Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtK6oa7sKyXOU7E+Bg1iuj4ozoJKC7KJfZlzVTf8unIIM6YPOBV8sIwREW8b90zP2BMaAFr
ARC-Seal: i=1; a=rsa-sha256; t=1519411115; cv=none;
        d=google.com; s=arc-20160816;
        b=Xjj3qAi/Aid/EmIX4/1LvsD8i5vk08jQpy/A01z6c9vwzMIZn9QDf+Mixoxd6V+I3L
         Ovmmo62FapKTFfqFZiP5TsMwWlsIhYwSanj44IJvfGXH/zUZja8bxhKJKN9Gz1sTpOJE
         MQC19EXl8f2nME9fYfUuQvZaL2wbaS/p5tVNO89H6o6wbniurB7CJdU+WGwYNitqqzVa
         BZbC+XwReWhIojroCfUx5H9OThlzmC0Hf9pZGXgoMuE2Q0sHaCmQVXOELuqF1Kr9EMjQ
         22U5Rz9qoAEgYy+aD41MsFxvH2aSZ3voiKAyZcIuG8bszZyHCarRpX11Hc4Y5Ku3p17r
         9jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kVs6SwhV4UkaGP9AUamyU5FEM3ptyoWmmVuTDB2i88k=;
        b=mred1VSbB47OwDJYucHpnEBfFOyQWMD0jfABr62W4VA0efRmDTZ7nJoI2TaKc+JGAp
         Fy3BCH41SwiaRdq8Q363CA5QwoZALmKf15RFRBb9Hjw+kOJy8es8/OVMs9p0rl3r4WvL
         X1mGq5MLtoDO/4gxBn36XgghkxvLnID8VgK9Fm+jv2GpjWYYqUIgqR4GwqITWvcIM93K
         BT3L5HsC4VT6kLqvwQ6ejtCRH8DwXxfeO1AIRx74tZJOKKcJQPjr7d5bsj1RdaAlPHhO
         AFECX5yDZnaVQQc4wfSgFwaAsZdlUCo7sP+8DJ0J7qfApF7ZCZ7+fJLJ3EH5TlhWFjVz
         eV3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: [PATCH 4.4 127/193] [media] b2c2: flexcop: avoid unused function warnings
Date: Fri, 23 Feb 2018 19:26:00 +0100
Message-Id: <20180223170345.788856247@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218030223294223?=
X-GMAIL-MSGID: =?utf-8?q?1593218030223294223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 733d0def3ebdd1d088330d904149af21fa4b9ae2 upstream.

The flexcop driver has two functions that are normally used, except
when multiple frontend drivers are disabled:

drivers/media/common/b2c2/flexcop-fe-tuner.c:42:12: warning: 'flexcop_set_voltage' defined but not used [-Wunused-function]
drivers/media/common/b2c2/flexcop-fe-tuner.c:71:12: warning: 'flexcop_sleep' defined but not used [-Wunused-function]

This avoids the build warning by updating the #ifdef for flexcop_set_voltage
to the exact condition under which it is used. For flexcop_sleep, the
condition is rather complex, so I resort to marking it as __maybe_unused,
so the compiler can silently drop it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/common/b2c2/flexcop-fe-tuner.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/common/b2c2/flexcop-fe-tuner.c
+++ b/drivers/media/common/b2c2/flexcop-fe-tuner.c
@@ -38,7 +38,7 @@ static int flexcop_fe_request_firmware(s
 #endif
 
 /* lnb control */
-#if FE_SUPPORTED(MT312) || FE_SUPPORTED(STV0299)
+#if (FE_SUPPORTED(MT312) || FE_SUPPORTED(STV0299)) && FE_SUPPORTED(PLL)
 static int flexcop_set_voltage(struct dvb_frontend *fe,
 			       enum fe_sec_voltage voltage)
 {
@@ -68,7 +68,7 @@ static int flexcop_set_voltage(struct dv
 #endif
 
 #if FE_SUPPORTED(S5H1420) || FE_SUPPORTED(STV0299) || FE_SUPPORTED(MT312)
-static int flexcop_sleep(struct dvb_frontend* fe)
+static int __maybe_unused flexcop_sleep(struct dvb_frontend* fe)
 {
 	struct flexcop_device *fc = fe->dvb->priv;
 	if (fc->fe_sleep)
