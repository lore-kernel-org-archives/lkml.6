Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0920894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B0920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeH1T61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:58:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeH1T61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:58:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74665401EF0A;
        Tue, 28 Aug 2018 16:06:05 +0000 (UTC)
Received: from redhat.com (ovpn-125-14.rdu2.redhat.com [10.10.125.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA20A2166B41;
        Tue, 28 Aug 2018 16:06:04 +0000 (UTC)
Date:   Tue, 28 Aug 2018 12:06:03 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Zi Yan <zi.yan@cs.rutgers.edu>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 4/7] mm/hmm: properly handle migration pmd
Message-ID: <20180828160602.GB4029@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
 <20180824192549.30844-5-jglisse@redhat.com>
 <0560A126-680A-4BAE-8303-F1AB34BE4BA5@cs.rutgers.edu>
 <20180828152414.GQ10223@dhcp22.suse.cz>
 <20180828153658.GA4029@redhat.com>
 <20180828154206.GR10223@dhcp22.suse.cz>
 <20180828154555.GS10223@dhcp22.suse.cz>
 <44C89854-FE83-492F-B6BB-CF54B77233CF@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44C89854-FE83-492F-B6BB-CF54B77233CF@cs.rutgers.edu>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 28 Aug 2018 16:06:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 28 Aug 2018 16:06:05 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 11:54:33AM -0400, Zi Yan wrote:
> Hi Michal,
> 
> On 28 Aug 2018, at 11:45, Michal Hocko wrote:
> 
> > On Tue 28-08-18 17:42:06, Michal Hocko wrote:
> >> On Tue 28-08-18 11:36:59, Jerome Glisse wrote:
> >>> On Tue, Aug 28, 2018 at 05:24:14PM +0200, Michal Hocko wrote:
> >>>> On Fri 24-08-18 20:05:46, Zi Yan wrote:
> >>>> [...]
> >>>>>> +	if (!pmd_present(pmd)) {
> >>>>>> +		swp_entry_t entry = pmd_to_swp_entry(pmd);
> >>>>>> +
> >>>>>> +		if (is_migration_entry(entry)) {
> >>>>>
> >>>>> I think you should check thp_migration_supported() here, since PMD migration is only enabled in x86_64 systems.
> >>>>> Other architectures should treat PMD migration entries as bad.
> >>>>
> >>>> How can we have a migration pmd entry when the migration is not
> >>>> supported?
> >>>
> >>> Not sure i follow here, migration can happen anywhere (assuming
> >>> that something like compaction is active or numa or ...). So this
> >>> code can face pmd migration entry on architecture that support
> >>> it. What is missing here is thp_migration_supported() call to
> >>> protect the is_migration_entry() to avoid false positive on arch
> >>> which do not support thp migration.
> >>
> >> I mean that architectures which do not support THP migration shouldn't
> >> ever see any migration entry. So is_migration_entry should be always
> >> false. Or do I miss something?
> >
> > And just to be clear. thp_migration_supported should be checked only
> > when we actually _do_ the migration or evaluate migratability of the
> > page. We definitely do want to sprinkle this check to all places where
> > is_migration_entry is checked.
> 
> is_migration_entry() is a general check for swp_entry_t, so it can return
> true even if THP migration is not enabled. is_pmd_migration_entry() always
> returns false when THP migration is not enabled.
> 
> So the code can be changed in two ways, either replacing is_migration_entry()
> with is_pmd_migration_entry() or adding thp_migration_supported() check
> like Jerome did.
> 
> Does this clarify your question?
> 

Well looking back at code is_migration_entry() will return false on arch
which do not have thp migration because pmd_to_swp_entry() will return
swp_entry(0,0) which is can not be a valid migration entry.

Maybe using is_pmd_migration_entry() would be better here ? It seems
that is_pmd_migration_entry() is more common then the open coded
thp_migration_supported() && is_migration_entry()

Cheers,
Jérôme
