Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224/Sl9JlCUz8/zFsVAcKseuKKwS/9gShl2btI1Q7QwVhi3C66mBRXQG6XX+6RJdmihizJ3u
ARC-Seal: i=1; a=rsa-sha256; t=1519217700; cv=none;
        d=google.com; s=arc-20160816;
        b=Et8eAssFrqnB82bjHG3CjisdBGm9GIjbYobUQ2M/1TJWNph2Jp8JF8Pkmyi2o2Azd8
         X8v4vgxF4mHRkciFkBHW89LtIKDupNGZHtj6FskFvcZbuZhVVQzM94/dZhjSMM8zzfTD
         TBdrLSw+JMTVpAVOl5OBIG8woodZgF2krzYtz9sdR4VEeU+0u9YlSGLBfFp7gFyjgZCP
         FtUjUdkfDx/t9W/uGyXoShxYOLK+vTw5CcWVNX7ONGsoTpQH64cIR/L/gHESfFpm+aE0
         InfXmgGiyc7dKau5wBxc1UoCpC/Y9qr4RRvjsQyoJygGOh6g9GhdV3lPofHB/WtI0H60
         0BNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7Yh02EqzXGKssB8s/W5rRmb4uTuOdBqgT9i6t+y/db0=;
        b=n6VNaJp7ecXZ9IQYFMTjIHfl9BBLr8+KkVaqXb7m4nRm73vlf0ZNafCnOVx7rQ2ei3
         SyfjLbiPL4n2RFlMNjN0I45QfFq139JgyM9H6NPjEyWwFHkSqDfXmd72H2Ds9EyfOsV6
         oHYWbLx5lZG/XkZP7ZG/ufsb3vc7F4kkTa069jRMxvl1wQGa3WyLV8H7Z4VTri64kuKo
         b9AY2skwb4K0XVDgEgTrlwNyxjVoEDg6y7Z9XTtIZ+jx4Fz7yB3PFITO7VHHXrb3vnk5
         bvY9xBwvmvT1StegiwiWGEK9Nv/I23dlAAFp6V0syQSFSwiZbBhsekyGN8KwNfR5rzcb
         fI9w==
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
Subject: [PATCH 4.9 24/77] mtd: nand: vf610: set correct ooblayout
Date: Wed, 21 Feb 2018 13:48:33 +0100
Message-Id: <20180221124433.204290521@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015219498083011?=
X-GMAIL-MSGID: =?utf-8?q?1593015219498083011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
