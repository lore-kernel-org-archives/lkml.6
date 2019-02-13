Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD125C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B74320643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550062814;
	bh=LRVLkxAjv1r1lcLiGCzOaHJAcZcS0/T/sk0X9EJIRhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GTpTRmo2B2THC4jWlU3JWsPAynTNW38I9hSwrs24QoRrzQ33kO4YrxC+Jzq5Srf8x
	 mkOv364GfLMrQPWQkFMnGx0dfVqHDAVpGpzBP6foUO6AeZOOctgLKEUPEEyPAe0RIy
	 p9CCKQnhzDgAwmgcHif4yFNIRDp1WryZi9/SjLfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbfBMNAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:00:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:35452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730451AbfBMNAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:00:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A7CEAEC5;
        Wed, 13 Feb 2019 13:00:11 +0000 (UTC)
Date:   Wed, 13 Feb 2019 14:00:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix potential build error in compaction.h
Message-ID: <20190213130010.GJ4525@dhcp22.suse.cz>
References: <20190208080437.253322-1-yuzhao@google.com>
 <20190212120358.GC7584@dhcp22.suse.cz>
 <20190212233858.GA95899@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212233858.GA95899@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-02-19 16:38:58, Yu Zhao wrote:
> On Tue, Feb 12, 2019 at 01:03:58PM +0100, Michal Hocko wrote:
> > On Fri 08-02-19 01:04:37, Yu Zhao wrote:
> > > Declaration of struct node is required regardless. On UMA system,
> > > including compaction.h without proceeding node.h shouldn't cause
> > > build error.
> > 
> > Anybody requiring struct node shouldn't depend on compaction.h to get
> > the declaration.
> 
> Yes, but the problem is the other way around. Build error happens
> when somebody includes compaction.h without definition or
> declaration of struct node, if CONFIG_NUMA is not set.
> 
> compaction.h already has struct node declaration to avoid the error
> when CONFIG_NUMA is set, but we need it for both cases.
> 
> > Anyway have you seen an actual build breakage?
> 
> Yes. I ran into the problem while trying to include compaction.h
> in this order, and had to move it to the bottom as a workaround.
> 
> #include <linux/backing-dev.h>
> #include <linux/compaction.h>
> #include <linux/ctype.h>
> #include <linux/freezer.h>
> #include <linux/hugetlb.h>
> #include <linux/kstaled.h>
> #include <linux/kthread.h>
> #include <linux/mm_inline.h>
> #include <linux/mm_types.h>
> #include <linux/module.h>
> #include <linux/pagemap.h>
> #include <linux/sched/task_stack.h>
> #include <linux/swap.h>

OK, fair enough. A subtle header file ordering dependencies are PITA.

Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
