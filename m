Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E593DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DFC20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DFC20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502124AbeKWRZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:25:51 -0500
Received: from foss.arm.com ([217.140.101.70]:36478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408204AbeKWRZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:25:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6BEE35CD;
        Thu, 22 Nov 2018 22:42:58 -0800 (PST)
Received: from [10.1.29.128] (p8cg001049571a15.cambridge.arm.com [10.1.29.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE1953F5A0;
        Thu, 22 Nov 2018 22:42:56 -0800 (PST)
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
To:     Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181114224902.12082-1-keith.busch@intel.com>
 <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com>
 <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com>
 <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
 <f5315662-5c1a-68a3-4d04-21b4b5ca94b1@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ac942498-8966-6a9b-0e55-c79ae167c679@arm.com>
Date:   Fri, 23 Nov 2018 12:12:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f5315662-5c1a-68a3-4d04-21b4b5ca94b1@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/2018 11:31 PM, Dave Hansen wrote:
> On 11/22/18 3:52 AM, Anshuman Khandual wrote:
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
> 
> My assumption has been that this kind of thing is too fancy for sysfs:

Applications need to know the matrix of multi attribute properties as
seen from various memory accessors/initiators to be able to bind them
to desired CPUs and memory. That gives applications true view of an
heterogeneous system. While I understand your concern here about the
sysfs (which can be worked around with probably multiple global files
may be if the size is a problem etc) but an insufficient interface is
definitely problematic in longer term. This is going to be an ABI which
is locked in for good. Hence even it might appear over engineering at
the moment but IMHO is the right thing to do.

> 
> Documentation/filesystems/sysfs.txt:
>> Attributes should be ASCII text files, preferably with only one value
>> per file. It is noted that it may not be efficient to contain only one
>> value per file, so it is socially acceptable to express an array of
>> values of the same type. 
>>
>> Mixing types, expressing multiple lines of data, and doing fancy
>> formatting of data is heavily frowned upon. Doing these things may get
>> you publicly humiliated and your code rewritten without notice. 
> 
> /proc/pid/pagemap is binary, not one-value-per-file and relatively
> complicated to parse.

I agree but it does provide user space really valuable information about
the faulted pages for it's VA space. Was there any better way of getting
it ? May be but at this point in time it is essential.

> 
> Do you really think following something like pagemap is the right model
> for sysfs.> 
> BTW, I'm not saying we don't need *some* interface like you propose.  We
> almost certainly will at some point.  I just don't think it will be in
> sysfs.

I am not saying doing this in sysfs is very elegant. I would rather have
a syscall read back (MAX_NODES * MAX_NODES * u64) attribute matrix from
the kernel. Probably a subset of that information can appear on sysfs to
speed of queries for various optimizations as Keith mentioned before. But
we will have to first evaluate and come to an agreement what constitutes
a comprehensive set for multi attribute properties. Are we willing to go
in the direction for inclusion of a new system call, subset of it appears
on sysfs etc ? My primary concern is not how the attribute information
appears on the sysfs but lack of it's completeness.
