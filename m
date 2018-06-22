Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D1CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175722407B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175722407B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933465AbeFVKmX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:42:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33493 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbeFVKmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:42:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 490C3AC6A;
        Fri, 22 Jun 2018 10:42:19 +0000 (UTC)
Date:   Fri, 22 Jun 2018 12:42:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v9] Refactor part of the oom report in dump_header
Message-ID: <20180622104217.GV10465@dhcp22.suse.cz>
References: <1529056341-16182-1-git-send-email-ufo19890607@gmail.com>
 <20180622083949.GR10465@dhcp22.suse.cz>
 <CAHCio2jkE2FGc2g48jm+ddvEbN3hEOoohBM+-871v32N2i2gew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2jkE2FGc2g48jm+ddvEbN3hEOoohBM+-871v32N2i2gew@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 17:33:12, 禹舟键 wrote:
> Hi Michal
> > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > index 6adac113e96d..5bed78d4bfb8 100644
> > --- a/include/linux/oom.h
> > +++ b/include/linux/oom.h
> > @@ -15,6 +15,20 @@ struct notifier_block;
> >  struct mem_cgroup;
> >  struct task_struct;
> >
> > +enum oom_constraint {
> > +     CONSTRAINT_NONE,
> > +     CONSTRAINT_CPUSET,
> > +     CONSTRAINT_MEMORY_POLICY,
> > +     CONSTRAINT_MEMCG,
> > +};
> > +
> > +static const char * const oom_constraint_text[] = {
> > +     [CONSTRAINT_NONE] = "CONSTRAINT_NONE",
> > +     [CONSTRAINT_CPUSET] = "CONSTRAINT_CPUSET",
> > +     [CONSTRAINT_MEMORY_POLICY] = "CONSTRAINT_MEMORY_POLICY",
> > +     [CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
> > +};
> 
> > I've suggested that this should be a separate patch.
> I've separate this part in patch v7.
> 
> [PATCH v7 1/2] Add an array of const char and enum oom_constraint in
> memcontrol.h
> On Sat 02-06-18 19:58:51, ufo19890607@gmail.com wrote:
> >> From: yuzhoujian <yuzhoujian@didichuxing.com>
> >>
> >> This patch will make some preparation for the follow-up patch: Refactor
> >> part of the oom report in dump_header. It puts enum oom_constraint in
> >> memcontrol.h and adds an array of const char for each constraint.
> 
> > I do not get why you separate this specific part out.
> > oom_constraint_text is not used in the patch. It is almost always
> > preferable to have a user of newly added functionality.
> 
> So do I need to separate this part ?

You misunderstood my suggestion. Let me be more specific. Please
separate the whole new oom_constraint including its _usage_.
-- 
Michal Hocko
SUSE Labs
