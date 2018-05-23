Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933212AbeEWOGK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:06:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:60404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932942AbeEWOGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:06:07 -0400
Date: Wed, 23 May 2018 16:06:02 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@techadventures.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: do not warn on offline nodes unless the specific
 node is explicitly requested
Message-ID: <20180523140601.GQ20441@dhcp22.suse.cz>
References: <20180523125555.30039-1-mhocko@kernel.org>
 <20180523125555.30039-3-mhocko@kernel.org>
 <11e26a4e-552e-b1dc-316e-ce3e92973556@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e26a4e-552e-b1dc-316e-ce3e92973556@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-05-18 19:15:51, Anshuman Khandual wrote:
> On 05/23/2018 06:25 PM, Michal Hocko wrote:
> > when adding memory to a node that is currently offline.
> > 
> > The VM_WARN_ON is just too loud without a good reason. In this
> > particular case we are doing
> > 	alloc_pages_node(node, GFP_KERNEL|__GFP_RETRY_MAYFAIL|__GFP_NOWARN, order)
> > 
> > so we do not insist on allocating from the given node (it is more a
> > hint) so we can fall back to any other populated node and moreover we
> > explicitly ask to not warn for the allocation failure.
> > 
> > Soften the warning only to cases when somebody asks for the given node
> > explicitly by __GFP_THISNODE.
> 
> node hint passed here eventually goes into __alloc_pages_nodemask()
> function which then picks up the applicable zonelist irrespective of
> the GFP flag __GFP_THISNODE.

__GFP_THISNODE should enforce the given node without any fallbacks
unless something has changed recently.

> Though we can go into zones of other
> nodes if the present node (whose zonelist got picked up) does not
> have any memory in it's zones. So warning here might not be without
> any reason.

I am not sure I follow. Are you suggesting a different VM_WARN_ON?
-- 
Michal Hocko
SUSE Labs
