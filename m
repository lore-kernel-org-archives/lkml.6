Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C449CC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A63120658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A63120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeJVSZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:25:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65416 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJVSZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:25:07 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9MA6tdH009222;
        Mon, 22 Oct 2018 19:06:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Mon, 22 Oct 2018 19:06:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9MA6sYL009218
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 22 Oct 2018 19:06:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: KASAN: use-after-free Read in task_is_descendant
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000004904df0578b7d3da@google.com>
 <bf1a083c-0d09-07fb-6ad2-4bf30ac49cd8@I-love.SAKURA.ne.jp>
 <20181022095439.GA4613@redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
Date:   Mon, 22 Oct 2018 19:06:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022095439.GA4613@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/22 18:54, Oleg Nesterov wrote:
> On 10/21, Tetsuo Handa wrote:
>>
>> On 2018/10/21 16:10, syzbot wrote:
>>> BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:188 [inline]
>>> BUG: KASAN: use-after-free in task_is_descendant.part.2+0x610/0x670 security/yama/yama_lsm.c:295
>>> Read of size 8 at addr ffff8801c4666b20 by task syz-executor3/12722
>>>
>>> CPU: 1 PID: 12722 Comm: syz-executor3 Not tainted 4.19.0-rc8+ #70
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>> Call Trace:
>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>>>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>>>  __read_once_size include/linux/compiler.h:188 [inline]
>>>  task_is_descendant.part.2+0x610/0x670 security/yama/yama_lsm.c:295
>>
>> Do we need to hold
>>
>>   write_lock_irq(&tasklist_lock);
>>
>> rather than
>>
>>   rcu_read_lock();
>>
>> when accessing
>>
>>   "struct task_struct"->real_parent
> 
> Well, if "task" is stable (can't exit), then I think
> 
> 	rcu_dereference(task->real_parent)
> 
> is fine, we know that ->real_parent did not pass exit_notif() yet.

OK.

> 
> However, task_is_descendant() looks unnecessarily complicated, it could be
> 
> 	static int task_is_descendant(struct task_struct *parent,
> 				      struct task_struct *child)
> 	{
> 		int rc = 0;
> 		struct task_struct *walker;
> 
> 		if (!parent || !child)
> 			return 0;
> 
> 		rcu_read_lock();
> 		for (walker = child; walker->pid; walker = rcu_dereference(walker->real_parent))
> 			if (same_thread_group(parent, walker)) {
> 				rc = 1;
> 				break;
> 			}
> 		rcu_read_unlock();
> 
> 		return rc;
> 	}
> 
> And again, I do not know how/if yama ensures that child is rcu-protected, perhaps
> task_is_descendant() needs to check pid_alive(child) right after rcu_read_lock() ?

Since the caller (ptrace() path) called get_task_struct(child), child itself can't be
released. Do we still need pid_alive(child) ?
