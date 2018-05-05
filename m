Return-Path: <jannh@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525495726; cv=none;
        d=google.com; s=arc-20160816;
        b=krjpclv6AumwPIQnxaHkk39E+bEGmu3OVFUcxH8dN1IMuk40dJBMmGJITXy156VsZm
         llr2tigzphCIecvGUrUjjSqw6D+lcnLJjYwBDt1WBjJQ1chmx2LZMK/5dn+fMyTCdMDB
         /bWynMan1ejZgfbG11d1LKXcJzbuwjmpRgHa0Aolj4OvwvhECl3jtr4i2evzRaDHOC3D
         lcX9iBhMI1NTMJHjV2CDoqiVtTAZMNOT1GxBLu5ofEq/EnEkL/CmM4kLRCWJx0RacjzN
         0j5yMbtQ0uhuFk6r2BWppIsDvMU77kf6WvN3j5P31VuiuzCn4rvEUYaQn6UQzrM6caj7
         3jPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hCkhHmb+llL4+j2cXiIusDBCpytyec57sQ6h2J/br6A=;
        b=uerqOisHuV35yO26AmUCBjovdBKqy+pLlSBaLG3222496L2Y+lL1PyrNrCOnCp3C1R
         y8oDe9JxeXfRawvp4TR3pmSnMG56d+0luhj7Qy+dxl2JhNvJsDvZW+ZX2HhVZMCcR4YM
         14nobLbUjHlT3M5fByQy8pyKJt3ybIXbaDGVnOF1YjfiX8BG7xsVsuOfIgbppy2/7IpJ
         8Ozu/joLcUGZLHvAkEXOmiZRwDVlcrWC9pwhGZwjSpOFguPRkA3RVx6lZHKVcgwtL/iB
         QdC3N93RxQ7Qy82Y/FQvUtk1E60z8r4l7IDBxzwGl8lk7s2wo9YL8gbiyyIRtKC7qWrk
         RZ6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jGs+AHnD;
       spf=pass (google.com: domain of jannh@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jannh@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jGs+AHnD;
       spf=pass (google.com: domain of jannh@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jannh@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZozD+sXtLspiEVUjsd3d64ucYTMpvZxyoyG3jAFSy6lZZazk7FrnX2dW2Ut7iWLlWF+q6DjJQvrvZO3NzSiEOU=
MIME-Version: 1.0
In-Reply-To: <20180503043604.1604587-2-ast@kernel.org>
References: <20180503043604.1604587-1-ast@kernel.org> <20180503043604.1604587-2-ast@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Sat, 5 May 2018 00:48:24 -0400
Message-ID: <CAG48ez3gB=zFebJAvFCj+6iuicgTiw_0UDEdeWW1Ri82pz8zkw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/4] umh: introduce fork_usermode_blob() helper
To: Alexei Starovoitov <ast@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Lutomirski <luto@amacapital.net>,
	Network Development <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>,
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416216881891368?=
X-GMAIL-MSGID: =?utf-8?q?1599598206774136950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 12:36 AM, Alexei Starovoitov <ast@kernel.org> wrote:
> Introduce helper:
> int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
> struct umh_info {
>        struct file *pipe_to_umh;
>        struct file *pipe_from_umh;
>        pid_t pid;
> };
>
> that GPLed kernel modules (signed or unsigned) can use it to execute part
> of its own data as swappable user mode process.
>
> The kernel will do:
> - mount "tmpfs"
> - allocate a unique file in tmpfs
> - populate that file with [data, data + len] bytes
> - user-mode-helper code will do_execve that file and, before the process
>   starts, the kernel will create two unix pipes for bidirectional
>   communication between kernel module and umh
> - close tmpfs file, effectively deleting it
> - the fork_usermode_blob will return zero on success and populate
>   'struct umh_info' with two unix pipes and the pid of the user process
>
> As the first step in the development of the bpfilter project
> the fork_usermode_blob() helper is introduced to allow user mode code
> to be invoked from a kernel module. The idea is that user mode code plus
> normal kernel module code are built as part of the kernel build
> and installed as traditional kernel module into distro specified location,
> such that from a distribution point of view, there is
> no difference between regular kernel modules and kernel modules + umh code.
> Such modules can be signed, modprobed, rmmod, etc. The use of this new helper
> by a kernel module doesn't make it any special from kernel and user space
> tooling point of view.
[...]
> +static struct vfsmount *umh_fs;
> +
> +static int init_tmpfs(void)
> +{
> +       struct file_system_type *type;
> +
> +       if (umh_fs)
> +               return 0;
> +       type = get_fs_type("tmpfs");
> +       if (!type)
> +               return -ENODEV;
> +       umh_fs = kern_mount(type);
> +       if (IS_ERR(umh_fs)) {
> +               int err = PTR_ERR(umh_fs);
> +
> +               put_filesystem(type);
> +               umh_fs = NULL;
> +               return err;
> +       }
> +       return 0;
> +}

Should init_tmpfs() be holding some sort of mutex if it's fiddling
with `umh_fs`? The current code only calls it in initcall context, but
if that ever changes and two processes try to initialize the tmpfs at
the same time, a few things could go wrong.
I guess Luis' suggestion (putting a call to init_tmpfs() in
do_basic_setup()) might be the easiest way to get rid of that problem.

> +static int alloc_tmpfs_file(size_t size, struct file **filp)
> +{
> +       struct file *file;
> +       int err;
> +
> +       err = init_tmpfs();
> +       if (err)
> +               return err;
> +       file = shmem_file_setup_with_mnt(umh_fs, "umh", size, VM_NORESERVE);
> +       if (IS_ERR(file))
> +               return PTR_ERR(file);
> +       *filp = file;
> +       return 0;
> +}
