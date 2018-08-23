Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27604C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD13520B6F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD13520B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeHWKyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:54:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:46438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbeHWKyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:54:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBC15AEA8;
        Thu, 23 Aug 2018 07:25:43 +0000 (UTC)
Date:   Thu, 23 Aug 2018 09:25:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Haren Myneni <haren@linux.vnet.ibm.com>,
        n-horiguchi@ah.jp.nec.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
        mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
Message-ID: <20180823072543.GS29735@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
 <87bm9ug34l.fsf@linux.ibm.com>
 <54c72a22-a921-fc64-460d-f66985d0df4e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c72a22-a921-fc64-460d-f66985d0df4e@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-08-18 11:58:02, Mike Kravetz wrote:
> On 08/22/2018 02:30 AM, Aneesh Kumar K.V wrote:
[...]
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 4eb6e824a80c..f9bdea685cf4 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
> >  				return pfn;
> >  			if (__PageMovable(page))
> >  				return pfn;
> > -			if (PageHuge(page)) {
> > +			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
> > +			    PageHuge(page)) {
> 
> How about using hugepage_migration_supported instead?  It would automatically
> catch those non-migratable huge page sizes.  Something like:
> 
> 			if (PageHuge(page) &&
> 			    hugepage_migration_supported(page_hstate(page))) {

Ohh, definitely, this is much better.
-- 
Michal Hocko
SUSE Labs
