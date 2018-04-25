Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZrZhOda/rMFLRB4hJf2tTOx5wynTksuTJLCGx5my1ZqrQv+Y1GGmGbB2F1dgJpD7mrDFZaA
ARC-Seal: i=1; a=rsa-sha256; t=1524652657; cv=none;
        d=google.com; s=arc-20160816;
        b=iOruYKY1J5AvZC6bXuNYHsNYNhoQlE43SxXgacYnVvPr10tJZ7ze2fQdOFLX0l3e+A
         Hjq11WMrjEGGUKSsvPxgaq+gUN0p3dgkt3ePTC7oC50Kl2g1jqF9XAFe19j79NsbJUh3
         TW7Ck+t1bbt5u+yNFmBN4Vm+zRk+lL+R2sfG/jUOdCiQ8AWGU7poutnTglVCOMK8TDjx
         sz4fBX36rQsMUwOuPTi0dPKLDVw8dD8eSB653CBFcRXdBAJmEASIcFbvY+0P7hdeTR7/
         iIRl4G7SgQKxBGc5GP4xnQXQgfuEWrzPI4Pli3NstQwFfXbCFvgnvssDvwJyEPqOW6ED
         t5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+BeNr2t/r6VBadvhTBAG33/Olb1JrWyQhEE1UArE1K0=;
        b=T2y+K17glteqpcFHnTgVqGnUa9suxYyAMAtNEvy1GC8SUHuTAr+aw4KxtEAPoQQIkM
         KZVorwliHoYnTNLw14Ghwh3hTwbu3EqJC+yA+G7eSHBqRJ1ionPF7FhdF3gTcdJj7NOf
         3iyG+01o9nqY2FcgzugAl5DGfnIQEYF1tZGtXXhITaU87rQGMxYjf20p6ogubVzaxyZ+
         tABq9DHUdCO6prA/e4/ZTGI0MYqhbiKKVZSlU2b7V/OAUkdoaF6AdL5BAzVDGClmiGEs
         DWoJxOih3CrxiDiRFSdjHH2Nb90TJwCl6CpEHD/WCk62WHniy7OIVwDHamsN75dMDEkV
         pH7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 021/183] ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()
Date: Wed, 25 Apr 2018 12:34:01 +0200
Message-Id: <20180425103243.457111558@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714185220866802?=
X-GMAIL-MSGID: =?utf-8?q?1598714185220866802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 123af9043e93cb6f235207d260d50f832cdb5439 ]

The loop timeout doesn't work because it's a post op and ends with "tmo"
set to -1.  I changed it from a post-op to a pre-op and I changed the
initial the starting value from 5 to 6 so we still iterate 5 times.  I
left the other as it was because it's a large number.

Fixes: b3c70c9ea62a ("ASoC: Alchemy AC97C/I2SC audio support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/au1x/ac97c.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -91,8 +91,8 @@ static unsigned short au1xac97c_ac97_rea
 	do {
 		mutex_lock(&ctx->lock);
 
-		tmo = 5;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		tmo = 6;
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			udelay(21);	/* wait an ac97 frame time */
 		if (!tmo) {
 			pr_debug("ac97rd timeout #1\n");
@@ -105,7 +105,7 @@ static unsigned short au1xac97c_ac97_rea
 		 * poll, Forrest, poll...
 		 */
 		tmo = 0x10000;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			asm volatile ("nop");
 		data = RD(ctx, AC97_CMDRESP);
 
