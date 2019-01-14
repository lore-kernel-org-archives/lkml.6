Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A77C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCA120651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfANTN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:13:58 -0500
Received: from foss.arm.com ([217.140.101.70]:39188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbfANTN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:13:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E13E80D;
        Mon, 14 Jan 2019 11:13:57 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4283F5BD;
        Mon, 14 Jan 2019 11:13:55 -0800 (PST)
Date:   Mon, 14 Jan 2019 19:13:50 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= 
        <Bernhard.Rosenkranzer@linaro.org>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Message-ID: <20190114191350.GA29600@fuggles.cambridge.arm.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
 <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 07:07:54PM +0000, Koenig, Christian wrote:
> Am 14.01.19 um 18:32 schrieb Ard Biesheuvel:
>             - The reason remapping the CPU side as cacheable does work (which I
>             did test) is because the GPU's uncacheable accesses (which I assume
>             are made using the NoSnoop PCIe transaction attribute) are actually
>             emitted as cacheable in some cases.
>                . On my AMD Seattle, with or without SMMU (which is stage 2 only), I
>             must use cacheable accesses from the CPU side or things are broken.
>             This might be a h/w flaw, though.
>                . On systems with stage 1+2 SMMUs, the driver uses stage 1
>             translations which always override the memory attributes to cacheable
>             for DMA coherent devices. This is what is affecting the Cavium
>             ThunderX2 (although it appears the attributes emitted by the RC may be
>             incorrect as well.)
> 
>             The latter issue is a shortcoming in the SMMU driver that we have to
>             fix, i.e., it should take care not to modify the incoming attributes
>             of DMA coherent PCIe devices for NoSnoop to be able to work.
> 
>             So in summary, the mismatch appears to be between the CPU accessing
>             the vmap region with non-cacheable attributes and the GPU accessing
>             the same memory with cacheable attributes, resulting in a loss of
>             coherency and lots of visible corruption.
> 
>         Actually it is the other way around. The CPU thinks some data is in the
>         cache and the GPU only updates the system memory version because the
>         snoop flag is not set.
> 
> 
>     That doesn't seem to be what is happening. As far as we can tell from
>     our experiments, all inbound transactions are always cacheable, and so
>     the only way to make things work is to ensure that the CPU uses the
>     same attributes.
> 
> 
> Ok that doesn't make any sense. If inbound transactions are cacheable or not is
> irrelevant when the CPU always uses uncached accesses.
> 
> See on the PCIe side you have the snoop bit in the read/write transactions
> which tells the root hub if the device wants to snoop caches or not.
> 
> When the CPU accesses some memory as cached then devices need to snoop the
> cache for coherent accesses.
> 
> When the CPU accesses some memory as uncached then devices can disable snooping
> to improve performance, but when they don't do this it is mandated by the spec
> that this still works.

Which spec? The Arm architecture (and others including Power afaiu) doesn't
guarantee coherency when memory is accessed using mismatched cacheability
attributes.

Will
