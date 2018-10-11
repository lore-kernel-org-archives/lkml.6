Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14556C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CA72085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CA72085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeJKO4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:56:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43494 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:56:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id q41-v6so8742783qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKbiLLke6MP/0FcmMV9ZeoaTU7oBYAbuD+pPwrcu6n8=;
        b=X+aq2rumIL7L052kCUFb0mOsZynRiIMLnVQ8LoepRWlnuCoHKkL5GxaJBAYzzDv5dM
         Gpwu+bwgz0vztFImKhK4OdjFJsZdEgE7GXCUqBy1edZc6l4rUIhUqvNwqgQdysDk+SBq
         efFHVzfUM11aq1coRGwFRiz3UiG1xIrobVqgDj5SRzo3Mn6E673Ij+xqCLfQw7YmacaB
         Q8rLM77UdXzc31OdfuviKvr2xbmyF223zYhagKEAqO389Bu/WQdRzgFKPKTl80O0sWkX
         0jUElOcCwY9sZp67ORVB1vNcqaCxYI2z3sjfgnPVQ2MY8zzVC+ummrMQBfgISO1heLyE
         rklQ==
X-Gm-Message-State: ABuFfoh8E5pNMbYtHBwzKR6fAmxNHIv5UqExrJL3Vzoi6fMxbMN0HFLa
        +2LpUH53f4pgaqQEyLb5PyG9CHbqo+mDxMmUKsY=
X-Google-Smtp-Source: ACcGV60fZJs8u4WsS2uR6PqGvcsF/DTsYKbCiWwTEy7w/NWESXPkMy/8INEqP+hmhcL/hC6XI3mOq20FlQ9nuWpJJXE=
X-Received: by 2002:a0c:881c:: with SMTP id 28mr434808qvl.40.1539243046934;
 Thu, 11 Oct 2018 00:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <1539224450-19928-1-git-send-email-vincentc@andestech.com> <1539224450-19928-2-git-send-email-vincentc@andestech.com>
In-Reply-To: <1539224450-19928-2-git-send-email-vincentc@andestech.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 09:30:30 +0200
Message-ID: <CAK8P3a2U_-EmBf5r4wELddwTYF-S_GKPBcwPiqhV0cp-Cb44gA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] nds32: nds32 FPU port
To:     Vincent Chen <vincentc@andestech.com>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 4:56 AM Vincent Chen <vincentc@andestech.com> wrote:
>
> This commit contains basic components for nds32 FPU support such as
> FPU exception handler and context switch for FPU register.
>
> diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
> index b8c8984..7ee4e19 100644
> --- a/arch/nds32/Kconfig.cpu
> +++ b/arch/nds32/Kconfig.cpu
> @@ -7,6 +7,28 @@ config CPU_LITTLE_ENDIAN
>         bool "Little endian"
>         default y
>
> +config FPU
> +       bool "FPU support"
> +       default n
> +       help
> +         If FPU ISA is used in user space, this configure shall be Y to make
> +         the fpu context switch and fpu exception handler is enabled in kernel.
> +         Lazy FPU is the default scheme for fpu context switch. If user wants
> +         to disable Lazy FPU scheme, please enable CONFIG_UNLAZY_FPU.
> +
> +         If no FPU ISA is used in user space, say N.

There was a long discussion on RISC-V about what happens when
FPU support is enabled or disabled, you may have seen that as well.

Can you confirm that:

a) A kernel with FPU support enabled running on a CPU without an FPU
    will behave the same as a kernel without FPU support, and in particular
    not crash while trying to access the FPU
b) A kernel with FPU support disabled running on a CPU with an FPU
    prevents user space from accessing the FPU, to avoid corrupting
    FPU registers during a task switch when a process accidentally contains
    FPU access

> +config UNLAZY_FPU
> +       bool "Unlazy FPU support"
> +       depends on FPU
> +       default n
> +       help
> +         Say Y here to disable lazy FPU scheme. Disable lazy FPU scheme causes
> +         some performance loss because the fpu register are loaded and stored
> +         in each context switch.
> +
> +         For nomal case, say N.

I prefer Kconfig symbols to avoid using negatives, as this easily gets
confusing. Why not do it like

config LAZY_FPU_SWITCHING
           bool "Lazy FPU switching"
           depends on FPU
           default y

      Arnd
