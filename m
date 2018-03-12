Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932522AbeCLPoJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932279AbeCLPoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:44:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DE6208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 12 Mar 2018 12:44:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 09/13] libbpf: Add bpf_insn__interpret function
Message-ID: <20180312154403.GC23720@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
 <20180312094313.18738-10-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312094313.18738-10-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 12, 2018 at 10:43:09AM +0100, Jiri Olsa escreveu:
> Adding bpf_insn__interpret function to run ebpf program
> in user space.
> 
> It's 'borrowed' from systemtap code, I still need to figure
> the proper credits, that will go to the file header in case
> this would ever go in.

What is the license? GPL?
 
> Link: http://lkml.kernel.org/n/tip-qqxsyw6imdisj3dydd6e21y7@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> +++ b/tools/lib/bpf/Build
> @@ -1 +1 @@
> -libbpf-y := libbpf.o bpf.o nlattr.o
> +libbpf-y := libbpf.o bpf.o nlattr.o interp.o
> diff --git a/tools/lib/bpf/interp.c b/tools/lib/bpf/interp.c
> new file mode 100644
> index 000000000000..2ceb6a0836c3
> --- /dev/null
> +++ b/tools/lib/bpf/interp.c
> @@ -0,0 +1,245 @@
> +#include <uapi/linux/bpf.h>
> +#include <stdlib.h>
> +#include "interp.h"
> +
> +u64 bpf_interp__run(struct bpf_interp *interp)
> +{
<SNIP>
> +
> +		case BPF_JMP | BPF_EXIT:
> +			return regs[0];
> +
> +		default:
> +			abort();

And this should be converted to returning some error that the users can
tell the user using whatever UI (TUI, etc).

> +		}
> +
> +		regs[i->dst_reg] = dr;
> +	nowrite:
> +		i++;
> +	}
> +
> +	return 0;
> +}
> -- 
> 2.13.6
