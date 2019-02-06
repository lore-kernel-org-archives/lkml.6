Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0E9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99112075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FnIJiLll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfBFTDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:03:50 -0500
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:46080 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbfBFTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549479828;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=xYi6pCyDA9ZOQcYAxtOfItk+QwdU/COFlue4KVWz1Sk=;
        b=FnIJiLll8xQfoA9hfRIsqHXFv7JymnplP5wZ7DxNoHDvrUAPoo8SzG6tfvRnypj/
        V+jSIAlK+w1UOD/3q+ki7ZhfpMVhSqg9WuawKegLwHSdhj0/3my9z6+m5MYoCqyR8FV
        v8flXD841rz/28n7k4eaOm8F1TKxqtgAlY7molh0=
Date:   Wed, 6 Feb 2019 19:03:48 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM ATTEND ] memory reclaim with NUMA rebalancing
In-Reply-To: <87h8dpnwxg.fsf@linux.ibm.com>
Message-ID: <01000168c431dbc5-65c68c0c-e853-4dda-9eef-8a9346834e59-000000@email.amazonses.com>
References: <20190130174847.GD18811@dhcp22.suse.cz> <87h8dpnwxg.fsf@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.06-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Aneesh Kumar K.V wrote:

> I would be interested in this topic too. I would like to
> understand the API and how it can help exploit the different type of
> devices we have on OpenCAPI.

So am I. We may want to rethink the whole NUMA API and the way we handle
different types of memory with their divergent performance
characteristics.

We need some way to allow a better selection of memory from the kernel
without creating too much complexity. We have new characteristics to
cover:

1. Persistence (NVRAM) or generally a storage device that allows access to
   the medium via a RAM like interface.

2. Coprocessor memory that can be shuffled back and forth to a device
   (HMM).

3. On Device memory (important since PCIe limitations are currently a
   problem and Intel is stuck on PCIe3 and devices start to bypass the
   processor to gain performance)

4. High Density RAM (GDDR f.e.) with different caching behavior
   and/or different cacheline sizes.

5. Modifying access characteristics by reserving slice of a cache (f.e.
   L3) for a specific memory region.

6. SRAM support (high speed memory on the processor itself or by using
   the processor cache to persist a cacheline)

And then the old NUMA stuff where only the latency to memory varies. But
that was a particular solution targeted at scaling SMP system through
interconnects. This was a mostly symmetric approach. The use of
accellerators etc etc and the above characteristics lead to more complex
assymmetric memory approaches that may be difficult to manage and use from
kernel space.

