Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE22C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D209520874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2M66UERA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D209520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeFTNr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbeFTNr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:47:57 -0400
Received: from jouet.infradead.org (unknown [189.40.103.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5D120846;
        Wed, 20 Jun 2018 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529502477;
        bh=8lahS97MJobEncwu+YFdU44gOgybQv8KvmUuiIAk8uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2M66UERA6wjr7czvSnnTQhO/a1ODTyu0aK7Vm5U8aScdpipUoSxX6yGUaaHsmNk+N
         1xapI8VrwfU7K2FJZjY9Nv6qcfGGs9qm1KfLcX7R2M5Q7ovc3LkCZUAAOnWasF0czX
         3IsY87oP84qzHd/pswqBsbg5V+63DH6g0vZX8UUE=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 7415D1401E5; Wed, 20 Jun 2018 10:47:54 -0300 (-03)
Date:   Wed, 20 Jun 2018 10:47:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Hendrik =?iso-8859-1?Q?Br=FCckner?= 
        <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] perf test shell: Replace '|&' with '2>&1 |' to work
 with more shells
Message-ID: <20180620134754.GN20477@kernel.org>
References: <20180619184948.a2aabe8f0159f0fd589d4008@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619184948.a2aabe8f0159f0fd589d4008@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 19, 2018 at 06:49:48PM -0500, Kim Phillips escreveu:
> Since we do not specify bash (and/or zsh) as a requirement, use the

This one is minor, so could be acceptable, but then if we make bash a
requirement for 'perf test' due to the other patch in this series, we
could as well keep the shorter |& form

- Arnaldo

> standard error redirection that is more widely supported.
> 
> BEFORE:
> 
> $ sudo ./perf test -v 62
> 62: Check open filename arg using perf trace + vfs_getname:
> --- start ---
> test child forked, pid 27305
> ./tests/shell/trace+probe_vfs_getname.sh: 20: ./tests/shell/trace+probe_vfs_getname.sh: Syntax error: "&" unexpected
> test child finished with -2
> ---- end ----
> Check open filename arg using perf trace + vfs_getname: Skip
> 
> AFTER:
> 
> $ sudo ./perf test -v 64
> 64: Check open filename arg using perf trace + vfs_getname               :
> --- start ---
> test child forked, pid 23008
> Added new event:
>   probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)
> 
> You can now use it in all perf tools, such as:
> 
>         perf record -e probe:vfs_getname -aR sleep 1
> 
>      0.361 ( 0.008 ms): touch/23032 openat(dfd: CWD, filename: /tmp/temporary_file.VEh0n, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 4
> test child finished with 0
> ---- end ----
> Check open filename arg using perf trace + vfs_getname: Ok
> 
> Similar to commit 35435cd06081, with the same title.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> index 55ad9793d544..4ce276efe6b4 100755
> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -17,7 +17,7 @@ skip_if_no_perf_probe || exit 2
>  file=$(mktemp /tmp/temporary_file.XXXXX)
>  
>  trace_open_vfs_getname() {
> -	evts=$(echo $(perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
> +	evts=$(echo $(perf list syscalls:sys_enter_open* 2>&1 | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
>  	perf trace -e $evts touch $file 2>&1 | \
>  	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
>  }
> -- 
> 2.17.1
