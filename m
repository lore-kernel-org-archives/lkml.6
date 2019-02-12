Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05166C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3A2222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfBLUeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:34:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfBLUeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:34:11 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 72BA5E132;
        Tue, 12 Feb 2019 20:34:10 +0000 (UTC)
Date:   Tue, 12 Feb 2019 12:34:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guroan@gmail.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2 0/3] vmalloc enhancements
Message-Id: <20190212123409.7ed5c34d68466dbd8b7013a3@linux-foundation.org>
In-Reply-To: <20190212184724.GA18339@cmpxchg.org>
References: <20190212175648.28738-1-guro@fb.com>
        <20190212184724.GA18339@cmpxchg.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 13:47:24 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Tue, Feb 12, 2019 at 09:56:45AM -0800, Roman Gushchin wrote:
> > The patchset contains few changes to the vmalloc code, which are
> > leading to some performance gains and code simplification.
> > 
> > Also, it exports a number of pages, used by vmalloc(),
> > in /proc/meminfo.
> > 
> > Patch (1) removes some redundancy on __vunmap().
> > Patch (2) separates memory allocation and data initialization
> >   in alloc_vmap_area()
> > Patch (3) adds vmalloc counter to /proc/meminfo.
> > 
> > v2->v1:
> >   - rebased on top of current mm tree
> >   - switch from atomic to percpu vmalloc page counter
> 
> I don't understand what prompted this change to percpu counters.
> 
> All writers already write vmap_area_lock and vmap_area_list, so it's
> not really saving much. The for_each_possible_cpu() for /proc/meminfo
> on the other hand is troublesome.

percpu_counters would fit here.  They have probably-unneeded locking
but I expect that will be acceptable.

And they address the issues with for_each_possible_cpu() avoidance, CPU
hotplug and transient negative values.
