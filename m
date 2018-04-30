Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp0OTHtMbhhTsuH0mNFTqBGvlbEklLb9a7Aix9V7D+KgTaCxM9ePvJ850QNyR6dh4soqJsn
ARC-Seal: i=1; a=rsa-sha256; t=1525116238; cv=none;
        d=google.com; s=arc-20160816;
        b=UcjuPV6S89mChxMmHPfXE4T7rrBTtOZLO2yX24saTtb6C1pJZc3yyZjLGa/cfpT8at
         ta7ul3rdKMUb4FWx8I6MIcONZsV0VXhQ+L79U0NRezCHXSopeCQh4qlcIyd9FdurtUOP
         Os2xVjo6ar6WelwP1Kzn7TVuU7pZiGjGvwEW4TB/IGPE2xuR97TC6uI3jPyrcmU2StzT
         SkRaEh/Zp526hKO/XfBlNR6bzPqyEZYP3H+DHwbM+3Y2s9ym6GXVQlctBkYwtI0sLkJz
         KQWDPHGlOZ/hgljQq+OtAByQLGYStJ3kxYkN6Pen28f3oWWPibZr1s652D5l9fNJ0V8K
         ZmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Ssj8+PuhiEM3p8szEvIZ5SJ1SURGdTdZMTu3KDrNX5Y=;
        b=AG+iZqWf4rrg/Q1PGRY5q6zJgsd6/TUNg9Mb3l245ZgH9hJZ1D3vysM19iPovnV0rM
         8JX6UDQu4+TMEhgu7BBXLbaxNpQdpniY0qVmVm7czl5+E8UEuB5oOwgVubT/cxz+VCt3
         351vzCUHjwR72uh6rF3oB7/Za6Q1zWViCgk+EKN68KmpSwNmq/lpN4eTa/MMa049ae7N
         wY7r7SzYAxD9qpVVW3FZc0mXWDkc28jTWcT+E57iseRb8VDCo3pAjWkTCPSw0lc7JBtK
         4k0JRrSktrGy8swQshw2U3F/P9WxaCKHQNPkPePmFZkizmaKmwkmP5w9A38gwoKfkMz+
         vmvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6DB22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 3.18 20/25] mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.
Date: Mon, 30 Apr 2018 12:23:27 -0700
Message-Id: <20180430183911.643116131@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285170089780?=
X-GMAIL-MSGID: =?utf-8?q?1599200285170089780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -814,9 +814,10 @@ static int get_chip(struct map_info *map
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
@@ -2265,6 +2266,7 @@ static int __xipram do_erase_chip(struct
 	chip->state = FL_ERASING;
 	chip->erase_suspended = 0;
 	chip->in_progress_block_addr = adr;
+	chip->in_progress_block_mask = ~(map->size - 1);
 
 	INVALIDATE_CACHE_UDELAY(map, chip,
 				adr, map->size,
@@ -2354,6 +2356,7 @@ static int __xipram do_erase_oneblock(st
 	chip->state = FL_ERASING;
 	chip->erase_suspended = 0;
 	chip->in_progress_block_addr = adr;
+	chip->in_progress_block_mask = ~(len - 1);
 
 	INVALIDATE_CACHE_UDELAY(map, chip,
 				adr, len,
