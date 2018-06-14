Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 56BC0C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1EC208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1EC208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966221AbeFNOSY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:18:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60520 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965440AbeFNOSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:18:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCAEC1435;
        Thu, 14 Jun 2018 07:18:22 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95B803F557;
        Thu, 14 Jun 2018 07:18:20 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:18:19 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v4 1/5] sched/topology: Add check to backup comment about
 hotplug lock
Message-ID: <20180614141818.GN17720@e108498-lin.cambridge.arm.com>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
 <20180613121711.5018-2-juri.lelli@redhat.com>
 <20180614093324.7ea45448@gandalf.local.home>
 <20180614134234.GC12032@localhost.localdomain>
 <20180614094747.390357ec@gandalf.local.home>
 <20180614135040.GE12032@localhost.localdomain>
 <20180614135800.GM17720@e108498-lin.cambridge.arm.com>
 <20180614141118.GG12032@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614141118.GG12032@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 Jun 2018 at 16:11:18 (+0200), Juri Lelli wrote:
> On 14/06/18 14:58, Quentin Perret wrote:
> 
> [...]
> 
> > Hmm not sure if this can help but I think that rebuild_sched_domains()
> > does _not_ take the hotplug lock before calling partition_sched_domains()
> > when CONFIG_CPUSETS=n. But it does take it for CONFIG_CPUSETS=y.
> 
> Did you mean cpuset_mutex?

Nope, I really meant the cpu_hotplug_lock !

With CONFIG_CPUSETS=n, rebuild_sched_domains() calls
partition_sched_domains() directly:

https://elixir.bootlin.com/linux/latest/source/include/linux/cpuset.h#L255

But with CONFIG_CPUSETS=y, rebuild_sched_domains() calls,
rebuild_sched_domains_locked(), which calls get_online_cpus() which
calls cpus_read_lock(), which does percpu_down_read(&cpu_hotplug_lock).
And all that happens before calling partition_sched_domains().

So yeah, the point I was trying to make is that there is an inconsistency
here, maybe for a good reason ? Maybe related to the issue you're seeing ?

Thanks,
Quentin
