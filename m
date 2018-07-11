Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DED2C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB5A20652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB5A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389690AbeGKW42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:56:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387885AbeGKW41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:56:27 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D2AACA0;
        Wed, 11 Jul 2018 22:49:55 +0000 (UTC)
Date:   Wed, 11 Jul 2018 15:49:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, kirill@shutemov.name,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for
 large mapping
Message-Id: <20180711154954.afe001e284574cd5d4c3ec89@linux-foundation.org>
In-Reply-To: <20180711103312.GH20050@dhcp22.suse.cz>
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
        <20180711103312.GH20050@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 12:33:12 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> > Approach:
> > Zapping pages is the most time consuming part, according to the suggestion from
> > Michal Hocko [1], zapping pages can be done with holding read mmap_sem, like
> > what MADV_DONTNEED does. Then re-acquire write mmap_sem to cleanup vmas.
> > 
> > But, we can't call MADV_DONTNEED directly, since there are two major drawbacks:
> >   * The unexpected state from PF if it wins the race in the middle of munmap.
> >     It may return zero page, instead of the content or SIGSEGV.
> >   * Can’t handle VM_LOCKED | VM_HUGETLB | VM_PFNMAP and uprobe mappings, which
> >     is a showstopper from akpm
> 
> I do not really understand why this is a showstopper. This is a mere
> optimization. VM_LOCKED ranges are usually not that large. VM_HUGETLB
> can be quite large alright but this should be doable on top. Is there
> any reason to block any "cover most mappings first" patch?

Somebody somewhere is going to want to unmap vast mlocked regions and
they're going to report softlockup warnings.  So we shouldn't implement
something which can't address these cases.  Maybe it doesn't do so in
the first version, but we should at least have a plan to handle all
cases.


