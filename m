Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEE9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C29A20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB1P3ik/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfANEpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 23:45:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35425 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANEpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 23:45:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so21307226wrb.2;
        Sun, 13 Jan 2019 20:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bS+3knPi/OIQRhQCGfxtXtmCl62jsC21TbasUTSjDAE=;
        b=CB1P3ik/w+W9RSfIY34O0anezucj8ieSdKi7d+lEBk0q69utscCuTR3yJndL0Eq3D+
         Im/TOv83Up78PfYlLoYYRo11aUBkOz8ykfl8W2kDM6FJOmC84lAf0oSTHRjBVWYemFCk
         /4Qj48oEoxx14kbHQJnswmoGGASzdddIuqKRemzMC0qxj/sEP/arjpORCHZGq4RRSHzw
         fwIUVUy/kAPOd5zZ41Z6izZZqUMriKpCa93VVORnOPKvP3zaCjz5xct/Qr1wBNgznl8I
         r4QiywAgI8gJpnXfZrvgp7EYUCCfOp2CxB2BQL6tUKYUqxcp5rwhVwq6SGZwA/+sWybi
         29gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bS+3knPi/OIQRhQCGfxtXtmCl62jsC21TbasUTSjDAE=;
        b=KA60VUubgK03ENbWZ9Ay6l5OSTSRuA8qBJiVRYzCjwmG8WGMkLF1kdwfzwvDFNMy6H
         s0ZGorFJpTLWu0ClXBpp7TzdPUBm6fc1rs0BPiOa9Y5SSQvKR15Ysj7vre7PdmyxsxVu
         vmcRZXXTXisb5NuM5HlBVVTTYaJ3NPAS/ibOsULBbboRAx8ppbI8vQcRD9Pm3yQlQCrf
         xudskTSQ/8sQ9cvB2NF8HFLYADcaO4djBi5c8z9Dn5g7aXCg4ck1hruGXSyQ//YvNW0H
         x1XdBQBt7m6Y1KewhJ7wgh3to+4ZAuHUTNnT3DCEZUvDrrCxW2gyC2c+48RsDJRKrO4o
         R9+w==
X-Gm-Message-State: AJcUukf2Qi+6yPRxxjJccKpmlPM7XXRZDtll2h9Xt/cA9FgAViba9fp0
        xcJrzRITgP5OUj0NcrbNGdo=
X-Google-Smtp-Source: ALg8bN6OyB1crDjt0nagGunFHfTNf10vLZPbm1IH6stfvJJvbCaER3YpLGRti2u6bF0thZx49qziTA==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr21374928wrv.80.1547441101122;
        Sun, 13 Jan 2019 20:45:01 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 67sm114622955wra.37.2019.01.13.20.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 20:45:00 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Don Brace <don.brace@microsemi.com>,
        Brian King <brking@us.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v3] scsi/ata: Use unsigned int for cmd's type in ioctls in scsi_host_template
Date:   Sun, 13 Jan 2019 21:42:07 -0700
Message-Id: <20190114044206.6351-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181020050143.589-1-natechancellor@gmail.com>
References: <20181020050143.589-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns several times in the scsi subsystem (trimmed for brevity):

drivers/scsi/hpsa.c:6209:7: warning: overflow converting case value to
switch condition type (2147762695 to 18446744071562347015) [-Wswitch]
        case CCISS_GETBUSTYPES:
             ^
drivers/scsi/hpsa.c:6208:7: warning: overflow converting case value to
switch condition type (2147762694 to 18446744071562347014) [-Wswitch]
        case CCISS_GETHEARTBEAT:
             ^

The root cause is that the _IOC macro can generate really large numbers,
which don't find into type 'int', which is used for the cmd paremeter in
the ioctls in scsi_host_template. My research into how GCC and Clang are
handling this at a low level didn't prove fruitful. However, looking at
the rest of the kernel tree, all ioctls use an 'unsigned int' for the
cmd parameter, which will fit all of the _IOC values in the scsi/ata
subsystems.

