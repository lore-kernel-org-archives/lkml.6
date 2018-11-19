Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6B5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606A620823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606A620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeKSNhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:37:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50112 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbeKSNhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 08:37:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F13CF80D;
        Sun, 18 Nov 2018 19:15:28 -0800 (PST)
Received: from [10.162.0.72] (unknown [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C74A3F5A0;
        Sun, 18 Nov 2018 19:15:26 -0800 (PST)
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
To:     Keith Busch <keith.busch@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181115135710.GD19286@bombadil.infradead.org>
 <20181115145920.GG11416@localhost.localdomain>
 <20181115203654.GA28246@bombadil.infradead.org>
 <20181116183254.GD14630@localhost.localdomain>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d5c7a267-840b-f253-ef0d-3715b2bcc196@arm.com>
Date:   Mon, 19 Nov 2018 08:45:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181116183254.GD14630@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2018 12:02 AM, Keith Busch wrote:
> On Thu, Nov 15, 2018 at 12:36:54PM -0800, Matthew Wilcox wrote:
>> On Thu, Nov 15, 2018 at 07:59:20AM -0700, Keith Busch wrote:
>>> On Thu, Nov 15, 2018 at 05:57:10AM -0800, Matthew Wilcox wrote:
>>>> On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
>>>>> Memory-only nodes will often have affinity to a compute node, and
>>>>> platforms have ways to express that locality relationship.
>>>>>
>>>>> A node containing CPUs or other DMA devices that can initiate memory
>>>>> access are referred to as "memory iniators". A "memory target" is a
>>>>> node that provides at least one phyiscal address range accessible to a
>>>>> memory initiator.
>>>>
>>>> I think I may be confused here.  If there is _no_ link from node X to
>>>> node Y, does that mean that node X's CPUs cannot access the memory on
>>>> node Y?  In my mind, all nodes can access all memory in the system,
>>>> just not with uniform bandwidth/latency.
>>>
>>> The link is just about which nodes are "local". It's like how nodes have
>>> a cpulist. Other CPUs not in the node's list can acces that node's memory,
>>> but the ones in the mask are local, and provide useful optimization hints.
>>
>> So ... let's imagine a hypothetical system (I've never seen one built like
>> this, but it doesn't seem too implausible).  Connect four CPU sockets in
>> a square, each of which has some regular DIMMs attached to it.  CPU A is
>> 0 hops to Memory A, one hop to Memory B and Memory C, and two hops from
>> Memory D (each CPU only has two "QPI" links).  Then maybe there's some
>> special memory extender device attached on the PCIe bus.  Now there's
>> Memory B1 and B2 that's attached to CPU B and it's local to CPU B, but
>> not as local as Memory B is ... and we'd probably _prefer_ to allocate
>> memory for CPU A from Memory B1 than from Memory D.  But ... *mumble*,
>> this seems hard.
> 
> Indeed, that particular example is out of scope for this series. The
> first objective is to aid a process running in node B's CPUs to allocate
> memory in B1. Anything that crosses QPI are their own.

This is problematic. Any new kernel API interface should accommodate B2 type
memory as well from the above example which is on a PCIe bus. Because
eventually they would be represented as some sort of a NUMA node and then
applications will have to depend on this sysfs interface for their desired
memory placement requirements. Unless this interface is thought through for
B2 type of memory, it might not be extensible in the future.
