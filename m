Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0717C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAF020868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAF020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeKXLLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:11:25 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:27963 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbeKXLLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:11:25 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAO0P2gt089962;
        Sat, 24 Nov 2018 09:25:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Sat, 24 Nov 2018 09:25:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAO0OuNR089845
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 24 Nov 2018 09:25:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
 <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
 <20181109061204.GC599@jagdpanzerIV>
 <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
 <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
 <deb8d78b-0593-2b8e-1c7a-9203aa77005f@i-love.sakura.ne.jp>
 <20181123124647.jmewvgrqdpra7wbm@pathway.suse.cz>
 <20181123105634.4956c255@vmware.local.home>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <6422717f-db27-8ba8-1183-ccb9f0400fc3@i-love.sakura.ne.jp>
Date:   Sat, 24 Nov 2018 09:24:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181123105634.4956c255@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/24 0:56, Steven Rostedt wrote:
> On Fri, 23 Nov 2018 13:46:47 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
>> Steven told me on Plumbers conference that even few initial
>> characters saved him a day few times.
> 
> Yes, and that has happened more than once. I would reboot and retest
> code that is crashing, and due to a triple fault, the machine would
> reboot because of some race, and the little output I get from the
> console would help tremendously.
> 
> Remember, debugging the kernel is a lot like forensics, especially when
> it's from a customer's site. You look at all the evidence that you can
> get, and sometimes it's just 10 characters in the output that gives you
> an idea of where things went wrong. I'm really not liking the buffering
> idea because of this.

Then, we should not enforce buffering in a way that requires modification of
printk() callers. That is, we should not ask printk() callers to use their
private buffer. What we can do is to enable/disable line buffering inside
printk() depending on the problem the user wants to debug.

Also, we should allow disabling "struct cont" depending on the problem (in
order to allow flushing the 10 characters in the "cont" buffer).



By the way, is the comment

  /*
   * Continuation lines are buffered, and not committed to the record buffer
   * until the line is complete, or a race forces it. The line fragments
   * though, are printed immediately to the consoles to ensure everything has
   * reached the console in case of a kernel crash.
   */

appropriate despite we don't call cont_flush() upon a kernel crash?

