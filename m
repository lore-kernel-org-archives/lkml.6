Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225KBnczyknY8oOxuveEjMB8e7bap469cBRs2gRJ5qMpHh8fSM//k/AJjuLV5/N/013c7pao
ARC-Seal: i=1; a=rsa-sha256; t=1518708362; cv=none;
        d=google.com; s=arc-20160816;
        b=tWn3ezzkTYhFnQo0S890h9tuDCXP8RqSPbfK8oyeCE7mmrDWE8M4th+pVVMAfRVz5b
         p+Vni8FL9lMem+6tCIO3gm64kaawmLp9hRq/4VN/GCgcI9P0tYytt86YQQraMQBkuP5m
         tvdHB15KWj18l0XeIIVgi2tJ1Zflh2ri+dYhT7R7JBeFI74cgOulj5j52BD6Pe0fTDR3
         ahDlAqilUEmMi1tTfnZ5K5LTLuSsZn7g8gslkWTUz6cvH5Ps+AEhgYt8ILh7IGj/yVP4
         bd756ZtJ1zg1IvhGqThZtYgG4E71wCtZxGAVlnvEmhYxY8VOMkT4jAtdFmnOpkpj1Z2D
         3wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zbnBZFazdx2kME2myi//nX99/PA+GlxH/rKcr693JT8=;
        b=w/hppZKEhSScXbAC+tCn0Aq20hXKQFydrFz/hol0TIknAd84fKcHYhkmVanwZ6yT2R
         yEpe3RvxwT7Rhq602x0SPV72Spjfi8LGFVGuKZ6/xt5lEsUaBQEOW617fI104vPJCqTX
         9jO+YJUIdYT8Uyqoqo+uHLnoJCzSx22vVW/LmLAqHM+hjHLa6eiEoXlSuOYNe5l4smlf
         cywD6gK4X3jxj+7wr67/aApgRRAS0N3YNFmc1N9z0k7l2r5Fq/H5haOXPiGko+yUZ6Fs
         ayqUd9QEA6/pm/acBesEWUX1uFcICTg5eZp5gr2HJTK4WhkCEmwf8TjghpEBA0OzbFlP
         b/5Q==
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
Subject: [PATCH 4.9 16/88] mtd: nand: brcmnand: Disable prefetch by default
Date: Thu, 15 Feb 2018 16:16:43 +0100
Message-Id: <20180215151224.970048629@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481049339714502?=
X-GMAIL-MSGID: =?utf-8?q?1592481139443215056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
