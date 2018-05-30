Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968789AbeE3JFj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:05:39 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44944 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964791AbeE3JFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:05:17 -0400
X-Google-Smtp-Source: ADUXVKIwoegqJJS9CjfF/PkTB04ugb4WZp1JTfPUHdtk/QSJYotJNG2kNlD5PMBFtbMBWJQmHnYQXg==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Wed, 30 May 2018 12:05:12 +0300
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 0/6] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <20180530090512.GC13528@localhost.localdomain>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I would like to ask for an educated opinion from more experienced
regulator driver developers.

On Wed, May 30, 2018 at 11:41:13AM +0300, Matti Vaittinen wrote:
> Patch series adding support for ROHM BD71837 PMIC.
> 
> BD71837 is a programmable Power Management IC for powering single-core,
> dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for
> low BOM cost and compact solution footprint. It integrates 8 buck
> regulators and 7 LDO’s to provide all the power rails required by the
> SoC and the commonly used peripherals.
> 
> The driver aims to not limit the usage of PMIC. Thus the buck and LDO
> naming is generic and not tied to any specific purposes. However there
> is following limitations which make it mostly suitable for use cases
> where the processor where PMIC driver is running is powered by the PMIC:
> 
> - The PMIC is not re-initialized if it resets. PMIC may reset as a
>   result of voltage monitoring (over/under voltage) or due to reset
>   request. Driver is only initializing PMIC at probe. This is not
>   problem as long as processor controlling PMIC is powered by PMIC.
> 
> - The PMIC internal state machine is ignored by driver. Driver assumes
>   the PMIC is wired so that it is always in "run" state when controlled
>   by the driver.
> 
> Changelog v4
> - remove mutex from regulator state check as core prevents simultaneous
>   accesses
> - allow voltage change for bucks 1 to 4 when regulator is enabled

This chip has 8 bucks. 4 of then support DVS (dynamic voltage scaling).
Other 4 can be used on PWM or PFM switching mode. When PWM is used
voltages can be changed without disabling regulator. On PFM this should
not be done. These latter 4 regulators can be forced to PWM mode via
control bit in register. This driver does not support controlling this
mode though. So this driver version just checks if regulator is enabled
before changing the voltage and if it is the voltage change fails with
-EBUSY

My question is whether it would be good idea to also read the 'force
PWM' bit when voltage is changed and allow the change if PWM mode is
forced to be used? Problem is that the check and voltage change can't be
atomic so there is a chance someone changes the mode (bypassing the
driver and regulator core) after this check but before we get to modify
the voltage. Furthermore, I doubt the 'force PWM' is widely used (but I
can't say for sure as I can't imagine all use cases) as it is not so
power efficient.

But as I am really inexperienced on this area I would like to get
opinions from people who know this field of industry better...

Br,
	Matti Vaittinen
