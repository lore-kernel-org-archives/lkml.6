Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521890859; cv=none;
        d=google.com; s=arc-20160816;
        b=pdTNlnfqrx+MCUKt2wuwk8mmG6XNDy6lQanw/Zo76gqRpH+MoDiFzaky3TbaIgrM7M
         6fYd/XvNE4Hm861s6EtDtlCheeSj0hHi2IdDPqRNolFAbX55Kd2SiCW9R+Uv28iRErYP
         LZMN4BnFRnBgGlLgAzOiGREofn3JigkplsCTKS8fKjeX7O/icK4mpT9tG7SQpfIMjZLC
         8Krv9QHAuPdO0NYqPSKigCN9pqk14rOfa2ZLHhD/GaQFY3liD8Ugm26hXaIm2BzGrTEi
         xS0d8XIZ5yFPyGzNfkC50GNRUzpw0pd2S3fN/ym0jkPbSL+v1sWUF8v/0sBVI321MMf1
         juUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=7zrMSY1Wi+vIndKKMIIUV2njqohpBgvYt+3SGcR74hk=;
        b=ErIYpRseuS9IHtk4J93NiUeEChmucDR8NfgymeAfnk6nR2Pcu5LzhJWrd1CPPqaQsC
         d20s4JSrHqww2gPczfseZfi3mscLZiMdfGPL5PR5SyukvjaQ0GixzPiDpM5iP4VQ7HXq
         bXWGLzDi9Zz+1ZIR+IAktI1FCvN1YD9s0dBbAVZxm1fosN6towkFqO9+YuYx/RD5932B
         njgPr5Qhvs3BqHPGfi1IYwTo6vTajOITXDYPMntt7x7rY2Q4qilkMMzvrqr2WG/Iqmk/
         7ROqPp6KNvI8WgRTElsjphLV1mhy07UILUvbb1HPZA1bUq3eGuIviQG8wLl8oj/HGqH8
         sT9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JKfLSr3Q;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JKfLSr3Q;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvKDDqyozBGt/OJOfSCMohMusyspXdTu6jlqgX3cAeJAOSr96HKiHUGUg2O/CSNxf2tbgn6Ow==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Joey Pabalinas <joeypabalinas@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>,
	Tomasz Kramkowsk <tk@the-tk.com>
Subject: [PATCH v2 1/4] tty/nozomi: cleanup DUMP() macro
Date: Sat, 24 Mar 2018 01:27:29 -1000
Message-Id: <20180324112732.29424-2-joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180324112732.29424-1-joeypabalinas@gmail.com>
References: <20180324112732.29424-1-joeypabalinas@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595818229750287449?=
X-GMAIL-MSGID: =?utf-8?q?1595818229750287449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace snprint() with strscpy() and use max_t() instead of
the conditional operator.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index b57b35066ebea94639..f26bf1d1e9ee0e74eb 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -72,19 +72,19 @@ do {							\
 
 #define TMP_BUF_MAX 256
 
-#define DUMP(buf__,len__) \
-  do {  \
-    char tbuf[TMP_BUF_MAX] = {0};\
-    if (len__ > 1) {\
-	snprintf(tbuf, len__ > TMP_BUF_MAX ? TMP_BUF_MAX : len__, "%s", buf__);\
-	if (tbuf[len__-2] == '\r') {\
-		tbuf[len__-2] = 'r';\
-	} \
-	DBG1("SENDING: '%s' (%d+n)", tbuf, len__);\
-    } else {\
-	DBG1("SENDING: '%s' (%d)", tbuf, len__);\
-    } \
-} while (0)
+#define DUMP(buf__, len__)						\
+	do {								\
+		char tbuf[TMP_BUF_MAX] = {0};				\
+		if (len__ > 1) {					\
+			u32 data_len = min_t(u32, len__, TMP_BUF_MAX);	\
+			strscpy(tbuf, buf__, data_len);			\
+			if (tbuf[data_len - 2] == '\r')			\
+				tbuf[data_len - 2] = 'r';		\
+			DBG1("SENDING: '%s' (%d+n)", tbuf, len__);	\
+		} else {						\
+			DBG1("SENDING: '%s' (%d)", tbuf, len__);	\
+		}							\
+	} while (0)
 
 /*    Defines */
 #define NOZOMI_NAME		"nozomi"
-- 
2.16.3
