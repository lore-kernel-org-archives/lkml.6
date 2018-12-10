Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DE6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47C62081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47C62081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeLJJ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:59:01 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:12481 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLJJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:59:01 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBA9wxbp081300;
        Mon, 10 Dec 2018 18:58:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Mon, 10 Dec 2018 18:58:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBA9wsOa081148
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 10 Dec 2018 18:58:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
 <20181210054622.GA6291@jagdpanzerIV>
 <27240C0AC20F114CBF8149A2696CBE4A6015A8D9@SHSMSX101.ccr.corp.intel.com>
 <20181210061151.GA28533@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f6e39c8f-2ca2-4a01-cf42-9ed3bc2462a8@i-love.sakura.ne.jp>
Date:   Mon, 10 Dec 2018 18:58:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210061151.GA28533@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/10 15:11, Sergey Senozhatsky wrote:
> On (12/10/18 05:58), Liu, Chuansheng wrote:
>>> On (12/10/18 05:40), Liu, Chuansheng wrote:
>>>> @@ -130,6 +130,13 @@ static void check_hung_task(struct task_struct *t,
>>> unsigned long timeout)
>>>>                         init_utsname()->version);
>>>>                 pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
>>>>                         " disables this message.\n");
>>>> +               /* When sysctl_hung_task_panic is set, we have to force
>>>> +                * ignore_loglevel to get really useful hung task
>>>> +                * information.
>>>> +                */
>>>> +               if (sysctl_hung_task_panic && !ignore_loglevel)
>>>> +                       ignore_loglevel = true;
>>>
>>> 		console_verbose()?
>>
>> Thanks Sergey, it is really my need. I will prepare for a new version of patch:)
> 
> Let's wait for people to take a look at this patch first.

Shouldn't console_verbose() be called like

-    if (!sysctl_hung_task_warnings && !sysctl_hung_task_panic)
+    if (sysctl_hung_task_panic)
+        console_verbose();
+    else if (!sysctl_hung_task_warnings)
         return;

or

-    if (!sysctl_hung_task_warnings && !sysctl_hung_task_panic)
-        return;
+    if (sysctl_hung_task_panic)
+        console_verbose();

or

-    if (!sysctl_hung_task_warnings && !sysctl_hung_task_panic)
-        return;
+    if (sysctl_hung_task_panic) {
+        console_verbose();
+        hung_task_show_lock = true;
+        hung_task_call_panic = true;
+    }
(...snipped...)
-    if (sysctl_hung_task_panic) {
-        hung_task_show_lock = true;
-        hung_task_call_panic = true;
-    }

so that sysctl_hung_task_warnings == 0 && sysctl_hung_task_panic == 1
will call debug_show_all_locks() and trigger_all_cpu_backtrace() with
verbose level?
