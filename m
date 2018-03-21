Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeCUSh4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:37:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752517AbeCUShw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:37:52 -0400
Date: Wed, 21 Mar 2018 19:37:49 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: Remove struct bpf_verifier_env argument from
 print_bpf_insn
Message-ID: <20180321183749.GF2707@krava>
References: <20180321150212.5586-1-jolsa@kernel.org>
 <d28f0a7f-3721-88f3-f4e9-97a73a8833e5@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28f0a7f-3721-88f3-f4e9-97a73a8833e5@netronome.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 05:25:33PM +0000, Quentin Monnet wrote:
> 2018-03-21 16:02 UTC+0100 ~ Jiri Olsa <jolsa@kernel.org>
> > We use print_bpf_insn in user space (bpftool and soon perf),
> > so it'd be nice to keep it generic and strip it off the kernel
> > struct bpf_verifier_env argument.
> > 
> > This argument can be safely removed, because its users can
> > use the struct bpf_insn_cbs::private_data to pass it.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/disasm.c   | 52 +++++++++++++++++++++++++--------------------------
> >  kernel/bpf/disasm.h   |  5 +----
> >  kernel/bpf/verifier.c |  6 +++---
> >  3 files changed, 30 insertions(+), 33 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c6eff108aa99..9f27d3fa7259 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -202,8 +202,7 @@ EXPORT_SYMBOL_GPL(bpf_verifier_log_write);
> >   * generic for symbol export. The function was renamed, but not the calls in
> >   * the verifier to avoid complicating backports. Hence the alias below.
> >   */
> > -static __printf(2, 3) void verbose(struct bpf_verifier_env *env,
> > -				   const char *fmt, ...)
> > +static __printf(2, 3) void verbose(void *private_data, const char *fmt, ...)
> >  	__attribute__((alias("bpf_verifier_log_write")));
> 
> Just as a note, verbose() will be aliased to a function whose prototype
> differs (bpf_verifier_log_write() still expects a struct
> bpf_verifier_env as its first argument). I am not so familiar with
> function aliases, could this change be a concern?

yea, but as it was pointer for pointer switch I did not
see any problem with that.. I'll check more

jirka
