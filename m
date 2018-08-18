Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70644C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CA7219CA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q39e9SiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CA7219CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeHRD70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:59:26 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:34883 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeHRD70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:59:26 -0400
Received: by mail-pg1-f180.google.com with SMTP id w10-v6so4270625pgv.2;
        Fri, 17 Aug 2018 17:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mOkp0idcHVwqqzEV3ow64B7igXPhFTJ+7jwyRlrCs1g=;
        b=q39e9SiEwn8E9hAqa4tWl5edZ6NepQqCM8uhsvNrUyjDdFlGW9I5lXOvyhS9nq3Ywd
         BwyEE7l/ENAfgu0vLI/GWPKJhrOXESqGt83C4/eQ+XIxObGSQcVNKV16zj1vJWTfRk9a
         MAqU2xWA9n95LKJVuSFhO1VgrrdWwRp6wmAjuW+ft/xN3pEV54tt0blR7YitAw+Q7mUu
         As8s8eYkC3FK11lODq+qQRoz/dXmMrfxn5a5JsKL1bVJeNwpedWcpu/ERw8YOdFWQrO7
         u+KyNYAfNvkFNvg0bWAnE/8/2JqxvRCaIpo+97qw2i0aZxAtRWoV+pdWxjlrbZDWiQal
         zKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mOkp0idcHVwqqzEV3ow64B7igXPhFTJ+7jwyRlrCs1g=;
        b=KB08zcQhflcOwaxrMRda4a/tDE83g4Kweoq/dNWNVxYfzOZuqe0meDXUP81biX5O2U
         46Z2aMmsAeWtKmfVzntbSj+X4Pxi0NRR3bnn99YsOXjio81dmxTy2XEIYpar12zteRyu
         e61iLqSXIPK+a1ZEUaTEF7g4iGbMwbM+FP9RnmPCN4JbbCx7AOhdiJZrOqv/h7HmYT7A
         I4NnSePK8ngFQkf2QbU2ug98l6wuCCgEfXx6Wja/XO90ICBs+8ng0OL+KfDKIUkTQw84
         kZNoFqawQUshv+Z/NFnW7KbXGm2G1Yag7aQyg21xaFDVTOIhaubV1qyC3TjhZOnNGok8
         2wmg==
X-Gm-Message-State: AOUpUlFe8rL4L2FA8Y0Nsz8jxy+L0AzeADlZFDIqpDrs91p/HJ+JXbfJ
        vXGBL/XXf0LjTvhc9Of3q/4=
X-Google-Smtp-Source: AA+uWPxFuhiTAVazN6MCe+xDibldQEBpeu66p9nlKgCAr8EnLLRqq+059cVR84xfiVKPTEEMvk/9lQ==
X-Received: by 2002:a62:c288:: with SMTP id w8-v6mr38513772pfk.92.1534553626711;
        Fri, 17 Aug 2018 17:53:46 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a77-v6sm6533840pfj.38.2018.08.17.17.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 17:53:45 -0700 (PDT)
Date:   Fri, 17 Aug 2018 17:53:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.19-rc0
Message-ID: <20180818005343.GA95184@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a new driver for Rohm BU21029 touch controller

- new bitmap APIs: bitmap_alloc, bitmap_zalloc and bitmap_free

- updates to Atmel, eeti. pxrc and iforce drivers

- assorted driver cleanups and fixes.

Changelog:
---------

Andy Shevchenko (5):
      dm: Avoid namespace collision with bitmap API
      md: Avoid namespace collision with bitmap API
      bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
      Input: gpio-keys - switch to bitmap_zalloc()
      Input: evdev - switch to bitmap API

Chen Zhong (1):
      dt-bindings: input: add common keyboard document bindings

Colin Ian King (1):
      Input: cros_ec_keyb - remove redundant variable num_cols

Daniel Mack (4):
      dt-bindings: input: touchscreen: add bindings for eeti touchscreen controller
      Input: eeti - add device tree matching table
      Input: eeti - drop module parameters, parse DT properties
      Input: eeti - fix link to documentation and email address in header

Dmitry Torokhov (6):
      Input: pxrc - fix freeing URB on device teardown
      Input: pxrc - move module device table closer to where it is used
      Input: pxrc - do not store unneeded data in driver structure
      Input: pxrc - flatten probe code
      Input: stop telling users to snail-mail Vojtech
      Input: do not use WARN() in input_alloc_absinfo()

Enric Balletbo i Serra (2):
      Input: cros_ec_keyb - make license text and MODULE_LICENSE match
      Input: cros_ec_keyb - switch to SPDX identifier

