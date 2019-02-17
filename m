Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A760CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCF721773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfBQXGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:06:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbfBQXGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:06:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DA892FE55A;
        Sun, 17 Feb 2019 23:06:18 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 93FC419741;
        Sun, 17 Feb 2019 23:06:15 +0000 (UTC)
Date:   Mon, 18 Feb 2019 00:06:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 perf,bpf 10/11] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190217230614.GH7443@krava>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-11-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215215354.3114006-11-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 17 Feb 2019 23:06:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:53:53PM -0800, Song Liu wrote:

SNIP

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
> +
> +	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
> +		return -1;
> +
> +	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
> +		 sym->name, sym->start, sym->end - sym->start);
> +
> +	memset(tpath, 0, sizeof(tpath));
> +	get_exec_path(tpath, sizeof(tpath));
> +
> +	bfdf = bfd_openr(tpath, NULL);
> +	assert(bfdf);
> +	assert(bfd_check_format(bfdf, bfd_object));
> +
> +	s = open_memstream(&buf, &buf_size);

what if open_memstream fails?


> +	init_disassemble_info(&info, s,
> +			      (fprintf_ftype) fprintf);
> +
> +	info.arch = bfd_get_arch(bfdf);
> +	info.mach = bfd_get_mach(bfdf);
> +
> +	arrays = 1UL << BPF_PROG_INFO_JITED_INSNS;
> +	arrays |= 1UL << BPF_PROG_INFO_JITED_KSYMS;
> +	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
> +	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;

what's the arrays for?

> +
> +	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
> +						 dso->bpf_prog.id);
> +	if (!info_node)
> +		return -1;
> +	info_linear = info_node->info_linear;
> +	sub_id = dso->bpf_prog.sub_id;
> +
> +	info.buffer = (void *)(info_linear->info.jited_prog_insns);
> +	info.buffer_length = info_linear->info.jited_prog_len;
> +
> +	if (info_linear->info.nr_line_info)
> +		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
> +	prog_linfo = prog_linfo;
> +
> +	if (info_linear->info.btf_id) {
> +		struct btf_node *node;
> +
> +		node = perf_env__find_btf(dso->bpf_prog.env,
> +					  info_linear->info.btf_id);
> +		if (node)
> +			btf = btf__new((__u8 *)(node->data),
> +				       node->data_size);
> +	}

what if btf__new fails? the btf__name_by_offset
does not check btf != NULL

> +
> +	disassemble_init_for_target(&info);
> +
> +#ifdef DISASM_FOUR_ARGS_SIGNATURE
> +	disassemble = disassembler(info.arch,
> +				   bfd_big_endian(bfdf),
> +				   info.mach,
> +				   bfdf);
> +#else
> +	disassemble = disassembler(bfdf);
> +#endif
> +	assert(disassemble);
> +
> +	fflush(s);

any chance this function could be split into some logical
pieces/fucntions?

thanks,
jirka

> +	do {
> +		const struct bpf_line_info *linfo = NULL;
> +		struct disasm_line *dl;
> +		size_t prev_buf_size;
> +		const char *srcline;
> +		u64 addr;
> +
> +		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
> +		count = disassemble(pc, &info);
> +
> +		linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo, addr, sub_id,
> +							nr_skip);
> +
> +		if (linfo) {
> +			srcline = btf__name_by_offset(btf, linfo->line_off);
> +			nr_skip++;
> +		} else
> +			srcline = NULL;
> +
> +		fprintf(s, "\n");
> +		prev_buf_size = buf_size;
> +		fflush(s);
> +
> +		if (!opts->hide_src_code && srcline) {
> +			args->offset = -1;
> +			args->line = strdup(srcline);
> +			args->line_nr = 0;
> +			args->ms.sym  = sym;
> +			dl = disasm_line__new(args);
> +			annotation_line__add(&dl->al, &notes->src->source);
> +		}
> +
> +		args->offset = pc;
> +		args->line = buf + prev_buf_size;
> +		args->line_nr = 0;
> +		args->ms.sym  = sym;
> +		dl = disasm_line__new(args);
> +		annotation_line__add(&dl->al, &notes->src->source);
> +
> +		pc += count;
> +	} while (count > 0 && pc < len);
> +
> +	bfd_close(bfdf);
> +	return 0;
> +}

SNIP
