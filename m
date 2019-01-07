Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519BDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3042087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfAGOoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:44:02 -0500
Received: from foss.arm.com ([217.140.101.70]:60790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfAGOoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:44:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30DB780D;
        Mon,  7 Jan 2019 06:44:01 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84FC23F5AF;
        Mon,  7 Jan 2019 06:43:59 -0800 (PST)
Date:   Mon, 7 Jan 2019 14:43:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, mingo@redhat.com,
        rostedt@goodmis.org, akpm@linux-foundation.org, broonie@kernel.org
Subject: Re: [RFC PATCH 3/3] arm64: add a new config option KTEST_RUNNABLE
Message-ID: <20190107144356.GB46743@lakrids.cambridge.arm.com>
References: <20181213122910.24193-1-anders.roxell@linaro.org>
 <20181213122910.24193-4-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213122910.24193-4-anders.roxell@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a general thing, please Cc LAKML on patches for arm64.

On Thu, Dec 13, 2018 at 01:29:10PM +0100, Anders Roxell wrote:
> With this new config option, we can boot a allmodconfig kernel in qemu.
> Config options SERIAL_AMBA_PL011, SERIAL_AMBA_PL011_CONSOLE, UNIX needs
> to be enabled in order to get a console. Options like CPU_BIG_ENDIAN,
> CMDLINE_FORCE, CMDLINE_OVERRIDE and HVC_DCC needs to be disabled.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/Kconfig      | 8 ++++++++
>  drivers/tty/hvc/Kconfig | 1 +
>  init/Kconfig            | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1f52362f8d99..bb17ccb7bab2 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -292,6 +292,12 @@ config ARCH_SUPPORTS_UPROBES
>  config ARCH_PROC_KCORE_TEXT
>  	def_bool y
>  
> +config KTEST_RUNNABLE
> +	bool "Test build kernels that run in qemu for ktest"
> +	select SERIAL_AMBA_PL011
> +	select SERIAL_AMBA_PL011_CONSOLE
> +	select UNIX
> +

As Mark Brown points out, the PL011 bits are platform-specific, and
don't directly relate to ktest.

The UNIX part is simply because that can be built as a module.

Is it possible to use an allyesconfig rather than an allmodconfig? That
would leave all relevant options built-in.

> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 4293c172e120..44e23c2388bd 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -82,6 +82,7 @@ config HVC_UDBG
>  config HVC_DCC
>         bool "ARM JTAG DCC console"
>         depends on ARM || ARM64
> +	depends on !KTEST_RUNNABLE
>         select HVC_DRIVER
>         help
>           This console uses the JTAG DCC on ARM to create a console under the HVC

... this is just a hack around the DCC driver being dodgy.

We should fix that to only probe if explicitly requested at run-time via
a command line argument.

Thanks,
Mark.
