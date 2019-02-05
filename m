Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BDAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75B420821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfBELdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:33:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:59615 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfBELdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:33:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 03:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="scan'208";a="140808117"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 05 Feb 2019 03:33:13 -0800
Received: from [10.125.252.139] (abudanko-mobl.ccr.corp.intel.com [10.125.252.139])
        by linux.intel.com (Postfix) with ESMTP id B9D3158044E;
        Tue,  5 Feb 2019 03:33:10 -0800 (PST)
Subject: Re: [PATCH 01/14] perf tools: Make rm_rf to remove single file
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
 <20190203153018.9650-2-jolsa@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6c505cd6-9b49-5c47-8e8d-5b1fa68d1a69@linux.intel.com>
Date:   Tue, 5 Feb 2019 14:33:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190203153018.9650-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.02.2019 18:30, Jiri Olsa wrote:
> Let rm_rf remove file if it's provided by path.
> 
> Link: http://lkml.kernel.org/n/tip-whhp3ej5795l9dc86xfyyp74@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/util.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 320b0fef249a..58b8d6a8bfbc 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -125,8 +125,14 @@ int rm_rf(const char *path)
>  	char namebuf[PATH_MAX];
>  
>  	dir = opendir(path);
> -	if (dir == NULL)
> -		return 0;
> +	if (dir == NULL) {
> +		/*
> +		 * The path does not exist or is not directory,
> +		 * so there's no harm to try remove it. This way
> +		 * rm_rf will work over single file.
> +		 */

This can also happen due to lack of fds or memory.
Not sure file still has to be deleted in these cases.

- Alexey

> +		return unlink(path);
> +	}
>  
>  	while ((d = readdir(dir)) != NULL && !ret) {
>  		struct stat statbuf;
> 
