Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D0BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C5220863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYcbtplB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C5220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeK3Tq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:46:29 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43526 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeK3Tq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:46:29 -0500
Received: by mail-io1-f65.google.com with SMTP id g8so3862383iop.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/h8BiSmw8To6VjvcNvZZ2C/1DCYc8B6gk98cB0p8pQA=;
        b=UYcbtplBNk4CiAS5gj/ZNATX0PaUxTu22jnonznqBwprQmY4XUTVV/CYTk+TVsG4IA
         LdWz6TUXvQBF927eh0ZXTr4COGCME5To1kP8ueoz7L1h3cOh/dMzoszif3Al3ZN2zZa5
         VkaSPGO542W9YuFLS5DBiqhdAgCpHNNzMoIHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/h8BiSmw8To6VjvcNvZZ2C/1DCYc8B6gk98cB0p8pQA=;
        b=tAh20SrDhnYNrrsiyIMMddyCyQAbOHU4MDyhT6SJZEofFCkf97RkS8JBaYsxYVMtQn
         uHbkVdlmxrWWApTRizdrCfB1ZAXkPAdzFRnsMWXzmCuLnlkkZ12vybEjfS85vUCLMT0h
         2xLUdY0BvdocFgLV9cwCV0MtLSvN5C/RpbxnVCJYBbthGtolAlWNdkbHxG6u7UmM/pvM
         xidb8MwsxEej6ztgwBjDwRssL2Cimqb5yAzpaX6AKwcCV8ePEXolylffA6AxO+omxXdX
         GpwmlfBMx02UeVpBI9pyuzZMSM2HclVI2+YPWAqs6w0km/pgRvCzx9xAhcVUvmkRZs1/
         d1jA==
X-Gm-Message-State: AA+aEWaSPO4O081I5xskxZaIollwqkZhiu26TTxb9/U6ljSZur9BB8z+
        Wpv79L8naDt1o2aANUceCqQOal8cbAGA7S59/rMxqg==
X-Google-Smtp-Source: AFSGD/VCEqg8FCzrTEIiYgAkGETrnd8Clu8NDo1/nlzGURwgH1lcMHTeIuo2x8dJW6WO/kDx/oOSbVLoKcyuWQ7h9r4=
X-Received: by 2002:a6b:7a46:: with SMTP id k6mr4154483iop.60.1543567075753;
 Fri, 30 Nov 2018 00:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-9-ard.biesheuvel@linaro.org> <20181130081159.GD16084@gmail.com>
In-Reply-To: <20181130081159.GD16084@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 30 Nov 2018 09:37:44 +0100
Message-ID: <CAKv+Gu8VeYbna2ZSo=sVQEahrKnkHE5HySag1kR4nLpNBBuN9A@mail.gmail.com>
Subject: Re: [PATCH 08/11] firmware: efi: add NULL pointer checks in efivars
 api functions
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 09:12, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > From: Arend van Spriel <arend.vanspriel@broadcom.com>
> >
> > Since commit:
> >
> >    ce2e6db554fa ("brcmfmac: Add support for getting nvram contents from
> >                  EFI variables")
>
> This commit ID is not upstream AFAICS. Which tree is it from? Mentioning
> non-upstream sha1's is discouraged in changelogs, as there's no guarantee
> that the sha1 will make it upstream.
>

This is a commit ID from Arend's own tree which is pulled into -next,
so I assumed that he'd only include commit IDs like this if they are
stable.

In any case, the fix itself is rather obvious, so much of the context
provided by the commit log could be summarized as '__efivars may be
NULL so check for that before you dereference it'

> > we have a device driver accessing the efivars API. Several functions in
> > the efivars API assume __efivars is set, i.e., that they will be accessed
> > only after efivars_register() has been called. However, the following NULL
> > pointer access was reported calling efivar_entry_size() from the brcmfmac
> > device driver.
> >
> >   Unable to handle kernel NULL pointer dereference at virtual address 00000008
> >   pgd = 60bfa5f1
> >   [00000008] *pgd=00000000
> >   Internal error: Oops: 5 [#1] SMP ARM
> >   ...
> >   Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> >   Workqueue: events request_firmware_work_func
> >   PC is at efivar_entry_size+0x28/0x90
> >   LR is at brcmf_fw_complete_request+0x3f8/0x8d4 [brcmfmac]
> >   pc : [<c0c40718>]    lr : [<bf2a3ef4>]    psr: a00d0113
> >   sp : ede7fe28  ip : ee983410  fp : c1787f30
> >   r10: 00000000  r9 : 00000000  r8 : bf2b2258
> >   r7 : ee983000  r6 : c1604c48  r5 : ede7fe88  r4 : edf337c0
> >   r3 : 00000000  r2 : 00000000  r1 : ede7fe88  r0 : c17712c8
> >   Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> >   Control: 10c5387d  Table: ad16804a  DAC: 00000051
> >
> > Disassembly showed that the local static variable __efivars is NULL,
> > which is not entirely unexpected given that it is a non-EFI platform.
> > So add a NULL pointer check to efivar_entry_size(), and to related
> > functions while at it. In efivars_register() a couple of sanity checks
> > are added as well.
> >
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Will that new commit be backported? If yes I suppose we could mark this
> fix -stable too? If not then it's fine for a v4.21 merge.
>

That commit is not -stable material at all, as far as I can tell.
