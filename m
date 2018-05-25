Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968080AbeEYTs5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:48:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33855 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967784AbeEYTs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:48:56 -0400
X-Google-Smtp-Source: AB8JxZq2GUMKpPfSyLNKQq2XT2uDEL+ziWovjGYMaeZZs5/s9wWEqFmLZbga65nI7oEa861MvB3ClA==
Date: Fri, 25 May 2018 12:48:54 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: ufo19890607 <ufo19890607@gmail.com>
cc: akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v5] Refactor part of the oom report in dump_header
In-Reply-To: <1527213613-7922-1-git-send-email-ufo19890607@gmail.com>
Message-ID: <alpine.DEB.2.21.1805251245210.158701@chino.kir.corp.google.com>
References: <1527213613-7922-1-git-send-email-ufo19890607@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018, ufo19890607 wrote:

> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> The dump_header does not print the memcg's name when the system
> oom happened, so users cannot locate the certain container which
> contains the task that has been killed by the oom killer.
> 
> I follow the advices of David Rientjes and Michal Hocko, and refactor
> part of the oom report in a backwards compatible way. After this patch,
> users can get the memcg's path from the oom report and check the certain
> container more quickly.
> 

I like the direction you are taking.  A couple notes:

 - you may find it easier to declare an array of const char * for each
   constraint:

	static const char * const oom_constraint_text[] = {
		[CONSTRAINT_NONE] = "CONSTRAINT_NONE",
		[CONSTRAINT_CPUSET] = "CONSTRAINT_CPUSET",
		[CONSTRAINT_MEMORY_POLICY] = "CONSTRAINT_MEMORY_POLICY",
		[CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
	};

 - we need to eliminate all the usage of pr_cont() because otherwise we
   can still get interleaving in the kernel log (the single line output
   should always be a complete single line that can be parsed by
   userspace).

 - to generate a single line output, I think you need a call to a
   function in mm/memcontrol.c when is_memcg_oom(oc) is true and
   otherwise a function in mm/oom_kill.c when false.   
