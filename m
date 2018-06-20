Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2214DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDABE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDABE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeFTMmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:42:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:46425 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbeFTMmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:42:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 05:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,247,1526367600"; 
   d="scan'208";a="58808372"
Received: from dengy1x-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.213.248])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2018 05:41:57 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fVcQv-0001YD-88; Wed, 20 Jun 2018 20:41:57 +0800
Date:   Wed, 20 Jun 2018 20:41:57 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180620124157.gd5245o63dq6teul@wfg-t540p.sh.intel.com>
References: <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV>
 <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
 <CACT4Y+a6nUqdpSyYGGcXKAgVbcw+uQOz2kYx8tUS+8T5-bzqkg@mail.gmail.com>
 <20180620113731.y7apmqoh6ke6ar2v@wfg-t540p.sh.intel.com>
 <CACT4Y+bw5j9aTRVFKHNO-YH0vXtuOvB4ez4wg6C=1GpSbvfSAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACT4Y+bw5j9aTRVFKHNO-YH0vXtuOvB4ez4wg6C=1GpSbvfSAQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 02:31:51PM +0200, Dmitry Vyukov wrote:
>On Wed, Jun 20, 2018 at 1:37 PM, Fengguang Wu <fengguang.wu@intel.com> wrote:
>> On Wed, Jun 20, 2018 at 11:30:05AM +0200, Dmitry Vyukov wrote:
>>>
>>> On Wed, Jun 20, 2018 at 11:06 AM, Sergey Senozhatsky
>>> <sergey.senozhatsky.work@gmail.com> wrote:
>>>>
>>>> Hi Dmitry,
>>>>
>>>> On (06/20/18 10:45), Dmitry Vyukov wrote:
>>>>>
>>>>> Hi Sergey,
>>>>>
>>>>> What are the visible differences between this patch and Tetsuo's
>>>>> patch?
>>>>
>>>>
>>>> I guess none, and looking at your requirements below I tend to agree
>>>> that Tetsuo's approach is probably what you need at the end of the day.
>>>>
>>>>> The only thing that will matter for syzkaller parsing in the
>>>>> end is the resulting text format as it appears on console. But you say
>>>>> "I'm not pushing for this particular message format", so what exactly
>>>>> do you want me to provide feedback on?
>>>>> I guess we need to handle pr_cont properly whatever approach we take.
>>>>
>>>>
>>>> Mostly, was wondering about if:
>>>> a) you need pr_cont() handling
>>>> b) you need printk_safe() handling
>>>>
>>>> The reasons I left those things behind:
>>>>
>>>> a) pr_cont() is officially hated. It was never supposed to be used
>>>>    on SMP systems. So I wasn't sure if we need all that effort and
>>>>    add tricky code to handle pr_cont(). Given that syzkaller is
>>>>    probably the only user of that functionality.
>>>
>>>
>>> Well, if I put my syzkaller hat on, then I don't care what exactly
>>> happens in the kernel, the only thing I care is well-formed output on
>>> console that can be parsed unambiguously in all cases.
>>
>>
>> +1 for 0day kernel testing.
>>
>> I admit that goal may never be 100% achievable -- at least some serial
>> console logs can sometimes become messy. So we'll have to write dmesg
>> parsing code in defensive ways.
>>
>> But some unnecessary pr_cont() broken-up messages can obviously be
>> avoided. For example,
>>
>> arch/x86/mm/fault.c:
>>
>>         printk(KERN_ALERT "BUG: unable to handle kernel ");
>>         if (address < PAGE_SIZE)
>>                 printk(KERN_CONT "NULL pointer dereference");
>>         else
>>                 printk(KERN_CONT "paging request");
>>
>> I've actually proposed to remove the above KERN_CONT, unfortunately the
>> patch was silently ignored.
>
>
>I've just cooked this change too, but do you mind reviving your patch?

Yes, sure. My version is more dumb. Since I'm not sure if it's OK to
do string formatting at this critical point. Let's see how others
think about the 2 approaches. I'm fine as long as our problem is fixed. :)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9a84a0d08727..c7b068c6b010 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -671,11 +671,10 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
                        printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
        }

-       printk(KERN_ALERT "BUG: unable to handle kernel ");
        if (address < PAGE_SIZE)
-               printk(KERN_CONT "NULL pointer dereference");
+               printk(KERN_ALERT "BUG: unable to handle kernel NULL pointer dereference");
        else
-               printk(KERN_CONT "paging request");
+               printk(KERN_ALERT "BUG: unable to handle kernel paging request");

        printk(KERN_CONT " at %px\n", (void *) address);

>It actually makes the code even shorter, which is nice:
>
>--- a/arch/x86/mm/fault.c
>+++ b/arch/x86/mm/fault.c
>@@ -671,13 +671,9 @@ show_fault_oops(struct pt_regs *regs, unsigned
>long error_code,
>                        printk(smep_warning, from_kuid(&init_user_ns,
>current_uid()));
>        }
>
>-       printk(KERN_ALERT "BUG: unable to handle kernel ");
>-       if (address < PAGE_SIZE)
>-               printk(KERN_CONT "NULL pointer dereference");
>-       else
>-               printk(KERN_CONT "paging request");
>-
>-       printk(KERN_CONT " at %px\n", (void *) address);
>+       printk(KERN_ALERT "BUG: unable to handle kernel %s at %px\n",
>+               (address < PAGE_SIZE ? "NULL pointer dereference" :
>+               "paging request"), (void *) address);
>
>        dump_pagetable(address);
> }
>
