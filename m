Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92468ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5443220673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5443220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeGTHQC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:16:02 -0400
Received: from ozlabs.org ([203.11.71.1]:60379 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeGTHQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:16:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41X1FD47dBz9s4V;
        Fri, 20 Jul 2018 16:29:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michael Neuling <mikey@neuling.org>, ego@linux.vnet.ibm.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        "Oleg Nesterov" <oleg@redhat.com>
Subject: Re: [RESEND][PATCH] powerpc/powernv : Save/Restore SPRG3 on entry/exit from stop.
In-Reply-To: <dd4a5526966b9b24b7eb52efadf3b9bcd4a94bd1.camel@neuling.org>
References: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com> <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com> <80bbdf47081e3e302ab5f28b5ddc9e2faabba842.camel@neuling.org> <20180718081249.GA17700@in.ibm.com> <1205bfc10c62986b4345fa258cf37e820c08226b.camel@neuling.org> <87tvoubpro.fsf@concordia.ellerman.id.au> <dd4a5526966b9b24b7eb52efadf3b9bcd4a94bd1.camel@neuling.org>
Date:   Fri, 20 Jul 2018 16:29:19 +1000
Message-ID: <871sbya08w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Neuling <mikey@neuling.org> writes:
> On Fri, 2018-07-20 at 12:32 +1000, Michael Ellerman wrote:
>> Michael Neuling <mikey@neuling.org> writes:
>> > On Wed, 2018-07-18 at 13:42 +0530, Gautham R Shenoy wrote:
>> > > On Wed, Jul 18, 2018 at 09:24:19AM +1000, Michael Neuling wrote:
>> > > > 
>> > > > >  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
>> > > > > diff --git a/arch/powerpc/kernel/idle_book3s.S
>> > > > > b/arch/powerpc/kernel/idle_book3s.S
>> > > > > index d85d551..5069d42 100644
>> > > > > --- a/arch/powerpc/kernel/idle_book3s.S
>> > > > > +++ b/arch/powerpc/kernel/idle_book3s.S
>> > > > > @@ -120,6 +120,9 @@ power9_save_additional_sprs:
>> > > > >  	mfspr	r4, SPRN_MMCR2
>> > > > >  	std	r3, STOP_MMCR1(r13)
>> > > > >  	std	r4, STOP_MMCR2(r13)
>> > > > > +
>> > > > > +	mfspr	r3, SPRN_SPRG3
>> > > > > +	std	r3, STOP_SPRG3(r13)
>> > > > 
>> > > > We don't need to save it.  Just restore it from paca->sprg_vdso which
>> > > > should
>> > > > never change.
>> > > 
>> > > Ok. I will respin a patch to restore SPRG3 from paca->sprg_vdso.
>> > > 
>> > > > 
>> > > > How can we do better at catching these missing SPRGs?
>> > > 
>> > > We can go through the list of SPRs from the POWER9 User Manual and
>> > > document explicitly why we don't have to save/restore certain SPRs
>> > > during the execution of the stop instruction. Does this sound ok ?
>> > > 
>> > > (Ref: Table 4-8, Section 4.7.3.4 from the POWER9 User Manual
>> > > accessible from
>> > > https://openpowerfoundation.org/?resource_lib=power9-processor-users-manua
>> > > l)
>> > 
>> > I was thinking of a boot time test case built into linux. linux has some
>> > boot
>> > time test cases which you can enable via CONFIG options.
>> > 
>> > Firstly you could see if an SPR exists using the same trick xmon does in
>> > dump_one_spr(). Then once you have a list of usable SPRs, you could write
>> > all
>> > the known ones (I assume you'd have to leave out some, like the PSSCR), then
>> > set
>> 
>> Write what value?
>> 
>> Ideally you want to write a random bit pattern to reduce the chance
>> that only some bits are being restored.
>
> The xmon dump_one_spr() trick tries to work around that by writing one random
> value and then a different one to see if it really is a nop.
>
>> But you can't do that because writing a value to an SPRs has an effect.
>
> Sure that's a concern but xmon seems to get away with it.

I don't think it writes, but maybe I'm reading the code wrong.

Writing a random value to the MSR could be fun :)

>> Some of them might even need to be zero, in which case you can't really
>> distinguish that from a non-restored zero.
>
> It doesn't need to be perfect. It just needs to catch more than we have now.

Sure.

>> > the appropriate stop level, make sure you got into that stop level, and then
>> > see
>> > if that register was changed. Then you'd have an automated list of registers
>> > you
>> > need to make sure you save/restore at each stop level.
>> > 
>> > Could something like that work?
>> 
>> Maybe.
>> 
>> Ignoring the problem of whether you can write a meaningful value to some
>> of the SPRs, I'm not entirely convinced it's going to work. But maybe
>> I'm wrong.
>
> Yeah, I'm not convinced it'll work either but it would be a nice piece of test
> infrastructure to have if it does work.

Yeah I guess I'd rather we worked on 1) and 2) below first :)

> We'd still need to marry up the SPR numbers we get from the test to what's
> actually being restored in Linux.
>
>> But there's a much simpler solution, we should 1) have a selftest for
>> getcpu() and 2) we should be running the glibc (I think?) test suite
>> that found this in the first place. It's frankly embarrassing that we
>> didn't find this.
>
> Yeah, we should do that also, but how do we catch the next SPR we are missing.
> I'd like some systematic way of doing that rather than wack-a-mole.

Whack-a-mole 😂😂😂😂

We could also improve things by documenting how each SPR is handled, eg.
is it saved/restored across idle, syscall, KVM etc. And possibly that
could even become code that defines how SPRs are handled, rather than it
all being done ad-hoc.

cheers
