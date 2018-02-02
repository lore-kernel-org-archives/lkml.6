Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227sRPV59a+VTpoiNmYl7Vt0f8hWdu53ThEzTRoWbTMD+iEcp/zXXrdo2bYGMfNggk6a2REG
ARC-Seal: i=1; a=rsa-sha256; t=1517591652; cv=none;
        d=google.com; s=arc-20160816;
        b=V4Sk6Q+omPsbK5T8DEja+B7j93ZNwaZqsSqeL+vC980hLpMgroNBSfkHf6mf6yrHdy
         OortwkrnC20omAPk3Oi2KK5byLPj18GVCXuAnNpXMt3uhS7/rBzV5q0j0BFvl6Ycqz3t
         RYTReXM2o9BA/u8xCFSlVSv016EF2fdwzw743T/Crgd4UeKHZobbP08QdTJh8PfRwe4I
         lptEVD18QkHREpqryJK4bqN4b49PWD1DKwVC2xPdiYZu3D7XBd7DnOzJomE3qDeCs1+A
         lP+MCDlL/PproiYz7Jz3W2PlRPMX4RrWh8YUyxcwM/fIPYiAFF6TAMR/1pDErfGAOX04
         9oUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E2mQZQb4e+e16/6HPaj8xSmCkvghd0wluj3kJCOba1k=;
        b=EnTNaGp3ccmTJ7ATBCZgDLjHhX7+P6oVPTopkwxmZYH3xgom4r0cBXrbWCaALTbgdB
         a6JyI1jVMYARwV+nFdCHfxjuWiJE2DbjI8wU9mGz/RBE5Ege1RuFDr3lRk0UB7bkxp25
         KY+6qgahsiCpf4GdM0F+vwqnANnRzu5GxKCy6OhcJXZrTqGA23wfqKlXvk180SDcojX7
         Ls047eDlEtN0f8PYiVSlAMV/tWuyZHxtanAliBYHcVJW1XU5En9ut7TO5q+X6g7TJNXv
         8MhWqog/ve7+bL0IQIiLR8NzfR2Kvh7fPlz3G+lGdWA0HU9b15auoaZF784HvyBhluKQ
         XrPg==
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
Subject: [PATCH 4.14 147/156] serial: 8250_of: fix return code when probe function fails to get reset
Date: Fri,  2 Feb 2018 17:58:48 +0100
Message-Id: <20180202140847.021774034@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310184137013467?=
X-GMAIL-MSGID: =?utf-8?q?1591310184137013467?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -141,8 +141,11 @@ static int of_platform_serial_setup(stru
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
