Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859AFC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A6B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A6B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeKUAla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:41:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:58638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbeKUAl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:41:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6043AB082;
        Tue, 20 Nov 2018 14:12:08 +0000 (UTC)
Date:   Tue, 20 Nov 2018 15:12:07 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a
 locked page
Message-ID: <20181120141207.GK22247@dhcp22.suse.cz>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-4-mhocko@kernel.org>
 <20181120140715.mouc7okin3ht5krr@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120140715.mouc7okin3ht5krr@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 17:07:15, Kirill A. Shutemov wrote:
> On Tue, Nov 20, 2018 at 02:43:23PM +0100, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > filemap_map_pages takes a speculative reference to each page in the
> > range before it tries to lock that page. While this is correct it
> > also can influence page migration which will bail out when seeing
> > an elevated reference count. The faultaround code would bail on
> > seeing a locked page so we can pro-actively check the PageLocked
> > bit before page_cache_get_speculative and prevent from pointless
> > reference count churn.
> 
> Looks fine to me.

Thanks for the review.

> But please drop a line of comment in the code. As is it might be confusing
> for a reader.

This?

diff --git a/mm/filemap.c b/mm/filemap.c
index c76d6a251770..7c4e439a2e85 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2554,6 +2554,10 @@ void filemap_map_pages(struct vm_fault *vmf,
 
 		head = compound_head(page);
 
+		/*
+		 * Check the locked pages before taking a reference to not
+		 * go in the way of migration.
+		 */
 		if (PageLocked(head))
 			goto next;
 		if (!page_cache_get_speculative(head))
-- 
Michal Hocko
SUSE Labs
