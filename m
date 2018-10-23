Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF3AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E892080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E892080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJWRAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:00:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:59516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727542AbeJWRAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:00:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E5ECB08A;
        Tue, 23 Oct 2018 08:37:41 +0000 (UTC)
Date:   Tue, 23 Oct 2018 10:37:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
Message-ID: <20181023083738.o4wo3jxw3xkp3rwx@pathway.suse.cz>
References: <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
 <20181018042739.GA650@jagdpanzerIV>
 <201810180526.w9I5QvVn032670@www262.sakura.ne.jp>
 <20181018061018.GB650@jagdpanzerIV>
 <20181018075611.GY18839@dhcp22.suse.cz>
 <20181018081352.GA438@jagdpanzerIV>
 <2c2b2820-e6f8-76c8-c431-18f60845b3ab@i-love.sakura.ne.jp>
 <20181018235427.GA877@jagdpanzerIV>
 <5d472476-7852-f97b-9412-63536dffaa0e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d472476-7852-f97b-9412-63536dffaa0e@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-10-19 19:35:53, Tetsuo Handa wrote:
> On 2018/10/19 8:54, Sergey Senozhatsky wrote:
> > On (10/18/18 20:58), Tetsuo Handa wrote:
> >> That boils down to a "user interaction" problem.
> >> Not limiting
> >>
> >>   "%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n"
> >>   "Out of memory and no killable processes...\n"
> >>
> >> is very annoying.
> >>
> >> And I really can't understand why Michal thinks "handling this requirement" as
> >> "make the code more complex than necessary and squash different things together".
> > 
> > Michal is trying very hard to address the problem in a reasonable way.
> 
> OK. But Michal, do we have a reasonable way which can be applied now instead of
> my patch or one of below patches? Just enumerating words like "hackish" or "a mess"
> without YOU ACTUALLY PROPOSE PATCHES will bounce back to YOU.

Michal suggested using ratelimit, the standard solution.

My understanding is that this situation happens when the system is
misconfigured and unusable without manual intervention. If
the user is able to see what the problem is then we are good.

You talk about interactivity but who asked for this?
IMHO, if system ends in OOM situation, it would need to get
restarted in most cases anyway. Then people have a chance
to fix the configuration after the reboot.

Best Regards,
Petr
