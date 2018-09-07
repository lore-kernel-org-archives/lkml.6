Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9BAC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E309B20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E309B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeIGN1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:27:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:46976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727586AbeIGN1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:27:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29CD1AEDD;
        Fri,  7 Sep 2018 08:47:57 +0000 (UTC)
Date:   Fri, 7 Sep 2018 10:47:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Rob Herring <robh@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
        paul.burton@mips.com, Thomas Gleixner <tglx@linutronix.de>,
        tony.luck@intel.com, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 07/29] memblock: remove _virt from APIs returning
 virtual address
Message-ID: <20180907084756.GD19621@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-8-git-send-email-rppt@linux.vnet.ibm.com>
 <CABGGiswdb1x-=vqrgxZ9i2dnLdsgtXq4+5H9Y1JRd90YVMW69A@mail.gmail.com>
 <20180905172017.GA2203@rapoport-lnx>
 <20180906072800.GN14951@dhcp22.suse.cz>
 <20180906124321.GD27492@rapoport-lnx>
 <20180906130102.GY14951@dhcp22.suse.cz>
 <20180906133958.GM27492@rapoport-lnx>
 <20180906134627.GZ14951@dhcp22.suse.cz>
 <20180907084211.GA19153@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907084211.GA19153@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-09-18 11:42:12, Mike Rapoport wrote:
> On Thu, Sep 06, 2018 at 03:46:27PM +0200, Michal Hocko wrote:
> > On Thu 06-09-18 16:39:58, Mike Rapoport wrote:
> > > On Thu, Sep 06, 2018 at 03:01:02PM +0200, Michal Hocko wrote:
> > > > On Thu 06-09-18 15:43:21, Mike Rapoport wrote:
> > > > > On Thu, Sep 06, 2018 at 09:28:00AM +0200, Michal Hocko wrote:
> > > > > > On Wed 05-09-18 20:20:18, Mike Rapoport wrote:
> > > > > > > On Wed, Sep 05, 2018 at 12:04:36PM -0500, Rob Herring wrote:
> > > > > > > > On Wed, Sep 5, 2018 at 11:00 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > > > > > > > >
> > > > > > > > > The conversion is done using
> > > > > > > > >
> > > > > > > > > sed -i 's@memblock_virt_alloc@memblock_alloc@g' \
> > > > > > > > >         $(git grep -l memblock_virt_alloc)
> > > > > > > > 
> > > > > > > > What's the reason to do this? It seems like a lot of churn even if a
> > > > > > > > mechanical change.
> > > > > > > 
> > > > > > > I felt that memblock_virt_alloc_ is too long for a prefix, e.g:
> > > > > > > memblock_virt_alloc_node_nopanic, memblock_virt_alloc_low_nopanic.
> > > > > > > 
> > > > > > > And for consistency I've changed the memblock_virt_alloc as well.
> > > > > > 
> > > > > > I would keep the current API unless the name is terribly misleading or
> > > > > > it can be improved a lot. Neither seems to be the case here. So I would
> > > > > > rather stick with the status quo.
> > > > > 
> > > > > I'm ok with the memblock_virt_alloc by itself, but having 'virt' in
> > > > > 'memblock_virt_alloc_try_nid_nopanic' and 'memblock_virt_alloc_low_nopanic'
> > > > > reduces code readability in my opinion.
> > > > 
> > > > Well, is _nopanic really really useful in the name. Do we even need/want
> > > > implicit panic/nopanic semantic? The code should rather check for the
> > > > return value and decide depending on the code path. I suspect removing
> > > > panic/nopanic would make the API slightly lighter.
> > >  
> > > I agree that panic/nopanic should be removed. But I prefer to start with
> > > equivalent replacement to make it as automated as possible and update
> > > memblock API when the dust settles a bit.
> > 
> > Yes, I agree with that approach. But that also doesn't justify the
> > renaming
> 
> Well, the renaming is automated :)

Yes, it is. It also adds churn to the code so I tend to prefer an
existing naming unless it is completely misleading or incomprehensible.

Is this something to lose sleep over. Absolutely not! Does it make sense
to discuss further? I do not think so. If you strongly believe that the
renaming is a good thing then just do it.
-- 
Michal Hocko
SUSE Labs
