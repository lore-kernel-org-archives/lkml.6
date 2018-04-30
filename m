Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZokddCBJKuANKrZcIeppCYmNGbE21ZJLEX9VWQr00JkHC60Z4Fm8u5K9Vx+j0oqTkcHHms/
ARC-Seal: i=1; a=rsa-sha256; t=1525116358; cv=none;
        d=google.com; s=arc-20160816;
        b=OfIXP81aykanY+WMpTmxSvRAuf3+nIKVmIEmaRQDgmUzw0mqYL5UYS9CcU995c9Hhb
         f3aDIHFMnULmZvjXUfWFCt2XsaiBxgIA11X/BNiIixFW+q74Q250+iNS8/c5CjrBRjOS
         M0eK/MkOlcv320Ke5/xTfV0HNg/BffddTVFD/EJGGLQMRkfYGdk36xzZVI1fz1g4p4Fx
         H7ARhNOMfBAhCwQntzUSbUiBqB1uDezqgKb6kLuP6MDy6vY06CrO0N3fYkbfTaFr0/5f
         WnOFD+uRQ4kJ3StwV4XdDiHrl1wgJz+4FpcYkyeAgUX0+hCA8ianDC1PDku6XcfvpQEA
         MpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=dYnElPwRF7pLq9y0HWXF7oVDqxX5xbICgyhXmAvvXjM=;
        b=CXKgjjOAg16rn6AV2IN8oUfIJQUrfJFhdKOVHBJlajg9Jp2SPOe9iL0WWsXYHli/tg
         uFdMN+12ND2oSXCg/j9Q2lG/apQJYcb5zv7MAqHUiDxSd1hk48RIY593qlZojVfW+0gu
         UHnhSYAEo1su2CDMeqrjWsqsssv06vYs7PpI76rRzz9+m+I9cOe98JlhSWFLLwFebQBj
         RnATyClwQ55W4nAOOlKwnBhFzRxG2N4zbemE2q3Bz0ZVD9VI+834CnDILDKPjFw7CDMd
         76NWc3DWLuSX00VvMXHVEYx9SmxQJ1aNBAP2T318e+m1KUNS6Qgel0yPPVCocZvpXfOT
         TcDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223F622DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.4 30/44] mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
Date: Mon, 30 Apr 2018 12:24:41 -0700
Message-Id: <20180430190947.537410858@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200282823323540?=
X-GMAIL-MSGID: =?utf-8?q?1599200410963837585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joakim Tjernlund <joakim.tjernlund@transmode.se>

commit 6510bbc88e3258631831ade49033537081950605 upstream.

Currently it is possible to read and/or write to suspend EB's.
Writing /dev/mtdX or /dev/mtdblockX from several processes may
break the flash state machine.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/cfi_cmdset_0001.c |   16 +++++++++++-----
 include/linux/mtd/flashchip.h       |    1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -825,21 +825,25 @@ static int chip_ready (struct map_info *
 		     (mode == FL_WRITING && (cfip->SuspendCmdSupport & 1))))
 			goto sleep;
 
+		/* Do not allow suspend iff read/write to EB address */
+		if ((adr & chip->in_progress_block_mask) ==
+		    chip->in_progress_block_addr)
+			goto sleep;
 
 		/* Erase suspend */
-		map_write(map, CMD(0xB0), adr);
+		map_write(map, CMD(0xB0), chip->in_progress_block_addr);
 
 		/* If the flash has finished erasing, then 'erase suspend'
 		 * appears to make some (28F320) flash devices switch to
 		 * 'read' mode.  Make sure that we switch to 'read status'
 		 * mode so we get the right data. --rmk
 		 */
-		map_write(map, CMD(0x70), adr);
+		map_write(map, CMD(0x70), chip->in_progress_block_addr);
 		chip->oldstate = FL_ERASING;
 		chip->state = FL_ERASE_SUSPENDING;
 		chip->erase_suspended = 1;
 		for (;;) {
-			status = map_read(map, adr);
+			status = map_read(map, chip->in_progress_block_addr);
 			if (map_word_andequal(map, status, status_OK, status_OK))
 			        break;
 
@@ -1035,8 +1039,8 @@ static void put_chip(struct map_info *ma
 		   sending the 0x70 (Read Status) command to an erasing
 		   chip and expecting it to be ignored, that's what we
 		   do. */
-		map_write(map, CMD(0xd0), adr);
-		map_write(map, CMD(0x70), adr);
+		map_write(map, CMD(0xd0), chip->in_progress_block_addr);
+		map_write(map, CMD(0x70), chip->in_progress_block_addr);
 		chip->oldstate = FL_READY;
 		chip->state = FL_ERASING;
 		break;
@@ -1927,6 +1931,8 @@ static int __xipram do_erase_oneblock(st
 	map_write(map, CMD(0xD0), adr);
 	chip->state = FL_ERASING;
 	chip->erase_suspended = 0;
+	chip->in_progress_block_addr = adr;
+	chip->in_progress_block_mask = ~(len - 1);
 
 	ret = INVAL_CACHE_AND_WAIT(map, chip, adr,
 				   adr, len,
--- a/include/linux/mtd/flashchip.h
+++ b/include/linux/mtd/flashchip.h
@@ -85,6 +85,7 @@ struct flchip {
 	unsigned int write_suspended:1;
 	unsigned int erase_suspended:1;
 	unsigned long in_progress_block_addr;
+	unsigned long in_progress_block_mask;
 
 	struct mutex mutex;
 	wait_queue_head_t wq; /* Wait on here when we're waiting for the chip
