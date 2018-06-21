Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3603FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E221E20874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E221E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeFUApu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:45:50 -0400
Received: from foss.arm.com ([217.140.101.70]:44452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754139AbeFUAps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:45:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BE591435;
        Wed, 20 Jun 2018 17:45:48 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 625053F578;
        Wed, 20 Jun 2018 17:45:47 -0700 (PDT)
Date:   Wed, 20 Jun 2018 19:45:46 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Hendrik =?ISO-8859-1?Q?Br=FCckner?= 
        <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf test shell: make perf inet_pton test more
 portable
Message-Id: <20180620194546.364cc109430ac51c5a288739@arm.com>
In-Reply-To: <20180620134622.GM20477@kernel.org>
References: <20180619184952.dac6a3a1e39d3b1d255e7119@arm.com>
        <20180620134622.GM20477@kernel.org>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 10:46:22 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Jun 19, 2018 at 06:49:52PM -0500, Kim Phillips escreveu:
> > Debian based systems such as Ubuntu have dash as their default shell.
> > Even if the normal or root user's shell is bash, certain scripts still
> > call /bin/sh, which points to dash, so we fix this perf test by
> > rewriting it in a more portable way.
> 
> Isn't it better to just make /bin/bash a requirement for these tests?

Perf is more bug-prone in distributions other than its main developers'
distributions, and when its own built-in tests start depending on those
same (primary) distributions' preferences, tests start to get skipped
on the secondary ones, which start to get subsequently ignored and
become acceptable to testers, which is a whole pattern I'd like to
avoid if at all possible.  I'd eventually like to see the real perf run
on Android, for example, and adding bash to Android is nontrivial,
AFAICT.

> I think the alternative is cryptic :-\

I think that's because of the fake array stuff, which technically isn't
needed by design.  How about something like the following?

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 263057039693..d5cceaeba42d 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -14,20 +14,21 @@ libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1
 nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 
 trace_libc_inet_pton_backtrace() {
+       newline='\n'
        idx=0
-       expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
-       expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
+       expected="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
+       expected="${expected}${newline}.*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
        case "$(uname -m)" in
        s390x)
                eventattr='call-graph=dwarf,max-stack=4'
-               expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
-               expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
-               expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
+               expected="${expected}${newline}gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
+               expected="${expected}${newline}(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
+               expected="${expected}${newline}main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
                ;;
        *)
                eventattr='max-stack=3'
-               expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
-               expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
+               expected="${expected}${newline}getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
+               expected="${expected}${newline}.*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
                ;;
        esac
 
@@ -35,14 +36,16 @@ trace_libc_inet_pton_backtrace() {
 
        perf record -e probe_libc:inet_pton/$eventattr/ -o $file ping -6 -c 1 ::1 > /dev/null 2>&1
        perf script -i $file | while read line ; do
+               [ -z "${line}" ] && break
                echo $line
-               echo "$line" | egrep -q "${expected[$idx]}"
+               idx=$((idx + 1))
+               first="$(echo ${expected} | head -$idx | tail -1)"
+               [ -z "${first}" ] && break
+               echo "$line" | egrep -q "$first"
                if [ $? -ne 0 ] ; then
-                       printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
+                       printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${first}" "$line"
                        exit 1
                fi
-               let idx+=1
-               [ -z "${expected[$idx]}" ] && break
        done
 
        # If any statements are executed from this point onwards,

Thanks,

Kim
