Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBHNzx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:55:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750929AbeBHNzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:55:52 -0500
Date: Thu, 8 Feb 2018 14:55:49 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, wcohen@redhat.com, will.deacon@arm.com,
        ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] perf utils: add support for arch standard events
Message-ID: <20180208135549.GK10234@krava>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517939104-230881-6-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:
> For some architectures (like arm), there are architecture-
> defined events. Sometimes these events may be "recommended"
> according to the architecture standard, in that the
> implementer is free ignore the "recommendation" and create
> its custom event.
> 
> This patch adds support for parsing standard events from
> arch-defined JSONs, and fixing up vendor events when they
> have implemented these events as standard.
> 
> Support is also ensured that the vendor may implement their
> own custom events.
> 
> A new step is added to the pmu events parsing to fix up the
> vendor events with the arch-standard events.
> 
> The arch-defined JSONs must be placed in the arch root
> folder for preprocessing prior to tree JSON processing.
> 
> In the vendor JSON, to specify that the arch event is
> supported, the keyword "ArchStdEvent" should be used,
> like this:
> [
>     {
>         "ArchStdEvent": "0x41",
> 	"BriefDescription": "L1D cache access, write"
>     },
> ]
> 
> No other JSON objects are strictly required. However,
> for other objects added, these take precedence over
> architecture defined standard events, thus supporting
> separate events which have the same event code.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/pmu-events/Build     |   1 +
>  tools/perf/pmu-events/README    |   6 ++
>  tools/perf/pmu-events/jevents.c | 185 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 182 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 999a4e8..f9e8466 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -1,5 +1,6 @@
>  hostprogs := jevents
>  
> +CHOSTFLAGS	= -I$(srctree)/tools/include

Ithink this could be just CHOSTFLAGS_jevents.o = -I$(srctree)/tools/include
it's just for the list.h right?

jirka
