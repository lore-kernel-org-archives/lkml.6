Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82396C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4399521104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4399521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeKZVnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:43:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59694 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeKZVnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:43:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDB1F351D;
        Mon, 26 Nov 2018 02:50:09 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636DE3F5AF;
        Mon, 26 Nov 2018 02:50:08 -0800 (PST)
Date:   Mon, 26 Nov 2018 10:50:05 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@gmx.us>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, arnd@arndb.de,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] debugobjects: scale the static pool size
Message-ID: <20181126105005.GA33554@arrakis.emea.arm.com>
References: <20181120232810.2503-1-cai@gmx.us>
 <20181121021157.3061-1-cai@gmx.us>
 <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de>
 <EAB01918-727E-4E6F-AC7F-0417CA469D5A@gmx.us>
 <211af3b2-bc56-2d1b-c6c2-f6853797a7a1@gmx.us>
 <473f6a6e-1a14-d07c-b0f0-4d96e3232d1a@redhat.com>
 <5abb31e1-b5f2-718d-3a48-b0d8a73d6e5c@gmx.us>
 <0cba9054-99dd-9dbe-3da8-e10d25752c5b@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cba9054-99dd-9dbe-3da8-e10d25752c5b@gmx.us>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:45:54AM -0500, Qian Cai wrote:
> On 11/25/18 11:52 PM, Qian Cai wrote:
> > BTW, calling debug_objects_mem_init() before kmemleak_init() actually
> > could trigger a loop on machines with 160+ CPUs until the pool is filled
> > up,
> > 
> > debug_objects_pool_min_level += num_possible_cpus() * 4;
> > 
> > [1] while (obj_pool_free < debug_objects_pool_min_level)
> > 
> > kmemleak_init
> >    kmemleak_ignore (from replaced static debug objects)
> >      make_black_object
> >        put_object
> >          __call_rcu (kernel/rcu/tree.c)
> >            debug_rcu_head_queue
> >              debug_object_activate
> >                debug_object_init
> >                  fill_pool
> >                    kmemleak_ignore (looping in [1])
> >                      make_black_object
> >                        ...
> > 
> > I think until this is resolved, there is no way to move
> > debug_objects_mem_init() before kmemleak_init().
> 
> I believe this is a separate issue that kmemleak is broken with
> CONFIG_DEBUG_OBJECTS_RCU_HEAD anyway where the infinite loop above could be
> triggered in the existing code as well, i.e., once the pool need be refilled
> (fill_pool()) after the system boot up, debug object creation will call
> kmemleak_ignore() and it will create a new rcu debug_object_init(), and then
> it will call fill_pool() again and again. As the results, the system is
> locking up during kernel compilations.
> 
> Hence, I'll send out a patch for debug objects with large CPUs anyway and
> deal with kmemleak + CONFIG_DEBUG_OBJECTS_RCU_HEAD issue later.

I haven't hit this before but I can see why it happens. Kmemleak uses
RCU for freeing its own data structures to avoid a recursive call to
sl*b (kmem_cache_free()). Since we already tell kmemleak to ignore the
debug_objects_cache allocations, I think we could as well add
SLAB_NOLEAKTRACE to kmem_cache_create() (I haven't tried yet, this was
not a documented API for kmemleak, rather used to avoid kmemleak
tracking itself).

-- 
Catalin
