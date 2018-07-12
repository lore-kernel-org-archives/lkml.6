Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B691DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B6F21479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B6F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbeGLIXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:23:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727016AbeGLIXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:23:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D60A1AE61;
        Thu, 12 Jul 2018 08:15:24 +0000 (UTC)
Date:   Thu, 12 Jul 2018 10:15:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, kirill@shutemov.name,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for
 large mapping
Message-ID: <20180712081524.GE32648@dhcp22.suse.cz>
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180711103312.GH20050@dhcp22.suse.cz>
 <20180711154954.afe001e284574cd5d4c3ec89@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711154954.afe001e284574cd5d4c3ec89@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 15:49:54, Andrew Morton wrote:
> On Wed, 11 Jul 2018 12:33:12 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > Approach:
> > > Zapping pages is the most time consuming part, according to the suggestion from
> > > Michal Hocko [1], zapping pages can be done with holding read mmap_sem, like
> > > what MADV_DONTNEED does. Then re-acquire write mmap_sem to cleanup vmas.
> > > 
> > > But, we can't call MADV_DONTNEED directly, since there are two major drawbacks:
> > >   * The unexpected state from PF if it wins the race in the middle of munmap.
> > >     It may return zero page, instead of the content or SIGSEGV.
> > >   * Can’t handle VM_LOCKED | VM_HUGETLB | VM_PFNMAP and uprobe mappings, which
> > >     is a showstopper from akpm
> > 
> > I do not really understand why this is a showstopper. This is a mere
> > optimization. VM_LOCKED ranges are usually not that large. VM_HUGETLB
> > can be quite large alright but this should be doable on top. Is there
> > any reason to block any "cover most mappings first" patch?
> 
> Somebody somewhere is going to want to unmap vast mlocked regions and
> they're going to report softlockup warnings. So we shouldn't implement
> something which can't address these cases.  Maybe it doesn't do so in
> the first version, but we should at least have a plan to handle all
> cases.

Absolutely. I was just responding to the "showstopper" part. This is
improving some cases but it shouldn't make others worse so going
incremental should be perfectly reasonable.
-- 
Michal Hocko
SUSE Labs
