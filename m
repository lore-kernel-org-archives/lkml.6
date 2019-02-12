Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56513C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287E920811
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfBLMCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:02:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:38648 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfBLMCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:02:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 04:02:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="125828692"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga003.jf.intel.com with ESMTP; 12 Feb 2019 04:02:34 -0800
Subject: Re: [PATCH v9 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Aubrey Li <aubrey.li@intel.com>, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <20190211185931.4386-1-aubrey.li@intel.com>
 <20190211185931.4386-2-aubrey.li@intel.com>
 <alpine.DEB.2.21.1902120905420.1654@nanos.tec.linutronix.de>
 <efe3e5c9-c477-8a28-5489-c943fe63efaa@linux.intel.com>
 <alpine.DEB.2.21.1902121215590.3710@nanos.tec.linutronix.de>
 <7cf6f2bb-780d-5c0d-ac3f-e88ced3a0404@linux.intel.com>
 <alpine.DEB.2.21.1902121254340.3710@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <8434e9a2-6173-4e2b-f635-51a1683bcd25@linux.intel.com>
Date:   Tue, 12 Feb 2019 20:02:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902121254340.3710@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/12 19:55, Thomas Gleixner wrote:
> On Tue, 12 Feb 2019, Li, Aubrey wrote:
>> On 2019/2/12 19:19, Thomas Gleixner wrote:
>>> On Tue, 12 Feb 2019, Li, Aubrey wrote:
>>>> On 2019/2/12 16:22, Thomas Gleixner wrote:
>>>>> On Tue, 12 Feb 2019, Aubrey Li wrote:
>>>>>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
>>>>>> index d53c54b842da..60ee932070fe 100644
>>>>>> --- a/arch/x86/include/asm/processor.h
>>>>>> +++ b/arch/x86/include/asm/processor.h
>>>>>> @@ -996,5 +996,7 @@ enum l1tf_mitigations {
>>>>>>  };
>>>>>>  
>>>>>>  extern enum l1tf_mitigations l1tf_mitigation;
>>>>>> +/* Add support for architecture specific output in /proc/pid/status */
>>>>>> +extern void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
>>>>>
>>>>> Sigh. This is absolutely the wrong place. The weak function is declared and
>>>>> used in fs/proc/... So the prototype wants to be in a header which is
>>>>> included from there independent of x86...
>>>>
>>>> Can the prototype be in the architecture header if they want to call the
>>>> function?
>>>
>>> Basic C programming course:
>>>
>>>  The prototype must be available before the declaration of the global
>>>  function.
>>>
>>> fs/proc/array.c:404:13: warning: no previous prototype for ‘arch_proc_pid_status’ [-Wmissing-prototypes]
>>>  void __weak arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
>>>
>>> Oh well....
>>
>> Is this because patch 1/3 applied alone? If the whole patch set are applied,
>> the prototype is included in <asm/processor.h>, which is at the beginning of
>> array.c file, so it is available before the declaration.
> 
> 1) Each patch has to be correct stand alone
> 
> 2) This file is compiled for every architecture the kernel supports and how
>    many of them are including arch/x86/include/asm/processor.h ?
> 
>    There is a world outside x86 and it's rather large.

Got it, thanks!

> 
> Thanks,
> 
> 	tglx
> 

