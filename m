Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965374AbeE2RRj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:17:39 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38644 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965010AbeE2RRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:17:35 -0400
X-Google-Smtp-Source: ADUXVKJ5cz1ubPgYyJ78P/Q7GXPNAErkGzAFFO3Mato7jakRsgto0aLFY2nfbkQjYT4HktokWrSC6FJ2qavHDgu8FIU=
MIME-Version: 1.0
In-Reply-To: <20180527112842.GA18204@asgard.redhat.com>
References: <20180527112842.GA18204@asgard.redhat.com>
From: Song Liu <liu.song.a23@gmail.com>
Date: Tue, 29 May 2018 10:17:34 -0700
Message-ID: <CAPhsuW4v=V0mbz07xe_shd68WP3BoV8iofxyVGApi+sL9kgzWQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix alignment of netns_dev/netns_ino fields
 in bpf_{map,prog}_info
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 4:28 AM, Eugene Syromiatnikov <esyr@redhat.com> wrote:
> Recent introduction of netns_dev/netns_ino to bpf_map_info/bpf_prog info
> has broken compat, as offsets of these fields are different in 32-bit
> and 64-bit ABIs.  One fix (other than implementing compat support in
> syscall in order to handle this discrepancy) is to use __aligned_u64
> instead of __u64 for these fields.
>
> Reported-by: Dmitry V. Levin <ldv@altlinux.org>
> Fixes: 52775b33bb507 ("bpf: offload: report device information about
> offloaded maps")
> Fixes: 675fc275a3a2d ("bpf: offload: report device information for
> offloaded programs")
>
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>  include/uapi/linux/bpf.h       | 8 ++++----
>  tools/include/uapi/linux/bpf.h | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c5ec897..903010a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1017,8 +1017,8 @@ struct bpf_prog_info {
>         __aligned_u64 map_ids;
>         char name[BPF_OBJ_NAME_LEN];
>         __u32 ifindex;
> -       __u64 netns_dev;
> -       __u64 netns_ino;
> +       __aligned_u64 netns_dev;
> +       __aligned_u64 netns_ino;
>  } __attribute__((aligned(8)));

Shall we add a __u32 padding variable before netns_dev? We can use it
for in the future.

Thanks,
Song

>
>  struct bpf_map_info {
> @@ -1030,8 +1030,8 @@ struct bpf_map_info {
>         __u32 map_flags;
>         char  name[BPF_OBJ_NAME_LEN];
>         __u32 ifindex;
> -       __u64 netns_dev;
> -       __u64 netns_ino;
> +       __aligned_u64 netns_dev;
> +       __aligned_u64 netns_ino;
>  } __attribute__((aligned(8)));
>
>  /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index c5ec897..903010a 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1017,8 +1017,8 @@ struct bpf_prog_info {
>         __aligned_u64 map_ids;
>         char name[BPF_OBJ_NAME_LEN];
>         __u32 ifindex;
> -       __u64 netns_dev;
> -       __u64 netns_ino;
> +       __aligned_u64 netns_dev;
> +       __aligned_u64 netns_ino;
>  } __attribute__((aligned(8)));
>
>  struct bpf_map_info {
> @@ -1030,8 +1030,8 @@ struct bpf_map_info {
>         __u32 map_flags;
>         char  name[BPF_OBJ_NAME_LEN];
>         __u32 ifindex;
> -       __u64 netns_dev;
> -       __u64 netns_ino;
> +       __aligned_u64 netns_dev;
> +       __aligned_u64 netns_ino;
>  } __attribute__((aligned(8)));
>
>  /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
> --
> 2.1.4
>
