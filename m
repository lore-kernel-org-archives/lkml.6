Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A62EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391E32087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="otBAzOTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391E32087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeH2AEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:04:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46264 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH2AEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o7Y1OTUXeAY4pcjaIziv2jztxSTV+PFDKkaKRIMPqSI=; b=otBAzOTMZrgYVYFdHWAJ0GiNNP
        XXSr0CM/MNOm3i6OqNE4eKHjTuVQ/aDkzrwB2BfF4DMsARViy6ouhI2wDN0cTjTa8hmwyhSsgN2Qn
        bATGeL/VyzubW3MKbWRYK8IGF2HkeYu10LaXsFu9YTJe8qRk+pVu3uih4Y9UudY0UQQB7jX09aNhe
        a16sXO2oJX0IFFir4wpzfogYfb+zcGUlWnMwnBjhPruiBrH6uJj1Zvbe9pUq9zinMPtc06pkNNpuP
        U/leUvTDNRHJ+OxcbvVAGVsaD3TXC64MzQJYj9aLaA9hmzfZe/ggcPPlBMcFvjs1IRrNXRM6IpCn7
        FVzKegpg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fukKZ-0004o0-DL; Tue, 28 Aug 2018 20:11:15 +0000
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180828172258.3185-9-hannes@cmpxchg.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ff71c29-3b6a-4849-6f2a-3d829bbd43e2@infradead.org>
Date:   Tue, 28 Aug 2018 13:11:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828172258.3185-9-hannes@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 10:22 AM, Johannes Weiner wrote:
> diff --git a/Documentation/accounting/psi.txt b/Documentation/accounting/psi.txt
> new file mode 100644
> index 000000000000..51e7ef14142e
> --- /dev/null
> +++ b/Documentation/accounting/psi.txt
> @@ -0,0 +1,64 @@
> +================================
> +PSI - Pressure Stall Information
> +================================
> +
> +:Date: April, 2018
> +:Author: Johannes Weiner <hannes@cmpxchg.org>
> +
> +When CPU, memory or IO devices are contended, workloads experience
> +latency spikes, throughput losses, and run the risk of OOM kills.
> +
> +Without an accurate measure of such contention, users are forced to
> +either play it safe and under-utilize their hardware resources, or
> +roll the dice and frequently suffer the disruptions resulting from
> +excessive overcommit.
> +
> +The psi feature identifies and quantifies the disruptions caused by
> +such resource crunches and the time impact it has on complex workloads
> +or even entire systems.
> +
> +Having an accurate measure of productivity losses caused by resource
> +scarcity aids users in sizing workloads to hardware--or provisioning
> +hardware according to workload demand.
> +
> +As psi aggregates this information in realtime, systems can be managed
> +dynamically using techniques such as load shedding, migrating jobs to
> +other systems or data centers, or strategically pausing or killing low
> +priority or restartable batch jobs.
> +
> +This allows maximizing hardware utilization without sacrificing
> +workload health or risking major disruptions such as OOM kills.
> +
> +Pressure interface
> +==================
> +
> +Pressure information for each resource is exported through the
> +respective file in /proc/pressure/ -- cpu, memory, and io.
> +

Hi,

> +In both cases, the format for CPU is as such:

I don't see what "In both cases" refers to here.  It seems that you could
just remove it.

> +
> +some avg10=0.00 avg60=0.00 avg300=0.00 total=0
> +
> +and for memory and IO:
> +
> +some avg10=0.00 avg60=0.00 avg300=0.00 total=0
> +full avg10=0.00 avg60=0.00 avg300=0.00 total=0
> +
> +The "some" line indicates the share of time in which at least some
> +tasks are stalled on a given resource.


-- 
~Randy
