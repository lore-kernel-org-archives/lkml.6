Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752808AbeD0FUu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 01:20:50 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:42510 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeD0FUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 01:20:48 -0400
X-Google-Smtp-Source: AB8JxZoXg+Pmu5YR5qslXrkpHbtTylvwbJ5KPgbkcw2AAvP4+un42sRYqQusCa/YTDlsEgWrSX0ufg==
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
From: Sultan Alsawaf <sultanxda@gmail.com>
Message-ID: <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
Date: Thu, 26 Apr 2018 22:20:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426235630.GG5965@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The CRNG changes were needed because were erroneously saying that the
> entropy pool was securely initialized before it really was.  Saying
> that CRNG should be able to init on its own is much like saying, "Ted
> should be able to fly wherever he wants in his own personal Gulfstream
> V."  It would certainly be _nice_ if I could afford my personal jet.
> I certainly wish I were that rich.  But the problem is that dollars
> (or Euro's) are like entropy, they don't just magically drop out of
> the sky.
>
> If there isn't user-provided entropy, and the hardware isn't providing
> sufficient entropy, where did you think the kernel is supposed to get
> the entropy from?  Should it dial 1-800-TRUST-NSA?
>
> From the dmesg log, you have a Chromebook Acer 14.  I'm guessing the
> problem is that Chromebooks have hardware tries *very* hard not to
> issue interrupts, since that helps with power savings.  The following
> from your dmesg is very interesting:
>
> [    0.526786] tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead
>
> I suspect this isn't a firmware bug; it's the hardware working as
> intended / working as designed, for power savings reasons.
>
> So there are two ways to fix this that I can see.  One is to try to
> adjust userspace so that it allows the boot to proceed.  As there is
> more activity, the disk completion interrupts, the user typing their
> username/password into the login screen, etc., there will be timing
> events which can be used to harvest entropy.
>
> The other approach would be to compile the kernel with
> CONFIG_HW_RANDOM_TPM and to modify drivers/char/tpm/tpm-chip.c tot
> initalize chip->hwrng.quality = 500.  We've historically made this
> something that the system administrator must set via sysfs.  This is
> because we wanted system adminisrators to explicitly say that they
> trust the any hardware manufacturer that (a) they haven't been paid by
> your choice of the Chinese MSS or the US NSA to introduce a backdoor,i
> and (b) they are competent to actually implemnt a _secure_ hardware
> random number generator.  Sadly, this has not always been the case.
> Please see:
>
> 	https://www.chromium.org/chromium-os/tpm_firmware_update
>
> And note that your Edgar Chromebook is one the list of devices that
> have a TPM with the buggy firmware.  Fortunately this particular TPM
> bug only affects RSA prime generation, so as far as I know there is no
> _known_ vulerability in your TPM's hardware random number generator.
> B ut we want it to be _your_ responsibility to decide you are willing
> to truste it.  I certainly don't want to be legally liable --- or even
> have the moral responsibility --- of guaranteeing that every single
> TPM out there is bug-free(tm).
>
> 					- Ted

Why don't we tell users that they need to smash their keyboards to make their computers boot
then? And if they question it, we can tell them that it certainly would be _nice_ to not have
to smash their keyboards to make their computers boot, but alas, a part of me has a feeling that
users would not take kindly to that :)

I noted at least 20,000 mmc interrupts before I intervened in the boot process to provide entropy
myself. That's just for mmc, so I'm sure there were even more interrupts elsewhere. Is 20k+ interrupts
really not sufficient?

There are lots of other sources of entropy available as well, like the ever-changing CPU frequencies reported
by any recent Intel chip (i.e., they report precision down to 1 kHz). Why are we so limited to h/w interrupts?

Sultan
