Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9E5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14A42086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbfAOSSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:18:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:34514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728812AbfAOSSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:18:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9892AFAA;
        Tue, 15 Jan 2019 18:18:39 +0000 (UTC)
Date:   Tue, 15 Jan 2019 10:18:31 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/6] mm: make pinned_vm atomic and simplify users
Message-ID: <20190115181831.4zgrvyfjy2re7t43@linux-r8p5>
Mail-Followup-To: akpm@linux-foundation.org, dledford@redhat.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190115181300.27547-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190115181300.27547-1-dave@stgolabs.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also Ccing lkml, sorry.

On Tue, 15 Jan 2019, Davidlohr Bueso wrote:

>Hi,
>
>The following patches aim to provide cleanups to users that pin pages
>(mostly infiniband) by converting the counter to atomic -- note that
>Daniel Jordan also has patches[1] for the locked_vm counterpart and vfio.
>
>Apart from removing a source of mmap_sem writer, we benefit in that
>we can get rid of a lot of code that defers work when the lock cannot
>be acquired, as well as drivers avoiding mmap_sem altogether by also
>converting gup to gup_fast() and letting the mm handle it. Users
>that do the gup_longterm() remain of course under at least reader mmap_sem.
>
>Everything has been compile-tested _only_ so I hope I didn't do anything
>too stupid. Please consider for v5.1.
>
>On a similar topic and potential follow up, it would be nice to resurrect
>Peter's VM_PINNED idea in that the broken semantics that occurred after
>bc3e53f682 ("mm: distinguish between mlocked and pinned pages") are still
>present. Also encapsulating internal mm logic via mm[un]pin() instead of
>drivers having to know about internals and playing nice with compaction are
>all wins.
>
>Thanks!
>
>[1] https://lkml.org/lkml/2018/11/5/854
>
>Davidlohr Bueso (6):
>  mm: make mm->pinned_vm an atomic counter
>  mic/scif: do not use mmap_sem
>  drivers/IB,qib: do not use mmap_sem
>  drivers/IB,hfi1: do not se mmap_sem
>  drivers/IB,usnic: reduce scope of mmap_sem
>  drivers/IB,core: reduce scope of mmap_sem
>
> drivers/infiniband/core/umem.c              | 47 +++-----------------
> drivers/infiniband/hw/hfi1/user_pages.c     | 12 ++---
> drivers/infiniband/hw/qib/qib_user_pages.c  | 69 ++++++++++-------------------
> drivers/infiniband/hw/usnic/usnic_ib_main.c |  2 -
> drivers/infiniband/hw/usnic/usnic_uiom.c    | 56 +++--------------------
> drivers/infiniband/hw/usnic/usnic_uiom.h    |  1 -
> drivers/misc/mic/scif/scif_rma.c            | 38 +++++-----------
> fs/proc/task_mmu.c                          |  2 +-
> include/linux/mm_types.h                    |  2 +-
> kernel/events/core.c                        |  8 ++--
> kernel/fork.c                               |  2 +-
> mm/debug.c                                  |  3 +-
> 12 files changed, 57 insertions(+), 185 deletions(-)
>
>-- 
>2.16.4
>
