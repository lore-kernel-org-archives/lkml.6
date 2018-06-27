Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8347AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FA8259A1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PBeV/WWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FA8259A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeF0X7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:59:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeF0X7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=64dsxRv56MiZpJt1LOECgyKuyCd0Ko9NDFXwOAKYO+U=; b=PBeV/WWTyczA+KA8u9Vm8AauY
        qXyztpL4sYAbmDJIywuvyTvUJ/RViXJBsR5czpTi/3lReHLZP+KzECFtwYSN0mnwSqxPkciHlfiD+
        zdHl+k/qNXk8vtjAeOJQB692IKOAikVWY4ySQEM1wYmt0+CjWHyei3CovD2Fg3jdmrBRTt3RyMZ7j
        cbEKs9CFWBJMynFKTRIuYAaQVMDpSub6CKh6qTpNb7jtgJvhOE8kktXqqXBxyFJNfA59b00pe/G5p
        TKn/MtLwEfMPZWOD6IUQ2KpTRmv6wiT4c4FMMX3Adk5RYtgeuRxHRkkbsFJ62vTMy0j3dKi6dmvuF
        DyExh55/Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYKLi-00071A-Rr; Wed, 27 Jun 2018 23:59:46 +0000
Subject: Re: [PATCH 13/14] Documentation: add a doc for blk-iolatency
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
References: <20180627190940.4696-1-josef@toxicpanda.com>
 <20180627190940.4696-14-josef@toxicpanda.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f6f7034d-c62d-8816-6e46-ad91d5721801@infradead.org>
Date:   Wed, 27 Jun 2018 16:59:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627190940.4696-14-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/2018 12:09 PM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> A basic documentation to describe the interface, statistics, and
> behavior of io.latency.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  Documentation/cgroup-v2.txt | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
> index 74cdeaed9f7a..06e36f3e3f9f 100644
> --- a/Documentation/cgroup-v2.txt
> +++ b/Documentation/cgroup-v2.txt
> @@ -51,6 +51,9 @@ v1 is available under Documentation/cgroup-v1/.
>       5-3. IO
>         5-3-1. IO Interface Files
>         5-3-2. Writeback
> +       5-3-3. IO Latency
> +         5-3-3-1. How IO Latency Throttling Works
> +         5-3-3-2. IO Latency Interface Files
>       5-4. PID
>         5-4-1. PID Interface Files
>       5-5. Device
> @@ -1395,6 +1398,82 @@ writeback as follows.
>  	vm.dirty[_background]_ratio.
>  

Hi again,

>  
> +IO Latency
> +~~~~~~~~~~
> +
> +This is a cgroup v2 controller for IO workload protection.  You provide a group
> +with a latency target, and if the average latency exceeds that target the
> +controller will throttle any peers that have a lower latency target than the
> +protected workload.
> +
> +The limits are only applied at the peer level in the hierarchy.  This means that
> +in the diagram below, only groups A, B, and C will influence each other, and
> +groups D and F will influence each other.  Group G will influence nobody.
> +
> +			[root]
> +		/	   |		\
> +		A	   B		C
> +	       /  \        |
> +	      D    F	   G
> +
> +
> +So the ideal way to configure this is to set io.latency in groups A, B, and C.
> +Generally you do not want to set a value lower than the latency your device
> +supports.  Experiment to find the value that works best for your workload, start

                                                           for your workload. Start

> +at higher than the expected latency for your device and watch the total_lat_avg
> +value in io.stat for your workload group to get an idea of the latency you see
> +during normal operation.  Use this value as a basis for your real setting,
> +setting at 10-15% higher than the value in io.stat.  Experimentation is key here
> +because total_lat_avg is a running total, so is the "statistics" portion of
> +"lies, damned lies, and statistics."
> +
> +How IO Latency Throttling Works
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +io.latency is work conserving; so as long as everybody is meeting their latency
> +target the controller doesn't do anything.  Once a group starts missing its
> +target it begins throttling any peer group that has a higher target than itself.
> +This throttling takes 2 forms:
> +
> +- Queue depth throttling.  This is the number of outstanding IO's a group is
> +  allowed to have.  We will clamp down relatively quickly, starting at no limit
> +  and going all the way down to 1 IO at a time.
> +
> +- Artificial delay induction.  There are certain types of IO that cannot be
> +  throttled without possibly adversely affecting higher priority groups.  This
> +  includes swapping and metadata IO.  These types of IO are allowed to occur
> +  normally, however they are "charged" to the originating group.  If the
> +  originating group is being throttled you will see the use_delay and delay
> +  fields in io.stat increase.  The delay value is how many microseconds that are
> +  being added to any process that runs in this group.  Because this number can
> +  grow quite large if there is a lot of swapping or metadata IO occurring we
> +  limit the individual delay events to 1 second at a time.
> +
> +Once the victimized group starts meeting its latency target again it will start
> +unthrottling any peer groups that were throttled previously.  If the victimized
> +group simply stops doing IO the global counter will unthrottle appropriately.
> +
> +IO Latency Interface Files
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +  io.latency
> +	This takes a similar format as the other controllers.
> +
> +		"MAJOR:MINOR target=<target time in microseconds"

		                                 in microseconds>"

> +
> +  io.stat
> +	If the controller is enabled you will see extra stats in io.stat in
> +	addition to the normal ones.
> +
> +	  depth
> +		This is the current queue depth for the group.
> +
> +	  avg_lat
> +		The running average IO latency for this group in microseconds.
> +		Running average is generally flawed, but will give an
> +		administrator a general idea of the overall latency they can
> +		expect for their workload on the given disk.
> +
>  PID
>  ---
>  
> 


-- 
~Randy
