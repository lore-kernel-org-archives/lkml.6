Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627C5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2378A20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2378A20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbeGaPnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:43:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49504 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeGaPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:43:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkVEI-0002tU-4L; Tue, 31 Jul 2018 14:02:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] xen/gntdev: don't dereference a null gntdev_dmabuf on allocation failure
Date:   Tue, 31 Jul 2018 15:02:25 +0100
Message-Id: <20180731140225.22717-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when the allocation of gntdev_dmabuf fails, the error exit
path will call dmabuf_imp_free_storage and causes a null pointer
dereference on gntdev_dmabuf.  Fix this by adding an error exit path
that won't free gntdev_dmabuf.

Detected by CoverityScan, CID#1472124 ("Dereference after null check")

Fixes: bf8dc55b1358 ("xen/gntdev: Implement dma-buf import functionality")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/xen/gntdev-dmabuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 744cfe9b0311..cba6b586bfbd 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -568,7 +568,7 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
 
 	gntdev_dmabuf = kzalloc(sizeof(*gntdev_dmabuf), GFP_KERNEL);
 	if (!gntdev_dmabuf)
-		goto fail;
+		goto fail_no_free;
 
 	gntdev_dmabuf->u.imp.refs = kcalloc(count,
 					    sizeof(gntdev_dmabuf->u.imp.refs[0]),
@@ -591,6 +591,7 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
 
 fail:
 	dmabuf_imp_free_storage(gntdev_dmabuf);
+fail_no_free:
 	return ERR_PTR(-ENOMEM);
 }
 
-- 
2.17.1

