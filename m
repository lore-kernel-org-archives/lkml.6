Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeDYOXn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:23:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753283AbeDYOXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:23:41 -0400
Date: Wed, 25 Apr 2018 16:23:37 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, zhangshaokun@hisilicon.com,
        yao.jin@linux.intel.com, will.deacon@arm.com, ak@linux.intel.com,
        agustinv@codeaurora.org
Subject: Re: [V2 PATCH] perf parse-events: Specially handle uncore event
 alias in small groups
Message-ID: <20180425142337.GE3396@krava>
References: <1524664218-134407-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524664218-134407-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 06:50:18AM -0700, kan.liang@linux.intel.com wrote:
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

hum, I still can see the original behaviour even with the patch:

[jolsa@krava perf]$ sudo ./perf stat -e '{data_reads,clockticks}' -a -I 1000
#           time             counts unit events
     1.000184929      <not counted> MiB  data_reads                                                  
     1.000184929    <not supported>      clockticks                                                  
     2.000552765      <not counted> MiB  data_reads                                                  
     2.000552765    <not supported>      clockticks                                                  
     3.000846298      <not counted> MiB  data_reads                                                  
     3.000846298    <not supported>      clockticks                                                  
     4.001044852      <not counted> MiB  data_reads                                                  
     4.001044852    <not supported>      clockticks                                                  
     5.001247131      <not counted> MiB  data_reads                                                  
     5.001247131    <not supported>      clockticks                                                  
^C     5.546917060      <not counted> MiB  data_reads                                                  
     5.546917060    <not supported>      clockticks                                                  


jirka
