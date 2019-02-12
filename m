Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8803FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6180B2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfBLJt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:49:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:31034 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfBLJt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:49:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 01:49:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="125800641"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga003.jf.intel.com with ESMTP; 12 Feb 2019 01:49:56 -0800
Subject: Re: [PATCH v9 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
To:     Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.li@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20190211185931.4386-1-aubrey.li@intel.com>
 <20190211185931.4386-2-aubrey.li@intel.com>
 <alpine.DEB.2.21.1902120905420.1654@nanos.tec.linutronix.de>
 <efe3e5c9-c477-8a28-5489-c943fe63efaa@linux.intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <7fb97f08-daac-1dad-f51e-13fe6753832c@linux.intel.com>
Date:   Tue, 12 Feb 2019 17:49:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <efe3e5c9-c477-8a28-5489-c943fe63efaa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/12 17:14, Li, Aubrey wrote:
> On 2019/2/12 16:22, Thomas Gleixner wrote:
>> On Tue, 12 Feb 2019, Aubrey Li wrote:
>>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
>>> index d53c54b842da..60ee932070fe 100644
>>> --- a/arch/x86/include/asm/processor.h
>>> +++ b/arch/x86/include/asm/processor.h
>>> @@ -996,5 +996,7 @@ enum l1tf_mitigations {
>>>  };
>>>  
>>>  extern enum l1tf_mitigations l1tf_mitigation;
>>> +/* Add support for architecture specific output in /proc/pid/status */
>>> +extern void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
>>
>> Sigh. This is absolutely the wrong place. The weak function is declared and
>> used in fs/proc/... So the prototype wants to be in a header which is
>> included from there independent of x86...
> 
> Can the prototype be in the architecture header if they want to call the function?
> Like the following? arch_report_meminfo() is used in fs/proc/... as well.
> 
> $ find . -name *.h | xargs grep arch_report_meminfo
> ./arch/s390/include/asm/pgtable.h:void arch_report_meminfo(struct seq_file *m);
> ./arch/x86/include/asm/pgtable_types.h:extern void arch_report_meminfo(struct seq_file *m);
> ./arch/parisc/include/asm/pgtable.h:extern void arch_report_meminfo(struct seq_file *m);
> 

Actually both way exist in the current kernel,the reason I chose to put the prototype
into architecture header file is that I found some architectures rename the function
name by a micro definition while others use prototype. See below:

$ find . -name *.h | xargs grep arch_irq_stat
./arch/arm64/include/asm/hardirq.h:#define arch_irq_stat_cpu	smp_irq_stat_cpu
./arch/arm/include/asm/hardirq.h:#define arch_irq_stat_cpu	smp_irq_stat_cpu
./arch/x86/include/asm/hardirq.h:extern u64 arch_irq_stat_cpu(unsigned int cpu);

This looks more flexible than it in the common header file.

Anyway, putting the prototype into the common header file like include/linux/proc_fs.h
is also acceptable to me if you persist, please just let me know, :)

Thanks,
-Aubrey
