Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fi1Wp/cdKSmmDn1zNIvK1LUsd8fxTi7cukkNB6u1Zy0v+9dfOpr1Hofvn+L3U8d9ESd2n
ARC-Seal: i=1; a=rsa-sha256; t=1522168324; cv=none;
        d=google.com; s=arc-20160816;
        b=TDgiyk78bUpQ1X0fPKEbh1V6/ppDin9XM29vhSpD17RYJ7gYpqMQEF9IUNclfsW/6N
         3ZDnZeu0XR56bYWOnFIHMEHTWtMH/dMgxeujjmjzHw1BUaRqQIOZlxM/HvzCY6eB8u3Y
         wSFtZdGm1jRTPiTaRK7221rZinS439Nu4JvDENSgQt+rc9DbJn7B0FzOUScfI00JFwjZ
         DTSp9BqHKUJyoA5AwqEBFubVBJJPVroxPWCHDAQXoBW6+1+sy9ial1mKsWThLGxuirV3
         gOAKYxgRWhmifG0nYmFGHUrBUQQYWxRlcIekM//3OHisEEWm9hJcxtMfIWpoKvGgY/3C
         xb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9mEkEiaV2qTc/fKWMi7ZSTexxVjr5i73DLsdzz8JIxA=;
        b=XACuPrThHrirYv8roEVXfEWlfk5020oB+IoBHnc1paH1+tP/+6EULxb4YkztIa8bmR
         MwkH+sDB0J+lvJ55WRqbNEvo0XqdaB5ZdbNqoOZsC5IAciBmhkWRFj4Ar16qAXtSG1NH
         RFDy8FJF5Fj/9Gpco+9DpR81u44XuW+l0pl5AFZRttomO6vBtOTJ51GUTPePDA7VDRjr
         YALFRg4lPA6uelbzqZMImAQ6TLncTRXFtM4m0mvd8xrtBXN2zdY2xB1VOkyeG+tMIgzb
         tMML3duweRf2OkMYe0c04o9xA2be4AT6kg7wfNCD/Vi3+ExfTFSU43eiijqIFQOwYx9N
         hs1A==
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
Subject: [PATCH 4.9 38/67] mtdchar: fix usage of mtd_ooblayout_ecc()
Date: Tue, 27 Mar 2018 18:27:30 +0200
Message-Id: <20180327162729.101835615@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109173619457635?=
X-GMAIL-MSGID: =?utf-8?q?1596109173619457635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
