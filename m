Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Fch+ePxk6fBo4Tn3m3pPhPKHTuijJVeq8BvjIBZapMC7oWnZbYpsAmQBfzhD1T3RMLIc0
ARC-Seal: i=1; a=rsa-sha256; t=1519218724; cv=none;
        d=google.com; s=arc-20160816;
        b=faIZ3cfFUxxneJT6lAy9/c4Tsv8GuHaQpGOdadV2sT4viWMRDUA3djoJLK+7DbTRcZ
         crGsEp3WvaW30GwBcauRg524qqm78Mk7V9bvgWzBM9Gf9xrAQ/Ez1IsTxcry/a7CuaFd
         T7z5rpcClkLiR+Tp2ozyu68Jy4A8AH8Mw2SwNChszjlE3ohK8fOvgvDfxDIh9g041XT4
         sf+W+sLuKdzrzjsNnk18t+CqA4P4Ui84/MauGS/DIAiW6zsybBjMHMU80U+Ni4VUd40r
         UmspO3EM/McUqxPnUTz0/5d4rIyrR34/F+3Uk0StMSRkEY1N7sEYQKCt2a9SteirQOCs
         duAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ygCTCIq97QRFD3uUgz/oZySp/KITJUmQyURfW+DgHW0=;
        b=EGWSjIxvE2nE6OS222IMkLIaXv7rj/bNJIQwl1m3aAVqxkgFYvmn0HH1XpphGZe5DC
         dhTddMNUWEY1Mkt+21v+FCN9Y3H6f0T7qnwBpv/2u6uMP49CQrtdsj9p0WdEF+eIL6y7
         AsBKoAhsc1mLRyoDhxPrgA4eg5Z9yA84xX3N5aMGVSrZHD03zqERCRg+PFMy3D81PjU5
         RJcCmG4LWz8cWygKCYTJ5llIHpd+oziAFEg7Xah6pj73L9uKywxBJAejM9HHxphdB3H7
         mvJvjvOUig34AOxLfabbl+CdvHKQ8pv+VocWVWwMgYSmo6uOyys8C8Vm9dpDktEyKwOU
         SuCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.15 142/163] mtd: nand: vf610: set correct ooblayout
Date: Wed, 21 Feb 2018 13:49:31 +0100
Message-Id: <20180221124537.974148710@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015219498083011?=
X-GMAIL-MSGID: =?utf-8?q?1593016293926360543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

commit ea56fb282368ea08c2a313af6b55cb597aec4db1 upstream.

With commit 3cf32d180227 ("mtd: nand: vf610: switch to
mtd_ooblayout_ops") the driver started to use the NAND cores
default large page ooblayout. However, shortly after commit
6a623e076944 ("mtd: nand: add ooblayout for old hamming layout")
changed the default layout to the old hamming layout, which is
not what vf610_nfc is using. Specify the default large page
layout explicitly.

Fixes: 6a623e076944 ("mtd: nand: add ooblayout for old hamming layout")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/vf610_nfc.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -752,10 +752,8 @@ static int vf610_nfc_probe(struct platfo
 		if (mtd->oobsize > 64)
 			mtd->oobsize = 64;
 
-		/*
-		 * mtd->ecclayout is not specified here because we're using the
-		 * default large page ECC layout defined in NAND core.
-		 */
+		/* Use default large page ECC layout defined in NAND core */
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		if (chip->ecc.strength == 32) {
 			nfc->ecc_mode = ECC_60_BYTE;
 			chip->ecc.bytes = 60;
