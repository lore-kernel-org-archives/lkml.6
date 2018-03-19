Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521423966; cv=none;
        d=google.com; s=arc-20160816;
        b=UCkKC2fgjaXLJhwlVpgYORZ5cQqPTq+WMHRqooC0qgx+DQ8rCoQbVW17NpTvyxtn2x
         Zs1/BXSARO9TjSRYO8J0eHkz0bk8AIeosFBrTV99e/mhGkspWj0LtsjPnIRyat46JcJV
         B2GalcAsHlwAzn425bA8x/Xx4cpw9DINwuujTKE5dwfj8CD99FDPPHR3fcLnD11ZQwKV
         eRuui/0wMj3aKizCUF8oBNmCzYeQz/bZ/ncTVSCII5BqNOX5vyOjuVTdRQ5iE9Z0gg2R
         riGEAwgw2YsiU4QHsEaCIA2Pa/5yIOhAlTTA1/HrHHLQ6FWZNQX7oKjyPVoX/Am0/LV2
         GT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=MNhuHtW7q+mUyVj5B8TqN0Pi3jGaFfk41J+cq4qN4uk=;
        b=STJ2EqwU97LKi+JUvcPvoGWMTjAHHi0QgDIp4Lg/wR+QaRDYZn1uJy3x85F7Iu60C2
         9eoYN3XQwnZsMqkMRafpiYqI2oz8dbghjRK0ID4dwE1dRZLa/hmffydFJ3J0IBX0WY6Z
         HSRc6oMZnEwqbj4qdhuXyo8v+2iYaBW6gSlBi6y8Tz4QhTZqhmh4Z+g11M422JVZJZ5p
         XbHRAxOYPh+ji/k59ZBPmGLN/9aQueaEtZL49ofp/cV0JFECe79R/MoCMCHA7rppNJOI
         CwbEFN2wfz/wBFDyKjVkjLwMl8fDxt0JSfxPTlQL0vuQyJ2JIwRcUjRwP45ygX78jRgP
         bP+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Th90vWYA;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Th90vWYA;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELt/IIE6dw4MVUB1ZOci06AWCKhDzQ4+84eZEp5A5i7F3YSlHP2JkaZeovAPoKux5zZSfo2eBg==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Jorge <jorge.sanjuan@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] USB Audio Device Class 3.0 support
Date: Mon, 19 Mar 2018 03:46:01 +0200
Message-Id: <1521423963-24677-1-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595328656357842553?=
X-GMAIL-MSGID: =?utf-8?q?1595328656357842553?=
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

v2 changes:
 - moved audioformat quirks to quirks.c
 - addressed many comments from Pierre-Louis Bossart
 - reorganized audio-v3.h
 - added more UAC3 channel relationship definitions


Ruslan Bilovol (2):
  ALSA: usb-audio: move audioformat quirks to quirks.c
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
 sound/usb/quirks.c             |  34 ++++
 sound/usb/quirks.h             |   4 +
 sound/usb/stream.c             | 393 +++++++++++++++++++++++++++++++++-------
 13 files changed, 1284 insertions(+), 222 deletions(-)
 create mode 100644 include/linux/usb/audio-v3.h

-- 
1.9.1
