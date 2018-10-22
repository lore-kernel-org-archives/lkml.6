Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654C7C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C220664
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7C220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeJVXcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:32:01 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:38592 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJVXcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:32:00 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9MFCouv093802;
        Tue, 23 Oct 2018 00:12:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Tue, 23 Oct 2018 00:12:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9MFCn1X093799
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 23 Oct 2018 00:12:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-3-mhocko@kernel.org>
 <f9a8079f-55b0-301e-9b3d-a5250bd7d277@i-love.sakura.ne.jp>
 <20181022120308.GB18839@dhcp22.suse.cz>
 <0a84d3de-f342-c183-579b-d672c116ba25@i-love.sakura.ne.jp>
 <20181022134315.GF18839@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2deec266-2eaf-f754-ae94-d290f10c79ec@i-love.sakura.ne.jp>
Date:   Tue, 23 Oct 2018 00:12:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022134315.GF18839@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/22 22:43, Michal Hocko wrote:
> On Mon 22-10-18 22:20:36, Tetsuo Handa wrote:
>> I mean:
>>
>>  mm/memcontrol.c |   3 +-
>>  mm/oom_kill.c   | 111 +++++---------------------------------------------------
>>  2 files changed, 12 insertions(+), 102 deletions(-)
> 
> This is much larger change than I feel comfortable with to plug this
> specific issue. A simple and easy to understand fix which doesn't add
> maintenance burden should be preferred in general.
> 
> The code reduction looks attractive but considering it is based on
> removing one of the heuristics to prevent OOM reports in some case it
> should be done on its own with a careful and throughout justification.
> E.g. how often is the heuristic really helpful.

I think the heuristic is hardly helpful.


Regarding task_will_free_mem(current) condition in out_of_memory(),
this served for two purposes. One is that mark_oom_victim() is not yet
called on current thread group when mark_oom_victim() was already called
on other thread groups. But such situation disappears by removing
task_will_free_mem() shortcuts and forcing for_each_process(p) loop
in __oom_kill_process().

The other is that mark_oom_victim() is not yet called on any thread groups when
all thread groups are exiting. In that case, we will fail to wait for current
thread group to release its mm... But it is unlikely that only threads which
task_will_free_mem(current) returns true can call out_of_memory() (note that
task_will_free_mem(p) returns false if p->mm == NULL).


I think it is highly unlikely to hit task_will_free_mem(p) condition
in oom_kill_process(). To hit it, the candidate who was chosen due to
the largest memory user has to be already exiting. However, if already
exiting, it is likely the candidate already released its mm (and hence
no longer the largest memory user). I can't say such race never happens,
but I think it is unlikely. Also, since task_will_free_mem(p) returns false
if thread group leader's mm is NULL whereas oom_badness() from
select_bad_process() evaluates any mm in that thread group and returns
a thread group leader, this heuristic is incomplete after all.

> 
> In principle I do not oppose to remove the shortcut after all due
> diligence is done because this particular one had given us quite a lot
> headaches in the past.
> 

