Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461D5C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05682087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aq+VXhgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05682087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJHIFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 04:05:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41229 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeJHIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 04:05:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id e18-v6so18012515oti.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 17:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IB8yV4o5YPHjoHGyzs9Q/C2T5pFFtsfV5psNZvRquqk=;
        b=Aq+VXhguI21pkUB0jBvZeJafMOBmXHT5gm4KpLSZxG2LTtxBaq+q+nHjLXaRrn6cvs
         h/noaSRP6g3z9yv9fbjzuHg1z5ak9kXT+wFKG5+NGaKZpuvGPfyx/UzzpW0V+tPQ+Gq5
         nt9HsC8mQ053IA93eA9U4mZFnO5Pl6FKnEYitSVHdPvkgFaEFyg6nQ6ru68BfojxBcIE
         B1XIT4s2nkgCjTfWleUjZFPKZYCNMyayVvuaIJq4Gz5LQh7cxEpa0cObtphyWmDwkyY1
         5e6ajhTwaVrJnigeU5es93wYUoX1h2t54MQEUGfMQyx3lPc1A6T5dL/6Oo1EPtfJetvE
         JlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IB8yV4o5YPHjoHGyzs9Q/C2T5pFFtsfV5psNZvRquqk=;
        b=HQsl02A37XzQEFn99cjoykd93CHp8dtm3Nmb+80l9gok1grYqc9blNUs1adG4RigVj
         w63G5VoRuUY7SrmVNV/eQYFymmzQ7mueonxYeFk5VVIt2QWTu7I7vf1+Plxar7JGvNWO
         Kw2Tu/XfREb4I8KqCBLfXk/bVWmuufNZG8O2mSe7s7f8t0qZOEXiOvWrZbtNR+RC/5il
         vVdOrwoPekWnsIsZnYAhSOICPw0JK8WKozA4Ed4PTZIuE5rvaz9+CXREaXAlINDXS7Rw
         6Xpxn7BntKvfV3zYTi9Vh0yxT7g9WpD1jfo39rF/QzeR8PYr8ZEcdRjSBMca+mk4fZok
         M/ag==
X-Gm-Message-State: ABuFfogglt32i1hcSU458peIIB9g5nEYzelYfvPHYRIRMsQWZaPXM5Uc
        ADfw22tIzqyioLmtyA3oscWYUUGSwpI+qJxGlPy2fg==
X-Google-Smtp-Source: ACcGV62cIXh/8HW1QxtX4WzuRuZkyyUG/7DaF8Bg/gABAirLHkCMPiMzgs6VJjnPphCbMfykVGwxaYdVzarqfoWNF3g=
X-Received: by 2002:a9d:5733:: with SMTP id p48mr11681178oth.292.1538960201639;
 Sun, 07 Oct 2018 17:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181004025750.498303-1-ast@kernel.org> <20181004025750.498303-2-ast@kernel.org>
In-Reply-To: <20181004025750.498303-2-ast@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 8 Oct 2018 02:56:15 +0200
Message-ID: <CAG48ez2zuJP0qOSU5QAER1xP56d5SvC0HTrM0Yh3wkKEQZ9R3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc kernel-hardening because this is related to sandboxing
+cc Micka=C3=ABl Sala=C3=BCn because this looks related to his Landlock pro=
posal

On Mon, Oct 8, 2018 at 2:30 AM Alexei Starovoitov <ast@kernel.org> wrote:
> Similar to networking sandboxing programs and cgroup-v2 based hooks
> (BPF_CGROUP_INET_[INGRESS|EGRESS,] BPF_CGROUP_INET[4|6]_[BIND|CONNECT], e=
tc)
> introduce basic per-container sandboxing for file access via
> new BPF_PROG_TYPE_FILE_FILTER program type that attaches after
> security_file_open() LSM hook and works as additional file_open filter.
> The new cgroup bpf hook is called BPF_CGROUP_FILE_OPEN.

Why do_dentry_open() specifically, and nothing else? If you want to
filter open, wouldn't you also want to filter a bunch of other
filesystem operations with LSM hooks, like rename, unlink, truncate
and so on? Landlock benefits there from re-using the existing security
hooks.

> Just like other cgroup-bpf programs new BPF_PROG_TYPE_FILE_FILTER type
> is only available to root.
>
> This program type has access to single argument 'struct bpf_file_info'
> that contains standard sys_stat fields:
> struct bpf_file_info {
>         __u64 inode;
>         __u32 dev_major;
>         __u32 dev_minor;
>         __u32 fs_magic;
>         __u32 mnt_id;
>         __u32 nlink;
>         __u32 mode;     /* file mode S_ISDIR, S_ISLNK, 0755, etc */
>         __u32 flags;    /* open flags O_RDWR, O_CREAT, etc */
> };
> Other file attributes can be added in the future to the end of this struc=
t
> without breaking bpf programs.
>
> For debugging introduce bpf_get_file_path() helper that returns
> NUL-terminated full path of the file. It should never be used for sandbox=
ing.
>
> Use cases:
> - disallow certain FS types within containers (fs_magic =3D=3D CGROUP2_SU=
PER_MAGIC)
> - restrict permissions in particular mount (mnt_id =3D=3D X && (flags & O=
_RDWR))
> - disallow access to hard linked sensitive files (nlink > 1 && mode =3D=
=3D 0700)
> - disallow access to world writeable files (mode =3D=3D 0..7)
> - disallow access to given set of files (dev_major =3D=3D X && dev_minor =
=3D=3D Y && inode =3D=3D Z)

