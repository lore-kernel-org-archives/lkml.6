Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814E5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4C82081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DlPChe98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbfBDNdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:33:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBDNdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2G6Id+7yUjSDlyENM/Qb+5JYzGtdNlR6zD4wg6ATMd0=; b=DlPChe98Mr380+TO6KbVQOpu0
        YvmsJaUplLeLHGXiyjaWiuAeBy/5o3b1I/EA9PkL8n2njwhS87EsTjwNFK6AEHaLWi/VdAnICfFG1
        w2vy3oEqA3qvRvZJT1TueMz9cufsi2TRUQcwFvwRHjEQN7M5fJH0HpYsGyTsJ3kVAvHf5XuTJsER2
        cVrZfug+e39sXOwCZBTr+6mbppbd8nN4aKIyH8imiubVCcL1WZg9I/UoIldi3PoS/i+Gt6+tCsVpA
        Ggjlffbo2id7LvtOHsU6/YDIdyXvIrwHirrrNTHTBFa2UnDrjnqvRiGRM/m+IsJz6LmMr03xjt2Wa
        L5kL8Kcfg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqeMu-0004eR-U6; Mon, 04 Feb 2019 13:33:00 +0000
Date:   Mon, 4 Feb 2019 05:33:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] mm/vmalloc: convert vmap_lazy_nr to atomic_long_t
Message-ID: <20190204133300.GA21860@bombadil.infradead.org>
References: <20190131162452.25879-1-urezki@gmail.com>
 <20190201124528.GN11599@dhcp22.suse.cz>
 <20190204104956.vg3u4jlwsjd2k7jn@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204104956.vg3u4jlwsjd2k7jn@pc636>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:49:56AM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 01, 2019 at 01:45:28PM +0100, Michal Hocko wrote:
> > On Thu 31-01-19 17:24:52, Uladzislau Rezki (Sony) wrote:
> > > vmap_lazy_nr variable has atomic_t type that is 4 bytes integer
> > > value on both 32 and 64 bit systems. lazy_max_pages() deals with
> > > "unsigned long" that is 8 bytes on 64 bit system, thus vmap_lazy_nr
> > > should be 8 bytes on 64 bit as well.
> > 
> > But do we really need 64b number of _pages_? I have hard time imagine
> > that we would have that many lazy pages to accumulate.
> > 
> That is more about of using the same type of variables thus the same size
> in 32/64 bit address space.
> 
> <snip>
> static void free_vmap_area_noflush(struct vmap_area *va)
> {
>     int nr_lazy;
>  
>     nr_lazy = atomic_add_return((va->va_end - va->va_start) >> PAGE_SHIFT,
>                                 &vmap_lazy_nr);
> ...
>     if (unlikely(nr_lazy > lazy_max_pages()))
>         try_purge_vmap_area_lazy();
> <snip>
> 
> va_end/va_start are "unsigned long" whereas atomit_t(vmap_lazy_nr) is "int". 
> The same with lazy_max_pages(), it returns "unsigned long" value.
> 
> Answering your question, in 64bit, the "vmalloc" address space is ~8589719406
> pages if PAGE_SIZE is 4096, i.e. a regular 4 byte integer is not enough to hold
> it. I agree it is hard to imagine, but it also depends on physical memory a
> system has, it has to be terabytes. I am not sure if such systems exists.

There are certainly systems with more than 16TB of memory out there.
The question is whether we want to allow individual vmaps of 16TB.
We currently have a 32TB vmap space (on x86-64), so that's one limit.
Should we restrict it further to avoid this ever wrapping past a 32-bit
limit?
