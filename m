Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id O/C1D0B7G1tgFAAAmS7hNA
	; Sat, 09 Jun 2018 07:01:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 295AC607E7; Sat,  9 Jun 2018 07:01:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A40E860290;
	Sat,  9 Jun 2018 07:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A40E860290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeFIHBR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 03:01:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:37696 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752599AbeFIHBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 03:01:16 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5971306004881;
        Sat, 9 Jun 2018 16:01:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Sat, 09 Jun 2018 16:01:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5970wsn004835
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 9 Jun 2018 16:01:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: allow to set period separately from
 timeout
To: Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <20180608133043.203744-1-dvyukov@google.com>
 <20180608145821.ec20a15944d1d19b683695e7@linux-foundation.org>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4d9f8cd8-1b2c-28ef-1705-2400e5af9b51@i-love.sakura.ne.jp>
Date: Sat, 9 Jun 2018 16:00:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608145821.ec20a15944d1d19b683695e7@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/09 6:58, Andrew Morton wrote:
> On Fri,  8 Jun 2018 15:30:43 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:
> 
>> Currently task hung checking period is equal to timeout,
>> as the result hung is detected anywhere between timeout and 2*timeout.
>> This is fine for most interactive environments, but this hurts automated
>> testing setups (syzbot). In an automated setup we need to strictly order
>> CPU lockup < RCU stall < workqueue lockup < task hung < silent loss,
>> so that RCU stall is not detected as task hung and task hung is not
>> detected as silent machine loss. The large variance in task hung
>> detection timeout requires setting silent machine loss timeout to
>> a very large value (e.g. if task hung is 3 mins, then silent loss
>> need to be set to ~7 mins). The additional 3 minutes significantly
>> reduce testing efficiency because usually we crash kernel within
>> a minute, and this can add hours to bug localization process as it
>> needs to do dozens of tests.
>>
>> Allow setting checking period separately from timeout.
>> This allows to set timeout to, say, 3 minutes, but period to 10 secs.
>>
>> The period is controlled via a new hung_task_period_secs sysctl,
>> similar to the existing hung_task_timeout_secs sysctl.
>> The default value of 0 results in the current behavior.
> 
> I'm rather struggling to understand the difference between "period" and
> "timeout".  We would benefit from a clear description of what these two
> things do.  An appropriate place for this description is
> Documentation/sysctl/kernel.txt, which this patch forgot to update.

My understanding is that "period" is "how frequently we should check"
and "timeout" is "how long a thread remained uninterruptible". Maybe
hung_task_check_interval_secs would be better than hung_task_period_secs.

timeout = 60 and period = 1 would allow hung task to be reported as soon
as it remained uninterruptible for 60 seconds. That makes me easier to
narrow down relevant kernel messages and syzbot program.

Well, showing exact slept time, along with all threads which slept more
than some threshold (e.g. timeout / 2), might be helpful.