That last one sounds weird. It doesn't work if you want to ban access
to a whole directory at once. And in general, highly specific
blocklists make me nervous, because if you add anything new and forget
to put it on the list, you have a problem.

> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf-cgroup.h |  10 +++
>  include/linux/bpf_types.h  |   1 +
>  include/uapi/linux/bpf.h   |  28 +++++-
>  kernel/bpf/cgroup.c        | 171 +++++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c       |   7 ++
>  5 files changed, 216 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 588dd5f0bd85..766f0223c222 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -109,6 +109,8 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
>  int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 min=
or,
>                                       short access, enum bpf_attach_type =
type);
>
> +int __cgroup_bpf_file_filter(struct file *file, enum bpf_attach_type typ=
e);
> +
>  static inline enum bpf_cgroup_storage_type cgroup_storage_type(
>         struct bpf_map *map)
>  {
> @@ -253,6 +255,13 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map =
*map, void *key,
>                                                                          =
     \
>         __ret;                                                           =
     \
>  })
> +#define BPF_CGROUP_RUN_PROG_FILE_FILTER(file)                           =
    \
> +({                                                                      =
     \
> +       int __ret =3D 0;                                                 =
       \
> +       if (cgroup_bpf_enabled)                                          =
     \
> +               __ret =3D __cgroup_bpf_file_filter(file, BPF_CGROUP_FILE_=
OPEN); \
> +       __ret;                                                           =
     \
> +})
>  int cgroup_bpf_prog_attach(const union bpf_attr *attr,
>                            enum bpf_prog_type ptype, struct bpf_prog *pro=
g);
>  int cgroup_bpf_prog_detach(const union bpf_attr *attr,
> @@ -321,6 +330,7 @@ static inline int bpf_percpu_cgroup_storage_update(st=
ruct bpf_map *map,
>  #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0;=
 })
> +#define BPF_CGROUP_RUN_PROG_FILE_FILTER(file) ({ 0; })
>
>  #define for_each_cgroup_storage_type(stype) for (; false; )
>
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index 5432f4c9f50e..f182b2e37b94 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -33,6 +33,7 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LIRC_MODE2, lirc_mode2)
>  #ifdef CONFIG_INET
>  BPF_PROG_TYPE(BPF_PROG_TYPE_SK_REUSEPORT, sk_reuseport)
>  #endif
> +BPF_PROG_TYPE(BPF_PROG_TYPE_FILE_FILTER, file_filter)
>
>  BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f9187b41dff6..c0df8dd99edc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -154,6 +154,7 @@ enum bpf_prog_type {
>         BPF_PROG_TYPE_LIRC_MODE2,
>         BPF_PROG_TYPE_SK_REUSEPORT,
>         BPF_PROG_TYPE_FLOW_DISSECTOR,
> +       BPF_PROG_TYPE_FILE_FILTER,
>  };
>
>  enum bpf_attach_type {
> @@ -175,6 +176,7 @@ enum bpf_attach_type {
>         BPF_CGROUP_UDP6_SENDMSG,
>         BPF_LIRC_MODE2,
>         BPF_FLOW_DISSECTOR,
> +       BPF_CGROUP_FILE_OPEN,
>         __MAX_BPF_ATTACH_TYPE
>  };
>
> @@ -2215,6 +2217,18 @@ union bpf_attr {
>   *             pointer that was returned from bpf_sk_lookup_xxx\ ().
>   *     Return
>   *             0 on success, or a negative error in case of failure.
> + *
> + * int bpf_get_file_path(struct bpf_file_info *file, char *buf, u32 size=
_of_buf)
> + *     Description
> + *             Reconstruct the full path of *file* and store it into *bu=
f* of
> + *             *size_of_buf*. The *size_of_buf* must be strictly positiv=
e.
> + *             On success, the helper makes sure that the *buf* is NUL-t=
erminated.
> + *             On failure, it is filled with string "(error)".
> + *             This helper should only be used for debugging.
> + *             'char *path' should never be used for permission checks.
> + *     Return
> + *             0 on success, or a negative error in case of failure.
> + *
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -2303,7 +2317,8 @@ union bpf_attr {
>         FN(skb_ancestor_cgroup_id),     \
>         FN(sk_lookup_tcp),              \
>         FN(sk_lookup_udp),              \
> -       FN(sk_release),
> +       FN(sk_release),                 \
> +       FN(get_file_path),
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
>   * function eBPF program intends to call
> @@ -2896,4 +2911,15 @@ struct bpf_flow_keys {
>         };
>  };
>
> +struct bpf_file_info {
> +       __u64 inode;
> +       __u32 dev_major;
> +       __u32 dev_minor;
> +       __u32 fs_magic;
> +       __u32 mnt_id;
> +       __u32 nlink;
> +       __u32 mode;     /* file mode S_ISDIR, S_ISLNK, 0755, etc */
> +       __u32 flags;    /* open flags O_RDWR, O_CREAT, etc */
> +};
[...]
