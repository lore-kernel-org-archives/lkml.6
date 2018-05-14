Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp4zbSE/15FNCWsvpzrG6nZoKntiSk4zKl1m5f9McQ0OgrqSFeGR5YyuX0weFhvRaj0474Q
ARC-Seal: i=1; a=rsa-sha256; t=1526281100; cv=none;
        d=google.com; s=arc-20160816;
        b=gPhVrDeVhp5gy1zOaAhYz5KO0pMiDlyZQc5IJg/zm6Qnr959nZrcI7p7F6NUDIMANp
         GHufd0uPMNGcrrc/vZ8Hs3FT6JGRiiYL6ci1i+2kdVvA1zaVfyadp61yQbpnT6kQ5v3q
         z+oT5PpnjQrzI12x7TzpzpFn1m6llvjdrHKIj872RmhmqUlbTRjklD/osPAVVsW1HKgH
         UM/4LLn45FKfqHCYbe/LLmDyNCxDxyc8r6iEXSzvKqeyGVgYFTt3/bOFUJNmA58bslWX
         1EKnhVky5wdnGKAkbz0ZxEc9JpZU0OSRlwZBAk0D/jYHj4nV+FFEB77OGRo1HE/Uot8y
         AQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ksB7Mq/FqLbd+Sev6Cc1mDEkREsoEBs0+8p9cxQqVYk=;
        b=DNeQvM4nBHRlt7A/iI+Vslr1w9IEhLzPlcK3DfA6R0GYaheE8+IhioS5XyRKlC8VKB
         ewZgkq9+/Tnbd6t356dcaFIB4vmmMYgVoK/hKh/Wpe9Q7EaswyBVeJLBhBCWZR/oSWkJ
         weyhQLxdBFLpHMoEBJMkHM4ukdmmOooTu0G1Dp2JGhS4ktEl0JSDbCd1nKC57D54r/bG
         KPBtjgYb91W2oTB6jt983PUdcml3YXiKHj9YFtQkrAzRVKqnkBs0XPd6H1NyMnQ1WS1+
         PXTZbMqa+AwhWn3gLKZMkqSNC5lijc48O2pLBEnoeJpdd2RsvahQtj8Fa20xTKkvK43/
         8t/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qIOJ++Pt;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qIOJ++Pt;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Popov <alex.popov@linux.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.16 18/72] i2c: dev: prevent ZERO_SIZE_PTR deref in i2cdev_ioctl_rdwr()
Date: Mon, 14 May 2018 08:48:35 +0200
Message-Id: <20180514064823.812684112@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421730689161322?=
X-GMAIL-MSGID: =?utf-8?q?1600421730689161322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Popov <alex.popov@linux.com>

commit 23a27722b5292ef0b27403c87a109feea8296a5c upstream.

i2cdev_ioctl_rdwr() allocates i2c_msg.buf using memdup_user(), which
returns ZERO_SIZE_PTR if i2c_msg.len is zero.

Currently i2cdev_ioctl_rdwr() always dereferences the buf pointer in case
of I2C_M_RD | I2C_M_RECV_LEN transfer. That causes a kernel oops in
case of zero len.

Let's check the len against zero before dereferencing buf pointer.

This issue was triggered by syzkaller.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
[wsa: use '< 1' instead of '!' for easier readability]
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -280,7 +280,7 @@ static noinline int i2cdev_ioctl_rdwr(st
 		 */
 		if (msgs[i].flags & I2C_M_RECV_LEN) {
 			if (!(msgs[i].flags & I2C_M_RD) ||
-			    msgs[i].buf[0] < 1 ||
+			    msgs[i].len < 1 || msgs[i].buf[0] < 1 ||
 			    msgs[i].len < msgs[i].buf[0] +
 					     I2C_SMBUS_BLOCK_MAX) {
 				res = -EINVAL;
