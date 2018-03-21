Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521590644; cv=none;
        d=google.com; s=arc-20160816;
        b=BvYR/+U7FvI44BgC5sYCD+dcXC+cOZyyxqqilyaaYDexEtXvT6iI4nBPPlZptc0ASI
         Pb75h3ZpKKnF7HLTJmQLHwHz3jNBlmYLIwaGPpch3PEm6tGaziNGnviNG1DH2hFFJYW2
         1o/mRLkk9A/ELWxuwq6bMI/IF0v8apbpVa83AO69JeRfSXxjunujOGeLm8BX2txfFhEC
         ORKdjHWWFnZ+83wOMKlRI+CtlID3/R1M4FcG6jyLJWbmL+0C82C0w/e+no8KfIhbCuX3
         GATY7+ZYkTORE9sc5aJhinZD3yBBXfJOzQ5+HipJp3H+W2UZ8JfwnsyQ+tuaaJZNVIrr
         v83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=JRx4Jp8Xc92eteaB4nqDQ2klvNzvpfUeEKA1qvWcFrY=;
        b=RvaRdoePTDHg3psVifhT4shAPUeYbIsz91imGX+3gHag0SQkZ7Me5teZy25EVcL9dW
         COXm2cLw4gX1/7iTQgakPO12JaxwmcBI6CFYsl9jlSj97HivXFyvYm2iZdJEtbX2JkwH
         fI6kP2+c1phmR+4IV+VqDlk2wecSBjt/AvlnmEm2mHjcxabAUa1pnBRUdx4+BLTG/IaI
         QdiraWsG3vyPWNIYoTYbILllW7SmYD7w0wIwQB+9Q+oNscEgwFKmED0cnEhZGUWIzsT4
         FFKhsWr4WOvNf0r2VXsoaioy6sLyln6LFyW9Eo787vyaRIKLxZCKSJPPMP23bkZiHqdb
         IAIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZVPO4gs6;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZVPO4gs6;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs7/iSePmwGQyqPhutqIoM5eT6fAKF1P9FyPQzSqgDVNapfCDkO2yPVoDrVWqW71yUMD94GoA==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Jorge <jorge.sanjuan@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] USB Audio Device Class 3.0 support
Date: Wed, 21 Mar 2018 02:03:58 +0200
Message-Id: <1521590639-31383-1-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595503431762584574?=
X-GMAIL-MSGID: =?utf-8?q?1595503431762584574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Takashi,

This patch adds initial USB Audio Device Class 3.0 [1]
support to the ALSA that we discussed at ELCE.

The patch was tested with UAC3 gadget [2] that I posted
to USB mailing list before. It is good for working with
BADD device which implements such topologies like
BAIF (Basic Audio Input Functions), BAOF (Basic Audio
Output Functions) or compbination of both.

UAC3 spec has changed descriptors laout and many other
codes comparing to UAC2 spec, thus making reuse of existing
sources impossible or quite complex.

There are still many areas of improvement, as this patch
doesn't have UAC3 Mixer Unit support nor some new features
like Power Management

I tested this with BeagleBone Black as UAC3 gadget device.

[1] http://www.usb.org/developers/docs/devclass_docs/USB_Audio_v3.0.zip
[2] http://www.spinics.net/lists/linux-usb/msg162482.html

v3 changes:
 - dropped audioformat quirks patch (already accepted)
 - addressed coding style requested changes

v2 changes:
 - moved audioformat quirks to quirks.c
 - addressed many comments from Pierre-Louis Bossart
 - reorganized audio-v3.h
 - added more UAC3 channel relationship definitions


Ruslan Bilovol (1):
  ALSA: usb: initial USB Audio Device Class 3.0 support

 include/linux/usb/audio-v2.h   |   4 +-
 include/linux/usb/audio-v3.h   | 395 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/usb/audio.h |   1 +
 sound/usb/card.c               |   7 +-
 sound/usb/card.h               |   2 +-
 sound/usb/clock.c              | 228 +++++++++++++++++++++---
 sound/usb/clock.h              |   4 +-
 sound/usb/format.c             |  91 ++++++++--
 sound/usb/format.h             |   6 +-
 sound/usb/mixer.c              | 337 +++++++++++++++++++++++------------
 sound/usb/stream.c             | 365 +++++++++++++++++++++++++++++++++----
 11 files changed, 1246 insertions(+), 194 deletions(-)
 create mode 100644 include/linux/usb/audio-v3.h

-- 
1.9.1
