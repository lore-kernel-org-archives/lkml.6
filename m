Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CFBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42492089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42492089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeKSXO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:14:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728701AbeKSXO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:14:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A91CAFAD;
        Mon, 19 Nov 2018 12:51:22 +0000 (UTC)
Date:   Mon, 19 Nov 2018 13:51:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        pifang@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181119125121.GK22247@dhcp22.suse.cz>
References: <20181115075349.GL2653@MiWiFi-R3L-srv>
 <20181115083055.GD23831@dhcp22.suse.cz>
 <20181115131211.GP2653@MiWiFi-R3L-srv>
 <20181115131927.GT23831@dhcp22.suse.cz>
 <20181115133840.GR2653@MiWiFi-R3L-srv>
 <20181115143204.GV23831@dhcp22.suse.cz>
 <20181116012433.GU2653@MiWiFi-R3L-srv>
 <20181116091409.GD14706@dhcp22.suse.cz>
 <20181119105202.GE18471@MiWiFi-R3L-srv>
 <20181119124033.GJ22247@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119124033.GJ22247@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-11-18 13:40:33, Michal Hocko wrote:
> On Mon 19-11-18 18:52:02, Baoquan He wrote:
> [...]
> 
> There are few stacks directly in the offline path but those should be
> OK.
> The real culprit seems to be the swap in code
> 
> > [  +1.734416] CPU: 255 PID: 5558 Comm: stress Tainted: G             L    4.20.0-rc2+ #7
> > [  +0.007927] Hardware name:  9008/IT91SMUB, BIOS BLXSV512 03/22/2018
> > [  +0.006297] Call Trace:
> > [  +0.002537]  dump_stack+0x46/0x60
> > [  +0.003386]  __migration_entry_wait.cold.65+0x5/0x14
> > [  +0.005043]  do_swap_page+0x84e/0x960
> > [  +0.003727]  ? arch_tlb_finish_mmu+0x29/0xc0
> > [  +0.006412]  __handle_mm_fault+0x933/0x1330
> > [  +0.004265]  handle_mm_fault+0xc4/0x250
> > [  +0.003915]  __do_page_fault+0x2b7/0x510
> > [  +0.003990]  do_page_fault+0x2c/0x110
> > [  +0.003729]  ? page_fault+0x8/0x30
> > [  +0.003462]  page_fault+0x1e/0x30
> 
> There are many traces to this path. We are 
> 	/*
> 	 * Once page cache replacement of page migration started, page_count
> 	 * *must* be zero. And, we don't want to call wait_on_page_locked()
> 	 * against a page without get_page().
> 	 * So, we use get_page_unless_zero(), here. Even failed, page fault
> 	 * will occur again.
> 	 */
> 	if (!get_page_unless_zero(page))
> 		goto out;
> 	pte_unmap_unlock(ptep, ptl);
> 	wait_on_page_locked(page);
> 
> taking a reference to the page under the migration. I have to think
> about this much more but I suspec this is just calling for a problem.
> 
> Cc migration experts. For you background information. We are seeing
> memory offline not being able to converge because few heavily used pages
> fail to migrate away - e.g. http://lkml.kernel.org/r/20181116012433.GU2653@MiWiFi-R3L-srv
> A debugging page to dump stack for these pages http://lkml.kernel.org/r/20181116091409.GD14706@dhcp22.suse.cz
> shows that references are taken from the swap in code (above). How are
> we supposed to converge when the swapin code waits for the migration to
> finish with the reference count elevated?

Just to clarify. This is not only about swapin obviously. Any caller of
__migration_entry_wait is affected the same way AFAICS.
-- 
Michal Hocko
SUSE Labs
