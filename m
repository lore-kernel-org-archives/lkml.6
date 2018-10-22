Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BDBC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB9420658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgdjGePI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB9420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeJVQ6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:58:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44614 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeJVQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:58:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id r9-v6so19543866pff.11;
        Mon, 22 Oct 2018 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=LvbhU9UTjOxV33lut41vK6lqH+A+7QDqcYBP8j9AON8=;
        b=qgdjGePIfYoiYg/THSJDqo40dngwpS90NJ8yNGHga6Ba6yYGsY3Wg8iLB6HKsbzEok
         weGu36yW/O8Tso0moFUNp6ahSxZfUFhaOMm9nuvOfwhGuKIuzE80WCv/iXUVYjVSD/S0
         933GFnKoRLW9splmh1wvfTDzgpTEFKpQelu3ZuRXFv6oq4uEeWlvLHj+RWi9mGMY1gM1
         UK+ioJ81fHVZF5+aECCRFDw0GKRzG8vnWodr0gHjIBYfbAzOhVauwUD0O//4PGyBhalH
         sZyJxAQ5gSfoON0tm5VpnDKeMm3ZE2STHJ8ji+cbZJ9b2l/9RbtP7t3HNSmcLZ2up5iE
         3vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=LvbhU9UTjOxV33lut41vK6lqH+A+7QDqcYBP8j9AON8=;
        b=WxUyphq9mrrFFjmlY98x9MZnhO+l5DHYA0Q8xT0uewFpVucjklw/rzUovDlFD07SRa
         uyCldZA5JVF9n3ZMpcKkiNpj8Blr62o0xZieZ5QmiFDxUFaUSHEiUl2wKesYuKbPBy0T
         Z6qcwpCzocKeaKtZUGDDbw4v+vyMIZJ+hqWvtpt6TGTdG/97vNA8a1zW9GpEjrnVPSl2
         fJPzOXYGBBo3we2TOWxrCAxA/bDpmklVdCTlv6jMtmCPcql3she131s/W/lvvx8g1p6r
         7z0cSeZbX9ARMfRMPzInCd56r6xBStaoFDn3M8nxUR5cpIgSr1K+6CqTGi53POTJAZt6
         GLLw==
X-Gm-Message-State: ABuFfohE8sUhAbeYSdKDs1zU0mBBTVoZ7UaTRFnPEx7fIyGO/LxN2e+W
        wS1sIBtwUDfUM47P6s4H+qA=
X-Google-Smtp-Source: ACcGV63PbtkfZi/fT/ZVrO06g9GYvxaxsx+Uig/ra4xJpO73+6tfAOQauJLuATRrSaGH+kVnlH+4ZA==
X-Received: by 2002:a62:3106:: with SMTP id x6-v6mr35210724pfx.154.1540197663572;
        Mon, 22 Oct 2018 01:41:03 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v189-v6sm40767793pfb.54.2018.10.22.01.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 01:41:02 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v4.20
Date:   Mon, 22 Oct 2018 01:41:01 -0700
Message-Id: <1540197661-10496-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v4.20 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v4.20

Thanks,
Guenter
------

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v4.20

for you to fetch changes up to e7c6a55606b5c46b449d76588968b4d8caae903f:

  hwmon: (pmbus) Fix page count auto-detection. (2018-10-15 12:44:36 -0700)

----------------------------------------------------------------
hwmon updates for v4.20

- Add support for trace events to hwmon core
- Add support for NCT6797D, NCT6798D, MAX31725/6, LTM4686
- Support all AMD Family 15h Model 6xh and Model 7xh processors
  in k10temp driver
- Convert ina3221 driver to _info API
- Fixes, cleanups, and improvements in various drivers.

----------------------------------------------------------------
Arnd Bergmann (1):
      hwmon: (ina3221) mark PM functions as __maybe_unused

Bartlomiej Zolnierkiewicz (1):
      hwmon: (pmbus) remove redundant 'default n' from Kconfig

Colin Ian King (1):
      hwmon: (tmp421) make const array 'names' static

Dan Carpenter (1):
      hwmon: (nct6775) Clean up a condition

Dmitry Bazhenov (1):
      hwmon: (pmbus) Fix page count auto-detection.

Fabio Estevam (4):
      hwmon: (mc13783-adc) Remove the mention to 'Atlas'
      hwmon: (mc13783-adc) Use nxp.com URLs
      hwmon: (mc13783-adc) Switch to SPDX identifier
      hwmon: (sht15) Switch to SPDX identifier

