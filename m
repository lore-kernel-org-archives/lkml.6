Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18BBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDD32084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDD32084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeLEEl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 23:41:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbeLEEl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 23:41:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26EC63DBCA;
        Wed,  5 Dec 2018 04:41:26 +0000 (UTC)
Received: from redhat.com (ovpn-120-95.rdu2.redhat.com [10.10.120.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8948A7F1CE;
        Wed,  5 Dec 2018 04:41:23 +0000 (UTC)
Date:   Tue, 4 Dec 2018 23:41:21 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <balbirs@au1.ibm.com>,
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
Message-ID: <20181205044121.GB3438@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <20181203233509.20671-3-jglisse@redhat.com>
 <875zw98bm4.fsf@linux.intel.com>
 <20181204182421.GC2937@redhat.com>
 <72f1141b-ffb5-71cb-8404-b55510b30267@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72f1141b-ffb5-71cb-8404-b55510b30267@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 05 Dec 2018 04:41:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:06:02AM +0530, Aneesh Kumar K.V wrote:
> On 12/4/18 11:54 PM, Jerome Glisse wrote:
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
> > 
> 
> So the knowledge that v1 is coherent and v2 is non-coherent is within the
> application? That seems really complicated from application point of view.
> Rill that v1 and v2 definition be arch and system dependent?

No the idea was that kernel version X like 4.20 would define what v1
means. Then once v2 is added it would define what that means. Memory
that has v1 property would get v1 and memory that have v2 property
would get v2 as prefix.

Application that was done at 4.20 time and thus only knew about v1
would only look for v1 folder and thus only get memory it does under-
stand.

This is kind of moot discussion as i will switch to mask file inside
the directory per Logan advice.

> 
> if we want to encode properties of a target and initiator we should do that
> as files within these directory. Something like 'is_cache_coherent'
> in the target director can be used to identify whether the target is cache
> coherent or not?

My objection and fear is that application would overlook new properties
that the application need to understand to safely use new type of memory.
Thus old application might start using weird memory on new platform and
break in unexpected way. This was the whole rational and motivation behind
my choice.

I will switch to a set of flag in a file in the target directory and rely
on sane userspace behavior.

Cheers,
Jérôme
