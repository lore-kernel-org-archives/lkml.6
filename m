Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525397089; cv=none;
        d=google.com; s=arc-20160816;
        b=AOet9hUMMuQL/YILzM9eotiSsD+4ZHCV7n0qxuuQXZJZksoDaWkDsk+z5ZyK67ZTst
         KvQhaPfVK/oUKRTs3y+3WX/4TEMvYz9kKVtl8RPriVgY4mO6cMCRWYZRBV42beo9jUtV
         KdNtkCXbKZAeyqKtl2NxhmxLZP6CqONeOM3wBYpqg7DxUbqfvYDgWzGCoMD1ES6p2UNB
         awbQOzXTdYVpJewe3rJuS2dH9nkASeWXOemaygGRvmzW3X7SHysme3PGaSw6iUjJbqIZ
         A+zYppHNjGKX/36Khx8i7eTGJgpFoRSSxVbKW4DE0lYkh1DC7Oeqo8AX4aVfhlTZn3bh
         4hng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=JYiEkko72DtkesBuFZdNkly8w/aDOD6VivnmAubVmuc=;
        b=q60VyG8cmYuyvXQHRKbVqWJjHyzsIzGouI98FVibwsc87c9bK25rCKevQtNN00F+il
         mlqx1GQVM4jknwTV2ELYoV2Qm1iFoiFKbiNbRHBhMaTlMl+ZGFCqm6FXuGWL2sucYF/0
         Piya3fzSJa8gY2blrrGszC/BLNJDwov744t/f9hYexk3CsXlVaWCe5XCOS7mPfIE5HF7
         OiW8Qk5evu5eJd6gF9pVVfQ8ajUMhBQhkaXBfyo9SiJiBh6hIVEiOa5n6cnT69he2TYU
         0OpQ4YuqGbZpC9p1DIRlioqfkIF7BBpJsd3BRqjD9wYY/FFC39JsRclQeCaZ6BBMwJ78
         0yQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FhcZy1hH;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FhcZy1hH;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrhsaSWu+OuOlt0OI+uRR8BcKnb54caHR/oJT9qQnhNmf6Hj2jQVz0OhaAM0Y3focpa4gUOSA==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Andrew Chant <achant@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] USB Audio Device Class 3.0 BADD profiles support
Date: Fri,  4 May 2018 04:23:57 +0300
Message-Id: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599494778683653955?=
X-GMAIL-MSGID: =?utf-8?q?1599494778683653955?=
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

First 5 patches are refactoring and improvements, and last 2
patches actually implement UAC3 BADD profiles support.

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

v2:
  - split refactoring patch to more atomic and bisectable
    changes as suggested by Takashi
  - renamed "Side Tone"->"Sidetone" as suggested by Andrew
  - revorked main BADD patch to have table lookup for
    checking BADD channels validity and to reduce identation
    as suggested by Takashi
  - also removed code duplication in BADD patch by reusing
    common part of build_feature_ctl() func

v1: http://mailman.alsa-project.org/pipermail/alsa-devel/2018-April/134412.html


[1] http://www.usb.org/developers/docs/devclass_docs/USB_Audio_v3.0.zip
[2] https://www.spinics.net/lists/alsa-devel/msg71614.html

Jorge Sanjuan (1):
  ALSA: usb: Only get AudioControl header for UAC1 class.

Ruslan Bilovol (6):
  ALSA: usb: stream: move audioformat alloc/init into separate function
  ALSA: usb: stream: refactor uac1/2 audio interface parsing
  ALSA: usb: stream: refactor uac3 audio interface parsing
  ALSA: usb: mixer: make string parsing independent of mixer_build state
  include: usb: audio-v3: add BADD-specific values
  ALSA: usb: add UAC3 BADD profiles support

 include/linux/usb/audio-v3.h |  26 ++
 sound/usb/card.c             |  53 ++--
 sound/usb/clock.c            |   9 +-
 sound/usb/mixer.c            | 351 +++++++++++++++++++---
 sound/usb/mixer_maps.c       |  65 ++++
 sound/usb/stream.c           | 687 +++++++++++++++++++++++++------------------
 sound/usb/usbaudio.h         |   2 +
 7 files changed, 849 insertions(+), 344 deletions(-)

-- 
1.9.1
