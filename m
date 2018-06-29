Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E8DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2C623DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2C623DCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934614AbeF2Kxm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:53:42 -0400
Received: from foss.arm.com ([217.140.101.70]:59526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932890AbeF2Kxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:53:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE2F818A;
        Fri, 29 Jun 2018 03:53:38 -0700 (PDT)
Received: from e107155-lin (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52F343F266;
        Fri, 29 Jun 2018 03:53:37 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:53:34 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Andrew Jones <drjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, shunyong.yang@hxt-semitech.com,
        yu.zheng@hxt-semitech.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: Re: [PATCH] arm64: acpi: reenumerate topology ids
Message-ID: <20180629105334.GB18043@e107155-lin>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <d797ebc5-bd7b-4f72-d4fc-840ba7345a15@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d797ebc5-bd7b-4f72-d4fc-840ba7345a15@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:12:00PM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 06/28/2018 11:30 AM, Sudeep Holla wrote:

[...]

> >I am not sure if we can ever guarantee that DT and ACPI will get the
> >same ids whatever counter we use as it depends on the order presented in
> >the firmware(DT or ACPI). So I am not for generating ids for core and
> >threads in that way.
> >
> >So I would like to keep it simple and just have this counters for
> >package ids as demonstrated in Shunyong's patch.
>
> So, currently on a non threaded system, the core id's look nice because they
> are just the ACPI ids. Its the package id's that look strange, we could just
> fix the package ids, but on threaded machines the threads have the nice acpi
> ids, and the core ids are then funny numbers. So, I suspect that is driving
> this as much as the strange package ids.
>

Yes, I know that and that's what made be look at topology_get_acpi_cpu_tag
For me, if the PPTT has valid ID, we should use that. Just becuase DT lacks
it and uses counter doesn't mean ACPI also needs to follow that.

I am sure some vendor will put valid UID and expect that to be in the
sysfs.

> (and as a side, I actually like the PE has a acpi id behavior, but for
> threads its being lost with this patch...)
> 
> Given i've seen odd package/core ids on x86s a few years ago, it never
> bothered me much as a lot of userspace tools are just using what is
> effectively the logical processor number anyway.
>

Indeed.

> Further, this table may be having some clarifications published for some of
> these fields. I'm not sure the final wording will help us, but it might.
>

I prefer that. We can then just use the IDs if valid, else offset if
PPTT ignores those fields. What's the point in having all these in
specification and vendors ignoring them altogether. Since this is new
feature, we can always enforce and say we don't care if firmware doesn't,
sorry.

> >
> >
> >Also looking @ topology_get_acpi_cpu_tag again now, we should have
> >valid flag check instead of level = 0. Jeremy ?
> 
> ? I'm not sure I understand, but your saying for the leaf nodes we should be
> checking the valid flag rather than whether the caller requested level 0?
> 
> I don't think that is right. The original PPTT spec is unclear about proper
> use of the valid flag. So, while this part of the spec may be clarified in
> the near future, (AFAIK) there are already tables in the wild which fail to
> set valid on the leaf nodes! So I think using the level check is the safest
> at the moment.
>

If it's unclear, we can fix it. I really don't like to support something
based on the counters as the logic is arbitrary.

> Depending on what happens with the next rev of the ACPI spec (or whenever)
> some of this whole discussion might be bypassed simply by using whatever id
> is marked valid on the node, as you suggest, but until then...

I will check if that can be done or enforced. I am sure if we add some
counter based logic, we will break something in future. So I would rather
stay with UID/offset though it's not mandatory in the specification.

--
Regards,
Sudeep
