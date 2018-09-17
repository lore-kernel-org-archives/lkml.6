Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8574ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DA9206B2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DA9206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeIQNVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:21:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:17546 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbeIQNVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:21:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 00:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,384,1531810800"; 
   d="scan'208";a="90694825"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 17 Sep 2018 00:55:31 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 17 Sep 2018 10:55:29 +0300
Date:   Mon, 17 Sep 2018 10:55:29 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        casey.g.bowman@intel.com,
        "Atwood, Matthew S" <matthew.s.atwood@intel.com>
Subject: Re: pinctrl-icelake: driver writes to wrong offsets?
Message-ID: <20180917075529.GJ14465@lahna.fi.intel.com>
References: <CACK8Z6ECjwWqDnaXKrmEbEXzmiX41Sbzys=FSCqMwh8eYLPH9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6ECjwWqDnaXKrmEbEXzmiX41Sbzys=FSCqMwh8eYLPH9A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 05:18:34PM -0700, Rajat Jain wrote:
> Hi,
> 
> This is to report what I think is a problem in the pinctrl-icelake
> driver. It seems that when trying to control GPIO pins GPP_A* and
> GPIO_B*, the driver ends up writing to incorrect PADCFG registers.
> I've reached this conclusion by putting debug prints in the driver,
> although this can be seen by the following commands too. Please let me
> know if something is wrong in my experiments. For example, when trying
> to control GPP_B8/ISH_I2C1_SCL, the driver ends up writing to
> GPP_A6/ESPI_RESETB registers.
> 
> I want to control the pin GPP_B8 i.e. ISH_I2C1_SCL and drive it low or
> high. I looked at the driver code, and it tells me that I need to use
> pin number 16:
> 
> static const struct pinctrl_pin_desc icllp_pins[] = {
>        ....
>         /* GPP_B */
>        ....
>         PINCTRL_PIN(16, "ISH_I2C1_SCL"),
>        .....
> 
> The pin number 16 is mapped to GPIO 224 as per the below output:
> 
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/gpio-ranges
> GPIO ranges handled:
> 0: INT3455:00 GPIOS [184 - 191] PINS [0 - 7]
> 32: INT3455:00 GPIOS [216 - 241] PINS [8 - 33]
> 64: INT3455:00 GPIOS [248 - 272] PINS [34 - 58]
> 96: INT3455:00 GPIOS [280 - 303] PINS [59 - 82]
> 128: INT3455:00 GPIOS [312 - 332] PINS [83 - 103]
> 160: INT3455:00 GPIOS [344 - 363] PINS [104 - 123]
> 192: INT3455:00 GPIOS [376 - 404] PINS [124 - 152]
> 224: INT3455:00 GPIOS [408 - 431] PINS [153 - 176]
> 256: INT3455:00 GPIOS [440 - 463] PINS [183 - 206]
> 288: INT3455:00 GPIOS [472 - 479] PINS [216 - 223]
> 320: INT3455:00 GPIOS [504 - 511] PINS [224 - 231]
> localhost /sys/class/gpio #
> 
> So I did this:
> 
> localhost /sys/class/gpio # ls
> export  gpiochip184  unexport
> localhost /sys/class/gpio # cat gpiochip184/label
> INT3455:00
> localhost /sys/class/gpio # cat gpiochip184/ngpio
> 328
> localhost /sys/class/gpio # echo 224 > export
> localhost /sys/class/gpio # ls
> export  gpio224  gpiochip184  unexport
> localhost /sys/class/gpio #
> 
> Before trying to change the value, I decided to take a dump of the
> PADCFG of the pins before and after I tried to change it. Here is the
> dump I took before changing:
> 
> localhost /sys/class/gpio # cat gpio224/active_low
> 0
> localhost /sys/class/gpio # cat gpio224/direction
> in
> localhost /sys/class/gpio # cat gpio224/edge
> none
> localhost /sys/class/gpio # cat gpio224/value
> 0
> localhost /sys/class/gpio #
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
> "ISH_I2C1_SCL\|ESPI_RESETB"
> pin 16 (ISH_I2C1_SCL) GPIO 0x44000102 0x00000028 0x00000000 [ACPI]
> pin 40 (ESPI_RESETB) mode 1 0x44000700 0x0000003e 0x00000100 [ACPI]
> localhost /sys/class/gpio #
> 
> Here is when I tried to change it and then dump the values again:
> 
> localhost /sys/class/gpio # echo out > gpio224/direction
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
> "ISH_I2C1_SCL\|ESPI_RESETB"
> pin 16 (ISH_I2C1_SCL) GPIO 0x44000200 0x00000028 0x00000000 [ACPI]
> pin 40 (ESPI_RESETB) mode 1 0x44000700 0x0000003e 0x00000100 [ACPI]
> localhost /sys/class/gpio #
> 
> Note that things look good so far (the PADCFG DW0 for pin 16 is
> corrrectly changed).
> But now when I try to write the value, it is the PADCFG DW0 for pin 40
> that gets written to, while the pin16 value does not change:
> 
> localhost /sys/class/gpio #
> localhost /sys/class/gpio # echo 1 > gpio224/value
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
> "ISH_I2C1_SCL\|ESPI_RESETB"
> pin 16 (ISH_I2C1_SCL) GPIO 0x44000200 0x00000028 0x00000000 [ACPI]
> pin 40 (ESPI_RESETB) mode 1 0x44000701 0x0000003e 0x00000100 [ACPI]
> localhost /sys/class/gpio #
> localhost /sys/class/gpio #
> localhost /sys/class/gpio # echo 0 > gpio224/value
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
> "ISH_I2C1_SCL\|ESPI_RESETB"
> pin 16 (ISH_I2C1_SCL) GPIO 0x44000200 0x00000028 0x00000000 [ACPI]
> pin 40 (ESPI_RESETB) mode 1 0x44000700 0x0000003e 0x00000100 [ACPI]
> localhost /sys/class/gpio #
> localhost /sys/class/gpio # echo 1 > gpio224/value
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
> "ISH_I2C1_SCL\|ESPI_RESETB"
> pin 16 (ISH_I2C1_SCL) GPIO 0x44000200 0x00000028 0x00000000 [ACPI]
> pin 40 (ESPI_RESETB) mode 1 0x44000701 0x0000003e 0x00000100 [ACPI]
> localhost /sys/class/gpio #
> localhost /sys/class/gpio #
> 
> I have also verified this using an oscilloscope on the external pin
> that the ISH_I2C1_SCL does not change. Also the gpio224/value stays
> stuck at 0.
> 
> localhost /sys/class/gpio # cat gpio224/value
> 0
> localhost /sys/class/gpio #
> 
> I failed to understand how could it be that the correct pin (16) is
> picked up when setting direction but incorrect pin (40) is picked up
> when setting value. I suspect some mux related call is being missed
> out while setting the value, may be? Can you please check this at your
> end?

Do you have schematics of the system? It could be that the ISH_I2C1_SCL
is just pulled low.

Can you try some other pin that you could measure and is wired a pin
header?
