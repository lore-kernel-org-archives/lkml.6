Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeDLNFT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbeDLNFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:05:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B77521745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 12 Apr 2018 10:05:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf record: Remove unnecessary warning for missing
 sysfs entry
Message-ID: <20180412130513.GB9818@kernel.org>
References: <20180412114723.48550-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412114723.48550-1-tmricht@linux.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 12, 2018 at 01:47:23PM +0200, Thomas Richter escreveu:
> Using perf on 4.16.0 kernel on s390 shows warning
>    failed: can't open node sysfs data
> each time I run command perf record ... for example:
> 
> [root@s35lp76 perf]# ./perf record -e rB0000 -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> failed: can't open node sysfs data
> [ perf record: Captured and wrote 0.001 MB perf.data (4 samples) ]
> [root@s35lp76 perf]#
> 
> BTW: I find this error message not very informative.

What an understatement :-)
 
> It turns out commit e2091cedd51bf ("perf tools: Add MEM_TOPOLOGY
> feature to perf data file") tries to open directory named
> /sys/devices/system/node/ which does not exist on s390.
> 
> This is the call stack:
>  __cmd_record
>  +---> perf_session__write_header
>        +---> perf_header__adds_write
>              +---> do_write_feat
> 	           +---> write_mem_topology
> 		         +---> build_mem_topology
> 			       prints warning
> The issue starts in do_write_feat() which unconditionally
> loops over all features and now includes HEADER_MEM_TOPOLOGY and calls
> write_mem_topology().
> Function record__init_features() at the beginning of __cmd_record()
> sets all features and then turns off some.
> 
> Fix this by removed the warning, if the directory is not present
> memory node information is not available and won't be displayed.

Can't we instead improve the error message and turn this into a
pr_debug2? Isn't it a reasonable scenario that the user expects this
topology information to be present and then ends up without it?

Perhaps something like:

	pr_debug2("%s: could't read %s, does this arch have topology information?\n", __func__, path);

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/header.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 121df1683c36..4a3bfc900a68 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1320,7 +1320,6 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
>  
>  	dir = opendir(path);
>  	if (!dir) {
> -		pr_warning("failed: can't open node sysfs data\n");
>  		return -1;
>  	}
>  
> -- 
> 2.14.3
