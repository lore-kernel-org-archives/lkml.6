Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756831AbeDXMHQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:07:16 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35836 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756720AbeDXMHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:07:12 -0400
X-Google-Smtp-Source: AIpwx4+D/0FcDjqJdJe12CurK2zl9XRxhP4Hyx/Jn2FUpT5LdMErndeKSAi4MCqTwgg+p6Ff/ij+8g==
From: Baolin Wang <baolin.wang@linaro.org>
To: perex@perex.cz, tiwai@suse.com, arnd@arndb.de
Cc: baolin.wang@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp, mingo@kernel.org,
        elfring@users.sourceforge.net, dan.carpenter@oracle.com,
        jeeja.kp@intel.com, vinod.koul@intel.com, guneshwor.o.singh@intel.com,
        subhransu.s.prusty@intel.com, bhumirks@gmail.com,
        gudishax.kranthikumar@intel.com, naveen.m@intel.com,
        hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Fix year 2038 issue for sound subsystem
Date: Tue, 24 Apr 2018 20:06:07 +0800
Message-Id: <cover.1524570852.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since many structures will use timespec type variables to record time stamp
in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
tries to introduce new structures removing timespec type to compatible native
mode and compat mode.

Moreover this patchset also converts the internal structrures to use timespec64
type and related APIs.

Arnd Bergmann (2):
  ALSA: move snd_pcm_ioctl_sync_ptr_compat into pcm_native.c
  ALSA: add new 32-bit layout for snd_pcm_mmap_status/control

Baolin Wang (6):
  ALSA: Replace timespec with timespec64
  ALSA: Avoid using timespec for struct snd_timer_status
  ALSA: Avoid using timespec for struct snd_ctl_elem_value
  ALSA: Avoid using timespec for struct snd_pcm_status
  ALSA: Avoid using timespec for struct snd_rawmidi_status
  ALSA: Avoid using timespec for struct snd_timer_tread

 include/sound/pcm.h               |   74 +++++++++--
 include/sound/timer.h             |    4 +-
 include/uapi/sound/asound.h       |  114 ++++++++++++++--
 sound/core/pcm.c                  |   12 +-
 sound/core/pcm_compat.c           |  261 ++++++++-----------------------------
 sound/core/pcm_lib.c              |   38 ++++--
 sound/core/pcm_native.c           |  224 +++++++++++++++++++++++++++----
 sound/core/rawmidi.c              |  131 +++++++++++++++----
 sound/core/rawmidi_compat.c       |   87 ++++---------
 sound/core/timer.c                |  224 +++++++++++++++++++++++--------
 sound/core/timer_compat.c         |   59 +--------
 sound/pci/hda/hda_controller.c    |   10 +-
 sound/soc/intel/skylake/skl-pcm.c |    4 +-
 13 files changed, 766 insertions(+), 476 deletions(-)

-- 
1.7.9.5
