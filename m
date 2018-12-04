Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBC8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FC42081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FC42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeLDS5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:57:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeLDS5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:57:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFB83A404B;
        Tue,  4 Dec 2018 18:57:29 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB99F19C7D;
        Tue,  4 Dec 2018 18:57:27 +0000 (UTC)
Date:   Tue, 4 Dec 2018 13:57:26 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Linux MM <linux-mm@kvack.org>,
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
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>, rcampbell@nvidia.com
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS)
 documentation
Message-ID: <20181204185725.GE2937@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <20181203233509.20671-3-jglisse@redhat.com>
 <875zw98bm4.fsf@linux.intel.com>
 <20181204182421.GC2937@redhat.com>
 <CAPcyv4gtv7eUc1_3Yhz-f-B3Lct=Vq7zqUJKOqCtWYb4BS6i9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4gtv7eUc1_3Yhz-f-B3Lct=Vq7zqUJKOqCtWYb4BS6i9g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 04 Dec 2018 18:57:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 10:31:17AM -0800, Dan Williams wrote:
> On Tue, Dec 4, 2018 at 10:24 AM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Tue, Dec 04, 2018 at 09:06:59AM -0800, Andi Kleen wrote:
> > > jglisse@redhat.com writes:
> > >
> > > > +
> > > > +To help with forward compatibility each object as a version value and
> > > > +it is mandatory for user space to only use target or initiator with
> > > > +version supported by the user space. For instance if user space only
> > > > +knows about what version 1 means and sees a target with version 2 then
> > > > +the user space must ignore that target as if it does not exist.
> > >
> > > So once v2 is introduced all applications that only support v1 break.
> > >
> > > That seems very un-Linux and will break Linus' "do not break existing
> > > applications" rule.
> > >
> > > The standard approach that if you add something incompatible is to
> > > add new field, but keep the old ones.
> >
> > No that's not how it is suppose to work. So let says it is 2018 and you
> > have v1 memory (like your regular main DDR memory for instance) then it
> > will always be expose a v1 memory.
> >
> > Fast forward 2020 and you have this new type of memory that is not cache
> > coherent and you want to expose this to userspace through HMS. What you
> > do is a kernel patch that introduce the v2 type for target and define a
> > set of new sysfs file to describe what v2 is. On this new computer you
> > report your usual main memory as v1 and your new memory as v2.
> >
> > So the application that only knew about v1 will keep using any v1 memory
> > on your new platform but it will not use any of the new memory v2 which
> > is what you want to happen. You do not have to break existing application
> > while allowing to add new type of memory.
> 
> That sounds needlessly restrictive. Let the kernel arbitrate what
> memory an application gets, don't design a system where applications
> are hard coded to a memory type. Applications can hint, or optionally
> specify an override and the kernel can react accordingly.

You do not want to randomly use non cache coherent memory inside your
application :) This is not gonna go well with C++ or atomic :) Yes they
are legitimate use case where application can decide to give up cache
coherency temporarily for a range of virtual address. But the application
needs to understand what it is doing and opt in to do that knowing full
well that. The version thing allows for scenario like. You do not have
to define a new version with every new type of memory. If your new memory
has all the properties of v1 than you expose it as v1 and old application
on the new platform will use your new memory type being non the wiser.

The version thing is really to exclude user from using something they
do not want to use without understanding the consequences of doing so.

Cheers,
Jérôme
