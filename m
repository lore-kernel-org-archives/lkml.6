Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E717C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C4A2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C4A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeJRT7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:59:39 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:24762 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeJRT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:59:38 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9IBwsOD098519;
        Thu, 18 Oct 2018 20:58:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Thu, 18 Oct 2018 20:58:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9IBwrgb098515
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 18 Oct 2018 20:58:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
References: <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
 <20181018042739.GA650@jagdpanzerIV>
 <201810180526.w9I5QvVn032670@www262.sakura.ne.jp>
 <20181018061018.GB650@jagdpanzerIV> <20181018075611.GY18839@dhcp22.suse.cz>
 <20181018081352.GA438@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2c2b2820-e6f8-76c8-c431-18f60845b3ab@i-love.sakura.ne.jp>
Date:   Thu, 18 Oct 2018 20:58:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018081352.GA438@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/18 17:13, Sergey Senozhatsky wrote:
> On (10/18/18 09:56), Michal Hocko wrote:
>> On Thu 18-10-18 15:10:18, Sergey Senozhatsky wrote:
>> [...]
>>> and let's hear from MM people what they can suggest.
>>>
>>> Michal, Andrew, Johannes, any thoughts?
>>
>> I have already stated my position. Let's not reinvent the wheel and use
>> the standard printk throttling. If there are cases where oom reports
>> cause more harm than good I am open to add a knob to allow disabling it
>> altogether (it can be even fine grained one to control whether to dump
>> show_mem, task_list etc.).

Moderate OOM reports with making progress is good.
But OOM reports without making progress is bad.

> 
> A knob might do.
> As well as /proc/sys/kernel/printk tweaks, probably. One can even add
> echo "a b c d" > /proc/sys/kernel/printk to .bashrc and adjust printk
> console levels on login and rollback to old values in .bash_logout
> May be.

That can work for only single login with root user case.
Not everyone logs into console as root user.

It is pity that we can't send kernel messages to only selected consoles
(e.g. all messages are sent to netconsole, but only critical messages are
sent to local consoles).

> 
>> But please let's stop this dubious one-off approaches.
> 
> OK. Well, I'm not proposing anything actually. I didn't even
> realize until recently that Tetsuo was talking about "user
> interaction" problem; I thought that his problem was stalled
> RCU.

The "stalled RCU" was the trigger for considering this problem.
Nobody has seriously considered what we should do when the memcg OOM killer
cannot make progress. If the OOM killer cannot make progress, we need to
handle situations where the OOM-unkillable process cannot solve the memcg OOM
situation. Then, the poorest recovery method is that the root user enters
commands for recovery (It might be to increase the memory limit. It might be
to move to a different cgroup. It might be to gracefully terminate the
OOM-unkillable process.) from "consoles" where the OOM messages are sent.

If we start from the worst case, it is obvious that we need to make sure that
the OOM messages do not disturb "consoles" so that the root user can enter
commands for recovery. That boils down to a "user interaction" problem.
Not limiting

  "%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n"
  "Out of memory and no killable processes...\n"

is very annoying.

And I really can't understand why Michal thinks "handling this requirement" as
"make the code more complex than necessary and squash different things together".
Satisfying the most difficult error path handling is not a simple thing.

