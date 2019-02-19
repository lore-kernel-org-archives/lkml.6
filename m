Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46C821903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfBSEU1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:20:27 -0500
Received: from ozlabs.org ([203.11.71.1]:38677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfBSEU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:20:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443SFh3vWsz9s5c;
        Tue, 19 Feb 2019 15:20:23 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix 32-bit KVM-PR lockup and panic with MacOS guest
In-Reply-To: <2ed8efb9-5cd4-31bf-6c7b-501b9d1925e6@ilande.co.uk>
References: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk> <41b02fb0-cdc6-6de0-d8fc-44d3d0a8ad70@c-s.fr> <2ed8efb9-5cd4-31bf-6c7b-501b9d1925e6@ilande.co.uk>
Date:   Tue, 19 Feb 2019 15:20:21 +1100
Message-ID: <87pnrobe9m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> On 08/02/2019 14:45, Christophe Leroy wrote:
>
>> Le 08/02/2019 à 15:33, Mark Cave-Ayland a écrit :
>>> Commit 8792468da5e1 "powerpc: Add the ability to save FPU without giving it up"
>> 
>> Expected format for the above is:
>> 
>> Commit 123456789abc ("text")
>
> Hi Christophe,
>
> Apologies - I'm fairly new at submitting kernel patches, but I can re-send it in the
> correct format later if required.
>
>>> unexpectedly removed the MSR_FE0 and MSR_FE1 bits from the bitmask used to
>>> update the MSR of the previous thread in __giveup_fpu() causing a KVM-PR MacOS
>>> guest to lockup and panic the kernel.

Which kernel is panicking? The guest or the host?

>>> Reinstate these bits to the MSR bitmask to enable MacOS guests to run under
>>> 32-bit KVM-PR once again without issue.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> 
>> Should include a Fixes: and a Cc to stable ?
>> 
>> Fixes: 8792468da5e1 ("powerpc: Add the ability to save FPU without giving it up")
>> Cc: stable@vger.kernel.org
>
> Indeed, but there are still some questions to be asked here:
>
> 1) Why were these bits removed from the original bitmask in the first place without
> it being documented in the commit message?

It was almost certainly an accident.

> 2) Is this the right fix? I'm told that MacOS guests already run without this patch
> on a G5 under 64-bit KVM-PR which may suggest that this is a workaround for another
> bug elsewhere in the 32-bit powerpc code.

That's slightly worrying. It's hard to say without more detail on why
the guest is crashing.

I think your patch looks OK based just on the fact that it restores the
previous behaviour, so I'll pick it up and pass it through my usual
testing. If nothing breaks I'll merge it.

cheers
