Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ICdr6CZTdDHc8zg4CpXNhzVBqRxIphzSXabeIQSOnGhzGnyrzxIEYd0V3fzHTpxioNhdR
ARC-Seal: i=1; a=rsa-sha256; t=1523022192; cv=none;
        d=google.com; s=arc-20160816;
        b=QqgZqMUlYuaTnTz0V+BT21R5VfdodyiBjAk7fQQbkRq/WUiXkO9SQHH5pw+nf1s0IQ
         TMC2dSWi7ul3GYhaZU0RpYnbvAN8mnClSb60/rYEoIYHnWeP27jJwYprNdAof6sPVz/n
         R6elOr7zmbPN0njw+LIANt1nI4EQZS9kVXuzXiYz5KcmCcbxegMgAnXltHJbo1Dsx3Pi
         ne7e4BqrKIeE2+xIWyt3mG/56fkjtv6Q9vGGB3cQmXRjgmrygSG1FYRCdJSne82Tcsg2
         sOPwoUvdyvR4C6hjTsw067EWY1eehmcE+Xw6lNtjuZLzUPqYT5Cmd1zrlpDERrTEqM7p
         wLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iICVaNRA/ocvaLRfXhE8yiCMA3dEJ0ZEoVKMydcncOo=;
        b=fjGhX3s9bTsioDNrR5tFpr0L8PZJ0ANXGnRtOIozgobmcZrGFlKtYJmlIZrs/2QFgI
         uXEh2/KBQz1WKl5NjlYmGklREwLa27pQZCKjo0OcU8xSYrT0U6RHAp6muzd7AD2jqVIe
         rYUseqeVWWvSI2uwZ2jDyyIYiNMiXKXUkzt3UorLqsziaKzfgbhVfRK3YTwdeFtr/S1Q
         g8S2vmTGQyOKjLl1Erte5LqJTlTLOLY9NNM17aMjjduKp8dSz15/eub9QkGHdDR9Nhnm
         liT3bCdMDqPkQBKWpT+Zpn1WqST4PKrz9pO8gTgNDoIj/iOnHikiqf0e4zhnKcx3GHwG
         Uv3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 51/72] crypto: inside-secure - fix clock management
Date: Fri,  6 Apr 2018 15:24:26 +0200
Message-Id: <20180406084353.029795884@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004270588720627?=
X-GMAIL-MSGID: =?utf-8?q?1597004518537308455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregory CLEMENT <gregory.clement@bootlin.com>

commit f962eb46e7a9b98a58d2483f5eb216e738fec732 upstream.

In this driver the clock is got but never put when the driver is removed
or if there is an error in the probe.

Using the managed version of clk_get() allows to let the kernel take care
of it.

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto
engine driver")
cc: stable@vger.kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/inside-secure/safexcel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -789,7 +789,7 @@ static int safexcel_probe(struct platfor
 		return PTR_ERR(priv->base);
 	}
 
-	priv->clk = of_clk_get(dev->of_node, 0);
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!IS_ERR(priv->clk)) {
 		ret = clk_prepare_enable(priv->clk);
 		if (ret) {
