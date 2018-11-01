Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D29FC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E50A204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E50A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeKAT6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:58:09 -0400
Received: from ozlabs.org ([203.11.71.1]:52629 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeKAT6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:58:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42m2DW30HCzB4N2;
        Thu,  1 Nov 2018 21:55:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, chzigotzky@xenosoft.de
Subject: Re: NXP P50XX/e5500 secondary CPUs not onlined with current mainline (was [PATCH 20/21] of: use for_each_of_cpu_node iterator)
In-Reply-To: <CAL_Jsq+mZD5cgzOQoC0bd-Bi-1i=eK=Xa3hLNtZ2phR8=5dN5A@mail.gmail.com>
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-21-robh@kernel.org> <87r2g6ffm8.fsf@concordia.ellerman.id.au> <CAL_Jsq+mZD5cgzOQoC0bd-Bi-1i=eK=Xa3hLNtZ2phR8=5dN5A@mail.gmail.com>
Date:   Thu, 01 Nov 2018 21:55:38 +1100
Message-ID: <87r2g5dq39.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> On Wed, Oct 31, 2018 at 7:46 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Rob Herring <robh@kernel.org> writes:
>> > Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
>> > has the side effect of defaulting to iterating using "cpu" node names in
>> > preference to the deprecated (for FDT) device_type == "cpu".
>> >
>> > Cc: Frank Rowand <frowand.list@gmail.com>
>> > Cc: devicetree@vger.kernel.org
>> > Signed-off-by: Rob Herring <robh@kernel.org>
>> > ---
>> > Please ack and I will take via the DT tree. This is dependent on the
>> > first 2 patches.
>> >
>> >  drivers/of/base.c    |  2 +-
>> >  drivers/of/of_numa.c | 15 ++-------------
>> >  2 files changed, 3 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/drivers/of/base.c b/drivers/of/base.c
>> > index 6389aeb2f48c..8285c07cab44 100644
>> > --- a/drivers/of/base.c
>> > +++ b/drivers/of/base.c
>> > @@ -389,7 +389,7 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
>> >  {
>> >       struct device_node *cpun;
>> >
>> > -     for_each_node_by_type(cpun, "cpu") {
>> > +     for_each_of_cpu_node(cpun) {
>> >               if (arch_find_n_match_cpu_physical_id(cpun, cpu, thread))
>> >                       return cpun;
>> >       }
>>
>> Previously we just looked for any node with a type of "cpu", but now
>> we're using for_each_of_cpu_node(), which does:
>>
>>         for (; next; next = next->sibling) {
>>                 if (!(of_node_name_eq(next, "cpu") ||
>>                       (next->type && !of_node_cmp(next->type, "cpu"))))
>>                         continue;
>>
>>                 if (!__of_device_is_available(next))
>>                         continue;
>>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>>                 if (of_node_get(next))
>>                         break;
>>         }
>>
>>
>> ie. the available check is new.
>>
>> On this machine the 2nd CPU is not marked as available:
>>
>>   root@p5020ds:/proc/device-tree/cpus/PowerPC,e5500@1# lsprop status
>>   status           "disabled"
>>
>> This has the effect of preventing the SMP code from finding the 2nd CPU
>> in order to bring it up (in smp_85xx_start_cpu()). And so only the boot
>> CPU is onlined.
>>
>> The device tree is built from a dts:
>>
>>   arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
>>
>> But we don't set the status in there, so presumably u-boot is changing
>> the status during boot? (not a u-boot expert).
>
> Ah, status for cpus is a bit different. For most nodes, it should be
> equivalent to the node not being present, but for cpus it means
> offline if disabled. Though ARM platforms have never used it in that
> way.

Aha. We don't use it like that on server CPUs either, so perhaps it's
just a u-boot thing.

>> We could work around this in the platform code presumably, but I'm
>> worried this might break other things as well. You didn't mention the
>> addition of the available check in the change log so I wonder if it was
>> deliberate or just seemed like a good idea?
>
> Just seemed like a good idea...

Yeah fair enough.

> I'll send a patch now dropping those 2 lines.

Awesome, thanks.

cheers
