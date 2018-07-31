Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85FEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369C220857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O77nB2Dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369C220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbeGaVeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:34:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43845 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbeGaVeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:34:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so6597685pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Dt6JDFVe5hjLBZUJaOIV8H2j2Ot6YIwsfUjbTkGqk0=;
        b=O77nB2DjII7fKfhJurQ7rBoSxeGplYKbPPSAeqglEgNEz/FyvpWCHrwdDtO7Uap8Ir
         CuC9zMvHpc3kFeSI0YEC7eN5dkeRnhEMGs8Oi2XKMZJZtF70OngeRYMgUstJfsbNw/i4
         Qxpo8Nn/hD+6KpexfiTNmfo8NF/XLyR3j6VfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Dt6JDFVe5hjLBZUJaOIV8H2j2Ot6YIwsfUjbTkGqk0=;
        b=Cx/59j7T4dh5HgNCTWfAt5QkUabL6gtVaqcaabQQ4c3ipnD7mBj5eNMlHsBxyfxnvn
         Kf04/FCN6/BsyMIfJ75zqybhgeOPbErG75QK53g8FJTEU4V6JqYRJgtnFMqLUkdfQ9Xl
         KpkQYxbxRe3L/weR8ClHMewHe+/kLrp6ek4GfspOt7IIueZgc3qXEesNA1jy/u2ifYNw
         Uuq3tXDNJnQKSYfBi2ohvcxcWkgZPBmV45/QMJTXdeARlA0m0M3UMSXB/lPsEiWNiRBf
         Ma+ULxRZZ88iqXu6jR9HS6VqnYDQqCif1NGhwxQjHLOZRETcVVdNwZh5bapAYwHF1b8T
         JDRA==
X-Gm-Message-State: AOUpUlHku54dlZg/FKQYKBOVywUwCJUqBe0PZPNB2aXtoSbxZC+YK5vL
        W4lER/O1BTYmGe8eA1og3MJj2g==
X-Google-Smtp-Source: AAOMgpd5p+t9tW+y61XOyv2SN/xo+vVR1ew4tiTU1pwhySI1OUE5sWGh5wRJpfCJxhKJlm01kyBkuw==
X-Received: by 2002:a63:7c18:: with SMTP id x24-v6mr21998927pgc.311.1533066733106;
        Tue, 31 Jul 2018 12:52:13 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c68-v6sm30299352pfj.51.2018.07.31.12.52.05
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
Subject: [PATCH v2 5/9] block: Switch struct packet_command to use struct scsi_sense_hdr
Date:   Tue, 31 Jul 2018 12:51:50 -0700
Message-Id: <20180731195155.46664-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731195155.46664-1-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lot of needless struct request_sense usage in the CDROM
code. These can all be struct scsi_sense_hdr instead, to avoid any
confusion over their respective structure sizes. This patch is a lot
of noise changing "sense" to "sshdr", but the final code is more
readable to distinguish between "sense" meaning "struct request_sense"
and "sshdr" meaning "struct scsi_sense_hdr".

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/pktcdvd.c    | 36 ++++++++++++++++++------------------
 drivers/cdrom/cdrom.c      | 22 +++++++++++-----------
 drivers/ide/ide-cd.c       | 11 ++++++-----
 drivers/ide/ide-cd.h       |  4 ++--
 drivers/ide/ide-cd_ioctl.c | 30 +++++++++++++++---------------
 drivers/scsi/sr_ioctl.c    | 22 +++++++++-------------
 include/linux/cdrom.h      |  3 ++-
 7 files changed, 63 insertions(+), 65 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index c61d20c9f3f8..f91c9f85e29d 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -748,13 +748,13 @@ static const char *sense_key_string(__u8 index)
 static void pkt_dump_sense(struct pktcdvd_device *pd,
 			   struct packet_command *cgc)
 {
-	struct request_sense *sense = cgc->sense;
+	struct scsi_sense_hdr *sshdr = cgc->sshdr;
 
-	if (sense)
+	if (sshdr)
 		pkt_err(pd, "%*ph - sense %02x.%02x.%02x (%s)\n",
 			CDROM_PACKET_SIZE, cgc->cmd,
-			sense->sense_key, sense->asc, sense->ascq,
-			sense_key_string(sense->sense_key));
+			sshdr->sense_key, sshdr->asc, sshdr->ascq,
+			sense_key_string(sshdr->sense_key));
 	else
 		pkt_err(pd, "%*ph - no sense\n", CDROM_PACKET_SIZE, cgc->cmd);
 }
