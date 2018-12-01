Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7EC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315EA2081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315EA2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeLBB51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:57:27 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:37752 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeLBB51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 20:57:27 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wB1EikZX069031;
        Sat, 1 Dec 2018 23:44:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Sat, 01 Dec 2018 23:44:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wB1Eic7J068967
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 1 Dec 2018 23:44:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add caller information to printk() output.
To:     Petr Mladek <pmladek@suse.com>, Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
Date:   Sat, 1 Dec 2018 23:44:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/01 0:40, Petr Mladek wrote:
>> Some examples for console output:
>>
>>   [    0.293000] [T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
>>   [    0.299733] [T1] Performance Events: Haswell events, core PMU driver.
>>   [    2.813808] [T35] clocksource: Switched to clocksource tsc
>>   [    2.893984] [C0] random: fast init done
>                   ^
> 
> Please, remove the space between the timestamp and the from field.

This space was emitted by print_time(). Do we want to modify print_time()
not to emit this space if the from field is printed?

If we modify print_time(), I think that the leading spaces inserted by "%5lu"
makes little sense, for "%5lu" is too small for systems with uptime >= 1.16 days
and parsers after all cannot assume fixed length for the timestamp field. Then,
we could change from "%5lu.%06lu" to "%lu.%06lu" so that parsers (like /bin/awk)
can get prefix part using white spaces as a delimiter.

If we want to reduce space, do we want to do like

  [0.293000@T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
  [0.299733@T1] Performance Events: Haswell events, core PMU driver.
  [2.813808@T35] clocksource: Switched to clocksource tsc
  [2.893984@C0] random: fast init done

(if printk_time = true) or

  [@T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
  [@T1] Performance Events: Haswell events, core PMU driver.
  [@T35] clocksource: Switched to clocksource tsc
  [@C0] random: fast init done

(if printk_time = false) ?

Dmitry, what format/delimiter is convenient for parsing by syzbot?

>> @@ -1037,6 +1054,9 @@ void log_buf_vmcoreinfo_setup(void)
>>  	VMCOREINFO_OFFSET(printk_log, len);
>>  	VMCOREINFO_OFFSET(printk_log, text_len);
>>  	VMCOREINFO_OFFSET(printk_log, dict_len);
>> +#ifdef CONFIG_PRINTK_FROM
>> +	VMCOREINFO_OFFSET(printk_log, from_id);
>> +#endif
> 
> The crash tool would need to be updated if anyone wanted to read
> the log from the extended structure. Well, it might be done later
> if people start using it more widely.

Since syzbot can utilize output from only normal consoles, I can
keep extended records unmodified for now.

> 
> I think about adding one more filed "u8 version". It would help
> to solve the external compatibility in the long term.

/dev/kmsg format allows adding more fields, but that format did not define
how to tell what fields are there. If fields are conditionally added by
kernel config options, I don't think that "u8 version" field helps.
Unless we add fields unconditionally, we will need to use $name=$value
(where $name and $value must not contain ',' and ';') representation.

> Anyway, I like this feature. It is compatible with /dev/kmsg
> format. dmesg works well. It helps to sort any mixed output
> from both full and continuous lines.

OK, let's refine this approach.

