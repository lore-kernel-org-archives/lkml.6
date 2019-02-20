Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE1FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932FC2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfBTMlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:41:21 -0500
Received: from ozlabs.org ([203.11.71.1]:44571 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfBTMlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:41:20 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444HK94H47z9s70;
        Wed, 20 Feb 2019 23:41:17 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix 32-bit KVM-PR lockup and panic with MacOS guest
In-Reply-To: <6839dfd8-f316-d98a-2ae9-279de956ce28@ilande.co.uk>
References: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk> <41b02fb0-cdc6-6de0-d8fc-44d3d0a8ad70@c-s.fr> <2ed8efb9-5cd4-31bf-6c7b-501b9d1925e6@ilande.co.uk> <87pnrobe9m.fsf@concordia.ellerman.id.au> <6839dfd8-f316-d98a-2ae9-279de956ce28@ilande.co.uk>
Date:   Wed, 20 Feb 2019 23:41:17 +1100
Message-ID: <87pnrm7hua.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> On 19/02/2019 04:20, Michael Ellerman wrote:
>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>>>> unexpectedly removed the MSR_FE0 and MSR_FE1 bits from the bitmask used to
>>>>> update the MSR of the previous thread in __giveup_fpu() causing a KVM-PR MacOS
>>>>> guest to lockup and panic the kernel.
>> 
>> Which kernel is panicking? The guest or the host?
>
> It's the host kernel. As long as you occasionally tap a few keys to keep the screen
> blanking disabled then you can see the panic on the physical console.

Ah crap I assumed you meant the guest kernel.

> I've uploaded a photo I took during the bisection containing the panic when booting
> MacOS X 10.2 under qemu-system-ppc to
> https://www.ilande.co.uk/tmp/qemu/macmini-kvm.jpg in case you find it useful.

OK. That's a host crash, but only because init died (systemd). Though
the reason it died is because we didn't clear FE0/1 properly, so still a
kernel bug.

> Given that it's really easy to recreate, let me know if you want me to do a git
> pull/rebuild and/or if you need any debugging information as it's easy for me to
> reproduce.

I think that's OK. It's reasonably clear what's going on.


>>> 2) Is this the right fix? I'm told that MacOS guests already run without this patch
>>> on a G5 under 64-bit KVM-PR which may suggest that this is a workaround for another
>>> bug elsewhere in the 32-bit powerpc code.
>> 
>> That's slightly worrying. It's hard to say without more detail on why
>> the guest is crashing.
>> 
>> I think your patch looks OK based just on the fact that it restores the
>> previous behaviour, so I'll pick it up and pass it through my usual
>> testing. If nothing breaks I'll merge it.
>
> That would be great! Does it need a CC to stable too? It would be great if this would
> get picked up in the next set of Debian ports kernels, for example.

I'll add Cc stable.

cheers