Guenter Roeck (18):
      hwmon: (iio_hwmon) Do not duplicate or sanitize fixed string
      hwmon: (k10temp) Support all Family 15h Model 6xh and Model 7xh processors
      hwmon: (lm92) Fix whitespace issues
      hwmon: (nct6775) Only display fan speed tolerance conditionally
      hwmon: (nct6775) Rename configuration register variables
      hwmon: (nct6775) Replace 'regval' with variables named after config registers
      hwmon: (nct6775) Move config variable declarations and initializations
      hwmon: (nct6775) Declare and initialize LDN specific config variables earlier
      hwmon: (nct6775) Use logical or instead of if statements where possible
      hwmon: (nct6775) Improve instruction grouping
      hwmon: (nct6775) Fix fan6/pwm6 detection for NCT6792D
      hwmon: (nct6775) Separate fan/pwm configuration detection for NCT6793D
      hwmon: (nct6775) Separate fan/pwm configuration detection for NCT6795D
      hwmon: (nct6796) Clean up and amend fan/pwm configuration for NCT6796D
      hwmon: (nct6775) Fix names of DIMM temperature sources
      hwmon: (nct6775) Add support for NCT6797D
      hwmon: (nct6775) Add support for NCT6798D
      MAINTAINERS: Update PMBUS maintainer entry

Kun Yi (2):
      hwmon: (lm75) Add MAX31725/6 support
      hwmon: (npcm-750-pwm-fan) Change initial pwm target to 255

Michael Hennerich (1):
      drivers: hwmon: (pmbus/ltc2978) Add support for LTM4686 uModule

Nathan Chancellor (1):
      hwmon: (scmi) Remove redundant pointer check

Nicolin Chen (9):
      hwmon: (ina3221) Add INA3221_CONFIG to volatile_table
      hwmon: (ina3221) Fix INA3221_CONFIG_MODE macros
      hwmon: (ina3221) Add suspend and resume functions
      dt-bindings: hwmon: Add ina3221 documentation
      hwmon: (ina3221) Read channel input source info from DT
      hwmon: (core) Add hwmon_in_enable attribute
      hwmon: (ina3221) Validate shunt resistor value from DT
      hwmon: (ina3221) Use _info API to register hwmon device
      hwmon: (core) Add trace events to _attr_show/store functions

Rob Herring (2):
      hwmon: Convert to using %pOFn instead of device_node.name
      hwmon: (ibmpowernv) drop unnecessary OF name NULL checks

Thierry Reding (2):
      hwmon: (pwm-fan) Silence error on probe deferral
      hwmon: (pwm-fan) Set fan speed to 0 on suspend

zhong jiang (2):
      hwmon: (asus_atk0110) Use PTR_ERR_OR_ZERO instead of reimplementing its function
      hwmon: (scpi-hwmon) remove redundant continue

 .../devicetree/bindings/hwmon/ina3221.txt          |  44 ++
 .../devicetree/bindings/hwmon/ltc2978.txt          |   2 +
 Documentation/hwmon/ina3221                        |   2 +
 Documentation/hwmon/lm75                           |   6 +-
 Documentation/hwmon/ltc2978                        |   5 +
 Documentation/hwmon/mc13783-adc                    |   8 +-
 MAINTAINERS                                        |  27 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |   2 +-
 drivers/hwmon/asus_atk0110.c                       |   4 +-
 drivers/hwmon/hwmon.c                              |  28 +-
 drivers/hwmon/ibmpowernv.c                         |  10 +-
 drivers/hwmon/iio_hwmon.c                          |  16 +-
 drivers/hwmon/ina3221.c                            | 592 ++++++++++++++-------
 drivers/hwmon/k10temp.c                            |   5 +-
 drivers/hwmon/lm75.c                               |  18 +-
 drivers/hwmon/lm92.c                               |  14 +-
 drivers/hwmon/mc13783-adc.c                        |  14 +-
 drivers/hwmon/nct6775.c                            | 302 +++++++----
 drivers/hwmon/npcm750-pwm-fan.c                    |   4 +-
 drivers/hwmon/pmbus/Kconfig                        |  18 +-
 drivers/hwmon/pmbus/ltc2978.c                      |   9 +-
 drivers/hwmon/pmbus/pmbus.c                        |   2 +
 drivers/hwmon/pmbus/pmbus_core.c                   |   5 +-
 drivers/hwmon/pwm-fan.c                            |  20 +-
 drivers/hwmon/scmi-hwmon.c                         |   2 +-
 drivers/hwmon/scpi-hwmon.c                         |   4 +-
 drivers/hwmon/sht15.c                              |   5 +-
 drivers/hwmon/tmp421.c                             |   6 +-
 include/linux/hwmon.h                              |   2 +
 include/trace/events/hwmon.h                       |  71 +++
 30 files changed, 878 insertions(+), 369 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt
 create mode 100644 include/trace/events/hwmon.h
