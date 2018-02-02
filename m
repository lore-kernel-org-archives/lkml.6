Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227XDrpNZmt9ZJgeTo7CqDvm7QTp6rLvDkCdP0inGf/6P2JhK5IaL/svGDSpDI8NNEVVyDvl
ARC-Seal: i=1; a=rsa-sha256; t=1517591793; cv=none;
        d=google.com; s=arc-20160816;
        b=j7rigr9Dpyc5hWW6itliavYQbcaDcNwUi5O9vxmgdA+oouTCfqUG+e4EyyWjuTEAVM
         k/ikeIAET/X3moW0kvvBpco80PiwG3/EfLaSfWsGIlZMxXijaHE0Nw7+Iw8P4YuysgMx
         eNp6aiNajVBhkXi8CWGT0iyrW3dh3+El4tBMvk6piXt0n/UgQ5ZO7jP6VHE1Dj1s11fn
         5N4FYrZiAn3b1MFArBMyy7ExnpRZFcPuuJ9n7fLLFNHWaqOaDucGqG0qq+HOLTxT70Mk
         ZrC5JZrpU9/oEaujbYnSyjLz35f8l7B/sn30y8XK2cbNXvMWo40lPS0aDdQkDXC1vK+5
         lCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A6g9HqBGDIKeJqnB0Hw7/nsofhTFUX+VEV5T+oqjul8=;
        b=ACNcHquVoVVzXlsxFAgRLvnnGyUXvKCkWECzivT+VVCKXRB0VOwevT4mzcrm64A368
         l89ptv1b4YICWq0BwjsLlhcN9KYpghU3rsVy6TWuZoJPoZWn1mJwkjSA4x8AT9JlEbw2
         xL3f+4DrSxHoS/OEqN6xe5zAEqT1L4T9vLqLSUY8vNas3lGqdI6uWSRg9ESOyke8/xCU
         N/XFqqz+h249zPL3HYOsng0ppbp8Or/h/+sNaFxNitCdZHN9ryT9UIbrsboT+l9mmPiQ
         NIVKDKBpA8O8Ng7GJ8hhT6cJjAWzOlmmycr3GSHqUXSZ/qD3kmjp6wk4G96lAaQMtSH5
         Sbew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 4.15 45/55] serial: 8250_of: fix return code when probe function fails to get reset
Date: Fri,  2 Feb 2018 17:59:03 +0100
Message-Id: <20180202140830.468435242@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310184137013467?=
X-GMAIL-MSGID: =?utf-8?q?1591310332895674290?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit b9820a31691b771db37afe2054dd3d3a680c1eed upstream.

The error pointer from devm_reset_control_get_optional_shared() is
not propagated.

One of the most common problem scenarios is it returns -EPROBE_DEFER
when the reset controller has not probed yet.  In this case, the
probe of the reset consumer should be deferred.

Fixes: e2860e1f62f2 ("serial: 8250_of: Add reset support")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_of.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -136,8 +136,11 @@ static int of_platform_serial_setup(stru
 	}
 
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
-	if (IS_ERR(info->rst))
+	if (IS_ERR(info->rst)) {
+		ret = PTR_ERR(info->rst);
 		goto err_dispose;
+	}
+
 	ret = reset_control_deassert(info->rst);
 	if (ret)
 		goto err_dispose;
