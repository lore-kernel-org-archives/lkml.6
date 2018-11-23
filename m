Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E91C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B688E20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B688E20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408264AbeKWRxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:53:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36784 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731655AbeKWRxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:53:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CE5035CD;
        Thu, 22 Nov 2018 23:10:55 -0800 (PST)
Received: from [10.1.29.128] (p8cg001049571a15.cambridge.arm.com [10.1.29.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9C753F5CF;
        Thu, 22 Nov 2018 23:10:53 -0800 (PST)
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20181114224902.12082-1-keith.busch@intel.com>
 <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com>
 <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com>
 <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
 <CAPcyv4hj61o+TDTSGxYSMMXMn7YiOGP0fj6R-cquPodN4VeT9A@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0194f47c-d1d8-108e-a57f-0316adb9112b@arm.com>
Date:   Fri, 23 Nov 2018 12:40:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hj61o+TDTSGxYSMMXMn7YiOGP0fj6R-cquPodN4VeT9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/2018 11:38 PM, Dan Williams wrote:
> On Thu, Nov 22, 2018 at 3:52 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 11/19/2018 11:07 PM, Dave Hansen wrote:
>>> On 11/18/18 9:44 PM, Anshuman Khandual wrote:
>>>> IIUC NUMA re-work in principle involves these functional changes
>>>>
>>>> 1. Enumerating compute and memory nodes in heterogeneous environment (short/medium term)
>>>
>>> This patch set _does_ that, though.
>>>
>>>> 2. Enumerating memory node attributes as seen from the compute nodes (short/medium term)
>>>
>>> It does that as well (a subset at least).
>>>
>>> It sounds like the subset that's being exposed is insufficient for yo
>>> We did that because we think doing anything but a subset in sysfs will
>>> just blow up sysfs:  MAX_NUMNODES is as high as 1024, so if we have 4
>>> attributes, that's at _least_ 1024*1024*4 files if we expose *all*
>>> combinations.
>> Each permutation need not be a separate file inside all possible NODE X
>> (/sys/devices/system/node/nodeX) directories. It can be a top level file
>> enumerating various attribute values for a given (X, Y) node pair based
>> on an offset something like /proc/pid/pagemap.
>>
>>>
>>> Do we agree that sysfs is unsuitable for exposing attributes in this manner?
>>>
>>
>> Yes, for individual files. But this can be worked around with an offset
>> based access from a top level global attributes file as mentioned above.
>> Is there any particular advantage of using individual files for each
>> given attribute ? I was wondering that a single unsigned long (u64) will
>> be able to pack 8 different attributes where each individual attribute
>> values can be abstracted out in 8 bits.
> 
> sysfs has a 4K limit, and in general I don't think there is much
> incremental value to go describe the entirety of the system from sysfs
> or anywhere else in the kernel for that matter. It's simply too much> information to reasonably consume. Instead the kernel can describe the

I agree that it may be some amount of information to parse but is crucial
for any task on a heterogeneous system to evaluate (probably re-evaluate
if the task moves around) its memory and CPU binding at runtime to make
sure it has got the right one.

> coarse boundaries and some semblance of "best" access initiator for a
> given target. That should cover the "80%" case of what applications

The current proposal just assumes that the best one is the nearest one.
This may be true for bandwidth and latency but may not be true for some
other properties. This assumptions should not be there while defining
new ABI.

> want to discover, for the other "20%" we likely need some userspace
> library that can go parse these platform specific information sources
> and supplement the kernel view. I also think a simpler kernel starting
> point gives us room to go pull in more commonly used attributes if it
> turns out they are useful, and avoid going down the path of exporting
> attributes that have questionable value in practice.
> 

Applications can just query platform information right now and just use
them for mbind() without requiring this new interface. We are not even
changing any core MM yet. So if it's just about identifying the node's
memory properties it can be scanned from platform itself. But I agree
we would like the kernel to start adding interfaces for multi attribute
memory but all I am saying is that it has to be comprehensive. Some of
the attributes have more usefulness now and some have less but the new
ABI interface has to accommodate exporting all of these.
