Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225r64EqexCOmx3n/IUwGRXjyu4hWh+rIm6jMGLmexIwm4dOSJ6qnaV0M6Jc8gVUBvn3kgSA
ARC-Seal: i=1; a=rsa-sha256; t=1518709053; cv=none;
        d=google.com; s=arc-20160816;
        b=XiYRTFDq83ESLL8ORZZagT1vejyKMjYIW4YAP5jRiLKa62ZwWakpuxSMcKOVJorX8F
         0WFWzGYcLol+nYDZdbA5EQhaZSfxThgo7O1VsRK14eigyulWGTf3+2ZHbeRUEI6/AkgS
         fpRfQCl+NRSFlEZZgHjc+6zdebHnnBjTN8onWOs+ILHw4xeZzFgNGcosuIk5XHh1h9fS
         RNPii+CqdEX839gBAc/wSigD0zUGuNmyhQSmulAh/qPBHpRRaVA+TKST9F7+6PRiWZIH
         mz9A9vOjXB91mDSIycFd+CbbllyaiVymtPHiTH49iAFi6tY5pDPLr05jLGt7E6At/3nQ
         ORtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=16eyD/3bOAqoA0VMu0jRFDV1G5aVQL/IcFCbt2oypY8=;
        b=AC1On9nQCADeWiW9UlO7WL5GXJz0qWuzAJJdPCBgzz7390XMVs1idTdNb3YFETvZ+I
         TfBdkuiVsXLUek57iwqVy8elqU2MNL0lBpIAhzbe/+WugqzmDJ62cIUDX4rsJjY8LIlH
         l9e8rQjz/cmQhE/t4QilEyqhe82EfHla4L2wDU8L1oXvS/vrz0b/pMVI8ef3NYcvyJPk
         CIW7m0R6Tg4b5O2Df9t6Wz70MdcwJT+Ep+S8Jd+YyxicgQl844Rk2BJJjeLhD12s/f+V
         x4kH01YkV6Cp7dgWq6YUI/M3T+sSzPLgcgacB+Qrv/vSrEbToctS+w9FSdW7Cf9NcMvs
         Jpkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Peter Rosin <peda@axentia.se>
Subject: [PATCH 4.14 175/195] pinctrl: sx150x: Add a static gpio/pinctrl pin range mapping
Date: Thu, 15 Feb 2018 16:17:46 +0100
Message-Id: <20180215151714.816225428@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481863904165472?=
X-GMAIL-MSGID: =?utf-8?q?1592481863904165472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Rosin <peda@axentia.se>

commit b930151e5b55a0e62a3aad06876de891ac980471 upstream.

Without such a range, gpiolib fails with -EPROBE_DEFER, pending the
addition of the range. So, without a range, gpiolib will keep
deferring indefinitely.

Fixes: 9e80f9064e73 ("pinctrl: Add SX150X GPIO Extender Pinctrl Driver")
Fixes: e10f72bf4b3e ("gpio: gpiolib: Generalise state persistence beyond sleep")
Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-sx150x.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1193,6 +1193,11 @@ static int sx150x_probe(struct i2c_clien
 	if (ret)
 		return ret;
 
+	ret = gpiochip_add_pin_range(&pctl->gpio, dev_name(dev),
+				     0, 0, pctl->data->npins);
+	if (ret)
+		return ret;
+
 	/* Add Interrupt support if an irq is specified */
 	if (client->irq > 0) {
 		pctl->irq_chip.name = devm_kstrdup(dev, client->name,
