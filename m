Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7350CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C58F2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C58F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbeGSMFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:05:03 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59734 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:05:03 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fg70k-0004fU-IF; Thu, 19 Jul 2018 12:22:18 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] usb-audio: Add UAC3 Power Domains
Date:   Thu, 19 Jul 2018 12:22:11 +0100
Message-Id: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support for UAC3 Power Domains. This feature
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
Power Domain in state D1 if the Power Domain exists so there is not a 
way a user could disable this feature. It may be worth getting a control
exposed to userland that enables/disables this feature (?).

Power Domains affecting other units independently are required to be 
bypassed via a Selector Unit first before the host can change the 
power state. This sceneario is not covered in this patchset.

based on next-20180719

Jorge Sanjuan (4):
  ALSA: usb-audio: Initial Power Domain support
  ALSA: usb-audio: AudioStreaming Power Domain parsing
  ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks
  ALSA: usb-audio: Add UAC3 Power Domains to suspend/resume

 include/linux/usb/audio-v3.h |   4 ++
 sound/usb/Makefile           |   1 +
 sound/usb/card.c             |   9 ++++
 sound/usb/card.h             |   2 +
 sound/usb/pcm.c              |  64 +++++++++++++++++++++--
 sound/usb/pcm.h              |   2 +
 sound/usb/power.c            | 117 +++++++++++++++++++++++++++++++++++++++++++
 sound/usb/power.h            |  19 +++++++
 sound/usb/stream.c           |  70 +++++++++++++++++++++++---
 9 files changed, 277 insertions(+), 11 deletions(-)
 create mode 100644 sound/usb/power.c

-- 
2.11.0

