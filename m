Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A49C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A0520878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A0520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeLDKRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:17:00 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:46957 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:17:00 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wB4AGwA4050933;
        Tue, 4 Dec 2018 19:16:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Tue, 04 Dec 2018 19:16:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wB4AGw6M050903
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 4 Dec 2018 19:16:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add caller information to printk() output.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <1bd509ec-0a3a-55cc-d43b-02baa489019a@i-love.sakura.ne.jp>
 <20181204020224.GA7580@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <be668360-279b-5c24-4fc1-10ef050bd87f@i-love.sakura.ne.jp>
Date:   Tue, 4 Dec 2018 19:16:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204020224.GA7580@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/04 11:02, Sergey Senozhatsky wrote:
> On (12/02/18 20:23), Tetsuo Handa wrote:
>>
>> Some examples for console output:
>>
>>   [    0.919699]@T1 x86: Booting SMP configuration:
>>   [    4.152681]@T271 Fusion MPT base driver 3.04.20
>>   [    5.070470]@C0 random: fast init done
>>   [    6.587900]@C3 random: crng init done
> 
> This is hard to read. Let's have a fixed width space for from_id.

Console might be only 80 columns. When we have to check from screen capture of
crash, triggering needless newlines due to occupying columns more than needed
will not be nice. Also, syzbot has file size limit for saving console output.
Wasting with needless spaces increases possibility of loosing past lines.
Given that said, do you still want to waste precious columns with spaces?

> 
>> +config PRINTK_FROM
>> +	bool "Show caller information on printks"
>> +	depends on PRINTK
> 
> Wasn't it supposed to also depend on DEBUG_AID_FOR_SYZBOT?

CONFIG_DEBUG_AID_FOR_SYZBOT is currently linux-next only option.
This feature will be useful for non-syzbot environments.

