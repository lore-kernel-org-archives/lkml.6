Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BA0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9438521848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547232258;
	bh=uv05aVhMx3vXrCSPrA44C1FdVzt8inbxXJlP+3a4Bms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cYWEupcZC/tl/AjQz5542TNhxHRSpwz2Dx89Mk2LaiaKEOsDv9NQSSL5I4BNI9mw/
	 AvfGg16mVF2tVDBYpPFhNeSE2v9t1ruV62ogWnw7+DLTBs+L+KQ2MH2UhnJBvMo3hc
	 1WHj6X8EuWDND079PlfcTRIySTWAoIHsa9L3Ing0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbfAKSoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:44:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730785AbfAKSoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:44:16 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4516020878;
        Fri, 11 Jan 2019 18:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547232255;
        bh=uv05aVhMx3vXrCSPrA44C1FdVzt8inbxXJlP+3a4Bms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3tp0B5AxedDYp1BfoFEOwnAwQRO1MGFIOFNwBx6EWbAhJfj7jTGCMfJzCwJL2H90
         AaL6dOxBGPBLqGCFp5tuQVh5TyV90OzWR0dos0SuCRne1J2QCuSYA57RSEY/t6qWAK
         1fBJrgpmbIqlhyE+Z3i6NSUVlivEivYcwvFaxBzg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6D8941AB5; Fri, 11 Jan 2019 15:44:12 -0300 (-03)
Date:   Fri, 11 Jan 2019 15:44:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, dsahern@gmail.com
Subject: Re: [PATCH v7 perf, bpf-next 8/8] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Message-ID: <20190111184412.GA22483@kernel.org>
References: <20190111001933.4153792-1-songliubraving@fb.com>
 <20190111001933.4153792-9-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111001933.4153792-9-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 10, 2019 at 04:19:33PM -0800, Song Liu escreveu:
> This patch synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for
> BPF programs loaded before perf-record. This is achieved by gathering
> information about all BPF programs via sys_bpf.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/builtin-record.c |   6 ++
>  tools/perf/util/bpf-event.c | 205 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/bpf-event.h |   5 +
>  3 files changed, 216 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index deaf9b902094..88ea11d57c6f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -41,6 +41,7 @@
>  #include "util/perf-hooks.h"
>  #include "util/time-utils.h"
>  #include "util/units.h"
> +#include "util/bpf-event.h"
>  #include "asm/bug.h"
>  
>  #include <errno.h>
> @@ -1082,6 +1083,11 @@ static int record__synthesize(struct record *rec, bool tail)
>  		return err;
>  	}
>  
> +	err = perf_event__synthesize_bpf_events(tool, process_synthesized_event,
> +						machine, opts);
> +	if (err < 0)
> +		pr_warning("Couldn't synthesize bpf events.\n");
> +

There should be no warnings on older systems, I build a kernel and tools
with your changes and then, before rebooting, I tried:

[root@quaco ~]# perf record ls
Couldn't synthesize bpf events.
<SNIP>
[root@quaco ~]# uname -a
Linux quaco 4.19.13-300.fc29.x86_64 #1 SMP Sat Dec 29 22:54:28 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
[root@quaco ~]#

At most this should be a pr_debug(), but then it should check if the
system is bpf capable and if not only warn if the user explicitely asked
for bpf events.

- Arnaldo

