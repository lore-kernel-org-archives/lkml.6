Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93521C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFE527E8C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILQx5rW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFE527E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755604AbeF2PRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbeF2PRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:17:39 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C3F27E8C;
        Fri, 29 Jun 2018 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530285459;
        bh=PP0jiIMQKZk3z6o36X23OITjazyuAFSbyt+4yvU1Ass=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ILQx5rW13G7Qsz8TqONxu4g6tVBmc+9L1C3IDWliqVVFRqbobtzZX1d7MKPC7IOhE
         QdFfiRNKKi3jEa4XRdSSQ8Ak41rmgioAb4c6UDWnfTpwB7IkKnt+Dk+AAktS7YmwcB
         C5VGFUAQmZUNX/nCq3bLlu/urvaCyO3VMwV8unG4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 1B87B1403D2; Fri, 29 Jun 2018 12:17:36 -0300 (-03)
Date:   Fri, 29 Jun 2018 12:17:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf test record+probe_libc_inet_pton: expect [unknown]
 for ping as well
Message-ID: <20180629151736.GA3593@kernel.org>
References: <1530170160-4979-1-git-send-email-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530170160-4979-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 28, 2018 at 03:16:00PM +0800, Li Zhijian escreveu:
> On system which has not installed debuginfo of iputils(ping) will fail like:
> ~/lkp/linux/tools/perf$ sudo ./perf test ping -v

I think that we should try to check if the required debuginfo package is
installed and if so, expect the symbol resolution that takes place in
that case. Other wise expect [unknown], this way we don't leave this
test accepting almost anything in any case.

- Arnaldo

> 63: probe libc's inet_pton & backtrace it with ping       :
> --- start ---
> test child forked, pid 4207
> ping 4224 [007] 3034121.295510: probe_libc:inet_pton: (7fedfccb2200)
> 7fedfccb2200 __GI___inet_pton+0x0 (/lib/x86_64-linux-gnu/libc-2.23.so)
> 7fedfcc7ad5e getaddrinfo+0xee (/lib/x86_64-linux-gnu/libc-2.23.so)
> 55e3239a9f4d [unknown] (/bin/ping)
> FAIL: expected backtrace entry 3
> ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" got "55e3239a9f4d [unknown] (/bin/ping)"
> test child finished with -1
> ---- end ----
> probe libc's inet_pton & backtrace it with ping: FAILED!
> 
> To be compatible with this system, expects [unknown] as well
> 
> Fixes: 7903a7086723 ("perf script: Show symbol offsets by default")
> CC: Sandipan Das <sandipan@linux.vnet.ibm.com>
> CC: Thomas Richter <tmricht@linux.ibm.com>
> Reported-by: kernel test robot <xiaolong.ye@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 2630570..ebb6549 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -22,12 +22,12 @@ trace_libc_inet_pton_backtrace() {
>  		eventattr='call-graph=dwarf,max-stack=4'
>  		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
>  		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> -		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> +		expected[4]=".*(\+0x[[:xdigit:]]|\[unknown\])+[[:space:]]\(.*/bin/ping.*\)$"
>  		;;
>  	*)
>  		eventattr='max-stack=3'
>  		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
> -		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> +		expected[3]=".*(\+0x[[:xdigit:]]|\[unknown\])+[[:space:]]\(.*/bin/ping.*\)$"
>  		;;
>  	esac
>  
> -- 
> 2.7.4
