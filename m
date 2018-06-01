Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbeFAIl0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:41:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46530 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeFAIlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:41:21 -0400
X-Google-Smtp-Source: ADUXVKIc9g/FNUVttrDe4cpaPTDoIT0bqd/K0me2+wDL5Q8HNg40V595LTwM9Dr12yvMIe26QYKsZw==
Date: Fri, 1 Jun 2018 04:41:16 -0400
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Eugene Syromiatnikov <esyr@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix alignment of netns_dev/netns_ino fields
 in bpf_{map,prog}_info
Message-ID: <20180601084114.xgvtg7nmihdavnnd@ast-mbp>
References: <20180527112842.GA18204@asgard.redhat.com>
 <20180530181857.GA6744@altlinux.org>
 <20180601031210.GA30533@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601031210.GA30533@altlinux.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:12:10AM +0300, Dmitry V. Levin wrote:
> Hi,
> 
> Looks like the ABI bug in bpf_map_info and bpf_prog info introduced
> in 4.16 is going to slip into 4.17, causing extra pain to 32-bit
> userspace.  I'm adding Linus to this thread in hope it might help
> to get a fix applied before 4.17 is released.

The issue identified in patch 1 is valid.
These two fields won't be properly accessible by 32-bit user space
on 64-bit kernel.
But the fix in patch 1 is wrong.
The patch 2 is completely unnecessary.
Everyone can also see that the patches are still marked as 'new' in patchworks
meaning that we didn't process them.
At the moment many networking folks are traveling to netconf
and we only had a chance to discuss this set last night.
We'll try to send a fix in coming days.
But regardless whether 4.17 is realesed this sunday or not
we're not going to rush wrong patch in without proper code review
and discussion.
That future patch either will land in 4.17 (if it's dealyed into next sunday)
or it will be sent to stable.

To speed up the situation next time please report the issue that you find
to public netdev mailing list instead of using proprietary distro emails.

Thanks.

> On Wed, May 30, 2018 at 09:18:58PM +0300, Dmitry V. Levin wrote:
> > On Sun, May 27, 2018 at 01:28:42PM +0200, Eugene Syromiatnikov wrote:
> > > Recent introduction of netns_dev/netns_ino to bpf_map_info/bpf_prog info
> > > has broken compat, as offsets of these fields are different in 32-bit
> > > and 64-bit ABIs.  One fix (other than implementing compat support in
> > > syscall in order to handle this discrepancy) is to use __aligned_u64
> > > instead of __u64 for these fields.
> > > 
> > > Reported-by: Dmitry V. Levin <ldv@altlinux.org>
> > > Fixes: 52775b33bb507 ("bpf: offload: report device information about
> > > offloaded maps")
> > > Fixes: 675fc275a3a2d ("bpf: offload: report device information for
> > > offloaded programs")
> > > 
> > > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > 
> > Reviewed-by: "Dmitry V. Levin" <ldv@altlinux.org>
> > Cc: <stable@vger.kernel.org> # v4.16+
> > 
> > Thanks,
> > 
> > > ---
> > >  include/uapi/linux/bpf.h       | 8 ++++----
> > >  tools/include/uapi/linux/bpf.h | 8 ++++----
> > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index c5ec897..903010a 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -1017,8 +1017,8 @@ struct bpf_prog_info {
> > >  	__aligned_u64 map_ids;
> > >  	char name[BPF_OBJ_NAME_LEN];
> > >  	__u32 ifindex;
> > > -	__u64 netns_dev;
> > > -	__u64 netns_ino;
> > > +	__aligned_u64 netns_dev;
> > > +	__aligned_u64 netns_ino;
> > >  } __attribute__((aligned(8)));
> > >  
> > >  struct bpf_map_info {
> > > @@ -1030,8 +1030,8 @@ struct bpf_map_info {
> > >  	__u32 map_flags;
> > >  	char  name[BPF_OBJ_NAME_LEN];
> > >  	__u32 ifindex;
> > > -	__u64 netns_dev;
> > > -	__u64 netns_ino;
> > > +	__aligned_u64 netns_dev;
> > > +	__aligned_u64 netns_ino;
> > >  } __attribute__((aligned(8)));
> > >  
> > >  /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
> > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > > index c5ec897..903010a 100644
> > > --- a/tools/include/uapi/linux/bpf.h
> > > +++ b/tools/include/uapi/linux/bpf.h
> > > @@ -1017,8 +1017,8 @@ struct bpf_prog_info {
> > >  	__aligned_u64 map_ids;
> > >  	char name[BPF_OBJ_NAME_LEN];
> > >  	__u32 ifindex;
> > > -	__u64 netns_dev;
> > > -	__u64 netns_ino;
> > > +	__aligned_u64 netns_dev;
> > > +	__aligned_u64 netns_ino;
> > >  } __attribute__((aligned(8)));
> > >  
> > >  struct bpf_map_info {
> > > @@ -1030,8 +1030,8 @@ struct bpf_map_info {
> > >  	__u32 map_flags;
> > >  	char  name[BPF_OBJ_NAME_LEN];
> > >  	__u32 ifindex;
> > > -	__u64 netns_dev;
> > > -	__u64 netns_ino;
> > > +	__aligned_u64 netns_dev;
> > > +	__aligned_u64 netns_ino;
> > >  } __attribute__((aligned(8)));
> > >  
> > >  /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
> 
> 
> -- 
> ldv
