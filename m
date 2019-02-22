Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BF3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C801D207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBVOMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:12:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVOMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:12:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2E2DA70E;
        Fri, 22 Feb 2019 14:12:16 +0000 (UTC)
Received: from lwoodman.boston.csb (ovpn-124-89.rdu2.redhat.com [10.10.124.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE0AE5D704;
        Fri, 22 Feb 2019 14:12:15 +0000 (UTC)
Reply-To: lwoodman@redhat.com
Subject: Re: [LSF/MM ATTEND ] memory reclaim with NUMA rebalancing
References: <20190130174847.GD18811@dhcp22.suse.cz>
 <87h8dpnwxg.fsf@linux.ibm.com>
 <01000168c431dbc5-65c68c0c-e853-4dda-9eef-8a9346834e59-000000@email.amazonses.com>
To:     Christopher Lameter <cl@linux.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
From:   Larry Woodman <lwoodman@redhat.com>
Organization: Red Hat
Message-ID: <d491fcc4-97c1-168e-e1c5-1106ea77f080@redhat.com>
Date:   Fri, 22 Feb 2019 09:12:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <01000168c431dbc5-65c68c0c-e853-4dda-9eef-8a9346834e59-000000@email.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 22 Feb 2019 14:12:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2019 02:03 PM, Christopher Lameter wrote:
> On Thu, 31 Jan 2019, Aneesh Kumar K.V wrote:
>
>> I would be interested in this topic too. I would like to
>> understand the API and how it can help exploit the different type of
>> devices we have on OpenCAPI.
Same here, we/RedHat have quite a bit of experience running on several
large system
(32TB/128nodes/1024CPUs).  Some of these systems have NVRAM and can operated
in memory mode as well as storage mode.

Larry

> So am I. We may want to rethink the whole NUMA API and the way we handle
> different types of memory with their divergent performance
> characteristics.
>
> We need some way to allow a better selection of memory from the kernel
> without creating too much complexity. We have new characteristics to
> cover:
>
> 1. Persistence (NVRAM) or generally a storage device that allows access to
>    the medium via a RAM like interface.
>
> 2. Coprocessor memory that can be shuffled back and forth to a device
>    (HMM).
>
> 3. On Device memory (important since PCIe limitations are currently a
>    problem and Intel is stuck on PCIe3 and devices start to bypass the
>    processor to gain performance)
>
> 4. High Density RAM (GDDR f.e.) with different caching behavior
>    and/or different cacheline sizes.
>
> 5. Modifying access characteristics by reserving slice of a cache (f.e.
>    L3) for a specific memory region.
>
> 6. SRAM support (high speed memory on the processor itself or by using
>    the processor cache to persist a cacheline)
>
> And then the old NUMA stuff where only the latency to memory varies. But
> that was a particular solution targeted at scaling SMP system through
> interconnects. This was a mostly symmetric approach. The use of
> accellerators etc etc and the above characteristics lead to more complex
> assymmetric memory approaches that may be difficult to manage and use from
> kernel space.
>

