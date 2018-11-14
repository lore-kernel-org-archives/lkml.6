Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A48C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0372243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFga16Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0372243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbeKOCO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbeKOCO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:14:56 -0500
Received: from linux-8ccs (ip5f5adbda.dynamic.kabel-deutschland.de [95.90.219.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398B022360;
        Wed, 14 Nov 2018 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542211864;
        bh=3FCN5veeezIRtQ+R8Sag7FMmSBB1PQgfbmBuHFamN6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFga16Q2G+FT9lcgA7G9DERYQR0J1QKduBVxLw/7kcbE2tCxwGnJG+WrvY6uH+YAy
         l30PNvZ40STfBJq6glAYf4Fc9q/43Dge6D37lw8BNY+mZwag5baG1stywXUFauHBsp
         NdGcDS9S4qEv+ve9lMzk7YSgqY5S/KqjgUiClgnU=
Date:   Wed, 14 Nov 2018 17:10:59 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181114161059.GB13928@linux-8ccs>
References: <20181031084253.9650-1-vincent.whitchurch@axis.com>
 <20181031155341.GA27878@linux-8ccs>
 <20181101152913.r2isskngiahi6o2u@axis.com>
 <20181102135322.GA5289@linux-8ccs>
 <20181109135300.3tyord6amvd7wy54@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181109135300.3tyord6amvd7wy54@axis.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Vincent Whitchurch [09/11/18 14:53 +0100]:
>On Fri, Nov 02, 2018 at 02:53:22PM +0100, Jessica Yu wrote:
>> +++ Vincent Whitchurch [01/11/18 16:29 +0100]:
>> > On Wed, Oct 31, 2018 at 04:53:41PM +0100, Jessica Yu wrote:
>> > > Could this be done in modpost? I'm guessing the answer is no as some
>> > > relocations may rely on that bit being set in st_value, right?
>> > > Therefore we can only clear the bit _after_ relocations to the module
>> > > are applied at runtime, correct?
>> >
>> > Yes, that's correct, it needs to be done after the relocations.
>> >
>> > > I'm not against having an arch-specific kallsyms fixup function, my
>> > > only concern would be if this would interfere with the delayed
>> > > relocations livepatching does, if there are plans in the future to
>> > > have livepatching on arm (IIRC there was an attempt at a port in
>> > > 2016). If there exists some Thumb-2 relocation types that rely on that
>> > > lowest bit in st_value being set in order to be applied, and we clear
>> > > it permanently from the symtab, then livepatching wouldn't be able to
>> > > apply those types of relocations anymore. If this is a legitimate
>> > > concern, then perhaps an alternative solution would be to have an
>> > > arch-specific kallsyms symbol-value-fixup function for accesses to
>> > > sym.st_value, without modifying the module symtab.
>> >
>> > I'm not familiar with livepatching, but yes, if it needs to do
>> > relocations later I guess we should preserve the original value.
>>
>> Yeah, I think the symtab needs to remain unmodified for livepatch to
>> be able to do delayed relocations after module load.
>>
>> > I gave the alternative solution a go and it seems to work.
>> > add_kallsyms() currently overwrites st_info so I had to move the
>> > elf_type to the unused st_other field instead to preserve st_info:
>>
>> I think that's fine, I think the only usages of st_other I've found
>> are during relocations, and the field is big enough for a char, so it
>> should be fine to reuse it afterwards.
>
>If livepatch can do relocations later, doesn't that mean that we _can't_
>reuse st_other for storing the elf_type?  OTOH, the current code
>overwrites st_info, and I see that used from various archs' relocation
>functions too, so perhaps I'm missing something.

D'oh, I just contradicted myself. Yes, you are correct. AFAIK the only
reason we haven't run into issues yet in livepatch is because the only
arches it currently supports (x86, s390, powerpc) don't depend on
st_info for module relocations. But yes, that's an outstanding problem
that will need to be fixed if livepatch gains support on more arches,
we shouldn't be overwriting that field. And after grepping around I do
see that st_other is used in powerpc, alpha, sh for module
relocations. I suggested in my other reply to your v3 patch that
reusing st_size instead of st_info might work, since it's not used in
the module loader/kallsyms, and arches don't seem to use it for module
relocs. Maybe that would work?

Jessica

