Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB86C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECE52087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeL2WhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:37:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42107 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeL2WhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:37:07 -0500
Received: by mail-qk1-f195.google.com with SMTP id 68so14243096qke.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 14:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWodW4m2le/vPs28+pio7unZZk61wUo/y9VehQhAy9Q=;
        b=qc469VgCW3oqjvLQJGShcc00Z6+icKI+/Rdx6/oqom/ciCV0orYqUq+K265uJyORp2
         8Yd7pWsEO/mrOofxoRtAvwqhPRvJXHsF70BJhtP+N33s45238RncUSYF43EL6E3zjaV7
         Tm2v2RSyPfj3aCvDM2ZAFJ3xjL1K5vj+qExbpsFOmPXEhR7lDxnFg3zWkIj6Nh4rgwlZ
         hvVnkWPedvGXy45QFTzeFn3UHUtJN7/h/JqpSJ3barNas4E3YQ3S8W/b/J+042/mvqN3
         1wMQGkfoOz1Xl02s7pN/KyZhmonem6nKhTFO3/1gPyFvmQN4u5RzKgUE8zzZR0FNcUX7
         locw==
X-Gm-Message-State: AJcUukcHfQsBkvHhMkgGZI6JCCN1Le3g8flmRVz19bJsMavTXCgSLg3c
        /FKhP1qfPr+fi8ZJ1VqImQ3U4ZVtnN/mg9sAuk0=
X-Google-Smtp-Source: ALg8bN5Ka4ZPtc7cyLPrB5ESs81qsypqdT3JLKIWF5u6XU+Lk2Lzxt8eH0yte00FtXFLRVUfviv8sQGYYOjAp9Aafjo=
X-Received: by 2002:a37:324a:: with SMTP id y71mr30094684qky.291.1546123026112;
 Sat, 29 Dec 2018 14:37:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au> <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 29 Dec 2018 23:36:49 +0100
Message-ID: <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:

> +static ssize_t ppc_nvram_get_size(void)
> +{
> +       if (ppc_md.nvram_size)
> +               return ppc_md.nvram_size();
> +       return -ENODEV;
> +}

> +const struct nvram_ops arch_nvram_ops = {
> +       .read           = ppc_nvram_read,
> +       .write          = ppc_nvram_write,
> +       .get_size       = ppc_nvram_get_size,
> +       .sync           = ppc_nvram_sync,
> +};

Coming back to this after my comment on the m68k side, I notice that
there is now a double indirection through function pointers. Have you
considered completely removing the operations from ppc_md instead
by having multiple copies of nvram_ops?

With the current method, it does seem odd to have a single
per-architecture instance of the exported structure containing
function pointers. This doesn't give us the flexibility of having
multiple copies in the kernel the way that ppc_md does, but it adds
overhead compared to simply exporting the functions directly.

       Arnd
