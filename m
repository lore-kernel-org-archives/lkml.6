Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbeEVTlq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:41:46 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:44254 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbeEVTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:41:44 -0400
Date: Tue, 22 May 2018 22:41:39 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com,
        abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: v4.17-rc1: regressions on N900, N950
Message-ID: <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd>
 <20180522080250.4fzyvqrgw5oigexn@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180522080250.4fzyvqrgw5oigexn@pali>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 22, 2018 at 10:02:50AM +0200, Pali Rohár wrote:
> Hi! I remember that in time of migration from platform board code to
> device tree structures there appeared some bug which caused that
> sometimes display were not initialized. And somebody figured out that
> display initialization is failing when some other SPI devices are
> initialized before or after display... This behavior was observed only
> on real N900 hardware, not in qemu.

Touchscreen needs to be initialized before display. This is documented
in the DTS, see arch/arm/boot/dts/omap3-n900.dts:

	* For some reason, touchscreen is necessary for screen to work at
	* all on real hw. It works well without it on emulator.
	*
	* Also... order in the device tree actually matters here.

> Real reason was never explained. In old platform board code there was
> hardcoded order of SPI devices in which initialization happened. And in
> device tree it is probably in (pseudo)-random order. Enabling/disabling
> various config option can affect some timings and order in which kernel
> starts probing and initializing devices...

The issue was also somewhat present with platform/board code, see e.g.
commit e65f131a14726e5f1b880a528271a52428e5b3a5.

My device worked with v4.17-rc1 (haven't found time to test newer kernels),
but if you say the probe order is random then we must find some proper way
to express the dependency.

A.
