Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754361AbeENHCg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:02:36 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36783 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754173AbeENHCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:02:35 -0400
X-Google-Smtp-Source: AB8JxZqHP2Ysx+kGaDQNNlurcZ1/JP+9a3oRrEImEYI4c98aWIkOvLYUVdHabWldEGmyrHkA3AC6FwbE85sXWmEowCM=
MIME-Version: 1.0
In-Reply-To: <20180514065744.GD16596@gmail.com>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
 <20180504060003.19618-13-ard.biesheuvel@linaro.org> <20180514065744.GD16596@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 14 May 2018 09:02:34 +0200
Message-ID: <CAKv+Gu8QVR_BFLMKttqfmCMqXU13grwr846oftFysB8B0CJCZw@mail.gmail.com>
Subject: Re: [PATCH 12/17] efi: fix efi_pci_io_protocol32 prototype for mixed mode
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2018 at 08:57, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> Mixed mode allows a kernel built for x86_64 to interact with 32-bit
>> EFI firmware, but requires us to define all struct definitions carefully
>> when it comes to pointer sizes. efi_pci_io_protocol32 currently uses a
>> void* for the 'romimage' field, which will be interpreted as a 64-bit
>> field on such kernels, potentially resulting in bogus memory references
>> and subsequent crashes.
>
> Yeah, so the first confusion I ran into is:
>
>  s/efi_pci_io_protocol32
>   /efi_pci_io_protocol_32
>
> Once I found it in the code I made this change:
>
>  s/efi: fix efi_pci_io_protocol32 prototype for mixed mode
>   /efi: Fix 'struct efi_pci_io_protocol32' definition for mixed mode
>
> Because we normally use the 'prototype' name for function declarations, not for
> data type definitions. Adding 'struct' and putting it between quotes makes it
> obvious at a glance that we are talking about a structure definition here.
>

OK.

> BTW., since it's marked -stable, due to:
>
>  > potentially resulting in bogus memory references
>  > and subsequent crashes.
>
> I'm moving it to efi/urgent: the principle here is that if a patch is urgent
> enough for -stable then it should generally not wait for the next merge window.
>

The issue was found by inspection rather than a crash report, so I was
in doubt about this.

> Also, because this actually fixes a crash, I extended the title to spell this out
> more clearly:
>
>   Subject: efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32' definition for mixed mode
>
> ... which also makes it easier for maintainers of older stable kernels to decide
> whether to backport the patch or not.
>

OK.

> Anyway, the patch is looking good otherwise, no need to resend.
>
> Thanks,
>
>         Ingo
