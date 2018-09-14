Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9559CC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B6A20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B6A20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeINLJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:09:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726831AbeINLJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:09:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50B61AD14;
        Fri, 14 Sep 2018 05:56:39 +0000 (UTC)
Date:   Fri, 14 Sep 2018 07:56:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "prakash.sangappa" <prakash.sangappa@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com, steven.sistare@oracle.com
Subject: Re: [PATCH V2 0/6] VA to numa node information
Message-ID: <20180914055637.GH20287@dhcp22.suse.cz>
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
 <20180913084011.GC20287@dhcp22.suse.cz>
 <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-09-18 15:32:25, prakash.sangappa wrote:
> 
> 
> On 09/13/2018 01:40 AM, Michal Hocko wrote:
> > On Wed 12-09-18 13:23:58, Prakash Sangappa wrote:
> > > For analysis purpose it is useful to have numa node information
> > > corresponding mapped virtual address ranges of a process. Currently,
> > > the file /proc/<pid>/numa_maps provides list of numa nodes from where pages
> > > are allocated per VMA of a process. This is not useful if an user needs to
> > > determine which numa node the mapped pages are allocated from for a
> > > particular address range. It would have helped if the numa node information
> > > presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
> > > exact numa node from where the pages have been allocated.
> > > 
> > > The format of /proc/<pid>/numa_maps file content is dependent on
> > > /proc/<pid>/maps file content as mentioned in the manpage. i.e one line
> > > entry for every VMA corresponding to entries in /proc/<pids>/maps file.
> > > Therefore changing the output of /proc/<pid>/numa_maps may not be possible.
> > > 
> > > This patch set introduces the file /proc/<pid>/numa_vamaps which
> > > will provide proper break down of VA ranges by numa node id from where the
> > > mapped pages are allocated. For Address ranges not having any pages mapped,
> > > a '-' is printed instead of numa node id.
> > > 
> > > Includes support to lseek, allowing seeking to a specific process Virtual
> > > address(VA) starting from where the address range to numa node information
> > > can to be read from this file.
> > > 
> > > The new file /proc/<pid>/numa_vamaps will be governed by ptrace access
> > > mode PTRACE_MODE_READ_REALCREDS.
> > > 
> > > See following for previous discussion about this proposal
> > > 
> > > https://marc.info/?t=152524073400001&r=1&w=2
> > It would be really great to give a short summary of the previous
> > discussion. E.g. why do we need a proc interface in the first place when
> > we already have an API to query for the information you are proposing to
> > export [1]
> > 
> > [1] http://lkml.kernel.org/r/20180503085741.GD4535@dhcp22.suse.cz
> 
> The proc interface provides an efficient way to export address range
> to numa node id mapping information compared to using the API.

Do you have any numbers?

> For example, for sparsely populated mappings, if a VMA has large portions
> not have any physical pages mapped, the page walk done thru the /proc file
> interface can skip over non existent PMDs / ptes. Whereas using the
> API the application would have to scan the entire VMA in page size units.

What prevents you from pre-filtering by reading /proc/$pid/maps to get
ranges of interest?

> Also, VMAs having THP pages can have a mix of 4k pages and hugepages.
> The page walks would be efficient in scanning and determining if it is
> a THP huge page and step over it. Whereas using the API, the application
> would not know what page size mapping is used for a given VA and so would
> have to again scan the VMA in units of 4k page size.

Why does this matter for something that is for analysis purposes.
Reading the file for the whole address space is far from a free
operation. Is the page walk optimization really essential for usability?
Moreover what prevents move_pages implementation to be clever for the
page walk itself? In other words why would we want to add a new API
rather than make the existing one faster for everybody.
 
> If this sounds reasonable, I can add it to the commit / patch description.

This all is absolutely _essential_ for any new API proposed. Remember that
once we add a new user interface, we have to maintain it for ever. We
used to be too relaxed when adding new proc files in the past and it
backfired many times already.
-- 
Michal Hocko
SUSE Labs
