Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E56C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8444B2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8444B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbeLDVPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:15:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeLDVPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:15:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EEF5A5275A;
        Tue,  4 Dec 2018 21:15:51 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0E9D5D785;
        Tue,  4 Dec 2018 21:15:49 +0000 (UTC)
Date:   Tue, 4 Dec 2018 16:15:47 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
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
Message-ID: <20181204211547.GN2937@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <20181203233509.20671-3-jglisse@redhat.com>
 <875zw98bm4.fsf@linux.intel.com>
 <20181204182421.GC2937@redhat.com>
 <CAPcyv4gtv7eUc1_3Yhz-f-B3Lct=Vq7zqUJKOqCtWYb4BS6i9g@mail.gmail.com>
 <20181204185725.GE2937@redhat.com>
 <de7c1099-2717-6396-bf56-c4ab4085ee83@deltatee.com>
 <20181204201432.GH18167@tassilo.jf.intel.com>
 <8ed92aba-a129-144f-34ab-f77102d54cfc@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ed92aba-a129-144f-34ab-f77102d54cfc@deltatee.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 04 Dec 2018 21:15:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:47:17PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-12-04 1:14 p.m., Andi Kleen wrote:
> >> Also, in the same vein, I think it's wrong to have the API enumerate all
> >> the different memory available in the system. The API should simply
> 
> > We need an enumeration API too, just to display to the user what they
> > have, and possibly for applications to size their buffers 
> > (all we do with existing NUMA nodes)
> 
> Yes, but I think my main concern is the conflation of the enumeration
> API and the binding API. An application doesn't want to walk through all
> the possible memory and types in the system just to get some memory that
> will work with a couple initiators (which it somehow has to map to
> actual resources, like fds). We also don't want userspace to police
> itself on which memory works with which initiator.

How application would police itself ? The API i am proposing is best
effort and as such kernel can fully ignore userspace request as it is
doing now sometimes with mbind(). So kernel always have the last call
and can always override application decission.

Device driver can also decide to override, anything that is kernel
side really have more power than userspace would have. So while we
give trust to userspace we do not abdicate control. That is not the
intention here.


> Enumeration is definitely not the common use case. And if we create a
> new enumeration API now, it may make it difficult or impossible to unify
> these types of memory with the existing NUMA node hierarchies if/when
> this gets more integrated with the mm core.

The point i am trying to make is that it can not get integrated as
regular NUMA node inside the mm core. But rather the mm core can
grow to encompass non NUMA node memory. I explained why in other
part of this thread but roughly:

- Device driver need to be in control of device memory allocation
  for backward compatibility reasons and to keep full filling thing
  like graphic API constraint (OpenGL, Vulkan, X, ...).

- Adding new node type is problematic inside mm as we are running
  out of bits in the struct page

- Excluding node from the regular allocation path was reject by
  upstream previously (IBM did post patchset for that IIRC).

I feel it is a safer path to avoid a one model fits all here and
to accept that device memory will be represented and managed in
a different way from other memory. I believe persistent memory
folks feels the same on that front.

Nonetheless i do want to expose this device memory in a standard
way so that we can consolidate and improve user experience on
that front. Eventually i hope that more of the device memory
management can be turn into a common device memory management
inside core mm but i do not want to enforce that at first as it
is likely to fail (building a moonbase before you have a moon
rocket). I rather grow organicaly from high level API that will
get use right away (it is a matter of converting existing user
to it s/computeAPIBind/HMSBind).

Cheers,
Jérôme
