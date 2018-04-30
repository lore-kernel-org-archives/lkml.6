Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrtzwzsXIvrpPH+PQ/LQhrOSiOKoNqQAHOFKHIsJwVUIkloEStwXN/xwoSMPbQsIqLyQB+9
ARC-Seal: i=1; a=rsa-sha256; t=1525116394; cv=none;
        d=google.com; s=arc-20160816;
        b=dJLka7hVYkJVOa1ueCA60DF/5Phm6/4JGfM6p3Ggzt7mjLV5DaQ/1CGGUB2gIcTtiR
         A2+V3OfyHOOtQDf8InsZGHFD/+oOKO8QPNxwIazMl3lRuaQcCE0QYavX6UYKlhZdEvFb
         8DvcNBFXy/01e9sesrm7DlU1s1wdjLPHmy6PJ2x7d2xdrLF8aOZyKwoidEjnIsa1lIJI
         ADSj6FxXQI2ol/+JkbhHkAEAgrPgox5V9TIpHKQ9Bt1CoE1WnSlH6bepAhX5GyUGbqRT
         DFsP8XPwrN17D/rZdXnDAyL3CAOCh+ZxQMe3P6actHybmm+KELjkKM2DwwwLpyE1hlFG
         pIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Be4FtGUJuVS9C6KT9cjfdvb31M5YY+aTmkoKFTTw/rg=;
        b=vrE7je+rAIZYDHBx7IWwuZCtmaxlQbPYJAtVmNp/1Y7J7iRPh5yZzwFZa7L/6ksv5s
         Sqjf5NciWhD1OA1SRKXZZB/f6nLFsyvyInpWPqj+L+nUyH9b6+ZrgDH5yrgi/xZ4CfbJ
         TKK+eceZgxUJk1XweeIoJtFl8FgoKrEzo/ANiAAHE9L5BBZ6SDahaMqlgdHjJB5LgjXX
         PrIcfdMxH25bs1QWmkY4VLTj/0yv/LlCjuThx9+UCQpwgigCqIexsPAMzWdnFSatMjtJ
         nBkvRa1BS68xgxmQcqcrbBsDXHMNMJB0NONja07u30ie1Y4T/7p3pEuozw5G/hYGuJSx
         nwIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776E222E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.9 36/61] mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
Date: Mon, 30 Apr 2018 12:24:39 -0700
Message-Id: <20180430183954.424222264@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200282823323540?=
X-GMAIL-MSGID: =?utf-8?q?1599200447965745227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -831,21 +831,25 @@ static int chip_ready (struct map_info *
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
 
@@ -1041,8 +1045,8 @@ static void put_chip(struct map_info *ma
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
@@ -1933,6 +1937,8 @@ static int __xipram do_erase_oneblock(st
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
