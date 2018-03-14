Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCNSyB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751985AbeCNSx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:53:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACC52077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 14 Mar 2018 15:53:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, wcohen@redhat.com,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] perf vendor events: fix processing for xfs
Message-ID: <20180314185355.GC27335@kernel.org>
References: <1521047452-28565-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521047452-28565-1-git-send-email-john.garry@huawei.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 15, 2018 at 01:10:52AM +0800, John Garry escreveu:
> In the recently introduced support for vendor subdirectory,
> the checking for directory entries under xfs (or any other fs
> which does not support dirent.d_type) is missing the check
> for links for current and parent directory. This can result
> in a broken pmu_events.c being generated.
> 
> Fix this by adding the appropriate check in is_leaf_dir().

So I'll lookup the patch that introduced the patch and squash this one
with it, so that we don't break 'git bisect' on ppc.

- Arnaldo
 
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 1c01844..db3a594 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -873,7 +873,10 @@ static int is_leaf_dir(const char *fpath)
>  		return 0;
>  
>  	while ((dir = readdir(d)) != NULL) {
> -		if (dir->d_type == DT_DIR && dir->d_name[0] != '.') {
> +		if (!strcmp(dir->d_name, ".") || !strcmp(dir->d_name, ".."))
> +			continue;
> +
> +		if (dir->d_type == DT_DIR) {
>  			res = 0;
>  			break;
>  		} else if (dir->d_type == DT_UNKNOWN) {
> -- 
> 1.9.1
