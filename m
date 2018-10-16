Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3032C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881922086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881922086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJPSzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:55:51 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:11186 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:55:51 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9GB5rJ0005528;
        Tue, 16 Oct 2018 20:05:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Tue, 16 Oct 2018 20:05:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9GB5mZ6005512
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 16 Oct 2018 20:05:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms
 without eligible tasks
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <6c0a57b3-bfd4-d832-b0bd-5dd3bcae460e@i-love.sakura.ne.jp>
 <20181015133524.GM18839@dhcp22.suse.cz>
 <201810160055.w9G0t62E045154@www262.sakura.ne.jp>
 <20181016092043.GP18839@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <59b9bd23-ff75-0488-fd96-68ee7f049d00@i-love.sakura.ne.jp>
Date:   Tue, 16 Oct 2018 20:05:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016092043.GP18839@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/16 18:20, Michal Hocko wrote:
>> Anyway, I'm OK if we apply _BOTH_ your patch and my patch. Or I'm OK with simplified
>> one shown below (because you don't like per memcg limit).
> 
> My patch is adding a rate-limit! I really fail to see why we need yet
> another one on top of it. This is just ridiculous. I can see reasons to
> tune that rate limit but adding 2 different mechanisms is just wrong.
> 
> If your NAK to unify the ratelimit for dump_header for all paths
> still holds then I do not care too much to push it forward. But I find
> thiis way of the review feedback counter productive.
> 

Your patch is _NOT_ adding a rate-limit for

  "%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n"
  "Out of memory and no killable processes...\n"

lines!

[   97.519229] Out of memory and no killable processes...
[   97.522060] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.525507] Out of memory and no killable processes...
[   97.528817] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.532345] Out of memory and no killable processes...
[   97.534813] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.538270] Out of memory and no killable processes...
[   97.541449] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.546268] Out of memory and no killable processes...
[   97.548823] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.552399] Out of memory and no killable processes...
[   97.554939] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.558616] Out of memory and no killable processes...
[   97.562257] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.565998] Out of memory and no killable processes...
[   97.568642] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.572169] Out of memory and no killable processes...
[   97.575200] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.579357] Out of memory and no killable processes...
[   97.581912] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.585414] Out of memory and no killable processes...
[   97.589191] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.593586] Out of memory and no killable processes...
[   97.596527] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.600118] Out of memory and no killable processes...
[   97.603237] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.606837] Out of memory and no killable processes...
[   97.611550] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.615244] Out of memory and no killable processes...
[   97.617859] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.621634] Out of memory and no killable processes...
[   97.624884] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.629256] Out of memory and no killable processes...
[   97.631885] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.635367] Out of memory and no killable processes...
[   97.638033] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.641827] Out of memory and no killable processes...
[   97.641993] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.648453] Out of memory and no killable processes...
[   97.651481] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.655082] Out of memory and no killable processes...
[   97.657941] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.663036] Out of memory and no killable processes...
[   97.665890] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
[   97.669473] Out of memory and no killable processes...

We don't need to print these lines every few milliseconds. Even if an exceptional case,
this is a DoS for console users. Printing once (or a few times) per a minute will be
enough. Otherwise, users cannot see what they are typing and what are printed.