Make that change because none of the ioctls expect to take a negative
value, it brings the ioctls inline with the reset of the kernel, and it
removes ambiguity, which is never good when dealing with compilers.

Link: https://github.com/ClangBuiltLinux/linux/issues/85
Link: https://github.com/ClangBuiltLinux/linux/issues/154
Link: https://github.com/ClangBuiltLinux/linux/issues/157
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v2 -> v3:

* Fix another -Wswitch warning from drivers/scsi/cxlflash/main.c, coming
  from decode_hioctl (uncovered via a powernv_defconfig build).

v1 -> v2:

* Fix build breakage in cxlflash driver from forgetting to update
  prototype (thanks to 0day for catching it).

I would appreciate some review so I could get this accepted...

 drivers/ata/libata-scsi.c             |  5 +++--
 drivers/scsi/aacraid/aachba.c         |  2 +-
 drivers/scsi/aacraid/aacraid.h        |  4 ++--
 drivers/scsi/aacraid/commctrl.c       |  2 +-
 drivers/scsi/aacraid/linit.c          |  6 ++++--
 drivers/scsi/cxlflash/common.h        |  3 ++-
 drivers/scsi/cxlflash/main.c          |  2 +-
 drivers/scsi/cxlflash/superpipe.c     | 12 +++++-------
 drivers/scsi/esas2r/esas2r.h          |  4 ++--
 drivers/scsi/esas2r/esas2r_ioctl.c    | 13 ++++++-------
 drivers/scsi/esas2r/esas2r_main.c     |  2 +-
 drivers/scsi/hpsa.c                   | 15 +++++++++------
 drivers/scsi/ipr.c                    |  3 ++-
 drivers/scsi/libsas/sas_scsi_host.c   |  2 +-
 drivers/scsi/scsi_debug.c             |  3 ++-
 drivers/scsi/smartpqi/smartpqi_init.c |  3 ++-
 include/linux/libata.h                |  5 +++--
 include/scsi/libsas.h                 |  3 ++-
 include/scsi/scsi_host.h              |  6 ++++--
 19 files changed, 53 insertions(+), 42 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3d4887d0e84a..6291f1dbf342 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -778,7 +778,7 @@ static int ata_ioc32(struct ata_port *ap)
 }
 
 int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
-		     int cmd, void __user *arg)
+		     unsigned int cmd, void __user *arg)
 {
 	unsigned long val;
 	int rc = -EINVAL;
@@ -829,7 +829,8 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
 }
 EXPORT_SYMBOL_GPL(ata_sas_scsi_ioctl);
 
-int ata_scsi_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg)
+int ata_scsi_ioctl(struct scsi_device *scsidev, unsigned int cmd,
+		   void __user *arg)
 {
 	return ata_sas_scsi_ioctl(ata_shost_to_port(scsidev->host),
 				scsidev, cmd, arg);
diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 75ab5ff6b78c..6085aa087a2f 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -3455,7 +3455,7 @@ static int delete_disk(struct aac_dev *dev, void __user *arg)
 	}
 }
 
