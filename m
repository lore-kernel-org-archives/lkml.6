Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF833C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804002075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="VywlTgzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfBVNiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:38:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35798 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfBVNin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:38:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id u128so1725849oie.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 05:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKZvRj6I8l74yCIsC1zmPgeNgy+oZb57Swx8tAxvfsU=;
        b=VywlTgzuqsO77YnwrudfdDgg4PPP6mItd/v7YSb8J3FqMUOmjmMCm1gOHbviVQJoqh
         Ndqsb9QtdrjqrGQiiTx0Vvf77YZTsqpzHeJ1oOy6HV66tDS/qI2Cytbg8gsjEXhwTb0u
         RNWd9SW6yEPOb3Ek3qvTgHZnnUGeZr+29ZV5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKZvRj6I8l74yCIsC1zmPgeNgy+oZb57Swx8tAxvfsU=;
        b=CH55qyfzvcerMu/JxLsWwlYLl+V6L1J8RxXYIFb67WSM5Xb+Jx34eqcjaCw7xRZRqm
         bA3qR4lBYLzMQBgf8zvUzk3k2lQJXX1wcPoi3/KvJQF4+nDd5SzjSkEOxBiAFg+R/0Lv
         ht073SeRlewcLcviAA94gkQQW418IcBvdjnUUQyeeC9dPhcmIsc+z/sMqkxYachYQM9I
         Ncbvlds9EKaUGcV/5yCSr7lcz9Ky0CLaDfhmGrqfsXQ/o5IsRRKsWFszz4kvTx2mk2ds
         uRP+XC/dDa8eKwxVB4FoGWmkI1S0eK0Pg7eDD8USI0zsQFKZR7FzjNGUH2brklOhQxs1
         n8ng==
X-Gm-Message-State: AHQUAuaXp9ULxOqbi1pvQsgcJcsSKlQ4EugKmSsI9n4yLKjtEbCsnFGu
        GdV/Oi8Q8xGXRNAkg7rUHVpjrOIphJrGLjbT+E5fFg==
X-Google-Smtp-Source: AHgI3IYOFjV3LoeSRwP5wnAW/0iDJZWw/50bsuOybcTZT1aUM7CVDTasRp4eVkq5Z6bxiuBpcHr2Bu5SihF1iBShG8g=
X-Received: by 2002:aca:538f:: with SMTP id h137mr2597326oib.54.1550842722163;
 Fri, 22 Feb 2019 05:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20190222131908.6207-1-alban@kinvolk.io>
In-Reply-To: <20190222131908.6207-1-alban@kinvolk.io>
From:   Alban Crequy <alban@kinvolk.io>
Date:   Fri, 22 Feb 2019 14:38:31 +0100
Message-ID: <CADZs7q4uDvJ3JPJu1aTc1fM4jJfDePcJeOgx=0gmNJoG=8OKyQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf, lpm: fix lookup bug in map_delete_elem
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>,
        Craig Gallek <kraig@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adding cc: Craig Gallek <kraig@google.com>

I got the "git send-email" command wrong, and the cc to Craig was
removed, despite being listed in the commitmsg. Sorry for my mistake.
There is a copy of the patch at this URL, if needed:
https://github.com/kinvolk/linux/commit/5c522b02ee447f2eb060f840ba709af6b425f932

On Fri, Feb 22, 2019 at 2:19 PM Alban Crequy <alban.crequy@gmail.com> wrote:
>
> From: Alban Crequy <alban@kinvolk.io>
>
> trie_delete_elem() was deleting an entry even though it was not matching
> if the prefixlen was correct. This patch adds a check on matchlen.
>
> Reproducer:
>
> $ sudo bpftool map create /sys/fs/bpf/mylpm type lpm_trie key 8 value 1 entries 128 name mylpm flags 1
> $ sudo bpftool map update pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 aa bb cc dd value hex 01
> $ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
> key: 10 00 00 00 aa bb cc dd  value: 01
> Found 1 element
> $ sudo bpftool map delete pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 ff ff ff ff
> $ echo $?
> 0
> $ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
> Found 0 elements
>
> A similar reproducer is added in the selftests.
>
> Without the patch:
>
> $ sudo ./tools/testing/selftests/bpf/test_lpm_map
> test_lpm_map: test_lpm_map.c:485: test_lpm_delete: Assertion `bpf_map_delete_elem(map_fd, key) == -1 && errno == ENOENT' failed.
> Aborted
>
> With the patch: test_lpm_map runs without errors.
>
> Fixes: e454cf595853 ("bpf: Implement map_delete_elem for BPF_MAP_TYPE_LPM_TRIE")
> Cc: Craig Gallek <kraig@google.com>
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
>
> ---
>
> Changes v1 to v2:
> - add selftest (review from Martin)
> - update commitmsg tags (review from Martin)
> - rebase on "bpf" tree and test again (review from Martin)
> ---
>  kernel/bpf/lpm_trie.c                      |  1 +
>  tools/testing/selftests/bpf/test_lpm_map.c | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index abf1002080df..93a5cbbde421 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -471,6 +471,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
>         }
>
>         if (!node || node->prefixlen != key->prefixlen ||
> +           node->prefixlen != matchlen ||
>             (node->flags & LPM_TREE_NODE_FLAG_IM)) {
>                 ret = -ENOENT;
>                 goto out;
> diff --git a/tools/testing/selftests/bpf/test_lpm_map.c b/tools/testing/selftests/bpf/test_lpm_map.c
> index 147e34cfceb7..02d7c871862a 100644
> --- a/tools/testing/selftests/bpf/test_lpm_map.c
> +++ b/tools/testing/selftests/bpf/test_lpm_map.c
> @@ -474,6 +474,16 @@ static void test_lpm_delete(void)
>         assert(bpf_map_lookup_elem(map_fd, key, &value) == -1 &&
>                 errno == ENOENT);
>
> +       key->prefixlen = 30; // unused prefix so far
> +       inet_pton(AF_INET, "192.255.0.0", key->data);
> +       assert(bpf_map_delete_elem(map_fd, key) == -1 &&
> +               errno == ENOENT);
> +
> +       key->prefixlen = 16; // same prefix as the root node
> +       inet_pton(AF_INET, "192.255.0.0", key->data);
> +       assert(bpf_map_delete_elem(map_fd, key) == -1 &&
> +               errno == ENOENT);
> +
>         /* assert initial lookup */
>         key->prefixlen = 32;
>         inet_pton(AF_INET, "192.168.0.1", key->data);
> --
> 2.20.1
>
