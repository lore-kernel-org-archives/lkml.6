Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F1CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDA5206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDA5206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436795AbeKWACF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:02:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48340 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732181AbeKWACF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:02:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BB303622;
        Thu, 22 Nov 2018 05:22:45 -0800 (PST)
Received: from [10.1.26.189] (p8cg001049571a15.cambridge.arm.com [10.1.26.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09F9E3F5AF;
        Thu, 22 Nov 2018 05:22:43 -0800 (PST)
Subject: Re: [PATCH 2/7] node: Add heterogenous memory performance
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-3-keith.busch@intel.com>
 <91369e94-d389-7cb9-6274-f46c9ec779d3@arm.com>
 <20181119154604.GC23062@localhost.localdomain>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2482fbdf-e672-8d46-edcb-021f7af8d9b7@arm.com>
Date:   Thu, 22 Nov 2018 18:52:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181119154604.GC23062@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/2018 09:16 PM, Keith Busch wrote:
> On Mon, Nov 19, 2018 at 09:05:07AM +0530, Anshuman Khandual wrote:
>> On 11/15/2018 04:19 AM, Keith Busch wrote:
>>> Heterogeneous memory systems provide memory nodes with latency
>>> and bandwidth performance attributes that are different from other
>>> nodes. Create an interface for the kernel to register these attributes
>>
>> There are other properties like power consumption, reliability which can
>> be associated with a particular PA range. Also the set of properties has
>> to be extensible for the future.
> 
> Sure, I'm just starting with the attributes available from HMAT, 
> If there are additional possible attributes that make sense to add, I
> don't see why we can't continue appending them if this patch is okay.

As I mentioned on the other thread

1) The interface needs to be compact to avoid large number of files
2) Single U64 will be able to handle 8 attributes with 8 bit values
3) 8 bit value needs needs to be arch independent and abstracted out

I guess 8 attributes should be good enough for all type of memory in
foreseeable future.

>  
>>> under the node that provides the memory. If the system provides this
>>> information, applications can query the node attributes when deciding
>>> which node to request memory.
>>
>> Right but each (memory initiator, memory target) should have these above
>> mentioned properties enumerated to have an 'property as seen' from kind
>> of semantics.
>>
>>>
>>> When multiple memory initiators exist, accessing the same memory target
>>> from each may not perform the same as the other. The highest performing
>>> initiator to a given target is considered to be a local initiator for
>>> that target. The kernel provides performance attributes only for the
>>> local initiators.
>>
>> As mentioned above the interface must enumerate a future extensible set
>> of properties for each (memory initiator, memory target) pair available
>> on the system.
> 
> That seems less friendly to use if forces the application to figure out
> which CPU is the best for a given memory node rather than just provide
> that answer directly.

Why ? The application would just have to scan all possible values out
there and decide for itself. A complete set of attribute values for
each pair makes the sysfs more comprehensive and gives the application
more control over it's choices.

> 
>>> The memory's compute node should be symlinked in sysfs as one of the
>>> node's initiators.
>>
>> Right. IIUC the first patch skips the linking process of for two nodes A
>> and B if (A == B) preventing association to local memory initiator.
> 
> Right, CPUs and memory sharing a proximity domain are assumed to be
> local to each other, so not going to set up those links to itself.

But this will be required for applications to evaluate correctly between
possible values from all node pairs.

