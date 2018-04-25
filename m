Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48bI0keBrSQvKO8KZhzCO9eT9DpXQJcs4OMeYu/DHOLzTQwQqj4UrkS01yXhN0vg43JVa+9
ARC-Seal: i=1; a=rsa-sha256; t=1524652758; cv=none;
        d=google.com; s=arc-20160816;
        b=Nma4dOUxYcZok4x7boAx/NycvI+ll9RproKinmaiCqAdNdVsqQuTgPpwQ9zu69psnQ
         4cv8nKJELPfgo1YRfec+BiqiCccoIbq2evLj3CCQxNRA9CX8JGzfxriK+tJ4zj9dews0
         2KK7Iiclzp2luPOddZoaz8JjKFicc87mronIRrG6iMiv+B5eEIqpBAHoWWJeUcwWE3Ja
         3yc5gulXSfHvGcA8sbbpX7W8ba1VtfiOu3McR/Ym/PLcRpfQWzNaJhbilovQw2zt3Ywl
         zNFHxLiNGXpCqMtC1BgO1H5ru9HKhdFwNdaX93+dz22nRnNlOq5W0CroaAuovrtJyRx4
         iLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ncGsVRDUlQ+HjnAg9Y9ieH5qnHPgXrDo5L6F4boFedc=;
        b=J6SX1PyaFoWMmSu591rhfhOdoVCEAkPWvS5L8DExXgGNQUmJ/oTwazk7Oy/uEBZjUC
         jz9c0R5hFFqWSsSlVWwpBs8pdLPPguphKYMCYgKy4jXrEXgtlzGoCNubk6b8iox96ahf
         vCPD2INHOVFQfGqXqevSI7lNTubXGlbRXaU2Ux+6iSisPLpxdVlRRMjEWXu6ah3VVFIH
         vxmLkpRUI9ZVw01JHMUtibbavzuEDloG0oYeQaTiLXd/mcjAaAulREdEGB9LZ7bmeKz5
         B1i1o+2wjDdP6F1CveQgLEfAGPh9l2oXpuDGVba01Pe7rGBlLHHfwOJp6aNiKDmek4Mv
         P8xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@pr.hu>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 057/183] watchdog: sp5100_tco: Fix watchdog disable bit
Date: Wed, 25 Apr 2018 12:34:37 +0200
Message-Id: <20180425103244.832986633@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714290197733313?=
X-GMAIL-MSGID: =?utf-8?q?1598714290197733313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>


[ Upstream commit f541c09ebfc61697b586b38c9ebaf4b70defb278 ]

According to all published information, the watchdog disable bit for SB800
compatible controllers is bit 1 of PM register 0x48, not bit 2. For the
most part that doesn't matter in practice, since the bit has to be cleared
to enable watchdog address decoding, which is the default setting, but it
still needs to be fixed.

Cc: Zoltán Böszörményi <zboszor@pr.hu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/sp5100_tco.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/watchdog/sp5100_tco.h
+++ b/drivers/watchdog/sp5100_tco.h
@@ -55,7 +55,7 @@
 #define SB800_PM_WATCHDOG_CONFIG	0x4C
 
 #define SB800_PCI_WATCHDOG_DECODE_EN	(1 << 0)
-#define SB800_PM_WATCHDOG_DISABLE	(1 << 2)
+#define SB800_PM_WATCHDOG_DISABLE	(1 << 1)
 #define SB800_PM_WATCHDOG_SECOND_RES	(3 << 0)
 #define SB800_ACPI_MMIO_DECODE_EN	(1 << 0)
 #define SB800_ACPI_MMIO_SEL		(1 << 1)
