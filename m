Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226VeTtrD21tmCDv8QSCii4RnfTC38Td5bNQ+7GhbTpcoQ6+RR+fUu3tj3z3Cfx3HM+bIBcv
ARC-Seal: i=1; a=rsa-sha256; t=1519218256; cv=none;
        d=google.com; s=arc-20160816;
        b=tKataOarbfQShwO8+KBVKDHGiuxNkK3Y5kodQEtMLxw5Onqg8ERp9ntnpZKkiYz9tm
         33XSFlFXsBAlWU5QmjHZyfuYYdheHbte86w1WqrTEpDSqYZDzLtlLjX/u6akxzz2AhF6
         0cz9JOSAQxqSTRhlSvXUlcEQnayATI+8Y/BmqxC2erU6T+0QH0e1T4agz/4dGIcFohiS
         Q9MtRt8aLZzq1EtZC/pjnduBO0ZemHZsxrRcuaxBbBV5vNQ+jXcptXDddTuf6JQUYZq9
         u8denf66BNBtGJfa9JElZYAgeXIztVPQ61oax3poTdrtOT6OfB2LFrhL3eOMBkJ7DxMU
         rQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nNMUa8TB02AT5yGgqp77D6mw17KSrBsGpMaFLIY0CFk=;
        b=GCEJtAPR/VAYGW4HqRiEONP4dqKGxSym+w7vVsAhiLOU1gUcuPcfsNfmzTNIs1Uhy0
         3l3nnfUSA3qjhLTF6htNvclrzPy/kmzRmYX6vt+O1mkkiRu5HOO3Au8kCOC6HpP9hDuM
         oz3qXyH3vY1SsaepFOddf1t9hfteB/89UcKsCqX++pLHE1CDnH7HSNRO/lXSjIXZkn6s
         /Txch0PGX3S0WiuL4B4rKAlLb2B1pEXsAkaP7QMPjVmUPARfzsQ8siPM+PuVQazWSAGa
         7rkGKHZnRvQEBO8lk1NSg98ZBXuJcyEx2Qld736T9XASLpg52WQdyyyyPzSnKZsVWoQc
         elCQ==
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
Subject: [PATCH 4.14 141/167] mtd: nand: vf610: set correct ooblayout
Date: Wed, 21 Feb 2018 13:49:12 +0100
Message-Id: <20180221124532.445104273@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015219498083011?=
X-GMAIL-MSGID: =?utf-8?q?1593015802429517909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
