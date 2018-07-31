Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ECCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5B820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mboo4uKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5B820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbeGaVeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:34:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37953 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbeGaVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:34:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so9598067pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nqR6k1MB6wyRMVwrfWMrenBi6eb5HDL3f8RkW4PPP4Q=;
        b=mboo4uKK8mHUzXWzVnL44wPkHdoUh2DoObef4UPry7nWOk32vTLbVDfdEfPQicXW5H
         H9noud5bEa9RnJGkCaNJqAo1I/l6jd37xmZ5oG5LrJ0HTHUJSnQnmnSv3BsyFSqmvPaW
         d3pO7Q2XmNcB+Tiaue5PoVO5HaQGwY72qZ/3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nqR6k1MB6wyRMVwrfWMrenBi6eb5HDL3f8RkW4PPP4Q=;
        b=GuceYzH5add1fcySR9qdJ/j07p+rFDBm+7PMRU9ynMASQ4Bli55MBlMJ3qMse3ha2p
         /UATAfW5bB+QHU3ssSEsKQBJOPAXpwgiLLCpLkGXveG6QFTTf35lmo8uL8YjPQnbMBLC
         6o5ovWP7ctmhGT28K7jilJ21TRyf/i9yB+QVk+/r/mG2WEt/oitHjZCLvsAH6Cne0S6R
         lF2tV8Y6KgxYkR+7WnAQ/FJpofWdU/6LG1LspPzyo5KnUx0i5GNNyjJTQYM26O0ATQFd
         VMSD+5YZPvgpoSSthjMt6kCQKtQhKR6K+OWkM8+Y4VL6t2rnFl4miarNmYNLfc5eeV+j
         lwpA==
X-Gm-Message-State: AOUpUlGKgNWk0fX4AOnWJEEqiZ0zaGxY1H5u5++As0R68LG8hL8+vdNh
        48CQ4M9TMkmgLYmyRp9o4Nk0OA==
X-Google-Smtp-Source: AAOMgpe2Hm0zPeg7+mCCEeTxTxEqxKPcnz5q1+aikiX596hAQ1DmHZMGoe6S1eOhs0JXFWeVUKvFgQ==
X-Received: by 2002:a65:6343:: with SMTP id p3-v6mr21983982pgv.48.1533066731061;
        Tue, 31 Jul 2018 12:52:11 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s3-v6sm43338921pfg.2.2018.07.31.12.52.06
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
Subject: [PATCH v2 7/9] cdrom: Use struct scsi_sense_hdr internally
Date:   Tue, 31 Jul 2018 12:51:52 -0700
Message-Id: <20180731195155.46664-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731195155.46664-1-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes more casts of struct request_sense and uses the standard
struct scsi_sense_hdr instead. This also fixes any possible stale values
since the prior code did not check the sense length.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/Kconfig | 2 +-
 drivers/cdrom/cdrom.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index ad9b687a236a..d4913516823f 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -74,12 +74,12 @@ config AMIGA_Z2RAM
 
 config CDROM
 	tristate
+	select BLK_SCSI_REQUEST
 
 config GDROM
 	tristate "SEGA Dreamcast GD-ROM drive"
 	depends on SH_DREAMCAST
 	select CDROM
-	select BLK_SCSI_REQUEST # only for the generic cdrom code
 	help
 	  A standard SEGA Dreamcast comes with a modified CD ROM drive called a
 	  "GD-ROM" by SEGA to signify it is capable of reading special disks
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 3522d2cae1b6..e547213239dc 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -282,6 +282,7 @@
 #include <linux/blkdev.h>
 #include <linux/times.h>
 #include <linux/uaccess.h>
+#include <scsi/scsi_common.h>
 #include <scsi/scsi_request.h>
 
 /* used to tell the module to turn on full debugging messages */
@@ -2222,9 +2223,12 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 
 		blk_execute_rq(q, cdi->disk, rq, 0);
 		if (scsi_req(rq)->result) {
-			struct request_sense *s = req->sense;
+			struct scsi_sense_hdr sshdr;
+
 			ret = -EIO;
-			cdi->last_sense = s->sense_key;
+			scsi_normalize_sense(req->sense, req->sense_len,
+					     &sshdr);
+			cdi->last_sense = sshdr.sense_key;
 		}
 
 		if (blk_rq_unmap_user(bio))
-- 
2.17.1

