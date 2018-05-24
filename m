Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqFvc3wIVIwceg2S3DN7lg+Z8FkhCZaZ7x67eAI2wv3a1jpog2dPXKAS0wIkWo2BS3j9mJc
ARC-Seal: i=1; a=rsa-sha256; t=1527155454; cv=none;
        d=google.com; s=arc-20160816;
        b=tsixMZNrrmd7f2NsHkLQFIc7jqL4z6B2yUJ1TekeU/UoRe26nJ/hVTkyhTVDuiNyyK
         HReEY3gIdS4aFz1PY/IPomNIet2SIz3UR6LAi2uf6bGsQnEQ4YJcmSBwqV21/7q16hxG
         sdf9CpydQQ/AKhxq+2AC2AEAai1/TYYinonUSHJB5ESPbz7YOOE1WCknLEJ/tylP4RDz
         DFtZYXmyAHDm9b149CMNjJJybLk8a0BgIJG2hLgO3+V1EjkgRc3AtnWhFpTPkdgqc+56
         cetDGonYEeszR43PtYJlv1HIz8Mr/CYY/sABGfYCj5SsudzzStm5nBDfr7Fb2W+aTSJE
         LT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/aBW6sZ7VXygnWCCWkNK85QhY6J/exESTdnQdIzd82w=;
        b=Sd7GkG04Y+i3mFa1rNFueli9hGxq1EWGrdTquwuprfrGt22iTPouPiyWGEHZH54hhd
         H8CFS7ndeRY4F94tKCgMEBKe0g2Jm7yU8GfnwE8CrU+7Dx6yadLGRJGX+TT50t+Vl1Dh
         kdcABFIeWUapR7jHZxQqYKOE9ip32gTyLelF1yetDu73wybrTieLwK40BMotSwDSYCjv
         68sZByNeSK4BPx/c+P8LDpS6IkIsG9Wph4/IwLMlp2dM+EnrrmirJaXPDw3LMNf3oL/y
         29F4zBGdIQCexvGbP8bscW2P7yEI7dfLKmRKgknztEsCbx0zCeoBPoT9nmT3QJgCbBOH
         HaTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DmLWtaQ5;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DmLWtaQ5;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 90/96] serial: imx: Fix out-of-bounds access through serial port index
Date: Thu, 24 May 2018 11:39:13 +0200
Message-Id: <20180524093610.829108429@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338558091886920?=
X-GMAIL-MSGID: =?utf-8?q?1601338558091886920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2080,6 +2080,12 @@ static int serial_imx_probe(struct platf
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
