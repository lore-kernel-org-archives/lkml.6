Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB53EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF1620844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7bYLw4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF1620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeIFWXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbeIFWXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:23:04 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFF620659;
        Thu,  6 Sep 2018 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536255990;
        bh=XuCDO0EVX3UpbyFbM6zUYmH41lJPIlg6MV187IMN7mE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7bYLw4oUWp+YdUmro5XbHawxZ0PCL/RPU0ea5biS+HSHHXPbnb2m17w8gn7fz/S1
         1N6JgqOVGhgptT3tLFKmmdLjtBsYmSBFZEeXEj7hmbgwozEPNRQxSxhAMpe4oLfgVA
         YJGJBpooBT/TsZumO78SbUkPGT+sKDwBWJ3nkNvY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id A8D15141FFC; Thu,  6 Sep 2018 14:46:27 -0300 (-03)
Date:   Thu, 6 Sep 2018 14:46:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tools: use PTR_ERR_OR_ZERO inetead of return code
Message-ID: <20180906174627.GA6853@kernel.org>
References: <1536234171-15970-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536234171-15970-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 06, 2018 at 07:42:51PM +0800, Ding Xiang escreveu:
> use PTR_ERR_OR_ZERO for bpf__setup_stdout return code
> 
> v2: add macro PTR_ERR_OR_ZERO to err.h

This really should be done in two patches, one introducing the
PTR_ERR_OR_ZERO() macro, and then the use of it in bpf-loader.c.

Thanks,

- Arnaldo
 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  tools/include/linux/err.h    | 7 +++++++
>  tools/perf/util/bpf-loader.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
> index 7a8b61a..0946496 100644
> --- a/tools/include/linux/err.h
> +++ b/tools/include/linux/err.h
> @@ -52,4 +52,11 @@ static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
>  	return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
>  }
>  
> +static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
> +{
> +	if (IS_ERR(ptr))
> +		return PTR_ERR(ptr);
> +	else
> +		return 0;
> +}
>  #endif /* _LINUX_ERR_H */
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 47aac41..f9ae1a9 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -1615,7 +1615,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
>  int bpf__setup_stdout(struct perf_evlist *evlist)
>  {
>  	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
> -	return IS_ERR(evsel) ? PTR_ERR(evsel) : 0;
> +	return PTR_ERR_OR_ZERO(evsel);
>  }
>  
>  #define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
> -- 
> 1.9.1
> 
> 
