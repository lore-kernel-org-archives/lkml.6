Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76230C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D102148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="p/fln5yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeL0Eso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 23:48:44 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:64580 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeL0Eso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 23:48:44 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wBR4mB6t004876;
        Thu, 27 Dec 2018 13:48:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wBR4mB6t004876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545886092;
        bh=2cE9y9Hyf9PIoYC3gD5I81/XuHeS09+4ezmhnQ614Cs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p/fln5ytYma/ko6KIebQKjwihSIVA2SQM6VlAEnTd4lgvLD+B2GTxKdAeriHrJsRc
         UhDKumbcZNQ/FEKT0whqB7j7/88hViThHnItLEEEwZAuQSRFbg4jIalszB3HZfMjUy
         L+dWkuLLBQYCjg4gnkkneKdDm2hBHI8DYYltQBWShmsd7V5G2J/z8xRCoYCpLAFWtj
         vKIhn286KwSmpQiCtnSfVZxsuFVUgHY8PyEcq8BtG+M6PG6ScjXsPVBWWm7Uuyohkr
         apF2jh4Tx+rRnf3YK7qIL9LhcPzoky5CgSaT+5ve6DZokOdrWw/Z8TaUw2ZnR+g6Di
         m+eSIZVUyc/Gw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id n13so10717569vsk.4;
        Wed, 26 Dec 2018 20:48:11 -0800 (PST)
X-Gm-Message-State: AJcUukfj2L0mMYj2Y+bHDI27UK24ulZuOzIcso/TG4aJqT/+ZDLOWS2R
        wPrXGxeFTsN1gz+xBM+JzqGJbC5B94bLGsm01f0=
X-Google-Smtp-Source: AFSGD/UTR047vmtoUsZj5NfySpkDktaa6ZsvzmMLFXaV8niECiZPojYEw9q9AtRNz/Uf7cf5vmNRJ4vhAd8Vy48a9lk=
X-Received: by 2002:a67:485:: with SMTP id 127mr9394405vse.54.1545886090893;
 Wed, 26 Dec 2018 20:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org> <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
 <20181010072240.GB103159@gmail.com> <20181010080324.GV29268@gate.crashing.org>
 <20181010081906.GA5533@zn.tnic> <20181010185432.GB29268@gate.crashing.org>
 <20181010191427.GF5533@zn.tnic> <20181013193335.GD31650@zn.tnic> <20181031125526.GA13219@hirez.programming.kicks-ass.net>
In-Reply-To: <20181031125526.GA13219@hirez.programming.kicks-ass.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 27 Dec 2018 13:47:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNASo5jedRxjX5zevLSmZRce3fERcFc=qn_JtJXx1Ss3iJA@mail.gmail.com>
Message-ID: <CAK7LNASo5jedRxjX5zevLSmZRce3fERcFc=qn_JtJXx1Ss3iJA@mail.gmail.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Biener <rguenther@suse.de>,
        Michael Matz <matz@suse.de>, gcc@gcc.gnu.org,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,


