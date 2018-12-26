Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96131C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AEF2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545853428;
	bh=P91yVx0HDx5C2WBO/pS4qL3kHc55TZ6fOvfJwK6+38I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SXHAIE0ZJN54PhWrOI/GmPTGxVfdY82d6RUpmMFlqPzLAMlRgBsb1lbrZDdB/Q+hg
	 mBXuQVmm9lSkHLqz3OwfQWNj+GKAQ0I4lVFQF1vVPxxKCrQo6lamL0vQWkXteskkrQ
	 V78NA2n1u3Q0MjKTBXKvFJmtR7ffIZyjWEwzUn2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeLZTnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbeLZTnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:43:46 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E113E214D8;
        Wed, 26 Dec 2018 19:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545853426;
        bh=P91yVx0HDx5C2WBO/pS4qL3kHc55TZ6fOvfJwK6+38I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ia2bTaazUmbXbMcKa4g1jadBVRKlebyT4ANXR2wGRiFdcN08VX2b0YKajU4AQlreh
         pmT8Y0Hu71cZ+UaWGTu8/Wa6T96rhO/bgsveKcYpmfMn+3nS4FCRywOnPzO1EgpOlg
         UYA8uT/reEEuwI2rA77Rw4q+jg6fM4wXRdw2lpWs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B08CF403A8; Wed, 26 Dec 2018 16:43:42 -0300 (-03)
Date:   Wed, 26 Dec 2018 16:43:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 1/5] perf session: Get rid of file_size variable
Message-ID: <20181226194342.GA19471@kernel.org>
References: <20181226135132.29330-1-jolsa@kernel.org>
 <20181226135132.29330-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226135132.29330-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 26, 2018 at 02:51:28PM +0100, Jiri Olsa escreveu:
> It's not needed and removing it makes the code little
> more simple for upcoming changes.
> 
> It's safe to replace file_size with data_size, because
> perf_data__size value is never smaller than data_offset
> + data_size.

This is not applying to my perf/core branch, can you check?

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-ocz7zwwkkx11v0mkxrtcddih@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/session.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 3972f081a8f4..d6c1d3853f27 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1818,7 +1818,6 @@ static int __perf_session__process_events(struct perf_session *session)
>  	struct ordered_events *oe = &session->ordered_events;
>  	struct perf_tool *tool = session->tool;
>  	int fd = perf_data__fd(session->data);
> -	u64 file_size = perf_data__size(session->data);
>  	u64 data_offset = session->header.data_offset;
>  	u64 data_size = session->header.data_size;
>  	u64 head, page_offset, file_offset, file_pos, size;
> @@ -1838,14 +1837,13 @@ static int __perf_session__process_events(struct perf_session *session)
>  	if (data_size == 0)
>  		goto out;
>  
> -	if (data_offset + data_size < file_size)
> -		file_size = data_offset + data_size;
> +	ui_progress__init_size(&prog, data_size, "Processing events...");
>  
> -	ui_progress__init_size(&prog, file_size, "Processing events...");
> +	data_size += data_offset;
>  
>  	mmap_size = MMAP_SIZE;
> -	if (mmap_size > file_size) {
> -		mmap_size = file_size;
> +	if (mmap_size > data_size) {
> +		mmap_size = data_size;
>  		session->one_mmap = true;
>  	}
>  
> @@ -1910,7 +1908,7 @@ static int __perf_session__process_events(struct perf_session *session)
>  	if (session_done())
>  		goto out;
>  
> -	if (file_pos < file_size)
> +	if (file_pos < data_size)
>  		goto more;
>  
>  out:
> -- 
> 2.17.2

-- 

- Arnaldo
