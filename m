Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqfVva5LSq+iPpEfE7cO1onw/IxMqUBoq/45Fx6VbbXit8r4NsJ92Ovo+h4RG5C3s4QYs8q
ARC-Seal: i=1; a=rsa-sha256; t=1525116501; cv=none;
        d=google.com; s=arc-20160816;
        b=cW/O2Q6in8BZJoELq/cfMRkxrYdwCF3wDE5VSAPlZSaw7oQFY3qazLxth3oL/qW24K
         BotH+SM0VOvWGc2M0MJ6yoRFNt7d0fOjfKu0dMyFd/KiEe7MJQH080Uz2CnjElK2fIQd
         WmxpMNJcl1GVB3rlBZFoIhZaJsReM53eLdgESyoRg6cFgFI9oT/yfD6aZ+EQ1S6CAeqV
         a6bPkLbNfJ+4hg+rTE0aF/W5dnuF83tKBhq7+u/jGlBecUvWObiYw6xdlOacC8Et0jnQ
         gTtomHraU7WrY9q++Pk0JENBQlS2aM90eHO6XpvVAZczcAZaHPU3eOUDwaH+2cjZSJJ1
         E8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=RKMzk0aad9ldAG7vzg1j40JNqw650IQdp3OrST22jFk=;
        b=MOTJo386hShU7LOSwI72Yzvkv4dLGojW3E+a7s3JPUu5HYUYAy0ULGoDjBkdgWs88/
         t8MXzX/Y4UvuP0KSYC2Gh8v9f+tPJ8LYBkAmfZHjKFkdmNqPdRwfgSTX8vyhwru7veMt
         mvvuO0QiMPL7vxu91+lSlYXv4pcMbNyRdLQF6Sjk36i2sg4ClO1ByT3cKYgffe3RSf+u
         JpDP2xrwds7tEOQ1jNpzDFb3LwsiRsuG5wJEeHWKNnIOmL2LclzCOQK2OC3S1m47+SUP
         I8FooyIKGCQ4tobWr0qHSof0PdjOrbW5GeJ/sWh8cqKsLyDCxFPKpyToKsy3wIaaAtG6
         OVlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707D322DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.16 055/113] mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
Date: Mon, 30 Apr 2018 12:24:26 -0700
Message-Id: <20180430184017.386404824@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200282823323540?=
X-GMAIL-MSGID: =?utf-8?q?1599200561069289005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
