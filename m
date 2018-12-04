Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768D2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1AE2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1AE2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLDSY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:24:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDSY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:24:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 403B387621;
        Tue,  4 Dec 2018 18:24:26 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00DCF194B4;
        Tue,  4 Dec 2018 18:24:23 +0000 (UTC)
Date:   Tue, 4 Dec 2018 13:24:22 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
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
Message-ID: <20181204182421.GC2937@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <20181203233509.20671-3-jglisse@redhat.com>
 <875zw98bm4.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zw98bm4.fsf@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 04 Dec 2018 18:24:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 09:06:59AM -0800, Andi Kleen wrote:
> jglisse@redhat.com writes:
> 
> > +
> > +To help with forward compatibility each object as a version value and
> > +it is mandatory for user space to only use target or initiator with
> > +version supported by the user space. For instance if user space only
> > +knows about what version 1 means and sees a target with version 2 then
> > +the user space must ignore that target as if it does not exist.
> 
> So once v2 is introduced all applications that only support v1 break.
> 
> That seems very un-Linux and will break Linus' "do not break existing
> applications" rule.
> 
> The standard approach that if you add something incompatible is to
> add new field, but keep the old ones.

No that's not how it is suppose to work. So let says it is 2018 and you
have v1 memory (like your regular main DDR memory for instance) then it
will always be expose a v1 memory.

Fast forward 2020 and you have this new type of memory that is not cache
coherent and you want to expose this to userspace through HMS. What you
do is a kernel patch that introduce the v2 type for target and define a
set of new sysfs file to describe what v2 is. On this new computer you
report your usual main memory as v1 and your new memory as v2.

So the application that only knew about v1 will keep using any v1 memory
on your new platform but it will not use any of the new memory v2 which
is what you want to happen. You do not have to break existing application
while allowing to add new type of memory.


Sorry if it was unclear. I will try to reformulate and give an example
as above.


> > +2) hbind() bind range of virtual address to heterogeneous memory
> > +================================================================
> > +
> > +So instead of using a bitmap, hbind() take an array of uid and each uid
> > +is a unique memory target inside the new memory topology description.
> 
> You didn't define what an uid is?
> 
> user id ?
> 
> Please use sensible terminology that doesn't conflict with existing
> usages.
> 
> I assume it's some kind of number that identifies a node in your
> graph. 

Correct uid is unique id given to each node in the graph. I will clarify
that.


> > +User space also provide an array of modifiers. Modifier can be seen as
> > +the flags parameter of mbind() but here we use an array so that user
> > +space can not only supply a modifier but also value with it. This should
> > +allow the API to grow more features in the future. Kernel should return
> > +-EINVAL if it is provided with an unkown modifier and just ignore the
> > +call all together, forcing the user space to restrict itself to modifier
> > +supported by the kernel it is running on (i know i am dreaming about well
> > +behave user space).
> 
> It sounds like you're trying to define a system call with built in
> ioctl? Is that really a good idea?
> 
> If you need ioctl you know where to find it.

Well i would like to get thing running in the wild with some guinea pig
user to get feedback from end user. It would be easier if i can do this
with upstream kernel and not some random branch in my private repo. While
doing that i would like to avoid commiting to a syscall upstream. So the
way i see around this is doing a driver under staging with an ioctl which
will be turn into a syscall once some confidence into the API is gain.

If you think i should do a syscall right away i am not against doing that.

> 
> Please don't over design APIs like this.

So there is 2 approach here. I can define 2 syscall, one for migration
and one for policy. Migration and policy are 2 different thing from all
existing user point of view. By defining 2 syscall i can cut them down
to do this one thing and one thing only and make it as simple and lean
as possible.

In the present version i took the other approach of defining just one
API that can grow to do more thing. I know the unix way is one simple
tool for one simple job. I can switch to the simple call for one action.


> > +3) Tracking and applying heterogeneous memory policies
> > +======================================================
> > +
> > +Current memory policy infrastructure is node oriented, instead of
> > +changing that and risking breakage and regression HMS adds a new
> > +heterogeneous policy tracking infra-structure. The expectation is
> > +that existing application can keep using mbind() and all existing
> > +infrastructure under-disturb and unaffected, while new application
> > +will use the new API and should avoid mix and matching both (as they
> > +can achieve the same thing with the new API).
> 
> I think we need a stronger motivation to define a completely
> parallel and somewhat redundant infrastructure. What breakage
> are you worried about?

Some memory expose through HMS is not allocated by regular memory
allocator. For instance GPU memory is manage by GPU driver, so when
you want to use GPU memory (either as a policy or by migrating to it)
you need to use the GPU allocator to allocate that memory. HMS adds
a bunch of callback to target structure so that device driver can
expose a generic API to core kernel to do such allocation.

Now i can change existing code path to use target structure as an
intermediary for allocation but this is changing hot code path and
i doubt it would be welcome today. Eventually i think we will want
that to happen and can work on minimizing cost for user that do not
use thing like GPU.

The transition phase will take times (couple years) and i would like
to avoid disturbing existing workload while we migrate GPU user to
this new API.


> The obvious alternative would of course be to add some extra
> enumeration to the existing nodes.

We can not extend NUMA node to expose GPU memory. GPU memory on
current AMD and Intel platform is not cache coherent and thus
should not be use for random memory allocation. It should really
stay a thing user have to explicitly select to use. Note that the
useage we have here is that when you use GPU memory it is as if
the range of virtual address is swapped out from CPU point of view
but the GPU can access it.

> It's a strange document. It goes from very high level to low level
> with nothing inbetween. I think you need a lot more details
> in the middle, in particularly how these new interfaces
> should be used. For example how should an application
> know how to look for a specific type of device?
> How is an automated tool supposed to use the enumeration?
> etc.

Today user use dedicated API (OpenCL, ROCm, CUDA, ...) those high
level API all have the API i present here in one form or another.
So i want to move this high level API that is actively use by
program today into the kernel. The end game is to create common
infrastructure for various accelerator hardware (GPU, FPGA, ...)
to manage memory.

This is something ask by end user for one simple reasons. Today
users have to mix and match multiple API in their application and
when they want to exchange data between one device that use one API
and another device that use another API they have to do explicit
copy and rebuild their data structure inside the new memory. When
you move over thing like tree or any complex data structure you have
to rebuilt it ie redo the pointers link between the nodes of your
data structure.

This is highly error prone complex and wasteful (you have to burn
CPU cycles to do that). Now if you can use the same address space
as all the other memory allocation in your program and move data
around from one device to another with a common API that works on
all the various devices, you are eliminating that complex step and
making the end user life much easier.

So i am doing this to help existing users by addressing an issues
that is becoming harder and harder to solve for userspace. My end
game is to blur the boundary between CPU and device like GPU, FPGA,
...


Thank you for taking time to read this proposal and for your feed-
back. Much appreciated. I will try to include your comments in my
v2.

Cheers,
Jérôme
