Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92350C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DDE20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Tm8ULAOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DDE20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=runbox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeGXNtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:49:03 -0400
Received: from aibo.runbox.com ([91.220.196.211]:36844 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeGXNtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
        bh=0By32EOjOrZPnFmL5TblDwLA9GgGrbmlPdx21rwlB/w=; b=Tm8ULAOL8lcSWyCPijnG2GS45A
        1NcaOWnRsyD8H8J4XJvKJrun8CAPoFKftK7EiJ3/gzYmtYOizv4CUFbYJsLePAUhcBXUvZJ82jWJz
        Hcto6kMhFpnxgUe5rMNF9zDc/XdJm6yz1HI3AOgOhIyH00pxgyrb7lR/DfdFqJTlFzYi6Iuw813KT
        a11pTpFJJtxYpzbdMQpxJhwAlqAYNiSNYa4TXigHgVM12EiIrMc3Y/SebPZpdiYmkg/RYS/mF/F+X
        /Gd4ylkyKYU6ys+dt6rljuzYz/PMbJqe0+MCOXquPVVwNzGKxyuWvpUBJNDMOzm77NyjQ8b0wYmvt
        b2Ux6xKA==;
Received: from [10.9.9.210] (helo=mailfront10.runbox.com)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1fhweE-00080x-GE; Tue, 24 Jul 2018 14:42:38 +0200
Received: by mailfront10.runbox.com with esmtpsa  (uid:769847 )  (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        id 1fhwe9-0005TA-R5; Tue, 24 Jul 2018 14:42:34 +0200
Subject: Re: [PATCH 2/2] xen/pv: Call get_cpu_address_sizes to set
 x86_virt/phys_bits
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        stable@vger.kernel.org
References: <20180721194909.23903-1-m.v.b@runbox.com>
 <20180721194909.23903-2-m.v.b@runbox.com>
 <90bc371d-a296-51b3-8b78-62106c9690de@oracle.com>
 <d85c93da-4549-a7c1-af48-9c62cba8ae71@runbox.com>
 <13b774d7-bc8c-039a-fbc0-52318f535883@runbox.com>
 <8c17dccf-d382-0ba4-612c-8c674f5dd9e0@oracle.com>
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
Message-ID: <c4589666-1c12-ea45-7eb9-4339a0067e34@runbox.com>
Date:   Tue, 24 Jul 2018 08:42:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8c17dccf-d382-0ba4-612c-8c674f5dd9e0@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 11:04 AM, Boris Ostrovsky wrote:
> On 07/22/2018 11:57 AM, M. Vefa Bicakci wrote:
>> On 07/21/2018 07:17 PM, M. Vefa Bicakci wrote:
>>> On 07/21/2018 05:25 PM, Boris Ostrovsky wrote:
>>>> On 07/21/2018 03:49 PM, M. Vefa Bicakci wrote:
>>>>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>>>>> index 439a94bf89ad..87afb000142a 100644
>>>>> --- a/arch/x86/xen/enlighten_pv.c
>>>>> +++ b/arch/x86/xen/enlighten_pv.c
>>>>> @@ -1257,6 +1257,7 @@ asmlinkage __visible void __init
>>>>> xen_start_kernel(void)
>>>>>        /* Work out if we support NX */
>>>>>        get_cpu_cap(&boot_cpu_data);
>>>>> +    get_cpu_address_sizes(&boot_cpu_data);
>>>>>        x86_configure_nx();
>>>>
>>>>
>>>> Have you observed any problems without this call? get_cpu_cap() is only
>>>> called here to set X86_FEATURE_NX, and is then called again, together
>>>> with get_cpu_address_sizes(), from early_identify_cpu().
>>>
>>> Thank you for the reviews! Without the call to get_cpu_address_sizes,
>>> paravirtualized virtual machines do not boot up kernels with versions
>>> 4.17 and up at all; this includes dom0 and domU. No domU logs are
>>> generated in dom0's /var/log/xen/console/ directory either, despite
>>> having earlyprintk=xen on the kernel command line for my test domU.
>>
>> Hello Boris,
>>
>> I debugged this further with a debugging version of Xen (so that I can
>> get early kernel print-outs via the "xen_raw_console_write" function),
>> and I found the root cause of the boot up failure.
>>
>> In summary, the issue is due to the following call path in version
>> 4.17 (and higher, I assume), which the kernel goes through /only/ when
>> CONFIG_DEBUG_VIRTUAL is enabled:
>>
>> enlighten_pv.c::xen_start_kernel
>>    mmu_pv.c::xen_reserve_special_pages
>>      page.h::__pa
>>        physaddr.c::__phys_addr
>>          physaddr.h::phys_addr_valid // uses boot_cpu_data.x86_phys_bits
>>
>> The return value of phys_addr_valid is used with the VIRTUAL_BUG_ON
>> macro,
>> which evaluates to BUG_ON in case CONFIG_DEBUG_VIRTUAL is enabled.
> 
> 
> Ah, that's why it hasn't been detected.
> 
> 
>>
>> It looks like the call to get_cpu_address_size is required in the
>> xen_start_kernel function. Perhaps there is a more elegant way to
>> resolve this issue as well.
>>
>> Another approach could be to check in the phys_addr_valid function
>> whether
>> boot_cpu_data.x86_phys_bits has been initialized or not, I think, but
>> I am
>> not sure about the correctness of this approach.
> 
> 
> No, I think your patch is good. The only thing I'd suggest is to move
> the call a few lines down. The way it is placed now may create
> impression that we are calling get_cpu_address_sizes() to figure out NX
> support.

Sorry for the delay, and thank you for your comments! I will
send an updated version of this patch in a few moments.

Vefa
