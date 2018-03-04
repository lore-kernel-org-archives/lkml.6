Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeCDKyN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 05:54:13 -0500
Received: from ozlabs.org ([103.22.144.67]:57687 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeCDKyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 05:54:12 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 03/21] powerpc: Mark the variable earlycon_acpi_spcr_enable maybe_unused
In-Reply-To: <20180225172236.29650-4-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-4-malat@debian.org>
Date: Sun, 04 Mar 2018 21:54:08 +1100
Message-ID: <87po4kglgv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:

> Re-use the object-like macro EARLYCON_USED_OR_UNUSED to mark
> `earlycon_acpi_spcr_enable` as maybe_unused.
>
> Fix the following warning (treated as error in W=1)
>
>   CC      arch/powerpc/kernel/setup-common.o
> In file included from ./include/linux/serial_8250.h:14:0,
>                  from arch/powerpc/kernel/setup-common.c:33:
> ./include/linux/serial_core.h:382:19: error: ‘earlycon_acpi_spcr_enable’ defined but not used [-Werror=unused-const-variable=]
>  static const bool earlycon_acpi_spcr_enable;
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  include/linux/serial_core.h | 1 +

I can't take this one as that's not a file I maintain.

The script says:

  $ ./scripts/get_maintainer.pl include/linux/serial_core.h
  gregkh@linuxfoundation.org
  jslaby@suse.com
  linux-kernel@vger.kernel.org


Can you resend it to them?

> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index b32df49a3bd5..4d14ecd7dbe8 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -379,6 +379,7 @@ extern int of_setup_earlycon(const struct earlycon_id *match,
>  extern bool earlycon_acpi_spcr_enable __initdata;
>  int setup_earlycon(char *buf);
>  #else
> +EARLYCON_USED_OR_UNUSED
>  static const bool earlycon_acpi_spcr_enable;

The macro eventually turns into an __attribute__, which I think is
typically placed after the variable, so eg:

  static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;


cheers

>  static inline int setup_earlycon(char *buf) { return 0; }
>  #endif
> -- 
> 2.11.0
