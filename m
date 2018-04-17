Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/MhI8hD+1yyQTfBcqQX1rW3CyLXMX3yDOX/ZfkgcXXvbG4v5qiMJMRy5CYxeuDkDAkkmD1
ARC-Seal: i=1; a=rsa-sha256; t=1523981097; cv=none;
        d=google.com; s=arc-20160816;
        b=EJtp/rqDRxX66rguAUmBMCKClmtVxHSlXqnjkV4hc7kPrUSdHZNP0t2i0Rf8NsJbis
         LM3/Q2vL7ZAF9p8J9izQpWytNG1FEqsCRceckCo8UEvBILhGkSyiXKGp8a1kJ4uOdoFM
         JA2sulkNF7yN2pewEkToKZyf1OgAocGbzoiV3ozLXHpgS1Quh8wNw/BrjiD9EMA2z9td
         8Wob4Sp7CpLxjt5xclr5ABksuq7+CknJ6X5SHHEJN4anSHtM5/pynl2cONQ7rrMvhDy4
         v0aYPUnvXy+e8Bs9FJ2om5EHeXataY0a0Eoz7PGUpJM2lynbq4ChLuH4XMxUPU3cAM7/
         6rZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kmCAE9pbjEHILMwWxZEbeCv0fIQoGbjIAIPjRVwOkw4=;
        b=Ts8cTKHSJqiy4LqEZNt/r/hEU9cx2viQi5P6t6vTUKrYd8hc9DCf57cONE379L7qN7
         WIccCXh82ewpeJ8C3ryBTQa+OI0K6WqdIKq2hPdmoQfeyquTbfaQvYtXOPG+wsEom1uZ
         Kkehrksr5Cqplo1TJHUxt3kbF9LEy4zcs6TC1tf5H+RMPcbctFDn+Aa65g9+MYV4id2Y
         ZqkOu8hLI1NbDAip/Tzh0fmCBABOwBora0MSlhN45oZEvT0sVTKiRFCxZWdp5RHu/t/R
         3MyucDOX0yOanUDv35XrHAarMZk94Z4tNTfRC06/jz/lQDLxDKygWY/Wv/skM8KNxaDb
         C8Tg==
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
Subject: [PATCH 4.15 11/53] lan78xx: Correctly indicate invalid OTP
Date: Tue, 17 Apr 2018 17:58:36 +0200
Message-Id: <20180417155723.706431040@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009755647099908?=
X-GMAIL-MSGID: =?utf-8?q?1598010003215479618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -928,7 +928,8 @@ static int lan78xx_read_otp(struct lan78
 			offset += 0x100;
 		else
 			ret = -EINVAL;
-		ret = lan78xx_read_raw_otp(dev, offset, length, data);
+		if (!ret)
+			ret = lan78xx_read_raw_otp(dev, offset, length, data);
 	}
 
 	return ret;
