Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A38AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023BF20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT6Yn4Tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023BF20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeFTNq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753960AbeFTNq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:46:27 -0400
Received: from jouet.infradead.org (unknown [189.40.103.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8564220874;
        Wed, 20 Jun 2018 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529502387;
        bh=OSTgzCRXjAoXANDdFVPVAnTHSKfIsw8b4/F+8H/orDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rT6Yn4Tx0lZ/Yt8k3Mdm+l07Ol1hpLN8t8nqBY3wen73fgRuyzwGDyfXCDyJXQ5+w
         h4QS5Oz45MdTd3ZFsRU4uCb8WdfDIqCjTZ5jJkrete2zlILX1ZDyDdsOEJae8c54/B
         tWVl/T/eF8qVSUlmSzLz8mNAG0GaN1yu3jaYIJW4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id CC9851401E5; Wed, 20 Jun 2018 10:46:22 -0300 (-03)
Date:   Wed, 20 Jun 2018 10:46:22 -0300
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
Subject: Re: [PATCH 2/2] perf test shell: make perf inet_pton test more
 portable
Message-ID: <20180620134622.GM20477@kernel.org>
References: <20180619184952.dac6a3a1e39d3b1d255e7119@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619184952.dac6a3a1e39d3b1d255e7119@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 19, 2018 at 06:49:52PM -0500, Kim Phillips escreveu:
> Debian based systems such as Ubuntu have dash as their default shell.
> Even if the normal or root user's shell is bash, certain scripts still
> call /bin/sh, which points to dash, so we fix this perf test by
> rewriting it in a more portable way.

Isn't it better to just make /bin/bash a requirement for these tests?

I think the alternative is cryptic :-\

Thanks,

- Arnaldo
 
> BEFORE:
> 
> $ sudo ./perf test -v 64
> 64: probe libc's inet_pton & backtrace it with ping       :
> --- start ---
> test child forked, pid 31942
> ./tests/shell/record+probe_libc_inet_pton.sh: 18: ./tests/shell/record+probe_libc_inet_pton.sh: expected[0]=ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\): not found
> ./tests/shell/record+probe_libc_inet_pton.sh: 19: ./tests/shell/record+probe_libc_inet_pton.sh: expected[1]=.*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/lib/x86_64-linux-gnu/libc-2.27.so|inlined\)$: not found
> ./tests/shell/record+probe_libc_inet_pton.sh: 29: ./tests/shell/record+probe_libc_inet_pton.sh: expected[2]=getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/lib/x86_64-linux-gnu/libc-2.27.so\)$: not found
> ./tests/shell/record+probe_libc_inet_pton.sh: 30: ./tests/shell/record+probe_libc_inet_pton.sh: expected[3]=.*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$: not found
> ping 31963 [004] 83577.670613: probe_libc:inet_pton: (7fe15f87f4b0)
> ./tests/shell/record+probe_libc_inet_pton.sh: 39: ./tests/shell/record+probe_libc_inet_pton.sh: Bad substitution
> ./tests/shell/record+probe_libc_inet_pton.sh: 41: ./tests/shell/record+probe_libc_inet_pton.sh: Bad substitution
> test child finished with -2
> ---- end ----
> probe libc's inet_pton & backtrace it with ping: Skip
> 
> AFTER:
> 
> 64: probe libc's inet_pton & backtrace it with ping       :
> --- start ---
> test child forked, pid 32277
> ping 32295 [001] 83679.690020: probe_libc:inet_pton: (7ff244f504b0)
> 7ff244f504b0 __GI___inet_pton+0x0 (/lib/x86_64-linux-gnu/libc-2.27.so)
> 7ff244f14ce4 getaddrinfo+0x124 (/lib/x86_64-linux-gnu/libc-2.27.so)
> 556ac036b57d _init+0xb75 (/bin/ping)
> test child finished with 0
> ---- end ----
> probe libc's inet_pton & backtrace it with ping: Ok
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: "Hendrik Brückner" <brueckner@linux.vnet.ibm.com>
> Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
> Fixed using fake array technique described here:
> 
> https://www.linuxquestions.org/questions/programming-9/basic-bash-how-to-use-eval-to-evaluate-variable-names-made-of-arbitrary-strings-775622/
> 
> Note that bashisms can also be found with 'checkbashisms':
> 
> $ checkbashisms record+probe_libc_inet_pton.sh
> script record+probe_libc_inet_pton.sh does not appear to have a #! interpreter line;
> you may get strange results
> possible bashism in record+probe_libc_inet_pton.sh line 18 (bash arrays, H[0]):
> 	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
> possible bashism in record+probe_libc_inet_pton.sh line 19 (bash arrays, H[0]):
> 	expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 23 (bash arrays, H[0]):
> 		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 24 (bash arrays, H[0]):
> 		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 25 (bash arrays, H[0]):
> 		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 29 (bash arrays, H[0]):
> 		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 30 (bash arrays, H[0]):
> 		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 39 (bash arrays, ${name[0|*|@]}):
> 		echo "$line" | egrep -q "${expected[$idx]}"
> possible bashism in record+probe_libc_inet_pton.sh line 41 (bash arrays, ${name[0|*|@]}):
> 			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
> possible bashism in record+probe_libc_inet_pton.sh line 44 (let ...):
> 		let idx+=1
> possible bashism in record+probe_libc_inet_pton.sh line 45 (bash arrays, ${name[0|*|@]}):
> 		[ -z "${expected[$idx]}" ] && break
> 
>  .../shell/record+probe_libc_inet_pton.sh      | 23 ++++++++++---------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 263057039693..41124fa12913 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -15,19 +15,20 @@ nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
>  
>  trace_libc_inet_pton_backtrace() {
>  	idx=0
> -	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
> -	expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> +	expected='expected'
> +	eval ${expected}0="'ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)'"
> +	eval ${expected}1="'.*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$'"
>  	case "$(uname -m)" in
>  	s390x)
>  		eventattr='call-graph=dwarf,max-stack=4'
> -		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> -		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> -		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> +		eval ${expected}2="'gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$'"
> +		eval ${expected}3="'(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$'"
> +		eval ${expected}4="'main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$'"
>  		;;
>  	*)
>  		eventattr='max-stack=3'
> -		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
> -		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> +		eval ${expected}2="'getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$'"
> +		eval ${expected}3="'.*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$'"
>  		;;
>  	esac
>  
> @@ -36,13 +37,13 @@ trace_libc_inet_pton_backtrace() {
>  	perf record -e probe_libc:inet_pton/$eventattr/ -o $file ping -6 -c 1 ::1 > /dev/null 2>&1
>  	perf script -i $file | while read line ; do
>  		echo $line
> -		echo "$line" | egrep -q "${expected[$idx]}"
> +		echo "$line" | egrep -q "$(echo $(eval echo \$$expected${idx}))"
>  		if [ $? -ne 0 ] ; then
> -			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
> +			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "$(echo $(eval echo \$$expected${idx}))" "$line"
>  			exit 1
>  		fi
> -		let idx+=1
> -		[ -z "${expected[$idx]}" ] && break
> +		idx=$((idx+1))
> +		[ -z "$(echo $(eval echo \$$expected${idx}))" ] && break
>  	done
>  
>  	# If any statements are executed from this point onwards,
> -- 
> 2.17.1