Fabio Estevam (5):
      Input: imx_keypad - switch to SPDX identifier
      Input: snvs_pwrkey - switch to SPDX identifier
      Input: fsl-imx25-tcq - switch to SPDX identifier
      Input: imx6ul_tsc - switch to SPDX identifier
      Input: egalax_ts - switch to SPDX identifier

Gustavo A. R. Silva (2):
      Input: raydium_i2c_ts - use true and false for boolean values
      Input: mark expected switch fall-throughs

Jia-Ju Bai (6):
      Input: wdt87xx_i2c - replace mdelay() with msleep() in wdt87xx_resume()
      Input: keyspan_remote - replace GFP_ATOMIC with GFP_KERNEL in keyspan_probe()
      Input: powermate - replace GFP_ATOMIC with GFP_KERNEL in powermate_alloc_buffers()
      Input: yealink - replace GFP_ATOMIC with GFP_KERNEL in usb_probe()
      Input: appletouch - replace GFP_ATOMIC with GFP_KERNEL
      Input: aiptek - replace GFP_ATOMIC with GFP_KERNEL in aiptek_probe()

Julia Lawall (1):
      Input: elan_i2c_smbus - cast sizeof to int for comparison

Marcus Folkesson (2):
      Input: pxrc - do not store USB device in private struct
      MAINTAINERS: Add PhoenixRC Flight Controller Adapter

Matti Vaittinen (1):
      Input: gpio_keys - add missing include to gpio_keys.h

Nick Dyer (9):
      Input: atmel_mxt_ts - only use first T9 instance
      Input: atmel_mxt_ts - use BIT() macro everywhere
      Input: atmel_mxt_ts - remove duplicate setup of ABS_MT_PRESSURE
      Input: atmel_mxt_ts - remove unnecessary debug on ENOMEM
      Input: atmel_mxt_ts - config CRC may start at T71
      Input: atmel_mxt_ts - refactor config update code to add context struct
      Input: atmel_mxt_ts - zero terminate config firmware file
      Input: atmel_mxt_ts - don't report zero pressure from T9
      Input: atmel_mxt_ts - move completion to after config crc is updated

Oleksandr Andrushchenko (3):
      xen: Sync up with the canonical protocol definitions in Xen
      Input: xen-kbdfront - fix multi-touch XenStore node's locations
      Input: xen-kbdfront - allow better run-time configuration

Ravi Chandra Sadineni (2):
      Input: cros_ec_keyb - remove check before calling pm_wakeup_event
      Input: i8042 - increment wakeup_count for the respective port

Sebastian Andrzej Siewior (1):
      Input: iforce - use GFP_KERNEL in iforce_get_id_packet()

Tim Schumacher (3):
      Input: iforce - reformat the packet dump output
      Input: iforce - assign BTN_DEAD only for specific devices
      Input: iforce - reorganize joystick configuration lists

Vinod Koul (2):
      Input: pm8941-pwrkey - abstract register offsets and event code
      Input: pm8941-pwrkey - add resin entry

Zhu Yi (1):
      Input: add bu21029 touch driver

