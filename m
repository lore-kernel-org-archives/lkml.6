Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D9EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25FF208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25FF208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbeK0U3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:29:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59558 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbeK0U3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:29:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 397CF3563;
        Tue, 27 Nov 2018 01:32:07 -0800 (PST)
Received: from [10.1.196.73] (unknown [10.1.196.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2AAB3F575;
        Tue, 27 Nov 2018 01:32:05 -0800 (PST)
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
 <ac942498-8966-6a9b-0e55-c79ae167c679@arm.com>
 <9015e51a-3584-7bb2-cc5e-25b0ec8e5494@intel.com>
 <1a9e887b-8087-e897-6195-e8df325bd458@arm.com>
 <3b86c5c5-53f2-29bf-48e7-5749c7287dca@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6208771a-43da-ecc4-40ed-8e99cd5169fc@arm.com>
Date:   Tue, 27 Nov 2018 15:02:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3b86c5c5-53f2-29bf-48e7-5749c7287dca@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2018 10:50 PM, Dave Hansen wrote:
> On 11/26/18 7:38 AM, Anshuman Khandual wrote:
>> On 11/24/2018 12:51 AM, Dave Hansen wrote:
>>> On 11/22/18 10:42 PM, Anshuman Khandual wrote:
>>>> Are we willing to go in the direction for inclusion of a new system
>>>> call, subset of it appears on sysfs etc ? My primary concern is not
>>>> how the attribute information appears on the sysfs but lack of it's
>>>> completeness.
>>>
>>> A new system call makes total sense to me.  I have the same concern
>>> about the completeness of what's exposed in sysfs, I just don't see a
>>> _route_ to completeness with sysfs itself.  Thus, the minimalist
>>> approach as a first step.
>>
>> Okay if we agree on the need for a new specific system call extracting
>> the superset attribute information MAX_NUMNODES * MAX_NUMNODES * U64
>> (u64 packs 8 bit values for 8 attributes or something like that) as we
>> had discussed before, it makes sense to export a subset of it which can
>> be faster but useful for the user space without going through a system
>> call. 
> 
> The information that needs to be exported is a bit more than that.  It's
> not just a binary attribute.

Right wont be binary because it would contain a value for an attribute.

> 
> The information we have from the new ACPI table, for instance, is the
> read and write bandwidth and latency between two nodes.  They are, IIRC,
> two-byte values in the ACPI table[1], each.  That's 8 bytes worth of
> data right there, which wouldn't fit *anything* else.

Hmm I get your point. We would need to have interfaces both system call
and sysfs where number of attributes and bit field to contain value for
any attribute can grow in the future with backward compatibility. 

> 
> The list of things we want to export will certainly grow.  That means we
> need a syscall something like this:
> 
> int get_mem_attribute(unsigned long attribute_nr,
> 		      unsigned long __user * initiator_nmask,
> 		      unsigned long __user * target_nmask,
> 		      unsigned long maxnode,
> 		      unsigned long *attributes_out);

Agreed. I was also thinking something like above syscall interface works
where attribute_nr can grow as an enum with MAX_MEM_ATTRIBUTES increasing
but still keeping previous order intact for backward compatibility. But I
guess we would need to pass a size of an attribute structure (UAPI like
perf_event_attr) so that it can grow further but then structure packing
order is maintained for backward compatibility.

int get_mem_attribute(unsigned long attribute_nr,
		      unsigned long __user * initiator_nmask,
		      unsigned long __user * target_nmask,
		      unsigned long maxnode,
 		      unsigned long *attributes_out,
		      size_t attribute_size);

 
> 
> #define MEM_ATTR_READ_BANDWIDTH		1
> #define MEM_ATTR_WRITE_BANDWIDTH	2
> #define MEM_ATTR_READ_LATENCY		3
> #define MEM_ATTR_WRITE_LATENCTY		4
> #define MEM_ATTR_ENCRYPTION		5
> 
> If you want to know the read latency between nodes 4 and 8, you do:
> 
> 	ret = get_mem_attr(MEM_ATTR_READ_LATENCY,
> 			   (1<<4), (1<<8), max, &array);
> 
> And the answer shows up at array[0] in this example.  If you had more
> than one bit set in the two nmasks, you would have a longer array.
> 
> The length of the array is the number of bits set in initiator_nmask *
> the number of bits set in target_nmask * sizeof(ulong).

Right. Hmm, I guess now that the interface is requesting for a single
attribute it does not have to worry about structure for the attribute
field. A single ULONG_MAX should be enough to hold value for any given
attribute and also it does not have to worry much about compatibility.
This is better.

> 
> This has the advantage of supporting ULONG_MAX attributes, and scales

Right.

> from asking for one attribute at a time all the way up to dumping the
> entire system worth of data for a single attribute.  The only downside

Right.

> is that it's one syscall per attribute instead of packing them all
> together.  But, if we have a small enough number to pack them in one
> ulong, then I think we can make 64 syscalls without too much trouble.

I agree. It also enables single attribute to have ULONG_MAX length value
and avoid compatibility issues because of packing order due to multiple
attributes requested together. This is definitely a cleaner interface.

> 
>> Do you agree on a (system call + sysfs) approach in principle ?
>> Also sysfs exported information has to be derived from whats available
>> through the system call not the other way round. Hence the starting
>> point has to be the system call definition.
> 
> Both the sysfs information *and* what will be exported in any future
> interfaces are derived from platform-specific information.  They are not
> derived from one _interface_ or the other.
> 
> They obviously need to be consistent, though.

What I meant was the most comprehensive set of information should be
available to be fetched from the system call. Any other interface like
sysfs (or some other) will have to be a subset of whats available through
the system call. It should never be the case where there are information
available via sysfs but not through system call route. What is exported
through either syscall or sysfs will always be derived from platform
specific information.

> 
> 1. See "Table 5-142 System Locality Latency and Bandwidth Information
> Structure" here:
> http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> 

In conclusion something like this sort of a system call interface really
makes sense and can represent superset of memory attribute information.