On Wed, Oct 31, 2018 at 9:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Oct 13, 2018 at 09:33:35PM +0200, Borislav Petkov wrote:
> > Ok,
> >
> > with Segher's help I've been playing with his patch ontop of bleeding
> > edge gcc 9 and here are my observations. Please double-check me for
> > booboos so that they can be addressed while there's time.
> >
> > So here's what I see ontop of 4.19-rc7:
> >
> > First marked the alternative asm() as inline and undeffed the "inline"
> > keyword. I need to do that because of the funky games we do with
> > "inline" redefinitions in include/linux/compiler_types.h.
> >
> > And Segher hinted at either doing:
> >
> > asm volatile inline(...
> >
> > or
> >
> > asm volatile __inline__(...
> >
> > but both "inline" variants are defined as macros in that file.
> >
> > Which means we either need to #undef inline before using it in asm() or
> > come up with something cleverer.
>
> # git grep -e "\<__inline__\>" | wc -l
> 488
> # git grep -e "\<__inline\>" | wc -l
> 56
> # git grep -e "\<inline\>" | wc -l
> 69598
>
> And we already have scripts/checkpatch.pl:
>
>   # Check for __inline__ and __inline, prefer inline
>
> Which suggests we do:
>
> git grep -l "\<__inline\(\|__\)\>" | while read file
> do
>         sed -i -e 's/\<__inline\(\|__\)\>/inline/g' $file
> done
>
> and get it over with.


Do you have a plan to really do this?

This is a nice cleanup anyway.

I think the last minute of MW is
a good timing for the global replacement like this.




>
> Anyway, with the below patch, I get:
>
>    text    data     bss     dec     hex filename
> 17385183        5064780 1953892 24403855        1745f8f defconfig-build/vmlinux
> 17385678        5064780 1953892 24404350        174617e defconfig-build/vmlinux
>
> Which shows we inline more (look for asm_volatile for the actual
> changes).
>
>
> So yes, this seems like something we could work with.
>
> ---
>  Documentation/trace/tracepoint-analysis.rst        |  2 +-
>  Documentation/translations/ja_JP/SubmittingPatches |  4 +--
>  Documentation/translations/zh_CN/SubmittingPatches |  4 +--
>  arch/alpha/include/asm/atomic.h                    | 12 +++----
>  arch/alpha/include/asm/bitops.h                    |  6 ++--
>  arch/alpha/include/asm/compiler.h                  |  4 +--
>  arch/alpha/include/asm/dma.h                       | 22 ++++++------
>  arch/alpha/include/asm/floppy.h                    |  4 +--
>  arch/alpha/include/asm/irq.h                       |  2 +-
>  arch/alpha/include/asm/local.h                     |  4 +--
>  arch/alpha/include/asm/smp.h                       |  2 +-
>  arch/arm/mach-iop32x/include/mach/uncompress.h     |  2 +-
>  arch/arm/mach-iop33x/include/mach/uncompress.h     |  2 +-
>  arch/arm/mach-ixp4xx/include/mach/uncompress.h     |  2 +-
>  arch/ia64/hp/common/sba_iommu.c                    |  2 +-
>  arch/ia64/hp/sim/simeth.c                          |  2 +-
>  arch/ia64/include/asm/atomic.h                     |  8 ++---
>  arch/ia64/include/asm/bitops.h                     | 34 +++++++++---------
>  arch/ia64/include/asm/delay.h                      | 14 ++++----
>  arch/ia64/include/asm/irq.h                        |  2 +-
>  arch/ia64/include/asm/page.h                       |  2 +-
>  arch/ia64/include/asm/sn/leds.h                    |  2 +-
>  arch/ia64/include/asm/uaccess.h                    |  4 +--
>  arch/ia64/include/uapi/asm/rse.h                   | 12 +++----
>  arch/ia64/include/uapi/asm/swab.h                  |  6 ++--
>  arch/ia64/oprofile/backtrace.c                     |  4 +--
>  arch/m68k/include/asm/blinken.h                    |  2 +-
>  arch/m68k/include/asm/checksum.h                   |  2 +-
>  arch/m68k/include/asm/dma.h                        | 32 ++++++++---------
>  arch/m68k/include/asm/floppy.h                     |  8 ++---
>  arch/m68k/include/asm/nettel.h                     |  8 ++---
>  arch/m68k/mac/iop.c                                | 14 ++++----
>  arch/mips/include/asm/atomic.h                     | 16 ++++-----
>  arch/mips/include/asm/checksum.h                   |  2 +-
>  arch/mips/include/asm/dma.h                        | 20 +++++------
>  arch/mips/include/asm/jazz.h                       |  2 +-
>  arch/mips/include/asm/local.h                      |  4 +--
>  arch/mips/include/asm/string.h                     |  8 ++---
>  arch/mips/kernel/binfmt_elfn32.c                   |  2 +-
>  arch/nds32/include/asm/swab.h                      |  4 +--
>  arch/parisc/include/asm/atomic.h                   | 20 +++++------
>  arch/parisc/include/asm/bitops.h                   | 18 +++++-----
>  arch/parisc/include/asm/checksum.h                 |  4 +--
>  arch/parisc/include/asm/compat.h                   |  2 +-
>  arch/parisc/include/asm/delay.h                    |  2 +-
>  arch/parisc/include/asm/dma.h                      | 20 +++++------
>  arch/parisc/include/asm/ide.h                      |  8 ++---
>  arch/parisc/include/asm/irq.h                      |  2 +-
>  arch/parisc/include/asm/spinlock.h                 | 12 +++----
>  arch/powerpc/include/asm/atomic.h                  | 40 +++++++++++-----------
>  arch/powerpc/include/asm/bitops.h                  | 28 +++++++--------
>  arch/powerpc/include/asm/dma.h                     | 20 +++++------
>  arch/powerpc/include/asm/edac.h                    |  2 +-
>  arch/powerpc/include/asm/irq.h                     |  2 +-
>  arch/powerpc/include/asm/local.h                   | 14 ++++----
>  arch/sh/include/asm/pgtable_64.h                   |  2 +-
>  arch/sh/include/asm/processor_32.h                 |  4 +--
>  arch/sh/include/cpu-sh3/cpu/dac.h                  |  6 ++--
>  arch/x86/include/asm/alternative.h                 | 14 ++++----
>  arch/x86/um/asm/checksum.h                         |  4 +--
>  arch/x86/um/asm/checksum_32.h                      |  4 +--
>  arch/xtensa/include/asm/checksum.h                 | 14 ++++----
>  arch/xtensa/include/asm/cmpxchg.h                  |  4 +--
>  arch/xtensa/include/asm/irq.h                      |  2 +-
>  block/partitions/amiga.c                           |  2 +-
>  drivers/atm/he.c                                   |  6 ++--
>  drivers/atm/idt77252.c                             |  6 ++--
>  drivers/gpu/drm/mga/mga_drv.h                      |  2 +-
>  drivers/gpu/drm/mga/mga_state.c                    | 14 ++++----
>  drivers/gpu/drm/r128/r128_drv.h                    |  2 +-
>  drivers/gpu/drm/r128/r128_state.c                  | 14 ++++----
>  drivers/gpu/drm/via/via_irq.c                      |  2 +-
>  drivers/gpu/drm/via/via_verifier.c                 | 30 ++++++++--------
>  drivers/isdn/hardware/eicon/platform.h             | 14 ++++----
>  drivers/isdn/i4l/isdn_net.c                        | 14 ++++----
>  drivers/isdn/i4l/isdn_net.h                        |  8 ++---
>  drivers/media/pci/ivtv/ivtv-ioctl.c                |  2 +-
>  drivers/net/ethernet/sun/sungem.c                  |  8 ++---
>  drivers/net/ethernet/sun/sunhme.c                  |  6 ++--
>  drivers/net/hamradio/baycom_ser_fdx.c              |  2 +-
>  drivers/net/wan/lapbether.c                        |  2 +-
>  drivers/net/wan/n2.c                               |  4 +--
>  drivers/parisc/led.c                               |  4 +--
>  drivers/parisc/sba_iommu.c                         |  2 +-
>  drivers/parport/parport_gsc.c                      |  2 +-
>  drivers/parport/parport_gsc.h                      |  4 +--
>  drivers/parport/parport_pc.c                       |  2 +-
>  drivers/scsi/lpfc/lpfc_scsi.c                      |  2 +-
>  drivers/scsi/pcmcia/sym53c500_cs.c                 |  4 +--
>  drivers/scsi/qla2xxx/qla_inline.h                  |  2 +-
>  drivers/scsi/qla2xxx/qla_os.c                      |  4 +--
>  drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |  4 +--
>  drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |  2 +-
>  drivers/staging/rtl8723bs/include/drv_types.h      |  6 ++--
>  drivers/staging/rtl8723bs/include/ieee80211.h      |  6 ++--
>  drivers/staging/rtl8723bs/include/osdep_service.h  | 10 +++---
>  .../rtl8723bs/include/osdep_service_linux.h        | 14 ++++----
>  drivers/staging/rtl8723bs/include/rtw_mlme.h       | 14 ++++----
>  drivers/staging/rtl8723bs/include/rtw_recv.h       | 16 ++++-----
>  drivers/staging/rtl8723bs/include/sta_info.h       |  2 +-
>  drivers/staging/rtl8723bs/include/wifi.h           | 14 ++++----
>  drivers/staging/rtl8723bs/include/wlan_bssdef.h    |  2 +-
>  drivers/tty/amiserial.c                            |  2 +-
>  drivers/tty/serial/ip22zilog.c                     |  2 +-
>  drivers/tty/serial/sunsab.c                        |  4 +--
>  drivers/tty/serial/sunzilog.c                      |  2 +-
>  drivers/video/fbdev/core/fbcon.c                   | 20 +++++------
>  drivers/video/fbdev/ffb.c                          |  2 +-
>  drivers/video/fbdev/intelfb/intelfbdrv.c           | 10 +++---
>  drivers/video/fbdev/intelfb/intelfbhw.c            |  2 +-
>  drivers/w1/masters/matrox_w1.c                     |  4 +--
>  fs/coda/coda_linux.h                               |  6 ++--
>  fs/freevxfs/vxfs_inode.c                           |  2 +-
>  fs/nfsd/nfsfh.h                                    |  4 +--
>  include/acpi/platform/acgcc.h                      |  2 +-
>  include/acpi/platform/acintel.h                    |  2 +-
>  include/asm-generic/ide_iops.h                     |  8 ++---
>  include/linux/atalk.h                              |  4 +--
>  include/linux/ceph/messenger.h                     |  2 +-
>  include/linux/compiler_types.h                     |  4 +--
>  include/linux/hdlc.h                               |  4 +--
>  include/linux/inetdevice.h                         |  8 ++---
>  include/linux/parport.h                            |  4 +--
>  include/linux/parport_pc.h                         | 22 ++++++------
>  include/net/ax25.h                                 |  2 +-
>  include/net/checksum.h                             |  2 +-
>  include/net/dn_nsp.h                               | 16 ++++-----
>  include/net/ip.h                                   |  2 +-
>  include/net/ip6_checksum.h                         |  2 +-
>  include/net/ipx.h                                  | 10 +++---
>  include/net/llc_c_ev.h                             |  4 +--
>  include/net/llc_conn.h                             |  4 +--
>  include/net/llc_s_ev.h                             |  2 +-
>  include/net/netrom.h                               |  8 ++---
>  include/net/scm.h                                  | 14 ++++----
>  include/net/udplite.h                              |  2 +-
>  include/net/x25.h                                  |  8 ++---
>  include/net/xfrm.h                                 | 18 +++++-----
>  include/uapi/linux/atm.h                           |  4 +--
>  include/uapi/linux/atmsap.h                        |  2 +-
>  include/uapi/linux/map_to_7segment.h               |  2 +-
>  include/uapi/linux/netfilter_arp/arp_tables.h      |  2 +-
>  include/uapi/linux/netfilter_bridge/ebtables.h     |  2 +-
>  include/uapi/linux/netfilter_ipv4/ip_tables.h      |  2 +-
>  include/uapi/linux/netfilter_ipv6/ip6_tables.h     |  2 +-
>  include/video/newport.h                            | 12 +++----
>  lib/zstd/mem.h                                     |  2 +-
>  net/appletalk/atalk_proc.c                         |  4 +--
>  net/appletalk/ddp.c                                |  2 +-
>  net/core/neighbour.c                               |  2 +-
>  net/core/scm.c                                     |  2 +-
>  net/decnet/dn_nsp_in.c                             |  2 +-
>  net/decnet/dn_nsp_out.c                            |  2 +-
>  net/decnet/dn_route.c                              |  2 +-
>  net/decnet/dn_table.c                              |  4 +--
>  net/ipv4/igmp.c                                    |  2 +-
>  net/ipv6/af_inet6.c                                |  2 +-
>  net/ipv6/icmp.c                                    |  4 +--
>  net/ipv6/udp.c                                     |  4 +--
>  net/lapb/lapb_iface.c                              |  4 +--
>  net/llc/llc_input.c                                |  2 +-
>  scripts/checkpatch.pl                              |  8 ++---
>  scripts/genksyms/keywords.c                        |  4 +--
>  scripts/kernel-doc                                 |  4 +--
>  sound/sparc/amd7930.c                              |  6 ++--
>  165 files changed, 547 insertions(+), 547 deletions(-)


-- 
Best Regards
Masahiro Yamada
