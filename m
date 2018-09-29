Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B7DC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B817206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B817206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeI2SHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 14:07:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:37776 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeI2SHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 14:07:43 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8TBdXAO025048;
        Sat, 29 Sep 2018 20:39:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Sat, 29 Sep 2018 20:39:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8TBdXOB025041
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 29 Sep 2018 20:39:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <20180928085648.GC1160@jagdpanzerIV>
 <802130a3-b8c1-3973-933b-d6dc5ff2930d@i-love.sakura.ne.jp>
 <20180929111317.GB1392@tigerII.localdomain>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <469bcffe-9e5b-d69f-da63-2a491c0e370b@i-love.sakura.ne.jp>
Date:   Sat, 29 Sep 2018 20:39:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180929111317.GB1392@tigerII.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/29 20:13, Sergey Senozhatsky wrote:
> On (09/28/18 20:21), Tetsuo Handa wrote:
>> On 2018/09/28 17:56, Sergey Senozhatsky wrote:
>>> The good thing about cont buffer is that we flush it on panic. E.g.
>>> core/arch early boot stage can do:
>>>
>>> 	pr_cont("going to call early_init_foo()...");
>>> 	early_init_foo();
>>> 	pr_cont("OK\n");
>>>
>>
>> Is printing
>>
>>   going to call early_init_foo()...OK
>>
>> in one line so critically important?
> 
> Could be. If this is the last thing you are about to see on your
> serial console. panic_on_flush() is not guaranteed to succeed.

Doing

  printk("going to call early_init_foo()...\n");
  early_init_foo();
  printk("OK\n");

and getting

  T0: going to call early_init_foo()...

as the last line we see on our serial console will not be so bad.

Implicitly flushing incomplete lines might disturb automated processing.
But there is after all other factors which can disturb automated
processing (e.g. "** %u printk messages dropped **\n" in printk(),
UDP packet being lost when transmitting via netconsole). After all,
we cannot allow perfect automated processing. The last help is
human's eyes and brain.

Then, prefixing caller information helps even if incomplete line
is implicitly flushed by line buffered printk() API...
