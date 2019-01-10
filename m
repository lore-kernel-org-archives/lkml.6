Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A879C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746E1214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfAJLGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:06:20 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:38967 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfAJLGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:06:19 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0AB5nfn067902;
        Thu, 10 Jan 2019 20:05:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Thu, 10 Jan 2019 20:05:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0AB5nIA067899
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 10 Jan 2019 20:05:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: yama: unsafe usage of ptrace_relation->tracer
To:     Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com> <20181025130129.GE3725@redhat.com>
 <CAGXu5jJDkt0vR28Rzhi2gmb=9S7BwWkiMuVrN98AOABgngYY4A@mail.gmail.com>
 <20181029122356.GA29883@redhat.com> <20181029150546.GA30959@redhat.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <0fc3493d-a50e-f386-20a8-28d348c19544@I-love.SAKURA.ne.jp>
Date:   Thu, 10 Jan 2019 20:05:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181029150546.GA30959@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Kees.

syzbot is hitting this problem as of linux-next-20190110.
When a patch will be proposed?

On 2018/10/30 0:05, Oleg Nesterov wrote:
> let me change the subject to avoid the confusion with the already confusing
> disccussion about task_is_descendant().
> 
> On 10/29, Oleg Nesterov wrote:
>>
>> I still think we need a single pid_alive() check and I even sent the patch.
>> Attached again at the end.
>>
>> To clarify, let me repeat that ptracer_exception_found() may need some fixes
>> too, right now I am only talking about task_is_descendant().
> 
> so yes, the ptracer_relations code looks very broken to me, but perhaps I
> misread this code, please correct me.
> 
> RCU can only protect the ptracer_relations list itself, you can do nothing
> with (say) relation->tracer. relation->tracer can be already freed when
> ptracer_exception_found() checks relation->tracee == tracee.
> 
> Not only pid_alive(parent) can not help in this case, pid_alive(parent) is
> equally unsafe because, again, this memory can be freed.
> 
> security_task_free(tsk) is called right before free_task(tsk), there is no
> a gp pass in between, and of course we can't rely on the ->invalid check.
> 
> _At first glance_ we can fix this if we simply turn both ->tracer/tracee
> pointers into "signal_struct *", then we can turn all same_thread_group()'s
> into walker->signal == parent which doesn't need to dereference the possibly-
> freed parent. This also allows to remove all thread_group_leader() checks.
> We need to ensure that false-positive is not possible (if, say, ->tracer
> was already re-allocated and points to another task->signal), but this
> doesn't look difficult.
> 
> Oleg.
> 
> 

