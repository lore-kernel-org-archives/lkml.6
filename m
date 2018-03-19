Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs4chsHf21yiRFPlV5Se1W2KRKtwJSmKjzvm2ai7848MldQW2+nV45e5/vbzLYiIHaLV/r7
ARC-Seal: i=1; a=rsa-sha256; t=1521484063; cv=none;
        d=google.com; s=arc-20160816;
        b=gtXoKL+WwJahTyw5nEn5m+X8a4dcP440fuNIlob/4RmidRmS7Xow+UOSn44kY3C6GO
         m9heK5iVppPMH+kGdf1dbjXiLoF2EJD2jlpAG/kfVVvWjM6at/GrUm5rJ8WaGyo7EpH1
         oNxNlqTJWTBAbPzpFDkO3R6As19HY4wok1/KAi48oCPpnKGd5Xze7V3raET+7do59GPQ
         tB2Y7U8Z8sbz1RXlfbZthlQ7LxkUjcgcZbxUScAkdimaa8MeGBRkBwpsGmIVceBoeiM+
         aPCYbLse/pUEcME37qVYdeq3wcyOWc43Gx0UNkPN1AeN2IJ60kuSHZHFsNygowjVwqT8
         EkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4QHzFVY2NQqUl43oMM/vJmqtWaaXXzujAj7ObWgv1JE=;
        b=PsaYXGLbyJeSRxZVnrfOVDBokEQ6MBJaxL49imfFTLW/fK6NNx9GmqdStkeHnOjgHp
         TtZyo6I9dcOZt3PnsDDNauO6ueKbp6qcqwRTUyaE4nHgTWu+wWUcm8JgbE83WIQLiFT4
         HqQQwiCrIU1VH96Kk9mdtCZVS2I1S6Ddw6MQFig4oPMUW7ZuK0iYzAtbAo5l7zOmccbE
         eJ3QsJiG2U58jY0TprGesvF3KX+iGFVT/WtX6r6V8fRe3HyfQbsl6Ldeom+QGC7+ZGU0
         LNCj2eRvbkMd5H3NfvirUlYYTWajf+Kb/uWDHXzFbllQcAeNggjQ56U8fH/z0hUSXb3V
         iVRw==
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
Subject: [PATCH 4.9 183/241] power: supply: ab8500_charger: Bail out in case of error in ab8500_charger_init_hw_registers()
Date: Mon, 19 Mar 2018 19:07:28 +0100
Message-Id: <20180319180758.722055266@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391673878383494?=
X-GMAIL-MSGID: =?utf-8?q?1595391673878383494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
