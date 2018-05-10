Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935366AbeEJLlu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:41:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935101AbeEJLlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:41:49 -0400
Date: Thu, 10 May 2018 13:41:47 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Roman Gushchin <guro@fb.com>
Cc: kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: fix oom_kill event handling
Message-ID: <20180510114147.GB5325@dhcp22.suse.cz>
References: <20180508124637.29984-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508124637.29984-1-guro@fb.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-05-18 13:46:37, Roman Gushchin wrote:
> Commit e27be240df53 ("mm: memcg: make sure memory.events is
> uptodate when waking pollers") converted most of memcg event
> counters to per-memcg atomics, which made them less confusing
> for a user. The "oom_kill" counter remained untouched, so now
> it behaves differently than other counters (including "oom").
> This adds nothing but confusion.
> 
> Let's fix this by adding the MEMCG_OOM_KILL event, and follow
> the MEMCG_OOM approach. This also removes a hack from
> count_memcg_event_mm(), introduced earlier specially for the
> OOM_KILL counter.

I agree that the current OOM_KILL is confusing. But do we really need
another memcg_memory_event_mm helper used for only one counter rather
than reuse memcg_memory_event. __oom_kill_process doesn't have the memcg
but nothing should really prevent us from adding the context
(oom_control) there, no?

[...]
-- 
Michal Hocko
SUSE Labs
