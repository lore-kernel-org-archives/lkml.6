Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C2CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B878205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfANLgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:36:54 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:55611 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfANLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:36:53 -0500
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 06:36:52 EST
Received: from g4t3428.houston.hpe.com (g4t3428.houston.hpe.com [15.241.140.76])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 57368611E6;
        Mon, 14 Jan 2019 11:30:29 +0000 (UTC)
Received: from sarge.linuxathome.me (unknown [16.214.81.200])
        by g4t3428.houston.hpe.com (Postfix) with SMTP id 1B22C53;
        Mon, 14 Jan 2019 11:30:17 +0000 (UTC)
Date:   Mon, 14 Jan 2019 11:30:16 +0000
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>
Subject: Re: [PATCH 3/3] x86/platform/UV: use efi_runtime_sem to serialise
 BIOS calls
Message-ID: <20190114113016.GS12284@sarge.linuxathome.me>
Mail-Followup-To: Bhupesh Sharma <bhsharma@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>
References: <20190109104541.25733-1-hedi.berriche@hpe.com>
 <20190109104541.25733-4-hedi.berriche@hpe.com>
 <134565bb-0f5e-27c7-199c-af6132dc0dc3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <134565bb-0f5e-27c7-199c-af6132dc0dc3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 07:14 Bhupesh Sharma wrote:
>Hi Hedi,

Hi Bhupesh,

>Thanks for the patchset.

Thanks for looking at it.

>I will give this a go on my sgi-uv300 machine and come back with more 
>detailed inputs,

and for testing it.

>but I wanted to ask about the hang/panic you 
>mentioned in the cover letter when efi_scratch gets clobbered. Can you 
>describe the same (for e.g. how to reproduce this).

When efi_switch_mm() gets called concurrently from two different CPUs
--via arch_efi_call_virt_setup()-- due to lack of serialisation in
uv_bios_call(), efi_scratch.prev_mm is overwritten and that's how all
hell breaks loose, and that's when you see either a hang (the more
frequent failure mode) or a panic.

In order to reproduce the problem you'd need, for example, a kernel
module that makes use of uv_bios_call(), in which case a test case
would be a loop with:

	- 2 concurrent tasks both invoking uv_bios_call()

or
	- 2 concurrent tasks
		- one invoking uv_bios_call()
		- one, for example, accessing an EFI vars via efivars

>Nitpicks below:
>
>
>On 01/09/2019 04:15 PM, Hedi Berriche wrote:
>>Calls into UV firmware must be protected against concurrency, use the
>>now visible efi_runtime_sem lock to serialise them.
>>
>>Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
>>Reviewed-by: Russ Anderson <rja@hpe.com>
>>Reviewed-by: Mike Travis <mike.travis@hpe.com>
>>Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
>>Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
>>---
>>  arch/x86/include/asm/uv/bios.h |  3 ++-
>>  arch/x86/platform/uv/bios_uv.c | 25 ++++++++++++++++++++++---
>>  2 files changed, 24 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
>>index 4eee646544b2..33e94aa0b1ff 100644
>>--- a/arch/x86/include/asm/uv/bios.h
>>+++ b/arch/x86/include/asm/uv/bios.h
>>@@ -48,7 +48,8 @@ enum {
>>  	BIOS_STATUS_SUCCESS		=  0,
>>  	BIOS_STATUS_UNIMPLEMENTED	= -ENOSYS,
>>  	BIOS_STATUS_EINVAL		= -EINVAL,
>>-	BIOS_STATUS_UNAVAIL		= -EBUSY
>>+	BIOS_STATUS_UNAVAIL		= -EBUSY,
>>+	BIOS_STATUS_ABORT		= -EINTR
>>  };
>>  /* Address map parameters */
>>diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
>>index cd05af157763..92f960798e20 100644
>>--- a/arch/x86/platform/uv/bios_uv.c
>>+++ b/arch/x86/platform/uv/bios_uv.c
>>@@ -29,7 +29,8 @@
>>  struct uv_systab *uv_systab;
>>-s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
>>+s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
>>+			u64 a4, u64 a5)
>
>Can we make this static?

Will do.

>>  {
>>  	struct uv_systab *tab = uv_systab;
>>  	s64 ret;
>>@@ -44,13 +45,26 @@ s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
>>  	 * If EFI_OLD_MEMMAP is set, we need to fall back to using our old EFI
>>  	 * callback method, which uses efi_call() directly, with the kernel page tables:
>>  	 */
>>-	if (unlikely(test_bit(EFI_OLD_MEMMAP, &efi.flags)))
>>+	if (unlikely(efi_enabled(EFI_OLD_MEMMAP)))
>>  		ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
>>  	else
>>  		ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
>>  	return ret;
>>  }
>>+
>>+s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
>>+{
>>+	s64 ret;
>>+
>>+	if (down_interruptible(&efi_runtime_sem))
>>+		return BIOS_STATUS_ABORT;
>>+
>>+	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
>>+	up(&efi_runtime_sem);
>>+
>>+	return ret;
>>+}
>>  EXPORT_SYMBOL_GPL(uv_bios_call);
>>  s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
>>@@ -59,10 +73,15 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
>>  	unsigned long bios_flags;
>>  	s64 ret;
>>+	if (down_interruptible(&efi_runtime_sem))
>>+		return BIOS_STATUS_ABORT;
>>+
>>  	local_irq_save(bios_flags);
>>-	ret = uv_bios_call(which, a1, a2, a3, a4, a5);
>>+	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
>>  	local_irq_restore(bios_flags);
>>+	up(&efi_runtime_sem);
>>+
>>  	return ret;
>>  }
>
>Thanks,
>Bhupesh

Cheers,
Hedi.
-- 
Be careful of reading health books, you might die of a misprint.
	-- Mark Twain
