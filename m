Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7717C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E31420C01
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfBQXWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:22:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfBQXWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:22:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D36BA7DCF3;
        Sun, 17 Feb 2019 23:22:51 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4C4E560BF7;
        Sun, 17 Feb 2019 23:22:46 +0000 (UTC)
Date:   Mon, 18 Feb 2019 00:22:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: update perf.data file format documentation
Message-ID: <20190217232246.GB26460@krava>
References: <20190215182823.303-1-jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215182823.303-1-jonas.rabenstein@studium.uni-erlangen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 17 Feb 2019 23:22:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 07:28:23PM +0100, Jonas Rabenstein wrote:
> I found that the documentation of the flags section is some how
> different from the actual format used and expected by the perf
> tools. In this patch the according section of the file format
> documentation is updated to conform to the expectations of the
> perf tool suite.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> ---
>  .../perf/Documentation/perf.data-file-format.txt  | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index dfb218feaad9..6ea199f28330 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -43,13 +43,10 @@ struct perf_file_section {
>  
>  Flags section:
>  
> -The header is followed by different optional headers, described by the bits set
> -in flags. Only headers for which the bit is set are included. Each header
> -consists of a perf_file_section located after the initial header.
> -The respective perf_file_section points to the data of the additional
> -header and defines its size.
> -
> -Some headers consist of strings, which are defined like this:
> +The Flags section is placed directly after the data section and consists of a
> +variable amount of information described by the flags-bitset in the perf_header.
> +A lot of the headers in the Flags section are simple strings and are represented
> +like this:

some how I find this more confusing.. please describe
what's actualy wrong with the current wording

>  
>  struct perf_header_string {
>         uint32_t len;
> @@ -82,7 +79,7 @@ assigned by the linker to an executable.
>  struct build_id_event {
>  	struct perf_event_header header;
>  	pid_t			 pid;
> -	uint8_t			 build_id[24];
> +	uint8_t			 build_id[PERF_ALIGN(24, sizeof(u64))];

isn't that always 24? I guess u meant:

  build_id[PERF_ALIGN(20, sizeof(u64))];


>  	char			 filename[header.size - offsetof(struct build_id_event, filename)];
>  };
>  
> @@ -131,7 +128,7 @@ An uint64_t with the total memory in bytes.
>  
>  	HEADER_CMDLINE = 11,
>  
> -A perf_header_string with the perf command line used to collect the data.
> +A perf_header_string_list with the perf arg-vector used to collect the data.

nice catch

thanks,
jirka

>  
>  	HEADER_EVENT_DESC = 12,
>  
> -- 
> 2.17.1
> 
