Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64176C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1122243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1122243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbeKMXFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:05:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:42560 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732728AbeKMXFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:05:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 05:06:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="107867831"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2018 05:06:48 -0800
Subject: Re: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
To:     David Laight <David.Laight@ACULAB.COM>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.li@intel.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
 <alpine.DEB.2.21.1811091121340.1519@nanos.tec.linutronix.de>
 <657a9ee9-bb27-968a-34ae-e25df6c2fff9@linux.intel.com>
 <25dd33ee964f4de5ae33a1575e1bf47f@AcuMS.aculab.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <2229f120-cb11-8f8e-f27d-eabc94457cd5@linux.intel.com>
Date:   Tue, 13 Nov 2018 21:06:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <25dd33ee964f4de5ae33a1575e1bf47f@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/13 18:25, David Laight wrote:
> From: Li, Aubrey
>> Sent: 12 November 2018 01:41
> ...
>> VZEROUPPER instruction resets the init state. If context switch happens
>> to occur exactly after VZEROUPPER instruction, XINUSE bitmap is empty(all
>> zeros), which indicates the task is not using AVX. That's why the state
>> decay count is used here.
> 
> Isn't there an obvious optimisation to execute VZEROALL during system call
> entry?

I'm not aware of this in the kernel, maybe you are talking about some 
optimization in glibc?

> If that is done does any of this actually work?

The bitmap is checked during context switch, not system call entry.

Also, the flag is turned on immediately once it's detected, but requires 3
*consecutive* context switches with no usage to clear. So it could filter
most jitter patterns out.

I measured tensorflow(with AVX512), linpack(with AVX512) and a micro
benchmark, this works properly.

If you have a AVX512 workload, I'd like to know if this works for it.

Thanks,
-Aubrey
> 
> 	David
>  
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

