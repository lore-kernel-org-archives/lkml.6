Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx491L8irAuSdpp37xUfcFcew5R/LwMF8D9p20Bx0ahW2eTaRvxG7xv/q1kQTAtJqApo8oDMa
ARC-Seal: i=1; a=rsa-sha256; t=1523022265; cv=none;
        d=google.com; s=arc-20160816;
        b=jiPvyTKDeX7siq4Q7R8NvFAJZAEzvZCz8APkt1cq8WqIx45hHy5YE9faxv92Jh0Why
         D0FqHT3ibiecMzdDGR+IjhIDlCC5aNUKzECzJ3xO0AjpSYmiPmD8YQJixoKrRkAunGm6
         uTKTh0a4hgqvBXBNRoEjnBEQlKLJaK0NkrR89HqI/rAOzvPe6PD9P6fGAP0seLAfXWMs
         issIo+KJ5w1sdEvo5wI6XZ7jcuaB8Dg7oI+jMX5xa2VwUMwSKghlb5iWmxRu2rNL+dZr
         jCQHacfYFVOOILIvdE7PqMQcaN4kBaxsyMkQtBHQveZf2QshC2TyE9bT7410xp9+Eh0f
         FC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z30RjNytNubLe2MkaiT+udCDiNPbhTfpWS+bWZ/8w28=;
        b=TSJxm0Pw+vhkTuijakeOE/Q54ItmVhztY9FEBAos8p5flU/o+I1hVt91AWa1hhnthj
         TOPzeDuhbVXOoH7uh45BVudyUAG7j1ir6/0dZydbBY72YIWSQAqz5wOd6rujzOGbRcoU
         IWExXgKoQebPpieG7n0aivR3bNm3i6sRu6Oem+0LDokhaLDqtC4Q4rIk0Xf6J3WOueBB
         F8r+VDOeBJpfrUhhk6L0F1sGbnoruiAmRBY0Xb4FvUaAjx5sQZja0vfO0BRHQePcvHh2
         3t1YkmpybE2s4NEf6psVHp+3LeJyz0FrxCaff+KW8AtkkwiCH8b2ElbAIfra4CjiBp/c
         iTxA==
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
Subject: [PATCH 4.16 13/31] crypto: inside-secure - fix clock management
Date: Fri,  6 Apr 2018 15:24:38 +0200
Message-Id: <20180406084342.851641414@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004270588720627?=
X-GMAIL-MSGID: =?utf-8?q?1597004595937214313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -894,7 +894,7 @@ static int safexcel_probe(struct platfor
 		return PTR_ERR(priv->base);
 	}
 
-	priv->clk = of_clk_get(dev->of_node, 0);
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!IS_ERR(priv->clk)) {
 		ret = clk_prepare_enable(priv->clk);
 		if (ret) {
