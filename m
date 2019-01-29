Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAE6C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71750214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfA2BSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:18:14 -0500
Received: from ozlabs.org ([203.11.71.1]:42707 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbfA2BSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:18:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43pTC33jzjz9sCX;
        Tue, 29 Jan 2019 12:18:06 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dave Hansen <dave.hansen@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Huang Ying <ying.huang@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>, baiyaowei@cmss.chinamobile.com,
        Takashi Iwai <tiwai@suse.de>,
        Jerome Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/5] mm/resource: return real error codes from walk failures
In-Reply-To: <4898e064-5298-6a82-83ea-23d16f3dfb3d@intel.com>
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231442.EFD29EE0@viggo.jf.intel.com> <CAErSpo7kMjfi-1r8ZyGbheWzo+JCFkDZ1zpVhyNV7VVy8NOV7g@mail.gmail.com> <4898e064-5298-6a82-83ea-23d16f3dfb3d@intel.com>
Date:   Tue, 29 Jan 2019 12:18:05 +1100
Message-ID: <87k1ios1ma.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:
> On 1/25/19 1:02 PM, Bjorn Helgaas wrote:
>>> @@ -453,7 +453,7 @@ int walk_system_ram_range(unsigned long
>>>         unsigned long flags;
>>>         struct resource res;
>>>         unsigned long pfn, end_pfn;
>>> -       int ret = -1;
>>> +       int ret = -EINVAL;
>> Can you either make a similar change to the powerpc version of
>> walk_system_ram_range() in arch/powerpc/mm/mem.c or explain why it's
>> not needed?  It *seems* like we'd want both versions of
>> walk_system_ram_range() to behave similarly in this respect.
>
> Sure.  A quick grep shows powerpc being the only other implementation.

Ugh gross, why are we reimplementing it? ...

Oh right, memblock vs iomem. We should fix that one day :/

> I'll just add this hunk:
>
>> diff -puN arch/powerpc/mm/mem.c~memory-hotplug-walk_system_ram_range-returns-neg-1 arch/powerpc/mm/mem.c
>> --- a/arch/powerpc/mm/mem.c~memory-hotplug-walk_system_ram_range-returns-neg-1  2019-01-25 12:57:00.000004446 -0800
>> +++ b/arch/powerpc/mm/mem.c     2019-01-25 12:58:13.215004263 -0800 
>> @@ -188,7 +188,7 @@ walk_system_ram_range(unsigned long star 
>>         struct memblock_region *reg; 
>>         unsigned long end_pfn = start_pfn + nr_pages; 
>>         unsigned long tstart, tend; 
>> -       int ret = -1; 
>> +       int ret = -EINVAL; 
>
> I'll also dust off the ol' cross-compiler and make sure I didn't
> fat-finger anything.

Modern Fedora & Ubuntu have packaged cross toolchains. Otherwise there's
the kernel.org ones, or bootlin has versions with libc if you need it.

Patch looks fine. That value could only get to userspace if we have no
memory, which would be interesting.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
