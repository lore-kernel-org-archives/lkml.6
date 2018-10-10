Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15459C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D895220835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D895220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJJQXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:23:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:49510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbeJJQXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:23:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53B0FB016;
        Wed, 10 Oct 2018 09:02:39 +0000 (UTC)
Date:   Wed, 10 Oct 2018 11:02:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        hannes@cmpxchg.org, akpm@linux-foundation.org, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        yang.s@alibaba-inc.com
Subject: Re: INFO: rcu detected stall in shmem_fault
Message-ID: <20181010090238.GD5873@dhcp22.suse.cz>
References: <000000000000dc48d40577d4a587@google.com>
 <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <alpine.DEB.2.21.1810092106190.83503@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810092106190.83503@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-10-18 21:11:48, David Rientjes wrote:
> On Wed, 10 Oct 2018, Tetsuo Handa wrote:
> 
> > syzbot is hitting RCU stall due to memcg-OOM event.
> > https://syzkaller.appspot.com/bug?id=4ae3fff7fcf4c33a47c1192d2d62d2e03efffa64
> > 
> > What should we do if memcg-OOM found no killable task because the allocating task
> > was oom_score_adj == -1000 ? Flooding printk() until RCU stall watchdog fires 
> > (which seems to be caused by commit 3100dab2aa09dc6e ("mm: memcontrol: print proper
> > OOM header when no eligible victim left") because syzbot was terminating the test
> > upon WARN(1) removed by that commit) is not a good behavior.
> > 
> 
> Not printing anything would be the obvious solution but the ideal solution 
> would probably involve
> 
>  - adding feedback to the memcg oom killer that there are no killable 
>    processes,

We already have that - out_of_memory == F

>  - adding complete coverage for memcg_oom_recover() in all uncharge paths
>    where the oom memcg's page_counter is decremented, and

Could you elaborate?

>  - having all processes stall until memcg_oom_recover() is called so 
>    looping back into try_charge() has a reasonable expectation to succeed.

You cannot stall in the charge path waiting for others to make a forward
progress because we would be back to oom deadlocks when nobody can make
forward progress due to lock dependencies.

Right now we simply force the charge and allow for further progress when
situation like this happen because this shouldn't happen unless the
memcg is misconfigured badly.
-- 
Michal Hocko
SUSE Labs
