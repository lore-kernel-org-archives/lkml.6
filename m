Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA8EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309802082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309802082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJ3PXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:23:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:53162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbeJ3PXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:23:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E32C5AEC0;
        Tue, 30 Oct 2018 06:31:37 +0000 (UTC)
Date:   Tue, 30 Oct 2018 07:31:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 3/3] mm, oom: hand over MMF_OOM_SKIP to exit path
 if it is guranteed to finish
Message-ID: <20181030063136.GU32673@dhcp22.suse.cz>
References: <20181025082403.3806-1-mhocko@kernel.org>
 <20181025082403.3806-4-mhocko@kernel.org>
 <201810300445.w9U4jMhu076672@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810300445.w9U4jMhu076672@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-10-18 13:45:22, Tetsuo Handa wrote:
> Michal Hocko wrote:
> > @@ -3156,6 +3166,13 @@ void exit_mmap(struct mm_struct *mm)
> >                 vma = remove_vma(vma);
> >         }
> >         vm_unacct_memory(nr_accounted);
> > +
> > +       /*
> > +        * Now that the full address space is torn down, make sure the
> > +        * OOM killer skips over this task
> > +        */
> > +       if (oom)
> > +               set_bit(MMF_OOM_SKIP, &mm->flags);
> >  }
> > 
> >  /* Insert vm structure into process list sorted by address
> 
> I don't like setting MMF_OOF_SKIP after remove_vma() loop. 50 users might
> call vma->vm_ops->close() from remove_vma(). Some of them are doing fs
> writeback, some of them might be doing GFP_KERNEL allocation from
> vma->vm_ops->open() with a lock also held by vma->vm_ops->close().
> 
> I don't think that waiting for completion of remove_vma() loop is safe.

What do you mean by 'safe' here?
-- 
Michal Hocko
SUSE Labs
