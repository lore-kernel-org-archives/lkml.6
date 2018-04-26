Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755966AbeDZMp3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:45:29 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52243 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755709AbeDZMp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:45:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp, alsa-devel@alsa-project.org,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 0/4] ALSA: Fix year 2038 issue for sound subsystem, alternative
Date: Thu, 26 Apr 2018 14:44:18 +0200
Message-Id: <20180426124422.2921744-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Ufsgb5tXjabCDRIuC3i0IVPaNHddszVnSjvrqnrdQkGUWKBVbmT
 MEUlfv1fsu3fAJez06AFo57UM8iG7XCGxIi/ODz/YEHRg4UumZQ7dxcG25lytepMqtVbF+B
 YXtT1vSBkypwEOBP8Q47p0rMayu/rwah6lYfOqH2uGo2xeE7YaBmGETJMdxCbvOHel1bVD1
 AXDUzEMYeXEOI3y1eWo2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q0vocCu1Zpk=:XS7qEjQS0TOQc3dZc24qWd
 JJH4CycYpEMaVbRgIJEOhOZG3m6KBeW6hDvMlVS5g8eWUMAJpfAXMJ5wuOtdHqospD1Yl/q6z
 QyHFKE9v+YiU35qLIxIAZkBJq3DN7iDA6cU0UKNC1piHRmFFxO/YqNNTXsAGUvDJiiEVojc0/
 lchhxI6/Zj9PZlCfV1Aa0lD5i2EJknkSKf8kH+CjkWpsOUYZAWnXT9ImwVQ9Vy6A62kUCx2Tv
 g4xkRu6svb3c1Z3hgGk3ujmBqSoHwylM0fNJjhy1zp+OIWtQFDCbXTH/CF4CFkoN7ow+2yVvr
 YqX7fCp2cT3Upgi9OUk7droxoWzyJmx+huPeL0sl0vhF7fEF4WGTGnw5kZTEgSWO9hOyYvjX3
 6Z6XMTv9FejZCQv9x8iZTAbBKlcuZJb2B9dOZHQTQ4/a6SVz/0w0jGbBZu5D73unDAMBghGsO
 lU/T2K9mSn8jHdofP/ihRT0IE19Ptzh0V+UhYHjyjKzi33sZB4PcswR/Zfc9tzlhvvH7N/d3k
 zH4rbJF6HyEoEjLO2AdNwK/JVOuH6IZemyztInxv6N95WZ85PX1PcfMp8ZfYlx156EAgc/SwI
 uxafTRbUwUO+RxGLKXvsb54QYUrhu1CU5QR/ran4UFmqoT0Vjgdldl72QOmLsoypWSYZW7Y/A
 S52bDXK32BHxMPjbk60bq2XrqFiuHWIKMPiRMRhAvondg1MDtpdOMxF30kgXzAihh2nI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried the suggestion from Jaroslaw, doing a minimal change to the
UAPI headers to keep the existing binary interface. As he predicted,
this is a much simpler set of kernel changes, but we will pay for that
with added complexity in alsa-lib.

The first two patches in this series are taken from Baolin's patch
set, with a small bugfix folded in to avoid a compile-time regression.

The other two patches are to redefine the UAPI and to deprecate
the support for CLOCK_REALTIME time stamps, which we can no longer
allow with user space that we expect to survive beyond 2038.

Overall, I'd still be happier with Baolin's approach since it allows
us to keep compatiblity with CLOCK_REALTIME users and requires
fewer changes in user space, but this would work as well.

	Arnd

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: tiwai@suse.com
Cc: lgirdwood@gmail.com
Cc: broonie@kernel.org
Cc: o-takashi@sakamocchi.jp
Cc: y2038@lists.linaro.org
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linaro.org>

Arnd Bergmann (2):
  ALSA: replace timespec types in uapi headers
  ALSA: Deprecate CLOCK_REALTIME timestamps

Baolin Wang (2):
  ALSA: Replace timespec with timespec64
  ALSA: Avoid using timespec for struct snd_ctl_elem_value

 include/sound/asound.h            |  8 +++++
 include/sound/pcm.h               | 22 +++++++-----
 include/sound/timer.h             |  4 +--
 include/uapi/sound/asound.h       | 53 +++++++++++++++++++++--------
 sound/core/Kconfig                | 11 ++++++
 sound/core/compat.h               | 11 ++++++
 sound/core/pcm.c                  |  3 ++
 sound/core/pcm_compat.c           | 70 ++++++++++++++++++++++-----------------
 sound/core/pcm_lib.c              | 36 ++++++++++++--------
 sound/core/pcm_native.c           | 25 ++++++++++----
 sound/core/rawmidi_compat.c       | 12 +++----
 sound/core/timer.c                | 28 ++++++++--------
 sound/core/timer_compat.c         |  4 ++-
 sound/pci/hda/hda_controller.c    | 14 +++++---
 sound/soc/intel/skylake/skl-pcm.c |  4 +--
 15 files changed, 203 insertions(+), 102 deletions(-)
 create mode 100644 sound/core/compat.h

-- 
2.9.0
