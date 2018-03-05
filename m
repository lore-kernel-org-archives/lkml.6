Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeCEK7h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:59:37 -0500
Received: from foss.arm.com ([217.140.101.70]:48126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752423AbeCEK7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:59:34 -0500
Date: Mon, 5 Mar 2018 10:59:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: robh@kernel.org, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>, peterz@infradead.org,
        sudeep.holla@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        jonathan.cameron@huawei.com, frowand.list@gmail.com,
        leo.yan@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
Message-ID: <20180305105925.4cjiqejfid7rswe6@lakrids.cambridge.arm.com>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5A90B77E.8040105@codeaurora.org>
 <20180225143653.peb4quk3ha5h3t5x@salmiak>
 <5A972A7D.9020301@codeaurora.org>
 <20180301114911.fundyuqxtj5klk4e@lakrids.cambridge.arm.com>
 <5A986425.9080007@codeaurora.org>
 <20180302104223.7tpsyhsum7nej237@lakrids.cambridge.arm.com>
 <5A99A3DC.9020400@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A99A3DC.9020400@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 11:19:56AM -0800, Saravana Kannan wrote:
> On 03/02/2018 02:42 AM, Mark Rutland wrote:
> > It's important to note that the DSU PMU's event_init() ensures events
> > are affine to a single CPU, and the perf core code serializes operations
> > on those events via the context lock.
> 
> Ah, I see that now. Thanks!
> 
> > Therefore, two CPUs *won't* try to access the registers simultaneously.
> 
> Right, and this driver seems to be going through a lot of work to make sure
> all events are read in one CPU.
> 
> Do you even have an upstream target where there are multiple DSU's in a
> system? 

I have no idea, though I do beleive that it's possible for a system to
have multiple DSUs.

> If not, we can simplify a ton of this code (no hotplug notifiers, no
> migrating PMUs, no SMP calls, etc) by just adding a spinlock and letting any
> CPU read these DSU counters.

Regardless of whether we allow arbitrary CPUs to read the counters,
other logic still needs to be CPU affine, and we'll still need hotplug
notifiers and event migration.

I am not necessarily opposed to allowing read() calls from associated
CPUs, but as before, I'll leave that to Suzuki.

Thanks,
Mark.
