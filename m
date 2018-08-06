Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909CDC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C9F21A0B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C9F21A0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeHFOvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:51:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeHFOvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:51:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6852580D;
        Mon,  6 Aug 2018 05:42:24 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 751CD3F2EA;
        Mon,  6 Aug 2018 05:42:22 -0700 (PDT)
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <neko@bakuhatsu.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
Date:   Mon, 6 Aug 2018 13:42:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/18 11:25, Mikulas Patocka wrote:
[...]
>> None of this explains why some transactions fail to make it across
>> entirely. The overlapping writes in question write the same data to
>> the memory locations that are covered by both, and so the ordering in
>> which the transactions are received should not affect the outcome.
> 
> You're right that the corruption couldn't be explained just by reordering
> writes. My hypothesis is that the PCIe controller tries to disambiguate
> the overlapping writes, but the disambiguation logic was not tested and it
> is buggy. If there's a barrier between the overlapping writes, the PCIe
> controller won't see any overlapping writes, so it won't trigger the
> faulty disambiguation logic and it works.
> 
> Could the ARM engineers look if there's some chicken bit in Cortex-A72
> that could insert barriers between non-cached writes automatically?

I don't think there is, and even if there was I imagine it would have a 
pretty hideous effect on non-coherent DMA buffers and the various other 
places in which we have Normal-NC mappings of actual system RAM.

> I observe these kinds of corruptions:
> - failing to write a few bytes

That could potentially be explained by the reordering/atomicity issues 
Matt mentioned, i.e. the load is observing part of the store, before the 
store has fully completed.

> - writing a few bytes that were written 16 bytes before
> - writing a few bytes that were written 16 bytes after

Those sound more like the interconnect or root complex ignoring the byte 
strobes on an unaligned burst, of which I think the simplistic view 
would be "it's broken".

FWIW I stuck my old Nvidia 7600GT card in my Arm Juno r2 board (2x 
Cortex-A72), built your test program natively with GCC 8.1.1 at -O2, and 
it's still happily flickering pixels in the corner of the console after 
nearly an hour (in parallel with some iperf3 just to ensure plenty of 
PCIe traffic). I would strongly suspect this issue is particular to 
Armada 8k, so its' probably one for the Marvell folks to take a closer 
look at - I believe some previous interconnect issues on those SoCs were 
actually fixable in firmware.

Robin.
