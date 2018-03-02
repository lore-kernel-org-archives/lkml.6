Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv2UnwnXioHN0NFfkA9qx2eux2ZlD0oSjxrOnU8SSS8KRZX+imk3u9ukWbLfppziYSMLtAq
ARC-Seal: i=1; a=rsa-sha256; t=1519981161; cv=none;
        d=google.com; s=arc-20160816;
        b=JSTsV3KJ4M6MwsummzhIFUJhuGReoRe18j9Un5ECbMqPY7hDiwgVaaL4Gg2ckSGohf
         KJHA05LitkVf80S8KW+MaRMBDe1jybMn7J7jJajOHQ5JBYEyEauJg8AQ5hgwJiyyETLV
         MygQNdGvcHB5h0lGmq7PbShXUclsPTVMl+J7YgrgmKBKEz4jhYDz4z6Y6LU7rao1wOAu
         iJsWtyWHVguwoKl9KJfTM2SViHyva0VZ6gY+bXGzTN04BZCFbocbO+5hVfw5+Xn2j8EQ
         HriWyjDqsfrMXIfwTLBfMirNHzr+zXisoxiELPeZ5MT44bQJK+pQ6qXySxJwe6CAHMAG
         8jhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VV6OuKIRWV39ahkTuiSrhAbxPirMeUoc0RHUZ5Xrjzo=;
        b=TYVphUm5FiVVQbpvm59D++zlwdq+EeRqgR5xXga3m1fWj+4kh0vtOVQ4rm6l27gsSE
         FqPBp6JVvy8TT2a4HoRU8mVHhP+pbInWP1UPNeE9g2aHGRP5O6S/NtKtZGwBuwK1MdeL
         OwmAyRMPJSSragY1vG5LOfhy+4QHQhcmXKMYEvxO//8MMMRqgwl4Vd3ltmTyYwkeJM1T
         1yQ2LKj5dRbuMZDLHW4TPCmLNEeUu/3GHyovAn56xe97erLvbIVZCGXOQtF4Qiw5GU7C
         Ej6Ilvi2w/h9NDcYrfRpUjJJybZHQ4rdICIv9APs8x5l291U3FV2ZsJrO5FxQxzoQYlH
         NnqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 012/115] mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM
Date: Fri,  2 Mar 2018 09:50:15 +0100
Message-Id: <20180302084504.359723798@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815412959122192?=
X-GMAIL-MSGID: =?utf-8?q?1593815766887003818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sascha Hauer <s.hauer@pengutronix.de>


[ Upstream commit fdf2e821052958a114618a95ab18a300d0b080cb ]

When erased subpages are read then the BCH decoder returns STATUS_ERASED
if they are all empty, or STATUS_UNCORRECTABLE if there are bitflips.
When there are bitflips, we have to set these bits again to show the
upper layers a completely erased page. When a bitflip happens in the
exact byte where the bad block marker is, then this byte is swapped
with another byte in block_mark_swapping(). The correction code then
detects a bitflip in another subpage and no longer corrects the bitflip
where it really happens.

Correct this behaviour by calling block_mark_swapping() after the
bitflips have been corrected.

In our case UBIFS failed with this bug because it expects erased
pages to be really empty:

UBIFS error (pid 187): ubifs_scan: corrupt empty space at LEB 36:118735
UBIFS error (pid 187): ubifs_scanned_corruption: corruption at LEB 36:118735
UBIFS error (pid 187): ubifs_scanned_corruption: first 8192 bytes from LEB 36:118735
UBIFS error (pid 187): ubifs_scan: LEB 36 scanning failed
UBIFS error (pid 187): do_commit: commit failed, error -117

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Richard Weinberger <richard@nod.at>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1067,9 +1067,6 @@ static int gpmi_ecc_read_page(struct mtd
 		return ret;
 	}
 
-	/* handle the block mark swapping */
-	block_mark_swapping(this, payload_virt, auxiliary_virt);
-
 	/* Loop over status bytes, accumulating ECC status. */
 	status = auxiliary_virt + nfc_geo->auxiliary_status_offset;
 
@@ -1158,6 +1155,9 @@ static int gpmi_ecc_read_page(struct mtd
 		max_bitflips = max_t(unsigned int, max_bitflips, *status);
 	}
 
+	/* handle the block mark swapping */
+	block_mark_swapping(this, buf, auxiliary_virt);
+
 	if (oob_required) {
 		/*
 		 * It's time to deliver the OOB bytes. See gpmi_ecc_read_oob()
