Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeCUQnj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:43:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752610AbeCUQn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:43:26 -0400
Date: Wed, 21 Mar 2018 17:43:24 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] bpftool: Adjust to new print_bpf_insn interface
Message-ID: <20180321164324.GD2707@krava>
References: <20180321150212.5586-1-jolsa@kernel.org>
 <20180321150212.5586-2-jolsa@kernel.org>
 <c27c5c1c-79ee-3ed2-d1c3-a011ead4edea@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c27c5c1c-79ee-3ed2-d1c3-a011ead4edea@netronome.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 04:39:09PM +0000, Quentin Monnet wrote:
> 2018-03-21 16:02 UTC+0100 ~ Jiri Olsa <jolsa@kernel.org>
> > Change bpftool to skip the removed struct bpf_verifier_env
> > argument in print_bpf_insn. It was passed as NULL anyway.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/bpf/bpftool/prog.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index e549e329be82..108001d974ee 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -489,7 +489,7 @@ static struct kernel_sym *kernel_syms_search(struct dump_data *dd,
> >  		       sizeof(*dd->sym_mapping), kernel_syms_cmp) : NULL;
> >  }
> >  
> > -static void print_insn(struct bpf_verifier_env *env, const char *fmt, ...)
> > +static void print_insn(void *private_data, const char *fmt, ...)
> >  {
> >  	va_list args;
> >  
> > @@ -576,7 +576,7 @@ static void dump_xlated_plain(struct dump_data *dd, void *buf,
> >  		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
> >  
> >  		printf("% 4d: ", i);
> > -		print_bpf_insn(&cbs, NULL, insn + i, true);
> > +		print_bpf_insn(&cbs, insn + i, true);
> >  
> >  		if (opcodes) {
> >  			printf("       ");
> > @@ -590,7 +590,7 @@ static void dump_xlated_plain(struct dump_data *dd, void *buf,
> >  	}
> >  }
> >  
> > -static void print_insn_json(struct bpf_verifier_env *env, const char *fmt, ...)
> > +static void print_insn_json(void *private_data, const char *fmt, ...)
> >  {
> >  	unsigned int l = strlen(fmt);
> >  	char chomped_fmt[l];
> > @@ -628,7 +628,7 @@ static void dump_xlated_json(struct dump_data *dd, void *buf,
> >  
> >  		jsonw_start_object(json_wtr);
> >  		jsonw_name(json_wtr, "disasm");
> > -		print_bpf_insn(&cbs, NULL, insn + i, true);
> > +		print_bpf_insn(&cbs, insn + i, true);
> >  
> >  		if (opcodes) {
> >  			jsonw_name(json_wtr, "opcodes");
> > 
> 
> Hi Jiri, this code has changed in the tree. It was moved to
> tools/bpf/bpftool/xlated_dumper.c, and there is now a third function to
> update: print_insn_for_graph(). Could you please rebase the patch?

sure.. I was over perf tree, I'll check on bpf tree

thanks,
jirka
