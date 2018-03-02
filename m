Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELun0MxCjNEeh6B7CBCmCCYnoHew9HnqXhe/tpWldEdDbDRVtuwLSMgMi8gVgDClc51IET6D
ARC-Seal: i=1; a=rsa-sha256; t=1519980982; cv=none;
        d=google.com; s=arc-20160816;
        b=vHXslb2L9ypngrF77AcUuaBx6xnjt9TQ/FArweLgxnjVB2Ww3gFZFbAVYZJ6RVq299
         fcSugonSZR4TpnhXWY26IOYUxJVdQIHQ+LOe1868rlbHhN2TW7XiD9vmoDtVZ11cfoxk
         mRKLg9CPaPesJvJmuIb1P+Qrd2poZUXHIYygTmPmd6CptceQAHgnIAx71/POTozNb8lF
         HnsJOPN37AId47BMzfDZUO19pmkBXQTCPqORt9zLjQoMcPJcDK9o+qGXE7+VDSbZWnmw
         YjiCiUyIV861ZdeiT4la0faaXUGNE9JiC17GgVWgN5FGdGF4iwOjsaDedadbvuuml3cA
         o+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t/YH6HNTYKRr6IOD5Ba9X4emKysxuryDrKs76unJ1LE=;
        b=ZbP65nhcIXzUMyHUFYcOvCwjUhI8rf/SNyht6V/68Qf3xR2VAEnQUimXGefmjc2byX
         QGroE5MkxHuIp+TVbycA/TcHcvhBzWFhBPpoDk30sN6LPaQhsPfPDYfkm57t38DgeOHG
         3AkxoRlrNfGTdJoliitiSe77USJchuSKeKQ3GOoe5gkjmOfqJiuytyEsQUKJ2snw69j7
         W/T8BzRKHtpl8bHWs6Gso230I1tSR18Hh8fVRr3lm0aS9HYDFE688zhZLJj/koonnkwu
         VkSgyWI6niqRybNnojg6MIQUL9NsyOZrgPa7YiVpz+9flZ1LQVO4aq/YpHlaKX5FUt2w
         r39w==
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
Subject: [PATCH 4.9 07/56] mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM
Date: Fri,  2 Mar 2018 09:50:53 +0100
Message-Id: <20180302084450.012532837@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815412959122192?=
X-GMAIL-MSGID: =?utf-8?q?1593815578507234032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1059,9 +1059,6 @@ static int gpmi_ecc_read_page(struct mtd
 		return ret;
 	}
 
-	/* handle the block mark swapping */
-	block_mark_swapping(this, payload_virt, auxiliary_virt);
-
 	/* Loop over status bytes, accumulating ECC status. */
 	status = auxiliary_virt + nfc_geo->auxiliary_status_offset;
 
@@ -1150,6 +1147,9 @@ static int gpmi_ecc_read_page(struct mtd
 		max_bitflips = max_t(unsigned int, max_bitflips, *status);
 	}
 
+	/* handle the block mark swapping */
+	block_mark_swapping(this, buf, auxiliary_virt);
+
 	if (oob_required) {
 		/*
 		 * It's time to deliver the OOB bytes. See gpmi_ecc_read_oob()
