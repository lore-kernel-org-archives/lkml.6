Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756053AbeEAQdq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:33:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753505AbeEAQdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:33:45 -0400
Date: Tue, 1 May 2018 18:33:40 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, zhangshaokun@hisilicon.com,
        yao.jin@linux.intel.com, will.deacon@arm.com, ak@linux.intel.com,
        agustinv@codeaurora.org
Subject: Re: [V5 PATCH] perf parse-events: Specially handle uncore event
 alias in small groups
Message-ID: <20180501163340.GB11539@krava>
References: <1525185096-13477-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525185096-13477-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 07:31:36AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Perf stat doesn't count the uncore event aliases from the same uncore
> block in a group, for example:
> 
>   perf stat -e '{unc_m_cas_count.all,unc_m_clockticks}' -a -I 1000
>   #           time             counts unit events
>        1.000447342      <not counted>      unc_m_cas_count.all
>        1.000447342      <not counted>      unc_m_clockticks
>        2.000740654      <not counted>      unc_m_cas_count.all
>        2.000740654      <not counted>      unc_m_clockticks
> 
> The output is very misleading. It gives a wrong impression that the
> uncore event doesn't work.
> 
> An uncore block could be composed by several PMUs. An uncore event alias
> is a joint name which means the same event runs on all PMUs of a block.
> Perf doesn't support mixed events from different PMUs in the same group.
> It is wrong to put uncore event aliases in a big group.
> 
> The right way is to split the big group into multiple small groups which
> only include the events from the same PMU.
> Only uncore event aliases from the same uncore block should be specially
> handled here. It doesn't make sense to mix the uncore events with other
> uncore events from different blocks or even core events in a group.
> 
> With the patch:
>   #           time             counts unit events
>      1.001557653            140,833      unc_m_cas_count.all
>      1.001557653      1,330,231,332      unc_m_clockticks
>      2.002709483             85,007      unc_m_cas_count.all
>      2.002709483      1,429,494,563      unc_m_clockticks
> 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V4:
> - Add WARN_ON when failing to alloc an array for leaders
> - Add comments to explain why it has to go through the whole group

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
