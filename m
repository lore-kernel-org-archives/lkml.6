Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C992521738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeLaMXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 07:23:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41732 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbeLaMXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 07:23:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so29116283qtf.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 04:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+Q1VfDsEMhpgAIiPRmFiPtlULVuqu36McELugsuCY0=;
        b=AFp1FLvnui4ePsKXGMdbPL0s6WWlVHJ04NQgw369xg+G1GAFQjB66NYPBvhGghDbR+
         aNY8ZJxv8ZQMmUy4WMabEX4cbij7G6vgQXgn+LDwuNHMyO2Pk4VoHjlatUWE4iSOHPBn
         24inpn7CnEqD/lX24UmO6WOa9XpVK7xFUdJAHfPrh5RLiJPS5eBmjJ/lkttuKhWdY9kt
         PwN70OAE8uQhIBIvdZtjixPG6YEyaoYROK4Do9ZWmI1GBh4r4c701UsxYEbGuAJ0zhby
         amBzrobbMs1CE5T988snqtCf22mL4TAMfCCbw2afp5YC9XmiMcr363+ORyNND/eN1bdJ
         SrVw==
X-Gm-Message-State: AA+aEWa+4iOKrctPEqNwyhfbE+3wQv7pkGZ3srlI3VCyErM5pv9MGE2O
        Ab4X8SxopMy0GdCXty2K2PubRanRj4Ul/wpDSGk=
X-Google-Smtp-Source: ALg8bN7SbnHMjAYUYwtcYYE2S1x4Ki2e0zodzAAhG/AQLJf6iERpo2wfVTtsYlpaDkjHUa6am1ixrbf5NzmLtw34Vck=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr33774681qtm.96.1546258983914;
 Mon, 31 Dec 2018 04:23:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com>
 <alpine.LNX.2.21.1812301051280.215@nippy.intranet> <alpine.LNX.2.21.1812301430221.215@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812301430221.215@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Dec 2018 13:22:47 +0100
Message-ID: <CAK8P3a28RETYsF4XxXadwYJ1sWFpopgHa3-mn00U7tPzQzRBjQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] Re-use nvram module
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 5:05 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Sun, 30 Dec 2018, I wrote:
>
> >
> > I'm not opposed to exported functions in place of a singleton ops
> > struct. Other things being equal I'm inclined toward the ops struct,
> > perhaps because I like encapsulation or perhaps because I don't like
> > excess generality. (That design decision was made years ago and I don't
> > remember the reasoning.)
>
> The rationale for the ops struct was that it offers introspection.
>
> It turns out that PPC64 device drivers don't care about byte-at-a-time
> accessors and X86 device drivers don't care about checksum validation.
> But that only gets us so far.
>
> We still needed a way to find out whether the arch has provided
> byte-at-a-time accessors (i.e. PPC32 and M68K Mac) or byte range accessors
> (i.e. PPC64 and those platforms with checksummed NVRAM like X86 and M68K
> Atari).
>
> You can't resolve this question at build time for a multi-platform kernel
> binary, so pre-processor tricks don't help.
>
> Device drivers tend to want to access NVRAM one byte at a time. With this
> patch series, those platforms which need checksum validation always set
> byte-at-a-time methods to NULL. (Hence the atari_scsi changes in patch 3.)
>
> The char misc driver is quite different to the usual device drivers,
> because the struct file_operations methods always access a byte range.
>
> The NULL methods in the ops struct allow the nvram.c misc device to avoid
> inefficient byte-at-a-time accessors where possible, just as
> arch/powerpc/kernel/nvram_64.c presently does.


Ok, I see. That sounds absolutely reasonable, so let's stay with
the structure as you proposed.

       Arnd
