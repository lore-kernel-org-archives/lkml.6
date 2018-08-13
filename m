Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3FAC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EA6217CC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lljKvCQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EA6217CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbeHMWbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:31:14 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34863 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeHMWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:31:13 -0400
Received: by mail-wr1-f46.google.com with SMTP id g1-v6so15282123wru.2;
        Mon, 13 Aug 2018 12:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4VE30PmKKtlgDVpZtd6w0n5vB+bRcmeXtMBqKNcqZU=;
        b=lljKvCQky1I11Q3rMAjcAUoBjkdOf2vEk2iBeU3IcvgSXQRnyTM9alxnC6AsGq42Yw
         nMOChDIg0TwRATyJuczyTk2ezzoEZr9tc/LJ4uqZVFD4ZZQG4ai/s6WXQMgi4qN9ZEMx
         T2UIVEqX1Om0rrJlh4/0wHnvFysY1+86Gp+FWVDpfnQQAdWJTOGKCE0oAsCAUrzOgm00
         FOOFSEAh+hd7KtQJ4kH0uNkxeqtj5oOGTQxE0EfM0Pb7VK3DBHHQmikdaFmfcinNCGJQ
         lki6652iIS7ulJ6JVyHyT/53ZvbSU78XWdJeHx5FPRtZtZLXB16REKfIWlXNiUyndEwe
         dwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4VE30PmKKtlgDVpZtd6w0n5vB+bRcmeXtMBqKNcqZU=;
        b=TiiU+ayvtyL08mcBv6MkMVQGvxXtQoj99GFMSWZ+m1zV4C9eAZJoZK2X/rlvxpNmXw
         qt3P0oyPPctijaWfQNnM/BDH/3StUE7LwrL3buvxMrgGrvLXmHHsyBw7CHx7QfjgBDSa
         BLMd7g5O5ZVpYdmcHZuwOxTAz13wk9IXhBFOW1RKBmwnEwMCHJ1T8EeEQ/MCvAk8fUlf
         7IK1ni8iTTP/Cvrb4gAu4KArThGCUiDwE6pMMkeYjBx11c39OlHtau+YIVyRwvFi+NYu
         Hat91LHoAOKi5vkBkMHVYWEFqufsnxAo+isc8uNUKWX3zgHCL133odDJZ3oqfaJHZ8CX
         1GbA==
X-Gm-Message-State: AOUpUlFzAghor+gi5iq8acDfnMYyN7LvGnVLBVcYnmaVKYzRwYtkgZM3
        QyxGDS6YMa6/vjaZMv1Bgso=
X-Google-Smtp-Source: AA+uWPxXp2etnuI3BN7gkx8qXNHfwG7ggIRXlWG38/YKrbkJK09Fukb7YsF6ufwbFls8vnrHV0aldg==
X-Received: by 2002:adf:fb0e:: with SMTP id c14-v6mr11303872wrr.117.1534189652525;
        Mon, 13 Aug 2018 12:47:32 -0700 (PDT)
Received: from i4790k.home (dkl99.neoplus.adsl.tpnet.pl. [83.24.15.99])
        by smtp.gmail.com with ESMTPSA id w204-v6sm14767398wmw.5.2018.08.13.12.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Aug 2018 12:47:31 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        arnd@arndb.de, colin.king@canonical.com, daniel@zonque.org,
        dmurphy@ti.com, elviskitone@gmail.com, mchehab+samsung@kernel.org,
        rafdev@dinapo.li, u.kleine-koenig@pengutronix.de,
        jacek.anaszewski@gmail.com
Subject: [GIT PULL] LED updates for 4.19-rc1
Date:   Mon, 13 Aug 2018 21:47:23 +0200
Message-Id: <1534189643-6449-1-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull LED updates for 4.19-rc1.

LED triggers improvements make the biggest part of this pull request.
The most striking ones, that allowed for nice cleanups in the triggers are:
	- centralized handling of creation and removal of trigger sysfs
	  attributes via attribute group
        - addition of module_led_trigger() helper

The other things that need to be mentioned:

New features and improvements to existing LED class drivers:
	- lt3593: add DT support, switch to gpiod interface
	- lm3692x: support LED sync configuration, change OF calls to fwnode calls
	- apu: modify PC Engines apu/apu2 driver to support apu3

Change in the drivers/net/can/led.c:
	- mark led trigger as broken since it's in the way for the further
          cleanups. It implements a subset of the netdev trigger and an Ack
	  is needed from someone who can actually test and confirm that the netdev
	  trigger works for can devices.

