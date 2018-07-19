Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234B7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E7420673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E7420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbeGSOhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:37:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:17455 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbeGSOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:37:47 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6JDsS8M016327;
        Thu, 19 Jul 2018 22:54:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Thu, 19 Jul 2018 22:54:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6JDsN85016284
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 19 Jul 2018 22:54:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v5] x86: Avoid pr_cont() in show_opcodes().
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, joe@perches.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1531907643-3367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180718115753.GA25388@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ed59bf3b-705f-8433-f498-0acc2f09ef97@i-love.sakura.ne.jp>
Date:   Thu, 19 Jul 2018 22:54:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718115753.GA25388@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/18 20:57, Ingo Molnar wrote:
> 
> * Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
>> Since syzbot is confused by concurrent printk() messages [1],
>> this patch changes show_opcodes() to use %ph format string.
>>
>> When we start adding prefix to each line of printk() output,
>> we will be able to handle concurrent printk() messages.
>>
>> [1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Wasn't that variant of the patch written by Rasmus?

Rasmus Villemoes taught me that we can use "%*ph" format string and pass
length as arguments for "*" part. Then, since Joe Perches suggested me to
use #define for length variable, I updated to use "#define length immediate"
and replaced "%*ph" with "%" __strigify(length) "ph" and removed length from
arguments. That is v5 patch.

> 
> If so then the changelog should start with:
> 
>  From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

OK. I posted v6 patch with From: line updated.

> 
> Thanks,
> 
> 	Ingo
> 

