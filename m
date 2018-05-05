Return-Path: <alexei.starovoitov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525537460; cv=none;
        d=google.com; s=arc-20160816;
        b=n/30Ku7qsmhlAeRFWJc1EqTxuhI24pfNzaEikr4PUyqMSiTBEgpL2gtizhO5ieWVfa
         CnnT6wKWE88kVKpXOCwDiuvM4gu24HF+UEePWx3FX3g3I8uYzlm2AfCcKPAwJvCCm0CI
         EUgmoXX+XQ/O/6ugjuLnblMnfw62hJNRu17U7Ey9ktp1p1rQZ9cYLpSfZh90kq08ZFrR
         +nGLLDxTDuBWRlz375JN4GXlgbMFs+GvvuyNXfoNZ0DZNHqD8/t/Cxya0MNmjlGfee2q
         G0U6LzMQrgvDI7f4mVvzGTLWG/6F7s6Zp0VeN2UbgiCtY+3RtxpsdA6jbZkssZ8jztWZ
         iO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=nLCRsToTox2IRoBRieaHW6caU/Zs3povL6LRhKQ/mrQ=;
        b=QLZBU4D1d+mCscYIeDZrBHxyZQDi7TbD4RglcfxXamggTqe0L5a09CPByL10+A6DEA
         hyMGI1s9TQfbAWY91eMBpPS4db5Yvise6b4DXRjs/Iat4nL4Xg36g3CT0O/ilalinD+5
         XOujeTGC/B9UKdxn6cBDBngWsInHyA/5qHQvJnM8Z5e1f+0hoOt3PvSR/AqhEcClqNvA
         lqAplMjps/6gOPTH8FQD1Q95dgaxfRcT+paBTYPPf+hxwtQ+0I2Spe/5YLT79zBchl3n
         rshrcOWm6JQRNQdJuEg76KrvFwWYtLek0zwAJ4ZSVnbRQkU3lPS7s5ysQzPW1cYbRci9
         AVUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SoSIcxxg;
       spf=pass (google.com: domain of alexei.starovoitov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexei.starovoitov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SoSIcxxg;
       spf=pass (google.com: domain of alexei.starovoitov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexei.starovoitov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZo/La9pfyPLxqeVTrn3xjY3cxDxKhtIMuuJ1+KgN1SFKoy9XYpD2dUkA1TEV0DDKeIlsbtWXQ==
Date: Sat, 5 May 2018 09:24:15 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Network Development <netdev@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 net-next 1/4] umh: introduce fork_usermode_blob()
 helper
Message-ID: <20180505162413.tmmtdgdds5yme64j@ast-mbp>
References: <20180503043604.1604587-1-ast@kernel.org>
 <20180503043604.1604587-2-ast@kernel.org>
 <CAG48ez3gB=zFebJAvFCj+6iuicgTiw_0UDEdeWW1Ri82pz8zkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3gB=zFebJAvFCj+6iuicgTiw_0UDEdeWW1Ri82pz8zkw@mail.gmail.com>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416216881891368?=
X-GMAIL-MSGID: =?utf-8?q?1599641967476820070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 05, 2018 at 12:48:24AM -0400, Jann Horn wrote:
> On Thu, May 3, 2018 at 12:36 AM, Alexei Starovoitov <ast@kernel.org> wrote:
> > Introduce helper:
> > int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
> > struct umh_info {
> >        struct file *pipe_to_umh;
> >        struct file *pipe_from_umh;
> >        pid_t pid;
> > };
> >
> > that GPLed kernel modules (signed or unsigned) can use it to execute part
> > of its own data as swappable user mode process.
> >
> > The kernel will do:
> > - mount "tmpfs"
> > - allocate a unique file in tmpfs
> > - populate that file with [data, data + len] bytes
> > - user-mode-helper code will do_execve that file and, before the process
> >   starts, the kernel will create two unix pipes for bidirectional
> >   communication between kernel module and umh
> > - close tmpfs file, effectively deleting it
> > - the fork_usermode_blob will return zero on success and populate
> >   'struct umh_info' with two unix pipes and the pid of the user process
> >
> > As the first step in the development of the bpfilter project
> > the fork_usermode_blob() helper is introduced to allow user mode code
> > to be invoked from a kernel module. The idea is that user mode code plus
> > normal kernel module code are built as part of the kernel build
> > and installed as traditional kernel module into distro specified location,
> > such that from a distribution point of view, there is
> > no difference between regular kernel modules and kernel modules + umh code.
> > Such modules can be signed, modprobed, rmmod, etc. The use of this new helper
> > by a kernel module doesn't make it any special from kernel and user space
> > tooling point of view.
> [...]
> > +static struct vfsmount *umh_fs;
> > +
> > +static int init_tmpfs(void)
> > +{
> > +       struct file_system_type *type;
> > +
> > +       if (umh_fs)
> > +               return 0;
> > +       type = get_fs_type("tmpfs");
> > +       if (!type)
> > +               return -ENODEV;
> > +       umh_fs = kern_mount(type);
> > +       if (IS_ERR(umh_fs)) {
> > +               int err = PTR_ERR(umh_fs);
> > +
> > +               put_filesystem(type);
> > +               umh_fs = NULL;
> > +               return err;
> > +       }
> > +       return 0;
> > +}
> 
> Should init_tmpfs() be holding some sort of mutex if it's fiddling
> with `umh_fs`? The current code only calls it in initcall context, but
> if that ever changes and two processes try to initialize the tmpfs at
> the same time, a few things could go wrong.

I thought that module loading is serialized, so calls to
fork_usermode_blob() will be serialized as well, but looking at the code
again that doesn't seem to be the case, so need to revisit not only
this function, but the rest of it too.

> I guess Luis' suggestion (putting a call to init_tmpfs() in
> do_basic_setup()) might be the easiest way to get rid of that problem.

I still think that two mounts where umh mount is dynamic is cleaner.
Why waste the mount if no module uses this helper?
I'm thinking to wrap init_tmpfs into DO_ONCE instead or use a mutex.
Looks like shmem_file_setup_with_mnt() can be called in parallel
on the same mount, so that should be fine.
