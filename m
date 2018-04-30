Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrwHK1BUHDdLt/kZzg6NRicqhzumKpOFhc+AYPggtFHs5EtEX487rqzP/8ugu6CV47fBWuJ
ARC-Seal: i=1; a=rsa-sha256; t=1525116443; cv=none;
        d=google.com; s=arc-20160816;
        b=Qk6Xn7X61R2s6RZM9ZnaahQRYdGAE2G4jMVewjE6jpWvLh5PG0EbWRP908BrgQTDAr
         s0S5ZpXYTNKRI/hHuYyayDZKr+c+I8nPaPleUCj9KAQBiZNHyjUwy2356JBwNCKIuYDB
         MXRMQSeRgOnjjD6KdjywNp6XYz1xdhz5H5BoPdxybbjsh1rz9Rfl4ZrZ8AgDU//Fm67U
         3jqUgTKEGgwcp8f9wyAgNde7/yzGpagVELAdL7qTjBnVojyB7Gu8D01bFgUTCK3f+hxq
         F41k3XNhKq7eFiURSrD8fqZU+itadS89KaxyhCtkYWrv4nPa/f3pxQHB93AASyp/i20o
         AwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=9Z0+QTtWV48Eez3EDjsy9pKY9XsTVNn/TGN9ud1nOT8=;
        b=p6oo9slwSgQd6ccUJ8OHqM1XckFED/jGtZ8CEdIlaFCMzpV3h02Iha5zWPtrpPFKCZ
         0njkh3CeQ5ra5LhgKuNOxEAH+XRYRtSzDS0KW0XbYSUUQ3fOc/cfemwK+6EHcRPe2B01
         nbCmG1zokYVjOAbrmDAcycx6ZMLbnviOwcUnO0VBDZ6hKv2EB0sHcDo/tpz8IzPovPgK
         e330rykrDDVbyqmoEVx5PQb11sS6MVlOZnUaytAj++THA4nDr1ZQbH8RRHb4g7229/Cy
         1VjYEn7umGX2apm5Rn/q2hHCfsyZfxlp8lTYtZ0LQG9HaheFfigBJL7g5SCjz5h7KJBF
         KvnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C1E22E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.14 53/91] mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.
Date: Mon, 30 Apr 2018 12:24:35 -0700
Message-Id: <20180430184006.945240271@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285170089780?=
X-GMAIL-MSGID: =?utf-8?q?1599200500012254804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -816,9 +816,10 @@ static int get_chip(struct map_info *map
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
@@ -2267,6 +2268,7 @@ static int __xipram do_erase_chip(struct
 	chip->state = FL_ERASING;
 	chip->erase_suspended = 0;
 	chip->in_progress_block_addr = adr;
+	chip->in_progress_block_mask = ~(map->size - 1);
 
 	INVALIDATE_CACHE_UDELAY(map, chip,
 				adr, map->size,
@@ -2356,6 +2358,7 @@ static int __xipram do_erase_oneblock(st
 	chip->state = FL_ERASING;
 	chip->erase_suspended = 0;
 	chip->in_progress_block_addr = adr;
+	chip->in_progress_block_mask = ~(len - 1);
 
 	INVALIDATE_CACHE_UDELAY(map, chip,
 				adr, len,
