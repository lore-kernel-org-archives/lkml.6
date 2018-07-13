Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6639AECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EDC2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="eiyq6Kxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EDC2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeGMJCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:02:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41340 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeGMJCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:02:51 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so11931181ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9TSJBTfCijmeX0Vh6R44kV63q3BgW0B4f7Uq7MIXjw=;
        b=eiyq6KxpJX5ZFUt33KY9eofKC0mdL+etO5IJXpYxpKO2YX2XqaIhtw3AT5rYa/k8vp
         WPYQweW0rVkPA/FjYBTxUiwBrSu11Q8yj4BIduGaWFuQZDWhoYNeb5o0KLEHii/G+Rwp
         TetS/sNdS7K3eTPfQVqLD4yNAudR2+46GD10EJ7NbPlNm6WQW7q3OyhtQsIPHnFeKXKg
         cZn3Z6lMYwqnKy4vebpHSSTi4fRbvGnMJ7VNFu+/AySiL+uKmlM1veCOs2uF25HLG05v
         d0cy9KMuVizbMDqVaFFgvt6OpjghH+HXTstv/jk94txo0RTeLAEFr5AWwGuvCDLCpl09
         WmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9TSJBTfCijmeX0Vh6R44kV63q3BgW0B4f7Uq7MIXjw=;
        b=sj7hks8Osp/U1b+bRhgfuL8CkBeKxUfx4a9HEG2c7VO3IAjBC6jzvPj/4sCtTQBOeI
         jRpHOXKP8jp+LFSvM7f6K1hnWU3OMp1sWTIvd2so0M2IMeU1+M0dKMb1SmUJWBapqjBN
         b5/yb9zHAiyWAoC4Bda+Cg/K6Nis0OpWot69ZQeGI/OM/mbKQdZbXkiQkHr9cg1evGd5
         LonUsklQWeGGrrK1hBWwTN9viKS/4y7qXbv/g02f4JUCIQt+YQx5tBK5v6GZWccJkM+M
         4z7oJBX0QMqCwn5YtGGK+u9mxLwSQRwdJcKu6aS5AASl1twl9ETIRkbB0rJUcv6845TF
         bioA==
X-Gm-Message-State: AOUpUlERzTVteg+J7qTpsYYpkM2Rt/+k1CS9AqnuXIxH80Mz7vJShPZz
        swyzAFeo2+9Qa6L+FJjasvQ8BQ==
X-Google-Smtp-Source: AAOMgpcr12f+Vx2HclJIUq6COSFomXdfzDKwLkuHa9GiKlJN3OV+QbNLfqLs2B5Ldbdr8hP/rPv4LA==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14-v6mr5460951plo.139.1531471752002;
        Fri, 13 Jul 2018 01:49:12 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id d18-v6sm569357pgo.74.2018.07.13.01.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 01:49:10 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 01/10] lightnvm: pblk: handle case when mw_cunits equals to 0
Date:   Fri, 13 Jul 2018 10:48:36 +0200
Message-Id: <20180713084845.19511-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>

Some devices can expose mw_cunits equal to 0, it can cause the
creation of too small write buffer and cause performance to drop
on write workloads.

Additionally, write buffer size must cover write data requirements,
such as WS_MIN and MW_CUNITS - it must be greater than or equal to
the larger one multiplied by the number of PUs. However, for
performance reasons, use the WS_OPT value to calculation instead of
WS_MIN.

Because the place where buffer size is calculated was changed, this
patch also removes pgs_in_buffer filed in pblk structure.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 9 +++++----
 drivers/lightnvm/pblk.h      | 3 ---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b57f764d6a16..ef8d8dea7b6b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -179,11 +179,14 @@ static int pblk_rwb_init(struct pblk *pblk)
 	struct pblk_rb_entry *entries;
 	unsigned long nr_entries, buffer_size;
 	unsigned int power_size, power_seg_sz;
+	int pgs_in_buffer;
 
-	if (write_buffer_size && (write_buffer_size > pblk->pgs_in_buffer))
+	pgs_in_buffer = max(geo->mw_cunits, geo->ws_opt) * geo->all_luns;
+
+	if (write_buffer_size && (write_buffer_size > pgs_in_buffer))
 		buffer_size = write_buffer_size;
 	else
-		buffer_size = pblk->pgs_in_buffer;
+		buffer_size = pgs_in_buffer;
 
 	nr_entries = pblk_rb_calculate_size(buffer_size);
 
@@ -366,8 +369,6 @@ static int pblk_core_init(struct pblk *pblk)
 	atomic64_set(&pblk->nr_flush, 0);
 	pblk->nr_flush_rst = 0;
 
-	pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
-
 	pblk->min_write_pgs = geo->ws_opt * (geo->csecs / PAGE_SIZE);
 	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
 	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 34cc1d64a9d4..9d1a0e86e082 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -608,9 +608,6 @@ struct pblk {
 
 	int min_write_pgs; /* Minimum amount of pages required by controller */
 	int max_write_pgs; /* Maximum amount of pages supported by controller */
-	int pgs_in_buffer; /* Number of pages that need to be held in buffer to
-			    * guarantee successful reads.
-			    */
 
 	sector_t capacity; /* Device capacity when bad blocks are subtracted */
 
-- 
2.11.0

