Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeCJSI7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:08:59 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41304 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbeCJSI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:08:58 -0500
X-Google-Smtp-Source: AG47ELst3VDOMjDLH7qLeyUjxyd04TrbQuNB2qnlnD+/gmxNhQuayZQUdPRUI2AB2ph077zGQn7zmm3ZN360Kaqtc/0=
MIME-Version: 1.0
In-Reply-To: <87po4kglgv.fsf@concordia.ellerman.id.au>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-4-malat@debian.org>
 <87po4kglgv.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Sat, 10 Mar 2018 19:08:37 +0100
X-Google-Sender-Auth: 1iPydjinM1ZwzM_ixwe7zyLapyk
Message-ID: <CA+7wUswMObjDxYO-3TXsM2jLkKR=pnweSpqO37_H6id91i_dZQ@mail.gmail.com>
Subject: Re: [PATCH 03/21] powerpc: Mark the variable earlycon_acpi_spcr_enable
 maybe_unused
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2AI94rg004159

On Sun, Mar 4, 2018 at 11:54 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Mathieu Malaterre <malat@debian.org> writes:
>
>> Re-use the object-like macro EARLYCON_USED_OR_UNUSED to mark
>> `earlycon_acpi_spcr_enable` as maybe_unused.
>>
>> Fix the following warning (treated as error in W=1)
>>
>>   CC      arch/powerpc/kernel/setup-common.o
>> In file included from ./include/linux/serial_8250.h:14:0,
>>                  from arch/powerpc/kernel/setup-common.c:33:
>> ./include/linux/serial_core.h:382:19: error: ‘earlycon_acpi_spcr_enable’ defined but not used [-Werror=unused-const-variable=]
>>  static const bool earlycon_acpi_spcr_enable;
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>  include/linux/serial_core.h | 1 +
>
> I can't take this one as that's not a file I maintain.
>
> The script says:
>
>   $ ./scripts/get_maintainer.pl include/linux/serial_core.h
>   gregkh@linuxfoundation.org
>   jslaby@suse.com
>   linux-kernel@vger.kernel.org
>
>
> Can you resend it to them?

Ah right, thanks.
>
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> index b32df49a3bd5..4d14ecd7dbe8 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -379,6 +379,7 @@ extern int of_setup_earlycon(const struct earlycon_id *match,
>>  extern bool earlycon_acpi_spcr_enable __initdata;
>>  int setup_earlycon(char *buf);
>>  #else
>> +EARLYCON_USED_OR_UNUSED
>>  static const bool earlycon_acpi_spcr_enable;
>
> The macro eventually turns into an __attribute__, which I think is
> typically placed after the variable, so eg:
>
>   static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
>

Indeed makes it more consistent with style.  Thanks!

> cheers
>
>>  static inline int setup_earlycon(char *buf) { return 0; }
>>  #endif
>> --
>> 2.11.0
