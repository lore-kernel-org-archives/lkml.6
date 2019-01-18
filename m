Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02B820823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfARLnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:43:37 -0500
Received: from foss.arm.com ([217.140.101.70]:55476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfARLnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:43:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5880A80D;
        Fri, 18 Jan 2019 03:43:36 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65C8C3F557;
        Fri, 18 Jan 2019 03:43:34 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH v2] drm/xen-front: Make shmem backed display
 buffer coherent
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "jgross@suse.com" <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
 <20190116063631.GA10881@infradead.org>
 <042fe794-dec6-6d9d-5b68-6f142790f5c7@epam.com>
 <20190117091815.GA7090@infradead.org>
 <1cfc5cb4-e481-5d71-29df-958db76fb681@epam.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <2ed681b9-c8d4-ea27-6b8b-e399ed034bda@arm.com>
Date:   Fri, 18 Jan 2019 11:43:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1cfc5cb4-e481-5d71-29df-958db76fb681@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Stefano)

Hi,

Sorry for jumping late in the conversation.

On 18/01/2019 09:40, Oleksandr Andrushchenko wrote:
> On 1/17/19 11:18 AM, Christoph Hellwig wrote:
>> On Wed, Jan 16, 2019 at 06:43:29AM +0000, Oleksandr Andrushchenko wrote:
>>>> This whole issue keeps getting more and more confusing.
>>> Well, I don't really do DMA here, but instead the buffers in
>>> question are shared with other Xen domain, so effectively it
>>> could be thought of some sort of DMA here, where the "device" is
>>> that remote domain. If the buffers are not flushed then the
>>> remote part sees some inconsistency which in my case results
>>> in artifacts on screen while displaying the buffers.
>>> When buffers are allocated via DMA API then there are no artifacts;
>>> if buffers are allocated with shmem + DMA mapping then there are no
>>> artifacts as well.
>>> The only offending use-case is when I use shmem backed buffers,
>>> but do not flush them
>> The right answer would be to implement cache maintainance hooks for
>> this case in the Xen arch code.  These would basically look the same
>> as the low-level cache maintainance used by the DMA ops, but without
>> going through the DMA mapping layer, in fact they should probably
>> reuse the same low-level assembly routines.
>>
>> I don't think this is the first usage of such Xen buffer sharing, so
>> what do the other users do?
> I'll have to get even deeper into it. Initially I
> looked at the code, but didn't find anything useful.
> Or maybe I have just overlooked obvious things there
 From Xen on Arm ABI:

"All memory which is shared with other entities in the system
(including the hypervisor and other guests) must reside in memory
which is mapped as Normal Inner Write-Back Outer Write-Back Inner-Shareable.
This applies to:
   - hypercall arguments passed via a pointer to guest memory.
   - memory shared via the grant table mechanism (including PV I/O
     rings etc).
   - memory shared with the hypervisor (struct shared_info, struct
     vcpu_info, the grant table, etc).
"

So you should not need any cache maintenance here. Can you provide more details 
on the memory attribute you use for memory shared in both the backend and frontend?

Cheers,

> 
> Thank you,
> Oleksandr
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 

-- 
Julien Grall
