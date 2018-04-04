Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeDDOXd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:23:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:59043 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeDDOXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:23:33 -0400
Date: Wed, 4 Apr 2018 16:23:29 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180404142329.GI6312@dhcp22.suse.cz>
References: <20180403110612.GM5501@dhcp22.suse.cz>
 <20180403075158.0c0a2795@gandalf.local.home>
 <20180403121614.GV5501@dhcp22.suse.cz>
 <20180403082348.28cd3c1c@gandalf.local.home>
 <20180403123514.GX5501@dhcp22.suse.cz>
 <20180403093245.43e7e77c@gandalf.local.home>
 <20180403135607.GC5501@dhcp22.suse.cz>
 <CAGWkznH-yfAu=fMo1YWU9zo-DomHY8YP=rw447rUTgzvVH4RpQ@mail.gmail.com>
 <20180404062340.GD6312@dhcp22.suse.cz>
 <20180404101149.08f6f881@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404101149.08f6f881@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-04-18 10:11:49, Steven Rostedt wrote:
> On Wed, 4 Apr 2018 08:23:40 +0200
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > If you are afraid of that then you can have a look at {set,clear}_current_oom_origin()
> > which will automatically select the current process as an oom victim and
> > kill it.
> 
> Would it even receive the signal? Does alloc_pages_node() even respond
> to signals? Because the OOM happens while the allocation loop is
> running.

Well, you would need to do something like:

> 
> I tried it out, I did the following:
> 
> 	set_current_oom_origin();
> 	for (i = 0; i < nr_pages; i++) {
> 		struct page *page;
> 		/*
> 		 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
> 		 * gracefully without invoking oom-killer and the system is not
> 		 * destabilized.
> 		 */
> 		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
> 				    GFP_KERNEL | __GFP_RETRY_MAYFAIL,
> 				    cpu_to_node(cpu));
> 		if (!bpage)
> 			goto free_pages;
> 
> 		list_add(&bpage->list, pages);
> 
> 		page = alloc_pages_node(cpu_to_node(cpu),
> 					GFP_KERNEL | __GFP_RETRY_MAYFAIL, 0);
> 		if (!page)
> 			goto free_pages;

		if (fatal_signal_pending())
			fgoto free_pages;

> 		bpage->page = page_address(page);
> 		rb_init_page(bpage->page);
> 	}
> 	clear_current_oom_origin();

If you use __GFP_RETRY_MAYFAIL it would have to be somedy else to
trigger the OOM killer and this user context would get killed. If you
drop __GFP_RETRY_MAYFAIL it would be this context to trigger the OOM but
it would still be the selected victim.
-- 
Michal Hocko
SUSE Labs
