Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF183C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487B72154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="wBRSzQBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487B72154D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeHBWn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:43:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46942 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbeHBWn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:43:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so3059929ljj.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fkdwr2evrSJglSAPSVfeflKs6pLfnTQBDxlgPCc4y4E=;
        b=wBRSzQBf1sXS6yyzxPxCv39vk3h7budIW6tzgymkFhpQGlrVEm8P02Ho2tsSDKSFcx
         P8Ywmpk7jksjZNV/5iV7+IYQvzjvsBiKp4sLX22rXDiow+yX8OBMm6iGRAf7Yza0FrIO
         QFcxc2MbRSBdDdOXSFG3hk/k2RxOncvN9fkw/SW/iTnwEim9vrphIrMGRAwr1o5mvZ/2
         IRRcwrLyxL8FuV3OC7UVfRj6jT5Plesaw9j6QHLuTppK+HYX/dVSJF1JEXf+Z/rYLxkh
         VYvmxctzo17kYdeuMI80mDc0IIGls4U28oyNV4sm/yB+nYr5zthUsw7L6NyvEquXkZTA
         opBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fkdwr2evrSJglSAPSVfeflKs6pLfnTQBDxlgPCc4y4E=;
        b=sV+wHR9g8FxOWdVVNxv1Uaxfl86VQlh3L7Psr9HVsEsP+1OZ6TO9Z0PiT9ff0Pzw/j
         SQGXdBrADkRlOx4UzlocWgaNjwNewbuz/qqZbUAvh/uit3Zdcv42oLZYD2VzcwCZIb2m
         GoOVLfN7TYgWjbAsu0dPib9JuqU5SYBnKJRvnA3jdpOV6qRkmjbr0W+EFrcwJISuv8gl
         m2i6BtjHFRtwYrUjDfIAeGhOVd2I2mtiGXq0xLpsSwKHmLxB/SDmNRzs4rdD5BWpsgDz
         jmcv3079JaKedKyq1v4D63GQvEk4/mmWJZaKaB04hL0KRnabJ3Bb5NxSyjzh6sNVm3kY
         BG6A==
X-Gm-Message-State: AOUpUlERwUlX8eGK3/iByYO232aU2H2wg8FHZ8QbT8akqsMUf8lUsQG4
        yN+EngEKO1WnTNvQtYxH89T9WQ==
X-Google-Smtp-Source: AAOMgpd3Y1m078njui2K4Nsa9O1qKiUtBUL2qm1Jc1ZTM1Tt8AU+bqZcJysKq+9lawZyrkHpUfukGw==
X-Received: by 2002:a2e:8807:: with SMTP id x7-v6mr3198480ljh.98.1533243037318;
        Thu, 02 Aug 2018 13:50:37 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id u10-v6sm560344ljk.83.2018.08.02.13.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 13:50:36 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: fix rqd.error return value in pblk_blk_erase_sync
Date:   Thu,  2 Aug 2018 22:50:23 +0200
Message-Id: <20180802205023.29094-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
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
---
 drivers/lightnvm/pblk-core.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 72acf2f6dbd6..814204d22a2e 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -886,10 +886,8 @@ static void pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 {
-	struct nvm_rq rqd;
-	int ret = 0;
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
+	struct nvm_rq rqd = {0};
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
2.11.0

