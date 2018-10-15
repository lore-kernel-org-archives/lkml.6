Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1ADC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD52C20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD52C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJOQDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:03:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:32956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbeJOQDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:03:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5319CAE4F;
        Mon, 15 Oct 2018 08:19:36 +0000 (UTC)
Date:   Mon, 15 Oct 2018 10:19:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms
 without eligible tasks
Message-ID: <20181015081934.GD18839@dhcp22.suse.cz>
References: <000000000000dc48d40577d4a587@google.com>
 <20181010151135.25766-1-mhocko@kernel.org>
 <20181012112008.GA27955@cmpxchg.org>
 <20181012120858.GX5873@dhcp22.suse.cz>
 <9174f087-3f6f-f0ed-6009-509d4436a47a@i-love.sakura.ne.jp>
 <20181012124137.GA29330@cmpxchg.org>
 <0417c888-d74e-b6ae-a8f0-234cbde03d38@i-love.sakura.ne.jp>
 <bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp>
 <20181013112238.GA762@cmpxchg.org>
 <b61b2e60-d899-90c6-579a-587815cebff6@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b61b2e60-d899-90c6-579a-587815cebff6@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 13-10-18 20:28:38, Tetsuo Handa wrote:
> On 2018/10/13 20:22, Johannes Weiner wrote:
> > On Sat, Oct 13, 2018 at 08:09:30PM +0900, Tetsuo Handa wrote:
> >> ---------- Michal's patch ----------
> >>
> >> 73133 lines (5.79MB) of kernel messages per one run
> >>
> >> [root@ccsecurity ~]# time ./a.out
> >>
> >> real    3m44.389s
> >> user    0m0.000s
> >> sys     3m42.334s
> >>
> >> [root@ccsecurity ~]# time ./a.out
> >>
> >> real    3m41.767s
> >> user    0m0.004s
> >> sys     3m39.779s
> >>
> >> ---------- My v2 patch ----------
> >>
> >> 50 lines (3.40 KB) of kernel messages per one run
> >>
> >> [root@ccsecurity ~]# time ./a.out
> >>
> >> real    0m5.227s
> >> user    0m0.000s
> >> sys     0m4.950s
> >>
> >> [root@ccsecurity ~]# time ./a.out
> >>
> >> real    0m5.249s
> >> user    0m0.000s
> >> sys     0m4.956s
> > 
> > Your patch is suppressing information that I want to have and my
> > console can handle, just because your console is slow, even though
> > there is no need to use that console at that log level.
> 
> My patch is not suppressing information you want to have.
> My patch is mainly suppressing
> 
> [   52.393146] Out of memory and no killable processes...
> [   52.395195] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
> [   52.398623] Out of memory and no killable processes...
> [   52.401195] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
> [   52.404356] Out of memory and no killable processes...
> [   52.406492] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
> [   52.409595] Out of memory and no killable processes...
> [   52.411745] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
> [   52.415588] Out of memory and no killable processes...
> [   52.418484] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
> [   52.421904] Out of memory and no killable processes...
> [   52.424273] a.out invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=-1000
> 
> lines which Michal's patch cannot suppress.

This was a deliberate decision because the allocation failure context is
usually a useful information to get. If this is killing a reasonably
configured machine then we can move the ratelimit up and suppress that
information. This will always be cost vs. benefit decision. And as such
it should be argued in the changelog.

As so many dozens of times before, I will point you to an incremental
nature of changes we really prefer in the mm land. We are also after a
simplicity which your proposal lacks in many aspects. You seem to ignore
that general approach and I have hard time to consider your NAK as a
relevant feedback. Going to an extreme and basing a complex solution on
it is not going to fly. No killable process should be a rare event which
requires a seriously misconfigured memcg to happen so wildly. If you can
trigger it with a normal user privileges then it would be a clear bug to
address rather than work around with printk throttling.
-- 
Michal Hocko
SUSE Labs
