Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9107AC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D87F27EDB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5ZWzXCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D87F27EDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937503AbeF2VCV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:02:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42419 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936431AbeF2VCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:02:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id k20-v6so8298168ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=v8BAsYL7JgI3sWPenSjeGmv7iWlTh4d99mgPEf77fsI=;
        b=m5ZWzXCWucz5un9Pq/vkhoFkAG4hpqkykpcGnUyYV2SjxbOqo6/ekSIvfRobkY6moG
         NyqoGZkvHZzFNf08yD0sdpfiLpKkrRpT8yEcq4GvMRbLc7R+nayo8WD+04BD6VZM/I14
         J+M2Vh940uC4HIieRrT9vxemM+M2IvKToLzI2zeggr22svQOHwAfajAPy7mYSpnmS9xe
         yR7B8jwV1Bug4cue2w4GF0nhdEuxZmEQcccz5Hej7XIp/NioDVhKc0Nkvp+aWK2KRaju
         GvxXBljdMZFYWqvHDtVvmIuW33xhB809YTD2WSfEjcNLkbIntVzN6okhhuFilxVViqoy
         67Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=v8BAsYL7JgI3sWPenSjeGmv7iWlTh4d99mgPEf77fsI=;
        b=fU7iynqpBth0YVc7bTHjnWhHCj8gwSJNkddOODbvugf43ICRRqZ5dQx1YkV9nC4cUa
         Lk6GFm/XEI7dUU+2S7TCMScfPrCAnJaD34icrEtbfhg4X6c+pDBk5VW4Jpic7K43VsiV
         SrYgfXGkmJC+XlB+X35aeH9cqm4Biey27gCZ2Q+KQQEs+j9zCGv/bQTQAuAU0g7Ujdha
         DG/Z5j3M6sldwhxB2IivV/4CJGWPTrZo2VmSoK5k83egf67YSiJUIDj4i+eJKTfBlkFg
         AKdSe7on60hp2fV7Cf8Fv5xlj2BR5Mvl7l6hmgv8npLbgHpdisgZ3OuZrxTUXwEMHWbV
         gqxg==
X-Gm-Message-State: APt69E3BCri4jbXsCibPsNsSiKm44jxeSttMUml5mMNcz2wS3DZzTq1K
        SBhrGYCQTIdQeZUxC8cLQ76vKTfqHFdo2yqsyhw=
X-Google-Smtp-Source: AAOMgpfbF09Q8U64wFChafO5cI+NQyzP7fWWXxbsuEsNWEXd4yNJI0GsrWbd+daqwBAom5rDO/VgqBvvcWm0Oxhkq4k=
X-Received: by 2002:a2e:9599:: with SMTP id w25-v6mr2980389ljh.6.1530306136051;
 Fri, 29 Jun 2018 14:02:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:02:15
 -0700 (PDT)
In-Reply-To: <20180629185339.GA37582@beast>
References: <20180629185339.GA37582@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Jun 2018 23:02:15 +0200
X-Google-Sender-Auth: MzO67Lpksp2MuOAI2HAWZCve-uQ
Message-ID: <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Anatolij Gustschin <agust@denx.de>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 8:53 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a stack size large enough for the saved routine and
> adds a sanity check.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

This seems particularly nice, not only avoids it the dynamic stack
allocation, it
also makes sure the new 0x500 handler doesn't overflow into the 0x600
exception handler.

It would help to explain how you arrived at that '256 byte' number in
the changelog though.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  arch/powerpc/platforms/52xx/mpc52xx_pm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
> index 31d3515672f3..b23da85fa73c 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
> @@ -117,7 +117,10 @@ int mpc52xx_pm_enter(suspend_state_t state)
>         u32 intr_main_mask;
>         void __iomem * irq_0x500 = (void __iomem *)CONFIG_KERNEL_START + 0x500;
>         unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
> -       char saved_0x500[mpc52xx_ds_cached_size];
> +       char saved_0x500[256];
> +
> +       if (WARN_ON(mpc52xx_ds_cached_size > sizeof(saved_0x500)))
> +               return -ENOMEM;
>
>         /* disable all interrupts in PIC */
>         intr_main_mask = in_be32(&intr->main_mask);
