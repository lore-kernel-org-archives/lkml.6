Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D121C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD6620868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KiriFpDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD6620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLGSa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:30:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45122 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeLGSa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:30:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so2182329plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=W8EggpNqVluQivnmp6iZyHVmDWnm/JueOezDzfiTuXY=;
        b=KiriFpDDC62/TPlCCHB38BoU4fopb6xpYfvpq0tsEGPUtcVrl+hteWe/GR4EArFjoq
         nQ+ptd8mJGKvr6djt5v+QmQhmw0PRZ1XVTQ4JqoNl4IfNVEZIgQhp1hOH4ANC4BzjU5V
         JMjUglB70auPStIAyviDxc5VK7ZmRb9bOCaauDVob8Mi1sfC2nr1P5mYw0NqisMtNEg2
         y38U4pOhJeAk26h4q7UbWVvK25wZQK32TiXPQcUtCY6zuJn6cGn0aBqE42yoBIbjlalz
         AKSi00FjJyQZd3tcuT22w/8miAHXprCyWrkxNIvl7VLOA3tdlhE7+3qI/Nz4DmVbE7FC
         sIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=W8EggpNqVluQivnmp6iZyHVmDWnm/JueOezDzfiTuXY=;
        b=k+0qoDaIbEFQSRCDtyrjAXAOMmd01OzhpunBxS1JRIQNQ6802sF32tpU60+yK+1lhy
         1hyW36iSKhqOH0mC66JjNa2i+dnXtqzFpbNOFf768lgIeYmd7uWm9fkIb7/im3nFPDG0
         qjG1s+VClzRveAae11rfOK1RRYLJdC1izY3fx0B2y1CTAlfGagSqIdRpKukDa2IXLppK
         H0zX1owcMOfDWO67fdYmneAnTIQBAPLDd1mC19n+R8p/B07su+kx0Nvol/aSuj5rAfLO
         p5jQw+Hygk6xN2U6GIcVTIQ8eGJrsPb4RYXkK239CyAszGHQqFHzqOdWjY2ahABn0pP8
         1eWw==
X-Gm-Message-State: AA+aEWaVhdO/WsBBYFknZ5MsnjqoQiDdHZQmFphyyQi7Y5AvmNBvb9Sg
        bjcdoPdyLAPqbSrmqlUwFng/iw==
X-Google-Smtp-Source: AFSGD/Xi/eZBBPy6a3ucsqeinj+9pPNX9MIWjSNXajUSVyZJ+Cb1hfLf6sMgxUT+MvxLSBeJD7gLvA==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr3067158plb.41.1544207428755;
        Fri, 07 Dec 2018 10:30:28 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id g190sm4641158pgc.28.2018.12.07.10.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:30:27 -0800 (PST)
Date:   Fri, 07 Dec 2018 10:30:27 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 10:12:36 PST (-0800)
Subject:     Re: [PATCH 1/3] tty/serial: Add RISC-V SBI earlycon support
In-Reply-To: <20181204135507.3706-2-anup@brainfault.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-03b5ef96-37b8-4a95-94fa-2fb5e8e59da3@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018 05:55:05 PST (-0800), anup@brainfault.org wrote:
> In RISC-V, the M-mode runtime firmware provide SBI calls for
> debug prints. This patch adds earlycon support using RISC-V
> SBI console calls. To enable it, just pass "earlycon=sbi" in
> kernel parameters.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  drivers/tty/serial/Kconfig              | 12 +++++++++++
>  drivers/tty/serial/Makefile             |  1 +
>  drivers/tty/serial/earlycon-riscv-sbi.c | 28 +++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>  create mode 100644 drivers/tty/serial/earlycon-riscv-sbi.c
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 32886c304641..287bb41ac814 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -85,6 +85,18 @@ config SERIAL_EARLYCON_ARM_SEMIHOST
>  	  with "earlycon=smh" on the kernel command line. The console is
>  	  enabled when early_param is processed.
>
> +config SERIAL_EARLYCON_RISCV_SBI
> +	bool "Early console using RISC-V SBI"
> +	depends on RISCV
> +	select SERIAL_CORE
> +	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
> +	help
> +	  Support for early debug console using RISC-V SBI. This enables
> +	  the console before standard serial driver is probed. This is enabled
> +	  with "earlycon=sbi" on the kernel command line. The console is
> +	  enabled when early_param is processed.
> +
>  config SERIAL_SB1250_DUART
>  	tristate "BCM1xxx on-chip DUART serial support"
>  	depends on SIBYTE_SB1xxx_SOC=y
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index daac675612df..3ce26ce08616 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_SERIAL_CORE) += serial_core.o
>
>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
>  obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
> +obj-$(CONFIG_SERIAL_EARLYCON_RISCV_SBI) += earlycon-riscv-sbi.o
>
>  # These Sparc drivers have to appear before others such as 8250
>  # which share ttySx minor node space.  Otherwise console device
> diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
> new file mode 100644
> index 000000000000..e1a551aae336
> --- /dev/null
> +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RISC-V SBI based earlycon
> + *
> + * Copyright (C) 2018 Anup Patel <anup@brainfault.org>
> + */
> +#include <linux/kernel.h>
> +#include <linux/console.h>
> +#include <linux/init.h>
> +#include <linux/serial_core.h>
> +#include <asm/sbi.h>
> +
> +static void sbi_console_write(struct console *con,
> +			      const char *s, unsigned int n)
> +{
> +	int i;
> +
> +	for (i = 0; i < n; ++i)
> +		sbi_console_putchar(s[i]);
> +}
> +
> +static int __init early_sbi_setup(struct earlycon_device *device,
> +				  const char *opt)
> +{
> +	device->con->write = sbi_console_write;
> +	return 0;
> +}
> +EARLYCON_DECLARE(sbi, early_sbi_setup);

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
