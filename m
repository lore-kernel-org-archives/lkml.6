Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0606DC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFF520831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFF520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeJ3VD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:03:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:42792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727768AbeJ3VD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:03:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6F28B08A;
        Tue, 30 Oct 2018 12:10:12 +0000 (UTC)
Date:   Tue, 30 Oct 2018 13:10:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 3/3] mm, oom: hand over MMF_OOM_SKIP to exit path
 if it is guranteed to finish
Message-ID: <20181030121012.GC32673@dhcp22.suse.cz>
References: <20181025082403.3806-1-mhocko@kernel.org>
 <20181025082403.3806-4-mhocko@kernel.org>
 <201810300445.w9U4jMhu076672@www262.sakura.ne.jp>
 <20181030063136.GU32673@dhcp22.suse.cz>
 <95cb93ec-2421-3c5d-fd1e-91d9696b0f5a@I-love.SAKURA.ne.jp>
 <20181030113915.GB32673@dhcp22.suse.cz>
 <ca390ac1-2f10-b734-fff7-56767253e8c5@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca390ac1-2f10-b734-fff7-56767253e8c5@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-10-18 21:02:40, Tetsuo Handa wrote:
> On 2018/10/30 20:39, Michal Hocko wrote:
> > On Tue 30-10-18 18:47:43, Tetsuo Handa wrote:
> >> On 2018/10/30 15:31, Michal Hocko wrote:
> >>> On Tue 30-10-18 13:45:22, Tetsuo Handa wrote:
> >>>> Michal Hocko wrote:
> >>>>> @@ -3156,6 +3166,13 @@ void exit_mmap(struct mm_struct *mm)
> >>>>>                 vma = remove_vma(vma);
> >>>>>         }
> >>>>>         vm_unacct_memory(nr_accounted);
> >>>>> +
> >>>>> +       /*
> >>>>> +        * Now that the full address space is torn down, make sure the
> >>>>> +        * OOM killer skips over this task
> >>>>> +        */
> >>>>> +       if (oom)
> >>>>> +               set_bit(MMF_OOM_SKIP, &mm->flags);
> >>>>>  }
> >>>>>
> >>>>>  /* Insert vm structure into process list sorted by address
> >>>>
> >>>> I don't like setting MMF_OOF_SKIP after remove_vma() loop. 50 users might
> >>>> call vma->vm_ops->close() from remove_vma(). Some of them are doing fs
> >>>> writeback, some of them might be doing GFP_KERNEL allocation from
> >>>> vma->vm_ops->open() with a lock also held by vma->vm_ops->close().
> >>>>
> >>>> I don't think that waiting for completion of remove_vma() loop is safe.
> >>>
> >>> What do you mean by 'safe' here?
> >>>
> >>
> >> safe = "Does not cause OOM lockup."
> >>
> >> remove_vma() is allowed to sleep, and some users might depend on memory
> >> allocation when the OOM killer is waiting for remove_vma() to complete.
> > 
> > But MMF_OOF_SKIP is set after we are done with remove_vma. In fact it is
> > the very last thing in exit_mmap. So I do not follow what you mean.
> > 
> 
> So what? Think the worst case. Quite obvious bug here.

I misunderstood your concern. oom_reaper would back off without
MMF_OOF_SKIP as well. You are right we cannot assume anything about
close callbacks so MMF_OOM_SKIP has to come before that. I will move it
behind the pagetable freeing.
-- 
Michal Hocko
SUSE Labs
