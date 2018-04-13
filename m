Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523658279; cv=none;
        d=google.com; s=arc-20160816;
        b=zkjqbMRYGJEkfoKwdQkoDPdJutsfK/i8dAIh2Xo3A6l42pYROAZLVXAKKrKx19UF2B
         cxs7AbI/4q8NQg8J5ymx/cor7x06fWWxmFXQ4RFtPdMSyPH4eqFfiRMFqtyzSShlof9e
         HqUAVyOM1XjVHCFUBbuLCC9SFBQx5cJZLbwZbjvl7u0Xf4fgpKnA2kqRfm4a7rJyQssT
         pe1aZDVi5pAGCpSXK08jBI+6hH6ze4hIotie6iEkVh5E+q6CIKAMDYo1OVTzCqSNRPCY
         xzM3pSOYmut5BYnv+vwFEFgq0pzGj76NC1ElqZOSt/8MY4g7j2jfrdSVlJkRjpTaCX8C
         PMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=nMgxzD9Zwsw6u4HYeZZlpRtxLLmPmVv4FzyETMWT5Fc=;
        b=jL4Fja2XtaA4zocKkO5qLc/k525hJQe/dgwqka1LFxOUE82pUk1BWmUIiftNGfdAJu
         ZAGP3zYxK9mYm7AtMfpI9I5ZewjEQfSS6CbQa4TXyR4Ez75fW20N+TEdshG81cGxDsST
         sQz//VRc2IbuSY/fb5cYQlNGOgA/yMmxWYOKVrt4iYIRz+z26y2zQGF9oABU2HXDFT28
         pI2WV57AnO3ZPfCQGQPCYes1zCYZljF+Nox1dGqlEZ98JhVBPCosen9WOqgc/jfpZhF0
         T8Dvkwk7GD0E/4BaLYvNBxybfwWg3kX9qz0TS/Z/mtYrLBVGoPunJc6U7G9GAA0tK9G3
         gipw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gtcP1cVL;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gtcP1cVL;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48oV1wj3XopmLUi4tVHu3kTAxLfJx1t4tYGFfGX+JOISvAP9jkyZoJ91YTZJ8N4ssQgy43z6Q==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] USB Audio Device Class 3.0 BADD profiles support
Date: Sat, 14 Apr 2018 01:24:22 +0300
Message-Id: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597671504085093612?=
X-GMAIL-MSGID: =?utf-8?q?1597671504085093612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset adds BADD profiles support from the USB Audio
Device Class 3.0 spec [1].

BADD profile support is defined as mandatory feature of
UAC3-compliant device, it should be implemented as a separate
USB configuration.

Notable issue with BADD configuration is that it misses
class-specific descriptors (and it's mandatory as per spec),
so host should guess them from BADD profile number and
parameters of endpoints (type, number of endpoints and
max packet size)

This patchset adds support of all known/existing BADD profiles
from the UAC3 specification.

It's an alternative implementation comparing to [2],
and doesn't build usb descriptors on the host but instead
initializes alsa-usb structures with known parameters,
so we don't need to keep whole class-specific descriptors
in the driver since we anyway need to have BADD-specific
logic.

I've picked one Jorge's UAC1 patch-improvement and
updated it to v4.17 wich contais recently introduced
header's sanity checks.

Remaining part is to add interrupt endpoint support
so we will be able to detect jack insertion in
the Headset Adapter profile.

This has been tested on ARM and x86-64 machines with
custom UAC3 gadget which I'll post later to linux-usb

Comments and testing are welcome.

[1] http://www.usb.org/developers/docs/devclass_docs/USB_Audio_v3.0.zip
[2] https://www.spinics.net/lists/alsa-devel/msg71614.html

Jorge Sanjuan (1):
  ALSA: usb: Only get AudioControl header for UAC1 class.

Ruslan Bilovol (3):
  ALSA: usb: stream: refactor audio interface parsing
  include: usb: audio-v3: add BADD-specific values
  ALSA: usb: add UAC3 BADD profiles support

 include/linux/usb/audio-v3.h |  26 ++
 sound/usb/card.c             |  53 ++--
 sound/usb/clock.c            |   9 +-
 sound/usb/mixer.c            | 313 +++++++++++++++++++-
 sound/usb/mixer_maps.c       |  65 +++++
 sound/usb/stream.c           | 678 +++++++++++++++++++++++++------------------
 sound/usb/usbaudio.h         |   2 +
 7 files changed, 836 insertions(+), 310 deletions(-)

-- 
1.9.1
