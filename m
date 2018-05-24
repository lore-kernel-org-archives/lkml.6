Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqYbASpwWHauIGBISqXj3TDRTNIFyn4jiUzUcq7WUtOC6njTlu852oAl8bB4+ZxTQW3n0vt
ARC-Seal: i=1; a=rsa-sha256; t=1527156335; cv=none;
        d=google.com; s=arc-20160816;
        b=E4BZm2fIxA0dBO/bi2K67SLnuvrWPo9SweP5s4prbPLGj2xDGbGGDn9Zo/CgtgVdhd
         SODmaC8dJd8tS+sHMhsVfMIKPRAkcT4lLNvbmg0BvYgivTvvNQEyUFD+LlnQLRRmUhcb
         5ZULpeNdmqb7h4TcggvIhFt0qUjzXFcy9i+ouV2I3sb8PAG/Qj8sPVe6QnnwP9uw0vF2
         fBOKasHbtJRrIC5TPLDX5yczsg1XiI85TkBtI8To5LpqZOwk5qrByx7CbDQwFDbHdgPg
         6SfCJb3aFA38B/AAgQgRCGPEZSmzEe2a8hRYHKEveOeyyUFIspCxS7w7Uk2s3IFtyP04
         tcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0KsWjb3j9e4oEy2g0NLEHqoIm6lIsD46PhW76CJb3G8=;
        b=AGZZBW1U+iL5L/dXjBhYs+yb33Dl3bQnfbuZWg1qutIT3u9Hdxqnxqqe1fZGMEVfcC
         9AinKJduw4QBGnXv61kyKghjF41+WzNf03Q2xUcjCixN4YpPpmeXiauof1kQ+H0Ly+Dg
         P3bRjfYs/qS37Cc5+vEJx4lZw2TsZl7wMppz89+gL6db6YRE8h3mQkzG6KvmIT4tawgn
         9ULG2LqbU6Xt28nxX+bLYSjXPQjVfunnvFEOsrFpS0e6QzlNe0/X4jH377bCzwAotn/x
         e02RBg7w84AO7KkSMgvJSyU9aBuE8Ajckix5nxqIcS37gk1QgiLSOYGKfB4QJIO1ZfLG
         4Ykg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GY+qfwvC;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GY+qfwvC;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 150/161] serial: imx: Fix out-of-bounds access through serial port index
Date: Thu, 24 May 2018 11:39:35 +0200
Message-Id: <20180524093036.261858573@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338558091886920?=
X-GMAIL-MSGID: =?utf-8?q?1601339481530193793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 5673444821406dda5fc25e4b52aca419f8065a19 ]

The imx_ports[] array is indexed using a value derived from the
"serialN" alias in DT, or from platform data, which may lead to an
out-of-bounds access.

Fix this by adding a range check.

Fixes: ff05967a07225ab6 ("serial/imx: add of_alias_get_id() reference back")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/imx.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2042,6 +2042,12 @@ static int serial_imx_probe(struct platf
 	else if (ret < 0)
 		return ret;
 
+	if (sport->port.line >= ARRAY_SIZE(imx_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n",
+			sport->port.line);
+		return -EINVAL;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
