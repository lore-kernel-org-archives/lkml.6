Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAA0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9F42082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9F42082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeLDTWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:22:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbeLDTWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:22:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F51E307C941;
        Tue,  4 Dec 2018 19:22:27 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EF5A60BF1;
        Tue,  4 Dec 2018 19:22:23 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:22:21 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
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
Message-ID: <20181204192221.GG2937@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <20181203233509.20671-3-jglisse@redhat.com>
 <875zw98bm4.fsf@linux.intel.com>
 <20181204182421.GC2937@redhat.com>
 <CAPcyv4gtv7eUc1_3Yhz-f-B3Lct=Vq7zqUJKOqCtWYb4BS6i9g@mail.gmail.com>
 <20181204185725.GE2937@redhat.com>
 <de7c1099-2717-6396-bf56-c4ab4085ee83@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de7c1099-2717-6396-bf56-c4ab4085ee83@deltatee.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 04 Dec 2018 19:22:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 12:11:42PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-12-04 11:57 a.m., Jerome Glisse wrote:
> >> That sounds needlessly restrictive. Let the kernel arbitrate what
> >> memory an application gets, don't design a system where applications
> >> are hard coded to a memory type. Applications can hint, or optionally
> >> specify an override and the kernel can react accordingly.
> > 
> > You do not want to randomly use non cache coherent memory inside your
> > application :) This is not gonna go well with C++ or atomic :) Yes they
> > are legitimate use case where application can decide to give up cache
> > coherency temporarily for a range of virtual address. But the application
> > needs to understand what it is doing and opt in to do that knowing full
> > well that. The version thing allows for scenario like. You do not have
> > to define a new version with every new type of memory. If your new memory
> > has all the properties of v1 than you expose it as v1 and old application
> > on the new platform will use your new memory type being non the wiser.
> 
> I agree with Dan and the general idea that this version thing is really
> ugly. Define some standard attributes so the application can say "I want
> cache-coherent, high bandwidth memory". If there's some future
> new-memory attribute, then the application needs to know about it to
> request it.

So version is a bad prefix, what about type, prefixing target with a
type id. So that application that are looking for a certain type of
memory (which has a set of define properties) can select them. Having
a type file inside the directory and hopping application will read
that sysfs file is a recipies for failure from my point of view. While
having it in the directory name is making sure that the application
has some idea of what it is doing.

> 
> Also, in the same vein, I think it's wrong to have the API enumerate all
> the different memory available in the system. The API should simply
> allow userspace to say it wants memory that can be accessed by a set of
> initiators with a certain set of attributes and the bind call tries to
> fulfill that or fallback on system memory/hmm migration/whatever.

We have existing application that use topology today to partition their
workload and do load balancing. Those application leverage the fact that
they are only running on a small set of known platform with known topology
here i want to provide a common API so that topology can be queried in a
standard by application.

Yes basic application will not leverage all this information and will
be happy enough with give me memory that will be fast for initiator A
and B. That can easily be implemented inside userspace library which
dumbs down the topology on behalf of application.

I believe that proposing a new infrastructure should allow for maximum
expressiveness. The HMS API in this proposal allow to express any kind
of directed graph hence i do not see any limitation going forward. At
the same time userspace library can easily dumbs this down for average
Joe/Jane application.

Cheers,
Jérôme
