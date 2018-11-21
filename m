Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD2CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B05F2148E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B05F2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeKURox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:44:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:58608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbeKURox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:44:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5845ACB4;
        Wed, 21 Nov 2018 07:11:33 +0000 (UTC)
Date:   Wed, 21 Nov 2018 08:11:32 +0100
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
Message-ID: <20181121071132.GD12932@dhcp22.suse.cz>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-4-mhocko@kernel.org>
 <alpine.LSU.2.11.1811201721470.2061@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1811201721470.2061@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 17:47:21, Hugh Dickins wrote:
> On Tue, 20 Nov 2018, Michal Hocko wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > filemap_map_pages takes a speculative reference to each page in the
> > range before it tries to lock that page. While this is correct it
> > also can influence page migration which will bail out when seeing
> > an elevated reference count. The faultaround code would bail on
> > seeing a locked page so we can pro-actively check the PageLocked
> > bit before page_cache_get_speculative and prevent from pointless
> > reference count churn.
> > 
> > Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Acked-by: Hugh Dickins <hughd@google.com>

Thanks!

> though I think this patch is more useful to the avoid atomic ops,
> and unnecessary dirtying of the cacheline, than to avoid the very
> transient elevation of refcount, which will not affect page migration
> very much.

Are you sure it would really be transient? In other words is it possible
that the fault around can block migration repeatedly under refault heavy
workload? I just couldn't convince myself, to be honest.
-- 
Michal Hocko
SUSE Labs
