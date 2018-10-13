Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3966EC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A05720895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A05720895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeJMTFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 15:05:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:32040 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeJMTFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 15:05:31 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9DBSg3f011643;
        Sat, 13 Oct 2018 20:28:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Sat, 13 Oct 2018 20:28:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9DBSfCf011630
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 13 Oct 2018 20:28:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms
 without eligible tasks
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <000000000000dc48d40577d4a587@google.com>
 <20181010151135.25766-1-mhocko@kernel.org>
 <20181012112008.GA27955@cmpxchg.org> <20181012120858.GX5873@dhcp22.suse.cz>
 <9174f087-3f6f-f0ed-6009-509d4436a47a@i-love.sakura.ne.jp>
 <20181012124137.GA29330@cmpxchg.org>
 <0417c888-d74e-b6ae-a8f0-234cbde03d38@i-love.sakura.ne.jp>
 <bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp>
 <20181013112238.GA762@cmpxchg.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b61b2e60-d899-90c6-579a-587815cebff6@i-love.sakura.ne.jp>
Date:   Sat, 13 Oct 2018 20:28:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181013112238.GA762@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/13 20:22, Johannes Weiner wrote:
> On Sat, Oct 13, 2018 at 08:09:30PM +0900, Tetsuo Handa wrote:
>> ---------- Michal's patch ----------
>>
>> 73133 lines (5.79MB) of kernel messages per one run
>>
>> [root@ccsecurity ~]# time ./a.out
>>
>> real    3m44.389s
>> user    0m0.000s
>> sys     3m42.334s
>>
>> [root@ccsecurity ~]# time ./a.out
>>
>> real    3m41.767s
>> user    0m0.004s
>> sys     3m39.779s
>>
>> ---------- My v2 patch ----------
>>
>> 50 lines (3.40 KB) of kernel messages per one run
>>
>> [root@ccsecurity ~]# time ./a.out
>>
>> real    0m5.227s
>> user    0m0.000s
>> sys     0m4.950s
>>
>> [root@ccsecurity ~]# time ./a.out
>>
>> real    0m5.249s
>> user    0m0.000s
>> sys     0m4.956s
> 
> Your patch is suppressing information that I want to have and my
> console can handle, just because your console is slow, even though
> there is no need to use that console at that log level.

My patch is not suppressing information you want to have.
My patch is mainly suppressing

[   52.393146] Out of memory and no killable processes...
[   52.395195] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   52.398623] Out of memory and no killable processes...
[   52.401195] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   52.404356] Out of memory and no killable processes...
[   52.406492] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   52.409595] Out of memory and no killable processes...
[   52.411745] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   52.415588] Out of memory and no killable processes...
[   52.418484] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   52.421904] Out of memory and no killable processes...
[   52.424273] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000

lines which Michal's patch cannot suppress.

Also, my console is console=ttyS0,115200n8 . Not slow at all.

> 
> NAK to your patch. I think you're looking at this from the wrong
> angle. A console that takes almost 4 minutes to print 70k lines
> shouldn't be the baseline for how verbose KERN_INFO is.
> 

Run the testcase in your environment.
