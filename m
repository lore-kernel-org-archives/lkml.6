Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeDDPrf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751696AbeDDPrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:47:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D13A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 11:47:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180404114730.65118279@gandalf.local.home>
In-Reply-To: <20180404142329.GI6312@dhcp22.suse.cz>
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
        <20180404142329.GI6312@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 16:23:29 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> > 
> > I tried it out, I did the following:
> > 
> > 	set_current_oom_origin();
> > 	for (i = 0; i < nr_pages; i++) {
> > 		struct page *page;
> > 		/*
> > 		 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
> > 		 * gracefully without invoking oom-killer and the system is not
> > 		 * destabilized.
> > 		 */
> > 		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
> > 				    GFP_KERNEL | __GFP_RETRY_MAYFAIL,
> > 				    cpu_to_node(cpu));
> > 		if (!bpage)
> > 			goto free_pages;
> > 
> > 		list_add(&bpage->list, pages);
> > 
> > 		page = alloc_pages_node(cpu_to_node(cpu),
> > 					GFP_KERNEL | __GFP_RETRY_MAYFAIL, 0);
> > 		if (!page)
> > 			goto free_pages;  
> 
> 		if (fatal_signal_pending())
> 			fgoto free_pages;

I originally was going to remove the RETRY_MAYFAIL, but adding this
check (at the end of the loop though) appears to have OOM consistently
kill this task.

I still like to keep RETRY_MAYFAIL, because it wont trigger OOM if
nothing comes in and tries to do an allocation, but instead will fail
nicely with -ENOMEM.

-- Steve


> 
> > 		bpage->page = page_address(page);
> > 		rb_init_page(bpage->page);
> > 	}
> > 	clear_current_oom_origin();  