Thanks,
Jacek Anaszewski

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/leds-for-4.19-rc1

for you to fetch changes up to 2224f2ff9670b899983ff1b42d85530e889cfea1:

  leds: ns2: Change unsigned to unsigned int (2018-08-06 23:03:12 +0200)

----------------------------------------------------------------
LED updates for 4.19-rc1
----------------------------------------------------------------

Arnd Bergmann (1):
      leds: ledtrig-activity: use ktime_get_boot_ns()

Colin Ian King (1):
      leds: max8997: use mode when calling max8997_led_set_mode

Dan Murphy (4):
      leds: lm3692x: Update license header to SPDX
      leds: lm3692x: Change DT calls to fwnode calls
      dt: bindings: lm3692x: Update binding for LED sync control
      leds: lm3692x: Support LED sync configuration

Daniel Mack (5):
      dt-bindings: leds: Add bindings for lltc,lt3593
      leds: lt3593: merge functions and clean up code
      leds: lt3593: switch to gpiod interface
      leds: lt3593: Add device tree probing glue
      leds: lt3593: update email address and switch to SPDX license header

Kitone Elvis Peter (1):
      leds: ns2: Change unsigned to unsigned int

Mauro Carvalho Chehab (1):
      devicectree: bindings: fix location of leds common file

Raffaello D. Di Napoli (1):
      leds: Modify PC Engines apu/apu2 driver to support apu3

Uwe Kleine-König (18):
      leds: triggers: don't depend on LEDS_TRIGGERS twice
      can: mark led trigger as broken
      leds: triggers: make the MODULE_LICENSE string match the actual license
      leds: triggers: let struct led_trigger::activate() return an error code
      leds: triggers: add device attribute support
      leds: triggers: handle .trigger_data and .activated() in the core
      leds: triggers: define module_led_trigger helper
      leds: triggers: new function led_set_trigger_data()
      leds: netdev trigger: simplifications from core changes
      leds: timer trigger: simplifications from core changes
      leds: transient trigger: simplifications from core changes
      leds: oneshot trigger: simplifications from core changes
      leds: heartbeat trigger: simplifications from core changes
      leds: default-on trigger: make use of module_led_trigger()
      leds: activity trigger: simplifications from core changes
      leds: backlight trigger: simplifications from core changes
      leds: gpio trigger: simplifications from core changes
      usb: simplify usbport trigger

 Documentation/devicetree/bindings/leds/common.txt  |   2 +-
 .../devicetree/bindings/leds/leds-lm3692x.txt      |   5 +-
 .../devicetree/bindings/leds/leds-lt3593.txt       |  32 ++++
 drivers/leds/Kconfig                               |   5 +-
 drivers/leds/led-triggers.c                        |  39 ++++-
 drivers/leds/leds-apu.c                            |  44 ++++-
 drivers/leds/leds-lm3692x.c                        | 181 ++++++++++++++------
 drivers/leds/leds-lt3593.c                         | 190 ++++++++++++---------
 drivers/leds/leds-max8997.c                        |   2 +-
 drivers/leds/leds-ns2.c                            |   4 +-
 drivers/leds/trigger/Kconfig                       |  15 +-
 drivers/leds/trigger/ledtrig-activity.c            |  51 +++---
 drivers/leds/trigger/ledtrig-backlight.c           |  64 +++----
 drivers/leds/trigger/ledtrig-camera.c              |   3 +-
 drivers/leds/trigger/ledtrig-default-on.c          |  20 +--
 drivers/leds/trigger/ledtrig-gpio.c                |  92 +++-------
 drivers/leds/trigger/ledtrig-heartbeat.c           |  49 +++---
 drivers/leds/trigger/ledtrig-netdev.c              | 101 ++++-------
 drivers/leds/trigger/ledtrig-oneshot.c             |  91 +++-------
 drivers/leds/trigger/ledtrig-timer.c               |  58 ++-----
 drivers/leds/trigger/ledtrig-transient.c           | 102 ++++-------
 drivers/net/can/Kconfig                            |   6 +
 drivers/tty/vt/keyboard.c                          |   4 +-
 drivers/usb/core/ledtrig-usbport.c                 |  34 ++--
 include/linux/leds.h                               |  36 +++-
 net/bluetooth/leds.c                               |   6 +-
 net/mac80211/led.c                                 |  20 ++-
 net/rfkill/core.c                                  |   4 +-
 28 files changed, 641 insertions(+), 619 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lt3593.txt
