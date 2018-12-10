Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FFCC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D74220870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D74220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeLJOBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:01:49 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:19838 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeLJOBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:01:48 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBAE1kNg089294;
        Mon, 10 Dec 2018 23:01:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Mon, 10 Dec 2018 23:01:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBAE1fXx089253
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 10 Dec 2018 23:01:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add caller information to printk() output.
To:     Petr Mladek <pmladek@suse.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
 <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
Date:   Mon, 10 Dec 2018 23:01:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/10 22:09, Petr Mladek wrote:
>> +#ifdef CONFIG_PRINTK_FROM
>> +#define PREFIX_FROM_MAX		16
>> +#define PREFIX_MAX		(32 + PREFIX_FROM_MAX)
>> +#define LOG_LINE_MAX		(1024 - 32)
> 
> This looks suspicious. We either need to limit LOG_LINE_MAX
> by the real PREFIX_MAX (48). Or we must make sure that
> the code is able to handle an eventual overflow.

Reducing LOG_LINE_MAX makes devkmsg_write() to return -EINVAL.
Is such user visible change acceptable?

> BTW: The limit 48 looks right. If I count correctly, the longest
> prefix might be:
> 
>     <2048>[4294967296,xxxxxx][T4294967296]
> 
> 38 = 6+19+13

Theoretical max (based on variable's bit width) is
6 + 20 + 13 + 1 (for space) + 1 (for '\0') = 41.

We allocate 32 for "<2047>[18446744073.709551] ". Thus,
I chose 48 for "<2047>[18446744073.709551][T4294967295] ".

