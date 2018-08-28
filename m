Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E98C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6C820891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6C820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH1T3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:29:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeH1T3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E90EB4023ECC;
        Tue, 28 Aug 2018 15:37:01 +0000 (UTC)
Received: from redhat.com (ovpn-125-14.rdu2.redhat.com [10.10.125.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD0122026D6B;
        Tue, 28 Aug 2018 15:37:00 +0000 (UTC)
Date:   Tue, 28 Aug 2018 11:36:59 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Zi Yan <zi.yan@cs.rutgers.edu>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 4/7] mm/hmm: properly handle migration pmd
Message-ID: <20180828153658.GA4029@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
 <20180824192549.30844-5-jglisse@redhat.com>
 <0560A126-680A-4BAE-8303-F1AB34BE4BA5@cs.rutgers.edu>
 <20180828152414.GQ10223@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180828152414.GQ10223@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 28 Aug 2018 15:37:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 28 Aug 2018 15:37:02 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 05:24:14PM +0200, Michal Hocko wrote:
> On Fri 24-08-18 20:05:46, Zi Yan wrote:
> [...]
> > > +	if (!pmd_present(pmd)) {
> > > +		swp_entry_t entry = pmd_to_swp_entry(pmd);
> > > +
> > > +		if (is_migration_entry(entry)) {
> > 
> > I think you should check thp_migration_supported() here, since PMD migration is only enabled in x86_64 systems.
> > Other architectures should treat PMD migration entries as bad.
> 
> How can we have a migration pmd entry when the migration is not
> supported?

Not sure i follow here, migration can happen anywhere (assuming
that something like compaction is active or numa or ...). So this
code can face pmd migration entry on architecture that support
it. What is missing here is thp_migration_supported() call to
protect the is_migration_entry() to avoid false positive on arch
which do not support thp migration.

Cheers,
Jérôme
