Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E5D20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E5D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbeFTLhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:37:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:41107 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751841AbeFTLhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:37:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 04:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,247,1526367600"; 
   d="scan'208";a="60772215"
Received: from dengy1x-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.213.248])
  by orsmga003.jf.intel.com with ESMTP; 20 Jun 2018 04:37:31 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fVbQZ-0000jw-4Q; Wed, 20 Jun 2018 19:37:31 +0800
Date:   Wed, 20 Jun 2018 19:37:31 +0800
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
Message-ID: <20180620113731.y7apmqoh6ke6ar2v@wfg-t540p.sh.intel.com>
References: <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV>
 <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV>
 <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
 <CACT4Y+a6nUqdpSyYGGcXKAgVbcw+uQOz2kYx8tUS+8T5-bzqkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACT4Y+a6nUqdpSyYGGcXKAgVbcw+uQOz2kYx8tUS+8T5-bzqkg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:30:05AM +0200, Dmitry Vyukov wrote:
>On Wed, Jun 20, 2018 at 11:06 AM, Sergey Senozhatsky
><sergey.senozhatsky.work@gmail.com> wrote:
>> Hi Dmitry,
>>
>> On (06/20/18 10:45), Dmitry Vyukov wrote:
>>> Hi Sergey,
>>>
>>> What are the visible differences between this patch and Tetsuo's
>>> patch?
>>
>> I guess none, and looking at your requirements below I tend to agree
>> that Tetsuo's approach is probably what you need at the end of the day.
>>
>>> The only thing that will matter for syzkaller parsing in the
>>> end is the resulting text format as it appears on console. But you say
>>> "I'm not pushing for this particular message format", so what exactly
>>> do you want me to provide feedback on?
>>> I guess we need to handle pr_cont properly whatever approach we take.
>>
>> Mostly, was wondering about if:
>> a) you need pr_cont() handling
>> b) you need printk_safe() handling
>>
>> The reasons I left those things behind:
>>
>> a) pr_cont() is officially hated. It was never supposed to be used
>>    on SMP systems. So I wasn't sure if we need all that effort and
>>    add tricky code to handle pr_cont(). Given that syzkaller is
>>    probably the only user of that functionality.
>
>Well, if I put my syzkaller hat on, then I don't care what exactly
>happens in the kernel, the only thing I care is well-formed output on
>console that can be parsed unambiguously in all cases.

+1 for 0day kernel testing.

I admit that goal may never be 100% achievable -- at least some serial
console logs can sometimes become messy. So we'll have to write dmesg
parsing code in defensive ways.

But some unnecessary pr_cont() broken-up messages can obviously be
avoided. For example,

arch/x86/mm/fault.c:

	printk(KERN_ALERT "BUG: unable to handle kernel ");
	if (address < PAGE_SIZE)
		printk(KERN_CONT "NULL pointer dereference");
	else
		printk(KERN_CONT "paging request");

I've actually proposed to remove the above KERN_CONT, unfortunately the
patch was silently ignored.

>From this point of view I guess pr_cont is actually syzkaller's worst
>enemy. If pr_const is officially hated, and it causes corrupted crash
>reports, then we can resolve it by just getting rid of more pr_cont's.
>So potentially we do not need any support for pr_cont in this patch.
>However, we also need to be practical and if there are tons of
>pr_cont's then we need some intermediate support of them, just because
>we won't be able to get rid of all of them overnight.
>
>But even if we attach context to pr_cont, it still causes problems for
>crash parsing, because today we see:
>
>BUG: unable to handle
>... 10 lines ...
>kernel
>... 10 lines ...
>paging request
>... 10 lines ...
>at ADDR
>
>Which is not too friendly for parsing regardless of contexts.

We met exactly the same issue and ended up with special handling in
https://github.com/intel/lkp-tests/blob/master/lib/dmesg.rb:

       /(BUG: unable to handle kernel)/,
       /(BUG: unable to handle kernel) NULL pointer dereference/,
       /(BUG: unable to handle kernel) paging request/,

>So I am leaning towards to getting rid of pr_cont's as the solution to
>the problem.

+1 for reducing unnecessary pr_cont() uses.

Thanks,
Fengguang
