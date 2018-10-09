Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44ACC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CEF214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CEF214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJIUJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:09:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57743 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIUJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:09:11 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w99CqLP7040230;
        Tue, 9 Oct 2018 21:52:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Tue, 09 Oct 2018 21:52:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w99CqFSD040206
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 9 Oct 2018 21:52:21 +0900 (JST)
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
 <df4b029c-16b4-755f-2672-d7ec116f78ba@i-love.sakura.ne.jp>
 <20181009111005.GK8528@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <99008444-b6b1-efc9-8670-f3eac4d2305f@i-love.sakura.ne.jp>
Date:   Tue, 9 Oct 2018 21:52:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009111005.GK8528@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/09 20:10, Michal Hocko wrote:
> On Tue 09-10-18 19:00:44, Tetsuo Handa wrote:
>>> 2) add OOM_SCORE_ADJ_MIN and do not kill tasks sharing mm and do not
>>> reap the mm in the rare case of the race.
>>
>> That is no problem. The mistake we made in 4.6 was that we updated oom_score_adj
>> to -1000 (and allowed unprivileged users to OOM-lockup the system).
> 
> I do not follow.
> 

http://tomoyo.osdn.jp/cgi-bin/lxr/source/mm/oom_kill.c?v=linux-4.6.7#L493

[  177.722853] a.out invoked oom-killer: gfp_mask=0x24280ca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=0, oom_score_adj=0
[  177.724956] a.out cpuset=/ mems_allowed=0
[  177.725735] CPU: 3 PID: 3962 Comm: a.out Not tainted 4.5.0-rc2-next-20160204 #291
(...snipped...)
[  177.802889] [ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
(...snipped...)
[  177.872248] [ 3941]  1000  3941    28880      124      14       3        0             0 bash
[  177.874279] [ 3962]  1000  3962   541717   395780     784       6        0             0 a.out
[  177.876274] [ 3963]  1000  3963     1078       21       7       3        0          1000 a.out
[  177.878261] [ 3964]  1000  3964     1078       21       7       3        0          1000 a.out
[  177.880194] [ 3965]  1000  3965     1078       21       7       3        0          1000 a.out
[  177.882262] Out of memory: Kill process 3963 (a.out) score 998 or sacrifice child
[  177.884129] Killed process 3963 (a.out) total-vm:4312kB, anon-rss:84kB, file-rss:0kB, shmem-rss:0kB
[  177.887100] oom_reaper: reaped process :3963 (a.out) anon-rss:0kB, file-rss:0kB, shmem-rss:0lB
[  179.638399] crond invoked oom-killer: gfp_mask=0x24201ca(GFP_HIGHUSER_MOVABLE|__GFP_COLD), order=0, oom_score_adj=0
[  179.647708] crond cpuset=/ mems_allowed=0
[  179.652996] CPU: 3 PID: 742 Comm: crond Not tainted 4.5.0-rc2-next-20160204 #291
(...snipped...)
[  179.771311] [ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
(...snipped...)
[  179.836221] [ 3941]  1000  3941    28880      124      14       3        0             0 bash
[  179.838278] [ 3962]  1000  3962   541717   396308     785       6        0             0 a.out
[  179.840328] [ 3963]  1000  3963     1078        0       7       3        0         -1000 a.out
[  179.842443] [ 3965]  1000  3965     1078        0       7       3        0          1000 a.out
[  179.844557] Out of memory: Kill process 3965 (a.out) score 998 or sacrifice child
[  179.846404] Killed process 3965 (a.out) total-vm:4312kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
