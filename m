Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeDPGZH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:25:07 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37038 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbeDPGZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:25:06 -0400
X-Google-Smtp-Source: AIpwx4/9KyAcK5BMjCAASLy46oTb51uSxFT/WnEKM8jCHxHtcUUKhtjbJQCoZCDo9eV8roggqIWbSg==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        tiwai@suse.com
Cc: andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2 0/5] ALSA: xen-front: Add Xen para-virtualized frontend driver
Date: Mon, 16 Apr 2018 09:24:48 +0300
Message-Id: <20180416062453.24743-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Please note: this patch series depends on [3].

This patch series adds support for Xen [1] para-virtualized
sound frontend driver. It implements the protocol from
include/xen/interface/io/sndif.h with the following limitations:
- mute/unmute is not supported
- get/set volume is not supported
Volume control is not supported for the reason that most of the
use-cases (at the moment) are based on scenarious where
unprivileged OS (e.g. Android, AGL etc) use software mixers.

Both capture and playback are supported.

Corresponding backend, implemented as a user-space application, can be
found at [2].

Thank you,
Oleksandr

Changes since v1:
*****************

1. Moved driver from sound/drivers to sound/xen

2. Coding style changes to better meet Linux Kernel

3. Added explicit back and front synchronization
   In order to provide explicit synchronization between backend and
   frontend the following changes are introduced in the protocol:
    - add new ring buffer for sending asynchronous events from
      backend to frontend to report number of bytes played by the
      frontend (XENSND_EVT_CUR_POS)
    - introduce trigger events for playback control: start/stop/pause/resume
    - add "req-" prefix to event-channel and ring-ref to unify naming
      of the Xen event channels for requests and events

4. Added explicit back and front parameter negotiation
   In order to provide explicit stream parameter negotiation between
   backend and frontend the following changes are introduced in the protocol:
   add XENSND_OP_HW_PARAM_QUERY request to read/update
   configuration space for the parameters given: request passes
   desired parameter's intervals/masks and the response to this request
   returns allowed min/max intervals/masks to be used.

[1] https://xenproject.org/
[2] https://github.com/xen-troops/snd_be
[3] https://lkml.org/lkml/2018/4/12/522

Oleksandr Andrushchenko (5):
  ALSA: xen-front: Introduce Xen para-virtualized sound frontend driver
  ALSA: xen-front: Read sound driver configuration from Xen store
  ALSA: xen-front: Implement Xen event channel handling
  ALSA: xen-front: Implement handling of shared buffers
  ALSA: xen-front: Implement ALSA virtual sound driver

 sound/Kconfig                     |   2 +
 sound/Makefile                    |   2 +-
 sound/xen/Kconfig                 |  10 +
 sound/xen/Makefile                |   9 +
 sound/xen/xen_snd_front.c         | 410 +++++++++++++++++++
 sound/xen/xen_snd_front.h         |  57 +++
 sound/xen/xen_snd_front_alsa.c    | 830 ++++++++++++++++++++++++++++++++++++++
 sound/xen/xen_snd_front_alsa.h    |  23 ++
 sound/xen/xen_snd_front_cfg.c     | 517 ++++++++++++++++++++++++
 sound/xen/xen_snd_front_cfg.h     |  46 +++
 sound/xen/xen_snd_front_evtchnl.c | 478 ++++++++++++++++++++++
 sound/xen/xen_snd_front_evtchnl.h |  92 +++++
 sound/xen/xen_snd_front_shbuf.c   | 193 +++++++++
 sound/xen/xen_snd_front_shbuf.h   |  36 ++
 14 files changed, 2704 insertions(+), 1 deletion(-)
 create mode 100644 sound/xen/Kconfig
 create mode 100644 sound/xen/Makefile
 create mode 100644 sound/xen/xen_snd_front.c
 create mode 100644 sound/xen/xen_snd_front.h
 create mode 100644 sound/xen/xen_snd_front_alsa.c
 create mode 100644 sound/xen/xen_snd_front_alsa.h
 create mode 100644 sound/xen/xen_snd_front_cfg.c
 create mode 100644 sound/xen/xen_snd_front_cfg.h
 create mode 100644 sound/xen/xen_snd_front_evtchnl.c
 create mode 100644 sound/xen/xen_snd_front_evtchnl.h
 create mode 100644 sound/xen/xen_snd_front_shbuf.c
 create mode 100644 sound/xen/xen_snd_front_shbuf.h

-- 
2.16.2
