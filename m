Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6056BC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF8121773
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Pu8jtDqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfAIA6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:58:30 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:37724 "EHLO
        mail2.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAIA6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:58:30 -0500
Received: from [192.168.100.195] (firewall.candelatech.com [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail2.candelatech.com (Postfix) with ESMTPSA id AA52140A5CB;
        Tue,  8 Jan 2019 16:58:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.candelatech.com AA52140A5CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1546995507;
        bh=H9WRq+ofNBsd2b+/IChDtHEgZ9k2lnLKvsUnSt3VsEU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Pu8jtDqg7i6KNEJ7p1kdEU7dqDz4/Fp75s8ESf6LWLMdzIpS8PcpEsStT5KwVl2WA
         S5TZgM/otgdsK6uWZdeJPrzkuQhFlYw/2TSo8s/t4CvX92hOGUonScIX4i9bLms/Sj
         bnsXeu8vNNXDY5qpAUrTpf2Iaaqu086GY7dPiRqg=
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and its
 mitigations
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
 <1c7923ec-70aa-25d4-3de1-f1b1768bb80b@candelatech.com>
 <fdf4e1cd-9b28-75c7-6846-6d0f5b816936@linux.intel.com>
 <5d45f3ef-a91f-815a-f532-62e75899e697@candelatech.com>
 <0d89b5a0-01d3-4927-ce59-fd9dc24c53b3@linux.intel.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <234fe108-1cdd-b97e-4c19-a0be6d5858d5@candelatech.com>
Date:   Tue, 8 Jan 2019 16:58:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <0d89b5a0-01d3-4927-ce59-fd9dc24c53b3@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 9:57 AM, Tim Chen wrote:
> On 12/31/18 8:22 AM, Ben Greear wrote:
>>
>>
>> On 12/21/2018 05:17 PM, Tim Chen wrote:
>>>
>>> If you don't worry about security and performance is paramount, then
>>> boot with "nospectre_v2".  That's explained in the document.
>>
>> There seem to be lots of different variants of this type of problem.  It was not clear
>> to me that just doing nospectre_v2 would be sufficient to get back full performance.
> 
> The performance penalty comes from retpoline penalizing indirect branch predictions in kernel.
> With nospectre_v2, retpoline is disabled so you should get all the performance
> back from spectre mitigation.
> 
> This does not disable kernel page table isolation for meltdown mitigation, which also
> needs to be turned off if you want to get the full performance back.  That's somewhat
> beyond the scope of this doc on Spectre.

The two bug families (spectre and meltdown) are conflated in my mind, at least.

For those of us who do not really understand this stuff in detail, it would
be good to at least mention some notes about Meltdown I think.

>> And anyway, I would like to compile the kernel to not need that command-line option,
>> so I am still interesting in what compile options need to be set to what values...
>>
> 
> If you just want to disable spectre mitigation, setting CONFIG_RETPOLINE=n should do
> the  trick.  If you also want to disable meltdown mitigation,
> set CONFIG_PAGE_TABLE_ISOLATION=n.

Ok, are there any other CONFIG options that relate to fixing security bugs that
have noticeable performance impacts or are these two the complete list?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

