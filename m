Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAA6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3663C2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfAGJF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:05:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfAGJF0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:05:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4300488E63;
        Mon,  7 Jan 2019 09:05:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id 08F5619743;
        Mon,  7 Jan 2019 09:05:22 +0000 (UTC)
Date:   Mon, 7 Jan 2019 10:05:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] Poll for monitored tasks being alive in fork mode
Message-ID: <20190107090522.GA3383@krava>
References: <1546822850-30649-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546822850-30649-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 07 Jan 2019 09:05:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:00:50AM +0800, Jin Yao wrote:
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
> v2:
> ---
> There is a potential race condition window, that is the
> child_pid set with -1 and kill(-1, SIGTERM) may happen.
> Jiri provides a simple method which stores the child_pid to
> a local variable and check the local variable before kill().
> At least, we can avoid the kill(-1, SIGTERM) case.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-stat.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 63a3afc..bd5fb8e 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -553,6 +553,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  
>  		if (interval || timeout) {
>  			while (!waitpid(child_pid, &status, WNOHANG)) {
> +				if (!is_target_alive(&target,
> +					evsel_list->threads)) {
> +					int pid = child_pid;
> +
> +					if (pid != -1)
> +						kill(pid, SIGTERM);
> +					break;
> +				}
> +
>  				nanosleep(&ts, NULL);
>  				if (timeout)
>  					break;
> -- 
> 2.7.4
> 
