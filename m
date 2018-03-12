Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeCLPx2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:53:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752164AbeCLPx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:53:27 -0400
Date: Mon, 12 Mar 2018 16:53:23 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 09/13] libbpf: Add bpf_insn__interpret function
Message-ID: <20180312155323.GF23111@krava>
References: <20180312094313.18738-1-jolsa@kernel.org>
 <20180312094313.18738-10-jolsa@kernel.org>
 <20180312154403.GC23720@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312154403.GC23720@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 12:44:03PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 12, 2018 at 10:43:09AM +0100, Jiri Olsa escreveu:
> > Adding bpf_insn__interpret function to run ebpf program
> > in user space.
> > 
> > It's 'borrowed' from systemtap code, I still need to figure
> > the proper credits, that will go to the file header in case
> > this would ever go in.
> 
> What is the license? GPL?

yes GPLv2

>  
> > Link: http://lkml.kernel.org/n/tip-qqxsyw6imdisj3dydd6e21y7@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > +++ b/tools/lib/bpf/Build
> > @@ -1 +1 @@
> > -libbpf-y := libbpf.o bpf.o nlattr.o
> > +libbpf-y := libbpf.o bpf.o nlattr.o interp.o
> > diff --git a/tools/lib/bpf/interp.c b/tools/lib/bpf/interp.c
> > new file mode 100644
> > index 000000000000..2ceb6a0836c3
> > --- /dev/null
> > +++ b/tools/lib/bpf/interp.c
> > @@ -0,0 +1,245 @@
> > +#include <uapi/linux/bpf.h>
> > +#include <stdlib.h>
> > +#include "interp.h"
> > +
> > +u64 bpf_interp__run(struct bpf_interp *interp)
> > +{
> <SNIP>
> > +
> > +		case BPF_JMP | BPF_EXIT:
> > +			return regs[0];
> > +
> > +		default:
> > +			abort();
> 
> And this should be converted to returning some error that the users can
> tell the user using whatever UI (TUI, etc).

right, I want to get rid of all abort calls, I think there's one more

jirka
