Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqotNKwDyVQVJbnYf5ypS6wAYwv7siAzQlSeJNOW5NB7hIy8ohJ+DPY8KYV7iH7pVYTdrN8
ARC-Seal: i=1; a=rsa-sha256; t=1525116395; cv=none;
        d=google.com; s=arc-20160816;
        b=llITUSGCXF37dG8/PLxBOENQcFQXH+UsyV7dZRYuVAIebuZCWme7mnK0nmCADooPLC
         V6j7UzlSxCY0OXBIiyAXxCvU9DyDuUbsC4hHXQHz971Edf7x66pw3ZqbtmODUEcTFM8d
         apvbtMvXrZmVyOR9rdzD5iP/BRBDNZui4P70OkvF/lk4i5d5tOW6OOPi3ggGtMa0LQLr
         dVkZS/mp4SLM9vJ0mzRV+mtezyxXNYIPBu2OlRbxXf0EBCxfPRp2HPmSog23cqkUYgWK
         nADGL83P9OtBNsWF292DizxQOCaZkyW3NPa+I/MJC/XUJy+nH8P4BwjKhGE2Suq0UVCm
         NITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0ZmCBg9cddY69m1EhAuW7p0qcVgcyIUwCtNFSwnafy4=;
        b=ucUNlDBJOmNXnLUJ6FdnfxyqAnWi87D5Tz/GnmZUbIUNF1g1cDbM/5uRvBCMHLTw9l
         YfcqrZ6DuFeN9xyPEru7y688fe3bdLGjXxogX9ZWWS8tiKvauWfkl9VTcMwnjtTLWh41
         tDyTDlkdg3DLTgDYTqIAowlrW41EukTOCLTSzGxfnZH2ZJvaxNTcyo0tVpKpUuUOHBLz
         N5zI1/efvdV18tON9jCG3DPh+zS1r36m1zw2wd/yWuPfMors7fvO/4h0zhWYgPRNRskT
         wUfYO4oo/OZKg/Q28lpp6NfCQbAHK+UMJ/KLPjNjqdiSeHC8vJDslVhaIen1C63aSED1
         1FXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62D922DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.9 38/61] mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.
Date: Mon, 30 Apr 2018 12:24:41 -0700
Message-Id: <20180430183954.580338167@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285170089780?=
X-GMAIL-MSGID: =?utf-8?q?1599200449277061585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joakim Tjernlund <joakim.tjernlund@infinera.com>

commit 7b70eb14392a7cf505f9b358d06c33b5af73d1e7 upstream.

Currently it is possible to read and/or write to suspend EB's.
Writing /dev/mtdX or /dev/mtdblockX from several processes may
break the flash state machine.

Taken from cfi_cmdset_0001 driver.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/cfi_cmdset_0002.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -812,9 +812,10 @@ static int get_chip(struct map_info *map
 		    (mode == FL_WRITING && (cfip->EraseSuspend & 0x2))))
 			goto sleep;
 
-		/* We could check to see if we're trying to access the sector
-		 * that is currently being erased. However, no user will try
-		 * anything like that so we just wait for the timeout. */
+		/* Do not allow suspend iff read/write to EB address */
+		if ((adr & chip->in_progress_block_mask) ==
+		    chip->in_progress_block_addr)
+			goto sleep;
 
 		/* Erase suspend */
 		/* It's harmless to issue the Erase-Suspend and Erase-Resume
@@ -2263,6 +2264,7 @@ static int __xipram do_erase_chip(struct
 	chip->state = FL_ERASING;
 	chip->erase_suspended = 0;
 	chip->in_progress_block_addr = adr;
+	chip->in_progress_block_mask = ~(map->size - 1);
 
 	INVALIDATE_CACHE_UDELAY(map, chip,
 				adr, map->size,
@@ -2352,6 +2354,7 @@ static int __xipram do_erase_oneblock(st
 	chip->state = FL_ERASING;
 	chip->erase_suspended = 0;
 	chip->in_progress_block_addr = adr;
+	chip->in_progress_block_mask = ~(len - 1);
 
 	INVALIDATE_CACHE_UDELAY(map, chip,
 				adr, len,
