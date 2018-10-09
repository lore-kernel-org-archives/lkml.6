Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AABC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A3C214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="TkCwfIhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A3C214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJIS3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:29:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33677 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeJIS3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:29:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so687243pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbpLUYkovpvd4K56ZaJIN/SCdn/2o6uCz0wZ+7EaWrI=;
        b=TkCwfIhTNdE5hP9eFab3BYYrfns5XOa3FKMzZ72TolpTWbX5rSrWzJ0e4CoXlDa8EU
         17z4VF2+TMJaLkvQQIShmEj2eFr5NDDNxrz8r1+scqoxurlx7AOSLWASfIfe+mt6xZ/8
         7sARzuqLmuxd8iBzkZBbdyqG2psszilF/m1gFiAcCDgRUc/xF0/CJ+yaAmXxMESY8tSP
         pVnn2zU9pZIlwo7GN+sD6FGmAkxqZ07yCOeyATJPnOiqYUbcPTejAiy0Ai/OWgSDRTUz
         VUu+t/JfuYC0o53dEN/BMsInHs0ZtjgqLAbIaDbYmpoI7IA66LZBdgTIdbUndCm2xham
         yojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbpLUYkovpvd4K56ZaJIN/SCdn/2o6uCz0wZ+7EaWrI=;
        b=CHoU1ap2n5Rz+WospIsuIjq7M7A64HpbVF1A3IFT4Mhct3KgZX6heyvEuqOqvoiA5M
         maXyp/bL6LqA2d44E9ENVnE37LJuOd3PrTj+zBwyxOWOY2YmgrR/WfEv8vlUUhMutcfE
         cs8GUxIU7QrypLI5mZUJnppdc8PeZQDg6We1cEvhbo5IVWTTMfzOpNxs9JscyywqkSRl
         EkYGQt6AwSQDV1/ccOzWFb4yrSnUXaIhnjT1MHO3r/qvWijClSxyKmzFinD1jdH71bhP
         O6WsIvT7bfZ+Nh+8bS+BUGJBceABAr8RhiiJCO0Zhn4mG+I8sQIT7d6M9qUcTUqu9ZTD
         WjcA==
X-Gm-Message-State: ABuFfoj/9Xj8UisV9EiHGdP8IVrWGQzZdvFudJuYgKrpHndYLF23kON3
        srUuFiQcUpdf8QWurGoG5YtE2Q==
X-Google-Smtp-Source: ACcGV63F8lTwMJE0YpPel90xK3SESQCu3eVSTwNWTWyxog5PMUYT/57MffrfHKEhxh71UIQi1wNC7A==
X-Received: by 2002:a63:f5a:: with SMTP id 26-v6mr25058334pgp.100.1539083604193;
        Tue, 09 Oct 2018 04:13:24 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:22 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 03/45] lightnvm: pblk: fix rqd.error return value in pblk_blk_erase_sync
Date:   Tue,  9 Oct 2018 13:11:33 +0200
Message-Id: <20181009111215.7653-4-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rqd.error is masked by the return value of pblk_submit_io_sync.
The rqd structure is then passed on to the end_io function, which
assumes that any error should lead to a chunk being marked
offline/bad. Since the pblk_submit_io_sync can fail before the
command is issued to the device, the error value maybe not correspond
to a media failure, leading to chunks being immaturely retired.

Also, the pblk_blk_erase_sync function prints an error message in case
the erase fails. Since the caller prints an error message by itself,
remove the error message in this function.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 72acf2f6dbd6..72de7456845b 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -886,10 +886,8 @@ static void pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 {
-	struct nvm_rq rqd;
-	int ret = 0;
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
+	struct nvm_rq rqd = {NULL};
+	int ret;
 
 	pblk_setup_e_rq(pblk, &rqd, ppa);
 
@@ -897,19 +895,6 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 	 * with writes. Thus, there is no need to take the LUN semaphore.
 	 */
 	ret = pblk_submit_io_sync(pblk, &rqd);
-	if (ret) {
-		struct nvm_tgt_dev *dev = pblk->dev;
-		struct nvm_geo *geo = &dev->geo;
-
-		pblk_err(pblk, "could not sync erase line:%d,blk:%d\n",
-					pblk_ppa_to_line(ppa),
-					pblk_ppa_to_pos(geo, ppa));
-
-		rqd.error = ret;
-		goto out;
-	}
-
-out:
 	rqd.private = pblk;
 	__pblk_end_io_erase(pblk, &rqd);
 
-- 
2.17.1

