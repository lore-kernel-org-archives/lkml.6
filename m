Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A75B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A75B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeGSQD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:03:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33377 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbeGSQD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:03:26 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgAiW-0001oW-9I; Thu, 19 Jul 2018 17:19:44 +0200
Date:   Thu, 19 Jul 2018 17:19:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        mingo@redhat.com, bhe@redhat.com, keescook@chromium.org,
        yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        lcapitulino@redhat.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH v3 1/4] x86/boot: Add acpitb.h to help parse acpi
 tables
In-Reply-To: <20180717100409.10547-2-fanc.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1807191717330.1693@nanos.tec.linutronix.de>
References: <20180717100409.10547-1-fanc.fnst@cn.fujitsu.com> <20180717100409.10547-2-fanc.fnst@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, Chao Fan wrote:

> In order to parse ACPI tables, reuse the head file linux/acpi.h,
> so that the files in 'compressed' directory can read ACPI table
> by including this head file.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpitb.h | 50 +++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/acpitb.h
> 
> diff --git a/arch/x86/boot/compressed/acpitb.h b/arch/x86/boot/compressed/acpitb.h
> new file mode 100644
> index 000000000000..fd2bba23f447
> --- /dev/null
> +++ b/arch/x86/boot/compressed/acpitb.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/acpi.h>
> +
> +#define ACPI_MAX_TABLES                128
> +
> +/* Function to get ACPI SRAT table pointer. */
> +struct acpi_table_header *get_acpi_srat_table(void);
> +
> +#ifdef ACPI_BIG_ENDIAN
> +
> +#define ACPI_MOVE_64_TO_64(d, s) \
> +{((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7]; \
> +((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[6]; \
> +((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[5]; \
> +((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[4]; \
> +((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3]; \
> +((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2]; \
> +((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1]; \
> +((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }

Whats wrong with be64_to_cpu() ?

> +
> +#define ACPI_MOVE_16_TO_32(d, s) \
> +{(*(u32 *)(void *)(d)) = 0; \
> +((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1]; \
> +((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }

Huch? 

> +
> +#else
> +#ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
> +
> +#define ACPI_MOVE_64_TO_64(d, s) \
> +{*(u64 *)(void *)(d) = *(u64 *)(void *)(s); }
> +
> +#define ACPI_MOVE_16_TO_32(d, s) \
> +{*(u32 *)(void *)(d) = *(u16 *)(void *)(s); }
> +
> +#else
> +#define ACPI_MOVE_64_TO_64(d, s) \
> +{((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0]; \
> +((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1]; \
> +((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2]; \
> +((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3]; \
> +((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[4]; \
> +((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[5]; \
> +((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[6]; \
> +((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7]; }

And why doees this have to be done bytewise? Some comments would be
helpful.

Thanks,

	tglx
