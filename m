Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88269C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3342081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3342081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLDUM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:12:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:57671 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDUM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:12:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 12:12:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="125064927"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2018 12:12:26 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 3DE46300F9B; Tue,  4 Dec 2018 12:12:26 -0800 (PST)
Date:   Tue, 4 Dec 2018 12:12:26 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <balbirs@au1.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS)
 documentation
Message-ID: <20181204201226.GG18167@tassilo.jf.intel.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <20181203233509.20671-3-jglisse@redhat.com>
 <875zw98bm4.fsf@linux.intel.com>
 <20181204182421.GC2937@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204182421.GC2937@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:24:22PM -0500, Jerome Glisse wrote:
> Fast forward 2020 and you have this new type of memory that is not cache
> coherent and you want to expose this to userspace through HMS. What you
> do is a kernel patch that introduce the v2 type for target and define a
> set of new sysfs file to describe what v2 is. On this new computer you
> report your usual main memory as v1 and your new memory as v2.
> 
> So the application that only knew about v1 will keep using any v1 memory
> on your new platform but it will not use any of the new memory v2 which
> is what you want to happen. You do not have to break existing application
> while allowing to add new type of memory.

That seems entirely like the wrong model. We don't want to rewrite every
application for adding a new memory type.

Rather there needs to be an abstract way to query memory of specific
behavior: e.g. cache coherent, size >= xGB, fastest or lowest latency or similar

Sure there can be a name somewhere, but it should only be used
for identification purposes, not to hard code in applications.

Really you need to define some use cases and describe how your API
handles them.

> > 
> > It sounds like you're trying to define a system call with built in
> > ioctl? Is that really a good idea?
> > 
> > If you need ioctl you know where to find it.
> 
> Well i would like to get thing running in the wild with some guinea pig
> user to get feedback from end user. It would be easier if i can do this
> with upstream kernel and not some random branch in my private repo. While
> doing that i would like to avoid commiting to a syscall upstream. So the
> way i see around this is doing a driver under staging with an ioctl which
> will be turn into a syscall once some confidence into the API is gain.

Ok that's fine I guess.

But should be a clearly defined ioctl, not an ioctl with redefinable parameters
(but perhaps I misunderstood your description)

> In the present version i took the other approach of defining just one
> API that can grow to do more thing. I know the unix way is one simple
> tool for one simple job. I can switch to the simple call for one action.

Simple calls are better.

> > > +Current memory policy infrastructure is node oriented, instead of
> > > +changing that and risking breakage and regression HMS adds a new
> > > +heterogeneous policy tracking infra-structure. The expectation is
> > > +that existing application can keep using mbind() and all existing
> > > +infrastructure under-disturb and unaffected, while new application
> > > +will use the new API and should avoid mix and matching both (as they
> > > +can achieve the same thing with the new API).
> > 
> > I think we need a stronger motivation to define a completely
> > parallel and somewhat redundant infrastructure. What breakage
> > are you worried about?
> 
> Some memory expose through HMS is not allocated by regular memory
> allocator. For instance GPU memory is manage by GPU driver, so when
> you want to use GPU memory (either as a policy or by migrating to it)
> you need to use the GPU allocator to allocate that memory. HMS adds
> a bunch of callback to target structure so that device driver can
> expose a generic API to core kernel to do such allocation.

We already have nodes without memory.
We can also take out nodes out of the normal fall back lists.
We also have nodes with special memory (e.g. DMA32)

Nothing you describe here cannot be handled with the existing nodes.

> > The obvious alternative would of course be to add some extra
> > enumeration to the existing nodes.
> 
> We can not extend NUMA node to expose GPU memory. GPU memory on
> current AMD and Intel platform is not cache coherent and thus
> should not be use for random memory allocation. It should really

Sure you don't expose it as normal memory, but it can be still
tied to a node. In fact you have to for the existing topology
interface to work.

> copy and rebuild their data structure inside the new memory. When
> you move over thing like tree or any complex data structure you have
> to rebuilt it ie redo the pointers link between the nodes of your
> data structure.
> 
> This is highly error prone complex and wasteful (you have to burn
> CPU cycles to do that). Now if you can use the same address space
> as all the other memory allocation in your program and move data
> around from one device to another with a common API that works on
> all the various devices, you are eliminating that complex step and
> making the end user life much easier.
> 
> So i am doing this to help existing users by addressing an issues
> that is becoming harder and harder to solve for userspace. My end
> game is to blur the boundary between CPU and device like GPU, FPGA,

This is just high level rationale. You already had that ...

What I was looking for is how applications actually use the 
API.

e.g. 

1. Compute application is looking for fast cache coherent memory 
for CPU usage.

What does it query and how does it decide and how does it allocate?

2. Allocator in OpenCL application is looking for memory to share
with OpenCL. How does it find memory?

3. Storage application is looking for larger but slower memory
for CPU usage. 

4. ...

Please work out some use cases like this.

-Andi
