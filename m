Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvlUofyG/hCMKU/CZGg3qfEkfn6H4GmqBB72PeLSlyyR5PwP6VvWBJvyEz3v6qzfFHCAOXV
ARC-Seal: i=1; a=rsa-sha256; t=1519980912; cv=none;
        d=google.com; s=arc-20160816;
        b=0ldktcCeKd0ESawxQrc5oCyC07lPP9ilP3N5ZdVF1Lg/BDlCRUX66xPHIMYkSsi41F
         NHY9oFwMHWYjj9lw8oMgdVpusX66fJfEqPPZQX5jhlij26xVrB7nX5B1RrbgW00S2tvz
         pmVfyYORxOYZhu3ZXvJi1+yaHNbIs7eTnHA4GVFPifGEys5OB5D5Tg6wHJpuu+9wg2yL
         4R/uPbI3eCmr/NO0HAO6ThqxDj0MPvr5Jsj5Qz6K038LrTuv6FK9sPcWOreMG3XKQNKw
         ubp8jfMI80Bc7F+7c3LiB1vCle/3Euqr7dG5VPMfEh6MSuaRbpWoQlzpeYLl+9WzwHHi
         5g0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WRVIrsRaQ9tIJecP4ZY/bvmpf8qQdOZETx+5sXRZh+A=;
        b=A4vU1/GjawAWomDGHWK/8V/7OBUsRxwN8D8XG97v+G5UDKHoZ1NJanzYmXQrwndyIo
         dFozHHJvK1xgwIKjsXEEc03hCwQ/lOc1ccg19ybIro355yJU7SrIOBcLXWScWQgRcSfK
         5ZWP7lY0K+iEfe05qBUlhBDhuLFjB5UblFkwKP4NYBLJs1tdhvZpQkLGdqyqJDpAsPh1
         qQPas6m/w/wlLWdv4WgCf0I9sHePeTESMv07RnSA6OhfvIBs3scVRAqFWf3i/6xewPJW
         1Ur7kxvBWB0cx0q54TIad6eGVmFrfvibKWrudsywv5Fq+zFGK19FzvFqKMCb2zvOTbA6
         awMA==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 03/34] mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM
Date: Fri,  2 Mar 2018 09:50:59 +0100
Message-Id: <20180302084436.171257760@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815412959122192?=
X-GMAIL-MSGID: =?utf-8?q?1593815505979225830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1029,9 +1029,6 @@ static int gpmi_ecc_read_page(struct mtd
 		return ret;
 	}
 
-	/* handle the block mark swapping */
-	block_mark_swapping(this, payload_virt, auxiliary_virt);
-
 	/* Loop over status bytes, accumulating ECC status. */
 	status = auxiliary_virt + nfc_geo->auxiliary_status_offset;
 
@@ -1047,6 +1044,9 @@ static int gpmi_ecc_read_page(struct mtd
 		max_bitflips = max_t(unsigned int, max_bitflips, *status);
 	}
 
+	/* handle the block mark swapping */
+	block_mark_swapping(this, buf, auxiliary_virt);
+
 	if (oob_required) {
 		/*
 		 * It's time to deliver the OOB bytes. See gpmi_ecc_read_oob()
