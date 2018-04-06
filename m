Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754905AbeDFPHq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:07:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754175AbeDFPHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:07:43 -0400
Date: Fri, 6 Apr 2018 17:07:36 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC 0/9] bpf: Add buildid check support
Message-ID: <20180406150736.GA13785@krava>
References: <20180405151645.19130-1-jolsa@kernel.org>
 <20180406013719.ekptkxbwzpjeaanu@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406013719.ekptkxbwzpjeaanu@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 06:37:23PM -0700, Alexei Starovoitov wrote:
> On Thu, Apr 05, 2018 at 05:16:36PM +0200, Jiri Olsa wrote:
> > hi,
> > eBPF programs loaded for kprobes are allowed to read kernel
> > internal structures. We check the provided kernel version
> > to ensure that the program is loaded for the proper kernel. 
> > 
> > The problem is that the version check is not enough, because
> > it only follows the version setup from kernel's Makefile.
> > However, the internal kernel structures change based on the
> > .config data, so in practise we have different kernels with
> > same version.
> > 
> > The eBPF kprobe program thus then get loaded for different
> > kernel than it's been built for, get wrong data (silently)
> > and provide misleading output.
> > 
> > This patchset implements additional check in eBPF loading code
> > on provided build ID (from kernel's elf image, .notes section
> > GNU build ID) to ensure we load the eBPF program on correct
> > kernel.
> > 
> > Also available in here (based on bpf-next/master):
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   bpf/checksum
> > 
> > This patchset consists of several changes:
> > 
> > - adding CONFIG_BUILDID_H option that instructs the build
> >   to generate uapi header file with build ID data, that
> >   will be included by eBPF program
> > 
> > - adding CONFIG_BPF_BUILDID_CHECK option and new bpf_attr
> >   field to allow build ID checking when loading the eBPF
> >   program
> > 
> > - changing libbpf to read and pass build ID to the kernel
> > 
> > - several small side fixes
> > 
> > - example perf eBPF code in bpf-samples/bpf-stdout-example.c
> >   to show the build ID support/usage.
> > 
> >     # perf record -vv  -e ./bpf-samples/bpf-stdout-example.c kill 2>&1 | grep buildid
> >     libbpf: section(7) buildid, size 21, link 0, flags 3, type=1
> >     libbpf: kernel buildid of ./bpf-samples/bpf-stdout-example.c is: 6e25edeb408513184e2753bebad25d42314501a0
> > 
> >   The buildid is provided the same way we provide kernel
> >   version, in a special "buildid" section:
> > 
> >     # cat ./bpf-samples/bpf-stdout-example.c
> >     ...
> >     #include <linux/buildid.h>
> > 
> >     char _buildid[] SEC("buildid") = LINUX_BUILDID_DATA;
> >     ...
> > 
> >   where LINUX_BUILDID_DATA is defined in the generated buildid.h.
> > 
> > please note it's an RFC ;-) any comments and suggestions are welcome
> 
> I think this is overkill.
> 
> We're very heavy users of kprobe+bpf. It's used for lots
> of different cases and usage is constantly growing,
> but I haven't seen a single case of :
> 
> > The eBPF kprobe program thus then get loaded for different
> > kernel than it's been built for, get wrong data (silently)
> > and provide misleading output.
> 
> but I saw plenty of the opposite. People pre-compile the program
> and hack kernel version when they load, since they know in advance
> that kprobe+bpf doesn't use any kernel specific things.
> The existing kernel version check for kprobe+bpf is already annoying
> to them.

perhaps verifier could detect this (via bpf_probe_read usage) and disable
the version check automaticaly for such program?

and in the same way force the version check (or buildid when enabled)
once the bpf_probe_read is detected

thanks,
jirka
