Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbeBFTIc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752702AbeBFTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:08:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776AD214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Feb 2018 16:08:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 05/17] tools lib api fs: Add sysfs__read_xll function
Message-ID: <20180206190821.GE3451@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
 <20180206181813.10943-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206181813.10943-6-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 06, 2018 at 07:18:01PM +0100, Jiri Olsa escreveu:
> Adding sysfs__read_xll function to be able to read sysfs
> files with hex numbers in, which do not have 0x prefix.

Applied 2-5 in this series, continuing...

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-j5ullvrcli5ga3hn6692t2aw@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/api/fs/fs.c | 15 +++++++++++++--
>  tools/lib/api/fs/fs.h |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
> index 8b0e4a4315bd..6a12bbf39f7b 100644
> --- a/tools/lib/api/fs/fs.c
> +++ b/tools/lib/api/fs/fs.c
> @@ -432,7 +432,8 @@ int procfs__read_str(const char *entry, char **buf, size_t *sizep)
>  	return filename__read_str(path, buf, sizep);
>  }
>  
> -int sysfs__read_ull(const char *entry, unsigned long long *value)
> +static int sysfs__read_ull_base(const char *entry,
> +				unsigned long long *value, int base)
>  {
>  	char path[PATH_MAX];
>  	const char *sysfs = sysfs__mountpoint();
> @@ -442,7 +443,17 @@ int sysfs__read_ull(const char *entry, unsigned long long *value)
>  
>  	snprintf(path, sizeof(path), "%s/%s", sysfs, entry);
>  
> -	return filename__read_ull(path, value);
> +	return filename__read_ull_base(path, value, base);
> +}
> +
> +int sysfs__read_xll(const char *entry, unsigned long long *value)
> +{
> +	return sysfs__read_ull_base(entry, value, 16);
> +}
> +
> +int sysfs__read_ull(const char *entry, unsigned long long *value)
> +{
> +	return sysfs__read_ull_base(entry, value, 0);
>  }
>  
>  int sysfs__read_int(const char *entry, int *value)
> diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
> index 8ebee35a6395..92d03b8396b1 100644
> --- a/tools/lib/api/fs/fs.h
> +++ b/tools/lib/api/fs/fs.h
> @@ -40,6 +40,7 @@ int procfs__read_str(const char *entry, char **buf, size_t *sizep);
>  int sysctl__read_int(const char *sysctl, int *value);
>  int sysfs__read_int(const char *entry, int *value);
>  int sysfs__read_ull(const char *entry, unsigned long long *value);
> +int sysfs__read_xll(const char *entry, unsigned long long *value);
>  int sysfs__read_str(const char *entry, char **buf, size_t *sizep);
>  int sysfs__read_bool(const char *entry, bool *value);
>  
> -- 
> 2.13.6
