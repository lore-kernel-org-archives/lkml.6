Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeBAVGf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:06:35 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:37397 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeBAVG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:06:26 -0500
X-Google-Smtp-Source: AH8x22520z/rXN4rCpOYAayzf6woJaoyQpzqkfwMiDDt4+2vWPyQUsNK5uNtauno1MjAPL64jbcqyQIcv1Z/yPUDPUc=
MIME-Version: 1.0
In-Reply-To: <20180201134829.GL21609@dhcp22.suse.cz>
References: <5acba3c2-754d-e449-24ff-a72a0ad0d895@linux.vnet.ibm.com>
 <20180126140415.GD5027@dhcp22.suse.cz> <15da8c87-e6db-13aa-01c8-a913656bfdb6@linux.vnet.ibm.com>
 <6db9b33d-fd46-c529-b357-3397926f0733@linux.vnet.ibm.com> <20180129132235.GE21609@dhcp22.suse.cz>
 <87k1w081e7.fsf@concordia.ellerman.id.au> <20180130094205.GS21609@dhcp22.suse.cz>
 <5eccdc1b-6a10-b48a-c63f-295f69473d97@linux.vnet.ibm.com> <20180131131937.GA6740@dhcp22.suse.cz>
 <bfecda5e-ae8b-df91-0add-df6322b42a70@linux.vnet.ibm.com> <20180201134829.GL21609@dhcp22.suse.cz>
From: Kees Cook <keescook@google.com>
Date: Fri, 2 Feb 2018 08:06:25 +1100
Message-ID: <CAGXu5jJMQ0HK2NeRw9VmZmOkuaw2g8tAf2yZ-OxfwZBTXxuZMw@mail.gmail.com>
Subject: Re: ppc elf_map breakage with MAP_FIXED_NOREPLACE
To: Michal Hocko <mhocko@kernel.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 12:48 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 01-02-18 08:43:34, Anshuman Khandual wrote:
> [...]
>> $dmesg | grep elf_brk
>> [    9.571192] elf_brk 10030328 elf_bss 10030000
>>
>> static int load_elf_binary(struct linux_binprm *bprm)
>> ---------------------
>>
>>       if (unlikely (elf_brk > elf_bss)) {
>>                       unsigned long nbyte;
>>
>>                       /* There was a PT_LOAD segment with p_memsz > p_filesz
>>                          before this one. Map anonymous pages, if needed,
>>                          and clear the area.  */
>>                       retval = set_brk(elf_bss + load_bias,
>>                                        elf_brk + load_bias,
>>                                        bss_prot);
>>
>>
>> ---------------------
>
> Just a blind shot... Does the following make any difference?
> ---
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 021fe78998ea..04b24d00c911 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -895,7 +895,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>            the correct location in memory. */
>         for(i = 0, elf_ppnt = elf_phdata;
>             i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
> -               int elf_prot = 0, elf_flags;
> +               int elf_prot = 0, elf_flags, elf_fixed = MAP_FIXED_NOREPLACE;
>                 unsigned long k, vaddr;
>                 unsigned long total_size = 0;
>
> @@ -927,6 +927,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>                                          */
>                                 }
>                         }
> +                       elf_fixed = MAP_FIXED;
>                 }
>
>                 if (elf_ppnt->p_flags & PF_R)
> @@ -944,7 +945,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>                  * the ET_DYN load_addr calculations, proceed normally.
>                  */
>                 if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
> -                       elf_flags |= MAP_FIXED_NOREPLACE;
> +                       elf_flags |= elf_fixed;
>                 } else if (loc->elf_ex.e_type == ET_DYN) {
>                         /*
>                          * This logic is run once for the first LOAD Program
> @@ -980,7 +981,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>                                 load_bias = ELF_ET_DYN_BASE;
>                                 if (current->flags & PF_RANDOMIZE)
>                                         load_bias += arch_mmap_rnd();
> -                               elf_flags |= MAP_FIXED_NOREPLACE;
> +                               elf_flags |= elf_fixed;
>                         } else
>                                 load_bias = 0;

If I'm reading this patch correctly, the intention is to allow LOADs
after brk-expansion to collide with the prior LOAD? (This patch will
need more comments for our future sanity.) I think this makes sense,
though it might be nice to be sure we're overlapping only with the
prior LOAD (and nothing else), but it's not clear to me the best way
to accomplish that here. Even without that extra check, I think this
is a net benefit (i.e. gain MAP_FIXED_NOREPLACE without breaking
page-crossing LOADs).

Actually, maybe the second LOAD could be page-aligned first, so it
doesn't collide with the prior LOAD, and it could keep
MAP_FIXED_NOREPLACE? I'll have more time to study this on Monday...

-Kees

-- 
Kees Cook
Pixel Security
