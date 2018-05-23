Date: Wed, 23 May 2018 19:33:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Miller <davem@davemloft.net>
Cc: ast@kernel.org, daniel@iogearbox.net, torvalds@linux-foundation.org,
	luto@amacapital.net, mcgrof@kernel.org, keescook@chromium.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v3 net-next 0/2] bpfilter
Message-ID: <20180523173351.GA10104@kroah.com>
References: <20180522022230.2492505-1-ast@kernel.org>
 <20180523.132648.459690706167609338.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523.132648.459690706167609338.davem@davemloft.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 01:26:48PM -0400, David Miller wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> Date: Mon, 21 May 2018 19:22:28 -0700
> 
> > v2->v3:
> > - followed Luis's suggestion and significantly simplied first patch
> >   with shmem_kernel_file_setup+kernel_write. Added kdoc for new helper
> > - fixed typos and race to access pipes with mutex
> > - tested with bpfilter being 'builtin'. CONFIG_BPFILTER_UMH=y|m both work.
> >   Interesting to see a usermode executable being embedded inside vmlinux.
> > - it doesn't hurt to enable bpfilter in .config.
> >   ip_setsockopt commands sent to usermode via pipes and -ENOPROTOOPT is
> >   returned from userspace, so kernel falls back to original iptables code
> > 
> > v1->v2:
> > this patch set is almost a full rewrite of the earlier umh modules approach
> > The v1 of patches and follow up discussion was covered by LWN:
> > https://lwn.net/Articles/749108/
> > 
> > I believe the v2 addresses all issues brought up by Andy and others.
> > Mainly there are zero changes to kernel/module.c
> > Instead of teaching module loading logic to recognize special
> > umh module, let normal kernel modules execute part of its own
> > .init.rodata as a new user space process (Andy's idea)
> > Patch 1 introduces this new helper:
> > int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
> > Input:
> >   data + len == executable file
> > Output:
> >   struct umh_info {
> >        struct file *pipe_to_umh;
> >        struct file *pipe_from_umh;
> >        pid_t pid;
> >   };
> 
> Series applied, let the madness begin... :-)

Yeah, this is going to be fun :)
