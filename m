Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8BAC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7F0214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7F0214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJIRRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:17:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:10374 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJIRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:17:01 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w99A0prO016026;
        Tue, 9 Oct 2018 19:00:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Tue, 09 Oct 2018 19:00:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w99A0kQn015815
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 9 Oct 2018 19:00:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] mm, oom_adj: avoid meaningless loop to find processes
 sharing mm
To:     Michal Hocko <mhocko@kernel.org>
Cc:     ytk.lee@samsung.com, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <67eedc4c-7afa-e845-6c88-9716fd820de6@i-love.sakura.ne.jp>
 <af7ae9c4-d7f1-69af-58fa-ec6949161f5b@I-love.SAKURA.ne.jp>
 <20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p8>
 <20181008061407epcms1p519703ae6373a770160c8f912c7aa9521@epcms1p5>
 <CGME20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p2>
 <20181008083855epcms1p20e691e5a001f3b94b267997c24e91128@epcms1p2>
 <f5bdf4a7-e491-1cda-590c-792526f49050@i-love.sakura.ne.jp>
 <20181009063541.GB8528@dhcp22.suse.cz> <20181009075015.GC8528@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <df4b029c-16b4-755f-2672-d7ec116f78ba@i-love.sakura.ne.jp>
Date:   Tue, 9 Oct 2018 19:00:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009075015.GC8528@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/09 16:50, Michal Hocko wrote:
> On Tue 09-10-18 08:35:41, Michal Hocko wrote:
>> [I have only now noticed that the patch has been reposted]
>>
>> On Mon 08-10-18 18:27:39, Tetsuo Handa wrote:
>>> On 2018/10/08 17:38, Yong-Taek Lee wrote:
> [...]
>>>> Thank you for your suggestion. But i think it would be better to seperate to 2 issues. How about think these
>>>> issues separately because there are no dependency between race issue and my patch. As i already explained,
>>>> for_each_process path is meaningless if there is only one thread group with many threads(mm_users > 1 but 
>>>> no other thread group sharing same mm). Do you have any other idea to avoid meaningless loop ? 
>>>
>>> Yes. I suggest reverting commit 44a70adec910d692 ("mm, oom_adj: make sure processes
>>> sharing mm have same view of oom_score_adj") and commit 97fd49c2355ffded ("mm, oom:
>>> kill all tasks sharing the mm").
>>
>> This would require a lot of other work for something as border line as
>> weird threading model like this. I will think about something more
>> appropriate - e.g. we can take mmap_sem for read while doing this check
>> and that should prevent from races with [v]fork.
> 
> Not really. We do not even take the mmap_sem when CLONE_VM. So this is
> not the way. Doing a proper synchronization seems much harder. So let's
> consider what is the worst case scenario. We would basically hit a race
> window between copy_signal and copy_mm and the only relevant case would
> be OOM_SCORE_ADJ_MIN which wouldn't propagate to the new "thread".

The "between copy_signal() and copy_mm()" race window is merely whether we need
to run for_each_process() loop. The race window is much larger than that; it is
between "copy_signal() copies oom_score_adj/oom_score_adj_min" and "the created
thread becomes accessible from for_each_process() loop".

>                                                                    OOM
> killer could then pick up the "thread" and kill it along with the whole
> process group sharing the mm.

Just reverting commit 44a70adec910d692 and commit 97fd49c2355ffded is
sufficient.

>                               Well, that is unfortunate indeed and it
> breaks the OOM_SCORE_ADJ_MIN contract. There are basically two ways here
> 1) do not care and encourage users to use a saner way to set
> OOM_SCORE_ADJ_MIN because doing that externally is racy anyway e.g.
> setting it before [v]fork & exec. Btw. do we know about an actual user
> who would care?

I'm not talking about [v]fork & exec. Why are you talking about [v]fork & exec ?

> 2) add OOM_SCORE_ADJ_MIN and do not kill tasks sharing mm and do not
> reap the mm in the rare case of the race.

That is no problem. The mistake we made in 4.6 was that we updated oom_score_adj
to -1000 (and allowed unprivileged users to OOM-lockup the system). Now that we set
MMF_OOM_SKIP, there is no need to worry about "oom_score_adj != -1000" thread group
and "oom_score_adj == -1000" thread group sharing the same mm. Since updating
oom_score_adj to -1000 is a privileged operation, it is administrator's wish if
such case happened; the kernel should respect the administrator's wish.

> 
> I would prefer the firs but if this race really has to be addressed then
> the 2 sounds more reasonable than the wholesale revert.
> 

