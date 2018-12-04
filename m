Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED586C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B890A20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B890A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeLDVvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:51:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeLDVvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:51:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F3D9307DAB3;
        Tue,  4 Dec 2018 21:51:50 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C2AD5C237;
        Tue,  4 Dec 2018 21:51:48 +0000 (UTC)
Date:   Tue, 4 Dec 2018 16:51:46 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>, balbirs@au1.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Kuehling, Felix" <felix.kuehling@amd.com>, Philip.Yang@amd.com,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Blinzer, Paul" <Paul.Blinzer@amd.com>,
        John Hubbard <jhubbard@nvidia.com>, rcampbell@nvidia.com
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS)
 documentation
Message-ID: <20181204215146.GO2937@redhat.com>
References: <20181204182421.GC2937@redhat.com>
 <CAPcyv4gtv7eUc1_3Yhz-f-B3Lct=Vq7zqUJKOqCtWYb4BS6i9g@mail.gmail.com>
 <20181204185725.GE2937@redhat.com>
 <de7c1099-2717-6396-bf56-c4ab4085ee83@deltatee.com>
 <20181204192221.GG2937@redhat.com>
 <f759cc28-309d-930c-da7d-34144a4d5517@deltatee.com>
 <20181204201347.GK2937@redhat.com>
 <2f146730-1bf9-db75-911d-67809fc7afef@deltatee.com>
 <20181204205902.GM2937@redhat.com>
 <e4d8bf6b-5b2c-58a5-577b-66d02f2342c1@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4d8bf6b-5b2c-58a5-577b-66d02f2342c1@deltatee.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 04 Dec 2018 21:51:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:19:09PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-12-04 1:59 p.m., Jerome Glisse wrote:
> > How to expose harmful memory to userspace then ? How can i expose
> > non cache coherent memory because yes they are application out there
> > that use that today and would like to be able to migrate to and from
> > that memory dynamicly during lifetime of the application as the data
> > set progress through the application processing pipeline.
> 
> I'm not arguing against the purpose or use cases. I'm being critical of
> the API choices.
> 
> > Note that i do not expose things like physical address or even splits
> > memory in a node into individual device, in fact in expose less
> > information that the existing NUMA (no zone, phys index, ...). As i do
> > not think those have any value to userspace. What matter to userspace
> > is where is this memory is in my topology so i can look at all the
> > initiators node that are close by. Or the reverse, i have a set of
> > initiators what is the set of closest targets to all those initiators.
> 
> No, what matters to applications is getting memory that will work for
> the initiators/resources they need it to work for. The specific topology
> might be of interest to administrators but it is not what applications
> need. And it should be relatively easy to flesh out the existing sysfs
> device tree to provide the topology information administrators need.

Existing user would disagree in my cover letter i have given pointer
to existing library and paper from HPC folks that do leverage system
topology (among the few who are). So they are application _today_ that
do use topology information to adapt their workload to maximize the
performance for the platform they run on.

They are also some new platform that have much more complex topology
that definitly can not be represented as a tree like today sysfs we
have (i believe that even some of the HPC folks have _today_ topology
that are not tree-like).

So existing user + random graph topology becoming more commons lead
me to the choice i made in this API. I believe a graph is someting
that can easily be understood by people. I am not inventing some
weird new data structure, it is just a graph and for the name i have
use the ACPI naming convention but i am more than open to use memory
for target and differentiate cpu and device instead of using initiator
as a name. I do not have strong feeling on that. I do however would
like to be able to represent any topology and be able to use device
memory that is not manage by core mm for reasons i explained previously.

Note that if it turn out to be a bad idea kernel can decide to dumb
down thing in future version for new platform. So it could give a
flat graph to userspace, there is nothing precluding that.


> > I am talking about the inevitable fact that at some point some system
> > firmware will miss-represent their platform. System firmware writer
> > usualy copy and paste thing with little regards to what have change
> > from one platform to the new. So their will be inevitable workaround
> > and i would rather see those piling up inside a userspace library than
> > inside the kernel.
> 
> It's *absolutely* the kernel's responsibility to patch issues caused by
> broken firmware. We have quirks all over the place for this. That's
> never something userspace should be responsible for. Really, this is the
> raison d'etre of the kernel: to provide userspace with a uniform
> execution environment -- if every application had to deal with broken
> firmware it would be a nightmare.

You cuted the other paragraph that explained why they will unlikely
to be broken badly enough to break the kernel.

Anyway we can fix the topology in kernel too ... that is fine with
me.

Cheers,
Jérôme
