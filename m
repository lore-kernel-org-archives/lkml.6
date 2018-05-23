Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933840AbeEWR0y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:26:54 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60198 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933760AbeEWR0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:26:50 -0400
Date: Wed, 23 May 2018 13:26:48 -0400 (EDT)
Message-Id: <20180523.132648.459690706167609338.davem@davemloft.net>
To: ast@kernel.org
Cc: daniel@iogearbox.net, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, luto@amacapital.net, mcgrof@kernel.org,
        keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 net-next 0/2] bpfilter
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180522022230.2492505-1-ast@kernel.org>
References: <20180522022230.2492505-1-ast@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Mon, 21 May 2018 19:22:28 -0700

> v2->v3:
> - followed Luis's suggestion and significantly simplied first patch
>   with shmem_kernel_file_setup+kernel_write. Added kdoc for new helper
> - fixed typos and race to access pipes with mutex
> - tested with bpfilter being 'builtin'. CONFIG_BPFILTER_UMH=y|m both work.
>   Interesting to see a usermode executable being embedded inside vmlinux.
> - it doesn't hurt to enable bpfilter in .config.
>   ip_setsockopt commands sent to usermode via pipes and -ENOPROTOOPT is
>   returned from userspace, so kernel falls back to original iptables code
> 
> v1->v2:
> this patch set is almost a full rewrite of the earlier umh modules approach
> The v1 of patches and follow up discussion was covered by LWN:
> https://lwn.net/Articles/749108/
> 
> I believe the v2 addresses all issues brought up by Andy and others.
> Mainly there are zero changes to kernel/module.c
> Instead of teaching module loading logic to recognize special
> umh module, let normal kernel modules execute part of its own
> .init.rodata as a new user space process (Andy's idea)
> Patch 1 introduces this new helper:
> int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
> Input:
>   data + len == executable file
> Output:
>   struct umh_info {
>        struct file *pipe_to_umh;
>        struct file *pipe_from_umh;
>        pid_t pid;
>   };

Series applied, let the madness begin... :-)
