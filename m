Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuVbRaYwhNG5y9D97y89v0W2b3cPChZ0zaMQvmXnmEDqZdnfRxPMsyV0KTVeclxLKxPazjz
ARC-Seal: i=1; a=rsa-sha256; t=1521214903; cv=none;
        d=google.com; s=arc-20160816;
        b=z+s6uFr1oTB9rSNSgDVCDAVSzi5WzOc23IlLF3deyVF7vy6e9F3cpwOJ7vQpK6oRa1
         eeJy2ARtm2AYX/v0K/1Kq1ec+dP0sxpt18ShAjXeeojtJce2rOpK5UB1dgk4WtDY12kr
         dfQJM2VU0lF8O7UsdcgdrLrg5HkkHOcPI+Zfae+sTpx2lyv+misoLRnZmSokocUPWXgc
         9QCkd2o9amuAKi1Ohl1V6dAFAoekkwzpx+GjCOjGT3RV47VlaHhIpYYK8sLKeCCiUnqt
         CNBDgnfI5cRXquEscWOI9VZ8tw5XMv2pm1D/n9UIckqyz5FpfnJorhok348OpnwS7wlg
         +Spg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nEwOaEWR0FM44Rf9nULHQNhcmtHtH1bqRrgo5V3/A0c=;
        b=e1iAdZSSzhxTgMXQDqOwNVkAc1ww5xGjvFMgTQoTiTjsZphQripsTB719NdIgr9VK9
         8JHeMoc7vQC0CcjO4eKJOUVFm+SEfE7gQICvvgq15SrL+tZZmUyWnipnQeQOIHQdFc8Y
         OhNaAV1TrYSigdI0RzyUsd0E025MQoMY4/+rW43Ekl8OkMiDgusBSnA/DurcjuSdxh3A
         wpgMV/w+9rcyCPFMqPIK3JJr+WQs72BwSbABr7tk0daR8cGf+Kp80Y02qxBoSRqM6ROb
         fx/Yz2eLNGQV/O/k16nrogplvZAac+1m97AB42QkYx0XfQweJtt07dS34B7s6I0lYp9m
         Ywyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 058/128] gpiolib: dont allow OPEN_DRAIN & OPEN_SOURCE flags simultaneously
Date: Fri, 16 Mar 2018 16:23:19 +0100
Message-Id: <20180316152339.713629484@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109438452997427?=
X-GMAIL-MSGID: =?utf-8?q?1595109438452997427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <brgl@bgdev.pl>


[ Upstream commit 588fc3bceaf81bbd62e18af6f7bd475e01c2b7e8 ]

Do not allow OPEN_SOURCE & OPEN_DRAIN flags in a single request. If
the hardware actually supports enabling both at the same time the
electrical result would be disastrous.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -460,6 +460,15 @@ static int linehandle_create(struct gpio
 	if (lflags & ~GPIOHANDLE_REQUEST_VALID_FLAGS)
 		return -EINVAL;
 
+	/*
+	 * Do not allow OPEN_SOURCE & OPEN_DRAIN flags in a single request. If
+	 * the hardware actually supports enabling both at the same time the
+	 * electrical result would be disastrous.
+	 */
+	if ((lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN) &&
+	    (lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE))
+		return -EINVAL;
+
 	/* OPEN_DRAIN and OPEN_SOURCE flags only make sense for output mode. */
 	if (!(lflags & GPIOHANDLE_REQUEST_OUTPUT) &&
 	    ((lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN) ||
