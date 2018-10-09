Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BBFC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494542087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494542087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJISpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:45:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:47063 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJISpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:45:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id d8-v6so1079207qtk.13;
        Tue, 09 Oct 2018 04:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPJvOQ+K4pbyPlAR84m0ZeslowgA22uBTgQXusuWas8=;
        b=E7kROk8XlDwUlmq9tKYLdkUlc6NyHP5PANRljUmR3UPIfL3n7s5FweXDL9ZLd7HONL
         zTmiR35Wo69FlgdJodECAydbz1ocmmUoB6WARlI4KGTvd4xzVGClasrBHgGe1dd0Wx/3
         eR8rXHA8NuU+A7ATKVgDY63ltcOqM10BY/yRMifkQa1B4dYlYqr+oK7kM8tOP5KjMbIv
         D4XXfdG9vzKVZo/V4BILMfm0enPgUWVlPszT7isON4vwum0x7UT0y/Q0yIsImAgm/M50
         noj+uJX4klqvr0yKgBO0l4V8+D3Wgf23GfHMfnjKFWxoZ1Yn7KeUbRpJfdKjxG/k68b3
         W+5g==
X-Gm-Message-State: ABuFfojoiTIvBAndus42wW7ffa+Mt6ZMT2NB34qHv9xFYUaAZn+HWsBQ
        cxEoJ2BPqKaJrAaNF+ExWk4KE/xChHF/mxegmeM=
X-Google-Smtp-Source: ACcGV60cYgzx0rbNpBu4fi37E5vKM7pv2/MUo2BFGTVrjG83XUE+YpF46BGO5LP2CAszx3GQvJH4x/R33KhEAmMtAY4=
X-Received: by 2002:aed:366a:: with SMTP id e97-v6mr23266932qtb.75.1539084511502;
 Tue, 09 Oct 2018 04:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-4-git-send-email-firoz.khan@linaro.org> <CALxhOnj4r_MUuAa2zvkvxvhQttEvCZ98n2dA9d6CYyvVf2rB3g@mail.gmail.com>
 <20181008130301.GM32759@asgard.redhat.com> <CAK8P3a0eoCVBVOZs0VwybAnUw0OUoW4Z=NJYi8686EHKj076_Q@mail.gmail.com>
 <CALxhOniJZGNCP+Xw_9EF8hnUEG_AWwrnQ86Gbh7vAW6SrE8ykQ@mail.gmail.com>
 <CAK8P3a0D+GUzza--ETrT1NHGduTfFGVoCcSEn5LxvKTtMYisbA@mail.gmail.com> <CALxhOnhCRWsuz-2G-SovjfqkXpsRdTrG5Atz2X8s+T8u=GbUcA@mail.gmail.com>
In-Reply-To: <CALxhOnhCRWsuz-2G-SovjfqkXpsRdTrG5Atz2X8s+T8u=GbUcA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Oct 2018 13:28:14 +0200
Message-ID: <CAK8P3a343PoH9WNH5ZYkNDTy=-ybGGsmvH9PbaSMmNo0Yob5eA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] parisc: add system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 11:36 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Tue, 9 Oct 2018 at 13:18, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Oct 9, 2018 at 7:35 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > On Mon, 8 Oct 2018 at 19:27, Arnd Bergmann <arnd@arndb.de> wrote:
> Let me bring another example from powerpc:
>
> syscall_32.tbl,
> 136     common  personality                     sys_personality
>          ppc64_personality   ---> 32-bit, compat (this is the current
> model which I implemented)
> syscall_64.tbl
> 136     common  personality                     ppc64_personality
>                                        ---> 64-bit
>
> I was wondering if the above table is right, how to arrange like parisc model?

I think this should simply be

136    32 personality sys_personality      ppc64_personality
136    64 personality ppc64_personality

Keeping the contents exactly the same as you have them
in the separate .tbl files, just merging the two files, and
splitting out the differences as 32/64 ABI.

> FYI, there are some implement missing for SPU in powerpc
>
> For your reference:
> SYSX_SPU(sys_newfstatat,sys_fstatat64,sys_fstatat64)
> SYSX_SPU(ppc64_personality,ppc64_personality,sys_personality)

This is a good question. The only difference between SPU and
native 64-bit is that some syscalls are not part of the SPU table
because those syscalls are impossible to implement on SPU.

Maybe we can solve this by allowing multiple comma-separated
ABIs in the table. On powerpc, 'common' would then mean
'32-bit, 64-bit and spu', while you could have various other
combinations:

/* always:32, 64 and SPU */
1 common exit sys_exit

/* 32-bit only call */
76  32    getrlimit      sys_old_getrlimit     compat_sys_old_getrlimit

/* 64-bit only, no SPU */
363 64 switch_endian  sys_switch_endian

/* 32-bit and 64-bit, no SPU */
198 32,64 pciconfig_read  sys_pciconfig_read

/* different pointers */
136    32 personality sys_personality      ppc64_personality
136    64,spu personality ppc64_personality

Would that work for you?

       Arnd
