Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AG47ELtigQbFPHI7bkC4MNRQs4VRKkmgdItfesE54nACh0Dncc8/qvq9Jyj0Udb1Ep8mcPgnCwRm
ARC-Seal: i=1; a=rsa-sha256; t=1521007396; cv=none;
        d=google.com; s=arc-20160816;
        b=drVd7hrvDJVShE22YZ08hcIxfDAj/dPS6e8gbw/VryHf+YUfgekWo1LTFmt2v50Zc1
         LYAzjUzqJ7EmCUei5MO14pzI1uWmQG60/sfCUluWinMgQ425wJLahCIgM4ji3JaD/8cP
         fFxhG4NjpiPExmEIzEf9FuciDdVYv+N+nlFMROm9dSBiXWgPovOXPgviwmA6eRW5Lcxm
         LUE9te6uvEaMSWZ9bNIUVfMlSmYMSuhd6duO2/UUu0V5+t1rIHtPkwQSr7+/spEu/2ZL
         9bG+XBpJwtjlIEgXYyy68owtASD0HfSt1JwigUw9uzACqMGXcVpmIxRrsLvIInUvR9Rh
         BZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8pd0QQ/gQRUlyS2CJXsmK6bdQEAXFgZ66ENaxZHx38E=;
        b=esPZOt8d5GWwx6Kzq8IkzH/IaEXUpiaftvv3rzho9h4tTzkbWJxoi1v1+fzqXYmHtj
         r4AYlaOtRvXTl4Kur+kXW8rfYgSB7ls15DSQHEW7JTxcHtmzfsWTI62AyaGrGBcyT/f5
         WdCc7LVd9uhysxlPrkEjHsFXrPnxBTIemrHU2ujc6dOs9+A5KAgLR8PIYwtjfbfwZAg7
         euL0MknSbw0elycv8oqKqB0s9DAMfMgGoIBTdunIguFVt3zPadb0wnxEFJGzP8JCKLhm
         S3eHAkN2OW1gj3e659+RzQb+YKR8jYDmwYK5n1a6/k9XvuRWLlIDvdubEKy60PBKvs6o
         9Yxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 482a472d4967464cad20d9b16b1a4189-20180314
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Guenter Roeck <linux@roeck-us.net>,
	Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] Add Apple Carplay driver 
Date: Wed, 14 Mar 2018 14:02:35 +0800
Message-ID: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594891852474932951?=
X-GMAIL-MSGID: =?utf-8?q?1594891852474932951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>From bf48dcd9cb254576cfea373c9a5d2ab996408895 Mon Sep 17 00:00:00 2001
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Tue, 13 Mar 2018 11:47:38 +0800
Subject: [PATCH] Add Apple Carplay driver

Some Apple devices which support Carplay can enter USB Host Mode from USB
Device Mode after receiving a specific USB Vendor Request. There is a
requirement apply to accesssories that support the USB dual role switch
feature, and must have a USB-A receptacle that is capable of functioning
in both USB Host and USB Device roles.
It means that the driver should supports manual Dual-Role switch, due to
no IDDIG pin is avaliable.

There is no suitable place to add this spicific USB Vendor Request, so
here I extract a single driver which allow user force to send it by a debug
interface when need it, and keep it independent on USB Dual-Role Controller
Drivers.
But to implement carplay feature, there are some requirments for USB Dual-Role
Driver:
1. supports manual dual-role switch, such as, by a debug interface;
2. keep vbus alive even when switch host into device mode;

More information please refer to "Chapter 46. USB Role Switch" in
MFI Accessroy Interface Specification.pdf

Chunfeng Yun (1):
  usb: misc: supports Apple Carplay driver

 drivers/usb/misc/Kconfig   |    9 +++
 drivers/usb/misc/Makefile  |    1 +
 drivers/usb/misc/carplay.c |  193 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 drivers/usb/misc/carplay.c

-- 
1.7.9.5
