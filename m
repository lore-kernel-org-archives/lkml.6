Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD37C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0F820834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0F820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbeLEA3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:29:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeLEA3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:29:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B01793001943;
        Wed,  5 Dec 2018 00:29:19 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39F4C6B8EC;
        Wed,  5 Dec 2018 00:29:16 +0000 (UTC)
Date:   Tue, 4 Dec 2018 19:29:14 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Vivek Kini <vkini@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Ben Woodard <woodard@redhat.com>, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Message-ID: <20181205002914.GS2937@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <9d745b99-22e3-c1b5-bf4f-d3e83113f57b@intel.com>
 <20181204184919.GD2937@redhat.com>
 <20163c1e-00f1-7e02-82c0-7730ceabb9f2@intel.com>
 <20181204215711.GP2937@redhat.com>
 <ed96fdb0-d8b6-e19b-fe45-532042b712c6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed96fdb0-d8b6-e19b-fe45-532042b712c6@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 05 Dec 2018 00:29:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:58:23PM -0800, Dave Hansen wrote:
> On 12/4/18 1:57 PM, Jerome Glisse wrote:
> > Fully correct mind if i steal that perfect summary description next time
> > i post ? I am so bad at explaining thing :)
> 
> Go for it!
> 
> > Intention is to allow program to do everything they do with mbind() today
> > and tomorrow with the HMAT patchset and on top of that to also be able to
> > do what they do today through API like OpenCL, ROCm, CUDA ... So it is one
> > kernel API to rule them all ;)
> 
> While I appreciate the exhaustive scope of such a project, I'm really
> worried that if we decided to use this for our "HMAT" use cases, we'll
> be bottlenecked behind this project while *it* goes through 25 revisions
> over 4 or 5 years like HMM did.
> 
> So, should we just "park" the enhancements to the existing NUMA
> interfaces and infrastructure (think /sys/devices/system/node) and wait
> for this to go in?  Do we try to develop them in parallel and make them
> consistent?  Or, do we just ignore each other and make Andrew sort it
> out in a few years? :)

Let have a battle with giant foam q-tip at next LSF/MM and see who wins ;)

More seriously i think you should go ahead with Keith HMAT patchset and
make progress there. In HMAT case you can grow and evolve the NUMA node
infrastructure to address your need and i believe you are doing it in
a sensible way. But i do not see a path for what i am trying to achieve
in that framework. If anyone have any good idea i would welcome it.

In the meantime i hope i can make progress with my proposal here under
staging. Once i get enough stuff working in userspace and convince guinea
pig (i need to find a better name for those poor people i will coerce
in testing this ;)) then i can have some hard evidence of what thing in
my proposal is useful on some concret case with open source stack from
top to bottom. It might means stripping down what i am proposing today
to what turns out to be useful. Then start a discussion about merging the
kernel underlying code into one (while preserving all existing API) and
getting out of staging with real syscall we will have to die with.

I know that at the very least the hbind() and hpolicy() syscall would
be successful as the HPC folks have been been dreaming of this. The
topology thing is harder to know, they are some users today but i can
not say how much more interest it can spark outside of this very small
community that is HPC.

Cheers,
Jérôme
