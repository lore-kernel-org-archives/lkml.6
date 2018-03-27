Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/wY6SzLKN5seZwuyKyp24cD2eFchI0LQvSpDtg/xqkM8ObYoV1DfuuOgh95qzO6x6qIPKp
ARC-Seal: i=1; a=rsa-sha256; t=1522168693; cv=none;
        d=google.com; s=arc-20160816;
        b=N/mjcaUOK6yQBRlOVCWJpnCZgz7yUaP2l59N6mPyr+3qxhIaJtHJ5pijf3T3im7vyg
         6TxepeGjqlzXyaCIQF/MD9sFnRzvCgSOjhnxSiwT2y+4Ncr59WeIdoW0zRSYJ5ayXHUK
         GJjAjc6idnxXv0svqOlIw48TZIZz6bYaa1533aDaaW7flxQMqULHKJqPxoOJtIxrcrq/
         TMKJHeN41R0T8MhKn0la5S+u3euyNZCvJaagi57eyA3dJbH8Bl02DHtFf2sGcazlP+5F
         H1DfFob6ZTmjejv1mHD7Iu+jdfPttQ1EBh/sPdJv1tbwuKcxrXs7wHAOD2XQBX3sdoRa
         MiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fb03iGY2U5Fgpi/WuDK05Xed4CtUo1RGjZ0tDuwz15U=;
        b=Eq8SpxpE6FpnDeWasvu5TnjfehWnOi9WcRZxg03UHDMHfFEBiA2tVG27d1CR+dSQtW
         U80uF7ZMSYIkwXvfzp9/xb0E56d+dE96Gag+ET6f4CG9B8c2RB+Mu2DY2OTYT1LUMrWG
         3A8+RLIqTCeov3DP687suy9nmI0tuOd2Tj/sbkJrCkUCnTaX5Pc/nygAjfpbiUq7WqUP
         tN6ZV1Imacj/gO49u2QB2QoraAIlPFGRg2nl5j/zdBY8eg6Awf5YpV5g+UR7kUw1xEXK
         wiAsk8ICMLUPnsbN2IhQSNgd30sbOTGD1B2TZb96DK8PKxisKVcIbsR9K4kUWZpyD+S9
         X9cA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	OuYang ZhiZhong <ouyzz@yealink.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.14 065/101] mtdchar: fix usage of mtd_ooblayout_ecc()
Date: Tue, 27 Mar 2018 18:27:37 +0200
Message-Id: <20180327162754.010738067@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109173619457635?=
X-GMAIL-MSGID: =?utf-8?q?1596109559976257055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: OuYang ZhiZhong <ouyzz@yealink.com>

commit 6de564939e14327148e31ddcf769e34105176447 upstream.

Section was not properly computed. The value of OOB region definition is
always ECC section 0 information in the OOB area, but we want to get all
the ECC bytes information, so we should call
mtd_ooblayout_ecc(mtd, section++, &oobregion) until it returns -ERANGE.

Fixes: c2b78452a9db ("mtd: use mtd_ooblayout_xxx() helpers where appropriate")
Cc: <stable@vger.kernel.org>
Signed-off-by: OuYang ZhiZhong <ouyzz@yealink.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/mtdchar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -487,7 +487,7 @@ static int shrink_ecclayout(struct mtd_i
 	for (i = 0; i < MTD_MAX_ECCPOS_ENTRIES;) {
 		u32 eccpos;
 
-		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
+		ret = mtd_ooblayout_ecc(mtd, section++, &oobregion);
 		if (ret < 0) {
 			if (ret != -ERANGE)
 				return ret;
@@ -534,7 +534,7 @@ static int get_oobinfo(struct mtd_info *
 	for (i = 0; i < ARRAY_SIZE(to->eccpos);) {
 		u32 eccpos;
 
-		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
+		ret = mtd_ooblayout_ecc(mtd, section++, &oobregion);
 		if (ret < 0) {
 			if (ret != -ERANGE)
 				return ret;
