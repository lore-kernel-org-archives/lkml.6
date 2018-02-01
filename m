Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeBAUzW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:55:22 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33294 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeBAUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:55:15 -0500
X-Google-Smtp-Source: AH8x22720aPtz5srlTmPzqw92EAIgvgsA4crC8gH7G0YUTaEk/BHUNKOpAdKlGZNUk6EnyWNyfGL62jMowIr/HphiCQ=
MIME-Version: 1.0
In-Reply-To: <20180201134026.GK21609@dhcp22.suse.cz>
References: <20180126140415.GD5027@dhcp22.suse.cz> <15da8c87-e6db-13aa-01c8-a913656bfdb6@linux.vnet.ibm.com>
 <6db9b33d-fd46-c529-b357-3397926f0733@linux.vnet.ibm.com> <20180129132235.GE21609@dhcp22.suse.cz>
 <87k1w081e7.fsf@concordia.ellerman.id.au> <20180130094205.GS21609@dhcp22.suse.cz>
 <5eccdc1b-6a10-b48a-c63f-295f69473d97@linux.vnet.ibm.com> <20180131131937.GA6740@dhcp22.suse.cz>
 <bfecda5e-ae8b-df91-0add-df6322b42a70@linux.vnet.ibm.com> <20180201131007.GJ21609@dhcp22.suse.cz>
 <20180201134026.GK21609@dhcp22.suse.cz>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 2 Feb 2018 07:55:14 +1100
X-Google-Sender-Auth: 54RvV7ggHMN3_ezu3wLuPXoZ04U
Message-ID: <CAGXu5j+fo0Z_ax2O10A-3D3puLhnX+o5M4Lp3TBsnE=NtFCjpw@mail.gmail.com>
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
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 12:40 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 01-02-18 14:10:07, Michal Hocko wrote:
> Thanks a lot to Michael Matz for his background. He has pointed me to
> the following two segments from your binary[1]
>   LOAD           0x0000000000000000 0x0000000010000000 0x0000000010000000
>                  0x0000000000013a8c 0x0000000000013a8c  R E    10000
>   LOAD           0x000000000001fd40 0x000000001002fd40 0x000000001002fd40
>                  0x00000000000002c0 0x00000000000005e8  RW     10000
>   LOAD           0x0000000000020328 0x0000000010030328 0x0000000010030328
>                  0x0000000000000384 0x00000000000094a0  RW     10000
>
> That binary has two RW LOAD segments, the first crosses a page border
> into the second
> 0x1002fd40 (LOAD2-vaddr) + 0x5e8 (LOAD2-memlen) == 0x10030328 (LOAD3-vaddr)
>
> He says
> : This is actually an artifact of RELRO machinism.  The first RW mapping
> : will be remapped as RO after relocations are applied (to increase
> : security).
> : Well, to be honest, normal relro binaries also don't have more than
> : two LOAD segments, so whatever RHEL did to their compilation options,
> : it's something in addition to just relro (which can be detected by
> : having a GNU_RELRO program header)
> : But it definitely has something to do with relro, it's just not the
> : whole story yet.
>
> I am still trying to wrap my head around all this, but it smells rather
> dubious to map different segments over the same page. Is this something
> that might happen widely and therefore MAP_FIXED_NOREPLACE is a no-go
> when loading ELF segments? Or is this a special case we can detect?

Eww. FWIW, I would expect that to be rare and detectable.

-Kees

-- 
Kees Cook
Pixel Security
