Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB28C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2900521773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfBQXFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:05:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfBQXF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:05:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 262DCB21B;
        Sun, 17 Feb 2019 23:05:29 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id A0A281001F41;
        Sun, 17 Feb 2019 23:05:26 +0000 (UTC)
Date:   Mon, 18 Feb 2019 00:05:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 perf,bpf 10/11] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190217230525.GB7443@krava>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-11-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215215354.3114006-11-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 17 Feb 2019 23:05:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:53:53PM -0800, Song Liu wrote:

SNIP

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 70de8f6b3aee..078017d31ca9 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -22,6 +22,7 @@
>  #include "annotate.h"
>  #include "evsel.h"
>  #include "evlist.h"
> +#include "bpf-event.h"
>  #include "block-range.h"
>  #include "string2.h"
>  #include "arch/common.h"
> @@ -29,6 +30,9 @@
>  #include <pthread.h>
>  #include <linux/bitops.h>
>  #include <linux/kernel.h>
> +#include <bfd.h>
> +#include <dis-asm.h>
> +#include <bpf/libbpf.h>
>  
>  /* FIXME: For the HE_COLORSET */
>  #include "ui/browser.h"
> @@ -1672,6 +1676,147 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  	return 0;
>  }
>  
> +static void get_exec_path(char *tpath, size_t size)
> +{
> +	const char *path = "/proc/self/exe";
> +	ssize_t len;
> +
> +	len = readlink(path, tpath, size - 1);
> +	assert(len > 0);
> +	tpath[len] = 0;
> +}

this is also used in write_cmdline, could you please
move it under util.c and use it in write_cmdline as well?

thanks,
jirka

> +
> +static int symbol__disassemble_bpf(struct symbol *sym,
> +				   struct annotate_args *args)
> +{
> +	struct annotation *notes = symbol__annotation(sym);
> +	struct annotation_options *opts = args->options;
> +	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_prog_linfo *prog_linfo = NULL;
> +	struct bpf_prog_info_node *info_node;
> +	int len = sym->end - sym->start;
> +	disassembler_ftype disassemble;
> +	struct map *map = args->ms.map;
> +	struct disassemble_info info;
> +	struct dso *dso = map->dso;
> +	int pc = 0, count, sub_id;
> +	struct btf *btf = NULL;
> +	char tpath[PATH_MAX];
> +	size_t buf_size;
> +	int nr_skip = 0;
> +	__u64 arrays;
> +	char *buf;
> +	bfd *bfdf;
> +	FILE *s;

nice triangle ;-)

SNIP
