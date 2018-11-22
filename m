Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C24C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77EF20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77EF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394984AbeKVWb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:31:26 -0500
Received: from foss.arm.com ([217.140.101.70]:46574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730549AbeKVWbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:31:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9831361A;
        Thu, 22 Nov 2018 03:52:21 -0800 (PST)
Received: from [10.1.26.189] (p8cg001049571a15.cambridge.arm.com [10.1.26.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 469653F5A0;
        Thu, 22 Nov 2018 03:52:20 -0800 (PST)
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
Date:   Thu, 22 Nov 2018 17:22:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/2018 11:07 PM, Dave Hansen wrote:
> On 11/18/18 9:44 PM, Anshuman Khandual wrote:
>> IIUC NUMA re-work in principle involves these functional changes
>>
>> 1. Enumerating compute and memory nodes in heterogeneous environment (short/medium term)
> 
> This patch set _does_ that, though.
> 
>> 2. Enumerating memory node attributes as seen from the compute nodes (short/medium term)
> 
> It does that as well (a subset at least).
> 
> It sounds like the subset that's being exposed is insufficient for yo
> We did that because we think doing anything but a subset in sysfs will
> just blow up sysfs:  MAX_NUMNODES is as high as 1024, so if we have 4
> attributes, that's at _least_ 1024*1024*4 files if we expose *all*
> combinations.
Each permutation need not be a separate file inside all possible NODE X
(/sys/devices/system/node/nodeX) directories. It can be a top level file
enumerating various attribute values for a given (X, Y) node pair based
on an offset something like /proc/pid/pagemap.

> 
> Do we agree that sysfs is unsuitable for exposing attributes in this manner?
> 

Yes, for individual files. But this can be worked around with an offset
based access from a top level global attributes file as mentioned above.
Is there any particular advantage of using individual files for each
given attribute ? I was wondering that a single unsigned long (u64) will
be able to pack 8 different attributes where each individual attribute
values can be abstracted out in 8 bits.