Diffstat:
--------

 Documentation/devicetree/bindings/input/keys.txt   |   8 +
 .../bindings/input/qcom,pm8941-pwrkey.txt          |  10 +
 .../bindings/input/touchscreen/bu21029.txt         |  35 ++
 .../devicetree/bindings/input/touchscreen/eeti.txt |  30 ++
 MAINTAINERS                                        |   7 +
 drivers/input/evbug.c                              |   4 -
 drivers/input/evdev.c                              |  16 +-
 drivers/input/gameport/emu10k1-gp.c                |   4 -
 drivers/input/gameport/lightning.c                 |   4 -
 drivers/input/gameport/ns558.c                     |   4 -
 drivers/input/input.c                              |  16 +-
 drivers/input/joystick/a3d.c                       |   4 -
 drivers/input/joystick/adi.c                       |   4 -
 drivers/input/joystick/amijoy.c                    |   4 -
 drivers/input/joystick/analog.c                    |   4 -
 drivers/input/joystick/cobra.c                     |   4 -
 drivers/input/joystick/db9.c                       |   9 +-
 drivers/input/joystick/gamecon.c                   |   4 -
 drivers/input/joystick/gf2k.c                      |   4 -
 drivers/input/joystick/grip.c                      |   4 -
 drivers/input/joystick/guillemot.c                 |   4 -
 drivers/input/joystick/iforce/iforce-ff.c          |   8 +-
 drivers/input/joystick/iforce/iforce-main.c        |  30 +-
 drivers/input/joystick/iforce/iforce-packets.c     |  16 +-
 drivers/input/joystick/iforce/iforce-serio.c       |   4 -
 drivers/input/joystick/iforce/iforce-usb.c         |   4 -
 drivers/input/joystick/iforce/iforce.h             |   6 +-
 drivers/input/joystick/interact.c                  |   4 -
 drivers/input/joystick/joydump.c                   |   4 -
 drivers/input/joystick/magellan.c                  |   4 -
 drivers/input/joystick/pxrc.c                      | 166 +++----
 drivers/input/joystick/sidewinder.c                |   4 -
 drivers/input/joystick/spaceball.c                 |   4 -
 drivers/input/joystick/spaceorb.c                  |   4 -
 drivers/input/joystick/stinger.c                   |   4 -
 drivers/input/joystick/tmdc.c                      |   4 -
 drivers/input/joystick/turbografx.c                |   4 -
 drivers/input/joystick/warrior.c                   |   4 -
 drivers/input/keyboard/adp5589-keys.c              |   1 +
 drivers/input/keyboard/amikbd.c                    |   4 -
 drivers/input/keyboard/atakbd.c                    |   4 -
 drivers/input/keyboard/cros_ec_keyb.c              |  69 +--
 drivers/input/keyboard/gpio_keys.c                 |   8 +-
 drivers/input/keyboard/imx_keypad.c                |  12 +-
 drivers/input/keyboard/newtonkbd.c                 |   4 -
 drivers/input/keyboard/snvs_pwrkey.c               |  15 +-
 drivers/input/keyboard/stowaway.c                  |   4 -
 drivers/input/keyboard/sunkbd.c                    |   4 -
 drivers/input/keyboard/xtkbd.c                     |   4 -
 drivers/input/misc/keyspan_remote.c                |   2 +-
 drivers/input/misc/pm8941-pwrkey.c                 |  70 ++-
 drivers/input/misc/powermate.c                     |   2 +-
 drivers/input/misc/xen-kbdfront.c                  | 183 ++++----
 drivers/input/misc/yealink.c                       |   4 +-
 drivers/input/mouse/appletouch.c                   |   7 +-
 drivers/input/mouse/cyapa_gen5.c                   |   1 +
 drivers/input/mouse/cyapa_gen6.c                   |   1 +
 drivers/input/mouse/elan_i2c_smbus.c               |   2 +-
 drivers/input/mouse/elantech.c                     |   2 +-
 drivers/input/mouse/inport.c                       |   4 -
 drivers/input/mouse/logibm.c                       |   4 -
 drivers/input/mouse/pc110pad.c                     |   4 -
 drivers/input/mouse/sermouse.c                     |   8 +-
 drivers/input/serio/ct82c710.c                     |   4 -
 drivers/input/serio/i8042.c                        |   3 +
 drivers/input/serio/q40kbd.c                       |   4 -
 drivers/input/serio/rpckbd.c                       |   4 -
 drivers/input/serio/serio.c                        |   4 -
 drivers/input/tablet/aiptek.c                      |   2 +-
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/atmel_mxt_ts.c           | 223 +++++-----
 drivers/input/touchscreen/bu21029_ts.c             | 484 +++++++++++++++++++++
 drivers/input/touchscreen/eeti_ts.c                |  37 +-
 drivers/input/touchscreen/egalax_ts.c              |   5 +-
 drivers/input/touchscreen/elo.c                    |   1 +
 drivers/input/touchscreen/fsl-imx25-tcq.c          |  21 +-
 drivers/input/touchscreen/gunze.c                  |   4 -
 drivers/input/touchscreen/imx6ul_tsc.c             |  14 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |   4 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |   2 +-
 drivers/md/dm-raid.c                               |   6 +-
 drivers/md/md-bitmap.c                             | 305 +++++++------
 drivers/md/md-bitmap.h                             |  60 +--
 drivers/md/md-cluster.c                            |  18 +-
 drivers/md/md.c                                    |  44 +-
 drivers/md/persistent-data/dm-space-map-common.c   |  20 +-
 drivers/md/raid1.c                                 |  35 +-
 drivers/md/raid10.c                                |  52 ++-
 drivers/md/raid5-cache.c                           |   8 +-
 drivers/md/raid5.c                                 |  44 +-
 include/linux/bitmap.h                             |   8 +
 include/linux/gpio_keys.h                          |   2 +
 include/linux/joystick.h                           |   4 -
 include/uapi/linux/joystick.h                      |   4 -
 include/xen/interface/io/displif.h                 |   8 +
 include/xen/interface/io/kbdif.h                   |  78 +++-
 include/xen/interface/io/sndif.h                   |  10 +-
 lib/bitmap.c                                       |  20 +
 99 files changed, 1468 insertions(+), 967 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/eeti.txt
 create mode 100644 drivers/input/touchscreen/bu21029_ts.c

Thanks.


-- 
Dmitry
