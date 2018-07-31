Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7CEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA5020870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA5020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbeGaPyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:54:39 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:23945 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbeGaPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:54:38 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6VEE5Nw096683;
        Tue, 31 Jul 2018 23:14:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Tue, 31 Jul 2018 23:14:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6VEE4Ni096677
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 31 Jul 2018 23:14:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v13 0/7] cgroup-aware OOM killer
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <0d018c7e-a3de-a23a-3996-bed8b28b1e4a@i-love.sakura.ne.jp>
 <20180716220918.GA3898@castle.DHCP.thefacebook.com>
 <201807170055.w6H0tHn5075670@www262.sakura.ne.jp>
Message-ID: <ede70c6a-620b-f835-d66c-b4608fe0ef54@i-love.sakura.ne.jp>
Date:   Tue, 31 Jul 2018 23:14:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201807170055.w6H0tHn5075670@www262.sakura.ne.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/17 9:55, Tetsuo Handa wrote:
>> I don't get, why it's necessary to drop the cgroup oom killer to merge your fix?
>> I'm happy to help with rebasing and everything else.
> 
> Yes, I wish you rebase your series on top of OOM lockup (CVE-2016-10723) mitigation
> patch ( https://marc.info/?l=linux-mm&m=153112243424285&w=4 ). It is a trivial change
> and easy to cleanly backport (if applied before your series).
> 
> Also, I expect you to check whether my cleanup patch which removes "abort" path
> ( [PATCH 1/2] at https://marc.info/?l=linux-mm&m=153119509215026&w=4 ) helps
> simplifying your series. I don't know detailed behavior of your series, but I
> assume that your series do not kill threads which current thread should not wait
> for MMF_OOM_SKIP.

syzbot is hitting WARN(1) due to mem_cgroup_out_of_memory() == false.
https://syzkaller.appspot.com/bug?id=ea8c7912757d253537375e981b61749b2da69258

I can't tell what change is triggering this race. Maybe removal of oom_lock from
the oom reaper made more likely to hit. But anyway I suspect that

static bool oom_kill_memcg_victim(struct oom_control *oc)
{
        if (oc->chosen_memcg == NULL || oc->chosen_memcg == INFLIGHT_VICTIM)
                return oc->chosen_memcg; // <= This line is still broken

because

                /* We have one or more terminating processes at this point. */
                oc->chosen_task = INFLIGHT_VICTIM;

is not called.

Also, that patch is causing confusion by reviving schedule_timeout_killable(1)
with oom_lock held.

Can we temporarily drop cgroup-aware OOM killer from linux-next.git and
apply my cleanup patch? Since the merge window is approaching, I really want to
see how next -rc1 would look like...
