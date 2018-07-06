Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707DCC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2870C219AC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2870C219AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeGFHOc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:14:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36991 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbeGFHN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:13:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so13473537wmh.2;
        Fri, 06 Jul 2018 00:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLje2SQgPPENAsBO3k6beiN5uOJk1rWqGZiw0ucQ6Nk=;
        b=ocmnaGAxbB0pQooPhiHpwN7nu6M+wqtJl1Yka+PO6NfC+WGRZMCpU/W9HSIRDIsShs
         T7/3BgWK91zJ+nakrmzcyQZOilHv5pW7FWpIw0Imq11dgOyOT8ar3PAL3LgXX1FBygE8
         Db7kgWWPzQYfz9CQP/lE5WctnKGAkpIbVVy4XX2QIkUp14i5n86T7xF51SyFqPYDtcdj
         EQQxFSsQcQ/8A9CM1UsvG07yw8pXUyJOuEf4TOsowakdfYH1tNn/Cg3/S0naqtUHkdwb
         ZzmbbwjGEvqzxJHl5pmMCgWTT7h14lcI1my5zRvDY8RryJkT3AnIgTPU6tCSeMDwv5GR
         vghA==
X-Gm-Message-State: APt69E1yF9kNGBDv4RjeM6TcdCFLY8P0NsArQ1v1CE726VH2V3ugUIsc
        qt9cZX9r25CxYmeDgoHCRvDNfkwS
X-Google-Smtp-Source: AAOMgpd4QlQ0XHlWnTuS6tQGjVx2PVCo0EY/gzFaE9pmBaJhHa9KoIY0v+kx0HeDegxmI4PaTEL2+g==
X-Received: by 2002:a1c:64d5:: with SMTP id y204-v6mr5617257wmb.14.1530861205283;
        Fri, 06 Jul 2018 00:13:25 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id y13-v6sm7941982wrr.24.2018.07.06.00.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 00:13:24 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id A91AF123C08; Fri,  6 Jul 2018 09:13:23 +0200 (CEST)
Date:   Fri, 6 Jul 2018 09:13:23 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs, elf: Make sure to page align bss in load_elf_library
Message-ID: <20180706071323.GA7959@techadventures.net>
References: <20180705145539.9627-1-osalvador@techadventures.net>
 <CAGXu5jL4O_qwwAHmW1C8q77Jv1fe_1JCq6iFxC73VySBkvHSQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL4O_qwwAHmW1C8q77Jv1fe_1JCq6iFxC73VySBkvHSQw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 08:44:18AM -0700, Kees Cook wrote:
> On Thu, Jul 5, 2018 at 7:55 AM,  <osalvador@techadventures.net> wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> >
> > The current code does not make sure to page align bss before calling
> > vm_brk(), and this can lead to a VM_BUG_ON() in __mm_populate()
> > due to the requested lenght not being correctly aligned.
> >
> > Let us make sure to align it properly.
> >
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Reported-by: syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com
> 
> Wow. CONFIG_USELIB? I'm surprised distros are still using this. 32-bit
> only, and libc5 and earlier only.
> 
> Regardless, this appears to match the current bss alignment logic in
> the main elf loader, so:
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
> > ---
> >  fs/binfmt_elf.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 0ac456b52bdd..816cc921cf36 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1259,9 +1259,8 @@ static int load_elf_library(struct file *file)
> >                 goto out_free_ph;
> >         }
> >
> > -       len = ELF_PAGESTART(eppnt->p_filesz + eppnt->p_vaddr +
> > -                           ELF_MIN_ALIGN - 1);
> > -       bss = eppnt->p_memsz + eppnt->p_vaddr;
> > +       len = ELF_PAGEALIGN(eppnt->p_filesz + eppnt->p_vaddr);
> > +       bss = ELF_PAGEALIGN(eppnt->p_memsz + eppnt->p_vaddr);
> >         if (bss > len) {
> >                 error = vm_brk(len, bss - len);
> >                 if (error)
> > --
> > 2.13.6
> >
CC Andrew

Hi Andrew,

in case this patch gets accepted, does it have to go through your tree?
Or is it for someone else to take it?

Thanks
-- 
Oscar Salvador
SUSE L3
