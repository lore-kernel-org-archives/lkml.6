Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A816C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F642081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F642081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeLESsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:48:54 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34848 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeLESsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:48:53 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gUcDy-0000jK-CZ; Wed, 05 Dec 2018 11:48:43 -0700
To:     Jerome Glisse <jglisse@redhat.com>
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
References: <20181204205902.GM2937@redhat.com>
 <e4d8bf6b-5b2c-58a5-577b-66d02f2342c1@deltatee.com>
 <20181204215146.GO2937@redhat.com>
 <c5cf87e8-9104-c2e6-9646-188f66fec581@deltatee.com>
 <20181204235630.GQ2937@redhat.com>
 <b77849e1-e05a-1071-7c48-ac93191e3134@deltatee.com>
 <20181205023116.GD3045@redhat.com>
 <a5ae63ff-a913-25af-4648-4ebf91775412@deltatee.com>
 <20181205180756.GI3536@redhat.com>
 <e5c740fd-0256-8b70-cd06-6d6fee19806d@deltatee.com>
 <20181205183314.GJ3536@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0ddb2620-ecbd-4b7b-aeb7-3f4ae7746e83@deltatee.com>
Date:   Wed, 5 Dec 2018 11:48:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205183314.GJ3536@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: rcampbell@nvidia.com, jhubbard@nvidia.com, Paul.Blinzer@amd.com, christian.koenig@amd.com, Philip.Yang@amd.com, felix.kuehling@amd.com, benh@kernel.crashing.org, aneesh.kumar@linux.ibm.com, balbirs@au1.ibm.com, haggaie@mellanox.com, dave.hansen@intel.com, rafael@kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, ak@linux.intel.com, dan.j.williams@intel.com, jglisse@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS)
 documentation
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-12-05 11:33 a.m., Jerome Glisse wrote:
> If i add a a fake driver for those what would i do ? under which
> sub-system i register them ? How i express the fact that they
> connect device X,Y and Z with some properties ?

Yes this is exactly what I'm suggesting. I wouldn't call it a fake
driver, but a new struct device describing an actual device in the
system. It would be a feature of the GPU subsystem seeing this is a
feature of GPUs. Expressing that the new devices connect to a specific
set of GPUs is not a hard problem to solve.

> This is not PCIE ... you can not discover bridges and child, it
> not a tree like structure, it is a random graph (which depends
> on how the OEM wire port on the chips).

You must be able to discover that these links exist and register a
device with the system. Where else do you get the information currently?
The suggestion doesn't change anything to do with how you interact with
hardware, only how you describe the information within the kernel.

> So i have not pre-existing driver, they are not in sysfs today and
> they do not need a driver. Hence why i proposed what i proposed
> a sysfs hierarchy where i can add those "virtual" object and shows
> how they connect existing device for which we have a sysfs directory
> to symlink.

So add a new driver -- that's what I've been suggesting all along.
Having a driver not exist is no reason to not create one. I'd suggest
that if you want them to show up in the sysfs hierarchy then you do need
some kind of driver code to create a struct device. Just because the
kernel doesn't have to interact with them is no reason not to create a
struct device. It's *much* easier to create a new driver subsystem than
a whole new userspace API.

Logan
