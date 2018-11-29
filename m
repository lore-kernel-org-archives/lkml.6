Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6CBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709222086B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP5fxc6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709222086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeK2Moo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:44:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbeK2Moo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:44:44 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97CD321473
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 01:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543455666;
        bh=QxY/NrOLFMD1bey0Bu9s7XYJ30r/UjceZG582NRQnQA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hP5fxc6+ml4dzqJ2jPzkXojP8oMLxzNzLlyfU1EpJRSoWXFI0PGI1xJ/FwAL1xjhK
         6wu/lwVNisjBUkeoKM2pKjFa+ZNpoYU0bXgNepFFgeTBTEdnXd66sdSF3YUttR97F1
         iONDY2xibf7hbfjHjTofra9xW6rx+oxp5SIxdXQw=
Received: by mail-wm1-f43.google.com with SMTP id n133so541075wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 17:41:06 -0800 (PST)
X-Gm-Message-State: AA+aEWYhxoBJeFJTKACfeQMqysNeA2G17Dsp2bNPco/fuXxil4avwy4k
        5SK3Cu5a4LZ2Ce8ArSlDnhHaPnaCv3KYF7T7ZapLtg==
X-Google-Smtp-Source: AFSGD/WfoTkNsD/SpIzGyHzxniNM/V3LNo5UXO6L2pLTY97A3RtZ4/fbzhf69z5mARk/D5a9sQm6+eazl13xJb2C6bQ=
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr4621742wme.108.1543455665079;
 Wed, 28 Nov 2018 17:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com> <20181128000754.18056-3-rick.p.edgecombe@intel.com>
In-Reply-To: <20181128000754.18056-3-rick.p.edgecombe@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Nov 2018 17:40:53 -0800
X-Gmail-Original-Message-ID: <CALCETrU+skBS0r6WtkwwMZJvb3s2vWB-JmDeZtVWV8pOkxKojQ@mail.gmail.com>
Message-ID: <CALCETrU+skBS0r6WtkwwMZJvb3s2vWB-JmDeZtVWV8pOkxKojQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/modules: Make x86 allocs to flush when free
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, jeyu@kernel.org,
        Network Development <netdev@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <rick.p.edgecombe@intel.com> =
wrote:
>
> Change the module allocations to flush before freeing the pages.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> arch/x86/kernel/module.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index b052e883dd8c..1694daf256b3 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -87,8 +87,8 @@ void *module_alloc(unsigned long size)
>    p =3D __vmalloc_node_range(size, MODULE_ALIGN,
>                    MODULES_VADDR + get_module_load_offset(),
>                    MODULES_END, GFP_KERNEL,
> -                    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> -                    __builtin_return_address(0));
> +                    PAGE_KERNEL_EXEC, VM_IMMEDIATE_UNMAP,
> +                    NUMA_NO_NODE, __builtin_return_address(0));

Hmm. How awful is the resulting performance for heavy eBPF users?  I=E2=80=
=99m
wondering if the JIT will need some kind of cache to reuse
allocations.

>    if (p && (kasan_module_alloc(p, size) < 0)) {
>        vfree(p);
>        return NULL;
> --
> 2.17.1
>
