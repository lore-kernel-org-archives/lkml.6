Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeDZHjM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:39:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753882AbeDZHjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:39:08 -0400
Date: Thu, 26 Apr 2018 09:39:05 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kubakici@wp.pl>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCH 3/3] tools bpftool: Display license GPL compatible in
 prog show/list
Message-ID: <20180426073905.GI3396@krava>
References: <20180425174108.6586-1-jolsa@kernel.org>
 <20180425174108.6586-4-jolsa@kernel.org>
 <20180425140346.3e0f3ba7@cakuba.netronome.com>
 <0e84fe67-59c9-a419-5ff7-05be2aa1991e@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e84fe67-59c9-a419-5ff7-05be2aa1991e@iogearbox.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 11:14:30PM +0200, Daniel Borkmann wrote:
> On 04/25/2018 11:03 PM, Jakub Kicinski wrote:
> > On Wed, 25 Apr 2018 19:41:08 +0200, Jiri Olsa wrote:
> >> @@ -295,6 +297,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
> >>  	printf("tag ");
> >>  	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
> >>  	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
> >> +	printf(" license GPL %scompatible", info->gpl_compatible ? "" : "NON ");
> > 
> > 3 nit picks:
> > 
> > Other "fields" are separated by two spaces between each other:
> > 
> >   4: kprobe  name func_begin  tag 57cd311f2e27366b license GPL compatible
> >            ^^               ^^                    X
> >           loaded_at Apr 25/11:20  uid 0
> >                                 ^^
> >           xlated 16B  not jited  memlock 4096B
> >                     ^^         ^^
> > 
> > Could you also update the example outputs in the man page:
> > 
> > tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > 
> > Sorry about the bike shedding but I would also vote for:
> > 
> > "[not] GPL compatible"
> > 
> > rather than
> > 
> > "license GPL [NON] compatible"
> > 
> > for brevity..
> 
> While we're at it, can we also squeeze this whole thing a bit? Feels like
> huge string wasted for very little information compared to the rest of the
> dump. Just append the string "gpl" at the end of the line if info->gpl_compatible
> is set, otherwise just add nothing. This also allows to naturally grep
> for it e.g. `bpftool p | grep gpl` if you need a quick summary.

that's fine with me.. so 'gpl' in here:

5: tracepoint  name func  tag 57cd311f2e27366b  gpl
        loaded_at Apr 26/09:37  uid 0
        xlated 16B  not jited  memlock 4096B

and keeping tyhe whole name in json output:

[{
        "id": 5,
        "type": "tracepoint",
        "name": "func",
        "tag": "57cd311f2e27366b",
        "gpl_compatible": true,
        "loaded_at": "Apr 26/09:37",
        "uid": 0,
        "bytes_xlated": 16,
        "jited": false,
        "bytes_memlock": 4096
    }
]

how about that?

thanks,
jirka
