Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoNuhN8pK9zNI8QmDO4mk5JostxP5NHdMwvB8va2UXyExAD1lywzNGh6DF/KU/x+U4gligA
ARC-Seal: i=1; a=rsa-sha256; t=1527155926; cv=none;
        d=google.com; s=arc-20160816;
        b=boilfa5Swe/cGd7aXUH/GaphUd/4LfkUJCx2Wkf+FjgjM0oBb9w2Res3M0lCnddCPT
         q3GEE0woYcpVoScII50mehV6UcW8WIkOJlacxvlnwMqre+alyloGD5PmGGxxMNnxJAF7
         RgdUrkoeKhTjnau1u6J8errSQ3TBYxhV6Tri90720VoAYbiZR9UB5EUbMZqI8YbAI53V
         6sd4H6Xtt0Cs0B6g0QL2RWC4wKhB0XCkd7g4d4Ies5RJ4MipoIs5SAYxD2XbUmr3+bQ+
         0gGZe2zqo4LGGr9620+ku0F1Nk9JulDMYpnrmYFgR9QiN5kSaMAA3VWSh/UhQmObb3+b
         r5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=KipF8YNp6rFV9QHJ4scMhPxNQTAWIeRNqvL8u4g5HLM=;
        b=ag96iyv6aT0aCMsLZG+QiR5/mKT8vqwAEwEjwHOR3Lkl9LjQnE2+1Dnm3uoAWJdmQT
         uxCJtpC2d0xHT7laqgJr6Wc4BPEKfnoKRfgAMmIvpJsbk1L3tNdIwUhyCOhe1Am/YcFZ
         HoFINXh2v5y7p+xBE2Wedew0CzY3zpB5LxmObqMBMA8MbT+Si2ms064Pu6ZXqo+mrJok
         pN/P1hHGZB9mRJpbWlbb5e8AsH4QcuymL2nVKNXXfvDrXbYiaz86rnipR8eXaouCMaH7
         btOZGiJ1vWCHAjUWMWjlKXfS4OfDN5pKESLWKu0Jf4Os18+NyDstIMZ6RWvGUpq5PmVC
         W2GA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QUYIv0dd;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QUYIv0dd;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 154/165] serial: imx: Fix out-of-bounds access through serial port index
Date: Thu, 24 May 2018 11:39:20 +0200
Message-Id: <20180524093628.309203405@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338558091886920?=
X-GMAIL-MSGID: =?utf-8?q?1601339052737597016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2096,6 +2096,12 @@ static int serial_imx_probe(struct platf
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
