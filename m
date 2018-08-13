Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC2C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C027E217AC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C027E217AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeHMN6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:58:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728055AbeHMN6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:58:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5060400138A;
        Mon, 13 Aug 2018 11:16:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 374C51C59E;
        Mon, 13 Aug 2018 11:16:32 +0000 (UTC)
Date:   Mon, 13 Aug 2018 13:16:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     jolsa@kernel.org, acme@kernel.org, mingo@kernel.org,
        namhyung@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, a.p.zijlstra@chello.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix check-headers.sh AND list path of
 execution
Message-ID: <20180813111631.GA718@krava>
References: <20180723070145.GB7523@krava>
 <20180811083915.17471-1-alexander.kapshuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811083915.17471-1-alexander.kapshuk@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 13 Aug 2018 11:16:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 13 Aug 2018 11:16:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 11:39:15AM +0300, Alexander Kapshuk wrote:
> The '||' path of execution in the 'test' block of the check_2() function
> may also be taken if file2 does not exist, in which case the warning
> message about the ABI headers being different would still be printed
> where it should not be.  See below.
> 
> % file1=file1; file2=file2
> % cmd="echo diff $file1 $file2"
> % test -f $file2 &&
> eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file1'
> differs from latest version at '$file2'" >&2
> Warning: Kernel ABI header at 'tools/file1' differs from latest
> version at 'file2'
> 
> The proposed patch converts the code following the '&&' operator into a
> compound list to be executed in the current process environment only if
> file2 does exist. Should the files being compared differ, a diff command
> to compare the files concerned is printed on standard output. E.g.
> 
> diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
> 
> Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>

I posted follow up patches based on this one
as a reply on this patch

for this one:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/check-headers.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index de28466c0186..ea48aa6f8d19 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -67,8 +67,12 @@ check_2 () {
>  
>    cmd="diff $* $file1 $file2 > /dev/null"
>  
> -  test -f $file2 &&
> -  eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
> +  test -f $file2 && {
> +    eval $cmd || {
> +      echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
> +      echo diff -u tools/$file $file
> +    }
> +  }
>  }
>  
>  check () {
> -- 
> 2.18.0
> 
