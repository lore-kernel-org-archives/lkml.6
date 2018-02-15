Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225QBLBXT+BaFVVww4iLjJVfjKXqfQCCCm/6E4wbLp//v/u30vDpLgv3ivnhytPw7+cy87na
ARC-Seal: i=1; a=rsa-sha256; t=1518708829; cv=none;
        d=google.com; s=arc-20160816;
        b=YntspA7z6EGtNZVhgXew4G8GZKjEaFiLDX6we6bqYRBMcsbYv8ME3Q2PcQ36i5lT6v
         oT+3F0bHTZeE/Wu1foKHWab9G/no6DnL9PQaapfv27FmcWK/pUqTk7+6eBM1OHUPZZm3
         5MEXgYfrCFpaoHUeC70Gv1xz8mOV6QPE5pji8IPWEP2bsfCTfJwut/KVP9sVIhFbL4X9
         GL5twV4oII38TDnOltzAZNKz//umnszSTgVM28GDvB9ns6yTqPiFvtfdAkggemy0cDvi
         JrKmwTI6QNfykPZApYW5X/WT8rTIby3avkoLofFswibirnhhM8L07aTFkRbZC5/JXffM
         HtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ipZbXsX1c0vGPMkOfhAHiQZ6dQ3IkZns0mRcCDKu50w=;
        b=sY7IiEExvOubLmdBNkxmdoSNQOvymIaj0c+CFW52HBQnQX8iNwO9fJdGcF2dptvLGx
         kt/3QrcldaXXY7yUf+rF5NKpmzXzlnjDGioHECc0OGaOBAFiIO7RpDE2HqpoN3Px/sUw
         HOYSrvZHST/hXMFcz41Ajc4o1Cad7wozqmq5qLh7wizJxH1gJSfz2q4MTSeX4JcdtfEu
         Q0RGnEmmFqRDbqCO2fKZk/e8+w2yP3ySZyC/6DWawwqOB2vlVq1sJu2Zz1g6WLBG+MiH
         LzQ86KtUuMY3GDNLSKKnGoghIRnObp5va2E0LVKEGzsGJ+frL+hvvIndswW9SQCVCBAM
         5D4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 4.14 096/195] mtd: nand: brcmnand: Disable prefetch by default
Date: Thu, 15 Feb 2018 16:16:27 +0100
Message-Id: <20180215151710.493268714@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481049339714502?=
X-GMAIL-MSGID: =?utf-8?q?1592481629195030738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Dasu <kdasu.kdev@gmail.com>

commit f953f0f89663c39f08f4baaa8a4a881401b65654 upstream.

Brcm nand controller prefetch feature needs to be disabled
by default. Enabling affects performance on random reads as
well as dma reads.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/brcmnand/brcmnand.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -2193,16 +2193,9 @@ static int brcmnand_setup_dev(struct brc
 	if (ctrl->nand_version >= 0x0702)
 		tmp |= ACC_CONTROL_RD_ERASED;
 	tmp &= ~ACC_CONTROL_FAST_PGM_RDIN;
-	if (ctrl->features & BRCMNAND_HAS_PREFETCH) {
-		/*
-		 * FIXME: Flash DMA + prefetch may see spurious erased-page ECC
-		 * errors
-		 */
-		if (has_flash_dma(ctrl))
-			tmp &= ~ACC_CONTROL_PREFETCH;
-		else
-			tmp |= ACC_CONTROL_PREFETCH;
-	}
+	if (ctrl->features & BRCMNAND_HAS_PREFETCH)
+		tmp &= ~ACC_CONTROL_PREFETCH;
+
 	nand_writereg(ctrl, offs, tmp);
 
 	return 0;
