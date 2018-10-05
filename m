Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA3BC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9190920834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9190920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wand.net.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJFATk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:19:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41397 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeJFATj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:19:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id 23-v6so6005307qkh.8;
        Fri, 05 Oct 2018 10:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrkVWQizy5vQIraI8/9WMpZhXQvk091qqfexNWXI9OI=;
        b=N/G5XM+HrRSz6LNZg9rPdm7iinlureWeWjEP1lvgPYF89c5zBPpss8JmgF3stq40vm
         vITEAg4lX7GgUY/KNl3hk5ZHC6J2YN2PE5JBkY7qG5C7YB8aUcdGNjVB0yPj0wYbTBu/
         6pl3qWkFQhldgyTMWk6PW7r495o0onTjbRYzZdO/mV5UIpeJTfZB88scnEkABu06cQuB
         XbM9SjlwblHPSLiTXcMH0+K75Wp8313DSDmrVw/vX6pt7ZkoAKibNsfLIHU2rV3Oegz9
         bi+CNcaXHximOF0zG3XDR/K5Bc19MRN2JCvee4HuUKs9DiydMGOokEaigObMUCBXJG7j
         J0zQ==
X-Gm-Message-State: ABuFfojmLNnHIDmb8Ey8wqjI6o5SmVuqPenezsXwiOSDUqbFBDusYY1V
        Idh80hZ1nAou4Bi9yTndkrMM/8ZtGrq3HdRq/oc=
X-Google-Smtp-Source: ACcGV61ky1047xH4fwfIQ/zOwitKK7X/+hLb753EtFru7AueaZaoDPW6xDrlDJd+ZpTraiFSXlSgko/b9Xm+Hp0uBsQ=
X-Received: by 2002:a37:a215:: with SMTP id l21-v6mr9891383qke.101.1538759998278;
 Fri, 05 Oct 2018 10:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181005161526.843924-1-arnd@arndb.de>
In-Reply-To: <20181005161526.843924-1-arnd@arndb.de>
From:   Joe Stringer <joe@wand.net.nz>
Date:   Fri, 5 Oct 2018 10:19:47 -0700
Message-ID: <CAOftzPg0POeTg+A2-fZM-A78sQf0r1saj23AhV6Ge7yBJGDHBw@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix building without CONFIG_INET
To:     arnd@arndb.de
Cc:     ast@kernel.org, daniel@iogearbox.net,
        David Miller <davem@davemloft.net>,
        john fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        makita.toshiaki@lab.ntt.co.jp, brakmo@fb.com, rdna@fb.com,
        Jesper Brouer <brouer@redhat.com>,
        jakub.kicinski@netronome.com, m.xhonneux@gmail.com,
        dsahern@gmail.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 at 09:16, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The newly added TCP and UDP handling fails to link when CONFIG_INET
> is disabled:
>
> net/core/filter.o: In function `sk_lookup':
> filter.c:(.text+0x7ff8): undefined reference to `tcp_hashinfo'
> filter.c:(.text+0x7ffc): undefined reference to `tcp_hashinfo'
> filter.c:(.text+0x8020): undefined reference to `__inet_lookup_established'
> filter.c:(.text+0x8058): undefined reference to `__inet_lookup_listener'
> filter.c:(.text+0x8068): undefined reference to `udp_table'
> filter.c:(.text+0x8070): undefined reference to `udp_table'
> filter.c:(.text+0x808c): undefined reference to `__udp4_lib_lookup'
> net/core/filter.o: In function `bpf_sk_release':
> filter.c:(.text+0x82e8): undefined reference to `sock_gen_put'
>
> The compiler can optimize it out and avoid those references for
> the most part, but we are missing a few steps here:
>
> - sk_lookup() should always have been marked 'static', this also
>   avoids a warning about a missing prototype when building with
>   'make W=1'.
> - The BPF_CALL_x() macro needs a little change to allow marking
>   the unneeded BPF call as 'static' and having the compiler
>   drop them.
> - The reference to the bpf_func_proto must be made conditional.
>
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for the fix.

>  include/linux/filter.h |  2 +-
>  net/core/filter.c      | 18 +++++++++++-------
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 6791a0ac0139..d9ec9d908bbe 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -428,9 +428,9 @@ struct sock_reuseport;
>                   u64, __ur_3, u64, __ur_4, u64, __ur_5)
>
>  #define BPF_CALL_x(x, name, ...)                                              \
> +       u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));         \
>         static __always_inline                                                 \
>         u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
> -       u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));         \
>         u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))          \
>         {                                                                      \
>                 return ____##name(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\

For what it's worth, other similar cases in net/core/filter.c avoid
this by just wrapping the relevant sections of the code in the #ifdef
as well.

Might be a bit simpler to follow that style (only checked with make
M=net/core W=1):

$ git di
diff --git a/net/core/filter.c b/net/core/filter.c
index 30c6b2d3ef16..4bbc6567fcb8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4817,8 +4817,9 @@ static const struct bpf_func_proto
bpf_lwt_seg6_adjust_srh_proto = {
};
#endif /* CONFIG_IPV6_SEG6_BPF */

-struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
-                      struct sk_buff *skb, u8 family, u8 proto)
+#ifdef CONFIG_INET
+static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
+                             struct sk_buff *skb, u8 family, u8 proto)
{
       int dif = skb->dev->ifindex;
       bool refcounted = false;
@@ -4951,6 +4952,7 @@ static const struct bpf_func_proto
bpf_sk_release_proto = {
       .ret_type       = RET_INTEGER,
       .arg1_type      = ARG_PTR_TO_SOCKET,
};
+#endif /* CONFIG_INET */

bool bpf_helper_changes_pkt_data(void *func)
{
@@ -5158,12 +5160,14 @@ tc_cls_act_func_proto(enum bpf_func_id
func_id, const struct bpf_prog *prog)
       case BPF_FUNC_skb_ancestor_cgroup_id:
               return &bpf_skb_ancestor_cgroup_id_proto;
#endif
+#ifdef CONFIG_INET
       case BPF_FUNC_sk_lookup_tcp:
               return &bpf_sk_lookup_tcp_proto;
       case BPF_FUNC_sk_lookup_udp:
               return &bpf_sk_lookup_udp_proto;
       case BPF_FUNC_sk_release:
               return &bpf_sk_release_proto;
+#endif
       default:
               return bpf_base_func_proto(func_id);
       }
@@ -5264,12 +5268,14 @@ sk_skb_func_proto(enum bpf_func_id func_id,
const struct bpf_prog *prog)
               return &bpf_sk_redirect_hash_proto;
       case BPF_FUNC_get_local_storage:
               return &bpf_get_local_storage_proto;
+#ifdef CONFIG_INET
       case BPF_FUNC_sk_lookup_tcp:
               return &bpf_sk_lookup_tcp_proto;
       case BPF_FUNC_sk_lookup_udp:
               return &bpf_sk_lookup_udp_proto;
       case BPF_FUNC_sk_release:
               return &bpf_sk_release_proto;
+#endif
       default:
               return bpf_base_func_proto(func_id);
       }
