Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3095FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCD420841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cit+LAf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCD420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbeGaVeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:34:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42420 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732556AbeGaVeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:34:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so6605304pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BDfKI6awLThB24p2Q6R3Fe6OMkgYvDzj00pebpvR4as=;
        b=Cit+LAf7T7XkvnyANuIoiBjF9q1tjsLa6AtTpZ7XVesA8Jn++uBPLSWtEpE4I/xLi/
         TCUGbtU1z+qwgfAGeYJIrkHbgXkZQ9OakNvLWMRcwq9uv7GyXs9qR6b0g8CTWty+o7K3
         sKHVp1Hx1rOWAwRNsOSEI7j13Zqw8a/aEpsBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BDfKI6awLThB24p2Q6R3Fe6OMkgYvDzj00pebpvR4as=;
        b=MskrDUBe4OylsaAmTeKFNfmsuVCIXE3y/PmB+stMHkXKmErClKhX1bWlVMz9WcZjRa
         NAl8w1Jl50J8GvyrV6dkOHqsR7uGFPdm8xvULeEF5a3LL/bCDc68NrlcUm8aXJA7F0zT
         AbO08pT2B+v8zDPf7od3p7ZCz7HJxSKs/5W3d6Aiwa8Jqef+/EsS6JDkB5VkA9PxPrwK
         eIUM+72OoQZBtoh/Gejrg90kY6zL6fBea91CE4CaLJOdOAoZYCcSwvxA/3qq4HPeTx7d
         bV6RHYPqtEsGk4fSsenyhFAz+2v/Jsg11iFMkjj/r1H4UL/w+OlHGocUBX3kggAGPFZe
         LFfw==
X-Gm-Message-State: AOUpUlEDeRHBiSW3ySGCQaMhp1tK+BwaPsemxyzQz1RNvwGWNYF7fm0S
        mTzWAzdfIQ9F3YZUciOQA+L0yw==
X-Google-Smtp-Source: AAOMgpe2zhSpA3DJdgGE7RghbpvSpIBCKJKihNhsZaiZF9Fwuqmx0TuQVBmAIM3apMrT1N0dxHLLYg==
X-Received: by 2002:a63:b02:: with SMTP id 2-v6mr21042647pgl.301.1533066732186;
        Tue, 31 Jul 2018 12:52:12 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k64-v6sm20423196pgd.47.2018.07.31.12.52.07
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
Subject: [PATCH v2 9/9] scsi: Check sense buffer size at build time
Date:   Tue, 31 Jul 2018 12:51:54 -0700
Message-Id: <20180731195155.46664-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731195155.46664-1-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid introducing problems like those fixed in commit f7068114d45e
("sr: pass down correctly sized SCSI sense buffer"), this creates a macro
wrapper for scsi_execute() that verifies the size of the sense buffer
similar to what was done for command string sizes in commit 3756f6401c30
("exec: avoid gcc-8 warning for get_task_comm").

Another solution could be to add a length argument to scsi_execute(),
but this function already takes a lot of arguments and Jens was not fond
of that approach.

Additionally, this moves the SCSI_SENSE_BUFFERSIZE definition into
scsi_device.h, and removes a redundant include for scsi_device.h from
scsi_cmnd.h.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/scsi_lib.c    |  6 +++---
 include/scsi/scsi_cmnd.h   |  6 ++----
 include/scsi/scsi_device.h | 14 +++++++++++++-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e9b4f279d29c..718c2bec4516 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -238,7 +238,7 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
 
 
 /**
- * scsi_execute - insert request and wait for the result
+ * __scsi_execute - insert request and wait for the result
  * @sdev:	scsi device
  * @cmd:	scsi command
  * @data_direction: data direction
@@ -255,7 +255,7 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
  * Returns the scsi_cmnd result field if a command was executed, or a negative
  * Linux error code if we didn't get that far.
  */
-int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
+int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 		 int data_direction, void *buffer, unsigned bufflen,
 		 unsigned char *sense, struct scsi_sense_hdr *sshdr,
 		 int timeout, int retries, u64 flags, req_flags_t rq_flags,
@@ -309,7 +309,7 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 
 	return ret;
 }
-EXPORT_SYMBOL(scsi_execute);
+EXPORT_SYMBOL(__scsi_execute);
 
 /*
  * Function:    scsi_init_cmd_errh()
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index aaf1e971c6a3..7bf043a66e10 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -14,8 +14,6 @@
 struct Scsi_Host;
 struct scsi_driver;
 
-#include <scsi/scsi_device.h>
-
 /*
  * MAX_COMMAND_SIZE is:
  * The longest fixed-length SCSI CDB as per the SCSI standard.
@@ -120,11 +118,11 @@ struct scsi_cmnd {
 	struct request *request;	/* The command we are
 				   	   working on */
 
-#define SCSI_SENSE_BUFFERSIZE 	96
 	unsigned char *sense_buffer;
 				/* obtained by REQUEST SENSE when
 				 * CHECK CONDITION is received on original
-				 * command (auto-sense) */
+				 * command (auto-sense). Length must be
+				 * SCSI_SENSE_BUFFERSIZE bytes. */
 
 	/* Low-level done function - can be used by low-level driver to point
 	 *        to completion function.  Not used by mid/upper level code. */
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 7ae177c8e399..96b626ad5fb1 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -17,6 +17,8 @@ struct scsi_sense_hdr;
 
 typedef unsigned int __bitwise blist_flags_t;
 
+#define SCSI_SENSE_BUFFERSIZE	96
+
 struct scsi_mode_data {
 	__u32	length;
 	__u16	block_descriptor_length;
@@ -426,11 +428,21 @@ extern const char *scsi_device_state_name(enum scsi_device_state);
 extern int scsi_is_sdev_device(const struct device *);
 extern int scsi_is_target_device(const struct device *);
 extern void scsi_sanitize_inquiry_string(unsigned char *s, int len);
-extern int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
+extern int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 			int data_direction, void *buffer, unsigned bufflen,
 			unsigned char *sense, struct scsi_sense_hdr *sshdr,
 			int timeout, int retries, u64 flags,
 			req_flags_t rq_flags, int *resid);
+/* Make sure any sense buffer is the correct size. */
+#define scsi_execute(sdev, cmd, data_direction, buffer, bufflen, sense,	\
+		     sshdr, timeout, retries, flags, rq_flags, resid)	\
+({									\
+	BUILD_BUG_ON((sense) != NULL &&					\
+		     sizeof(sense) != SCSI_SENSE_BUFFERSIZE);		\
+	__scsi_execute(sdev, cmd, data_direction, buffer, bufflen,	\
+		       sense, sshdr, timeout, retries, flags, rq_flags,	\
+		       resid);						\
+})
 static inline int scsi_execute_req(struct scsi_device *sdev,
 	const unsigned char *cmd, int data_direction, void *buffer,
 	unsigned bufflen, struct scsi_sense_hdr *sshdr, int timeout,
-- 
2.17.1

