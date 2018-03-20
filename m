Return-Path: <tavery321@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521583041; cv=none;
        d=google.com; s=arc-20160816;
        b=HDjNFwH+qikyU+7MSlTUlVCvUhUDrasL5QyYznKaEt2nx3API9MraYypv/RQ9xQqmH
         ALYEU1OU+YqCv4Ehp99va5iu5FrBdGoNruWQGmOssUY66Uska0IcTItFIxA6kmu25Uav
         NV0jkojNp73lr6V7qt5JA6FVI+3z8YbGnIUw8m+HhoJ7V6ZYwW00KroYEYvOmE1qfvHR
         McmC7KApHekymOAzkH7Y+206wpsddXcwBjPdIb2x2uds96ZZSvVk87tWYHUD4Kcq8qcp
         pZhgsXOeEtFRIe/KRR/Hed0sTk+axKc7eykFD+fZHvJd/bPQXlslkeYi4djIIqEuWcHE
         DgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=Tsh00ayAE4y5O506uhAloXF5aOg/B2uU2qA90QBJel0=;
        b=bb7E0pykqvxg9wJg3IbNRq9C8j3L60mRjnCiqj8Vjo6xKxMcEY4vfLCiUWeUKkz9ES
         LyFFwd68I0Ov8Uy5O97VkFebblMAHliAcvcsldGwjAojaHhSIvIoICZujz/f3xzRiq0V
         yWiEfu30matyMNDVUP7Z//gGnXcySjQ3hRJd2buerenJ0gOsTVH0BZu3GtgmgPhqbyjz
         0sBjvVhCB7pySSkhy5wnnCs07pftnAI9Fgdht/JCJjVtOICf8wFCCHfAskNbkermLv1E
         jxPjxy4z9V6XXn1MF1hjCn+TIdwvPcin/6yOk5tW9KFYWYOhZpVWSbTPvGCED1qjQ+zq
         GLWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LJ0Rvf2U;
       spf=pass (google.com: domain of tavery321@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tavery321@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LJ0Rvf2U;
       spf=pass (google.com: domain of tavery321@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tavery321@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtSeChgf0Gb2Wc7rDKtLCaMq8y11xg2iobPCrX+zzfxTLSOyW2+c9IK2J1b/he9/o6L9Gx0wA==
Date: Tue, 20 Mar 2018 17:45:41 -0400
From: Thomas Avery <tavery321@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs/core/rtw_mlme_ext.c: Replace yield() call
 with cond_resched
Message-ID: <20180320214541.cknrcuercnhfrx2a@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595495459050327769?=
X-GMAIL-MSGID: =?utf-8?q?1595495459050327769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove yield() call, yield() does not guarantee progress, and should not
be used. Cond_resched() is a safer alternative

Signed-off-by: Thomas Avery <tavery321@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 7d7756e40bcb..fdcc5b28af22 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4263,7 +4263,7 @@ unsigned int send_beacon(struct adapter *padapter)
 		issue_beacon(padapter, 100);
 		issue++;
 		do {
-			yield();
+			cond_resched();
 			rtw_hal_get_hwreg(padapter, HW_VAR_BCN_VALID, (u8 *)(&bxmitok));
 			poll++;
 		} while ((poll%10) != 0 && false == bxmitok && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
-- 
2.11.0
