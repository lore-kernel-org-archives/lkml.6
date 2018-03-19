Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtGJY4FOhPm90e1lQOVB6zPheqf0Jw5oo6ouGFyzM13GDDV3OaoPF6D37Z3AAEBGE2htWBE
ARC-Seal: i=1; a=rsa-sha256; t=1521482952; cv=none;
        d=google.com; s=arc-20160816;
        b=jCu6Sf6LFTROzX05a29hEwo3oazs40ndpnk9o8DSHPJeMAfOQ0KoV6vXM6NGcU0Sis
         AkQMY6WcjYzppxDT1NzwzjzhVb8eGrRX8YSAHSBHDrxg6rDbDvIv3upeo/FhLyzCeo1E
         hJRFDuAoGlGPA0o4fEGwmBXY+xKtY73d8r1tuxcIXmxzghHik0ALwOTRgqnWcBP8DXzM
         9hbrSny9g3baqzbiwffn7CUzS4k/5PRP7lVASZIjmXX4IrBdds0oRbQ4a0chaua8KWeq
         cS/1KbrXSZy7P/Qo0qtcNOoYScjqtIw5UjH1wxiBrUXjcFoNwp3xjeth0hP++jLIpKa8
         At0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r7bSUHMdyy+YZ4gQPj9wkwDYDy3Sm0UEPeEjsTvVxqU=;
        b=LXMUj5oo1xHGFdnluzdBes5QOiEHnjz5GuvyZXeXl44Qm9R8B7SRdIKO1Ww5f8/Z9C
         i2W7O+tk6Avco5EOxGnw+pS6zhkAkPAHEBY3f7ME6pSxU/ncEuDSeie3SjUXQMvCbxDZ
         w0dDTcElP5kEzfTbPxh//YaHKU46aCx5vcjBOlr38U9a+QZDOOV4yS/GArLF7VGfhQmV
         tCWa7KLWqm8vliQd1BTFC/ATmP1PNiIl/FxP0j7uD2nhOqPa6sZ9GcTrTIQvwaB0wz60
         GHL/KN2D4eosxrq1sWY1ZqCpHVGksGeSN+yKbuQ29FxymjupJlkIB2crvPmYmVGn+ZDR
         tbOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 13/68] of: fix of_device_get_modalias returned length when truncating buffers
Date: Mon, 19 Mar 2018 19:05:51 +0100
Message-Id: <20180319171829.754615664@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390508983075525?=
X-GMAIL-MSGID: =?utf-8?q?1595390508983075525?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>


[ Upstream commit bcf54d5385abaea9c8026aae6f4eeb348671a52d ]

If the length of the modalias is greater than the buffer size, then the
modalias is truncated. However the untruncated length is returned which
will cause an error. Fix this to return the truncated length. If an error
in the case was desired, then then we should just return -ENOMEM.

The reality is no device will ever have 4KB of compatible strings to hit
this case.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -126,7 +126,7 @@ ssize_t of_device_get_modalias(struct de
 			str[i] = '_';
 	}
 
-	return tsize;
+	return repend;
 }
 EXPORT_SYMBOL_GPL(of_device_get_modalias);
 
