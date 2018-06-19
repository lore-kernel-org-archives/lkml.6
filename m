Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCABC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F25C20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F25C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937821AbeFSPSH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:18:07 -0400
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:55527 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937750AbeFSPSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:18:06 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id BA898989D5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:18:04 +0000 (UTC)
Received: (qmail 25700 invoked from network); 19 Jun 2018 15:18:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 19 Jun 2018 15:18:04 -0000
Date:   Tue, 19 Jun 2018 16:18:03 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "kkolakow@redhat.com" <kkolakow@redhat.com>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180619151803.bu6pehdu6wbd6l5x@techsingularity.net>
References: <CAE4VaGBRFBM-uZEE=DdUzQkcNmpnUHdjK-7hgEeywmG8bvOOgw@mail.gmail.com>
 <20180611141113.pfuttg7npch3jtg6@techsingularity.net>
 <CAE4VaGCMS2pXfPVSnMbudexv_m5wRCTuBKA5ijh2x==11uQg9g@mail.gmail.com>
 <20180614083640.dekqhsopoefnfhb4@techsingularity.net>
 <CAE4VaGCzB99es_TpAaYvtjX8fqzFA=7HX-ezqgO6FaEB5if4zg@mail.gmail.com>
 <20180615112522.3wujbq7bajof57qx@techsingularity.net>
 <CAE4VaGBtasbDBoZ-c5R-AY++Y1BXgjrE7DwN0zOt113xmV95xw@mail.gmail.com>
 <20180615135212.wq45co7ootvdeo2f@techsingularity.net>
 <CAE4VaGAdXNYXMUn4eQgMqQtLKfp6-YHMa1NUSpL-L078oX7C-w@mail.gmail.com>
 <CAE4VaGBeTpxd1phR4rVAjqOXuLgLWPtVMPoRSOcG3HXfWDF=8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGBeTpxd1phR4rVAjqOXuLgLWPtVMPoRSOcG3HXfWDF=8w@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 03:36:53PM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> we have tested following variants:
> 
> var1: 4.16 + 2c83362734dad8e48ccc0710b5cd2436a0323893
> fix1: var1+ ratelimit_pages __read_mostly increased by factor 4x
> -static unsigned int ratelimit_pages __read_mostly = 128 << (20 - PAGE_SHIFT);
> +static unsigned int ratelimit_pages __read_mostly = 512 << (20 - PAGE_SHIFT);
> fix2: var1+ ratelimit_pages __read_mostly increased by factor 8x
> -static unsigned int ratelimit_pages __read_mostly = 512 << (20 - PAGE_SHIFT);
> +static unsigned int ratelimit_pages __read_mostly = 1024 << (20 - PAGE_SHIFT);
> fix3: var1+ ratelimit_pages __read_mostly increased by factor 16x
> -static unsigned int ratelimit_pages __read_mostly = 1024 << (20 - PAGE_SHIFT);
> +static unsigned int ratelimit_pages __read_mostly = 2048 << (20 - PAGE_SHIFT);
> 
> Results for the stream benchmark (standalone processes) have gradually
> improved. For fix3, stream benchmark with runtime 60 seconds does not show
> performance drop compared to 4.16 kernel anymore.
> 

Ok, so at least one option is to remove the rate limiting.  It'll be ok as
long as cross-node migrations are not both a) a regular event and b) each
migrate remains on the new socket long enough for migrations to occur and c)
the bandwidth used for cross-node migration does not interfere badly with
tasks accessing local memory. It'll vary depending on workload and machine
unfortuantely but the rate limiting never accounted for the real capabilities
of hardware and cannot detect bandwidth used for regular accesses.

> For the OpenMP NAS, results are still worse than with vanilla 4.16 kernel.
> Increasing the ratelimit has helped, but even the best results of {fix1,
> fix2, fix3} are still some 5-10% slower than with vanilla 4.16 kernel.  If
> I should pick the best value for ratelimit_pages __read_mostly it would be
> fix2:
> +static unsigned int ratelimit_pages __read_mostly = 1024 << (20 -
> PAGE_SHIFT);
> 
> I have also used the Intel LINPACK (OpenMP) benchmark on 4 NUMA server - it
> gives the similar results as NAS test.
> 
> I think that patch 2c83362734dad8e48ccc0710b5cd2436a0323893 needs a review
> for the OpenMP and standalone processes workflow.
> 

I did get some results although testing of the different potential patches
(revert, numabalance series, faster scanning in isolation etc) are still
in progress. However, I did find that rate limiting was not a factor for
NAS at least (STREAM was too short lived in the configuration I used) on
the machine I used. That does not prevent the ratelimiting being removed
but it highlights that the impact is workload and machine specific.

Second, I did manage to see the regression and the fix from the revert *but*
it required both one third of CPUs to be used and the openMP parallelisation
method. Using all CPUs shows no regression and using a third of the CPUs
with MPI shows no regression. In other words, the impact is specific to
the workload, the configuration and the machine.

I don't have a LINPACK configuration but you say that the behaviour is
similar so I'll stick with NAS.

On the topic of STREAM, it's meant to be a memory bandwidth benchmark and
there is no knowledge within the scheduler for automatically moving tasks
to a memory controller. It really should be tuned to run as one instance
bound to one controller for the figures to make sense. For automatic NUMA
balancing to fix it up, it needs to run long enough and it's not guaranteed
to be optimally located. I think it's less relevant as a workload in this
instance and it'll never be optimal as even spreading early does not mean
it'll spread to each memory controller.

Given the specific requirement of CPUs used and parallelisation method, I
think a plain revert is not the answer because it'll fix one particular
workload and reintroduce regressions on others (as laid out in the
original changelog). There are other observations we can make about the
NAS-OpenMP workload though

1. The locality sucks
Parallelising with MPI indicates that locality as measured by the NUMA
hinting achieves 94% local hits and minimal migration. With OpenMP,
locality is 66% with large amounts of migration. Many of the updates are
huge PMDs so this may be an instance of false sharing or it might be the
timing of when migrations start.

2. Migrations with the revert are lower
There are fewer migrations when the patch is reverted and this may be an
indication that it simply benefits by spreading early before any memory
is allocated so that migrations are avoided. Unfortunately, this is not
a universal win for every workload.

I'll experiement a bit with faster migrations on cross-node accesses
but I think no matter which way we jump on this one it'll be a case of
"it helps one workload and hurts another".

-- 
Mel Gorman
SUSE Labs
