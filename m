Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFC6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7A4205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPnJNBGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7A4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeGTPq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbeGTPq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:46:27 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9989B205C9;
        Fri, 20 Jul 2018 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532098667;
        bh=0Q+GFpOOsnUxkNSzkpt/9Y9KutYg9oXsjSfM7p3bruM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPnJNBGBW8jLTjWzq3wdt5gHNXo2CerReT7nFy7wjFVpPJRlUeKpIQH4MDKIDmSdj
         ni71KPXyDeRkLmQ1b/apCqiRA7W12sFIcVpyLFTCDmgGB4gqK7njA0KFxxxDz0ijdG
         HYTzKzdnX4cyzoHisUav31yob+GrmRRyBYiGgC3s=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 325D4140260; Fri, 20 Jul 2018 11:57:45 -0300 (-03)
Date:   Fri, 20 Jul 2018 11:57:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 3/4] perf tools: Fix check-headers.sh output file
 variables
Message-ID: <20180720145745.GB4329@kernel.org>
References: <20180720110036.32251-1-jolsa@kernel.org>
 <20180720110036.32251-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720110036.32251-3-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 20, 2018 at 01:00:35PM +0200, Jiri Olsa escreveu:
> The warning message in check_w function uses wrongly
> the $file variable instead of $file1 and $file2.

Humm,

Before:

Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'

After:

Warning: Kernel ABI header at '../arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at '../../arch/powerpc/include/uapi/asm/unistd.h'


The previous version is better, I can then just use:

diff -u tools/arch/powerpc/include/uapi/asm/unistd.h arch/powerpc/include/uapi/asm/unistd.h

and get what changed, with your change I have to go to tools/perf before
doing that diff, which is an unnecessary extra step in at least my
workflow.

- Arnaldo

 
> Fixes: 582472973593 ("perf check-headers.sh: Add support to check 2 independent files")
> Link: http://lkml.kernel.org/n/tip-oh56ckqztoc07we7mtdphu7r@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/check-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 814aaf269949..73e723675c5f 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -67,7 +67,7 @@ check_2 () {
>    cmd="diff $* $file1 $file2 > /dev/null"
>  
>    test -f $file2 &&
> -  eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
> +  eval $cmd || echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
>  }
>  
>  check () {
> -- 
> 2.17.1
