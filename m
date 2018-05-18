Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpMkvh789+FyJRORxtmAntQWZlLbgbI9zAmCn8Gix1rn11UhAXmBHMClRxDpdBrDRVBO9/h
ARC-Seal: i=1; a=rsa-sha256; t=1526631751; cv=none;
        d=google.com; s=arc-20160816;
        b=nJflq7w7Tuwq/t4H6D/bUHm4PfIULdUE3q2F7/Ymjjb9Tyrli4atO8bearlhgVuZPZ
         yJkuKnXAJkbzSRhux9rF6Nk2QtldlUvsj86TExR0ZnLSdBksH7aJip+kV8j0L9U2PIiq
         W52YEXhQiVJ8NFJr/WGrKBTfdlSotJ7vasMbZOFkxgWzZMemOijrxKtL0YYusbrNwDIM
         17Hvo7tNl2XmldCdwz+AldzGGviJvD6QuK7eUU4T6eyrP7xq1oiTwJ9ecRq59lnZ1owT
         qhgxx2nqSvZ7D+tJCPgNY/oJeMLOgr1lH2PaIT2saYzBmOdMjG60zOAIn5+IxGWcdNHv
         M8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Gw2it0bKRUVFgmb2qGWJDwEstZUZ097HlgGx0TsO6FM=;
        b=jCZodeMMWGhDRk91/02c92RAQw+oEjN3O6TysWnq4p/SKpT2JwcVXC/0bkqo1f0FCF
         G5SadSq59GZfr85ycM8837WY6Xhpghlt3bWuIqyHb8APb93HcBM7o6tRop6rvwUcO34H
         oA3p4NbLZ9WXiUbquSGvOBRAwt0814TAZXnNlLGDBsSk2++gPowdBR7S4zso3OhrYejN
         K6/M/+r+gbExmhPmQjYcQMDsN1mk23GQI5rd3ib1nbQB0Yr8jDNqK/c0uX9meXmZtJBQ
         uxKsd37IYsYkbCm6mV20GU7JstoOO3IGo4LLk8MnbeUbfD0+qHoSX/bPr5y8KTaKWwHg
         zqhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iY/DN5wv;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iY/DN5wv;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 26/33] serial: sccnxp: Fix error handling in sccnxp_probe()
Date: Fri, 18 May 2018 10:16:05 +0200
Message-Id: <20180518081536.129606967@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789415588343883?=
X-GMAIL-MSGID: =?utf-8?q?1600789415588343883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

commit c91261437985d481c472639d4397931d77f5d4e9 upstream.

sccnxp_probe() returns result of regulator_disable() that may lead
to returning zero, while device is not properly initialized.
Also the driver enables clocks, but it does not disable it.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sccnxp.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -889,7 +889,16 @@ static int sccnxp_probe(struct platform_
 			goto err_out;
 		uartclk = 0;
 	} else {
-		clk_prepare_enable(clk);
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			goto err_out;
+
+		ret = devm_add_action_or_reset(&pdev->dev,
+				(void(*)(void *))clk_disable_unprepare,
+				clk);
+		if (ret)
+			goto err_out;
+
 		uartclk = clk_get_rate(clk);
 	}
 
@@ -988,7 +997,7 @@ static int sccnxp_probe(struct platform_
 	uart_unregister_driver(&s->uart);
 err_out:
 	if (!IS_ERR(s->regulator))
-		return regulator_disable(s->regulator);
+		regulator_disable(s->regulator);
 
 	return ret;
 }
