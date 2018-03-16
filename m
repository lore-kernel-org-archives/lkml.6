Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvR5ywwFPStbnYaT4ml16JXgJHSPWvtEnU9DMUX9yNd0e5GejSVMjpq3MkbxccFKVTmWaZS
ARC-Seal: i=1; a=rsa-sha256; t=1521214943; cv=none;
        d=google.com; s=arc-20160816;
        b=C6OQqbx9Jc9+Xc3auT0y444YeldBb4tsU1aXKXRhKeN1TICUunkH5hGTBPvweHarQW
         X6yAl1PVMW9Xsw/B1vhwp8C5A6vMX73j12J79hxIX2rwFiwV4aOFplUL1F/q8ae216ST
         JersOYYKNEBFA4bThcDDMtFB7w0ibzbwqrZMjXlS4RKacZ9fogfUOPklxG6UUZs1Xc6C
         vBurCXpOFZDVJGNTeCXa/tKSZTUCJcJ8aUA/MdJpCpQtB0AN12CHqVHCBeQTzEL6MIcH
         Duf1p5BT0dPyec5N8tMBJ0OeoSjAVN452ehJNWOApZ/rpK/dhHbbetP7VyUMqrYjwllJ
         zoag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JfM1zW7m2Ie126FqldR6xJlRe9zRTUX6GIbMLpCq1ik=;
        b=gp0MKtjp4gVhNMqhtNrkbQRJwZDHjKlnDtx+cfLUG3Y/1GTXUqP+d+JMRlys/7caHr
         C3HiR4MGpHqW92Bzc7XTwBG6nRPW2+0Qs2s6DssVebOOnQgjtIR3i4SDq7nyKNqxzYts
         6lFaz53hiQt8FWU8r09ox16JAeqn4Y6yBNgEcoHwYTnoWWlMd5YXWsGBfzslXObt+mrv
         PSXn2nsTsW8Rr8AjW+e3ORnKG7jPThXDtBrJ+FJx5KzIgsa5EhyN3L+ohSYMOjJdIEy4
         93NlLVVVv0e4umeA6I4YZUwhlLDyWhvVzPS32z/ZMS14MwQ4I4qewZkaHiIBNiDmQfSK
         9B6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 071/128] power: supply: ab8500_charger: Bail out in case of error in ab8500_charger_init_hw_registers()
Date: Fri, 16 Mar 2018 16:23:32 +0100
Message-Id: <20180316152340.254833015@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109109307642633?=
X-GMAIL-MSGID: =?utf-8?q?1595109480013532936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 09edcb647542487864e23aa8d2ef26be3e08978a ]

If an error occurs when we enable the backup battery charging, we should
go through the error handling path directly.

Before commit db43e6c473b5 ("ab8500-bm: Add usb power path support") this
was the case, but this commit has added some code between the last test and
the 'out' label.
So, in case of error, this added code is executed and the error may be
silently ignored.

Fix it by adding the missing 'goto out', as done in all other error
handling paths.

Fixes: db43e6c473b5 ("ab8500-bm: Add usb power path support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/ab8500_charger.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3221,8 +3221,10 @@ static int ab8500_charger_init_hw_regist
 	ret = abx500_mask_and_set_register_interruptible(di->dev,
 		AB8500_RTC, AB8500_RTC_CTRL_REG,
 		RTC_BUP_CH_ENA, RTC_BUP_CH_ENA);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(di->dev, "%s mask and set failed\n", __func__);
+		goto out;
+	}
 
 	if (is_ab8540(di->parent)) {
 		ret = abx500_mask_and_set_register_interruptible(di->dev,
