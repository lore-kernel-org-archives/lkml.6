Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7922DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532462080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfBELxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:53:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:8970 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfBELxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:53:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 03:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="scan'208";a="316450896"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 05 Feb 2019 03:53:01 -0800
Received: from [10.125.252.139] (abudanko-mobl.ccr.corp.intel.com [10.125.252.139])
        by linux.intel.com (Postfix) with ESMTP id 5D9CC580487;
        Tue,  5 Feb 2019 03:52:59 -0800 (PST)
Subject: Re: [PATCH 06/14] perf data: Add perf_data__(create_dir|free_dir)
 functions
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
References: <20190203153018.9650-1-jolsa@kernel.org>
 <20190203153018.9650-7-jolsa@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <19a2d4fd-11b4-dc80-2d0a-c4bccd95736c@linux.intel.com>
Date:   Tue, 5 Feb 2019 14:52:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190203153018.9650-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.02.2019 18:30, Jiri Olsa wrote:
> Adding perf_data__create_dir to create nr files inside
> struct perf_data path directory:
>   int perf_data__create_dir(struct perf_data *data, int nr);
> 
> and function to free that data:
>   void perf_data__free_dir(struct perf_data *data);
> 
> Link: http://lkml.kernel.org/n/tip-kl4s1f13cg6wycrg367p85qm@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/data.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/data.h |  8 +++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 0a3051cc0ea0..ff1d9e5bd68d 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -7,11 +7,58 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <string.h>
> +#include <asm/bug.h>
>  
>  #include "data.h"
>  #include "util.h"
>  #include "debug.h"
>  
> +static void free_dir(struct perf_data_file *files, int nr)
> +{
> +	while (--nr >= 1) {
> +		close(files[nr].fd);
> +		free(files[nr].path);
> +	}
> +	free(files);

It implements closing of created files and frees corresponding memory.
However it doesn't delete the files what looks like the proper rollback
from perf_data__create_dir() in case of some open() failure.

> +}
> +
> +void perf_data__free_dir(struct perf_data *data)
> +{
> +	free_dir(data->dir.files, data->dir.nr);
> +}
> +
> +int perf_data__create_dir(struct perf_data *data, int nr)
> +{
> +	struct perf_data_file *files = NULL;
> +	int i, ret = -1;
> +
> +	files = malloc(nr * sizeof(*files));
> +	if (!files)
> +		return -ENOMEM;
> +
> +	data->dir.files = files;
> +	data->dir.nr    = nr;
> +
> +	for (i = 0; i < nr; i++) {
> +		struct perf_data_file *file = &files[i];
> +
> +		if (asprintf(&file->path, "%s/data.%d", data->path, i) < 0)
> +			goto out_err;
> +
> +		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
> +		if (ret < 0)
> +			goto out_err;
> +
> +		file->fd = ret;
> +	}
> +
> +	return 0;
> +
> +out_err:
> +	free_dir(files, i);

It looks like this is more unlink(dir) than close_files_in_dir().

Alexey

> +	return ret;
> +}
> +
>  static bool check_pipe(struct perf_data *data)
>  {
>  	struct stat st;
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 2bce28117ccf..3b4115dc777f 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -21,6 +21,11 @@ struct perf_data {
>  	bool			 is_pipe;
>  	bool			 force;
>  	enum perf_data_mode	 mode;
> +
> +	struct {
> +		struct perf_data_file	*files;
> +		int			 nr;
> +	} dir;
>  };
>  
>  static inline bool perf_data__is_read(struct perf_data *data)
> @@ -64,4 +69,7 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
>  int perf_data__switch(struct perf_data *data,
>  			   const char *postfix,
>  			   size_t pos, bool at_exit);
> +
> +int perf_data__create_dir(struct perf_data *data, int nr);
> +void perf_data__free_dir(struct perf_data *data);
>  #endif /* __PERF_DATA_H */
> 
