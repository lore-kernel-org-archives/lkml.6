Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032582AbeBOCBp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 21:01:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:9131 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032245AbeBOCBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 21:01:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,515,1511856000";
   d="scan'208";a="204327441"
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave@sr71.net>,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@infradead.org>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
 <20180212165835.GO25181@hirez.programming.kicks-ass.net>
 <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
 <5c3ba123-abbe-f153-7b75-a89d31d25c72@linux.intel.com>
 <20180214085614.GT25181@hirez.programming.kicks-ass.net>
 <1fd7c8ef-a50c-53d8-7159-d992e669c2f2@linux.intel.com>
 <20180214231904.ww46gjnytbx3jqef@gmail.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <97bc2ca2-7d5b-c206-5c23-902ed3586256@linux.intel.com>
Date: Wed, 14 Feb 2018 18:01:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20180214231904.ww46gjnytbx3jqef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 03:19 PM, Ingo Molnar wrote:
> 
> * Tim Chen <tim.c.chen@linux.intel.com> wrote:
> 
>> On 02/14/2018 12:56 AM, Peter Zijlstra wrote:
>>
>>>
>>> At the very least this must disable and re-enable preemption, such that
>>> we guarantee we inc/dec the same counter. ISTR some firmware calls (EFI)
>>> actually are preemptible so that wouldn't work.
>>>
>>> Further, consider:
>>>
>>> 	this_cpu_inc_return()		// 0->1
>>> 	<NMI>
>>> 		this_cpu_inc_return()	// 1->2
>>> 		call_broken_arse_firmware()
>>> 		this_cpu_dec_return()	// 2->1
>>> 	</NMI>
>>> 	wrmsr(SPEC_CTRL, IBRS);
>>>
>>> 	/* from dodgy firmware crap */
>>>
>>> 	this_cpu_dec_return()		// 1->0
>>> 	wrmsr(SPEC_CTRL, 0);
>>>
>>
>> How about the following patch.
> 
> These fragile complications of the interface should now be unnecessary, as the 
> only driver that called firmware from NMI callbacks (hpwdt.c) is going to remove 
> those firmware callbacks in the near future - solving the problem at the source.
> 
> Thanks,
> 
> 	Ingo
> 

Sounds good. I sent this out before seeing the other mails on removing NMI callbacks
from hpwdt.c

Tim