@@ -787,11 +787,11 @@ static noinline_for_stack int pkt_set_speed(struct pktcdvd_device *pd,
 				unsigned write_speed, unsigned read_speed)
 {
 	struct packet_command cgc;
-	struct request_sense sense;
+	struct scsi_sense_hdr sshdr;
 	int ret;
 
 	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
-	cgc.sense = &sense;
+	cgc.sshdr = &sshdr;
 	cgc.cmd[0] = GPCMD_SET_SPEED;
 	cgc.cmd[2] = (read_speed >> 8) & 0xff;
 	cgc.cmd[3] = read_speed & 0xff;
@@ -1645,7 +1645,7 @@ static noinline_for_stack int pkt_get_last_written(struct pktcdvd_device *pd,
 static noinline_for_stack int pkt_set_write_settings(struct pktcdvd_device *pd)
 {
 	struct packet_command cgc;
-	struct request_sense sense;
+	struct scsi_sense_hdr sshdr;
 	write_param_page *wp;
 	char buffer[128];
 	int ret, size;
@@ -1656,7 +1656,7 @@ static noinline_for_stack int pkt_set_write_settings(struct pktcdvd_device *pd)
 
 	memset(buffer, 0, sizeof(buffer));
 	init_cdrom_command(&cgc, buffer, sizeof(*wp), CGC_DATA_READ);
-	cgc.sense = &sense;
+	cgc.sshdr = &sshdr;
 	if ((ret = pkt_mode_sense(pd, &cgc, GPMODE_WRITE_PARMS_PAGE, 0))) {
 		pkt_dump_sense(pd, &cgc);
 		return ret;
@@ -1671,7 +1671,7 @@ static noinline_for_stack int pkt_set_write_settings(struct pktcdvd_device *pd)
 	 * now get it all
 	 */
 	init_cdrom_command(&cgc, buffer, size, CGC_DATA_READ);
-	cgc.sense = &sense;
+	cgc.sshdr = &sshdr;
 	if ((ret = pkt_mode_sense(pd, &cgc, GPMODE_WRITE_PARMS_PAGE, 0))) {
 		pkt_dump_sense(pd, &cgc);
 		return ret;
@@ -1905,12 +1905,12 @@ static noinline_for_stack int pkt_write_caching(struct pktcdvd_device *pd,
 						int set)
 {
 	struct packet_command cgc;
-	struct request_sense sense;
+	struct scsi_sense_hdr sshdr;
 	unsigned char buf[64];
 	int ret;
 
 	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
-	cgc.sense = &sense;
+	cgc.sshdr = &sshdr;
 	cgc.buflen = pd->mode_offset + 12;
 
 	/*
@@ -1950,14 +1950,14 @@ static noinline_for_stack int pkt_get_max_speed(struct pktcdvd_device *pd,
 						unsigned *write_speed)
 {
 	struct packet_command cgc;
-	struct request_sense sense;
+	struct scsi_sense_hdr sshdr;
 	unsigned char buf[256+18];
 	unsigned char *cap_buf;
 	int ret, offset;
 
 	cap_buf = &buf[sizeof(struct mode_page_header) + pd->mode_offset];
 	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_UNKNOWN);
-	cgc.sense = &sense;
+	cgc.sshdr = &sshdr;
 
 	ret = pkt_mode_sense(pd, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
 	if (ret) {
@@ -2011,13 +2011,13 @@ static noinline_for_stack int pkt_media_speed(struct pktcdvd_device *pd,
 						unsigned *speed)
 {
 	struct packet_command cgc;
-	struct request_sense sense;
+	struct scsi_sense_hdr sshdr;
 	unsigned char buf[64];
 	unsigned int size, st, sp;
 	int ret;
 
 	init_cdrom_command(&cgc, buf, 2, CGC_DATA_READ);
-	cgc.sense = &sense;
+	cgc.sshdr = &sshdr;
 	cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
 	cgc.cmd[1] = 2;
 	cgc.cmd[2] = 4; /* READ ATIP */
@@ -2032,7 +2032,7 @@ static noinline_for_stack int pkt_media_speed(struct pktcdvd_device *pd,
 		size = sizeof(buf);
 
 	init_cdrom_command(&cgc, buf, size, CGC_DATA_READ);
-	cgc.sense = &sense;
+	cgc.sshdr = &sshdr;
 	cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
 	cgc.cmd[1] = 2;
 	cgc.cmd[2] = 4;
@@ -2083,13 +2083,13 @@ static noinline_for_stack int pkt_media_speed(struct pktcdvd_device *pd,
 static noinline_for_stack int pkt_perform_opc(struct pktcdvd_device *pd)
 {
 	struct packet_command cgc;
-	struct request_sense sense;
+	struct scsi_sense_hdr sshdr;
 	int ret;
 
 	pkt_dbg(2, pd, "Performing OPC\n");
 
 	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
-	cgc.sense = &sense;
+	cgc.sshdr = &sshdr;
 	cgc.timeout = 60*HZ;
 	cgc.cmd[0] = GPCMD_SEND_OPC;
 	cgc.cmd[1] = 1;
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index bfc566d3f31a..3522d2cae1b6 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -345,10 +345,10 @@ static LIST_HEAD(cdrom_list);
 int cdrom_dummy_generic_packet(struct cdrom_device_info *cdi,
 			       struct packet_command *cgc)
 {
-	if (cgc->sense) {
-		cgc->sense->sense_key = 0x05;
-		cgc->sense->asc = 0x20;
-		cgc->sense->ascq = 0x00;
+	if (cgc->sshdr) {
+		cgc->sshdr->sense_key = 0x05;
+		cgc->sshdr->asc = 0x20;
+		cgc->sshdr->ascq = 0x00;
 	}
 
 	cgc->stat = -EIO;
@@ -2943,7 +2943,7 @@ static noinline int mmc_ioctl_cdrom_read_data(struct cdrom_device_info *cdi,
 					      struct packet_command *cgc,
 					      int cmd)
 {
-	struct request_sense sense;
+	struct scsi_sense_hdr sshdr;
 	struct cdrom_msf msf;
 	int blocksize = 0, format = 0, lba;
 	int ret;
@@ -2971,13 +2971,13 @@ static noinline int mmc_ioctl_cdrom_read_data(struct cdrom_device_info *cdi,
 	if (cgc->buffer == NULL)
 		return -ENOMEM;
 
-	memset(&sense, 0, sizeof(sense));
-	cgc->sense = &sense;
+	memset(&sshdr, 0, sizeof(sshdr));
+	cgc->sshdr = &sshdr;
 	cgc->data_direction = CGC_DATA_READ;
 	ret = cdrom_read_block(cdi, cgc, lba, 1, format, blocksize);
-	if (ret && sense.sense_key == 0x05 &&
-	    sense.asc == 0x20 &&
-	    sense.ascq == 0x00) {
+	if (ret && sshdr.sense_key == 0x05 &&
+	    sshdr.asc == 0x20 &&
+	    sshdr.ascq == 0x00) {
 		/*
 		 * SCSI-II devices are not required to support
 		 * READ_CD, so let's try switching block size
@@ -2986,7 +2986,7 @@ static noinline int mmc_ioctl_cdrom_read_data(struct cdrom_device_info *cdi,
 		ret = cdrom_switch_blocksize(cdi, blocksize);
 		if (ret)
 			goto out;
-		cgc->sense = NULL;
+		cgc->sshdr = NULL;
 		ret = cdrom_read_cd(cdi, cgc, lba, blocksize, 1);
 		ret |= cdrom_switch_blocksize(cdi, blocksize);
 	}
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 1d5b35312e33..cb90560acf6e 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -419,7 +419,7 @@ static void ide_cd_request_sense_fixup(ide_drive_t *drive, struct ide_cmd *cmd)
 
 int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		    int write, void *buffer, unsigned *bufflen,
-		    struct request_sense *sense, int timeout,
+		    struct scsi_sense_hdr *sshdr, int timeout,
 		    req_flags_t rq_flags)
 {
 	struct cdrom_info *info = drive->driver_data;
@@ -456,8 +456,9 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 
 		if (buffer)
 			*bufflen = scsi_req(rq)->resid_len;
-		if (sense)
-			memcpy(sense, scsi_req(rq)->sense, sizeof(*sense));
+		if (sshdr)
+			scsi_normalize_sense(scsi_req(rq)->sense,
+					     scsi_req(rq)->sense_len, sshdr);
 
 		/*
 		 * FIXME: we should probably abort/retry or something in case of
@@ -864,7 +865,7 @@ static void msf_from_bcd(struct atapi_msf *msf)
 	msf->frame  = bcd2bin(msf->frame);
 }
 
-int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
+int cdrom_check_status(ide_drive_t *drive, struct scsi_sense_hdr *sshdr)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi;
@@ -886,7 +887,7 @@ int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
 	 */
 	cmd[7] = cdi->sanyo_slot % 3;
 
-	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, sense, 0, RQF_QUIET);
+	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, sshdr, 0, RQF_QUIET);
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index fc162fbb6629..a69dc7f61c4d 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -98,11 +98,11 @@ void ide_cd_log_error(const char *, struct request *, struct request_sense *);
 
 /* ide-cd.c functions used by ide-cd_ioctl.c */
 int ide_cd_queue_pc(ide_drive_t *, const unsigned char *, int, void *,
-		    unsigned *, struct request_sense *, int, req_flags_t);
+		    unsigned *, struct scsi_sense_hdr *, int, req_flags_t);
 int ide_cd_read_toc(ide_drive_t *);
 int ide_cdrom_get_capabilities(ide_drive_t *, u8 *);
 void ide_cdrom_update_speed(ide_drive_t *, u8 *);
-int cdrom_check_status(ide_drive_t *, struct request_sense *);
+int cdrom_check_status(ide_drive_t *, struct scsi_sense_hdr *);
 
 /* ide-cd_ioctl.c */
 int ide_cdrom_open_real(struct cdrom_device_info *, int);
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index c709f4eed0e9..c945beb9e75a 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -43,14 +43,14 @@ int ide_cdrom_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 {
 	ide_drive_t *drive = cdi->handle;
 	struct media_event_desc med;
-	struct request_sense sense;
+	struct scsi_sense_hdr sshdr;
 	int stat;
 
 	if (slot_nr != CDSL_CURRENT)
 		return -EINVAL;
 
-	stat = cdrom_check_status(drive, &sense);
-	if (!stat || sense.sense_key == UNIT_ATTENTION)
+	stat = cdrom_check_status(drive, &sshdr);
+	if (!stat || sshdr.sense_key == UNIT_ATTENTION)
 		return CDS_DISC_OK;
 
 	if (!cdrom_get_media_event(cdi, &med)) {
@@ -62,8 +62,8 @@ int ide_cdrom_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 			return CDS_NO_DISC;
 	}
 
-	if (sense.sense_key == NOT_READY && sense.asc == 0x04
-			&& sense.ascq == 0x04)
+	if (sshdr.sense_key == NOT_READY && sshdr.asc == 0x04
+			&& sshdr.ascq == 0x04)
 		return CDS_DISC_OK;
 
 	/*
@@ -71,8 +71,8 @@ int ide_cdrom_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 	 * just return TRAY_OPEN since ATAPI doesn't provide
 	 * any other way to detect this...
 	 */
-	if (sense.sense_key == NOT_READY) {
-		if (sense.asc == 0x3a && sense.ascq == 1)
+	if (sshdr.sense_key == NOT_READY) {
+		if (sshdr.asc == 0x3a && sshdr.ascq == 1)
 			return CDS_NO_DISC;
 		else
 			return CDS_TRAY_OPEN;
@@ -135,7 +135,7 @@ int cdrom_eject(ide_drive_t *drive, int ejectflag)
 static
 int ide_cd_lockdoor(ide_drive_t *drive, int lockflag)
 {
-	struct request_sense my_sense, *sense = &my_sense;
+	struct scsi_sense_hdr sshdr;
 	int stat;
 
 	/* If the drive cannot lock the door, just pretend. */
@@ -150,14 +150,14 @@ int ide_cd_lockdoor(ide_drive_t *drive, int lockflag)
 		cmd[4] = lockflag ? 1 : 0;
 
 		stat = ide_cd_queue_pc(drive, cmd, 0, NULL, NULL,
-				       sense, 0, 0);
+				       &sshdr, 0, 0);
 	}
 
 	/* If we got an illegal field error, the drive
 	   probably cannot lock the door. */
 	if (stat != 0 &&
-	    sense->sense_key == ILLEGAL_REQUEST &&
-	    (sense->asc == 0x24 || sense->asc == 0x20)) {
+	    sshdr.sense_key == ILLEGAL_REQUEST &&
+	    (sshdr.asc == 0x24 || sshdr.asc == 0x20)) {
 		printk(KERN_ERR "%s: door locking not supported\n",
 			drive->name);
 		drive->dev_flags &= ~IDE_DFLAG_DOORLOCKING;
@@ -165,7 +165,7 @@ int ide_cd_lockdoor(ide_drive_t *drive, int lockflag)
 	}
 
 	/* no medium, that's alright. */
-	if (stat != 0 && sense->sense_key == NOT_READY && sense->asc == 0x3a)
+	if (stat != 0 && sshdr.sense_key == NOT_READY && sshdr.asc == 0x3a)
 		stat = 0;
 
 	if (stat == 0) {
@@ -451,8 +451,8 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
 	   layer. the packet must be complete, as we do not
 	   touch it at all. */
 
-	if (cgc->sense)
-		memset(cgc->sense, 0, sizeof(struct request_sense));
+	if (cgc->sshdr)
+		memset(cgc->sshdr, 0, sizeof(*cgc->sshdr));
 
 	if (cgc->quiet)
 		flags |= RQF_QUIET;
@@ -460,7 +460,7 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
 	cgc->stat = ide_cd_queue_pc(drive, cgc->cmd,
 				    cgc->data_direction == CGC_DATA_WRITE,
 				    cgc->buffer, &len,
-				    cgc->sense, cgc->timeout, flags);
+				    cgc->sshdr, cgc->timeout, flags);
 	if (!cgc->stat)
 		cgc->buflen -= len;
 	return cgc->stat;
diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index 35fab1e18adc..ffcf902da390 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -186,14 +186,13 @@ static int sr_play_trkind(struct cdrom_device_info *cdi,
 int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)
 {
 	struct scsi_device *SDev;
-	struct scsi_sense_hdr sshdr;
+	struct scsi_sense_hdr local_sshdr, *sshdr = &local_sshdr;
 	int result, err = 0, retries = 0;
-	unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE], *senseptr = NULL;
 
 	SDev = cd->device;
 
-	if (cgc->sense)
-		senseptr = sense_buffer;
+	if (cgc->sshdr)
+		sshdr = cgc->sshdr;
 
       retry:
 	if (!scsi_block_when_processing_errors(SDev)) {
@@ -202,15 +201,12 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)
 	}
 
 	result = scsi_execute(SDev, cgc->cmd, cgc->data_direction,
-			      cgc->buffer, cgc->buflen, senseptr, &sshdr,
+			      cgc->buffer, cgc->buflen, NULL, sshdr,
 			      cgc->timeout, IOCTL_RETRIES, 0, 0, NULL);
 
-	if (cgc->sense)
-		memcpy(cgc->sense, sense_buffer, sizeof(*cgc->sense));
-
 	/* Minimal error checking.  Ignore cases we know about, and report the rest. */
 	if (driver_byte(result) != 0) {
-		switch (sshdr.sense_key) {
+		switch (sshdr->sense_key) {
 		case UNIT_ATTENTION:
 			SDev->changed = 1;
 			if (!cgc->quiet)
@@ -221,8 +217,8 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)
 			err = -ENOMEDIUM;
 			break;
 		case NOT_READY:	/* This happens if there is no disc in drive */
-			if (sshdr.asc == 0x04 &&
-			    sshdr.ascq == 0x01) {
+			if (sshdr->asc == 0x04 &&
+			    sshdr->ascq == 0x01) {
 				/* sense: Logical unit is in process of becoming ready */
 				if (!cgc->quiet)
 					sr_printk(KERN_INFO, cd,
@@ -245,8 +241,8 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)
 			break;
 		case ILLEGAL_REQUEST:
 			err = -EIO;
-			if (sshdr.asc == 0x20 &&
-			    sshdr.ascq == 0x00)
+			if (sshdr->asc == 0x20 &&
+			    sshdr->ascq == 0x00)
 				/* sense: Invalid command operation code */
 				err = -EDRIVE_CANT_DO_THIS;
 			break;
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index e75dfd1f1dec..528271c60018 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -13,6 +13,7 @@
 
 #include <linux/fs.h>		/* not really needed, later.. */
 #include <linux/list.h>
+#include <scsi/scsi_common.h>
 #include <uapi/linux/cdrom.h>
 
 struct packet_command
@@ -21,7 +22,7 @@ struct packet_command
 	unsigned char 		*buffer;
 	unsigned int 		buflen;
 	int			stat;
-	struct request_sense	*sense;
+	struct scsi_sense_hdr	*sshdr;
 	unsigned char		data_direction;
 	int			quiet;
 	int			timeout;
-- 
2.17.1

