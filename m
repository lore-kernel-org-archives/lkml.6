Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F440C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1000A2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1000A2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbeGZOFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:05:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:59366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729406AbeGZOFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:05:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8BDDDAEE5;
        Thu, 26 Jul 2018 12:48:34 +0000 (UTC)
Date:   Thu, 26 Jul 2018 14:48:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bruce Merry <bmerry@ska.ac.za>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some
 machines
Message-ID: <20180726124833.GG28386@dhcp22.suse.cz>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz>
 <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
 <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
 <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
 <CAOm-9aqYLExQZUvfk9ucCoSPoaA67D6ncEDR2+UZBMLhv4-r_A@mail.gmail.com>
 <CAOm-9arV_OC5XQquSUHy6WbsxC7s1gUWQDKKLkR+Ctvq6=A-BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOm-9arV_OC5XQquSUHy6WbsxC7s1gUWQDKKLkR+Ctvq6=A-BQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-07-18 14:35:34, Bruce Merry wrote:
> On 24 July 2018 at 12:05, Bruce Merry <bmerry@ska.ac.za> wrote:
> > To reproduce:
> > 1. Start cadvisor running. I use the 0.30.2 binary from Github, and
> > run it with sudo ./cadvisor-0.30.2 --logtostderr=true
> > 2. Run the Python 3 script below, which repeatedly creates a cgroup,
> > enters it, stats some files in it, and leaves it again (and removes
> > it). It takes a few minutes to run.
> > 3. time cat /sys/fs/cgroup/memory/memory.stat. It now takes about 20ms for me.
> > 4. sudo sysctl vm.drop_caches=2
> > 5. time cat /sys/fs/cgroup/memory/memory.stat. It is back to 1-2ms.
> >
> > I've also added some code to memcg_stat_show to report the number of
> > cgroups in the hierarchy (iterations in for_each_mem_cgroup_tree).
> > Running the script increases it from ~700 to ~41000. The script
> > iterates 250,000 times, so only some fraction of the cgroups become
> > zombies.
> 
> I've discovered that I'd messed up that instrumentation code (it was
> incrementing inside a loop so counted 5x too many cgroups), so some of
> the things I said turn out to be wrong. Let me try again:
> - Running the script generates about 8000 zombies (not 40000), with or
> without Shakeel's patch (for 250,000 cgroups created/destroyed - so
> possibly there is some timing condition that makes them into zombies.
> I've only measured it with 4.17, but based on timing results I have no
> particular reason to think it's wildly different to older kernels.
> - After running the script 5 times (to generate 40K zombies), getting
> the stats takes 20ms with Shakeel's patch and 80ms without it (on
> 4.17.9) - which is a speedup of the same order of magnitude as Shakeel
> observed with non-zombies.
> - 4.17.9 already seems to be an improvement over 4.15: with 40K
> (non-zombie) cgroups, memory.stat time decreases from 200ms to 75ms.
> 
> So with 4.15 -> 4.17.9 plus Shakeel's patch, the effects are reduced
> by an order of magnitude, which is good news. Of course, that doesn't
> solve the fundamental issue of why the zombies get generated in the
> first place. I'm not a kernel developer and I very much doubt I'll
> have the time to try to debug what may turn out to be a race
> condition, but let me know if I can help with testing things.

As already explained. This is not a race. We just simply keep pages
charged to a memcg we are removing and rely on the memory reclaim to
free them when we need that memory for something else. The problem you
are seeing is a side effect of this because a large number of zombies
adds up when we need to get cumulative stats for their parent.
-- 
Michal Hocko
SUSE Labs
