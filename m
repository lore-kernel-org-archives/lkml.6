Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E14FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0DF2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0DF2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbeIREhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeIREhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:52 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 408D8707;
        Mon, 17 Sep 2018 23:08:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.18 033/158] memory: ti-aemif: fix a potential NULL-pointer dereference
Date:   Tue, 18 Sep 2018 00:41:03 +0200
Message-Id: <20180917211712.551670260@linuxfoundation.org>
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

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit 6b45a2b1c0bc2aec84d1c56a1976ca9c8a621ecb upstream.

Platform data pointer may be NULL. We check it everywhere but in one
place. Fix it.

Fixes: 8af70cd2ca50 ("memory: aemif: add support for board files")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: stable@vger.kernel.org
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/memory/ti-aemif.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -411,7 +411,7 @@ static int aemif_probe(struct platform_d
 			if (ret < 0)
 				goto error;
 		}
-	} else {
+	} else if (pdata) {
 		for (i = 0; i < pdata->num_sub_devices; i++) {
 			pdata->sub_devices[i].dev.parent = dev;
 			ret = platform_device_register(&pdata->sub_devices[i]);


