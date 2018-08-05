Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CFAC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E32A217CC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="rilgOaQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E32A217CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeHEOvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 10:51:54 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:59215 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbeHEOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 10:51:54 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Aug 2018 10:51:51 EDT
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:10])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 23F57211AD;
        Sun,  5 Aug 2018 15:40:17 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtpcorp1p.mail.yandex.net (Yandex) with ESMTP id 0E85B6E40DC3;
        Sun,  5 Aug 2018 15:40:17 +0300 (MSK)
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:854c:7dcd:9203:76a5])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ai8VyubnKi-eGwq3aQh;
        Sun, 05 Aug 2018 15:40:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1533472817; bh=jbn26KyMLK81UxMu4QX0u51Uih/JSwg8Z3ad7igXfsQ=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=rilgOaQquBbuqgfOlOp4akDC1MXL9G+DtJmKZvkspM7qiRJtpnBT5+6UxNAZM6aWo
         C54PLEM2oAaZfWRH08ThPZN1JSx7OXQmVkjxgvanS/hK5r1vjc8okSe/uiP5c5Y9uo
         FtoLYKKed9hpzuBP5h73ZlplRetFcD9CQFRPbeSE=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH 13/14] Documentation: add a doc for blk-iolatency
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-14-josef@toxicpanda.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <30471358-6482-1e3f-e8bc-4195289d4108@yandex-team.ru>
Date:   Sun, 5 Aug 2018 15:40:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180703151503.2549-14-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2018 18:15, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> A basic documentation to describe the interface, statistics, and
> behavior of io.latency.
> 

Request size also has significant effect on latency of following requests.
It's worth to notice that smaller max_sectors_kb gives more control over latency.

> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst | 79 +++++++++++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 8a2c52d5c53b..569ce27b85e5 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -51,6 +51,9 @@ v1 is available under Documentation/cgroup-v1/.
>        5-3. IO
>          5-3-1. IO Interface Files
>          5-3-2. Writeback
> +       5-3-3. IO Latency
> +         5-3-3-1. How IO Latency Throttling Works
> +         5-3-3-2. IO Latency Interface Files
>        5-4. PID
>          5-4-1. PID Interface Files
>        5-5. Device
> @@ -1446,6 +1449,82 @@ writeback as follows.
>   	vm.dirty[_background]_ratio.
>   
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
> +supports.  Experiment to find the value that works best for your workload.
> +Start at higher than the expected latency for your device and watch the
> +total_lat_avg value in io.stat for your workload group to get an idea of the
> +latency you see during normal operation.  Use this value as a basis for your
> +real setting, setting at 10-15% higher than the value in io.stat.
> +Experimentation is key here because total_lat_avg is a running total, so is the
> +"statistics" portion of "lies, damned lies, and statistics."
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
>   PID
>   ---
>   
> 

