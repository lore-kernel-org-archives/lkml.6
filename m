Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B475DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760902170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760902170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeHCQON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:14:13 -0400
Received: from foss.arm.com ([217.140.101.70]:43438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731948AbeHCQON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:14:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E07C80D;
        Fri,  3 Aug 2018 07:17:40 -0700 (PDT)
Received: from e120077-lin.cambridge.arm.com (e120077-lin.cambridge.arm.com [10.2.207.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F4623F2EA;
        Fri,  3 Aug 2018 07:17:38 -0700 (PDT)
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Pinski <pinskia@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        thomas.petazzoni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <alpine.LRH.2.02.1808030925440.28733@file01.intranet.prod.int.rdu2.redhat.com>
From:   "Richard Earnshaw (lists)" <Richard.Earnshaw@arm.com>
Openpgp: preference=signencrypt
Message-ID: <a6437980-4222-1f5f-8d6c-7632bc5fcbad@arm.com>
Date:   Fri, 3 Aug 2018 15:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1808030925440.28733@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/18 14:31, Mikulas Patocka wrote:
> 
> 
> On Fri, 3 Aug 2018, Andrew Pinski wrote:
> 
>> On Thu, Aug 2, 2018 at 12:31 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>>>
>>> Hi
>>>
>>> I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit a
>>> strange problem.
>>>
>>> When I use the links browser in graphics mode on the framebuffer, I get
>>> occasional pixel corruption. Links does memcpy, memset and 4-byte writes
>>> on the framebuffer - nothing else.
>>>
>>> I found out that the pixel corruption is caused by overlapping unaligned
>>> stp instructions inside memcpy. In order to avoid branching, the arm64
>>> memcpy implementation may write the same destination twice with different
>>> alignment. If I put "dmb sy" between the overlapping stp instructions, the
>>> pixel corruption goes away.
>>>
>>> This seems like a hardware bug. Is it a known errata? Do you have any
>>> workarounds for it?
>>
>> Yes fix Links not to use memcpy on the framebuffer.
>> It is undefined behavior to use device memory with memcpy.
>>
>> Thanks,
>> Andrew Pinski
> 
> Links can be fixed easily - but there is exterme amount of code that 
> accesses videoram via C pointers in the Xserver and in the GPU drivers. 
> How do you intend to fix that?
> 
> What should we use instead of direct access or memcpy? Libc doesn't 
> provide any macros or functions for framebuffer access. Using hardcoded 
> assembler doesn't make the the programs portable.
> 
> Mikulas
> 

Dialing back the optimization levels when building the Xserver so the
compilers plays by its rules is one thing.  Dialing back the
optimizations in the C library to handle a non-conforming program is
quite another.  That affects every program on the system, even if it
turns out to be a server with no graphics system.

R.
