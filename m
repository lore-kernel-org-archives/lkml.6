Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeA3S3u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:29:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:43089 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752023AbeA3S3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:29:49 -0500
Date: Tue, 30 Jan 2018 19:29:47 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Memory hotplug not increasing the total RAM
Message-ID: <20180130182947.GK21609@dhcp22.suse.cz>
References: <20180130083006.GB1245@in.ibm.com>
 <20180130091600.GA26445@dhcp22.suse.cz>
 <20180130092815.GR21609@dhcp22.suse.cz>
 <20180130095345.GC1245@in.ibm.com>
 <20180130101141.GW21609@dhcp22.suse.cz>
 <CAOAebxvAwuQfAErNJa2fwdWCe+yToCLn-vr0+SuyUcdb5corAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOAebxvAwuQfAErNJa2fwdWCe+yToCLn-vr0+SuyUcdb5corAw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-01-18 13:11:06, Pavel Tatashin wrote:
> Hi Michal,
> 
> Thank you for taking care of the problem. The patch may introduce a
> small performance regression during normal boot, as we add a branch
> into a hot initialization path. But, it fixes a current problem, so:
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Thanks!

> However, I think we should change the hotplug code to also not to
> touch the map area until struct pages are initialized.
> 
> Currently, we loop through "struct page"s several times during memory hotplug:
> 
> 1. memset(0) in sparse_add_one_section()
> 2. loop in __add_section() to set do: set_page_node(page, nid); and
> SetPageReserved(page);
> 3. loop in pages_correctly_reserved() to check that SetPageReserved is set.
> 4. loop in memmap_init_zone() to call __init_single_pfn()

You might be very well correct but the hotplug code is quite subtle and
we do depend on PageReserved at some unexpected places so it is not that
easy I am afraid. My TODO list in the hotplug is quite long. If you feel
like you want to work on that I would be more than happy.
-- 
Michal Hocko
SUSE Labs
