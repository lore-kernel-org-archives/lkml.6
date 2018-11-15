Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2946EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7DD2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7DD2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbeKPI5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:57:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeKPI5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:57:07 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48273B6D;
        Thu, 15 Nov 2018 22:47:20 +0000 (UTC)
Date:   Thu, 15 Nov 2018 14:47:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Lameter <clameter@sgi.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 3.18 8/9] mm/vmstat.c: assert that vmstat_text
 is in sync with stat_items_size
Message-Id: <20181115144719.d26dc7a2d47fade8d41a83d5@linux-foundation.org>
In-Reply-To: <20181115223718.GB1706@sasha-vm>
References: <20181113055252.79406-1-sashal@kernel.org>
        <20181113055252.79406-8-sashal@kernel.org>
        <20181115140810.e3292c83467544f6a1d82686@linux-foundation.org>
        <20181115223718.GB1706@sasha-vm>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 17:37:18 -0500 Sasha Levin <sashal@kernel.org> wrote:

> On Thu, Nov 15, 2018 at 02:08:10PM -0800, Andrew Morton wrote:
> >On Tue, 13 Nov 2018 00:52:51 -0500 Sasha Levin <sashal@kernel.org> wrote:
> >
> >> From: Jann Horn <jannh@google.com>
> >>
> >> [ Upstream commit f0ecf25a093fc0589f0a6bc4c1ea068bbb67d220 ]
> >>
> >> Having two gigantic arrays that must manually be kept in sync, including
> >> ifdefs, isn't exactly robust.  To make it easier to catch such issues in
> >> the future, add a BUILD_BUG_ON().
> >>
> >> ...
> >>
> >> --- a/mm/vmstat.c
> >> +++ b/mm/vmstat.c
> >> @@ -1189,6 +1189,8 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
> >>  	stat_items_size += sizeof(struct vm_event_state);
> >>  #endif
> >>
> >> +	BUILD_BUG_ON(stat_items_size !=
> >> +		     ARRAY_SIZE(vmstat_text) * sizeof(unsigned long));
> >>  	v = kmalloc(stat_items_size, GFP_KERNEL);
> >>  	m->private = v;
> >>  	if (!v)
> >
> >I don't think there's any way in which this can make a -stable kernel
> >more stable!
> >
> >
> >Generally, I consider -stable in every patch I merge, so for each patch
> >which doesn't have cc:stable, that tag is missing for a reason.
> >
> >In other words, your criteria for -stable addition are different from
> >mine.
> >
> >And I think your criteria differ from those described in
> >Documentation/process/stable-kernel-rules.rst.
> >
> >So... what is your overall thinking on patch selection?
> 
> Indeed, this doesn't fix anything.
> 
> My concern is that in the future, we will pull a patch that will cause
> the issue described here, and that issue will only be relevant on
> stable. It is very hard to debug this, and I suspect that stable kernels
> will still pass all their tests with flying colors.
> 
> As an example, consider the case where commit 28e2c4bb99aa ("mm/vmstat.c:
> fix outdated vmstat_text") is backported to a kernel that doesn't have
> commit 7a9cdebdcc17 ("mm: get rid of vmacache_flush_all() entirely").
> 
> I also felt safe with this patch since it adds a single BUILD_BUG_ON()
> which does nothing during runtime, so the chances it introduces anything
> beyond a build regression seemed to be slim to none.

Well OK.  But my question was general and covers basically every
autosel patch which originated in -mm.

