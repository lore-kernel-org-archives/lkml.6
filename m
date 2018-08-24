Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6163C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6878721581
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6878721581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeHXLZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:25:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeHXLZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:25:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2C89AF6F;
        Fri, 24 Aug 2018 07:52:01 +0000 (UTC)
Date:   Fri, 24 Aug 2018 09:52:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2 1/3] mm: rework memcg kernel stack accounting
Message-ID: <20180824075201.GZ29735@dhcp22.suse.cz>
References: <20180821213559.14694-1-guro@fb.com>
 <20180822141213.GO29735@dhcp22.suse.cz>
 <20180823162347.GA22650@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823162347.GA22650@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-08-18 09:23:50, Roman Gushchin wrote:
> On Wed, Aug 22, 2018 at 04:12:13PM +0200, Michal Hocko wrote:
[...]
> > > @@ -248,9 +253,20 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> > >  static inline void free_thread_stack(struct task_struct *tsk)
> > >  {
> > >  #ifdef CONFIG_VMAP_STACK
> > > -	if (task_stack_vm_area(tsk)) {
> > > +	struct vm_struct *vm = task_stack_vm_area(tsk);
> > > +
> > > +	if (vm) {
> > >  		int i;
> > >  
> > > +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> > > +			mod_memcg_page_state(vm->pages[i],
> > > +					     MEMCG_KERNEL_STACK_KB,
> > > +					     -(int)(PAGE_SIZE / 1024));
> > > +
> > > +			memcg_kmem_uncharge(vm->pages[i],
> > > +					    compound_order(vm->pages[i]));
> > 
> > when do we have order > 0 here?
> 
> I guess, it's not possible, but hard-coded 1 looked a bit crappy.
> Do you think it's better?

I guess you meant 0 here. Well, I do not mind, I was just wondering
whether I am missing something.
-- 
Michal Hocko
SUSE Labs
