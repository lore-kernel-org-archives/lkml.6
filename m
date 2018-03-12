Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbeCLSpC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:45:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45698 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeCLSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:45:01 -0400
X-Google-Smtp-Source: AG47ELt/LeH6w7K9XadpjvA5iTnJjC+LFmNbP+AgJNyXDyevjbgW3t7MnGnx5dyA9r6qj+R+XDG74g==
Date: Mon, 12 Mar 2018 11:44:57 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Daniel Borkmann <daniel@iogearbox.net>, Wangnan <wangnan0@huawei.com>
Subject: Re: [PATCH 11/13] perf bpf: Add helper header files
Message-ID: <20180312184455.bs2rk6qr3qrz7vmy@ast-mbp>
References: <20180312094313.18738-1-jolsa@kernel.org>
 <20180312094313.18738-12-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312094313.18738-12-jolsa@kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:43:11AM +0100, Jiri Olsa wrote:
> diff --git a/tools/perf/util/bpf-userapi.h b/tools/perf/util/bpf-userapi.h
> new file mode 100644
> index 000000000000..63f2b4c13a5c
> --- /dev/null
> +++ b/tools/perf/util/bpf-userapi.h
> @@ -0,0 +1,11 @@
> +#ifndef __BPF_USERAPI_H
> +#define __BPF_USERAPI_H
> +
> +enum {
> +	BPF_FUNC_USER_START			= 10000,
> +	BPF_FUNC_USER_print			= BPF_FUNC_USER_START,
> +	BPF_FUNC_USER_bpf_map_get_next_key,
> +	BPF_FUNC_USER_bpf_map_lookup_elem,
> +};
> +
> +#endif /* __BPF_USERFUNCS_H */
> diff --git a/tools/perf/util/bpf-userfuncs.h b/tools/perf/util/bpf-userfuncs.h
> new file mode 100644
> index 000000000000..e920420237ee
> --- /dev/null
> +++ b/tools/perf/util/bpf-userfuncs.h
> @@ -0,0 +1,19 @@
> +#ifndef __BPF_USERFUNCS_H
> +#define __BPF_USERFUNCS_H
> +
> +#include <bpf-userapi.h>
> +
> +static int (*bpfu_print)(const char *fmt, ...) =
> +	(void *) BPF_FUNC_USER_print;
> +static int (*bpfu_map_get_next_key)(void *map, void *key, void *value) =
> +	(void *) BPF_FUNC_USER_bpf_map_get_next_key;
> +static int (*bpfu_map_lookup_elem)(void *map, void *key, void *value) =
> +	(void *) BPF_FUNC_USER_bpf_map_lookup_elem;
> +
> +#define print(fmt, ...)                                  \
> +({                                                       \
> +	char ____fmt[] = fmt;                            \
> +	bpfu_print(____fmt, ##__VA_ARGS__);              \
> +})

since there is no verifier for this user space bpf interpreter
there is no need to restrict what BEGIN/END progs can do and can call.
llvm will happily compile any C code into bpf instructions.
With little bit of elf magic it's possible to let it call any libc
function instead of only 3 above.
perf loader will see bpf_call into normal printf, memcpy, memcmp, etc
then during the loading need to associate symbol with actual address
of these functions inside perf binary and let call_cb do the call.
I think this way begin/end will be much more powerful and useful.
Potentially allowing some of the bcc scripts to be written this way.
