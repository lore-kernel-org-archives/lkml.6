Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D2AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B4020866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B4020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405128AbeKVToY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:44:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:36596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731655AbeKVToY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:44:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50B13AD5D;
        Thu, 22 Nov 2018 09:05:48 +0000 (UTC)
Date:   Thu, 22 Nov 2018 10:05:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a
 locked page
Message-ID: <20181122090547.GD18011@dhcp22.suse.cz>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-4-mhocko@kernel.org>
 <alpine.LSU.2.11.1811201721470.2061@eggly.anvils>
 <20181121071132.GD12932@dhcp22.suse.cz>
 <alpine.LSU.2.11.1811211757070.5557@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1811211757070.5557@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-11-18 18:27:11, Hugh Dickins wrote:
> On Wed, 21 Nov 2018, Michal Hocko wrote:
> > On Tue 20-11-18 17:47:21, Hugh Dickins wrote:
> > > On Tue, 20 Nov 2018, Michal Hocko wrote:
> > > 
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > filemap_map_pages takes a speculative reference to each page in the
> > > > range before it tries to lock that page. While this is correct it
> > > > also can influence page migration which will bail out when seeing
> > > > an elevated reference count. The faultaround code would bail on
> > > > seeing a locked page so we can pro-actively check the PageLocked
> > > > bit before page_cache_get_speculative and prevent from pointless
> > > > reference count churn.
> > > > 
> > > > Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> > > > Suggested-by: Jan Kara <jack@suse.cz>
> > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > 
> > > Acked-by: Hugh Dickins <hughd@google.com>
> > 
> > Thanks!
> > 
> > > though I think this patch is more useful to the avoid atomic ops,
> > > and unnecessary dirtying of the cacheline, than to avoid the very
> > > transient elevation of refcount, which will not affect page migration
> > > very much.
> > 
> > Are you sure it would really be transient? In other words is it possible
> > that the fault around can block migration repeatedly under refault heavy
> > workload? I just couldn't convince myself, to be honest.
> 
> I don't deny that it is possible: I expect that, using fork() (which does
> not copy the ptes in a shared file vma), you can construct a test case
> where each child faults one or another page near a page of no interest,
> and that page of no interest is a target of migration perpetually
> frustrated by filemap_map_pages()'s briefly raised refcount.

The other issue I am debugging and which very likely has the same
underlying issue in the end has shown
[  883.930477] rac1 kernel: page:ffffea2084bf5cc0 count:1889 mapcount:1887 mapping:ffff8833c82c9ad8 index:0x6b
[  883.930485] rac1 kernel: ext4_da_aops [ext4]
[  883.930497] rac1 kernel: name:"libc-2.22.so"
[  883.931241] rac1 kernel: do_migrate_range done ret=23

pattern. After we have disabled the faultaround the failure has moved to
a different page but libc hasn't shown up again. This might be a matter
of (bad)luck and timing. But we thought that it is not too unlikely for
faultaround on such a shared page to strike in.

> But I suggest that's a third-order effect: well worth fixing because
> it's easily and uncontroversially dealt with, as you have; but not of
> great importance.
> 
> The first-order effect is migration conspiring to defeat itself: that's
> what my put_and_wait_on_page_locked() patch, in other thread, is about.

yes. That is obviously a much more effective fix.

> The second order effect is when a page that is really wanted is waited
> on - the target of a fault, for which page refcount is raised maybe
> long before it finally gets into the page table (whereupon it becomes
> visible to try_to_unmap(), and its mapcount matches refcount so that
> migration can fully account for the page).  One class of that can be
> well dealt with by using put_and_wait_on_page_locked_killable() in
> lock_page_or_retry(), but I was keeping that as a future instalment.
> 
> But I shouldn't denigrate the transient case by referring so lightly
> to migrate_pages()' 10 attempts: each of those failed attempts can
> be very expensive, unmapping and TLB flushing (including IPIs) and
> remapping. It may well be that 2 or 3 would be a more cost-effective
> number of attempts, at least when the page is mapped.

If you want some update to the comment in this function or to the
changelog, I am open of course. Right now I have
+                * Check for a locked page first, as a speculative
+                * reference may adversely influence page migration.
as suggested by William.
-- 
Michal Hocko
SUSE Labs