-int aac_dev_ioctl(struct aac_dev *dev, int cmd, void __user *arg)
+int aac_dev_ioctl(struct aac_dev *dev, unsigned int cmd, void __user *arg)
 {
 	switch (cmd) {
 	case FSACTL_QUERY_DISK:
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 3291d1c16864..1df5171594b8 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -2706,12 +2706,12 @@ void aac_set_intx_mode(struct aac_dev *dev);
 int aac_get_config_status(struct aac_dev *dev, int commit_flag);
 int aac_get_containers(struct aac_dev *dev);
 int aac_scsi_cmd(struct scsi_cmnd *cmd);
-int aac_dev_ioctl(struct aac_dev *dev, int cmd, void __user *arg);
+int aac_dev_ioctl(struct aac_dev *dev, unsigned int cmd, void __user *arg);
 #ifndef shost_to_class
 #define shost_to_class(shost) &shost->shost_dev
 #endif
 ssize_t aac_get_serial_number(struct device *dev, char *buf);
-int aac_do_ioctl(struct aac_dev * dev, int cmd, void __user *arg);
+int aac_do_ioctl(struct aac_dev *dev, unsigned int cmd, void __user *arg);
 int aac_rx_init(struct aac_dev *dev);
 int aac_rkt_init(struct aac_dev *dev);
 int aac_nark_init(struct aac_dev *dev);
diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index e2899ff7913e..f0ff40332753 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -1060,7 +1060,7 @@ static int aac_send_reset_adapter(struct aac_dev *dev, void __user *arg)
 	return retval;
 }
 
-int aac_do_ioctl(struct aac_dev * dev, int cmd, void __user *arg)
+int aac_do_ioctl(struct aac_dev *dev, unsigned int cmd, void __user *arg)
 {
 	int status;
 
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 634ddb90e7aa..17bcad701cf0 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -616,7 +616,8 @@ static struct device_attribute *aac_dev_attrs[] = {
 	NULL,
 };
 
-static int aac_ioctl(struct scsi_device *sdev, int cmd, void __user * arg)
+static int aac_ioctl(struct scsi_device *sdev, unsigned int cmd,
+		     void __user *arg)
 {
 	struct aac_dev *dev = (struct aac_dev *)sdev->host->hostdata;
 	if (!capable(CAP_SYS_RAWIO))
@@ -1206,7 +1207,8 @@ static long aac_compat_do_ioctl(struct aac_dev *dev, unsigned cmd, unsigned long
 	return ret;
 }
 
-static int aac_compat_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
+static int aac_compat_ioctl(struct scsi_device *sdev, unsigned int cmd,
+			    void __user *arg)
 {
 	struct aac_dev *dev = (struct aac_dev *)sdev->host->hostdata;
 	if (!capable(CAP_SYS_RAWIO))
diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
index 8908a20065c8..4d90106fcb37 100644
--- a/drivers/scsi/cxlflash/common.h
+++ b/drivers/scsi/cxlflash/common.h
@@ -334,7 +334,8 @@ int cxlflash_afu_sync(struct afu *afu, ctx_hndl_t c, res_hndl_t r, u8 mode);
 void cxlflash_list_init(void);
 void cxlflash_term_global_luns(void);
 void cxlflash_free_errpage(void);
-int cxlflash_ioctl(struct scsi_device *sdev, int cmd, void __user *arg);
+int cxlflash_ioctl(struct scsi_device *sdev, unsigned int cmd,
+		   void __user *arg);
 void cxlflash_stop_term_user_contexts(struct cxlflash_cfg *cfg);
 int cxlflash_mark_contexts_error(struct cxlflash_cfg *cfg);
 void cxlflash_term_local_luns(struct cxlflash_cfg *cfg);
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index bfa13e3b191c..a0ea2dea7518 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3282,7 +3282,7 @@ static int cxlflash_chr_open(struct inode *inode, struct file *file)
  *
  * Return: A string identifying the decoded host ioctl.
  */
-static char *decode_hioctl(int cmd)
+static char *decode_hioctl(unsigned int cmd)
 {
 	switch (cmd) {
 	case HT_CXLFLASH_LUN_PROVISION:
diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index acac6152f50b..1a94a469051e 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -1924,7 +1924,7 @@ static int cxlflash_disk_verify(struct scsi_device *sdev,
  *
  * Return: A string identifying the decoded ioctl.
  */
-static char *decode_ioctl(int cmd)
+static char *decode_ioctl(unsigned int cmd)
 {
 	switch (cmd) {
 	case DK_CXLFLASH_ATTACH:
@@ -2051,7 +2051,7 @@ static int cxlflash_disk_direct_open(struct scsi_device *sdev, void *arg)
  *
  * Return: 0 on success, -errno on failure
  */
-static int ioctl_common(struct scsi_device *sdev, int cmd)
+static int ioctl_common(struct scsi_device *sdev, unsigned int cmd)
 {
 	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
 	struct device *dev = &cfg->dev->dev;
@@ -2096,7 +2096,7 @@ static int ioctl_common(struct scsi_device *sdev, int cmd)
  *
  * Return: 0 on success, -errno on failure
  */
-int cxlflash_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
+int cxlflash_ioctl(struct scsi_device *sdev, unsigned int cmd, void __user *arg)
 {
 	typedef int (*sioctl) (struct scsi_device *, void *);
 
@@ -2179,8 +2179,7 @@ int cxlflash_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
 	}
 
 	if (unlikely(copy_from_user(&buf, arg, size))) {
-		dev_err(dev, "%s: copy_from_user() fail "
-			"size=%lu cmd=%d (%s) arg=%p\n",
+		dev_err(dev, "%s: copy_from_user() fail size=%lu cmd=%u (%s) arg=%p\n",
 			__func__, size, cmd, decode_ioctl(cmd), arg);
 		rc = -EFAULT;
 		goto cxlflash_ioctl_exit;
@@ -2203,8 +2202,7 @@ int cxlflash_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
 	rc = do_ioctl(sdev, (void *)&buf);
 	if (likely(!rc))
 		if (unlikely(copy_to_user(arg, &buf, size))) {
-			dev_err(dev, "%s: copy_to_user() fail "
-				"size=%lu cmd=%d (%s) arg=%p\n",
+			dev_err(dev, "%s: copy_to_user() fail size=%lu cmd=%u (%s) arg=%p\n",
 				__func__, size, cmd, decode_ioctl(cmd), arg);
 			rc = -EFAULT;
 		}
diff --git a/drivers/scsi/esas2r/esas2r.h b/drivers/scsi/esas2r/esas2r.h
index 858c3b33db78..7f43b95f4e94 100644
--- a/drivers/scsi/esas2r/esas2r.h
+++ b/drivers/scsi/esas2r/esas2r.h
@@ -965,8 +965,8 @@ struct esas2r_adapter {
 const char *esas2r_info(struct Scsi_Host *);
 int esas2r_write_params(struct esas2r_adapter *a, struct esas2r_request *rq,
 			struct esas2r_sas_nvram *data);
-int esas2r_ioctl_handler(void *hostdata, int cmd, void __user *arg);
-int esas2r_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
+int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg);
+int esas2r_ioctl(struct scsi_device *dev, unsigned int cmd, void __user *arg);
 u8 handle_hba_ioctl(struct esas2r_adapter *a,
 		    struct atto_ioctl *ioctl_hba);
 int esas2r_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd);
diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index 34bcc8c04ff4..916b9adf4921 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -1274,7 +1274,7 @@ int esas2r_write_params(struct esas2r_adapter *a, struct esas2r_request *rq,
 
 
 /* This function only cares about ATTO-specific ioctls (atto_express_ioctl) */
-int esas2r_ioctl_handler(void *hostdata, int cmd, void __user *arg)
+int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
 {
 	struct atto_express_ioctl *ioctl = NULL;
 	struct esas2r_adapter *a;
@@ -1292,7 +1292,7 @@ int esas2r_ioctl_handler(void *hostdata, int cmd, void __user *arg)
 	ioctl = memdup_user(arg, sizeof(struct atto_express_ioctl));
 	if (IS_ERR(ioctl)) {
 		esas2r_log(ESAS2R_LOG_WARN,
-			   "ioctl_handler access_ok failed for cmd %d, "
+			   "ioctl_handler access_ok failed for cmd %u, "
 			   "address %p", cmd,
 			   arg);
 		return PTR_ERR(ioctl);
@@ -1493,7 +1493,7 @@ int esas2r_ioctl_handler(void *hostdata, int cmd, void __user *arg)
 ioctl_done:
 
 	if (err < 0) {
-		esas2r_log(ESAS2R_LOG_WARN, "err %d on ioctl cmd %d", err,
+		esas2r_log(ESAS2R_LOG_WARN, "err %d on ioctl cmd %u", err,
 			   cmd);
 
 		switch (err) {
@@ -1518,9 +1518,8 @@ int esas2r_ioctl_handler(void *hostdata, int cmd, void __user *arg)
 	err = __copy_to_user(arg, ioctl, sizeof(struct atto_express_ioctl));
 	if (err != 0) {
 		esas2r_log(ESAS2R_LOG_WARN,
-			   "ioctl_handler copy_to_user didn't copy "
-			   "everything (err %d, cmd %d)", err,
-			   cmd);
+			   "ioctl_handler copy_to_user didn't copy everything (err %d, cmd %u)",
+			   err, cmd);
 		kfree(ioctl);
 
 		return -EFAULT;
@@ -1531,7 +1530,7 @@ int esas2r_ioctl_handler(void *hostdata, int cmd, void __user *arg)
 	return 0;
 }
 
-int esas2r_ioctl(struct scsi_device *sd, int cmd, void __user *arg)
+int esas2r_ioctl(struct scsi_device *sd, unsigned int cmd, void __user *arg)
 {
 	return esas2r_ioctl_handler(sd->host->hostdata, cmd, arg);
 }
diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index 64397d441bae..fdbda5c05aa0 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -623,7 +623,7 @@ static int esas2r_proc_major;
 long esas2r_proc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 {
 	return esas2r_ioctl_handler(esas2r_proc_host->hostdata,
-				    (int)cmd, (void __user *)arg);
+				    cmd, (void __user *)arg);
 }
 
 static void __exit esas2r_exit(void)
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index ff67ef5d5347..28cfd3d01c5a 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -251,10 +251,11 @@ static int number_of_controllers;
 
 static irqreturn_t do_hpsa_intr_intx(int irq, void *dev_id);
 static irqreturn_t do_hpsa_intr_msi(int irq, void *dev_id);
-static int hpsa_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
+static int hpsa_ioctl(struct scsi_device *dev, unsigned int cmd,
+		      void __user *arg);
 
 #ifdef CONFIG_COMPAT
-static int hpsa_compat_ioctl(struct scsi_device *dev, int cmd,
+static int hpsa_compat_ioctl(struct scsi_device *dev, unsigned int cmd,
 	void __user *arg);
 #endif
 
@@ -6127,7 +6128,7 @@ static void cmd_free(struct ctlr_info *h, struct CommandList *c)
 
 #ifdef CONFIG_COMPAT
 
-static int hpsa_ioctl32_passthru(struct scsi_device *dev, int cmd,
+static int hpsa_ioctl32_passthru(struct scsi_device *dev, unsigned int cmd,
 	void __user *arg)
 {
 	IOCTL32_Command_struct __user *arg32 =
@@ -6164,7 +6165,7 @@ static int hpsa_ioctl32_passthru(struct scsi_device *dev, int cmd,
 }
 
 static int hpsa_ioctl32_big_passthru(struct scsi_device *dev,
-	int cmd, void __user *arg)
+	unsigned int cmd, void __user *arg)
 {
 	BIG_IOCTL32_Command_struct __user *arg32 =
 	    (BIG_IOCTL32_Command_struct __user *) arg;
@@ -6201,7 +6202,8 @@ static int hpsa_ioctl32_big_passthru(struct scsi_device *dev,
 	return err;
 }
 
-static int hpsa_compat_ioctl(struct scsi_device *dev, int cmd, void __user *arg)
+static int hpsa_compat_ioctl(struct scsi_device *dev, unsigned int cmd,
+			     void __user *arg)
 {
 	switch (cmd) {
 	case CCISS_GETPCIINFO:
@@ -6521,7 +6523,8 @@ static void check_ioctl_unit_attention(struct ctlr_info *h,
 /*
  * ioctl
  */
-static int hpsa_ioctl(struct scsi_device *dev, int cmd, void __user *arg)
+static int hpsa_ioctl(struct scsi_device *dev, unsigned int cmd,
+		      void __user *arg)
 {
 	struct ctlr_info *h;
 	void __user *argp = (void __user *)arg;
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index d1b4025a4503..6d053e220153 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6696,7 +6696,8 @@ static int ipr_queuecommand(struct Scsi_Host *shost,
  * Return value:
  * 	0 on success / other on failure
  **/
-static int ipr_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
+static int ipr_ioctl(struct scsi_device *sdev, unsigned int cmd,
+		     void __user *arg)
 {
 	struct ipr_resource_entry *res;
 
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index c43a00a9d819..b775445892af 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -799,7 +799,7 @@ void sas_scsi_recover_host(struct Scsi_Host *shost)
 		  shost->host_failed, tries);
 }
 
-int sas_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
+int sas_ioctl(struct scsi_device *sdev, unsigned int cmd, void __user *arg)
 {
 	struct domain_device *dev = sdev_to_domain_dev(sdev);
 
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 661512bec3ac..e0f949b7d947 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -836,7 +836,8 @@ static void mk_sense_invalid_opcode(struct scsi_cmnd *scp)
 	mk_sense_buffer(scp, ILLEGAL_REQUEST, INVALID_OPCODE, 0);
 }
 
-static int scsi_debug_ioctl(struct scsi_device *dev, int cmd, void __user *arg)
+static int scsi_debug_ioctl(struct scsi_device *dev, unsigned int cmd,
+			    void __user *arg)
 {
 	if (sdebug_verbose) {
 		if (0x1261 == cmd)
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 40f58238ce4a..8baaf35da935 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6043,7 +6043,8 @@ static int pqi_passthru_ioctl(struct pqi_ctrl_info *ctrl_info, void __user *arg)
 	return rc;
 }
 
-static int pqi_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
+static int pqi_ioctl(struct scsi_device *sdev, unsigned int cmd,
+		     void __user *arg)
 {
 	int rc;
 	struct pqi_ctrl_info *ctrl_info;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 68133842e6d7..c9419c05a90a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1122,10 +1122,11 @@ extern int ata_host_activate(struct ata_host *host, int irq,
 extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *, struct ata_port_operations *);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
-extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
+extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
+			  void __user *arg);
 extern int ata_scsi_queuecmd(struct Scsi_Host *h, struct scsi_cmnd *cmd);
 extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
-			    int cmd, void __user *arg);
+			    unsigned int cmd, void __user *arg);
 extern void ata_sas_port_destroy(struct ata_port *);
 extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
 					   struct ata_port_info *, struct Scsi_Host *);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 3de3b10da19a..70461264d6e7 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -709,7 +709,8 @@ int sas_eh_target_reset_handler(struct scsi_cmnd *cmd);
 
 extern void sas_target_destroy(struct scsi_target *);
 extern int sas_slave_alloc(struct scsi_device *);
-extern int sas_ioctl(struct scsi_device *sdev, int cmd, void __user *arg);
+extern int sas_ioctl(struct scsi_device *sdev, unsigned int cmd,
+		     void __user *arg);
 extern int sas_drain_work(struct sas_ha_struct *ha);
 
 extern void sas_ssp_task_response(struct device *dev, struct sas_task *task,
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 6ca954e9f752..4047d68d1b08 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -60,7 +60,8 @@ struct scsi_host_template {
 	 *
 	 * Status: OPTIONAL
 	 */
-	int (* ioctl)(struct scsi_device *dev, int cmd, void __user *arg);
+	int (*ioctl)(struct scsi_device *dev, unsigned int cmd,
+		     void __user *arg);
 
 
 #ifdef CONFIG_COMPAT
@@ -70,7 +71,8 @@ struct scsi_host_template {
 	 *
 	 * Status: OPTIONAL
 	 */
-	int (* compat_ioctl)(struct scsi_device *dev, int cmd, void __user *arg);
+	int (*compat_ioctl)(struct scsi_device *dev, unsigned int cmd,
+			    void __user *arg);
 #endif
 
 	/*
-- 
2.20.1

