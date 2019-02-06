Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD41C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AC5218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfBFRay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:30:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbfBFRau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:30:50 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B25B56B7394A149B462B;
        Thu,  7 Feb 2019 01:30:47 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Feb 2019
 01:30:37 +0800
Date:   Wed, 6 Feb 2019 17:30:27 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCHv5 00/10] Heterogeneuos memory node attributes
Message-ID: <20190206173027.0000195c@huawei.com>
In-Reply-To: <20190206171935.GJ28064@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
        <20190206123100.0000094a@huawei.com>
        <20190206171935.GJ28064@localhost.localdomain>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 10:19:37 -0700
Keith Busch <keith.busch@intel.com> wrote:

> On Wed, Feb 06, 2019 at 12:31:00PM +0000, Jonathan Cameron wrote:
> > On Thu, 24 Jan 2019 16:07:14 -0700
> > Keith Busch <keith.busch@intel.com> wrote:
> > 
> > 1) It seems this version added a hard dependence on having the memory node
> >    listed in the Memory Proximity Domain attribute structures.  I'm not 100%
> >    sure there is actually any requirement to have those structures. If you aren't
> >    using the hint bit, they don't convey any information.  It could be argued
> >    that they provide info on what is found in the other hmat entries, but there
> >    is little purpose as those entries are explicit in what the provide.
> >    (Given I didn't have any of these structures and things  worked fine with
> >     v4 it seems this is a new check).  
> 
> Right, v4 just used the node(s) with the highest performance. You mentioned
> systems having nodes with different performance, but no winner across all
> attributes, so there's no clear way to rank these for access class linkage.
> Requiring an initiator PXM present clears that up.
> 
> Maybe we can fallback to performance if the initiator pxm isn't provided,
> but the ranking is going to require an arbitrary decision, like prioritize
> latency over bandwidth.

I'd certainly prefer to see that fall back and would argue it is
the only valid route.  What is 'best' if we don't put a preference on
one parameter over the other.

Perfectly fine to have another access class that does bandwidth preferred
if that is of sufficient use to people.

>  
> >    This is also somewhat inconsistent.
> >    a) If a given entry isn't there, we still get for example
> >       node4/access0/initiators/[read|write]_* but all values are 0.
> >       If we want to do the check you have it needs to not create the files in
> >       this case.  Whilst they have no meaning as there are no initiators, it
> >       is inconsistent to my mind.
> > 
> >    b) Having one "Memory Proximity Domain attribute structure" for node 4 linking
> >       it to node0 is sufficient to allow
> >       node4/access0/initiators/node0
> >       node4/access0/initiators/node1
> >       node4/access0/initiators/node2
> >       node4/access0/initiators/node3
> >       I think if we are going to enforce the presence of that structure then only
> >       the node0 link should exist.  
> 
> We'd link the initiator pxm in the Address Range Structure, and also any
> other nodes with identical performance access. I think that makes sense.

I disagree on this. It is either / or, it seem really illogical to build
all of them if only one initiator is specified for the target.

If someone deliberately only specified one initiator for this target then they
meant to do that (hopefully).  Probably because they wanted to set one
of the flags.

>  
> > 2) Error handling could perhaps do to spit out some nasty warnings.
> >    If we have an entry for nodes that don't exist we shouldn't just fail silently,
> >    that's just one example I managed to trigger with minor table tweaking.
> > 
> > Personally I would just get rid of enforcing anything based on the presence of
> > that structure.  

Thanks,

Jonathan

