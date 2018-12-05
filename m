Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D940C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584D3208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584D3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeLEW6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:58:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeLEW6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:58:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AC203C2CEB;
        Wed,  5 Dec 2018 22:58:33 +0000 (UTC)
Received: from redhat.com (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EE1160565;
        Wed,  5 Dec 2018 22:58:30 +0000 (UTC)
Date:   Wed, 5 Dec 2018 17:58:28 -0500
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
Message-ID: <20181205225828.GL3536@redhat.com>
References: <20181204235630.GQ2937@redhat.com>
 <b77849e1-e05a-1071-7c48-ac93191e3134@deltatee.com>
 <20181205023116.GD3045@redhat.com>
 <a5ae63ff-a913-25af-4648-4ebf91775412@deltatee.com>
 <20181205180756.GI3536@redhat.com>
 <e5c740fd-0256-8b70-cd06-6d6fee19806d@deltatee.com>
 <20181205183314.GJ3536@redhat.com>
 <0ddb2620-ecbd-4b7b-aeb7-3f4ae7746e83@deltatee.com>
 <20181205185550.GK3536@redhat.com>
 <7ab26ea6-d16d-8d71-78ca-4266a864f8d3@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ab26ea6-d16d-8d71-78ca-4266a864f8d3@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 05 Dec 2018 22:58:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:10:10PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-12-05 11:55 a.m., Jerome Glisse wrote:
> > So now once next type of device shows up with the exact same thing
> > let say FPGA, we have to create a new subsystem for them too. Also
> > this make the userspace life much much harder. Now userspace must
> > go parse PCIE, subsystem1, subsystem2, subsystemN, NUMA, ... and
> > merge all that different information together and rebuild the
> > representation i am putting forward in this patchset in userspace.
> 
> Yes. But seeing such FPGA links aren't common yet and there isn't really
> much in terms of common FPGA infrastructure in the kernel (which are
> hard seeing the hardware is infinitely customization) you can let the
> people developing FPGA code worry about it and come up with their own
> solution. Buses between FPGAs may end up never being common enough for
> people to care, or they may end up being so weird that they need their
> own description independent of GPUS, or maybe when they become common
> they find a way to use the GPU link subsystem -- who knows. Don't try to
> design for use cases that don't exist yet.
> 
> Yes, userspace will have to know about all the buses it cares to find
> links over. Sounds like a perfect thing for libhms to do.

So just to be clear here is how i understand your position:
"Single coherent sysfs hierarchy to describe something is useless
 let's git rm drivers/base/"

While i am arguing that "hey the /sys/bus/node/devices/* is nice
but it just does not cut it for all this new hardware platform
if i add new nodes there for my new memory i will break tons of
existing application. So what about a new hierarchy that allow
to describe those new hardware platform in a single place like
today node thing"


> 
> > There is no telling that kernel won't be able to provide quirk and
> > workaround because some merging is actually illegal on a given
> > platform (like some link from a subsystem is not accessible through
> > the PCI connection of one of the device connected to that link).
> 
> These are all just different individual problems which need different
> solutions not grand new design concepts.
> 
> > So it means userspace will have to grow its own database or work-
> > around and quirk and i am back in the situation i am in today.
> 
> No, as I've said, quirks are firmly the responsibility of kernels.
> Userspace will need to know how to work with the different buses and
> CPU/node information but there really isn't that many of these to deal
> with and this is a much easier approach than trying to come up with a
> new API that can wrap the nuances of all existing and potential future
> bus types we may have to deal with.

No can do that is what i am trying to explain. So if i bus 1 in a
sub-system A and usualy that kind of bus can serve a bridge for
PCIE ie a CPU can access device behind it by going through a PCIE
device first. So now the userspace libary have this knowledge
bake in. Now if a platform has a bug for whatever reasons where
that does not hold, the kernel has no way to tell userspace that
there is an exception there. It is up to userspace to have a data
base of quirks.

Kernel see all those objects in isolation in your scheme. While in
what i am proposing there is only one place and any device that
participate in this common place can report any quirks so that a
coherent view is given to user space.

If we have gazillion of places where all this informations is spread
around than we have no way to fix weird inter-action between any
of those.

Cheers,
Jérôme
