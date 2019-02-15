Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697BBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB6321920
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbfBOILq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:11:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43286 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390540AbfBOILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:11:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so15129661ota.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 00:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3cA10avh2RJqVKzPkWhDR1H+JTQFljMSI7C8GFBdv68=;
        b=A39PI9XlvE4TLxdTv/iDNW7rpx52s/cKDHDbL3jPpJS28sazivQ2tSmwz6IUAAPd9G
         cZ9BA+keR762FH0guvTdZ21dokOzI0dJ53Jm75Gewe49jcB658xo5WH1Nfz2Htjj4hLU
         Xp9cJFK5ms7wuHYAsKVsxPA0agxAwxXuAa5dYZIzYqTMpU+iLYC38gNF4+a/Yb8+QN3k
         G5T1JokFQIqWjqnmccXyLIKjKeD1ZSnN3WJx/c7njoQMyqaHf06UEC60074l+iWe3Qz9
         0jMqkGMShl2Vxpb64LvDvW4TKfn3CrIyWrlMrmsc1So7kyLlXuP8GpWl1tnQydCNpl0L
         qwnQ==
X-Gm-Message-State: AHQUAuafuAjV/hFBY7Sp5M6qSYFpIriojHpG3usjWcyK1pmmXSDA2hOW
        2PRwIEKbYKBKLePSB4nCNFQG607CxY65LScLQIM=
X-Google-Smtp-Source: AHgI3IZHGRbHp85QSkjsm/PAG/vOAXBxQ6nW2o9ez2D+Wch/1sVS8llpq8a4EHj6Z+hG1Zdy1CikmZcMS/w2H6j2vxQ=
X-Received: by 2002:a9d:730d:: with SMTP id e13mr4671323otk.281.1550218305450;
 Fri, 15 Feb 2019 00:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20181208154624.6504-1-malat@debian.org>
In-Reply-To: <20181208154624.6504-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 15 Feb 2019 09:11:34 +0100
Message-ID: <CA+7wUswJy0z_+aytawQv6+1pOVvH2z8SfOz1sxziHtgjqZ1F9g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ptrace: Add prototype for function pt_regs_check
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 8, 2018 at 4:46 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> `pt_regs_check` is a dummy function, its purpose is to break the build
> if struct pt_regs and struct user_pt_regs don't match.
>
> This function has no functionnal purpose, and will get eliminated at
> link time or after init depending on CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>
> This commit adds a prototype to fix warning at W=1:
>
>   arch/powerpc/kernel/ptrace.c:3339:13: error: no previous prototype for ‘pt_regs_check’ [-Werror=missing-prototypes]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/powerpc/kernel/ptrace.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index a398999d0770..341c0060b4c8 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3338,6 +3338,10 @@ void do_syscall_trace_leave(struct pt_regs *regs)
>         user_enter();
>  }
>
> +void __init pt_regs_check(void);
> +/* dummy function, its purpose is to break the build if struct pt_regs and
> + * struct user_pt_regs don't match.
> + */

Another trick which seems to work with GCC is:

-void __init pt_regs_check(void)
+static inline void __init pt_regs_check(void)

>  void __init pt_regs_check(void)
>  {
>         BUILD_BUG_ON(offsetof(struct pt_regs, gpr) !=
> --
> 2.19.2
>
