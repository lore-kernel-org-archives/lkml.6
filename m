Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226SyOVTFHsgNHxv7BDTjFJ0igkm8I5EzzTnDVVuHJaBKtpQLnGOTdfkDtHXz4KRC7boQGmx
ARC-Seal: i=1; a=rsa-sha256; t=1518709050; cv=none;
        d=google.com; s=arc-20160816;
        b=Mn95FDrsPOkesyHfOj0wuejoREC/rB5WWTym/YmfWj8VEhM/F0AqyFRqDkWZZLXSKb
         2e+w9v320KGtWWbb/OMRoh5xqu4y44IkkWdijnGRRUWqhzguY2Ej4FwrX5yoGFYOMmzs
         krQDlYMe9qUpIrouf7B/XA8YcTwmr18Qw/Sz2So/TdmuRbLx2wQOUdmPltcVa/HPgClI
         UJiQDx6G+L12AnhGFC+h0V6hlFWAGRXCSLOfuagEf5uvRXZJzJO5EdZn9UnSZPDoHBzW
         Z4T5zTUZDVWvyTwxjufWGn1xj5pXZGsG8vgGPxjiDbGSvpstlpq9osSZlFDHmguCM3M3
         FOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BlGzE9pT3kQ2F1Fnz+Y02L6/Q0MAKb8Xf4XZn/L39zw=;
        b=airfvdqzWXQQoJjxBzLoLXFRvOFa37PGgoJ5rG40UHR8dRPKNBhC/L3J+Ff4VpUMEe
         f90p1EucHeY2ho2GbzmKQ5raYOU+ZYpfF96IGY3Pb5DZL/laLYr9446p3nyKjIRTysIU
         nPV3Ny8y9x1nT5cZou4IYHeapxBPGyJ9BU3gd1vE5iq7nzi4hTvFDOGyzhny+/Oxhy4y
         wfIQO8eZJxouEGzhNbmUDuW19VAoFF7FLMMq9yt+O8nndspFgNDalyD140GKrA0DqYnm
         rb95X2oqhVRpSAO9AvPpCoAXg30pJp9OcHrPjZ2QchScegNBd5HjmEwPEsLHc4Ql+A9I
         73qA==
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
Subject: [PATCH 4.14 174/195] pinctrl: sx150x: Register pinctrl before adding the gpiochip
Date: Thu, 15 Feb 2018 16:17:45 +0100
Message-Id: <20180215151714.764629591@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481861331149685?=
X-GMAIL-MSGID: =?utf-8?q?1592481861331149685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Rosin <peda@axentia.se>

commit 1a1d39e1b8dd1d0f92a79da4fcc1ab0be3ae9bfc upstream.

Various gpiolib activity depend on the pinctrl to be up and kicking.
Therefore, register the pinctrl before adding a gpiochip.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-sx150x.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1144,6 +1144,27 @@ static int sx150x_probe(struct i2c_clien
 	if (ret)
 		return ret;
 
+	/* Pinctrl_desc */
+	pctl->pinctrl_desc.name = "sx150x-pinctrl";
+	pctl->pinctrl_desc.pctlops = &sx150x_pinctrl_ops;
+	pctl->pinctrl_desc.confops = &sx150x_pinconf_ops;
+	pctl->pinctrl_desc.pins = pctl->data->pins;
+	pctl->pinctrl_desc.npins = pctl->data->npins;
+	pctl->pinctrl_desc.owner = THIS_MODULE;
+
+	ret = devm_pinctrl_register_and_init(dev, &pctl->pinctrl_desc,
+					     pctl, &pctl->pctldev);
+	if (ret) {
+		dev_err(dev, "Failed to register pinctrl device\n");
+		return ret;
+	}
+
+	ret = pinctrl_enable(pctl->pctldev);
+	if (ret) {
+		dev_err(dev, "Failed to enable pinctrl device\n");
+		return ret;
+	}
+
 	/* Register GPIO controller */
 	pctl->gpio.label = devm_kstrdup(dev, client->name, GFP_KERNEL);
 	pctl->gpio.base = -1;
@@ -1217,20 +1238,6 @@ static int sx150x_probe(struct i2c_clien
 					    client->irq);
 	}
 
-	/* Pinctrl_desc */
-	pctl->pinctrl_desc.name = "sx150x-pinctrl";
-	pctl->pinctrl_desc.pctlops = &sx150x_pinctrl_ops;
-	pctl->pinctrl_desc.confops = &sx150x_pinconf_ops;
-	pctl->pinctrl_desc.pins = pctl->data->pins;
-	pctl->pinctrl_desc.npins = pctl->data->npins;
-	pctl->pinctrl_desc.owner = THIS_MODULE;
-
-	pctl->pctldev = devm_pinctrl_register(dev, &pctl->pinctrl_desc, pctl);
-	if (IS_ERR(pctl->pctldev)) {
-		dev_err(dev, "Failed to register pinctrl device\n");
-		return PTR_ERR(pctl->pctldev);
-	}
-
 	return 0;
 }
 
