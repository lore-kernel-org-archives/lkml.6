Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZWDkJ8pvHluZZwAAmS7hNA
	; Mon, 11 Jun 2018 12:49:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9337160792; Mon, 11 Jun 2018 12:49:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A73EB60351;
	Mon, 11 Jun 2018 12:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A73EB60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932937AbeFKMtM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:49:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15480 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKMtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:49:11 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5BCmxtY003371;
        Mon, 11 Jun 2018 21:49:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Mon, 11 Jun 2018 21:48:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5BCmtIj003344
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 11 Jun 2018 21:48:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: allow to set period separately from
 timeout
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <20180608133043.203744-1-dvyukov@google.com>
 <20180608145821.ec20a15944d1d19b683695e7@linux-foundation.org>
 <4d9f8cd8-1b2c-28ef-1705-2400e5af9b51@i-love.sakura.ne.jp>
 <CACT4Y+adbYJdmgzuLVV+iy+Q+tii_cnKm=VwCfdkr8uKWbww+Q@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8171ca9e-54c4-46bd-803b-cf0b9aa03303@i-love.sakura.ne.jp>
Date: Mon, 11 Jun 2018 21:48:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+adbYJdmgzuLVV+iy+Q+tii_cnKm=VwCfdkr8uKWbww+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/11 20:16, Dmitry Vyukov wrote:
>> timeout = 60 and period = 1 would allow hung task to be reported as soon
>> as it remained uninterruptible for 60 seconds. That makes me easier to
>> narrow down relevant kernel messages and syzbot program.
>>
>> Well, showing exact slept time, along with all threads which slept more
>> than some threshold (e.g. timeout / 2), might be helpful.
> 
> You mean if we report any task, then scan all tasks second time and
> additionally report tasks that are blocked for (timeout/2 : timeout)?

Yes. Something like check_memalloc_stalling_tasks() in
http://lkml.kernel.org/r/1495331504-12480-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp .

> 
> Should we do this when hung_task_show_lock? Or only when
> sysctl_hung_task_panic? Or when?
> 

I think always is more useful. That is, first round only checks whether
there is at least one stalling task, and second round reports stalling tasks
if at least one task is stalling.
