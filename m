Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/NaGiC7Ckwbkr8Icm2nJ6en0hD95i0uoaOsqz2QDpKtkqaDLM3/sWM1kG336e/h0GUNUBV
ARC-Seal: i=1; a=rsa-sha256; t=1523021955; cv=none;
        d=google.com; s=arc-20160816;
        b=KeAf9Dr4Y6WsK5YtJ/wYK+qOzdZC7CsI8q7tbw5aO9/MCm+Ga6Eit/PF7OYZRHbRWZ
         B31TnG0MIcAsFbpsgUM9jayIHnPdJx7MqZstMse0aGWO1fiAbDjG/4gaHOFL2dqfZspI
         J9nra0WAJNNkPgpRlNReOTFZExu7yTLf+kbKJ5sIGln5NKltnM7EJDv+tMwG+95Yx6Cw
         e89gZ4N3024I0NWj2aGxataM0agkm/uKKl10j3ZZ5iBAB9QaBDxxZsIiySRfJ5q1p/hg
         zxTTPeWJBSZa10KctkrSG+1OLrGwZeNGnz8q3U47YqohTK7E4Zm3JZmkWDgiuqfBqCgc
         skSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m9U4Y33q7dXu07VJ3kTzUX6SoLJkoeBBaxDr4rkyolk=;
        b=DBp1DTgpqpIDKAbqQivLjKnjzGO3bSJaVES0+TPLgFtkmkJfG8iwEbBYWor+g/kvcC
         wY6fLKPG1meEoWrc5E3JJvrIFtRDJ9VfJu7+HtRq66+0gpJp2hTbesX8X7E9grdSVeMj
         JdawEnT1QeAN78JT1U/LL9sXBt30MfWguOPT6vJPehLN3akmKD/AG3jNVNPj42gm36YQ
         YZbeD+XpefNb5bAYJGBtYoU+lOn7i/N51HKin46ryX58BktNxEED4fw/odct4MWUJ4Xg
         bO4gKMcBT12TrAh9zZLgA9CvTMvaQQVqltuR2gKmARoee+CQIJCDyF3cyKQrPa34NHOi
         N2LQ==
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
Subject: [PATCH 4.14 47/67] crypto: inside-secure - fix clock management
Date: Fri,  6 Apr 2018 15:24:17 +0200
Message-Id: <20180406084347.438770647@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004270588720627?=
X-GMAIL-MSGID: =?utf-8?q?1597004270588720627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
