Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD081ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D18021476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D18021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeJRTYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:24:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:43906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727365AbeJRTYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:24:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94BBDAE10;
        Thu, 18 Oct 2018 11:23:59 +0000 (UTC)
Date:   Thu, 18 Oct 2018 13:23:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
Message-ID: <20181018112358.GB18839@dhcp22.suse.cz>
References: <20181017102821.GM18839@dhcp22.suse.cz>
 <20181017111724.GA459@jagdpanzerIV>
 <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
 <20181018065519.GV18839@dhcp22.suse.cz>
 <6bbb0449-1f22-4d05-9e2a-636965b7dbc6@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bbb0449-1f22-4d05-9e2a-636965b7dbc6@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-10-18 19:37:18, Tetsuo Handa wrote:
> On 2018/10/18 15:55, Michal Hocko wrote:
> > On Thu 18-10-18 11:46:50, Tetsuo Handa wrote:
> >> This is essentially a ratelimit approach, roughly equivalent with:
> >>
> >>   static DEFINE_RATELIMIT_STATE(oom_no_victim_rs, 60 * HZ, 1);
> >>   oom_no_victim_rs.flags |= RATELIMIT_MSG_ON_RELEASE;
> >>
> >>   if (__ratelimit(&oom_no_victim_rs)) {
> >>     dump_header(oc, NULL);
> >>     pr_warn("Out of memory and no killable processes...\n");
> >>     oom_no_victim_rs.begin = jiffies;
> >>   }
> > 
> > Then there is no reason to reinvent the wheel. So use the standard
> > ratelimit approach. Or put it in other words, this place is no special
> > to any other that needs some sort of printk throttling. We surely do not
> > want an ad-hoc solutions all over the kernel.
> 
> netdev_wait_allrefs() in net/core/dev.c is doing the same thing. Since
> out_of_memory() is serialized by oom_lock mutex, there is no need to use
> "struct ratelimit_state"->lock field. Plain "unsigned long" is enough.

That code probably predates generalized ratelimit api.

> > And once you realize that the ratelimit api is the proper one (put aside
> > any potential improvements in the implementation of this api) then you
> > quickly learn that we already do throttle oom reports and it would be
> > nice to unify that and ... we are back to a naked patch. So please stop
> > being stuborn and try to cooperate finally.
> 
> I don't think that ratelimit API is the proper one, for I am touching
> "struct ratelimit_state"->begin field which is not exported by ratelimit API.
> But if you insist on ratelimit API version, I can tolerate with below one.

I just give up. I do not really see why you always have to make the code
more complex than necessary and squash different things together. This
is a complete kernel code development antipattern.

I am not goging to reply to this thread more but let me note that this
is beyond fun in any aspect I can think off (and yeah I have considered
dark sense of humor as well).

> 
>  mm/oom_kill.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index f10aa53..7c6118e 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1106,6 +1106,12 @@ bool out_of_memory(struct oom_control *oc)
>  	select_bad_process(oc);
>  	/* Found nothing?!?! */
>  	if (!oc->chosen) {
> +		static DEFINE_RATELIMIT_STATE(no_eligible_rs, 60 * HZ, 1);
> +
> +		ratelimit_set_flags(&no_eligible_rs, RATELIMIT_MSG_ON_RELEASE);
> +		if ((is_sysrq_oom(oc) || is_memcg_oom(oc)) &&
> +		    !__ratelimit(&no_eligible_rs))
> +			return false;
>  		dump_header(oc, NULL);
>  		pr_warn("Out of memory and no killable processes...\n");
>  		/*
> @@ -1115,6 +1121,7 @@ bool out_of_memory(struct oom_control *oc)
>  		 */
>  		if (!is_sysrq_oom(oc) && !is_memcg_oom(oc))
>  			panic("System is deadlocked on memory\n");
> +		no_eligible_rs.begin = jiffies;
>  	}
>  	if (oc->chosen && oc->chosen != (void *)-1UL)
>  		oom_kill_process(oc, !is_memcg_oom(oc) ? "Out of memory" :
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
