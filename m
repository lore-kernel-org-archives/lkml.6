Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD1DC71125
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 14:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57B920876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 14:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57B920876
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeJNVqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 17:46:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeJNVqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 17:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4834F30020A5;
        Sun, 14 Oct 2018 14:04:54 +0000 (UTC)
Received: from krava (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6506C1062244;
        Sun, 14 Oct 2018 14:04:52 +0000 (UTC)
Date:   Sun, 14 Oct 2018 16:04:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ivan Krylov <krylov.r00t@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: pass filename to objdump via execl
Message-ID: <20181014140451.GB24104@krava>
References: <20181014111803.5d83b806@Tarkus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014111803.5d83b806@Tarkus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 14 Oct 2018 14:04:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 11:18:03AM +0300, Ivan Krylov wrote:
> The symbol__disassemble() function uses shell to launch objdump and filter
> its output via grep. Passing filenames by interpolating them into the
> command line via "%s" may lead to problems if said filenames contain
> special characters.
> 
> Instead, pass the filename as a command line argument where it is not
> subject to any kind of interpretation, then use quoted shell
> interpolation to build the strings we need safely.
> 
> Signed-off-by: Ivan Krylov <krylov.r00t@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/annotate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 28cd6a174..4a870181e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1696,15 +1696,14 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	err = asprintf(&command,
>  		 "%s %s%s --start-address=0x%016" PRIx64
>  		 " --stop-address=0x%016" PRIx64
> -		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
> +		 " -l -d %s %s -C \"$1\" 2>/dev/null|grep -v \"$1:\"|expand",
>  		 opts->objdump_path ?: "objdump",
>  		 opts->disassembler_style ? "-M " : "",
>  		 opts->disassembler_style ?: "",
>  		 map__rip_2objdump(map, sym->start),
>  		 map__rip_2objdump(map, sym->end),
>  		 opts->show_asm_raw ? "" : "--no-show-raw",
> -		 opts->annotate_src ? "-S" : "",
> -		 symfs_filename, symfs_filename);
> +		 opts->annotate_src ? "-S" : "");
>  
>  	if (err < 0) {
>  		pr_err("Failure allocating memory for the command to run\n");
> @@ -1729,7 +1728,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		close(stdout_fd[0]);
>  		dup2(stdout_fd[1], 1);
>  		close(stdout_fd[1]);
> -		execl("/bin/sh", "sh", "-c", command, NULL);
> +		execl("/bin/sh", "sh", "-c", command, "--", symfs_filename,
> +		      NULL);
>  		perror(command);
>  		exit(-1);
>  	}
> -- 
> 2.11.0