>  	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
>  					    process_synthesized_event, opts->sample_address,
>  					    1);
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index f24f75506f51..ee60c8b1e636 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -1,10 +1,24 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
>  #include <bpf/bpf.h>
> +#include <bpf/btf.h>
> +#include <linux/btf.h>
>  #include "bpf-event.h"
>  #include "debug.h"
>  #include "symbol.h"
>  
> +#define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
> +
> +static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
> +{
> +	int ret = 0;
> +	size_t i;
> +
> +	for (i = 0; i < len; i++)
> +		ret += snprintf(buf + ret, size - ret, "%02x", data[i]);
> +	return ret;
> +}
> +
>  int machine__process_bpf_event(struct machine *machine __maybe_unused,
>  			       union perf_event *event,
>  			       struct perf_sample *sample __maybe_unused)
> @@ -13,3 +27,194 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
>  		perf_event__fprintf_bpf_event(event, stderr);
>  	return 0;
>  }
> +
> +/*
> + * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
> + * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
> + * one PERF_RECORD_KSYMBOL is generated for each sub program.
> + */
> +static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
> +					       perf_event__handler_t process,
> +					       struct machine *machine,
> +					       int fd,
> +					       union perf_event *event,
> +					       struct record_opts *opts)
> +{
> +	struct ksymbol_event *ksymbol_event = &event->ksymbol_event;
> +	struct bpf_event *bpf_event = &event->bpf_event;
> +	u32 sub_prog_cnt, i, func_info_rec_size;
> +	u8 (*prog_tags)[BPF_TAG_SIZE] = NULL;
> +	struct bpf_prog_info info = {};
> +	u32 info_len = sizeof(info);
> +	void *func_infos = NULL;
> +	u64 *prog_addrs = NULL;
> +	struct btf *btf = NULL;
> +	u32 *prog_lens = NULL;
> +	bool has_btf = false;
> +	int err = 0;
> +
> +	/* Call bpf_obj_get_info_by_fd() to get sizes of arrays */
> +	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
> +
> +	if (err || info_len < 192 /* need field prog_tags */)
> +		return -1;
> +
> +	/* number of ksyms, func_lengths, and tags should match */
> +	sub_prog_cnt = info.nr_jited_ksyms;
> +	if (sub_prog_cnt != info.nr_prog_tags ||
> +	    sub_prog_cnt != info.nr_jited_func_lens)
> +		return -1;
> +
> +	/* check BTF func info support */
> +	if (info.btf_id && info.nr_func_info && info.func_info_rec_size) {
> +		/* btf func info number should be same as sub_prog_cnt */
> +		if (sub_prog_cnt != info.nr_func_info)
> +			return -1;
> +		if (btf__get_from_id(info.btf_id, &btf))
> +			return -1;
> +		func_info_rec_size = info.func_info_rec_size;
> +		func_infos = malloc(sub_prog_cnt * func_info_rec_size);
> +		if (!func_infos)
> +			return -1;
> +		has_btf = true;
> +	}
> +
> +	/*
> +	 * We need address, length, and tag for each sub program.
> +	 * Allocate memory and call bpf_obj_get_info_by_fd() again
> +	 */
> +	prog_addrs = (u64 *)malloc(sizeof(u64) * sub_prog_cnt);
> +	prog_lens = (u32 *)malloc(sizeof(u64) * sub_prog_cnt);
> +	prog_tags = malloc(sizeof(u8) * BPF_TAG_SIZE * sub_prog_cnt);
> +
> +	err = !prog_addrs || !prog_lens || !prog_tags;
> +	if (err)
> +		goto out;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.nr_jited_ksyms = sub_prog_cnt;
> +	info.nr_jited_func_lens = sub_prog_cnt;
> +	info.nr_prog_tags = sub_prog_cnt;
> +	info.jited_ksyms = ptr_to_u64(prog_addrs);
> +	info.jited_func_lens = ptr_to_u64(prog_lens);
> +	info.prog_tags = ptr_to_u64(prog_tags);
> +	info_len = sizeof(info);
> +	if (has_btf) {
> +		info.nr_func_info = sub_prog_cnt;
> +		info.func_info_rec_size = func_info_rec_size;
> +		info.func_info = ptr_to_u64(func_infos);
> +	}
> +
> +	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
> +	if (err)
> +		goto out;
> +
> +	/* Synthesize PERF_RECORD_KSYMBOL */
> +	for (i = 0; i < sub_prog_cnt; i++) {
> +		const struct bpf_func_info *finfo;
> +		const char *short_name = NULL;
> +		const struct btf_type *t;
> +		int name_len;
> +
> +		*ksymbol_event = (struct ksymbol_event){
> +			.header = {
> +				.type = PERF_RECORD_KSYMBOL,
> +				.size = sizeof(struct ksymbol_event),
> +			},
> +			.addr = prog_addrs[i],
> +			.len = prog_lens[i],
> +			.ksym_type = PERF_RECORD_KSYMBOL_TYPE_BPF,
> +			.flags = 0,
> +		};
> +		name_len = snprintf(ksymbol_event->name, KSYM_NAME_LEN,
> +				    "bpf_prog_");
> +		name_len += snprintf_hex(ksymbol_event->name + name_len,
> +					 KSYM_NAME_LEN - name_len,
> +					 prog_tags[i], BPF_TAG_SIZE);
> +		if (has_btf) {
> +			finfo = func_infos + i * info.func_info_rec_size;
> +			t = btf__type_by_id(btf, finfo->type_id);
> +			short_name = btf__name_by_offset(btf, t->name_off);
> +		} else if (i == 0 && sub_prog_cnt == 1) {
> +			/* no subprog */
> +			if (info.name[0])
> +				short_name = info.name;
> +		} else
> +			short_name = "F";
> +		if (short_name)
> +			name_len += snprintf(ksymbol_event->name + name_len,
> +					     KSYM_NAME_LEN - name_len,
> +					     "_%s", short_name);
> +
> +		ksymbol_event->header.size += PERF_ALIGN(name_len + 1,
> +							 sizeof(u64));
> +		err = perf_tool__process_synth_event(tool, event,
> +						     machine, process);
> +	}
> +
> +	/* Synthesize PERF_RECORD_BPF_EVENT */
> +	if (opts->bpf_event) {
> +		*bpf_event = (struct bpf_event){
> +			.header = {
> +				.type = PERF_RECORD_BPF_EVENT,
> +				.size = sizeof(struct bpf_event),
> +			},
> +			.type = PERF_BPF_EVENT_PROG_LOAD,
> +			.flags = 0,
> +			.id = info.id,
> +		};
> +		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
> +		err = perf_tool__process_synth_event(tool, event,
> +						     machine, process);
> +	}
> +
> +out:
> +	free(prog_tags);
> +	free(prog_lens);
> +	free(prog_addrs);
> +	free(func_infos);
> +	free(btf);
> +	return err ? -1 : 0;
> +}
> +
> +int perf_event__synthesize_bpf_events(struct perf_tool *tool,
> +				      perf_event__handler_t process,
> +				      struct machine *machine,
> +				      struct record_opts *opts)
> +{
> +	union perf_event *event;
> +	__u32 id = 0;
> +	int err;
> +	int fd;
> +
> +	event = malloc(sizeof(event->bpf_event) + KSYM_NAME_LEN);
> +	if (!event)
> +		return -1;
> +	while (true) {
> +		err = bpf_prog_get_next_id(id, &id);
> +		if (err) {
> +			if (errno == ENOENT) {
> +				err = 0;
> +				break;
> +			}
> +			pr_err("can't get next program: %s%s",
> +			       strerror(errno),
> +			       errno == EINVAL ? " -- kernel too old?" : "");
> +			err = -1;
> +			break;
> +		}
> +		fd = bpf_prog_get_fd_by_id(id);
> +		if (fd < 0) {
> +			pr_debug("Failed to get fd for prog_id %u\n", id);
> +			continue;
> +		}
> +
> +		err = perf_event__synthesize_one_bpf_prog(
> +			tool, process, machine, fd, event, opts);
> +		close(fd);
> +		if (err)
> +			break;
> +	}
> +	free(event);
> +	return err;
> +}
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index d5ca355dd298..38aee4040f12 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -8,4 +8,9 @@ int machine__process_bpf_event(struct machine *machine,
>  			       union perf_event *event,
>  			       struct perf_sample *sample);
>  
> +int perf_event__synthesize_bpf_events(struct perf_tool *tool,
> +				      perf_event__handler_t process,
> +				      struct machine *machine,
> +				      struct record_opts *opts);
> +
>  #endif
> -- 
> 2.17.1

-- 

- Arnaldo
