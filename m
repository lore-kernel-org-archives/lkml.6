Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsEes4AZZau6ux/XO7uU6ptDAyiYqphaRpdlbH4FaVvzmz5vPT3xduQ+Gg7SjwJ/4y6lYxu
ARC-Seal: i=1; a=rsa-sha256; t=1521214772; cv=none;
        d=google.com; s=arc-20160816;
        b=tEVpQ1FJcYGKNxV9FPC8ix9eyFFtNk/cAt1cwWRrjvpfFmR+gz7qnnRmz5mBKBoOg8
         Z8I2Ad6mU/41ac3BVMidalpdMrMXHSZhV1OBXm9IY9ju/vPInXMOX0yg+So6TOx2jQ1Q
         dDyP+lxOivhdqy8wYB+tEcoH9vuZSCeehU+20y4c4HGyLnARPEIPzPGmROI3CM2Bdlns
         95m3OIOA/EWPbcYnJQfTxrFLoXf9FWsQ+KSR85tGS/hyQUahdjZd0JY9E9A0agvn+HvO
         2L6EFVGHkRvg/nYWRUu+xak2FzODw1uelFNYRjxPh2Sese+MlNNwgUJcSFSjFnyg0nFP
         8niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L84Y1r64jX6icNJpi02WBkf0q8fNPb2a6awXT/Vto74=;
        b=XkNmBcIxQiCyVrxR7kITkD0WdylDsRTSlDSPWZulHX2X0Na7s90QgKS/UyUmbeVnwB
         r56MVA0yB+x02QeBdKO1dyXm+pVDpggCoa8AhxCwHM7BZeGj/aAKbZPHzYi8029SqS+g
         fWkAqLJZIawLmjCDVUErzFA79c4B/+elH1ywJbyHcXuQDlCpAWHpA16/iS88kuz8pzds
         CoAq6+lxIIDXCu7OAt83GzIaGKvNTVLjs2Th4sQr5ttPzlkL5I/Y3sGPv06WRrhDueKR
         hzErXJr4fqe5fSPF1mfeE9CUejqSLRm81N6m/4AHVtw6xmd18mAgQ4fVM+ffHnsmpfyg
         oP3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"David.butterfield" <david.butterfield@wdc.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 014/128] scsi: sd_zbc: Fix potential memory leak
Date: Fri, 16 Mar 2018 16:22:35 +0100
Message-Id: <20180316152337.075974962@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109300677505902?=
X-GMAIL-MSGID: =?utf-8?q?1595109300677505902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 4b433924b2755a94f99258c178684a0e05c344de upstream.

Rework sd_zbc_check_zone_size() to avoid a memory leak due to an early
return if sd_zbc_report_zones() fails.

Reported-by: David.butterfield <david.butterfield@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd_zbc.c |   35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -486,7 +486,7 @@ static int sd_zbc_check_capacity(struct
  */
 static int sd_zbc_check_zone_size(struct scsi_disk *sdkp)
 {
-	u64 zone_blocks;
+	u64 zone_blocks = 0;
 	sector_t block = 0;
 	unsigned char *buf;
 	unsigned char *rec;
@@ -504,10 +504,8 @@ static int sd_zbc_check_zone_size(struct
 
 	/* Do a report zone to get the same field */
 	ret = sd_zbc_report_zones(sdkp, buf, SD_ZBC_BUF_SIZE, 0);
-	if (ret) {
-		zone_blocks = 0;
-		goto out;
-	}
+	if (ret)
+		goto out_free;
 
 	same = buf[4] & 0x0f;
 	if (same > 0) {
@@ -547,7 +545,7 @@ static int sd_zbc_check_zone_size(struct
 			ret = sd_zbc_report_zones(sdkp, buf,
 						  SD_ZBC_BUF_SIZE, block);
 			if (ret)
-				return ret;
+				goto out_free;
 		}
 
 	} while (block < sdkp->capacity);
@@ -555,35 +553,32 @@ static int sd_zbc_check_zone_size(struct
 	zone_blocks = sdkp->zone_blocks;
 
 out:
-	kfree(buf);
-
 	if (!zone_blocks) {
 		if (sdkp->first_scan)
 			sd_printk(KERN_NOTICE, sdkp,
 				  "Devices with non constant zone "
 				  "size are not supported\n");
-		return -ENODEV;
-	}
-
-	if (!is_power_of_2(zone_blocks)) {
+		ret = -ENODEV;
+	} else if (!is_power_of_2(zone_blocks)) {
 		if (sdkp->first_scan)
 			sd_printk(KERN_NOTICE, sdkp,
 				  "Devices with non power of 2 zone "
 				  "size are not supported\n");
-		return -ENODEV;
-	}
-
-	if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {
+		ret = -ENODEV;
+	} else if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {
 		if (sdkp->first_scan)
 			sd_printk(KERN_NOTICE, sdkp,
 				  "Zone size too large\n");
-		return -ENODEV;
+		ret = -ENODEV;
+	} else {
+		sdkp->zone_blocks = zone_blocks;
+		sdkp->zone_shift = ilog2(zone_blocks);
 	}
 
-	sdkp->zone_blocks = zone_blocks;
-	sdkp->zone_shift = ilog2(zone_blocks);
+out_free:
+	kfree(buf);
 
-	return 0;
+	return ret;
 }
 
 static int sd_zbc_setup(struct scsi_disk *sdkp)
