Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF34EC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E6F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E6F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeJZXm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:42:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62195 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJZXm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:42:26 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9QF4d5D032461;
        Sat, 27 Oct 2018 00:04:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Sat, 27 Oct 2018 00:04:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9QF4cmM032457
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 27 Oct 2018 00:04:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: KASAN: use-after-free Read in task_is_descendant
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com>
 <d11bc954-5a30-e6bd-1668-866a187e0aac@i-love.sakura.ne.jp>
 <20181025155503.GF3725@redhat.com>
 <3423a470-c152-0dbf-c7a7-2775a9679194@i-love.sakura.ne.jp>
 <20181026130442.GB10581@redhat.com>
 <522c4993-4d98-be98-def2-452ed28098f9@i-love.sakura.ne.jp>
 <20181026143937.GA18848@redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4264173d-4947-9fad-97e6-5269defb6eb4@i-love.sakura.ne.jp>
Date:   Sat, 27 Oct 2018 00:04:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026143937.GA18848@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/26 23:39, Oleg Nesterov wrote:
> On 10/26, Tetsuo Handa wrote:
>> Suppose p1 == p2->real_parent and p2 == p3->real_parent, and p1 exited
>> when someone tried to attach on p2, p2->real_parent was pointing to already
>> (or about to be) freed p1.
> 
> I don't see a difference.
> 
> If p1 exits it will re-parent p2, p2->real_parent will be updated.
> 
>> So, the puzzle part is why p2->real_parent was still pointing p1 even after
>> p1 was freed...
> 
> I don't understand the question.
> 
> Once again. TASK->real_parent can point to the freed mem only if a) TASK exits,
> and b) _after_ that its parent TASK->real_parent exits too.

Oh, p2 exited and then p1 also exited when someone tried to attach on p2.
Then, p2->real_parent can point to already (or about to be) freed p1.

> 
>>> Again, did you read my previous email?
>>
>> Yes. But I still can't be convinced that pid_alive() test helps.
> 
> Well, I don't understand which part of my explanations is not clear to you.

OK. Checking pid_alive() should help.

(By the way, if p->real_parent were updated to point to init_task when p exits,
we could omit pid_alive() check?)

