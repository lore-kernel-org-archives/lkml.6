Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeBAVXV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:23:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751821AbeBAVXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:23:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD82217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 1 Feb 2018 18:23:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@intel.com
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, jolsa@kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH V5 02/17] perf mmap: fix: recalculate size for overwrite
 mode.
Message-ID: <20180201212313.GD4835@kernel.org>
References: <1516310792-208685-1-git-send-email-kan.liang@intel.com>
 <1516310792-208685-3-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516310792-208685-3-git-send-email-kan.liang@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 18, 2018 at 01:26:17PM -0800, kan.liang@intel.com escreveu:
> From: Kan Liang <kan.liang@intel.com>
> 
> In perf_mmap__push(), the 'size' need to be recalculated, otherwise the
> invalid data might be pushed to the record in overwrite mode.
> 
> The issue is introduced by commit 7fb4b407a124 ("perf mmap: Don't
> discard prev in backward mode").

In these cases, please add the Fixes tag, like:

Fixes: 7fb4b407a124 ("perf mmap: Don't discard prev in backward mode")

I'm doing it this time.

Thanks,

- Arnaldo
 
> When the ringbuffer is full in overwrite mode, backward_rb_find_range
> will be called to recalculate the 'start' and 'end'. The 'size' needs to
> be recalculated accordingly.
> 
> Unconditionally recalculate the 'size', not just for full ringbuffer in
> overwrite mode. Because,
> - There is no harmful to recalculate the 'size' for other cases.
> - The code of calculating 'start' and 'end' will be factored out later.
>   The new function does not need to return 'size'.
> 
> Signed-off-by: Kan Liang <kan.liang@intel.com>
> ---
>  tools/perf/util/mmap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 05076e6..97cf4fa 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -302,6 +302,8 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
>  			return -1;
>  	}
>  
> +	size = end - start;
> +
>  	if ((start & md->mask) + size != (end & md->mask)) {
>  		buf = &data[start & md->mask];
>  		size = md->mask + 1 - (start & md->mask);
> -- 
> 2.5.5
