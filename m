Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AH8x226PHwLdson0dctpKjd5p5H91cH0hSysYFzHAQQ1q6AU6vofv7j5BkBk6zcQpI6vvGLYzgLg
ARC-Seal: i=1; a=rsa-sha256; t=1519398010; cv=none;
        d=google.com; s=arc-20160816;
        b=nCOW6QD3OWT7oGxSZ44jbdlo0n354bUfwYMMOoukAoeyb1gwjyZCbOF4lh6rC1AT/8
         1bqbOvc3ZKSkydolr0LrVestDJlBsiMFWMn5TBw1eJip/EoUQZQ5EU0lA6F3tDedjbS5
         lZM2pzTQrDrnNoK8cHTnaGWbiZqhmKqj9SQF32ipAR8zLsnxM+zKRphNssx1FALTY0UG
         ojhTrWwxi6PSqgkGqQ28GJbrOuD7N/LQFqZLC8SN9HqRt22mmtQh2BIPaJWoEyyg4psz
         aUbIvYcj7ZoQZt9AWJAYUEZILr9f/WNqP50sjTiB+3/PKIPo2XnJlHqlAFn+xWC4QIYl
         3/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=5EXcdMYx4pet1RX+BdCBV+KAKt8/3k2v0Ft4KCNbdug=;
        b=BWuVNgMMFNdBfDp8bp7U6letDg/ZcrdibdzWAZqyKn6rkHd/YiZXT7bYrcWxEu1r9b
         21EBREKWx/LG+Yni9FmgN/ATZqSdevITG641SjBu9Jp6S+QyzgGhN/sLJGdrbL9R6/Uh
         cbx97lVV5s2wUQn9liZHku5wdjxtd91YI1gYhY/XoHhEypZaF0BFkUFKevhkHYitRv8r
         83CoX+Co1Ha2lAjXsfuJ78aLXf3JQnww9RcXufn/LdrcrDOtMY32JUqwGAqE/lYZjWdb
         zS11mOHRZcfVVGurIej3IcsM9P5JS9OIBeOHNe2rCvBkThFxBBBbo/ZBxXoLMI3+qqkn
         v6Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix u8 less than zero check
Date: Fri, 23 Feb 2018 15:00:08 +0000
Message-Id: <20180223150008.30124-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593204288033529417?=
X-GMAIL-MSGID: =?utf-8?q?1593204288033529417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The error variable ret is currently a u8 and so two comparisons
to see if an error return is less than zero will always be false
because ret is unsigned.  Fix this by making ret an int.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 51d48de24a24..1e6c587e4550 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -3255,7 +3255,7 @@ static int cfg80211_rtw_sched_scan_start(struct wiphy *wiphy,
 
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	u8 ret;
+	int ret;
 
 	if (padapter->bup == false) {
 		DBG_871X("%s: net device is down.\n", __func__);
-- 
2.15.1
