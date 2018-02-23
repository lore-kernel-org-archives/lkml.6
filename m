Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225GtCPgZUHTEyDT2D3NlKl9hWu4HNsT45opT5TSQesBAryzBYqk4s5jncXYanwQ918l//NY
ARC-Seal: i=1; a=rsa-sha256; t=1519411329; cv=none;
        d=google.com; s=arc-20160816;
        b=p8cpi5XzcniDDoU+l425xGacSn5EGcBUXIQQUsDffYOlnCsWDkNdnpJ8a9JD0p2U2s
         WfV4PAsBtw5B7Nt6wphgCNTCHxjQ3Xmglrs1MNxNbIngsxWToGOaOwJ7TT6IQjWlkM1Y
         zwgI9pUohIVa1u3OKC7wSec0sLN8LWvEDR9UyfpOQD7ObLj/PqV3/KNJvbazdMR7Lsxb
         3Mp1yWtnB8L+OH2faZBA6i4olkWbJGBQkuovvZlyy77Qeclev+xJmLi1+SXJ0w5q1gPO
         gdkmfbEfaNhFy1ebOnVQyw72OlaOIB8VwXpgZIPAmeid8Va7GuI3HafqV0ChLCRqCK+e
         H5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dr0hPv1kgJ2LygrRjd4iuFQ3BRW0KIsRivsI9NnPn90=;
        b=WXFsOtB1DXyyc3RN3so7DygFI+B/8wTl208ovtfvqUZ9pvRr/3wT6iv/EeF33YKWPA
         eyd9cruFy8aIooirxfqH9yIzG6Wh97u5tW8VGRFf26mnJN8/Irnnlbsqh6wb09zbGIW1
         XXAtsVIz3i0/ooU+QqJdjwM5Evlkw5KlLbwj2xDzpEfXSHqrCH2HoQzcy3KCmR+kW2zJ
         obo0Of47MfSa3GS4jRv9AG4xb6+Np6Bp4wZHrfrroReZDB7gl83TAqYeFhtrLin1Mass
         WID5nN3gWJT8trv/pRfyqjtjv4LTatb6SNSt10swIeDVPzAYw1Ai2TYDrkLDMEEjIjbN
         dFsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 153/193] idle: i7300: add PCI dependency
Date: Fri, 23 Feb 2018 19:26:26 +0100
Message-Id: <20180223170349.920176501@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218254156434587?=
X-GMAIL-MSGID: =?utf-8?q?1593218254156434587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

GCC correctly points out an uninitialized variable use when CONFIG_PCI is disabled.

drivers/idle/i7300_idle.c: In function 'i7300_idle_notifier':
include/asm-generic/bug.h:119:5: error: 'got_ctl' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (unlikely(__ret_warn_once && !__warned)) {  \
     ^
drivers/idle/i7300_idle.c:415:5: note: 'got_ctl' was declared here
  u8 got_ctl;
     ^~~~~~~

The driver no longer exists in later kernels, so this patch only appplies to
linux-4.9.y and earlier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/idle/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/idle/Kconfig
+++ b/drivers/idle/Kconfig
@@ -17,6 +17,7 @@ config I7300_IDLE_IOAT_CHANNEL
 
 config I7300_IDLE
 	tristate "Intel chipset idle memory power saving driver"
+	depends on PCI
 	select I7300_IDLE_IOAT_CHANNEL
 	help
 	  Enable memory power savings when idle with certain Intel server
