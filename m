Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224fz3nxWBaXASaOXUi0Z2JvZInH8Fv9RUJVGbxpK1dZJKqMS/PNCkKBnOgBWWmZkoZtDc7s
ARC-Seal: i=1; a=rsa-sha256; t=1518709048; cv=none;
        d=google.com; s=arc-20160816;
        b=g1shMhCni2hzg354aYs69HH1RtEfY+1Xel7KnEAs4ZIKtwQyeyszQfpTw6kD1nJF/9
         rMgZAOC45zqMMaS2eozWTWg8eN0BmGGXeLxtfIv25X6hr3JyUjgUCsXt77xzrPUFGJ6T
         A1nu3+eZqqga+1VssiMosUE24zlNGyDD/pcXyiR9JFLeJIAUvK7tiqifNnWH9onCYkJg
         Sk8zLtHCKp71X6wVYhxyDbjF23k8VXN6l+Rq6a25CbD2z7BVKkL3AAUY+X2wm6A8YdwO
         Ch4IWl0M/hnre5TNSseDrfcJrHFjZfQKEBtQidVOCs2TgcSCaZhAMNbXEXO1GwXCJuvB
         FUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pWDFPLGUSLlt/McvZuUvQdye7MW3Y6oXxQQnm5NSi4I=;
        b=oFsxYk5b6J2zmbdYOD9wwnuFR3+PVHZtB2cb9f9QS9eF+/9qIp7UNWAxEnYP3OAYqs
         3A/hXKrpQ/X8Ri2seezEK/APS5sxLWJGl8VQ4krrRphLl0AtfgDbiQ03qUMbTGPwnNvM
         sMf6pKaOi19gyOACLCxnGVqAOt2cHKLsTqCb5AS5Bu/+jwKOLO5lSfuqnoJLstvXXmXc
         QommV9NfmSFmTlUhTKElI3eTlwburs+QRlc1n5G1aCtcEL/H6rkIBP13DC1UssqzbF2Z
         Tynb+cyYBHBu7xRv2IAMg2bDL3JMuLFmYoUeH+6OcZ02V62/7c3ha17CIP/JjvW46BNQ
         7SNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Rosin <peda@axentia.se>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 173/195] pinctrl: sx150x: Unregister the pinctrl on release
Date: Thu, 15 Feb 2018 16:17:44 +0100
Message-Id: <20180215151714.706772491@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481858598468107?=
X-GMAIL-MSGID: =?utf-8?q?1592481858598468107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Rosin <peda@axentia.se>

commit 0657cb50b5a75abd92956028727dc255d690a4a6 upstream.

There is no matching call to pinctrl_unregister, so switch to the
managed devm_pinctrl_register to clean up properly when done.

Fixes: 9e80f9064e73 ("pinctrl: Add SX150X GPIO Extender Pinctrl Driver")
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-sx150x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1225,7 +1225,7 @@ static int sx150x_probe(struct i2c_clien
 	pctl->pinctrl_desc.npins = pctl->data->npins;
 	pctl->pinctrl_desc.owner = THIS_MODULE;
 
-	pctl->pctldev = pinctrl_register(&pctl->pinctrl_desc, dev, pctl);
+	pctl->pctldev = devm_pinctrl_register(dev, &pctl->pinctrl_desc, pctl);
 	if (IS_ERR(pctl->pctldev)) {
 		dev_err(dev, "Failed to register pinctrl device\n");
 		return PTR_ERR(pctl->pctldev);
