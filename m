Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F86C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A142087C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A142087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeGJLzk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:55:40 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:45001 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeGJLzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:55:39 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6ABtbC4061923;
        Tue, 10 Jul 2018 20:55:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Tue, 10 Jul 2018 20:55:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6ABtbo6061919
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 10 Jul 2018 20:55:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] x86: Avoid pr_cont() in show_opcodes()
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180707111209.GA27768@gmail.com>
 <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
 <20180709084953.GB2476@hirez.programming.kicks-ass.net>
 <20180709191034.pyadc3cy7ulwaf2o@treble>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ac094aa6-3b8d-6a96-b635-0634052bf3cf@i-love.sakura.ne.jp>
Date:   Tue, 10 Jul 2018 20:55:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180709191034.pyadc3cy7ulwaf2o@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/10 4:11, Josh Poimboeuf wrote:
> On Mon, Jul 09, 2018 at 10:49:53AM +0200, Peter Zijlstra wrote:
>> On Sat, Jul 07, 2018 at 10:54:28PM +0900, Tetsuo Handa wrote:
>>>>> Since syzbot is confused by concurrent printk() messages [1],
>>>>> this patch changes show_opcodes() to use snprintf().
>>
>> But how big of a problem is that really? We can't very well remove all
>> pr_cont stuff from the kernel.
> 
> I'd say we should try to make oopses as legible as possible.
> 
> Also KERN_CONT is inherently broken, and we should avoid using it in
> general, IMO.
> 

We can't afford removing all pr_cont()/KERN_CONT.
But show_opcodes() is an example of function which is expected to be SMP-safe.

  /*
   * Annotation for a "continued" line of log printout (only done after a
   * line that had no enclosing \n). Only to be used by core/arch code
   * during early bootup (a continued line is not SMP-safe otherwise).
   */
  #define KERN_CONT       KERN_SOH "c"
