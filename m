Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeDQMmh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:42:37 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44584 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeDQMmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:42:35 -0400
X-Google-Smtp-Source: AIpwx49FYqVw8qdPPETovW6I/VzA35t38ZDcat5i0LGyQALEZvAH+dyxpGMYpYkkr+/zipudofh1rg==
Subject: Re: [PATCH v2 0/5] ALSA: xen-front: Add Xen para-virtualized frontend
 driver
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <da30127e-d16c-2b48-1d8a-1c9810ae234f@gmail.com>
Date: Tue, 17 Apr 2018 15:42:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416062453.24743-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Juergen!

Thank you very much for reviewing the driver and providing
valuable comments! I will send v3 of the driver once I have
more reviews, especially I hope ALSA community can also take a look

Also, as you suggested on IRC, I will add a patch for adding
myself as sound/xen maintainer.

Thank you,
Oleksandr

On 04/16/2018 09:24 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Please note: this patch series depends on [3].
>
> This patch series adds support for Xen [1] para-virtualized
> sound frontend driver. It implements the protocol from
> include/xen/interface/io/sndif.h with the following limitations:
> - mute/unmute is not supported
> - get/set volume is not supported
> Volume control is not supported for the reason that most of the
> use-cases (at the moment) are based on scenarious where
> unprivileged OS (e.g. Android, AGL etc) use software mixers.
>
> Both capture and playback are supported.
>
> Corresponding backend, implemented as a user-space application, can be
> found at [2].
>
> Thank you,
> Oleksandr
>
> Changes since v1:
> *****************
>
> 1. Moved driver from sound/drivers to sound/xen
>
> 2. Coding style changes to better meet Linux Kernel
>
> 3. Added explicit back and front synchronization
>     In order to provide explicit synchronization between backend and
>     frontend the following changes are introduced in the protocol:
>      - add new ring buffer for sending asynchronous events from
>        backend to frontend to report number of bytes played by the
>        frontend (XENSND_EVT_CUR_POS)
>      - introduce trigger events for playback control: start/stop/pause/resume
>      - add "req-" prefix to event-channel and ring-ref to unify naming
>        of the Xen event channels for requests and events
>
> 4. Added explicit back and front parameter negotiation
>     In order to provide explicit stream parameter negotiation between
>     backend and frontend the following changes are introduced in the protocol:
>     add XENSND_OP_HW_PARAM_QUERY request to read/update
>     configuration space for the parameters given: request passes
>     desired parameter's intervals/masks and the response to this request
>     returns allowed min/max intervals/masks to be used.
>
> [1] https://xenproject.org/
> [2] https://github.com/xen-troops/snd_be
> [3] https://lkml.org/lkml/2018/4/12/522
>
> Oleksandr Andrushchenko (5):
>    ALSA: xen-front: Introduce Xen para-virtualized sound frontend driver
>    ALSA: xen-front: Read sound driver configuration from Xen store
>    ALSA: xen-front: Implement Xen event channel handling
>    ALSA: xen-front: Implement handling of shared buffers
>    ALSA: xen-front: Implement ALSA virtual sound driver
>
>   sound/Kconfig                     |   2 +
>   sound/Makefile                    |   2 +-
>   sound/xen/Kconfig                 |  10 +
>   sound/xen/Makefile                |   9 +
>   sound/xen/xen_snd_front.c         | 410 +++++++++++++++++++
>   sound/xen/xen_snd_front.h         |  57 +++
>   sound/xen/xen_snd_front_alsa.c    | 830 ++++++++++++++++++++++++++++++++++++++
>   sound/xen/xen_snd_front_alsa.h    |  23 ++
>   sound/xen/xen_snd_front_cfg.c     | 517 ++++++++++++++++++++++++
>   sound/xen/xen_snd_front_cfg.h     |  46 +++
>   sound/xen/xen_snd_front_evtchnl.c | 478 ++++++++++++++++++++++
>   sound/xen/xen_snd_front_evtchnl.h |  92 +++++
>   sound/xen/xen_snd_front_shbuf.c   | 193 +++++++++
>   sound/xen/xen_snd_front_shbuf.h   |  36 ++
>   14 files changed, 2704 insertions(+), 1 deletion(-)
>   create mode 100644 sound/xen/Kconfig
>   create mode 100644 sound/xen/Makefile
>   create mode 100644 sound/xen/xen_snd_front.c
>   create mode 100644 sound/xen/xen_snd_front.h
>   create mode 100644 sound/xen/xen_snd_front_alsa.c
>   create mode 100644 sound/xen/xen_snd_front_alsa.h
>   create mode 100644 sound/xen/xen_snd_front_cfg.c
>   create mode 100644 sound/xen/xen_snd_front_cfg.h
>   create mode 100644 sound/xen/xen_snd_front_evtchnl.c
>   create mode 100644 sound/xen/xen_snd_front_evtchnl.h
>   create mode 100644 sound/xen/xen_snd_front_shbuf.c
>   create mode 100644 sound/xen/xen_snd_front_shbuf.h
>
