Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D418C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4002821904
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497809;
	bh=AJOlNYZ8AAG4w61NNZTcFxOPcWEMZgii3xi3QLbfXdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UMaMfkJ//8e3boUCKWzKZCflDhYisrFEgKM5Ldeo4R1iOz+i/lM1tzotQQkNQ3hdh
	 HBcx/Juz/VyI60xItjxYzrSY1ci8vekIcm0EkptVmO+pmgGHjBudssl1O90VVixih4
	 jJknARKpWBeQl+cKmA9JkyuDVqR5UDwOm1skUGoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfBRNuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:50:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:46130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731440AbfBRNuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:50:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63490B015;
        Mon, 18 Feb 2019 13:50:03 +0000 (UTC)
Date:   Mon, 18 Feb 2019 14:50:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Lars Persson <lists@bofh.nu>
Cc:     Jan Stancek <jstancek@redhat.com>, linux-mm@kvack.org,
        lersek@redhat.com, alex williamson <alex.williamson@redhat.com>,
        aarcange@redhat.com, rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: page_mapped: don't assume compound page is huge
 or THP
Message-ID: <20190218135002.GR4525@dhcp22.suse.cz>
References: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
 <c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com>
 <CADnJP=vsum7_YYWBpknpahTQFAzm7G40_E2dLMB_poFEhPKEfw@mail.gmail.com>
 <997509746.100933786.1549350874925.JavaMail.zimbra@redhat.com>
 <CADnJP=t25=AcVq7z3w8iG1+ywnSNN4Vbow3-7tOai+qnyD5ACQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnJP=t25=AcVq7z3w8iG1+ywnSNN4Vbow3-7tOai+qnyD5ACQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-02-19 14:43:58, Lars Persson wrote:
> On Tue, Feb 5, 2019 at 8:14 AM Jan Stancek <jstancek@redhat.com> wrote:
> > Hi,
> >
> > are you using THP (CONFIG_TRANSPARENT_HUGEPAGE)?
> >
> > The changed line should affect only THP and normal compound pages,
> > so a test with THP disabled might be interesting.
> >
> > >
> > > The breakage consists of random processes dying with SIGILL or SIGSEGV
> > > when we stress test the system with high memory pressure and explicit
> > > memory compaction requested through /proc/sys/vm/compact_memory.
> > > Reverting this patch fixes the crashes.
> > >
> > > We can put some effort on debugging if there are no obvious
> > > explanations for this. Keep in mind that this is 32-bit system with
> > > HIGHMEM.
> >
> > Nothing obvious that I can see. I've been trying to reproduce on
> > 32-bit x86 Fedora with no luck so far.
> >
> 
> Hi
> 
> Thanks for looking in to it. After some deep dive in MM code, I think
> it is safe to say this patch was innocent.
> 
> All traces studied so far points to a missing cache coherency call in
> mm/migrate.c:migrate_page that is needed only for those evil MIPSes
> that lack I/D cache coherency. I will send a write-up to linux-mips
> about this. Basically for a non-mapped page it does only a copy of
> page data and metadata but no flush_dcache_page() call will be done.
> This races with subsequent use of the page.

Please make sure to cc linux-mm for the patch
-- 
Michal Hocko
SUSE Labs
