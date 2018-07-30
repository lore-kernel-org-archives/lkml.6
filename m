Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142E413F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881A020881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881A020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeG3K5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:57:48 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56186 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeG3K5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:57:48 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fk4Oy-0004qJ-AH; Mon, 30 Jul 2018 10:23:40 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] usb-audio: Add UAC3 Power Domains
Date:   Mon, 30 Jul 2018 10:23:32 +0100
Message-Id: <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is what's new in this v2:
 - Fixes build error reported by kbuild for multiple configs 
   (missing include of linux/slab.h).
 - Makes function `snd_usb_add_audio_stream_v3` static for now
   as no one is using it outside sound/usb/stream.c (suggested
   by kbuild).
 - Re-organization of patches so the bit that is not tied up
   to usb's runtime PM (See patch: "ALSA: usb-audio: Operate
   UAC3 Power Domains in PCM callbacks") is the last patch of
   the series. This is likely to need feature improvements to
   tie it up to runtime PM.

This patchset adds support for UAC3 Power Domains. This feature
of the USB audio class 3 allows the host to notify the device 
what it is making use of so power comsumption can be optimized.

This proposal implements this feature for Power Domains
that include an Input/Output Terminal associated to an
audio Streaming interface. This is the main usage of this
feature according to the spec. For that reason, the logic
for the Power Domain state change has been implemented
within the ALSA PCMs logic and the suspend/resume callbacks
of the usb_driver. The behaviour would be as follows:

* Power Domain State D0: A Power Domain will reach this state
  only when the audio substream associated to that domain is
  being used (i,e. Audio playback/capture is happening).
* Power Domain State D1: This is the Idle state where the driver
  is going to always want to be in order to reduce power
  consumption.
* Power Domain State D2: This state is only set when the usb driver
  asumes the device is not going to be used anymore and hence, it
  wont care about getting any interrupts from the device. This
  will only happen when power level is set to "auto" in sysfs
  so the usb driver gets suspended when the interfaces are not in use.
 
NOTE: The way this has been implemented will always try to put the 
Power Domain in state D1 if the Power Domain exists. The patch
"ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks"
puts the logic for doing so inside the PCM's logic. Something to
improve on that is to also tie up those D1<->D0 state changes
to runtime PM maybe.

Jorge Sanjuan (4):
  ALSA: usb-audio: Initial Power Domain support
  ALSA: usb-audio: AudioStreaming Power Domain parsing
  ALSA: usb-audio: Add UAC3 Power Domains to suspend/resume
  ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks

 include/linux/usb/audio-v3.h |   4 ++
 sound/usb/Makefile           |   1 +
 sound/usb/card.c             |   9 ++++
 sound/usb/card.h             |   2 +
 sound/usb/pcm.c              |  64 +++++++++++++++++++++--
 sound/usb/pcm.h              |   2 +
 sound/usb/power.c            | 118 +++++++++++++++++++++++++++++++++++++++++++
 sound/usb/power.h            |  19 +++++++
 sound/usb/stream.c           |  70 ++++++++++++++++++++++---
 9 files changed, 278 insertions(+), 11 deletions(-)
 create mode 100644 sound/usb/power.c

-- 
2.11.0

