Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFF5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005BA213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005BA213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeJCNu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:50:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbeJCNu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:50:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6735FAFF6;
        Wed,  3 Oct 2018 07:03:23 +0000 (UTC)
Date:   Wed, 3 Oct 2018 09:03:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc:     Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Malaterre <malat@debian.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
Message-ID: <20181003070320.GE18290@dhcp22.suse.cz>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001202724.GL18290@dhcp22.suse.cz>
 <bdbca329-7d35-0535-1737-94a06a19ae28@linux.vnet.ibm.com>
 <df95f828-1963-d8b9-ab58-6d29d2d152d2@linux.vnet.ibm.com>
 <20181002145922.GZ18290@dhcp22.suse.cz>
 <d338b385-626b-0e79-9944-708178fe245d@linux.vnet.ibm.com>
 <20181002160446.GA18290@dhcp22.suse.cz>
 <e7dd66c1-d196-3a14-0115-acdaf538ebfd@linux.vnet.ibm.com>
 <bbc5f219-614f-b024-0888-8ad216c5eaf8@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc5f219-614f-b024-0888-8ad216c5eaf8@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-10-18 12:45:50, Tyrel Datwyler wrote:
> On 10/02/2018 11:13 AM, Michael Bringmann wrote:
> > 
> > 
> > On 10/02/2018 11:04 AM, Michal Hocko wrote:
> >> On Tue 02-10-18 10:14:49, Michael Bringmann wrote:
> >>> On 10/02/2018 09:59 AM, Michal Hocko wrote:
> >>>> On Tue 02-10-18 09:51:40, Michael Bringmann wrote:
> >>>> [...]
> >>>>> When the device-tree affinity attributes have changed for memory,
> >>>>> the 'nid' affinity calculated points to a different node for the
> >>>>> memory block than the one used to install it, previously on the
> >>>>> source system.  The newly calculated 'nid' affinity may not yet
> >>>>> be initialized on the target system.  The current memory tracking
> >>>>> mechanisms do not record the node to which a memory block was
> >>>>> associated when it was added.  Nathan is looking at adding this
> >>>>> feature to the new implementation of LMBs, but it is not there
> >>>>> yet, and won't be present in earlier kernels without backporting a
> >>>>> significant number of changes.
> >>>>
> >>>> Then the patch you have proposed here just papers over a real issue, no?
> >>>> IIUC then you simply do not remove the memory if you lose the race.
> >>>
> >>> The problem occurs when removing memory after an affinity change
> >>> references a node that was previously unreferenced.  Other code
> >>> in 'kernel/mm/memory_hotplug.c' deals with initializing an empty
> >>> node when adding memory to a system.  The 'removing memory' case is
> >>> specific to systems that perform LPM and allow device-tree changes.
> >>> The powerpc kernel does not have the option of accepting some PRRN
> >>> requests and accepting others.  It must perform them all.
> >>
> >> I am sorry, but you are still too cryptic for me. Either there is a
> >> correctness issue and the the patch doesn't really fix anything or the
> >> final race doesn't make any difference and then the ppc code should be
> >> explicit about that. Checking the node inside the hotplug core code just
> >> looks as a wrong layer to mitigate an arch specific problem. I am not
> >> saying the patch is a no-go but if anything we want a big fat comment
> >> explaining how this is possible because right now it just points to an
> >> incorrect API usage.
> >>
> >> That being said, this sounds pretty much ppc specific problem and I
> >> would _prefer_ it to be handled there (along with a big fat comment of
> >> course).
> > 
> > Let me try again.  Regardless of the path to which we get to this condition,
> > we currently crash the kernel.  This patch changes that to a WARN_ON notice
> > and continues executing the kernel without shutting down the system.  I saw
> > the problem during powerpc testing, because that is the focus of my work.
> > There are other paths to this function besides powerpc.  I feel that the
> > kernel should keep running instead of halting.
> 
> This is still basically a hack to get around a known race. In itself
> this patch is still worth while in that we shouldn't crash the kernel
> on a null pointer dereference. However, I think the actual problem
> still needs to be addressed. We shouldn't run any PRRN events for the
> source system on the target after a migration. The device tree update
> should have taken care of telling us about new affinities and what
> not. Can we just throw out any queued PRRN events when we wake up on
> the target?

And until a proper fix is developed can we have NODE_DATA test in the
affected code rather than pollute the generic code with something that
is essentially a wrong usage of the API? With a big fat warning
explaining what is going on here?
-- 
Michal Hocko
SUSE Labs
