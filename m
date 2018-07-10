Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F543C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B888B208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B888B208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbeGJVlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:41:36 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:24170 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbeGJVlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:41:36 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6AL8Kim082080;
        Wed, 11 Jul 2018 06:08:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 11 Jul 2018 06:08:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6AL8EmB082058
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 11 Jul 2018 06:08:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] x86: Avoid pr_cont() in show_opcodes()
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Josh Poimboeuf'" <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180707111209.GA27768@gmail.com>
 <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
 <20180709084953.GB2476@hirez.programming.kicks-ass.net>
 <20180709191034.pyadc3cy7ulwaf2o@treble>
 <cbb4e190f9de45cf8586c1df02ec3619@AcuMS.aculab.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <19297e6e-c9f7-cd19-d6ac-39ed45d5d269@i-love.sakura.ne.jp>
Date:   Wed, 11 Jul 2018 06:08:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <cbb4e190f9de45cf8586c1df02ec3619@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/11 1:51, David Laight wrote:
> From: Josh Poimboeuf
>> Sent: 09 July 2018 20:12
>> On Mon, Jul 09, 2018 at 10:49:53AM +0200, Peter Zijlstra wrote:
>>> On Sat, Jul 07, 2018 at 10:54:28PM +0900, Tetsuo Handa wrote:
>>>>>> Since syzbot is confused by concurrent printk() messages [1],
>>>>>> this patch changes show_opcodes() to use snprintf().
>>>
>>> But how big of a problem is that really? We can't very well remove all
>>> pr_cont stuff from the kernel.
>>
>> I'd say we should try to make oopses as legible as possible.
> 
> To make oopses legible you need to lock the output between output lines.
> Which would require a 'KERN_CONTINUED' marker on the previous print.

There is an attempt to prefix context identifier to each line of output
( https://groups.google.com/d/msg/syzkaller/ttZehjXiHTU/JR67pXz3BAAJ ).
Therefore, I expect oops messages can stop using pr_cont()/KERN_CONT.
