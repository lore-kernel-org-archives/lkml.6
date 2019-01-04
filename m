Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA48C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47E121874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfADMyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:54:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfADMyp (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:54:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5A06C068BF8;
        Fri,  4 Jan 2019 12:54:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id B883D608C6;
        Fri,  4 Jan 2019 12:54:42 +0000 (UTC)
Date:   Fri, 4 Jan 2019 13:54:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Poll for monitored tasks being alive in fork
 mode
Message-ID: <20190104125441.GF5481@krava>
References: <1546568897-16123-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546568897-16123-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 04 Jan 2019 12:54:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 10:28:17AM +0800, Jin Yao wrote:
> Following test shows the stat keeps running even if no longer
> task to monitor (mgen exits at ~5s).
> 
> perf stat -e cycles -p `pgrep mgen` -I1000 -- sleep 10
>             time             counts unit events
>      1.000148916      1,308,365,864      cycles
>      2.000379171      1,297,269,875      cycles
>      3.000556719      1,297,187,078      cycles
>      4.000914241        761,261,827      cycles
>      5.001306091      <not counted>      cycles
>      6.001676881      <not counted>      cycles
>      7.002046336      <not counted>      cycles
>      8.002405651      <not counted>      cycles
>      9.002766625      <not counted>      cycles
>     10.001395827      <not counted>      cycles
> 
> We'd better finish stat immediately if there's no longer task to
> monitor.
> 
> After:
> 
> perf stat -e cycles -p `pgrep mgen` -I1000 -- sleep 10
>             time             counts unit events
>      1.000180062      1,236,592,661      cycles
>      2.000421539      1,223,733,572      cycles
>      3.000609910      1,297,047,663      cycles
>      4.000807545      1,297,215,816      cycles
>      5.001001578      1,297,208,032      cycles
>      6.001390345        582,343,659      cycles
> sleep: Terminated
> 
> Now the stat exits immediately when the monitored tasks ends.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 63a3afc..71f3bc8 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -553,6 +553,13 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  
>  		if (interval || timeout) {
>  			while (!waitpid(child_pid, &status, WNOHANG)) {
> +				if (!is_target_alive(&target,
> +					evsel_list->threads) &&
> +					(child_pid != -1)) {

do we need that child_pid check? we just returned from waitpid
so we should be ok.. we just make the race window smaller

could we just do:

				if (!is_target_alive(&target, evsel_list->threads)) {
					kill(child_pid, SIGTERM);
					break;
				}

also I'm not sure we should do this only under new option,
as it might break people's scripts.. thoughts?

jirka

> +					kill(child_pid, SIGTERM);
> +					break;
> +				}
> +
>  				nanosleep(&ts, NULL);
>  				if (timeout)
>  					break;
> -- 
> 2.7.4
> 
