Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4ACFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E55D20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E55D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeINLee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:34:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbeINLee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:34:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6D6FAE4A;
        Fri, 14 Sep 2018 06:21:35 +0000 (UTC)
Date:   Fri, 14 Sep 2018 08:21:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Prakash Sangappa <prakash.sangappa@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com,
        nao.horiguchi@gmail.com, steven.sistare@oracle.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
Message-ID: <20180914062132.GI20287@dhcp22.suse.cz>
References: <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
 <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com>
 <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com>
 <8569dabb-4930-aa20-6249-72457e2df51e@intel.com>
 <51145ccb-fc0d-0281-9757-fb8a5112ec24@oracle.com>
 <c72fea44-59f3-b106-8311-b5eae2d254e7@intel.com>
 <addeaadc-5ab2-f0c9-2194-dd100ae90f3a@oracle.com>
 <aaca3180-7510-c008-3e12-8bbe92344ef4@intel.com>
 <94ee0b6c-4663-0705-d4a8-c50342f6b483@oracle.com>
 <CAG48ez1YhHKTDHZoH2tEFaLk4LcCSw5G60=+KpGRaMQxvw1qLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1YhHKTDHZoH2tEFaLk4LcCSw5G60=+KpGRaMQxvw1qLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-09-18 03:33:28, Jann Horn wrote:
> On Wed, Sep 12, 2018 at 10:43 PM prakash.sangappa
> <prakash.sangappa@oracle.com> wrote:
> > On 05/09/2018 04:31 PM, Dave Hansen wrote:
> > > On 05/07/2018 06:16 PM, prakash.sangappa wrote:
> > >> It will be /proc/<pid>/numa_vamaps. Yes, the behavior will be
> > >> different with respect to seeking. Output will still be text and
> > >> the format will be same.
> > >>
> > >> I want to get feedback on this approach.
> > > I think it would be really great if you can write down a list of the
> > > things you actually want to accomplish.  Dare I say: you need a
> > > requirements list.
> > >
> > > The numa_vamaps approach continues down the path of an ever-growing list
> > > of highly-specialized /proc/<pid> files.  I don't think that is
> > > sustainable, even if it has been our trajectory for many years.
> > >
> > > Pagemap wasn't exactly a shining example of us getting new ABIs right,
> > > but it sounds like something along those is what we need.
> >
> > Just sent out a V2 patch.  This patch simplifies the file content. It
> > only provides VA range to numa node id information.
> >
> > The requirement is basically observability for performance analysis.
> >
> > - Need to be able to determine VA range to numa node id information.
> >    Which also gives an idea of which range has memory allocated.
> >
> > - The proc file /proc/<pid>/numa_vamaps is in text so it is easy to
> >    directly view.
> >
> > The V2 patch supports seeking to a particular process VA from where
> > the application could read the VA to  numa node id information.
> >
> > Also added the 'PTRACE_MODE_READ_REALCREDS' check when opening the
> > file /proc file as was indicated by Michal Hacko
> 
> procfs files should use PTRACE_MODE_*_FSCREDS, not PTRACE_MODE_*_REALCREDS.

Out of my curiosity, what is the semantic difference? At least
kernel_move_pages uses PTRACE_MODE_READ_REALCREDS. Is this a bug?

-- 
Michal Hocko
SUSE Labs
