Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755606AbeDYQPi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:15:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34277 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755066AbeDYQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:15:33 -0400
X-Google-Smtp-Source: AIpwx4802EqFiuoJBnfnqEio/3aEzG1UbJln66w59hohARrQQCMQhi4CsM1g/fjbiuBEH0QXuaSCmw==
Date: Wed, 25 Apr 2018 10:15:29 -0600
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCH 0/3] bpf: Store/dump license string for loaded program
Message-ID: <20180425161527.w7xgpg75npdx2zmb@ast-mbp>
References: <20180423065927.23127-1-jolsa@kernel.org>
 <20180423201134.r56ts7usec4jjnbh@ast-mbp>
 <20180425101713.GB3396@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425101713.GB3396@krava>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 12:17:13PM +0200, Jiri Olsa wrote:
> On Mon, Apr 23, 2018 at 02:11:36PM -0600, Alexei Starovoitov wrote:
> > On Mon, Apr 23, 2018 at 08:59:24AM +0200, Jiri Olsa wrote:
> > > hi,
> > > sending the change to store and dump the license
> > > info for loaded BPF programs. It's important for
> > > us get the license info, when investigating on
> > > screwed up machine.
> > 
> > hmm. boolean flag whether bpf prog is gpl or not
> > is already exposed via bpf_prog_info.
> 
> hum, I can't see that (on bpf-next/master)
> would the attached change be ok with you?
> 
> jirka
> 
> 
> ---
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e6679393b687..2ce9c9d41c2b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1062,6 +1062,7 @@ struct bpf_prog_info {
>  	__u32 ifindex;
>  	__u64 netns_dev;
>  	__u64 netns_ino;
> +	__u16 gpl_compatible:1;
>  } __attribute__((aligned(8)));

ahh. I swear there were patches to add it and I thought we accepted them.
Also just noticed that commit 675fc275a3a2d added 4-byte hole in there.
So I'm thinking we can fill the hole with 
 	__u32 ifindex;
+	__u32 gpl_compatible:1;
 	__u64 netns_dev;
 	__u64 netns_ino;

and keep adding bit fields in there without breaking user space.
Such patch would need to go to bpf tree.
