Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49UoEdigZ9ZXxaCHSMDt6c48xg2MlQ9L13vUpUeGKn7OfF3pRMMCexyU9HJiGUEWSzBuHqH
ARC-Seal: i=1; a=rsa-sha256; t=1524405464; cv=none;
        d=google.com; s=arc-20160816;
        b=tNPPNcmkQ0bSCbcs5z00jTwrKOSgPGS4m3SOKI27XjewvMeA22PixAE+K8SMBxHQ67
         t47cnj8es6/HK9H110/cCsk7nXN7RQBxkvZDwv8Cyzclu8BjyMI9vFoTMxxd4nv3YaND
         CI1KwHR6i6uS/C6IyGyYJBWuRIMwtx5UYMZfYJObE52aOu74rB8J7NS+rSs0M7by9cEV
         CFqRDBjapOBVNUoXgjvNnTWszXv6rmQTcRm+zlAFAsRmI62ObsN8jB/u24LFKmj6ZZda
         V/4jztt9y9NhMx+8V2OqSToj2VQht/vX8v5IpkrUjht1HqpFxKkonQF4C+qAnhcKlR72
         bYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t/6oF9ZmS1T5Osqox1sOc0sVcon1epQbt7ayWDZgJQ8=;
        b=wiPhXMmlHzSXdTl0WCNE9SSSdPIKur1yX3Xn5NRQKPDBLMzyOi11QUBVJafVzMxj7H
         3w6HuZ6llisOs2keMAGZrV/jYTl4jA0m6oDPlorQves2FBwxGaqH7W/D2xqqCgBiRZ0d
         UBizTjHPzhMUR7VItnjaD+HSMoY0/IxiKifFEX+iAvtgK+N501YlWqqJLMekMMJu4gKu
         dLmbQZmeOG+z4W2TsdKC6z6o7oYF3JZ+fK9MrhJL3qH3KDJIn6hslImTbJh2j76KRhNY
         LeEolb2eYmdzbA4CdGpdDwMD4I2KrLSune6b4T97XGMqF+uZNV5cKp16xobxRik+uaaf
         wC7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 4.16 075/196] thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
Date: Sun, 22 Apr 2018 15:51:35 +0200
Message-Id: <20180422135108.112426632@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454984602080437?=
X-GMAIL-MSGID: =?utf-8?q?1598454984602080437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit e4be8c9b6a512e274cb6bbac4ac869d73880a8b3 upstream.

Sometimes during cold boot ICM has not yet authenticated the active NVM
image leading to timeout and failing the driver probe. Allow ICM to take
some more time and increase the timeout to 3 seconds before we give up.

While there fix icm_firmware_init() to return the real error code
without overwriting it with -ENODEV.

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thunderbolt/icm.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -728,14 +728,14 @@ static bool icm_ar_is_supported(struct t
 static int icm_ar_get_mode(struct tb *tb)
 {
 	struct tb_nhi *nhi = tb->nhi;
-	int retries = 5;
+	int retries = 60;
 	u32 val;
 
 	do {
 		val = ioread32(nhi->iobase + REG_FW_STS);
 		if (val & REG_FW_STS_NVM_AUTH_DONE)
 			break;
-		msleep(30);
+		msleep(50);
 	} while (--retries);
 
 	if (!retries) {
@@ -1054,6 +1054,9 @@ static int icm_firmware_init(struct tb *
 			break;
 
 		default:
+			if (ret < 0)
+				return ret;
+
 			tb_err(tb, "ICM firmware is in wrong mode: %u\n", ret);
 			return -ENODEV;
 		}
