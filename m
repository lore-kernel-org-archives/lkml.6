Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00292C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A0C20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRHJG5+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A0C20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbeGaVeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:34:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46600 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732541AbeGaVeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:34:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so6599017pfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=24hZXZaYjkBN7Mhw98yp1L0z0cLuLy+pImRF9czCj3g=;
        b=LRHJG5+dUthNvaTssITiGXrhVq67Uc2hLz9U5lGiVKe7K4gvHKd+1tKsYIS0KkHeUh
         68+eP18my0QjNjWuFvA9fHkCPRm+0enDupu83c/IL60CZeGx2CTUUUFsh1TioStOG0QM
         Xn9AkZTZCCGhDr12kE+Hj7dbKw4VTnLG6aTYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=24hZXZaYjkBN7Mhw98yp1L0z0cLuLy+pImRF9czCj3g=;
        b=E0OFz73kvfOcbrPFRDtiBtpVxywiybWcKJ6JNth/hd54jLIwbUcyTE6UQ58cEz8St5
         lbSaNEMCNi5nEcJ9iP4MirdAvO8gXIixWn/XkFieVS6P97RmbnX+9tRR8Ur98jdAd+SO
         QRHp82zi8bP5kxtZz1An79TAUbzynaaQRqBdy9kHCzm3JvQmMz4CNq1O6a1TT5vni9yH
         6dcZLjIvweEjbM8toULieq9syqAZP9NbylSxXlD37SPYrbZN/K2gFU1wQmrKrvIwTbx5
         wNZh6an1g1x72YFyCA+Sm/mZuXKAsSkQGLWw07+U0DFXT34AZfhc/VuuOUs+KV/m9UHr
         LHoQ==
X-Gm-Message-State: AOUpUlFqNcyt6pvMmOstZLK7RL6Wr0aoqBnG36BQj2yC0ylx4uIdyDFT
        viIUe3ZprvJzmn/mBXzGUjeg4A==
X-Google-Smtp-Source: AAOMgpezb9ER0QUYjK7xUFVvBclCtPAfOWAzBWZVqTZPPa3akynnaF5z8OkGZt7iSnJPxC8IIA3azA==
X-Received: by 2002:a63:6d8b:: with SMTP id i133-v6mr22059745pgc.215.1533066729234;
        Tue, 31 Jul 2018 12:52:09 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y27-v6sm34108464pff.181.2018.07.31.12.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:52:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vinod.koul@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] ide-cd: Remove redundant sense buffer
Date:   Tue, 31 Jul 2018 12:51:51 -0700
Message-Id: <20180731195155.46664-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731195155.46664-1-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already able to process the sense buffer, so remove the redundant
parsing during the failure path. This also fixes any possible stale values
since the prior code did not check the sense length.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/ide/ide-cd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index cb90560acf6e..023a7d94eb08 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -423,6 +423,7 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		    req_flags_t rq_flags)
 {
 	struct cdrom_info *info = drive->driver_data;
+	struct scsi_sense_hdr local_sshdr;
 	int retries = 10;
 	bool failed;
 
@@ -430,6 +431,9 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 				  "rq_flags: 0x%x",
 				  cmd[0], write, timeout, rq_flags);
 
+	if (!sshdr)
+		sshdr = &local_sshdr;
+
 	/* start of retry loop */
 	do {
 		struct request *rq;
@@ -456,9 +460,8 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 
 		if (buffer)
 			*bufflen = scsi_req(rq)->resid_len;
-		if (sshdr)
-			scsi_normalize_sense(scsi_req(rq)->sense,
-					     scsi_req(rq)->sense_len, sshdr);
+		scsi_normalize_sense(scsi_req(rq)->sense,
+				     scsi_req(rq)->sense_len, sshdr);
 
 		/*
 		 * FIXME: we should probably abort/retry or something in case of
@@ -470,12 +473,10 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 			 * The request failed.  Retry if it was due to a unit
 			 * attention status (usually means media was changed).
 			 */
-			struct request_sense *reqbuf = scsi_req(rq)->sense;
-
-			if (reqbuf->sense_key == UNIT_ATTENTION)
+			if (sshdr->sense_key == UNIT_ATTENTION)
 				cdrom_saw_media_change(drive);
-			else if (reqbuf->sense_key == NOT_READY &&
-				 reqbuf->asc == 4 && reqbuf->ascq != 4) {
+			else if (sshdr->sense_key == NOT_READY &&
+				 sshdr->asc == 4 && sshdr->ascq != 4) {
 				/*
 				 * The drive is in the process of loading
 				 * a disk.  Retry, but wait a little to give
-- 
2.17.1

