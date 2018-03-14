Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCNPIB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:08:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51483 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbeCNPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:08:00 -0400
Date: Wed, 14 Mar 2018 16:07:43 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
cc: x86@kernel.org, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
        anshuman.gupta@intel.com, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v2] x86: i8237: Register based on FADT legacy boot flag
In-Reply-To: <1521004627-30329-1-git-send-email-rajneesh.bhardwaj@intel.com>
Message-ID: <alpine.DEB.2.21.1803141603190.2481@nanos.tec.linutronix.de>
References: <1521004627-30329-1-git-send-email-rajneesh.bhardwaj@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Rajneesh Bhardwaj wrote:
>  static int __init i8237A_init_ops(void)
>  {
> +	/*
> +	 * From SKL PCH onwards, the port 0x61 bit 4 would stop toggle and

s/would stop toggle/stops toggling/

You are describing a fact, right?

> +	 * the legacy DMA device is removed in which the I/O ports (81h-83h,
> +	 * 87h, 89h-8Bh, 8Fh)  related to it are removed as well. All
> +	 * removed ports must return 0xff for a inb() request.
> +	 *
> +	 * Note: DMA_PAGE_2 (port 0x81) should not be checked for detecting
> +	 * the presence of DMA device since it may be used by BIOS to decode
> +	 * LPC traffic for POST codes. Original LPC only decodes one byte of
> +	 * port 0x80 but some BIOS may choose to enhance PCH LPC port 0x8x
> +	 * decoding.
> +	 */
> +	if (dma_inb(DMA_PAGE_0) == 0xFF)
> +		return -ENODEV;
> +
> +	/*
> +	 * It should be OK to not load this driver as newer SoC may not

Should? Is this based on facts or hope?

> +	 * support 8237 DMA or bus mastering from LPC. Platform firmware
> +	 * must announce the support for such legacy devices via
> +	 * ACPI_FADT_LEGACY_DEVICES field in FADT table.
> +	 */
> +	if (!x86_platform.legacy.devices.pnpbios && dmi_get_bios_year() >= 2017)

Please use arch_pnpbios_disabled() and explain why you need that year
check. If there is no pnpbios then why is the year interesting and why
would anyone trust something which comes from BIOS?

Thanks,

	tglx
