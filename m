Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843BEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADB120841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DPQ1RajV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADB120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbeGaVeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:34:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44687 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732539AbeGaVeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:34:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so6602988pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q7jGiY6bcjknel3f67YCdBy100vkB2E9u4fhQCP3suo=;
        b=DPQ1RajVjK4/NlRNn5tSUQrg/ESfpJ6VOgG6EOxtgSuy9EQeqdPkaEZ8E936/NJN8g
         uhJWOLRBzudVudKXGoXPVJU4yt4W21uWSH6J893lcGpHJrfSDcajTGpAH6bw/jXX1Fck
         g+jTfuPTfzlXSh3aDcXBbXs/owtwdg+QUyP70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q7jGiY6bcjknel3f67YCdBy100vkB2E9u4fhQCP3suo=;
        b=NHQ1WXwknOJ38/XJCrXv40k6KRs6WrW9ja8GRO9tCst8PVjT6kwTJx+GJI0Rw2Q3b2
         gFkQ1hna54BnMMuOOWuy75HmbzDEQW6bYVPaVA6iufmWFLCKBZ8A/1iMYAp6dlKRunqH
         XRuekVeYaWTCfLO6QY9HHDriVnWw/vncEHMmiPghmvUSgg9mdeIEqOgH36Wju6xUnQ0F
         pTA/ZDg+om6vJiIvWbnfBcwiLglLK7P3d6in6ChApDeuulbVyvdqaCN3tqUCBfH8+NxO
         awYTLN40DOzidY8runvUDPUWnoVX6RHgvltzJwwv80sFfsaG6e4xnQUlX8U6iS1sVYV/
         IV0g==
X-Gm-Message-State: AOUpUlH9HpDWLjc86srD7M1kjvupk398F7rLo34Q0ske8gL/pTR6mRDr
        i7BIzdTe6DqSUu34jLWpYm6NoA==
X-Google-Smtp-Source: AAOMgpd1W49IHWu8Xdm4kYVr99i5ZDoLZddE858jTmxXjOs5MwA1txFGid898+FLN6f7vXdMAu7xLw==
X-Received: by 2002:a63:ab4c:: with SMTP id k12-v6mr21381868pgp.386.1533066727678;
        Tue, 31 Jul 2018 12:52:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x15-v6sm23735181pgc.46.2018.07.31.12.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:52:02 -0700 (PDT)
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
Subject: [PATCH v2 2/9] scsi: cxlflash: Drop unused sense buffers
Date:   Tue, 31 Jul 2018 12:51:47 -0700
Message-Id: <20180731195155.46664-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731195155.46664-1-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the unused sense buffer in read_cap16() and write_same16().

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/superpipe.c | 8 ++------
 drivers/scsi/cxlflash/vlun.c      | 7 ++-----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index 2fe79df5c73c..59b9f2023748 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -324,7 +324,6 @@ static int read_cap16(struct scsi_device *sdev, struct llun_info *lli)
 	struct scsi_sense_hdr sshdr;
 	u8 *cmd_buf = NULL;
 	u8 *scsi_cmd = NULL;
-	u8 *sense_buf = NULL;
 	int rc = 0;
 	int result = 0;
 	int retry_cnt = 0;
@@ -333,8 +332,7 @@ static int read_cap16(struct scsi_device *sdev, struct llun_info *lli)
 retry:
 	cmd_buf = kzalloc(CMD_BUFSIZE, GFP_KERNEL);
 	scsi_cmd = kzalloc(MAX_COMMAND_SIZE, GFP_KERNEL);
-	sense_buf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
-	if (unlikely(!cmd_buf || !scsi_cmd || !sense_buf)) {
+	if (unlikely(!cmd_buf || !scsi_cmd)) {
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -349,7 +347,7 @@ static int read_cap16(struct scsi_device *sdev, struct llun_info *lli)
 	/* Drop the ioctl read semahpore across lengthy call */
 	up_read(&cfg->ioctl_rwsem);
 	result = scsi_execute(sdev, scsi_cmd, DMA_FROM_DEVICE, cmd_buf,
-			      CMD_BUFSIZE, sense_buf, &sshdr, to, CMD_RETRIES,
+			      CMD_BUFSIZE, NULL, &sshdr, to, CMD_RETRIES,
 			      0, 0, NULL);
 	down_read(&cfg->ioctl_rwsem);
 	rc = check_state(cfg);
@@ -380,7 +378,6 @@ static int read_cap16(struct scsi_device *sdev, struct llun_info *lli)
 					if (retry_cnt++ < 1) {
 						kfree(cmd_buf);
 						kfree(scsi_cmd);
-						kfree(sense_buf);
 						goto retry;
 					}
 				}
@@ -411,7 +408,6 @@ static int read_cap16(struct scsi_device *sdev, struct llun_info *lli)
 out:
 	kfree(cmd_buf);
 	kfree(scsi_cmd);
-	kfree(sense_buf);
 
 	dev_dbg(dev, "%s: maxlba=%lld blklen=%d rc=%d\n",
 		__func__, gli->max_lba, gli->blk_len, rc);
diff --git a/drivers/scsi/cxlflash/vlun.c b/drivers/scsi/cxlflash/vlun.c
index 5deef57a7834..e7e9b2f2ad21 100644
--- a/drivers/scsi/cxlflash/vlun.c
+++ b/drivers/scsi/cxlflash/vlun.c
@@ -425,7 +425,6 @@ static int write_same16(struct scsi_device *sdev,
 {
 	u8 *cmd_buf = NULL;
 	u8 *scsi_cmd = NULL;
-	u8 *sense_buf = NULL;
 	int rc = 0;
 	int result = 0;
 	u64 offset = lba;
@@ -439,8 +438,7 @@ static int write_same16(struct scsi_device *sdev,
 
 	cmd_buf = kzalloc(CMD_BUFSIZE, GFP_KERNEL);
 	scsi_cmd = kzalloc(MAX_COMMAND_SIZE, GFP_KERNEL);
-	sense_buf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
-	if (unlikely(!cmd_buf || !scsi_cmd || !sense_buf)) {
+	if (unlikely(!cmd_buf || !scsi_cmd)) {
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -456,7 +454,7 @@ static int write_same16(struct scsi_device *sdev,
 		/* Drop the ioctl read semahpore across lengthy call */
 		up_read(&cfg->ioctl_rwsem);
 		result = scsi_execute(sdev, scsi_cmd, DMA_TO_DEVICE, cmd_buf,
-				      CMD_BUFSIZE, sense_buf, NULL, to,
+				      CMD_BUFSIZE, NULL, NULL, to,
 				      CMD_RETRIES, 0, 0, NULL);
 		down_read(&cfg->ioctl_rwsem);
 		rc = check_state(cfg);
@@ -481,7 +479,6 @@ static int write_same16(struct scsi_device *sdev,
 out:
 	kfree(cmd_buf);
 	kfree(scsi_cmd);
-	kfree(sense_buf);
 	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
 	return rc;
 }
-- 
2.17.1

