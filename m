Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCDCECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D16F214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D16F214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeIREkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:40:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbeIREkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:40:42 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45597707;
        Mon, 17 Sep 2018 23:11:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 085/158] device-dax: avoid hang on error before devm_memremap_pages()
Date:   Tue, 18 Sep 2018 00:41:55 +0200
Message-Id: <20180917211715.132439137@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Hajnoczi <stefanha@redhat.com>

[ Upstream commit b7751410c180a05fdc21268f8661b1480169b0df ]

dax_pmem_percpu_exit() waits for dax_pmem_percpu_release() to invoke the
dax_pmem->cmp completion.  Unfortunately this approach to cleaning up
the percpu_ref only works after devm_memremap_pages() was successful.

If devm_add_action_or_reset() or devm_memremap_pages() fails,
dax_pmem_percpu_release() is not invoked.  Therefore
dax_pmem_percpu_exit() hangs waiting for the completion:

  rc = devm_add_action_or_reset(dev, dax_pmem_percpu_exit,
  				&dax_pmem->ref);
  if (rc)
  	return rc;

  dax_pmem->pgmap.ref = &dax_pmem->ref;
  addr = devm_memremap_pages(dev, &dax_pmem->pgmap);

Avoid the hang by calling percpu_ref_exit() in the error paths instead
of going through dax_pmem_percpu_exit().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dax/pmem.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -105,15 +105,19 @@ static int dax_pmem_probe(struct device
 	if (rc)
 		return rc;
 
-	rc = devm_add_action_or_reset(dev, dax_pmem_percpu_exit,
-							&dax_pmem->ref);
-	if (rc)
+	rc = devm_add_action(dev, dax_pmem_percpu_exit, &dax_pmem->ref);
+	if (rc) {
+		percpu_ref_exit(&dax_pmem->ref);
 		return rc;
+	}
 
 	dax_pmem->pgmap.ref = &dax_pmem->ref;
 	addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
-	if (IS_ERR(addr))
+	if (IS_ERR(addr)) {
+		devm_remove_action(dev, dax_pmem_percpu_exit, &dax_pmem->ref);
+		percpu_ref_exit(&dax_pmem->ref);
 		return PTR_ERR(addr);
+	}
 
 	rc = devm_add_action_or_reset(dev, dax_pmem_percpu_kill,
 							&dax_pmem->ref);


