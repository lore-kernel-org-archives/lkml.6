Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49BQNeqOWg0JJVVpBNbEcaxeekSCGOTmEh59reuv3lr9s3OLxs+DC6kx45CE+h2mbqbMD9U
ARC-Seal: i=1; a=rsa-sha256; t=1523981452; cv=none;
        d=google.com; s=arc-20160816;
        b=dalLuGdjNYtaJjRfPifuionxy9lB/2RrRmlOQBE9euA8Ceqh62wXgjJ3xzJEjmOCw1
         sKaHcNboCv915AURIs/RxlLh0YiHRavnliVG4/Cpzcr1ve51WbEunJUhnW09L1eCJc3F
         AGDXCkCp92B7OUgxFN91r1B+w7goHBleQcYgmdB5RLRczic+C7xGZo5vG4qffdvWMBMl
         NC7I8MTF/0qwwO9HO2q3fDeB0Jm3rI0pBexDkb1eqyJRxE0fdix7QoLLGKJHlmzs3Nf+
         tLOk8QcMgmnSGwK56bzhMQ0TVz+qcoWnrBJwxhiM2VXO1rx5SoPvMZP8T8SSSXoqRsE5
         xDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fzcqnZq16Adhu6u7mHSUZEpqnsJFemZAhg5YgDaYJpQ=;
        b=QXiCHk6QnhK+Z2CK2pyzzGVgO0EHrqovHsFTIG+zbPyYu0yCIx7nekoixJDUaLg4B8
         vxydw076B3QeW4UHv9umujZC4qS08d7IU/6qCPWGEahE9xYMxw3h5vskGdsBDGtVQAwu
         CYpgjf2FaojLxXxQuzeUkUoiv/cQ2awBz2GecSSYYoL37N7BO2iGg5Xpv9BLpW5NPdq2
         6qDmzrI76A83OXEVrCrDtAvZEoT2Ji3vwLrZha9wYy4JZ7QXi0aVnsQ4itWrLLTi7xL/
         fykkwxcwzCM9Dk+W3BRpAqngrIA7ix2GBbvRVPTd6l0EkOTfzJlHmLztyAJ0Eu6Nt/Vy
         8Fjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Phil Elwell <phil@raspberrypi.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 66/66] lan78xx: Correctly indicate invalid OTP
Date: Tue, 17 Apr 2018 17:59:39 +0200
Message-Id: <20180417155648.707734660@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009755647099908?=
X-GMAIL-MSGID: =?utf-8?q?1598010375464655649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Elwell <phil@raspberrypi.org>


[ Upstream commit 4bfc33807a9a02764bdd1e42e794b3b401240f27 ]

lan78xx_read_otp tries to return -EINVAL in the event of invalid OTP
content, but the value gets overwritten before it is returned and the
read goes ahead anyway. Make the read conditional as it should be
and preserve the error code.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -873,7 +873,8 @@ static int lan78xx_read_otp(struct lan78
 			offset += 0x100;
 		else
 			ret = -EINVAL;
-		ret = lan78xx_read_raw_otp(dev, offset, length, data);
+		if (!ret)
+			ret = lan78xx_read_raw_otp(dev, offset, length, data);
 	}
 
 	return ret;
