Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B9CC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D5F208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D5F208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933389AbeFUNlW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:41:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41683 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932918AbeFUNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:41:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id v12-v6so269018ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/E6pIjXYo0X7FrBgWrDJ1hiO9AfD9QApx8/CmEai3Tk=;
        b=JNyww6y1ewoDCWqprip645Tehv+PDT3qeWwIhOG1HUnxc20zpu+/Px0ydowJbZ09Up
         TYWQzfJO7xtrJB3C0j6DE4wbRajRcI8OAXXM4ouvgDfyxdWqdyisKQ5vjg83qMCYZoJi
         NCYn2a27TR+AK4o84Zqcr+tzkQAWVuNxwaqDVVXTePURfal6WjQ2VQRFF/3LjO/tBx+M
         7DAAlLH7wvSrhO1Nlu/+Nm+Rt35ZLJaj8laTeZyQJvxnq7cDnxfsnX3btfVONnLGoQEw
         9mfTE4clAbJ622eMQIyRqwWu/baULqTH1B9tXLoKWSiDCPPyM8Ebc1qx8dduve1tOZ+Y
         HZPQ==
X-Gm-Message-State: APt69E2b86oAPScyEti5oXkq18k0/SU4A89bTiq1VTAbWFaJPBmIFe3R
        gnl34GYOg6Le/8HZHATCy3YKkArMei7iQUcT+ThV50ZEerU=
X-Google-Smtp-Source: ADUXVKJPiRqLvPQaqZ8wN4r8lcTfEFo2BpeEoM2gEI3kZPlKiy/6hSyXVTusj5NYahXwwtXSK8T0Lwi6R4cE/ttWyYk=
X-Received: by 2002:a2e:4189:: with SMTP id d9-v6mr16626375ljf.36.1529588479489;
 Thu, 21 Jun 2018 06:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180620.213540.214945910722071226.davem@davemloft.net> <20180621084510.GA22870@gmail.com>
In-Reply-To: <20180621084510.GA22870@gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 21 Jun 2018 13:40:43 +0000
Message-ID: <CAGnkfhxGAYZNhJp7eyg+_j3LY31w7muFqerhQp7jGqQ02iFxkg@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     mingo@kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        alexei.starovoitov@gmail.com, sfr@canb.auug.org.au,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 8:46 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * David Miller <davem@davemloft.net> wrote:
>
> > 1) Fix crash on bpf_prog_load() errors, from Daniel Borkmann.
>
> > Daniel Borkmann (4):
> >       Merge branch 'bpf-misc-fixes'
> >       bpf: fix panic in prog load calls cleanup
> >       bpf: reject any prog that failed read-only lock
> >       bpf, xdp, i40e: fix i40e_build_skb skb reserve and truesize
>
> JFYI, I'm still seeing this BPF build error upstream, on a 32-bit allyesconfig I'm
> getting:
>
>   LD      vmlinux.o
>   ld: i386:x86-64 architecture of input file `net/bpfilter/bpfilter_umh.o' is incompatible with i386 output
>   Makefile:1010: recipe for target 'vmlinux' failed
>   make: *** [vmlinux] Error 1
>
> A similar looking build bug was reported by sfr three weeks ago:
>
> > Subject: linux-next: build failure after merge of the net-next tree
> >
> > ...
> >
> > x86_64-linux-ld: unknown architecture of input file `net/bpfilter/bpfilter_umh.o'
> > is incompatible with i386:x86-64 output
> >
> > Caused by commit
> >
> >  d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
> >
> > In my builds, the host is PowerPC 64 LE ...
> >
> > I have reverted that commit along with
> >
> >  61a552eb487f ("bpfilter: fix build dependency")
> >  13405468f49d ("bpfilter: don't pass O_CREAT when opening console for debug")
> >
> > for today.
>
> Is there a fix I could try?
>
> Thanks,
>
>         Ingo

Hi Ingo,

are you compiling a 32 bit kernel on an x86_64 host? I tried to
compile an i386 bit kernel on an i386 host and I have no issue,
running objdump by hand produces correct output:

$ uname -a
Linux debian32 4.16.0-2-686-pae #1 SMP Debian 4.16.16-1 (2018-06-19)
i686 GNU/Linux
$ objdump -f net/bpfilter/bpfilter_umh |awk -F' |,' '/file
format/{print "-O",$NF} /^architecture:/{print "-B",$2}'
-O elf32-i386
-B i386

then I tried to compile an i386 kernel on an x86_64 host and I get the
same error:

$ make -j8 ARCH=i386
...
  LD      vmlinux.o
ld: i386:x86-64 architecture of input file
`net/bpfilter/bpfilter_umh.o' is incompatible with i386 output
make: *** [Makefile:1015: vmlinux] Error 1

the problem seems to be that bpfilter_umh is compiled with host flags,
and so it's a 64 bit binary in my case:

gcc  -static -o net/bpfilter/bpfilter_umh net/bpfilter/main.o
objcopy -I binary `LC_ALL=C objdump -f net/bpfilter/bpfilter_umh |awk
-F' |,' '/file format/{print "-O",$NF} /^architecture:/{print
"-B",$2}'` --rename-section .data=.init.rodata
net/bpfilter/bpfilter_umh net/bpfilter/bpfilter_umh.o
ld -m elf_i386 -r -o vmlinux.o --whole-archive built-in.a
--no-whole-archive --start-group lib/lib.a arch/x86/lib/lib.a
--end-group
ld: i386:x86-64 architecture of input file
`net/bpfilter/bpfilter_umh.o' is incompatible with i386 output

Any idea how to fix it without building it twice, for host and target?
-- 
Matteo Croce
per aspera ad upstream
