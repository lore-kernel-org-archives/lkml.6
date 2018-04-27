Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp9GIlqVl7s+Y+n9TRcGuugLhv4AOS/6TytMCGm9CvwqWTkNrt6dZZq2LsaW4Xq6+RLR9di
ARC-Seal: i=1; a=rsa-sha256; t=1524838294; cv=none;
        d=google.com; s=arc-20160816;
        b=Dd6tXh70BKfFH5Rk+f7O4WcWVaDebbMo2rLJii5tSJwMO4nSk4kNupeldH4lqP+idI
         pUbPRI6uB31cPFu/MeYzDuRko+2XbxjNsqtgITZvThzFAbiknehk/l554Yxu7jiED8uN
         YJFDdt4iDNBMYQ0EPhC5Am3k+8m1dY09u7wq+rkq5yW46Xf1XIETKQ6HUh6dDQ4m4KT3
         JbsoGrwxJ8gMo925dMkFqF+uIR5AozL6w3vBO3+ihObqIr+68KkXwgwBpcMTmOCNianS
         PAl4YQ3ByAZ2QZs2TSgiQzGjuMpcLcydUNR775CGg9V11PYG6sPR3xI/iqDBSKn8dON4
         HBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4e8TT6r7vh0jRufwlZILqJcgNOOW4/LsaokrJNtTpmU=;
        b=TqgqFDEiRDy/JAuHQOLMExDk28hC4twom5Vf4r1Zc/0CQIfmcYhz/r3cPuRynI7bZG
         11FOx0Fjl2kcLfrjBOrvz1aQY4iiRZvTAULlAKNKXIPZLEfC6rFP5DyegfgiZGU6YUFZ
         lRs9UelA8mogIQH8zifr2nBQ04HJ/aBBMOmH8O+/DRUA6M3+ZXWAgXGrkCBqggKRzTW1
         HCfhvEvYJeWdwfQH3EqPxjoD8IXfWrdUMUbj238taRM1yNTO/9kGbZu3xA5ZuAyg4ovA
         m5Rm5nZOnkRK68LZuCqd9I3fxZvm+yq5L8QjIx2L5JJHNBbJhx1+J/sVH5gtr75yG8CO
         tzHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA0521895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 52/81] bnxt_en: Fix memory fault in bnxt_ethtool_init()
Date: Fri, 27 Apr 2018 15:58:54 +0200
Message-Id: <20180427135746.276210299@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908839497575706?=
X-GMAIL-MSGID: =?utf-8?q?1598908839497575706?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>


[ Upstream commit a60faa60da891e311e19fd3e88d611863f431130 ]

In some firmware images, the length of BNX_DIR_TYPE_PKG_LOG nvram type
could be greater than the fixed buffer length of 4096 bytes allocated by
the driver.  This was causing HWRM_NVM_READ to copy more data to the buffer
than the allocated size, causing general protection fault.

Fix the issue by allocating the exact buffer length returned by
HWRM_NVM_FIND_DIR_ENTRY, instead of 4096.  Move the kzalloc() call
into the bnxt_get_pkgver() function.

Fixes: 3ebf6f0a09a2 ("bnxt_en: Add installed-package firmware version reporting via Ethtool GDRVINFO")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   51 +++++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt_nvm_defs.h |    2 
 2 files changed, 28 insertions(+), 25 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1874,22 +1874,39 @@ static char *bnxt_parse_pkglog(int desir
 	return retval;
 }
 
-static char *bnxt_get_pkgver(struct net_device *dev, char *buf, size_t buflen)
+static void bnxt_get_pkgver(struct net_device *dev)
 {
+	struct bnxt *bp = netdev_priv(dev);
 	u16 index = 0;
-	u32 datalen;
+	char *pkgver;
+	u32 pkglen;
+	u8 *pkgbuf;
+	int len;
 
 	if (bnxt_find_nvram_item(dev, BNX_DIR_TYPE_PKG_LOG,
 				 BNX_DIR_ORDINAL_FIRST, BNX_DIR_EXT_NONE,
-				 &index, NULL, &datalen) != 0)
-		return NULL;
+				 &index, NULL, &pkglen) != 0)
+		return;
+
+	pkgbuf = kzalloc(pkglen, GFP_KERNEL);
+	if (!pkgbuf) {
+		dev_err(&bp->pdev->dev, "Unable to allocate memory for pkg version, length = %u\n",
+			pkglen);
+		return;
+	}
 
-	memset(buf, 0, buflen);
-	if (bnxt_get_nvram_item(dev, index, 0, datalen, buf) != 0)
-		return NULL;
+	if (bnxt_get_nvram_item(dev, index, 0, pkglen, pkgbuf))
+		goto err;
 
-	return bnxt_parse_pkglog(BNX_PKG_LOG_FIELD_IDX_PKG_VERSION, buf,
-		datalen);
+	pkgver = bnxt_parse_pkglog(BNX_PKG_LOG_FIELD_IDX_PKG_VERSION, pkgbuf,
+				   pkglen);
+	if (pkgver && *pkgver != 0 && isdigit(*pkgver)) {
+		len = strlen(bp->fw_ver_str);
+		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
+			 "/pkg %s", pkgver);
+	}
+err:
+	kfree(pkgbuf);
 }
 
 static int bnxt_get_eeprom(struct net_device *dev,
@@ -2558,22 +2575,10 @@ void bnxt_ethtool_init(struct bnxt *bp)
 	struct hwrm_selftest_qlist_input req = {0};
 	struct bnxt_test_info *test_info;
 	struct net_device *dev = bp->dev;
-	char *pkglog;
 	int i, rc;
 
-	pkglog = kzalloc(BNX_PKG_LOG_MAX_LENGTH, GFP_KERNEL);
-	if (pkglog) {
-		char *pkgver;
-		int len;
-
-		pkgver = bnxt_get_pkgver(dev, pkglog, BNX_PKG_LOG_MAX_LENGTH);
-		if (pkgver && *pkgver != 0 && isdigit(*pkgver)) {
-			len = strlen(bp->fw_ver_str);
-			snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
-				 "/pkg %s", pkgver);
-		}
-		kfree(pkglog);
-	}
+	bnxt_get_pkgver(dev);
+
 	if (bp->hwrm_spec_code < 0x10704 || !BNXT_SINGLE_PF(bp))
 		return;
 
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_nvm_defs.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_nvm_defs.h
@@ -59,8 +59,6 @@ enum bnxt_nvm_directory_type {
 #define BNX_DIR_ATTR_NO_CHKSUM			(1 << 0)
 #define BNX_DIR_ATTR_PROP_STREAM		(1 << 1)
 
-#define BNX_PKG_LOG_MAX_LENGTH			4096
-
 enum bnxnvm_pkglog_field_index {
 	BNX_PKG_LOG_FIELD_IDX_INSTALLED_TIMESTAMP	= 0,
 	BNX_PKG_LOG_FIELD_IDX_PKG_DESCRIPTION		= 1,
