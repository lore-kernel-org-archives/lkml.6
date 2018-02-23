Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuU/XIsFji4UvXFbG5IOYbV931ygCc0Z7XN9yblb3rU+eJYtcsaDDbwQuLFoymabfuEQ/ez
ARC-Seal: i=1; a=rsa-sha256; t=1519411215; cv=none;
        d=google.com; s=arc-20160816;
        b=KU2OkTj5x8XDvuqOPyYV/ALwqfMtzmInzNloYZrDKjAewJIXqPMLIGK65xTHqIdp7C
         B2yTqEGbAVabGvAR+3ptBke9ZxW5tTPpP5ux5SCA7a6mg5V7bR5NTM+YnA8bzvK0wNDi
         IGUzoOte/1G4x/i4PEOwHjUMHAPwFlFOmICa/8aI6AptuVLHGUbasXB1J3ge6/brHluQ
         PvLxG+2zhlnq1utG209IQQPtRlmzCeS22G0Bpf9r9T89Ii9mQUxjowffTqGnGdNfRNHo
         1uVztaHwaow3E1UqlfO0Z0nZ6jNQjZTJ39YrzUttWEzQowBOLXJRy1jx1D+iKYgeyZAS
         sNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m6b2rmSJ3uAUYZ62D1jWX5b6ljMP3ktMwRLjcjXr7ZA=;
        b=dfA2S50kiGv/u9RDFRnldXJI/JzB20P2qVy/fP/oVpccmaLExtAfbtRgmZuX/Q0Ohc
         h2ApgjvmxSvf8VBdm38lopwmK346SZMg208O0lxuGcw5aTe9/u76PsyV5H+KM6dXBi3V
         2wyk86TtRPPKXTo0ihCY8JYSNafQw8FDz8J5I3hguz+Of4BDDowWBqCE0kHQosczQTAy
         RHbP+cAHvXVSRYBqzfpLkHFj/wn3xtLcU/upg/SVtHDkWMyinVBy8JJ8LVr9sitomM6Y
         i5/+i/XCdJAGXTwgVZzpmp3y8hBk4wWb+Px2XAoVqX+BWlcSgGAxN8Jqsh0bZK3XFQQv
         Dmvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 113/193] USB: cdc_subset: only build when one driver is enabled
Date: Fri, 23 Feb 2018 19:25:46 +0100
Message-Id: <20180223170343.604027996@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218134275519114?=
X-GMAIL-MSGID: =?utf-8?q?1593218134275519114?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit f3bb23764fac042d189129d485d3a9246cb777da upstream.

This avoids a harmless randconfig warning I get when USB_NET_CDC_SUBSET
is enabled, but all of the more specific drivers are not:

drivers/net/usb/cdc_subset.c:241:2: #warning You need to configure some hardware for this driver

The current behavior is clearly intentional, giving a warning when
a user picks a configuration that won't do anything good. The only
reason for even addressing this is that I'm getting close to
eliminating all 'randconfig' warnings on ARM, and this came up
a couple of times.

My workaround is to not even build the module when none of the
configurations are enable.

Alternatively we could simply remove the #warning (nothing wrong
for compile-testing), turn it into a runtime warning, or
change the Kconfig options into a menu to hide CONFIG_USB_NET_CDC_SUBSET.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/Kconfig  |   10 ++++++++++
 drivers/net/usb/Makefile |    2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -395,6 +395,10 @@ config USB_NET_RNDIS_HOST
 	  The protocol specification is incomplete, and is controlled by
 	  (and for) Microsoft; it isn't an "Open" ecosystem or market.
 
+config USB_NET_CDC_SUBSET_ENABLE
+	tristate
+	depends on USB_NET_CDC_SUBSET
+
 config USB_NET_CDC_SUBSET
 	tristate "Simple USB Network Links (CDC Ethernet subset)"
 	depends on USB_USBNET
@@ -413,6 +417,7 @@ config USB_NET_CDC_SUBSET
 config USB_ALI_M5632
 	bool "ALi M5632 based 'USB 2.0 Data Link' cables"
 	depends on USB_NET_CDC_SUBSET
+	select USB_NET_CDC_SUBSET_ENABLE
 	help
 	  Choose this option if you're using a host-to-host cable
 	  based on this design, which supports USB 2.0 high speed.
@@ -420,6 +425,7 @@ config USB_ALI_M5632
 config USB_AN2720
 	bool "AnchorChips 2720 based cables (Xircom PGUNET, ...)"
 	depends on USB_NET_CDC_SUBSET
+	select USB_NET_CDC_SUBSET_ENABLE
 	help
 	  Choose this option if you're using a host-to-host cable
 	  based on this design.  Note that AnchorChips is now a
@@ -428,6 +434,7 @@ config USB_AN2720
 config USB_BELKIN
 	bool "eTEK based host-to-host cables (Advance, Belkin, ...)"
 	depends on USB_NET_CDC_SUBSET
+	select USB_NET_CDC_SUBSET_ENABLE
 	default y
 	help
 	  Choose this option if you're using a host-to-host cable
@@ -437,6 +444,7 @@ config USB_BELKIN
 config USB_ARMLINUX
 	bool "Embedded ARM Linux links (iPaq, ...)"
 	depends on USB_NET_CDC_SUBSET
+	select USB_NET_CDC_SUBSET_ENABLE
 	default y
 	help
 	  Choose this option to support the "usb-eth" networking driver
@@ -454,6 +462,7 @@ config USB_ARMLINUX
 config USB_EPSON2888
 	bool "Epson 2888 based firmware (DEVELOPMENT)"
 	depends on USB_NET_CDC_SUBSET
+	select USB_NET_CDC_SUBSET_ENABLE
 	help
 	  Choose this option to support the usb networking links used
 	  by some sample firmware from Epson.
@@ -461,6 +470,7 @@ config USB_EPSON2888
 config USB_KC2190
 	bool "KT Technology KC2190 based cables (InstaNet)"
 	depends on USB_NET_CDC_SUBSET
+	select USB_NET_CDC_SUBSET_ENABLE
 	help
 	  Choose this option if you're using a host-to-host cable
 	  with one of these chips.
--- a/drivers/net/usb/Makefile
+++ b/drivers/net/usb/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_USB_NET_GL620A)	+= gl620a.o
 obj-$(CONFIG_USB_NET_NET1080)	+= net1080.o
 obj-$(CONFIG_USB_NET_PLUSB)	+= plusb.o
 obj-$(CONFIG_USB_NET_RNDIS_HOST)	+= rndis_host.o
-obj-$(CONFIG_USB_NET_CDC_SUBSET)	+= cdc_subset.o
+obj-$(CONFIG_USB_NET_CDC_SUBSET_ENABLE)	+= cdc_subset.o
 obj-$(CONFIG_USB_NET_ZAURUS)	+= zaurus.o
 obj-$(CONFIG_USB_NET_MCS7830)	+= mcs7830.o
 obj-$(CONFIG_USB_USBNET)	+= usbnet.o
