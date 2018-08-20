Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9FBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C9E21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="tf/jAatw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C9E21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeHTQPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:15:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45436 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeHTQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:15:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id w16-v6so11512225ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KFEGRNXG6jGhkWzKu1wMnVtS4eIhncZB52VPNE7hPHg=;
        b=tf/jAatwx0m5FsSFqhR25+PUkX2t3PP4xtCcm38GRHmos+trPhjTyVkToDIPVjzYZF
         inDYJK7JkpzMXQPVLKrhfzCTRSIdXAHykcXG/JGA7l8d7df2exDdlU8C55lmZvCZBC5w
         fAnQ5/w4CHNMZez7wHIMi/F4EwpsUZDNNV3fIZSbOd/bZDh3spu6AQUb4zke4DUtEoMD
         +jDVUZmxAkcpXlHJVlMM2yLpyYxgm4YbL51d5WhQo8OmJ14kj0nsEjqmfGqFQRQloyea
         eFBcE3eDDawoJY1Sf2+lWAv/ChXsRHYllbQg1PgM2aDKPsZsQGJkipSSwOJgIeP1dhU7
         pDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KFEGRNXG6jGhkWzKu1wMnVtS4eIhncZB52VPNE7hPHg=;
        b=jsHzBYoAsJ88K/YsvIqeporEPyuqIDnuXWEJK1b9IjaFBGJyLmHVze3G4O+sflabW1
         VdPbi5smPzUsQC9+5Hs5cJnx9mZL2btkJDGT2tEPwqmIBLGlox00R3E1nbYTYbUVmQiZ
         R+cI9lGQ/NLNWGRY4m8vGO8QMCTwSVf4RVauQfWJUvsom1TKSQxyc7IdOJ/owtC12AnG
         kzoKkJEHrwMhxzAw4XIpiAxDc6Iz4ltdSQefw9bK03nOGSXPqVpU6PomId4sV2lXirlN
         886lsNSWF/KK3CZNT9HsNWMCEXlGodRip6c8rjvVnIvQNbR9QpJSsOFSFYOS/fxqk+1c
         h8Ww==
X-Gm-Message-State: AOUpUlHC0M7ivewMVhkQBAiPYt/dZjcW/vr+w1sc57is0C4EFDdoot/K
        LqkuY8siJ5M/tUF8Pa0QiqsctQ==
X-Google-Smtp-Source: AA+uWPyVjtqly7AyBK4P3cnDfGPpSxlNgF/OdxWymXe+vOr5Bh2pTMm2OTP88+o+ustfF6dJi3Kuqw==
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr30054946ljj.53.1534770001004;
        Mon, 20 Aug 2018 06:00:01 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id a14-v6sm1609051ljb.49.2018.08.20.05.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 05:59:59 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: remove size and out of bounds read check
Date:   Mon, 20 Aug 2018 14:59:53 +0200
Message-Id: <20180820125953.15364-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I/O size and capacity check are already done by the block layer.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f275c7e5abe4..d0fbd50ecc90 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -452,13 +452,6 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
 	int ret = NVM_IO_ERR;
 
-	/* logic error: lba out-of-bounds. Ignore read request */
-	if (blba >= pblk->rl.nr_secs || nr_secs > NVM_MAX_VLBA) {
-		WARN(1, "pblk: read lba out of bounds (lba:%llu, nr:%d)\n",
-					(unsigned long long)blba, nr_secs);
-		return NVM_IO_ERR;
-	}
-
 	generic_start_io_acct(q, READ, bio_sectors(bio), &pblk->disk->part0);
 
 	bitmap_zero(read_bitmap, nr_secs);
-- 
2.11.0

