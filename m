Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8C3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E9120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GDJkQVmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E9120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbeJaVyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:54:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbeJaVyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fDsRJqGLuqH39gTLCq3i/5lToL/hjidrWwVUl9Wf9RY=; b=GDJkQVmX2lq+AWOAWMMlIxYoeo
        88wxTGY37mk5DxFnicCa11hKsm7t+ReyZhByHtXBJ0yO07B4WSU/Cde/tcjMpyD3YoLNP0SVZJVNU
        sYFDwljrEGkLDP6kgeJpAKz8wHcMVB71xWOk3Ff8yUHXQFMJk3qf1bru+r+bx7PNZ0XxMZwxBIwk9
        I8jUSMDZQ8y3zkZmsusGGbsbe5Xjq0MoBtodoTKV5RRmtG36icG9K05QDSFeGjlPspiXaAa9HquA/
        7YTg27aZVDX5hTRzrwelHaQRahQf13Y+lF95gzqxaJ2WrkdzTm4BiCuMxKdKLmlfD0xXPTZ++nCSb
        EE4ZLs1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHq1x-0007NE-RJ; Wed, 31 Oct 2018 12:55:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D33D920297604; Wed, 31 Oct 2018 13:55:26 +0100 (CET)
Date:   Wed, 31 Oct 2018 13:55:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Biener <rguenther@suse.de>,
        Michael Matz <matz@suse.de>, gcc@gcc.gnu.org,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
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
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Message-ID: <20181031125526.GA13219@hirez.programming.kicks-ass.net>
References: <20181008073128.GL29268@gate.crashing.org>
 <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org>
 <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
 <20181010072240.GB103159@gmail.com>
 <20181010080324.GV29268@gate.crashing.org>
 <20181010081906.GA5533@zn.tnic>
 <20181010185432.GB29268@gate.crashing.org>
 <20181010191427.GF5533@zn.tnic>
 <20181013193335.GD31650@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181013193335.GD31650@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 09:33:35PM +0200, Borislav Petkov wrote:
> Ok,
> 
> with Segher's help I've been playing with his patch ontop of bleeding
> edge gcc 9 and here are my observations. Please double-check me for
> booboos so that they can be addressed while there's time.
> 
> So here's what I see ontop of 4.19-rc7:
> 
> First marked the alternative asm() as inline and undeffed the "inline"
> keyword. I need to do that because of the funky games we do with
> "inline" redefinitions in include/linux/compiler_types.h.
> 
> And Segher hinted at either doing:
> 
> asm volatile inline(...
> 
> or
> 
> asm volatile __inline__(...
> 
> but both "inline" variants are defined as macros in that file.
> 
> Which means we either need to #undef inline before using it in asm() or
> come up with something cleverer.

# git grep -e "\<__inline__\>" | wc -l
488
# git grep -e "\<__inline\>" | wc -l
56
# git grep -e "\<inline\>" | wc -l
69598

And we already have scripts/checkpatch.pl:

  # Check for __inline__ and __inline, prefer inline

Which suggests we do:

git grep -l "\<__inline\(\|__\)\>" | while read file
do
	sed -i -e 's/\<__inline\(\|__\)\>/inline/g' $file
done

and get it over with.


Anyway, with the below patch, I get:

   text    data     bss     dec     hex filename
17385183        5064780 1953892 24403855        1745f8f defconfig-build/vmlinux
17385678        5064780 1953892 24404350        174617e defconfig-build/vmlinux

Which shows we inline more (look for asm_volatile for the actual
changes).


So yes, this seems like something we could work with.

---
 Documentation/trace/tracepoint-analysis.rst        |  2 +-
 Documentation/translations/ja_JP/SubmittingPatches |  4 +--
 Documentation/translations/zh_CN/SubmittingPatches |  4 +--
 arch/alpha/include/asm/atomic.h                    | 12 +++----
 arch/alpha/include/asm/bitops.h                    |  6 ++--
 arch/alpha/include/asm/compiler.h                  |  4 +--
 arch/alpha/include/asm/dma.h                       | 22 ++++++------
 arch/alpha/include/asm/floppy.h                    |  4 +--
 arch/alpha/include/asm/irq.h                       |  2 +-
 arch/alpha/include/asm/local.h                     |  4 +--
 arch/alpha/include/asm/smp.h                       |  2 +-
 arch/arm/mach-iop32x/include/mach/uncompress.h     |  2 +-
 arch/arm/mach-iop33x/include/mach/uncompress.h     |  2 +-
 arch/arm/mach-ixp4xx/include/mach/uncompress.h     |  2 +-
 arch/ia64/hp/common/sba_iommu.c                    |  2 +-
 arch/ia64/hp/sim/simeth.c                          |  2 +-
 arch/ia64/include/asm/atomic.h                     |  8 ++---
 arch/ia64/include/asm/bitops.h                     | 34 +++++++++---------
 arch/ia64/include/asm/delay.h                      | 14 ++++----
 arch/ia64/include/asm/irq.h                        |  2 +-
 arch/ia64/include/asm/page.h                       |  2 +-
 arch/ia64/include/asm/sn/leds.h                    |  2 +-
 arch/ia64/include/asm/uaccess.h                    |  4 +--
 arch/ia64/include/uapi/asm/rse.h                   | 12 +++----
 arch/ia64/include/uapi/asm/swab.h                  |  6 ++--
 arch/ia64/oprofile/backtrace.c                     |  4 +--
 arch/m68k/include/asm/blinken.h                    |  2 +-
 arch/m68k/include/asm/checksum.h                   |  2 +-
 arch/m68k/include/asm/dma.h                        | 32 ++++++++---------
 arch/m68k/include/asm/floppy.h                     |  8 ++---
 arch/m68k/include/asm/nettel.h                     |  8 ++---
 arch/m68k/mac/iop.c                                | 14 ++++----
 arch/mips/include/asm/atomic.h                     | 16 ++++-----
 arch/mips/include/asm/checksum.h                   |  2 +-
 arch/mips/include/asm/dma.h                        | 20 +++++------
 arch/mips/include/asm/jazz.h                       |  2 +-
 arch/mips/include/asm/local.h                      |  4 +--
 arch/mips/include/asm/string.h                     |  8 ++---
 arch/mips/kernel/binfmt_elfn32.c                   |  2 +-
 arch/nds32/include/asm/swab.h                      |  4 +--
 arch/parisc/include/asm/atomic.h                   | 20 +++++------
 arch/parisc/include/asm/bitops.h                   | 18 +++++-----
 arch/parisc/include/asm/checksum.h                 |  4 +--
 arch/parisc/include/asm/compat.h                   |  2 +-
 arch/parisc/include/asm/delay.h                    |  2 +-
 arch/parisc/include/asm/dma.h                      | 20 +++++------
 arch/parisc/include/asm/ide.h                      |  8 ++---
 arch/parisc/include/asm/irq.h                      |  2 +-
 arch/parisc/include/asm/spinlock.h                 | 12 +++----
 arch/powerpc/include/asm/atomic.h                  | 40 +++++++++++-----------
 arch/powerpc/include/asm/bitops.h                  | 28 +++++++--------
 arch/powerpc/include/asm/dma.h                     | 20 +++++------
 arch/powerpc/include/asm/edac.h                    |  2 +-
 arch/powerpc/include/asm/irq.h                     |  2 +-
 arch/powerpc/include/asm/local.h                   | 14 ++++----
 arch/sh/include/asm/pgtable_64.h                   |  2 +-
 arch/sh/include/asm/processor_32.h                 |  4 +--
 arch/sh/include/cpu-sh3/cpu/dac.h                  |  6 ++--
 arch/x86/include/asm/alternative.h                 | 14 ++++----
 arch/x86/um/asm/checksum.h                         |  4 +--
 arch/x86/um/asm/checksum_32.h                      |  4 +--
 arch/xtensa/include/asm/checksum.h                 | 14 ++++----
 arch/xtensa/include/asm/cmpxchg.h                  |  4 +--
 arch/xtensa/include/asm/irq.h                      |  2 +-
 block/partitions/amiga.c                           |  2 +-
 drivers/atm/he.c                                   |  6 ++--
 drivers/atm/idt77252.c                             |  6 ++--
 drivers/gpu/drm/mga/mga_drv.h                      |  2 +-
 drivers/gpu/drm/mga/mga_state.c                    | 14 ++++----
 drivers/gpu/drm/r128/r128_drv.h                    |  2 +-
 drivers/gpu/drm/r128/r128_state.c                  | 14 ++++----
 drivers/gpu/drm/via/via_irq.c                      |  2 +-
 drivers/gpu/drm/via/via_verifier.c                 | 30 ++++++++--------
 drivers/isdn/hardware/eicon/platform.h             | 14 ++++----
 drivers/isdn/i4l/isdn_net.c                        | 14 ++++----
 drivers/isdn/i4l/isdn_net.h                        |  8 ++---
 drivers/media/pci/ivtv/ivtv-ioctl.c                |  2 +-
 drivers/net/ethernet/sun/sungem.c                  |  8 ++---
 drivers/net/ethernet/sun/sunhme.c                  |  6 ++--
 drivers/net/hamradio/baycom_ser_fdx.c              |  2 +-
 drivers/net/wan/lapbether.c                        |  2 +-
 drivers/net/wan/n2.c                               |  4 +--
 drivers/parisc/led.c                               |  4 +--
 drivers/parisc/sba_iommu.c                         |  2 +-
 drivers/parport/parport_gsc.c                      |  2 +-
 drivers/parport/parport_gsc.h                      |  4 +--
 drivers/parport/parport_pc.c                       |  2 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |  2 +-
 drivers/scsi/pcmcia/sym53c500_cs.c                 |  4 +--
 drivers/scsi/qla2xxx/qla_inline.h                  |  2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  4 +--
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |  4 +--
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |  2 +-
 drivers/staging/rtl8723bs/include/drv_types.h      |  6 ++--
 drivers/staging/rtl8723bs/include/ieee80211.h      |  6 ++--
 drivers/staging/rtl8723bs/include/osdep_service.h  | 10 +++---
 .../rtl8723bs/include/osdep_service_linux.h        | 14 ++++----
 drivers/staging/rtl8723bs/include/rtw_mlme.h       | 14 ++++----
 drivers/staging/rtl8723bs/include/rtw_recv.h       | 16 ++++-----
 drivers/staging/rtl8723bs/include/sta_info.h       |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h           | 14 ++++----
 drivers/staging/rtl8723bs/include/wlan_bssdef.h    |  2 +-
 drivers/tty/amiserial.c                            |  2 +-
 drivers/tty/serial/ip22zilog.c                     |  2 +-
 drivers/tty/serial/sunsab.c                        |  4 +--
 drivers/tty/serial/sunzilog.c                      |  2 +-
 drivers/video/fbdev/core/fbcon.c                   | 20 +++++------
 drivers/video/fbdev/ffb.c                          |  2 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c           | 10 +++---
 drivers/video/fbdev/intelfb/intelfbhw.c            |  2 +-
 drivers/w1/masters/matrox_w1.c                     |  4 +--
 fs/coda/coda_linux.h                               |  6 ++--
 fs/freevxfs/vxfs_inode.c                           |  2 +-
 fs/nfsd/nfsfh.h                                    |  4 +--
 include/acpi/platform/acgcc.h                      |  2 +-
 include/acpi/platform/acintel.h                    |  2 +-
 include/asm-generic/ide_iops.h                     |  8 ++---
 include/linux/atalk.h                              |  4 +--
 include/linux/ceph/messenger.h                     |  2 +-
 include/linux/compiler_types.h                     |  4 +--
 include/linux/hdlc.h                               |  4 +--
 include/linux/inetdevice.h                         |  8 ++---
 include/linux/parport.h                            |  4 +--
 include/linux/parport_pc.h                         | 22 ++++++------
 include/net/ax25.h                                 |  2 +-
 include/net/checksum.h                             |  2 +-
 include/net/dn_nsp.h                               | 16 ++++-----
 include/net/ip.h                                   |  2 +-
 include/net/ip6_checksum.h                         |  2 +-
 include/net/ipx.h                                  | 10 +++---
 include/net/llc_c_ev.h                             |  4 +--
 include/net/llc_conn.h                             |  4 +--
 include/net/llc_s_ev.h                             |  2 +-
 include/net/netrom.h                               |  8 ++---
 include/net/scm.h                                  | 14 ++++----
 include/net/udplite.h                              |  2 +-
 include/net/x25.h                                  |  8 ++---
 include/net/xfrm.h                                 | 18 +++++-----
 include/uapi/linux/atm.h                           |  4 +--
 include/uapi/linux/atmsap.h                        |  2 +-
 include/uapi/linux/map_to_7segment.h               |  2 +-
 include/uapi/linux/netfilter_arp/arp_tables.h      |  2 +-
 include/uapi/linux/netfilter_bridge/ebtables.h     |  2 +-
 include/uapi/linux/netfilter_ipv4/ip_tables.h      |  2 +-
 include/uapi/linux/netfilter_ipv6/ip6_tables.h     |  2 +-
 include/video/newport.h                            | 12 +++----
 lib/zstd/mem.h                                     |  2 +-
 net/appletalk/atalk_proc.c                         |  4 +--
 net/appletalk/ddp.c                                |  2 +-
 net/core/neighbour.c                               |  2 +-
 net/core/scm.c                                     |  2 +-
 net/decnet/dn_nsp_in.c                             |  2 +-
 net/decnet/dn_nsp_out.c                            |  2 +-
 net/decnet/dn_route.c                              |  2 +-
 net/decnet/dn_table.c                              |  4 +--
 net/ipv4/igmp.c                                    |  2 +-
 net/ipv6/af_inet6.c                                |  2 +-
 net/ipv6/icmp.c                                    |  4 +--
 net/ipv6/udp.c                                     |  4 +--
 net/lapb/lapb_iface.c                              |  4 +--
 net/llc/llc_input.c                                |  2 +-
 scripts/checkpatch.pl                              |  8 ++---
 scripts/genksyms/keywords.c                        |  4 +--
 scripts/kernel-doc                                 |  4 +--
 sound/sparc/amd7930.c                              |  6 ++--
 165 files changed, 547 insertions(+), 547 deletions(-)

diff --git a/Documentation/trace/tracepoint-analysis.rst b/Documentation/trace/tracepoint-analysis.rst
index 716326b9f152..edd735a9ba2d 100644
--- a/Documentation/trace/tracepoint-analysis.rst
+++ b/Documentation/trace/tracepoint-analysis.rst
@@ -315,7 +315,7 @@ To see where within the function pixmanFillsse2 things are going wrong:
     0.00 :         34eeb:       0f 18 08                prefetcht0 (%eax)
          :      }
          :
-         :      extern __inline void __attribute__((__gnu_inline__, __always_inline__, _
+         :      extern inline void __attribute__((__gnu_inline__, __always_inline__, _
          :      _mm_store_si128 (__m128i *__P, __m128i __B) :      {
          :        *__P = __B;
    12.40 :         34eee:       66 0f 7f 80 40 ff ff    movdqa %xmm0,-0xc0(%eax)
diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index 02139656463e..188846f1184b 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -676,8 +676,8 @@ gcc においては、マクロと同じくらい軽いです。
 いくつかの特定のケース)や「 static inline 」関数を使うことができないような
 場所(マクロの引数の文字列連結のような)にだけ使われるべきです。
 
-「 static inline 」は「 static __inline__ 」や「 extern inline 」や
-「 extern __inline__ 」よりも適切です。
+「 static inline 」は「 static inline 」や「 extern inline 」や
+「 extern inline 」よりも適切です。
 
 4) 設計に凝りすぎるな
 
diff --git a/Documentation/translations/zh_CN/SubmittingPatches b/Documentation/translations/zh_CN/SubmittingPatches
index e9098da8f1a4..5c39b6c487b5 100644
--- a/Documentation/translations/zh_CN/SubmittingPatches
+++ b/Documentation/translations/zh_CN/SubmittingPatches
@@ -377,8 +377,8 @@ Static inline 函数相比宏来说，是好得多的选择。Static inline 函
 
 宏只在 static inline 函数不是最优的时候[在 fast paths 里有很少的独立的
 案例]，或者不可能用 static inline 函数的时候[例如字符串分配]。
-应该用 'static inline' 而不是 'static __inline__', 'extern inline' 和
-'extern __inline__' 。
+应该用 'static inline' 而不是 'static inline', 'extern inline' 和
+'extern inline' 。
 
 4) 不要过度设计
 
diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 150a1c5d6a2c..f8d494bcd72c 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -40,7 +40,7 @@
  */
 
 #define ATOMIC_OP(op, asm_op)						\
-static __inline__ void atomic_##op(int i, atomic_t * v)			\
+static inline void atomic_##op(int i, atomic_t * v)			\
 {									\
 	unsigned long temp;						\
 	__asm__ __volatile__(						\
@@ -93,7 +93,7 @@ static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
-static __inline__ void atomic64_##op(long i, atomic64_t * v)		\
+static inline void atomic64_##op(long i, atomic64_t * v)		\
 {									\
 	unsigned long temp;						\
 	__asm__ __volatile__(						\
@@ -109,7 +109,7 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, asm_op)					\
-static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v)	\
+static inline long atomic64_##op##_return_relaxed(long i, atomic64_t * v)	\
 {									\
 	long temp, result;						\
 	__asm__ __volatile__(						\
@@ -128,7 +128,7 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v)	\
 }
 
 #define ATOMIC64_FETCH_OP(op, asm_op)					\
-static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)	\
+static inline long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)	\
 {									\
 	long temp, result;						\
 	__asm__ __volatile__(						\
@@ -214,7 +214,7 @@ ATOMIC_OPS(xor, xor)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, new, old;
 	smp_mb();
@@ -246,7 +246,7 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
+static inline long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
 {
 	long c, new, old;
 	smp_mb();
diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index ca43f4d0b937..4d08bd8243c0 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -82,7 +82,7 @@ clear_bit_unlock(unsigned long nr, volatile void * addr)
 /*
  * WARNING: non atomic version.
  */
-static __inline__ void
+static inline void
 __clear_bit(unsigned long nr, volatile void * addr)
 {
 	int *m = ((int *) addr) + (nr >> 5);
@@ -118,7 +118,7 @@ change_bit(unsigned long nr, volatile void * addr)
 /*
  * WARNING: non atomic version.
  */
-static __inline__ void
+static inline void
 __change_bit(unsigned long nr, volatile void * addr)
 {
 	int *m = ((int *) addr) + (nr >> 5);
@@ -272,7 +272,7 @@ test_and_change_bit(unsigned long nr, volatile void * addr)
 /*
  * WARNING: non atomic version.
  */
-static __inline__ int
+static inline int
 __test_and_change_bit(unsigned long nr, volatile void * addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
diff --git a/arch/alpha/include/asm/compiler.h b/arch/alpha/include/asm/compiler.h
index 5159ba259d65..11176dc182f8 100644
--- a/arch/alpha/include/asm/compiler.h
+++ b/arch/alpha/include/asm/compiler.h
@@ -10,8 +10,8 @@
 
 #include <linux/compiler.h>
 #undef inline
-#undef __inline__
-#undef __inline
+#undef inline
+#undef inline
 #undef __always_inline
 #define __always_inline		inline __attribute__((always_inline))
 
diff --git a/arch/alpha/include/asm/dma.h b/arch/alpha/include/asm/dma.h
index 28610ea7786d..73bf4154b6a5 100644
--- a/arch/alpha/include/asm/dma.h
+++ b/arch/alpha/include/asm/dma.h
@@ -198,20 +198,20 @@
 
 extern spinlock_t  dma_spin_lock;
 
-static __inline__ unsigned long claim_dma_lock(void)
+static inline unsigned long claim_dma_lock(void)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&dma_spin_lock, flags);
 	return flags;
 }
 
-static __inline__ void release_dma_lock(unsigned long flags)
+static inline void release_dma_lock(unsigned long flags)
 {
 	spin_unlock_irqrestore(&dma_spin_lock, flags);
 }
 
 /* enable/disable a specific DMA channel */
-static __inline__ void enable_dma(unsigned int dmanr)
+static inline void enable_dma(unsigned int dmanr)
 {
 	if (dmanr<=3)
 		dma_outb(dmanr,  DMA1_MASK_REG);
@@ -219,7 +219,7 @@ static __inline__ void enable_dma(unsigned int dmanr)
 		dma_outb(dmanr & 3,  DMA2_MASK_REG);
 }
 
-static __inline__ void disable_dma(unsigned int dmanr)
+static inline void disable_dma(unsigned int dmanr)
 {
 	if (dmanr<=3)
 		dma_outb(dmanr | 4,  DMA1_MASK_REG);
@@ -234,7 +234,7 @@ static __inline__ void disable_dma(unsigned int dmanr)
  * --- In order to do that, the DMA routines below should ---
  * --- only be used while interrupts are disabled! ---
  */
-static __inline__ void clear_dma_ff(unsigned int dmanr)
+static inline void clear_dma_ff(unsigned int dmanr)
 {
 	if (dmanr<=3)
 		dma_outb(0,  DMA1_CLEAR_FF_REG);
@@ -243,7 +243,7 @@ static __inline__ void clear_dma_ff(unsigned int dmanr)
 }
 
 /* set mode (above) for a specific DMA channel */
-static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
+static inline void set_dma_mode(unsigned int dmanr, char mode)
 {
 	if (dmanr<=3)
 		dma_outb(mode | dmanr,  DMA1_MODE_REG);
@@ -252,7 +252,7 @@ static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
 }
 
 /* set extended mode for a specific DMA channel */
-static __inline__ void set_dma_ext_mode(unsigned int dmanr, char ext_mode)
+static inline void set_dma_ext_mode(unsigned int dmanr, char ext_mode)
 {
 	if (dmanr<=3)
 		dma_outb(ext_mode | dmanr,  DMA1_EXT_MODE_REG);
@@ -264,7 +264,7 @@ static __inline__ void set_dma_ext_mode(unsigned int dmanr, char ext_mode)
  * This is used for successive transfers when we know the contents of
  * the lower 16 bits of the DMA current address register.
  */
-static __inline__ void set_dma_page(unsigned int dmanr, unsigned int pagenr)
+static inline void set_dma_page(unsigned int dmanr, unsigned int pagenr)
 {
 	switch(dmanr) {
 		case 0:
@@ -302,7 +302,7 @@ static __inline__ void set_dma_page(unsigned int dmanr, unsigned int pagenr)
 /* Set transfer address & page bits for specific DMA channel.
  * Assumes dma flipflop is clear.
  */
-static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
+static inline void set_dma_addr(unsigned int dmanr, unsigned int a)
 {
 	if (dmanr <= 3)  {
 	    dma_outb( a & 0xff, ((dmanr&3)<<1) + IO_DMA1_BASE );
@@ -323,7 +323,7 @@ static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
  * Assumes dma flip-flop is clear.
  * NOTE 2: "count" represents _bytes_ and must be even for channels 5-7.
  */
-static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
+static inline void set_dma_count(unsigned int dmanr, unsigned int count)
 {
         count--;
 	if (dmanr <= 3)  {
@@ -344,7 +344,7 @@ static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
  *
  * Assumes DMA flip-flop is clear.
  */
-static __inline__ int get_dma_residue(unsigned int dmanr)
+static inline int get_dma_residue(unsigned int dmanr)
 {
 	unsigned int io_port = (dmanr<=3)? ((dmanr&3)<<1) + 1 + IO_DMA1_BASE
 					 : ((dmanr&3)<<2) + 2 + IO_DMA2_BASE;
diff --git a/arch/alpha/include/asm/floppy.h b/arch/alpha/include/asm/floppy.h
index 942924756cf2..37947c2a8336 100644
--- a/arch/alpha/include/asm/floppy.h
+++ b/arch/alpha/include/asm/floppy.h
@@ -34,7 +34,7 @@
 
 #define fd_dma_setup(addr,size,mode,io) alpha_fd_dma_setup(addr,size,mode,io)
 
-static __inline__ int 
+static inline int 
 alpha_fd_dma_setup(char *addr, unsigned long size, int mode, int io)
 {
 	static unsigned long prev_size;
@@ -72,7 +72,7 @@ alpha_fd_dma_setup(char *addr, unsigned long size, int mode, int io)
 
 #endif /* CONFIG_PCI */
 
-__inline__ void virtual_dma_init(void)
+inline void virtual_dma_init(void)
 {
 	/* Nothing to do on an Alpha */
 }
diff --git a/arch/alpha/include/asm/irq.h b/arch/alpha/include/asm/irq.h
index 4d17cacd1462..bfad8598e972 100644
--- a/arch/alpha/include/asm/irq.h
+++ b/arch/alpha/include/asm/irq.h
@@ -77,7 +77,7 @@
 # define NR_IRQS	16
 #endif
 
-static __inline__ int irq_canonicalize(int irq)
+static inline int irq_canonicalize(int irq)
 {
 	/*
 	 * XXX is this true for all Alpha's?  The old serial driver
diff --git a/arch/alpha/include/asm/local.h b/arch/alpha/include/asm/local.h
index fab26a1c93d5..b13615ee5431 100644
--- a/arch/alpha/include/asm/local.h
+++ b/arch/alpha/include/asm/local.h
@@ -18,7 +18,7 @@ typedef struct
 #define local_add(i,l)	atomic_long_add((i),(&(l)->a))
 #define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
 
-static __inline__ long local_add_return(long i, local_t * l)
+static inline long local_add_return(long i, local_t * l)
 {
 	long temp, result;
 	__asm__ __volatile__(
@@ -35,7 +35,7 @@ static __inline__ long local_add_return(long i, local_t * l)
 	return result;
 }
 
-static __inline__ long local_sub_return(long i, local_t * l)
+static inline long local_sub_return(long i, local_t * l)
 {
 	long temp, result;
 	__asm__ __volatile__(
diff --git a/arch/alpha/include/asm/smp.h b/arch/alpha/include/asm/smp.h
index 2264ae72673b..f5e49acf60a4 100644
--- a/arch/alpha/include/asm/smp.h
+++ b/arch/alpha/include/asm/smp.h
@@ -9,7 +9,7 @@
 
 /* HACK: Cabrio WHAMI return value is bogus if more than 8 bits used.. :-( */
 
-static __inline__ unsigned char
+static inline unsigned char
 __hard_smp_processor_id(void)
 {
 	register unsigned char __r0 __asm__("$0");
diff --git a/arch/arm/mach-iop32x/include/mach/uncompress.h b/arch/arm/mach-iop32x/include/mach/uncompress.h
index ed4ac3e28fa1..24d1dd4ea27f 100644
--- a/arch/arm/mach-iop32x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop32x/include/mach/uncompress.h
@@ -23,7 +23,7 @@ static inline void flush(void)
 {
 }
 
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
+static inline void __arch_decomp_setup(unsigned long arch_id)
 {
 	if (machine_is_iq80321())
 		uart_base = (volatile u8 *)IQ80321_UART;
diff --git a/arch/arm/mach-iop33x/include/mach/uncompress.h b/arch/arm/mach-iop33x/include/mach/uncompress.h
index 62b71cde1f79..9fc5a2aae8de 100644
--- a/arch/arm/mach-iop33x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop33x/include/mach/uncompress.h
@@ -23,7 +23,7 @@ static inline void flush(void)
 {
 }
 
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
+static inline void __arch_decomp_setup(unsigned long arch_id)
 {
 	if (machine_is_iq80331() || machine_is_iq80332())
 		uart_base = (volatile u32 *)IOP33X_UART0_PHYS;
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index 7b25c0225e46..d9e698f7d7e1 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -35,7 +35,7 @@ static void flush(void)
 {
 }
 
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
+static inline void __arch_decomp_setup(unsigned long arch_id)
 {
 	/*
 	 * Some boards are using UART2 as console
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 671ce1e3f6f2..d597f810bb84 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -107,7 +107,7 @@ extern int swiotlb_late_init_with_default_size (size_t size);
 #error FULL_VALID_PDIR and ASSERT_PDIR_SANITY are mutually exclusive
 #endif
 
-#define SBA_INLINE	__inline__
+#define SBA_INLINE	inline
 /* #define SBA_INLINE */
 
 #ifdef DEBUG_SBA_INIT
diff --git a/arch/ia64/hp/sim/simeth.c b/arch/ia64/hp/sim/simeth.c
index f39ef2b4ed72..e0620283dfc6 100644
--- a/arch/ia64/hp/sim/simeth.c
+++ b/arch/ia64/hp/sim/simeth.c
@@ -246,7 +246,7 @@ simeth_open(struct net_device *dev)
 }
 
 /* copied from lapbether.c */
-static __inline__ int dev_is_ethdev(struct net_device *dev)
+static inline int dev_is_ethdev(struct net_device *dev)
 {
        return ( dev->type == ARPHRD_ETHER && strncmp(dev->name, "dummy", 5));
 }
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index 206530d0751b..9408fa96e2dd 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -29,7 +29,7 @@
 #define atomic64_set(v,i)	WRITE_ONCE(((v)->counter), (i))
 
 #define ATOMIC_OP(op, c_op)						\
-static __inline__ int							\
+static inline int							\
 ia64_atomic_##op (int i, atomic_t *v)					\
 {									\
 	__s32 old, new;							\
@@ -44,7 +44,7 @@ ia64_atomic_##op (int i, atomic_t *v)					\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-static __inline__ int							\
+static inline int							\
 ia64_atomic_fetch_##op (int i, atomic_t *v)				\
 {									\
 	__s32 old, new;							\
@@ -124,7 +124,7 @@ ATOMIC_FETCH_OP(xor, ^)
 #undef ATOMIC_OP
 
 #define ATOMIC64_OP(op, c_op)						\
-static __inline__ long							\
+static inline long							\
 ia64_atomic64_##op (__s64 i, atomic64_t *v)				\
 {									\
 	__s64 old, new;							\
@@ -139,7 +139,7 @@ ia64_atomic64_##op (__s64 i, atomic64_t *v)				\
 }
 
 #define ATOMIC64_FETCH_OP(op, c_op)					\
-static __inline__ long							\
+static inline long							\
 ia64_atomic64_fetch_##op (__s64 i, atomic64_t *v)			\
 {									\
 	__s64 old, new;							\
diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
index 56a774bf13fa..d3249d081ab6 100644
--- a/arch/ia64/include/asm/bitops.h
+++ b/arch/ia64/include/asm/bitops.h
@@ -36,7 +36,7 @@
  *
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
-static __inline__ void
+static inline void
 set_bit (int nr, volatile void *addr)
 {
 	__u32 bit, old, new;
@@ -61,7 +61,7 @@ set_bit (int nr, volatile void *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __inline__ void
+static inline void
 __set_bit (int nr, volatile void *addr)
 {
 	*((__u32 *) addr + (nr >> 5)) |= (1 << (nr & 31));
@@ -77,7 +77,7 @@ __set_bit (int nr, volatile void *addr)
  * you should call smp_mb__before_atomic() and/or smp_mb__after_atomic()
  * in order to ensure changes are visible on other processors.
  */
-static __inline__ void
+static inline void
 clear_bit (int nr, volatile void *addr)
 {
 	__u32 mask, old, new;
@@ -101,7 +101,7 @@ clear_bit (int nr, volatile void *addr)
  * clear_bit_unlock() is atomic and may not be reordered.  It does
  * contain a memory barrier suitable for unlock type operations.
  */
-static __inline__ void
+static inline void
 clear_bit_unlock (int nr, volatile void *addr)
 {
 	__u32 mask, old, new;
@@ -125,7 +125,7 @@ clear_bit_unlock (int nr, volatile void *addr)
  * Similarly to clear_bit_unlock, the implementation uses a store
  * with release semantics. See also arch_spin_unlock().
  */
-static __inline__ void
+static inline void
 __clear_bit_unlock(int nr, void *addr)
 {
 	__u32 * const m = (__u32 *) addr + (nr >> 5);
@@ -143,7 +143,7 @@ __clear_bit_unlock(int nr, void *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __inline__ void
+static inline void
 __clear_bit (int nr, volatile void *addr)
 {
 	*((__u32 *) addr + (nr >> 5)) &= ~(1 << (nr & 31));
@@ -158,7 +158,7 @@ __clear_bit (int nr, volatile void *addr)
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static __inline__ void
+static inline void
 change_bit (int nr, volatile void *addr)
 {
 	__u32 bit, old, new;
@@ -183,7 +183,7 @@ change_bit (int nr, volatile void *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __inline__ void
+static inline void
 __change_bit (int nr, volatile void *addr)
 {
 	*((__u32 *) addr + (nr >> 5)) ^= (1 << (nr & 31));
@@ -197,7 +197,7 @@ __change_bit (int nr, volatile void *addr)
  * This operation is atomic and cannot be reordered.  
  * It also implies the acquisition side of the memory barrier.
  */
-static __inline__ int
+static inline int
 test_and_set_bit (int nr, volatile void *addr)
 {
 	__u32 bit, old, new;
@@ -232,7 +232,7 @@ test_and_set_bit (int nr, volatile void *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static __inline__ int
+static inline int
 __test_and_set_bit (int nr, volatile void *addr)
 {
 	__u32 *p = (__u32 *) addr + (nr >> 5);
@@ -251,7 +251,7 @@ __test_and_set_bit (int nr, volatile void *addr)
  * This operation is atomic and cannot be reordered.  
  * It also implies the acquisition side of the memory barrier.
  */
-static __inline__ int
+static inline int
 test_and_clear_bit (int nr, volatile void *addr)
 {
 	__u32 mask, old, new;
@@ -277,7 +277,7 @@ test_and_clear_bit (int nr, volatile void *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static __inline__ int
+static inline int
 __test_and_clear_bit(int nr, volatile void * addr)
 {
 	__u32 *p = (__u32 *) addr + (nr >> 5);
@@ -296,7 +296,7 @@ __test_and_clear_bit(int nr, volatile void * addr)
  * This operation is atomic and cannot be reordered.  
  * It also implies the acquisition side of the memory barrier.
  */
-static __inline__ int
+static inline int
 test_and_change_bit (int nr, volatile void *addr)
 {
 	__u32 bit, old, new;
@@ -320,7 +320,7 @@ test_and_change_bit (int nr, volatile void *addr)
  *
  * This operation is non-atomic and can be reordered.
  */
-static __inline__ int
+static inline int
 __test_and_change_bit (int nr, void *addr)
 {
 	__u32 old, bit = (1 << (nr & 31));
@@ -331,7 +331,7 @@ __test_and_change_bit (int nr, void *addr)
 	return (old & bit) != 0;
 }
 
-static __inline__ int
+static inline int
 test_bit (int nr, const volatile void *addr)
 {
 	return 1 & (((const volatile __u32 *) addr)[nr >> 5] >> (nr & 31));
@@ -359,7 +359,7 @@ ffz (unsigned long x)
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static __inline__ unsigned long
+static inline unsigned long
 __ffs (unsigned long x)
 {
 	unsigned long result;
@@ -427,7 +427,7 @@ __fls (unsigned long x)
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
  */
-static __inline__ unsigned long __arch_hweight64(unsigned long x)
+static inline unsigned long __arch_hweight64(unsigned long x)
 {
 	unsigned long result;
 	result = ia64_popcnt(x);
diff --git a/arch/ia64/include/asm/delay.h b/arch/ia64/include/asm/delay.h
index 0227ac586107..9f7e60496feb 100644
--- a/arch/ia64/include/asm/delay.h
+++ b/arch/ia64/include/asm/delay.h
@@ -20,14 +20,14 @@
 #include <asm/intrinsics.h>
 #include <asm/processor.h>
 
-static __inline__ void
+static inline void
 ia64_set_itm (unsigned long val)
 {
 	ia64_setreg(_IA64_REG_CR_ITM, val);
 	ia64_srlz_d();
 }
 
-static __inline__ unsigned long
+static inline unsigned long
 ia64_get_itm (void)
 {
 	unsigned long result;
@@ -37,27 +37,27 @@ ia64_get_itm (void)
 	return result;
 }
 
-static __inline__ void
+static inline void
 ia64_set_itv (unsigned long val)
 {
 	ia64_setreg(_IA64_REG_CR_ITV, val);
 	ia64_srlz_d();
 }
 
-static __inline__ unsigned long
+static inline unsigned long
 ia64_get_itv (void)
 {
 	return ia64_getreg(_IA64_REG_CR_ITV);
 }
 
-static __inline__ void
+static inline void
 ia64_set_itc (unsigned long val)
 {
 	ia64_setreg(_IA64_REG_AR_ITC, val);
 	ia64_srlz_d();
 }
 
-static __inline__ unsigned long
+static inline unsigned long
 ia64_get_itc (void)
 {
 	unsigned long result;
@@ -75,7 +75,7 @@ ia64_get_itc (void)
 
 extern void ia64_delay_loop (unsigned long loops);
 
-static __inline__ void
+static inline void
 __delay (unsigned long loops)
 {
 	if (unlikely(loops < 1))
diff --git a/arch/ia64/include/asm/irq.h b/arch/ia64/include/asm/irq.h
index 8b84a55ed38a..eab8defa30de 100644
--- a/arch/ia64/include/asm/irq.h
+++ b/arch/ia64/include/asm/irq.h
@@ -16,7 +16,7 @@
 #include <linux/cpumask.h>
 #include <generated/nr-irqs.h>
 
-static __inline__ int
+static inline int
 irq_canonicalize (int irq)
 {
 	/*
diff --git a/arch/ia64/include/asm/page.h b/arch/ia64/include/asm/page.h
index 5798bd2b462c..858317be10cb 100644
--- a/arch/ia64/include/asm/page.h
+++ b/arch/ia64/include/asm/page.h
@@ -154,7 +154,7 @@ typedef union ia64_va {
 extern unsigned int hpage_shift;
 #endif
 
-static __inline__ int
+static inline int
 get_order (unsigned long size)
 {
 	long double d = size - 1;
diff --git a/arch/ia64/include/asm/sn/leds.h b/arch/ia64/include/asm/sn/leds.h
index 66cf8c4d92c9..48aabe95523f 100644
--- a/arch/ia64/include/asm/sn/leds.h
+++ b/arch/ia64/include/asm/sn/leds.h
@@ -22,7 +22,7 @@
  * Basic macros for flashing the LEDS on an SGI SN.
  */
 
-static __inline__ void
+static inline void
 set_led_bits(u8 value, u8 mask)
 {
 	pda->led_state = (pda->led_state & ~mask) | (value & mask);
diff --git a/arch/ia64/include/asm/uaccess.h b/arch/ia64/include/asm/uaccess.h
index a74524f2d625..386bfe1550c0 100644
--- a/arch/ia64/include/asm/uaccess.h
+++ b/arch/ia64/include/asm/uaccess.h
@@ -259,7 +259,7 @@ extern unsigned long __strnlen_user (const char __user *, long);
 })
 
 #define ARCH_HAS_TRANSLATE_MEM_PTR	1
-static __inline__ void *
+static inline void *
 xlate_dev_mem_ptr(phys_addr_t p)
 {
 	struct page *page;
@@ -277,7 +277,7 @@ xlate_dev_mem_ptr(phys_addr_t p)
 /*
  * Convert a virtual cached kernel memory pointer to an uncached pointer
  */
-static __inline__ void *
+static inline void *
 xlate_dev_kmem_ptr(void *p)
 {
 	struct page *page;
diff --git a/arch/ia64/include/uapi/asm/rse.h b/arch/ia64/include/uapi/asm/rse.h
index 6d260af571c5..55e66cae10e1 100644
--- a/arch/ia64/include/uapi/asm/rse.h
+++ b/arch/ia64/include/uapi/asm/rse.h
@@ -8,11 +8,11 @@
  *
  * Register stack engine related helper functions.  This file may be
  * used in applications, so be careful about the name-space and give
- * some consideration to non-GNU C compilers (though __inline__ is
+ * some consideration to non-GNU C compilers (though inline is
  * fine).
  */
 
-static __inline__ unsigned long
+static inline unsigned long
 ia64_rse_slot_num (unsigned long *addr)
 {
 	return (((unsigned long) addr) >> 3) & 0x3f;
@@ -21,7 +21,7 @@ ia64_rse_slot_num (unsigned long *addr)
 /*
  * Return TRUE if ADDR is the address of an RNAT slot.
  */
-static __inline__ unsigned long
+static inline unsigned long
 ia64_rse_is_rnat_slot (unsigned long *addr)
 {
 	return ia64_rse_slot_num(addr) == 0x3f;
@@ -31,7 +31,7 @@ ia64_rse_is_rnat_slot (unsigned long *addr)
  * Returns the address of the RNAT slot that covers the slot at
  * address SLOT_ADDR.
  */
-static __inline__ unsigned long *
+static inline unsigned long *
 ia64_rse_rnat_addr (unsigned long *slot_addr)
 {
 	return (unsigned long *) ((unsigned long) slot_addr | (0x3f << 3));
@@ -42,7 +42,7 @@ ia64_rse_rnat_addr (unsigned long *slot_addr)
  * ending at BSP.  This isn't simply (BSP-BSPSTORE)/8 because every 64th slot stores
  * ar.rnat.
  */
-static __inline__ unsigned long
+static inline unsigned long
 ia64_rse_num_regs (unsigned long *bspstore, unsigned long *bsp)
 {
 	unsigned long slots = (bsp - bspstore);
@@ -54,7 +54,7 @@ ia64_rse_num_regs (unsigned long *bspstore, unsigned long *bsp)
  * The inverse of the above: given bspstore and the number of
  * registers, calculate ar.bsp.
  */
-static __inline__ unsigned long *
+static inline unsigned long *
 ia64_rse_skip_regs (unsigned long *addr, long num_regs)
 {
 	long delta = ia64_rse_slot_num(addr) + num_regs;
diff --git a/arch/ia64/include/uapi/asm/swab.h b/arch/ia64/include/uapi/asm/swab.h
index 79f3fef1a05e..5b5df7a05f7e 100644
--- a/arch/ia64/include/uapi/asm/swab.h
+++ b/arch/ia64/include/uapi/asm/swab.h
@@ -11,7 +11,7 @@
 #include <asm/intrinsics.h>
 #include <linux/compiler.h>
 
-static __inline__ __attribute_const__ __u64 __arch_swab64(__u64 x)
+static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 {
 	__u64 result;
 
@@ -20,13 +20,13 @@ static __inline__ __attribute_const__ __u64 __arch_swab64(__u64 x)
 }
 #define __arch_swab64 __arch_swab64
 
-static __inline__ __attribute_const__ __u32 __arch_swab32(__u32 x)
+static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
 	return __arch_swab64(x) >> 32;
 }
 #define __arch_swab32 __arch_swab32
 
-static __inline__ __attribute_const__ __u16 __arch_swab16(__u16 x)
+static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
 {
 	return __arch_swab64(x) >> 48;
 }
diff --git a/arch/ia64/oprofile/backtrace.c b/arch/ia64/oprofile/backtrace.c
index 6a219a946050..c9c8282f7a73 100644
--- a/arch/ia64/oprofile/backtrace.c
+++ b/arch/ia64/oprofile/backtrace.c
@@ -32,7 +32,7 @@ typedef struct
 } ia64_backtrace_t;
 
 /* Returns non-zero if the PC is in the Interrupt Vector Table */
-static __inline__ int in_ivt_code(unsigned long pc)
+static inline int in_ivt_code(unsigned long pc)
 {
 	extern char ia64_ivt[];
 	return (pc >= (u_long)ia64_ivt && pc < (u_long)ia64_ivt+32768);
@@ -41,7 +41,7 @@ static __inline__ int in_ivt_code(unsigned long pc)
 /*
  * Unwind to next stack frame.
  */
-static __inline__ int next_frame(ia64_backtrace_t *bt)
+static inline int next_frame(ia64_backtrace_t *bt)
 {
 	/*
 	 * Avoid unsightly console message from unw_unwind() when attempting
diff --git a/arch/m68k/include/asm/blinken.h b/arch/m68k/include/asm/blinken.h
index 0626582a7db4..2e5e74d74f82 100644
--- a/arch/m68k/include/asm/blinken.h
+++ b/arch/m68k/include/asm/blinken.h
@@ -19,7 +19,7 @@
 
 extern unsigned char hp300_ledstate;
 
-static __inline__ void blinken_leds(int on, int off)
+static inline void blinken_leds(int on, int off)
 {
 	if (MACH_IS_HP300)
 	{
diff --git a/arch/m68k/include/asm/checksum.h b/arch/m68k/include/asm/checksum.h
index f9b94e4b94f9..3724307be4a1 100644
--- a/arch/m68k/include/asm/checksum.h
+++ b/arch/m68k/include/asm/checksum.h
@@ -116,7 +116,7 @@ static inline __sum16 ip_compute_csum(const void *buff, int len)
 }
 
 #define _HAVE_ARCH_IPV6_CSUM
-static __inline__ __sum16
+static inline __sum16
 csum_ipv6_magic(const struct in6_addr *saddr, const struct in6_addr *daddr,
 		__u32 len, __u8 proto, __wsum sum)
 {
diff --git a/arch/m68k/include/asm/dma.h b/arch/m68k/include/asm/dma.h
index ae2021964e32..a451778fe112 100644
--- a/arch/m68k/include/asm/dma.h
+++ b/arch/m68k/include/asm/dma.h
@@ -123,7 +123,7 @@ extern unsigned int dma_device_address[MAX_M68K_DMA_CHANNELS];
 
 #if !defined(CONFIG_M5272)
 /* enable/disable a specific DMA channel */
-static __inline__ void enable_dma(unsigned int dmanr)
+static inline void enable_dma(unsigned int dmanr)
 {
   volatile unsigned short *dmawp;
 
@@ -135,7 +135,7 @@ static __inline__ void enable_dma(unsigned int dmanr)
   dmawp[MCFDMA_DCR] |= MCFDMA_DCR_EEXT;
 }
 
-static __inline__ void disable_dma(unsigned int dmanr)
+static inline void disable_dma(unsigned int dmanr)
 {
   volatile unsigned short *dmawp;
   volatile unsigned char  *dmapb;
@@ -162,12 +162,12 @@ static __inline__ void disable_dma(unsigned int dmanr)
  *
  * This is a NOP for ColdFire. Provide a stub for compatibility.
  */
-static __inline__ void clear_dma_ff(unsigned int dmanr)
+static inline void clear_dma_ff(unsigned int dmanr)
 {
 }
 
 /* set mode (above) for a specific DMA channel */
-static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
+static inline void set_dma_mode(unsigned int dmanr, char mode)
 {
 
   volatile unsigned char  *dmabp;
@@ -210,7 +210,7 @@ static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
 }
 
 /* Set transfer address for specific DMA channel */
-static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
+static inline void set_dma_addr(unsigned int dmanr, unsigned int a)
 {
   volatile unsigned short *dmawp;
   volatile unsigned int   *dmalp;
@@ -247,7 +247,7 @@ static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
  * Specific for Coldfire - sets device address.
  * Should be called after the mode set call, and before set DMA address.
  */
-static __inline__ void set_dma_device_addr(unsigned int dmanr, unsigned int a)
+static inline void set_dma_device_addr(unsigned int dmanr, unsigned int a)
 {
 #ifdef DMA_DEBUG
   printk("set_dma_device_addr(dmanr=%d,a=%x)\n", dmanr, a);
@@ -259,7 +259,7 @@ static __inline__ void set_dma_device_addr(unsigned int dmanr, unsigned int a)
 /*
  * NOTE 2: "count" represents _bytes_.
  */
-static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
+static inline void set_dma_count(unsigned int dmanr, unsigned int count)
 {
   volatile unsigned short *dmawp;
 
@@ -277,7 +277,7 @@ static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
  * still in progress will return unpredictable results.
  * Otherwise, it returns the number of _bytes_ left to transfer.
  */
-static __inline__ int get_dma_residue(unsigned int dmanr)
+static inline int get_dma_residue(unsigned int dmanr)
 {
   volatile unsigned short *dmawp;
   unsigned short count;
@@ -316,7 +316,7 @@ static __inline__ int get_dma_residue(unsigned int dmanr)
  */
 
 /* enable/disable a specific DMA channel */
-static __inline__ void enable_dma(unsigned int dmanr)
+static inline void enable_dma(unsigned int dmanr)
 {
   volatile unsigned int  *dmalp;
 
@@ -328,7 +328,7 @@ static __inline__ void enable_dma(unsigned int dmanr)
   dmalp[MCFDMA_DMR] |= MCFDMA_DMR_EN;
 }
 
-static __inline__ void disable_dma(unsigned int dmanr)
+static inline void disable_dma(unsigned int dmanr)
 {
   volatile unsigned int   *dmalp;
 
@@ -353,12 +353,12 @@ static __inline__ void disable_dma(unsigned int dmanr)
  *
  * This is a NOP for ColdFire. Provide a stub for compatibility.
  */
-static __inline__ void clear_dma_ff(unsigned int dmanr)
+static inline void clear_dma_ff(unsigned int dmanr)
 {
 }
 
 /* set mode (above) for a specific DMA channel */
-static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
+static inline void set_dma_mode(unsigned int dmanr, char mode)
 {
 
   volatile unsigned int   *dmalp;
@@ -396,7 +396,7 @@ static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
 }
 
 /* Set transfer address for specific DMA channel */
-static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
+static inline void set_dma_addr(unsigned int dmanr, unsigned int a)
 {
   volatile unsigned int   *dmalp;
 
@@ -431,7 +431,7 @@ static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
  * Specific for Coldfire - sets device address.
  * Should be called after the mode set call, and before set DMA address.
  */
-static __inline__ void set_dma_device_addr(unsigned int dmanr, unsigned int a)
+static inline void set_dma_device_addr(unsigned int dmanr, unsigned int a)
 {
 #ifdef DMA_DEBUG
   printk("set_dma_device_addr(dmanr=%d,a=%x)\n", dmanr, a);
@@ -445,7 +445,7 @@ static __inline__ void set_dma_device_addr(unsigned int dmanr, unsigned int a)
  *
  * NOTE 3: While a 32-bit register, "count" is only a maximum 24-bit value.
  */
-static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
+static inline void set_dma_count(unsigned int dmanr, unsigned int count)
 {
   volatile unsigned int *dmalp;
 
@@ -463,7 +463,7 @@ static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
  * still in progress will return unpredictable results.
  * Otherwise, it returns the number of _bytes_ left to transfer.
  */
-static __inline__ int get_dma_residue(unsigned int dmanr)
+static inline int get_dma_residue(unsigned int dmanr)
 {
   volatile unsigned int *dmalp;
   unsigned int count;
diff --git a/arch/m68k/include/asm/floppy.h b/arch/m68k/include/asm/floppy.h
index c3b9ad6732fc..7a658a5ca746 100644
--- a/arch/m68k/include/asm/floppy.h
+++ b/arch/m68k/include/asm/floppy.h
@@ -50,20 +50,20 @@ static int doing_pdma=0;
 
 extern spinlock_t  dma_spin_lock;
 
-static __inline__ unsigned long claim_dma_lock(void)
+static inline unsigned long claim_dma_lock(void)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&dma_spin_lock, flags);
 	return flags;
 }
 
-static __inline__ void release_dma_lock(unsigned long flags)
+static inline void release_dma_lock(unsigned long flags)
 {
 	spin_unlock_irqrestore(&dma_spin_lock, flags);
 }
 
 
-static __inline__ unsigned char fd_inb(int port)
+static inline unsigned char fd_inb(int port)
 {
 	if(MACH_IS_Q40)
 		return inb_p(port);
@@ -72,7 +72,7 @@ static __inline__ unsigned char fd_inb(int port)
 	return 0;
 }
 
-static __inline__ void fd_outb(unsigned char value, int port)
+static inline void fd_outb(unsigned char value, int port)
 {
 	if(MACH_IS_Q40)
 		outb_p(value, port);
diff --git a/arch/m68k/include/asm/nettel.h b/arch/m68k/include/asm/nettel.h
index 45716ead7b9d..4037377c0048 100644
--- a/arch/m68k/include/asm/nettel.h
+++ b/arch/m68k/include/asm/nettel.h
@@ -47,14 +47,14 @@ extern volatile unsigned short ppdata;
  *	These functions defined to give quasi generic access to the
  *	PPIO bits used for DTR/DCD.
  */
-static __inline__ unsigned int mcf_getppdata(void)
+static inline unsigned int mcf_getppdata(void)
 {
 	volatile unsigned short *pp;
 	pp = (volatile unsigned short *) MCFSIM_PADAT;
 	return((unsigned int) *pp);
 }
 
-static __inline__ void mcf_setppdata(unsigned int mask, unsigned int bits)
+static inline void mcf_setppdata(unsigned int mask, unsigned int bits)
 {
 	volatile unsigned short *pp;
 	pp = (volatile unsigned short *) MCFSIM_PADAT;
@@ -86,12 +86,12 @@ static __inline__ void mcf_setppdata(unsigned int mask, unsigned int bits)
  *	These functions defined to give quasi generic access to the
  *	PPIO bits used for DTR/DCD.
  */
-static __inline__ unsigned int mcf_getppdata(void)
+static inline unsigned int mcf_getppdata(void)
 {
 	return readw(MCFSIM_PBDAT);
 }
 
-static __inline__ void mcf_setppdata(unsigned int mask, unsigned int bits)
+static inline void mcf_setppdata(unsigned int mask, unsigned int bits)
 {
 	writew((readw(MCFSIM_PBDAT) & ~mask) | bits, MCFSIM_PBDAT);
 }
diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 9bfa17015768..288b07530802 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -161,42 +161,42 @@ irqreturn_t iop_ism_irq(int, void *);
  * Private access functions
  */
 
-static __inline__ void iop_loadaddr(volatile struct mac_iop *iop, __u16 addr)
+static inline void iop_loadaddr(volatile struct mac_iop *iop, __u16 addr)
 {
 	iop->ram_addr_lo = addr;
 	iop->ram_addr_hi = addr >> 8;
 }
 
-static __inline__ __u8 iop_readb(volatile struct mac_iop *iop, __u16 addr)
+static inline __u8 iop_readb(volatile struct mac_iop *iop, __u16 addr)
 {
 	iop->ram_addr_lo = addr;
 	iop->ram_addr_hi = addr >> 8;
 	return iop->ram_data;
 }
 
-static __inline__ void iop_writeb(volatile struct mac_iop *iop, __u16 addr, __u8 data)
+static inline void iop_writeb(volatile struct mac_iop *iop, __u16 addr, __u8 data)
 {
 	iop->ram_addr_lo = addr;
 	iop->ram_addr_hi = addr >> 8;
 	iop->ram_data = data;
 }
 
-static __inline__ void iop_stop(volatile struct mac_iop *iop)
+static inline void iop_stop(volatile struct mac_iop *iop)
 {
 	iop->status_ctrl &= ~IOP_RUN;
 }
 
-static __inline__ void iop_start(volatile struct mac_iop *iop)
+static inline void iop_start(volatile struct mac_iop *iop)
 {
 	iop->status_ctrl = IOP_RUN | IOP_AUTOINC;
 }
 
-static __inline__ void iop_bypass(volatile struct mac_iop *iop)
+static inline void iop_bypass(volatile struct mac_iop *iop)
 {
 	iop->status_ctrl |= IOP_BYPASS;
 }
 
-static __inline__ void iop_interrupt(volatile struct mac_iop *iop)
+static inline void iop_interrupt(volatile struct mac_iop *iop)
 {
 	iop->status_ctrl |= IOP_IRQ;
 }
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index d4ea7a5b60cf..c179c12cd7c7 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -53,7 +53,7 @@
 #define atomic_set(v, i)	WRITE_ONCE((v)->counter, (i))
 
 #define ATOMIC_OP(op, c_op, asm_op)					      \
-static __inline__ void atomic_##op(int i, atomic_t * v)			      \
+static inline void atomic_##op(int i, atomic_t * v)			      \
 {									      \
 	if (kernel_uses_llsc) {						      \
 		int temp;						      \
@@ -77,7 +77,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 }
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				      \
-static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
+static inline int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 {									      \
 	int result;							      \
 									      \
@@ -109,7 +109,7 @@ static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				      \
-static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
+static inline int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 {									      \
 	int result;							      \
 									      \
@@ -178,7 +178,7 @@ ATOMIC_OPS(xor, ^=, xor)
  * Atomically test @v and subtract @i if @v is greater or equal than @i.
  * The function returns the old value of @v minus @i.
  */
-static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
+static inline int atomic_sub_if_positive(int i, atomic_t * v)
 {
 	int result;
 
@@ -246,7 +246,7 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 #define atomic64_set(v, i)	WRITE_ONCE((v)->counter, (i))
 
 #define ATOMIC64_OP(op, c_op, asm_op)					      \
-static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
+static inline void atomic64_##op(long i, atomic64_t * v)		      \
 {									      \
 	if (kernel_uses_llsc) {						      \
 		long temp;						      \
@@ -270,7 +270,7 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 }
 
 #define ATOMIC64_OP_RETURN(op, c_op, asm_op)				      \
-static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
+static inline long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 {									      \
 	long result;							      \
 									      \
@@ -302,7 +302,7 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 }
 
 #define ATOMIC64_FETCH_OP(op, c_op, asm_op)				      \
-static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
+static inline long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
 {									      \
 	long result;							      \
 									      \
@@ -372,7 +372,7 @@ ATOMIC64_OPS(xor, ^=, xor)
  * Atomically test @v and subtract @i if @v is greater or equal than @i.
  * The function returns the old value of @v minus @i.
  */
-static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
+static inline long atomic64_sub_if_positive(long i, atomic64_t * v)
 {
 	long result;
 
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index e8161e4dfde7..93f3fbc6e917 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -215,7 +215,7 @@ static inline __sum16 ip_compute_csum(const void *buff, int len)
 }
 
 #define _HAVE_ARCH_IPV6_CSUM
-static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 					  const struct in6_addr *daddr,
 					  __u32 len, __u8 proto,
 					  __wsum sum)
diff --git a/arch/mips/include/asm/dma.h b/arch/mips/include/asm/dma.h
index be726b943530..85cc6b5df8c9 100644
--- a/arch/mips/include/asm/dma.h
+++ b/arch/mips/include/asm/dma.h
@@ -157,20 +157,20 @@
 
 extern spinlock_t  dma_spin_lock;
 
-static __inline__ unsigned long claim_dma_lock(void)
+static inline unsigned long claim_dma_lock(void)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&dma_spin_lock, flags);
 	return flags;
 }
 
-static __inline__ void release_dma_lock(unsigned long flags)
+static inline void release_dma_lock(unsigned long flags)
 {
 	spin_unlock_irqrestore(&dma_spin_lock, flags);
 }
 
 /* enable/disable a specific DMA channel */
-static __inline__ void enable_dma(unsigned int dmanr)
+static inline void enable_dma(unsigned int dmanr)
 {
 	if (dmanr<=3)
 		dma_outb(dmanr,	 DMA1_MASK_REG);
@@ -178,7 +178,7 @@ static __inline__ void enable_dma(unsigned int dmanr)
 		dma_outb(dmanr & 3,  DMA2_MASK_REG);
 }
 
-static __inline__ void disable_dma(unsigned int dmanr)
+static inline void disable_dma(unsigned int dmanr)
 {
 	if (dmanr<=3)
 		dma_outb(dmanr | 4,  DMA1_MASK_REG);
@@ -193,7 +193,7 @@ static __inline__ void disable_dma(unsigned int dmanr)
  * --- In order to do that, the DMA routines below should ---
  * --- only be used while holding the DMA lock ! ---
  */
-static __inline__ void clear_dma_ff(unsigned int dmanr)
+static inline void clear_dma_ff(unsigned int dmanr)
 {
 	if (dmanr<=3)
 		dma_outb(0,  DMA1_CLEAR_FF_REG);
@@ -202,7 +202,7 @@ static __inline__ void clear_dma_ff(unsigned int dmanr)
 }
 
 /* set mode (above) for a specific DMA channel */
-static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
+static inline void set_dma_mode(unsigned int dmanr, char mode)
 {
 	if (dmanr<=3)
 		dma_outb(mode | dmanr,	DMA1_MODE_REG);
@@ -215,7 +215,7 @@ static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
  * the lower 16 bits of the DMA current address register, but a 64k boundary
  * may have been crossed.
  */
-static __inline__ void set_dma_page(unsigned int dmanr, char pagenr)
+static inline void set_dma_page(unsigned int dmanr, char pagenr)
 {
 	switch(dmanr) {
 		case 0:
@@ -246,7 +246,7 @@ static __inline__ void set_dma_page(unsigned int dmanr, char pagenr)
 /* Set transfer address & page bits for specific DMA channel.
  * Assumes dma flipflop is clear.
  */
-static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
+static inline void set_dma_addr(unsigned int dmanr, unsigned int a)
 {
 	set_dma_page(dmanr, a>>16);
 	if (dmanr <= 3)	 {
@@ -267,7 +267,7 @@ static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
  * Assumes dma flip-flop is clear.
  * NOTE 2: "count" represents _bytes_ and must be even for channels 5-7.
  */
-static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
+static inline void set_dma_count(unsigned int dmanr, unsigned int count)
 {
 	count--;
 	if (dmanr <= 3)	 {
@@ -288,7 +288,7 @@ static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
  *
  * Assumes DMA flip-flop is clear.
  */
-static __inline__ int get_dma_residue(unsigned int dmanr)
+static inline int get_dma_residue(unsigned int dmanr)
 {
 	unsigned int io_port = (dmanr<=3)? ((dmanr&3)<<1) + 1 + IO_DMA1_BASE
 					 : ((dmanr&3)<<2) + 2 + IO_DMA2_BASE;
diff --git a/arch/mips/include/asm/jazz.h b/arch/mips/include/asm/jazz.h
index a61970d01a81..9401780519eb 100644
--- a/arch/mips/include/asm/jazz.h
+++ b/arch/mips/include/asm/jazz.h
@@ -72,7 +72,7 @@
 
 #ifndef __ASSEMBLY__
 
-static __inline__ void pica_set_led(unsigned int bits)
+static inline void pica_set_led(unsigned int bits)
 {
 	volatile unsigned int *led_register = (unsigned int *) PICA_LED;
 
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index ac8264eca1e9..056b4a5e00f4 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -27,7 +27,7 @@ typedef struct
 /*
  * Same as above, but return the result value
  */
-static __inline__ long local_add_return(long i, local_t * l)
+static inline long local_add_return(long i, local_t * l)
 {
 	unsigned long result;
 
@@ -72,7 +72,7 @@ static __inline__ long local_add_return(long i, local_t * l)
 	return result;
 }
 
-static __inline__ long local_sub_return(long i, local_t * l)
+static inline long local_sub_return(long i, local_t * l)
 {
 	unsigned long result;
 
diff --git a/arch/mips/include/asm/string.h b/arch/mips/include/asm/string.h
index 29030cb398ee..8764cba30e50 100644
--- a/arch/mips/include/asm/string.h
+++ b/arch/mips/include/asm/string.h
@@ -20,7 +20,7 @@
 #ifndef IN_STRING_C
 
 #define __HAVE_ARCH_STRCPY
-static __inline__ char *strcpy(char *__dest, __const__ char *__src)
+static inline char *strcpy(char *__dest, __const__ char *__src)
 {
   char *__xdest = __dest;
 
@@ -42,7 +42,7 @@ static __inline__ char *strcpy(char *__dest, __const__ char *__src)
 }
 
 #define __HAVE_ARCH_STRNCPY
-static __inline__ char *strncpy(char *__dest, __const__ char *__src, size_t __n)
+static inline char *strncpy(char *__dest, __const__ char *__src, size_t __n)
 {
   char *__xdest = __dest;
 
@@ -70,7 +70,7 @@ static __inline__ char *strncpy(char *__dest, __const__ char *__src, size_t __n)
 }
 
 #define __HAVE_ARCH_STRCMP
-static __inline__ int strcmp(__const__ char *__cs, __const__ char *__ct)
+static inline int strcmp(__const__ char *__cs, __const__ char *__ct)
 {
   int __res;
 
@@ -100,7 +100,7 @@ static __inline__ int strcmp(__const__ char *__cs, __const__ char *__ct)
 #endif /* !defined(IN_STRING_C) */
 
 #define __HAVE_ARCH_STRNCMP
-static __inline__ int
+static inline int
 strncmp(__const__ char *__cs, __const__ char *__ct, size_t __count)
 {
 	int __res;
diff --git a/arch/mips/kernel/binfmt_elfn32.c b/arch/mips/kernel/binfmt_elfn32.c
index 7a12763d553a..c84b0d718dd4 100644
--- a/arch/mips/kernel/binfmt_elfn32.c
+++ b/arch/mips/kernel/binfmt_elfn32.c
@@ -82,7 +82,7 @@ struct elf_prpsinfo32
 #define init_elf_binfmt init_elfn32_binfmt
 
 #define jiffies_to_timeval jiffies_to_old_timeval32
-static __inline__ void
+static inline void
 jiffies_to_old_timeval32(unsigned long jiffies, struct old_timeval32 *value)
 {
 	/*
diff --git a/arch/nds32/include/asm/swab.h b/arch/nds32/include/asm/swab.h
index e01a755a37d2..8e87949e59fd 100644
--- a/arch/nds32/include/asm/swab.h
+++ b/arch/nds32/include/asm/swab.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 
-static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
+static inline __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 	__asm__("wsbh   %0, %0\n\t"	/* word swap byte within halfword */
 		"rotri  %0, %0, #16\n"
@@ -16,7 +16,7 @@ static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 	return x;
 }
 
-static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
+static inline __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("wsbh   %0, %0\n"	/* word swap byte within halfword */
 		:"=r"(x)
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 118953d41763..60efc1896b5e 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -56,7 +56,7 @@ extern arch_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned;
  * are atomic, so a reader never sees inconsistent values.
  */
 
-static __inline__ void atomic_set(atomic_t *v, int i)
+static inline void atomic_set(atomic_t *v, int i)
 {
 	unsigned long flags;
 	_atomic_spin_lock_irqsave(v, flags);
@@ -68,7 +68,7 @@ static __inline__ void atomic_set(atomic_t *v, int i)
 
 #define atomic_set_release(v, i)	atomic_set((v), (i))
 
-static __inline__ int atomic_read(const atomic_t *v)
+static inline int atomic_read(const atomic_t *v)
 {
 	return READ_ONCE((v)->counter);
 }
@@ -78,7 +78,7 @@ static __inline__ int atomic_read(const atomic_t *v)
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 #define ATOMIC_OP(op, c_op)						\
-static __inline__ void atomic_##op(int i, atomic_t *v)			\
+static inline void atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long flags;						\
 									\
@@ -88,7 +88,7 @@ static __inline__ void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
-static __inline__ int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -101,7 +101,7 @@ static __inline__ int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-static __inline__ int atomic_fetch_##op(int i, atomic_t *v)		\
+static inline int atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -143,7 +143,7 @@ ATOMIC_OPS(xor, ^=)
 #define ATOMIC64_INIT(i) { (i) }
 
 #define ATOMIC64_OP(op, c_op)						\
-static __inline__ void atomic64_##op(s64 i, atomic64_t *v)		\
+static inline void atomic64_##op(s64 i, atomic64_t *v)		\
 {									\
 	unsigned long flags;						\
 									\
@@ -153,7 +153,7 @@ static __inline__ void atomic64_##op(s64 i, atomic64_t *v)		\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, c_op)					\
-static __inline__ s64 atomic64_##op##_return(s64 i, atomic64_t *v)	\
+static inline s64 atomic64_##op##_return(s64 i, atomic64_t *v)	\
 {									\
 	unsigned long flags;						\
 	s64 ret;							\
@@ -166,7 +166,7 @@ static __inline__ s64 atomic64_##op##_return(s64 i, atomic64_t *v)	\
 }
 
 #define ATOMIC64_FETCH_OP(op, c_op)					\
-static __inline__ s64 atomic64_fetch_##op(s64 i, atomic64_t *v)		\
+static inline s64 atomic64_fetch_##op(s64 i, atomic64_t *v)		\
 {									\
 	unsigned long flags;						\
 	s64 ret;							\
@@ -201,7 +201,7 @@ ATOMIC64_OPS(xor, ^=)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-static __inline__ void
+static inline void
 atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned long flags;
@@ -212,7 +212,7 @@ atomic64_set(atomic64_t *v, s64 i)
 	_atomic_spin_unlock_irqrestore(v, flags);
 }
 
-static __inline__ s64
+static inline s64
 atomic64_read(const atomic64_t *v)
 {
 	return READ_ONCE((v)->counter);
diff --git a/arch/parisc/include/asm/bitops.h b/arch/parisc/include/asm/bitops.h
index 53252d4f9a57..58d4dc3c6ddf 100644
--- a/arch/parisc/include/asm/bitops.h
+++ b/arch/parisc/include/asm/bitops.h
@@ -33,7 +33,7 @@
  *	__*_bit() are "relaxed" and don't use spinlock or volatile.
  */
 
-static __inline__ void set_bit(int nr, volatile unsigned long * addr)
+static inline void set_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
 	unsigned long flags;
@@ -44,7 +44,7 @@ static __inline__ void set_bit(int nr, volatile unsigned long * addr)
 	_atomic_spin_unlock_irqrestore(addr, flags);
 }
 
-static __inline__ void clear_bit(int nr, volatile unsigned long * addr)
+static inline void clear_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = ~(1UL << CHOP_SHIFTCOUNT(nr));
 	unsigned long flags;
@@ -55,7 +55,7 @@ static __inline__ void clear_bit(int nr, volatile unsigned long * addr)
 	_atomic_spin_unlock_irqrestore(addr, flags);
 }
 
-static __inline__ void change_bit(int nr, volatile unsigned long * addr)
+static inline void change_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
 	unsigned long flags;
@@ -66,7 +66,7 @@ static __inline__ void change_bit(int nr, volatile unsigned long * addr)
 	_atomic_spin_unlock_irqrestore(addr, flags);
 }
 
-static __inline__ int test_and_set_bit(int nr, volatile unsigned long * addr)
+static inline int test_and_set_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
 	unsigned long old;
@@ -84,7 +84,7 @@ static __inline__ int test_and_set_bit(int nr, volatile unsigned long * addr)
 	return set;
 }
 
-static __inline__ int test_and_clear_bit(int nr, volatile unsigned long * addr)
+static inline int test_and_clear_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
 	unsigned long old;
@@ -102,7 +102,7 @@ static __inline__ int test_and_clear_bit(int nr, volatile unsigned long * addr)
 	return set;
 }
 
-static __inline__ int test_and_change_bit(int nr, volatile unsigned long * addr)
+static inline int test_and_change_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
 	unsigned long oldbit;
@@ -140,7 +140,7 @@ static __inline__ int test_and_change_bit(int nr, volatile unsigned long * addr)
  * cycles for each mispredicted branch.
  */
 
-static __inline__ unsigned long __ffs(unsigned long x)
+static inline unsigned long __ffs(unsigned long x)
 {
 	unsigned long ret;
 
@@ -178,7 +178,7 @@ static __inline__ unsigned long __ffs(unsigned long x)
  * This is defined the same way as the libc and compiler builtin
  * ffs routines, therefore differs in spirit from the above ffz (man ffs).
  */
-static __inline__ int ffs(int x)
+static inline int ffs(int x)
 {
 	return x ? (__ffs((unsigned long)x) + 1) : 0;
 }
@@ -188,7 +188,7 @@ static __inline__ int ffs(int x)
  * fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __inline__ int fls(int x)
+static inline int fls(int x)
 {
 	int ret;
 	if (!x)
diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 3cbf1f1c1188..2e441a55adc9 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -121,7 +121,7 @@ static inline __sum16 ip_compute_csum(const void *buf, int len)
 
 
 #define _HAVE_ARCH_IPV6_CSUM
-static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 					  const struct in6_addr *daddr,
 					  __u32 len, __u8 proto,
 					  __wsum sum)
@@ -189,7 +189,7 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  *	Copy and checksum to user
  */
 #define HAVE_CSUM_COPY_USER
-static __inline__ __wsum csum_and_copy_to_user(const void *src,
+static inline __wsum csum_and_copy_to_user(const void *src,
 						      void __user *dst,
 						      int len, __wsum sum,
 						      int *err_ptr)
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index e03e3c849f40..e2269acf3d2b 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -190,7 +190,7 @@ static inline compat_uptr_t ptr_to_compat(void __user *uptr)
 	return (u32)(unsigned long)uptr;
 }
 
-static __inline__ void __user *arch_compat_alloc_user_space(long len)
+static inline void __user *arch_compat_alloc_user_space(long len)
 {
 	struct pt_regs *regs = &current->thread.regs;
 	return (void __user *)regs->gr[30];
diff --git a/arch/parisc/include/asm/delay.h b/arch/parisc/include/asm/delay.h
index 841b506b702a..e8f35d605bb2 100644
--- a/arch/parisc/include/asm/delay.h
+++ b/arch/parisc/include/asm/delay.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_PARISC_DELAY_H
 #define _ASM_PARISC_DELAY_H
 
-static __inline__ void __delay(unsigned long loops) {
+static inline void __delay(unsigned long loops) {
 	asm volatile(
 	"	.balignl	64,0x34000034\n"
 	"	addib,UV -1,%0,.\n"
diff --git a/arch/parisc/include/asm/dma.h b/arch/parisc/include/asm/dma.h
index eea80ed34e6d..55170ca19ac9 100644
--- a/arch/parisc/include/asm/dma.h
+++ b/arch/parisc/include/asm/dma.h
@@ -71,12 +71,12 @@
 #define DMA2_MASK_ALL_REG       0xDE    /* all-channels mask (w) */
 #define DMA2_EXT_MODE_REG	(0x400 | DMA2_MODE_REG)
 
-static __inline__ unsigned long claim_dma_lock(void)
+static inline unsigned long claim_dma_lock(void)
 {
 	return 0;
 }
 
-static __inline__ void release_dma_lock(unsigned long flags)
+static inline void release_dma_lock(unsigned long flags)
 {
 }
 
@@ -89,7 +89,7 @@ static __inline__ void release_dma_lock(unsigned long flags)
  *
  * Assumes DMA flip-flop is clear.
  */
-static __inline__ int get_dma_residue(unsigned int dmanr)
+static inline int get_dma_residue(unsigned int dmanr)
 {
 	unsigned int io_port = (dmanr<=3)? ((dmanr&3)<<1) + 1 + IO_DMA1_BASE
 					 : ((dmanr&3)<<2) + 2 + IO_DMA2_BASE;
@@ -104,7 +104,7 @@ static __inline__ int get_dma_residue(unsigned int dmanr)
 }
 
 /* enable/disable a specific DMA channel */
-static __inline__ void enable_dma(unsigned int dmanr)
+static inline void enable_dma(unsigned int dmanr)
 {
 #ifdef CONFIG_SUPERIO
 	if (dmanr<=3)
@@ -114,7 +114,7 @@ static __inline__ void enable_dma(unsigned int dmanr)
 #endif
 }
 
-static __inline__ void disable_dma(unsigned int dmanr)
+static inline void disable_dma(unsigned int dmanr)
 {
 #ifdef CONFIG_SUPERIO
 	if (dmanr<=3)
@@ -134,12 +134,12 @@ static __inline__ void disable_dma(unsigned int dmanr)
  * --- In order to do that, the DMA routines below should ---
  * --- only be used while holding the DMA lock ! ---
  */
-static __inline__ void clear_dma_ff(unsigned int dmanr)
+static inline void clear_dma_ff(unsigned int dmanr)
 {
 }
 
 /* set mode (above) for a specific DMA channel */
-static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
+static inline void set_dma_mode(unsigned int dmanr, char mode)
 {
 }
 
@@ -148,7 +148,7 @@ static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
  * the lower 16 bits of the DMA current address register, but a 64k boundary
  * may have been crossed.
  */
-static __inline__ void set_dma_page(unsigned int dmanr, char pagenr)
+static inline void set_dma_page(unsigned int dmanr, char pagenr)
 {
 }
 
@@ -156,7 +156,7 @@ static __inline__ void set_dma_page(unsigned int dmanr, char pagenr)
 /* Set transfer address & page bits for specific DMA channel.
  * Assumes dma flipflop is clear.
  */
-static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
+static inline void set_dma_addr(unsigned int dmanr, unsigned int a)
 {
 }
 
@@ -169,7 +169,7 @@ static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
  * Assumes dma flip-flop is clear.
  * NOTE 2: "count" represents _bytes_ and must be even for channels 5-7.
  */
-static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
+static inline void set_dma_count(unsigned int dmanr, unsigned int count)
 {
 }
 
diff --git a/arch/parisc/include/asm/ide.h b/arch/parisc/include/asm/ide.h
index 34cdac01ed35..edd7fe03b90a 100644
--- a/arch/parisc/include/asm/ide.h
+++ b/arch/parisc/include/asm/ide.h
@@ -21,7 +21,7 @@
 #define __ide_outsw	outsw
 #define __ide_outsl	outsl
 
-static __inline__ void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
+static inline void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
 {
 	while (count--) {
 		*(u16 *)addr = __raw_readw(port);
@@ -29,7 +29,7 @@ static __inline__ void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
 	}
 }
 
-static __inline__ void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
+static inline void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
 {
 	while (count--) {
 		*(u32 *)addr = __raw_readl(port);
@@ -37,7 +37,7 @@ static __inline__ void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
 	}
 }
 
-static __inline__ void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
+static inline void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
 {
 	while (count--) {
 		__raw_writew(*(u16 *)addr, port);
@@ -45,7 +45,7 @@ static __inline__ void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
 	}
 }
 
-static __inline__ void __ide_mm_outsl(void __iomem *port, void *addr, u32 count)
+static inline void __ide_mm_outsl(void __iomem *port, void *addr, u32 count)
 {
 	while (count--) {
 		__raw_writel(*(u32 *)addr, port);
diff --git a/arch/parisc/include/asm/irq.h b/arch/parisc/include/asm/irq.h
index 959e79cd2c14..b1c23a163114 100644
--- a/arch/parisc/include/asm/irq.h
+++ b/arch/parisc/include/asm/irq.h
@@ -27,7 +27,7 @@
 
 #define NR_IRQS		(CPU_IRQ_MAX + 1)
 
-static __inline__ int irq_canonicalize(int irq)
+static inline int irq_canonicalize(int irq)
 {
 	return (irq == 2) ? 9 : irq;
 }
diff --git a/arch/parisc/include/asm/spinlock.h b/arch/parisc/include/asm/spinlock.h
index 8a63515f03bf..0d4620a1f81b 100644
--- a/arch/parisc/include/asm/spinlock.h
+++ b/arch/parisc/include/asm/spinlock.h
@@ -66,7 +66,7 @@ static inline int arch_spin_trylock(arch_spinlock_t *x)
 
 /* Note that we have to ensure interrupts are disabled in case we're
  * interrupted by some other code that wants to grab the same read lock */
-static  __inline__ void arch_read_lock(arch_rwlock_t *rw)
+static  inline void arch_read_lock(arch_rwlock_t *rw)
 {
 	unsigned long flags;
 	local_irq_save(flags);
@@ -78,7 +78,7 @@ static  __inline__ void arch_read_lock(arch_rwlock_t *rw)
 
 /* Note that we have to ensure interrupts are disabled in case we're
  * interrupted by some other code that wants to grab the same read lock */
-static  __inline__ void arch_read_unlock(arch_rwlock_t *rw)
+static  inline void arch_read_unlock(arch_rwlock_t *rw)
 {
 	unsigned long flags;
 	local_irq_save(flags);
@@ -90,7 +90,7 @@ static  __inline__ void arch_read_unlock(arch_rwlock_t *rw)
 
 /* Note that we have to ensure interrupts are disabled in case we're
  * interrupted by some other code that wants to grab the same read lock */
-static __inline__ int arch_read_trylock(arch_rwlock_t *rw)
+static inline int arch_read_trylock(arch_rwlock_t *rw)
 {
 	unsigned long flags;
  retry:
@@ -116,7 +116,7 @@ static __inline__ int arch_read_trylock(arch_rwlock_t *rw)
 
 /* Note that we have to ensure interrupts are disabled in case we're
  * interrupted by some other code that wants to read_trylock() this lock */
-static __inline__ void arch_write_lock(arch_rwlock_t *rw)
+static inline void arch_write_lock(arch_rwlock_t *rw)
 {
 	unsigned long flags;
 retry:
@@ -138,7 +138,7 @@ static __inline__ void arch_write_lock(arch_rwlock_t *rw)
 	local_irq_restore(flags);
 }
 
-static __inline__ void arch_write_unlock(arch_rwlock_t *rw)
+static inline void arch_write_unlock(arch_rwlock_t *rw)
 {
 	rw->counter = 0;
 	arch_spin_unlock(&rw->lock);
@@ -146,7 +146,7 @@ static __inline__ void arch_write_unlock(arch_rwlock_t *rw)
 
 /* Note that we have to ensure interrupts are disabled in case we're
  * interrupted by some other code that wants to read_trylock() this lock */
-static __inline__ int arch_write_trylock(arch_rwlock_t *rw)
+static inline int arch_write_trylock(arch_rwlock_t *rw)
 {
 	unsigned long flags;
 	int result = 0;
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 52eafaf74054..4e33807c75cf 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -25,7 +25,7 @@
 #define __atomic_release_fence()					\
 	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory")
 
-static __inline__ int atomic_read(const atomic_t *v)
+static inline int atomic_read(const atomic_t *v)
 {
 	int t;
 
@@ -34,13 +34,13 @@ static __inline__ int atomic_read(const atomic_t *v)
 	return t;
 }
 
-static __inline__ void atomic_set(atomic_t *v, int i)
+static inline void atomic_set(atomic_t *v, int i)
 {
 	__asm__ __volatile__("stw%U0%X0 %1,%0" : "=m"(v->counter) : "r"(i));
 }
 
 #define ATOMIC_OP(op, asm_op)						\
-static __inline__ void atomic_##op(int a, atomic_t *v)			\
+static inline void atomic_##op(int a, atomic_t *v)			\
 {									\
 	int t;								\
 									\
@@ -123,7 +123,7 @@ ATOMIC_OPS(xor, xor)
 #undef ATOMIC_OP_RETURN_RELAXED
 #undef ATOMIC_OP
 
-static __inline__ void atomic_inc(atomic_t *v)
+static inline void atomic_inc(atomic_t *v)
 {
 	int t;
 
@@ -139,7 +139,7 @@ static __inline__ void atomic_inc(atomic_t *v)
 }
 #define atomic_inc atomic_inc
 
-static __inline__ int atomic_inc_return_relaxed(atomic_t *v)
+static inline int atomic_inc_return_relaxed(atomic_t *v)
 {
 	int t;
 
@@ -156,7 +156,7 @@ static __inline__ int atomic_inc_return_relaxed(atomic_t *v)
 	return t;
 }
 
-static __inline__ void atomic_dec(atomic_t *v)
+static inline void atomic_dec(atomic_t *v)
 {
 	int t;
 
@@ -172,7 +172,7 @@ static __inline__ void atomic_dec(atomic_t *v)
 }
 #define atomic_dec atomic_dec
 
-static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
+static inline int atomic_dec_return_relaxed(atomic_t *v)
 {
 	int t;
 
@@ -210,7 +210,7 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int t;
 
@@ -241,7 +241,7 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * Atomically increments @v by 1, so long as @v is non-zero.
  * Returns non-zero if @v was non-zero, and zero otherwise.
  */
-static __inline__ int atomic_inc_not_zero(atomic_t *v)
+static inline int atomic_inc_not_zero(atomic_t *v)
 {
 	int t1, t2;
 
@@ -270,7 +270,7 @@ static __inline__ int atomic_inc_not_zero(atomic_t *v)
  * The function returns the old value of *v minus 1, even if
  * the atomic variable, v, was not decremented.
  */
-static __inline__ int atomic_dec_if_positive(atomic_t *v)
+static inline int atomic_dec_if_positive(atomic_t *v)
 {
 	int t;
 
@@ -297,7 +297,7 @@ static __inline__ int atomic_dec_if_positive(atomic_t *v)
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-static __inline__ long atomic64_read(const atomic64_t *v)
+static inline long atomic64_read(const atomic64_t *v)
 {
 	long t;
 
@@ -306,13 +306,13 @@ static __inline__ long atomic64_read(const atomic64_t *v)
 	return t;
 }
 
-static __inline__ void atomic64_set(atomic64_t *v, long i)
+static inline void atomic64_set(atomic64_t *v, long i)
 {
 	__asm__ __volatile__("std%U0%X0 %1,%0" : "=m"(v->counter) : "r"(i));
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
-static __inline__ void atomic64_##op(long a, atomic64_t *v)		\
+static inline void atomic64_##op(long a, atomic64_t *v)		\
 {									\
 	long t;								\
 									\
@@ -394,7 +394,7 @@ ATOMIC64_OPS(xor, xor)
 #undef ATOMIC64_OP_RETURN_RELAXED
 #undef ATOMIC64_OP
 
-static __inline__ void atomic64_inc(atomic64_t *v)
+static inline void atomic64_inc(atomic64_t *v)
 {
 	long t;
 
@@ -409,7 +409,7 @@ static __inline__ void atomic64_inc(atomic64_t *v)
 }
 #define atomic64_inc atomic64_inc
 
-static __inline__ long atomic64_inc_return_relaxed(atomic64_t *v)
+static inline long atomic64_inc_return_relaxed(atomic64_t *v)
 {
 	long t;
 
@@ -425,7 +425,7 @@ static __inline__ long atomic64_inc_return_relaxed(atomic64_t *v)
 	return t;
 }
 
-static __inline__ void atomic64_dec(atomic64_t *v)
+static inline void atomic64_dec(atomic64_t *v)
 {
 	long t;
 
@@ -440,7 +440,7 @@ static __inline__ void atomic64_dec(atomic64_t *v)
 }
 #define atomic64_dec atomic64_dec
 
-static __inline__ long atomic64_dec_return_relaxed(atomic64_t *v)
+static inline long atomic64_dec_return_relaxed(atomic64_t *v)
 {
 	long t;
 
@@ -463,7 +463,7 @@ static __inline__ long atomic64_dec_return_relaxed(atomic64_t *v)
  * Atomically test *v and decrement if it is greater than 0.
  * The function returns the old value of *v minus 1.
  */
-static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
+static inline long atomic64_dec_if_positive(atomic64_t *v)
 {
 	long t;
 
@@ -502,7 +502,7 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
+static inline long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
 {
 	long t;
 
@@ -532,7 +532,7 @@ static __inline__ long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
  * Atomically increments @v by 1, so long as @v is non-zero.
  * Returns non-zero if @v was non-zero, and zero otherwise.
  */
-static __inline__ int atomic64_inc_not_zero(atomic64_t *v)
+static inline int atomic64_inc_not_zero(atomic64_t *v)
 {
 	long t1, t2;
 
diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index ff71566dadee..0858c8ddea92 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -68,7 +68,7 @@
 
 /* Macro for generating the ***_bits() functions */
 #define DEFINE_BITOP(fn, op, prefix)		\
-static __inline__ void fn(unsigned long mask,	\
+static inline void fn(unsigned long mask,	\
 		volatile unsigned long *_p)	\
 {						\
 	unsigned long old;			\
@@ -90,22 +90,22 @@ DEFINE_BITOP(clear_bits, andc, "")
 DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
 DEFINE_BITOP(change_bits, xor, "")
 
-static __inline__ void set_bit(int nr, volatile unsigned long *addr)
+static inline void set_bit(int nr, volatile unsigned long *addr)
 {
 	set_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
+static inline void clear_bit(int nr, volatile unsigned long *addr)
 {
 	clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
+static inline void clear_bit_unlock(int nr, volatile unsigned long *addr)
 {
 	clear_bits_unlock(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void change_bit(int nr, volatile unsigned long *addr)
+static inline void change_bit(int nr, volatile unsigned long *addr)
 {
 	change_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
@@ -113,7 +113,7 @@ static __inline__ void change_bit(int nr, volatile unsigned long *addr)
 /* Like DEFINE_BITOP(), with changes to the arguments to 'op' and the output
  * operands. */
 #define DEFINE_TESTOP(fn, op, prefix, postfix, eh)	\
-static __inline__ unsigned long fn(			\
+static inline unsigned long fn(			\
 		unsigned long mask,			\
 		volatile unsigned long *_p)		\
 {							\
@@ -142,33 +142,33 @@ DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
 DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
 	      PPC_ATOMIC_EXIT_BARRIER, 0)
 
-static __inline__ int test_and_set_bit(unsigned long nr,
+static inline int test_and_set_bit(unsigned long nr,
 				       volatile unsigned long *addr)
 {
 	return test_and_set_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_set_bit_lock(unsigned long nr,
+static inline int test_and_set_bit_lock(unsigned long nr,
 				       volatile unsigned long *addr)
 {
 	return test_and_set_bits_lock(BIT_MASK(nr),
 				addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_clear_bit(unsigned long nr,
+static inline int test_and_clear_bit(unsigned long nr,
 					 volatile unsigned long *addr)
 {
 	return test_and_clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_change_bit(unsigned long nr,
+static inline int test_and_change_bit(unsigned long nr,
 					  volatile unsigned long *addr)
 {
 	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
 #ifdef CONFIG_PPC64
-static __inline__ unsigned long clear_bit_unlock_return_word(int nr,
+static inline unsigned long clear_bit_unlock_return_word(int nr,
 						volatile unsigned long *addr)
 {
 	unsigned long old, t;
@@ -197,7 +197,7 @@ static __inline__ unsigned long clear_bit_unlock_return_word(int nr,
 
 #include <asm-generic/bitops/non-atomic.h>
 
-static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
+static inline void __clear_bit_unlock(int nr, volatile unsigned long *addr)
 {
 	__asm__ __volatile__(PPC_RELEASE_BARRIER "" ::: "memory");
 	__clear_bit(nr, addr);
@@ -219,14 +219,14 @@ static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
  * fls: find last (most-significant) bit set.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static __inline__ int fls(unsigned int x)
+static inline int fls(unsigned int x)
 {
 	return 32 - __builtin_clz(x);
 }
 
 #include <asm-generic/bitops/builtin-__fls.h>
 
-static __inline__ int fls64(__u64 x)
+static inline int fls64(__u64 x)
 {
 	return 64 - __builtin_clzll(x);
 }
diff --git a/arch/powerpc/include/asm/dma.h b/arch/powerpc/include/asm/dma.h
index 1b4f0254868f..d5be698b831a 100644
--- a/arch/powerpc/include/asm/dma.h
+++ b/arch/powerpc/include/asm/dma.h
@@ -166,20 +166,20 @@
 
 extern spinlock_t dma_spin_lock;
 
-static __inline__ unsigned long claim_dma_lock(void)
+static inline unsigned long claim_dma_lock(void)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&dma_spin_lock, flags);
 	return flags;
 }
 
-static __inline__ void release_dma_lock(unsigned long flags)
+static inline void release_dma_lock(unsigned long flags)
 {
 	spin_unlock_irqrestore(&dma_spin_lock, flags);
 }
 
 /* enable/disable a specific DMA channel */
-static __inline__ void enable_dma(unsigned int dmanr)
+static inline void enable_dma(unsigned int dmanr)
 {
 	unsigned char ucDmaCmd = 0x00;
 
@@ -195,7 +195,7 @@ static __inline__ void enable_dma(unsigned int dmanr)
 	}
 }
 
-static __inline__ void disable_dma(unsigned int dmanr)
+static inline void disable_dma(unsigned int dmanr)
 {
 	if (dmanr <= 3)
 		dma_outb(dmanr | 4, DMA1_MASK_REG);
@@ -210,7 +210,7 @@ static __inline__ void disable_dma(unsigned int dmanr)
  * --- In order to do that, the DMA routines below should ---
  * --- only be used while interrupts are disabled! ---
  */
-static __inline__ void clear_dma_ff(unsigned int dmanr)
+static inline void clear_dma_ff(unsigned int dmanr)
 {
 	if (dmanr <= 3)
 		dma_outb(0, DMA1_CLEAR_FF_REG);
@@ -219,7 +219,7 @@ static __inline__ void clear_dma_ff(unsigned int dmanr)
 }
 
 /* set mode (above) for a specific DMA channel */
-static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
+static inline void set_dma_mode(unsigned int dmanr, char mode)
 {
 	if (dmanr <= 3)
 		dma_outb(mode | dmanr, DMA1_MODE_REG);
@@ -232,7 +232,7 @@ static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
  * the lower 16 bits of the DMA current address register, but a 64k boundary
  * may have been crossed.
  */
-static __inline__ void set_dma_page(unsigned int dmanr, int pagenr)
+static inline void set_dma_page(unsigned int dmanr, int pagenr)
 {
 	switch (dmanr) {
 	case 0:
@@ -269,7 +269,7 @@ static __inline__ void set_dma_page(unsigned int dmanr, int pagenr)
 /* Set transfer address & page bits for specific DMA channel.
  * Assumes dma flipflop is clear.
  */
-static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int phys)
+static inline void set_dma_addr(unsigned int dmanr, unsigned int phys)
 {
 	if (dmanr <= 3) {
 		dma_outb(phys & 0xff,
@@ -294,7 +294,7 @@ static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int phys)
  * Assumes dma flip-flop is clear.
  * NOTE 2: "count" represents _bytes_ and must be even for channels 5-7.
  */
-static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
+static inline void set_dma_count(unsigned int dmanr, unsigned int count)
 {
 	count--;
 	if (dmanr <= 3) {
@@ -319,7 +319,7 @@ static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
  *
  * Assumes DMA flip-flop is clear.
  */
-static __inline__ int get_dma_residue(unsigned int dmanr)
+static inline int get_dma_residue(unsigned int dmanr)
 {
 	unsigned int io_port = (dmanr <= 3)
 	    ? ((dmanr & 3) << 1) + 1 + IO_DMA1_BASE
diff --git a/arch/powerpc/include/asm/edac.h b/arch/powerpc/include/asm/edac.h
index 5571e23d253e..f331c7f8525f 100644
--- a/arch/powerpc/include/asm/edac.h
+++ b/arch/powerpc/include/asm/edac.h
@@ -16,7 +16,7 @@
  * ECC scrubbing.  It reads memory and then writes back the original
  * value, allowing the hardware to detect and correct memory errors.
  */
-static __inline__ void edac_atomic_scrub(void *va, u32 size)
+static inline void edac_atomic_scrub(void *va, u32 size)
 {
 	unsigned int *virt_addr = va;
 	unsigned int temp;
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index ee39ce56b2a2..676a7e7c66e7 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -31,7 +31,7 @@ extern atomic_t ppc_n_lost_interrupts;
 
 extern irq_hw_number_t virq_to_hw(unsigned int virq);
 
-static __inline__ int irq_canonicalize(int irq)
+static inline int irq_canonicalize(int irq)
 {
 	return irq;
 }
diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index fdd00939270b..95702e9dc1d0 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -17,18 +17,18 @@ typedef struct
 
 #define LOCAL_INIT(i)	{ (i) }
 
-static __inline__ long local_read(local_t *l)
+static inline long local_read(local_t *l)
 {
 	return READ_ONCE(l->v);
 }
 
-static __inline__ void local_set(local_t *l, long i)
+static inline void local_set(local_t *l, long i)
 {
 	WRITE_ONCE(l->v, i);
 }
 
 #define LOCAL_OP(op, c_op)						\
-static __inline__ void local_##op(long i, local_t *l)			\
+static inline void local_##op(long i, local_t *l)			\
 {									\
 	unsigned long flags;						\
 									\
@@ -38,7 +38,7 @@ static __inline__ void local_##op(long i, local_t *l)			\
 }
 
 #define LOCAL_OP_RETURN(op, c_op)					\
-static __inline__ long local_##op##_return(long a, local_t *l)		\
+static inline long local_##op##_return(long a, local_t *l)		\
 {									\
 	long t;								\
 	unsigned long flags;						\
@@ -76,7 +76,7 @@ LOCAL_OPS(sub, -=)
 #define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
 #define local_dec_and_test(l)		(local_dec_return((l)) == 0)
 
-static __inline__ long local_cmpxchg(local_t *l, long o, long n)
+static inline long local_cmpxchg(local_t *l, long o, long n)
 {
 	long t;
 	unsigned long flags;
@@ -90,7 +90,7 @@ static __inline__ long local_cmpxchg(local_t *l, long o, long n)
 	return t;
 }
 
-static __inline__ long local_xchg(local_t *l, long n)
+static inline long local_xchg(local_t *l, long n)
 {
 	long t;
 	unsigned long flags;
@@ -112,7 +112,7 @@ static __inline__ long local_xchg(local_t *l, long n)
  * Atomically adds @a to @l, so long as it was not @u.
  * Returns non-zero if @l was not @u, and zero otherwise.
  */
-static __inline__ int local_add_unless(local_t *l, long a, long u)
+static inline int local_add_unless(local_t *l, long a, long u)
 {
 	unsigned long flags;
 	int ret = 0;
diff --git a/arch/sh/include/asm/pgtable_64.h b/arch/sh/include/asm/pgtable_64.h
index 07424968df62..12ca0d9bdebb 100644
--- a/arch/sh/include/asm/pgtable_64.h
+++ b/arch/sh/include/asm/pgtable_64.h
@@ -32,7 +32,7 @@
  */
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
 
-static __inline__ void set_pte(pte_t *pteptr, pte_t pteval)
+static inline void set_pte(pte_t *pteptr, pte_t pteval)
 {
 	unsigned long long x = ((unsigned long long) pteval.pte_low);
 	unsigned long long *xp = (unsigned long long *) pteptr;
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index 95100d8a0b7b..87aa8cb16b5a 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -141,7 +141,7 @@ extern void release_thread(struct task_struct *);
  * FPU lazy state save handling.
  */
 
-static __inline__ void disable_fpu(void)
+static inline void disable_fpu(void)
 {
 	unsigned long __dummy;
 
@@ -153,7 +153,7 @@ static __inline__ void disable_fpu(void)
 			     : "r" (SR_FD));
 }
 
-static __inline__ void enable_fpu(void)
+static inline void enable_fpu(void)
 {
 	unsigned long __dummy;
 
diff --git a/arch/sh/include/cpu-sh3/cpu/dac.h b/arch/sh/include/cpu-sh3/cpu/dac.h
index fd02331608a8..67ae1ae03c47 100644
--- a/arch/sh/include/cpu-sh3/cpu/dac.h
+++ b/arch/sh/include/cpu-sh3/cpu/dac.h
@@ -15,7 +15,7 @@
 #define DACR_DAE	0x20
 
 
-static __inline__ void sh_dac_enable(int channel)
+static inline void sh_dac_enable(int channel)
 {
 	unsigned char v;
 	v = __raw_readb(DACR);
@@ -24,7 +24,7 @@ static __inline__ void sh_dac_enable(int channel)
 	__raw_writeb(v,DACR);
 }
 
-static __inline__ void sh_dac_disable(int channel)
+static inline void sh_dac_disable(int channel)
 {
 	unsigned char v;
 	v = __raw_readb(DACR);
@@ -33,7 +33,7 @@ static __inline__ void sh_dac_disable(int channel)
 	__raw_writeb(v,DACR);
 }
 
-static __inline__ void sh_dac_output(u8 value, int channel)
+static inline void sh_dac_output(u8 value, int channel)
 {
 	if(channel) __raw_writeb(value,DADR1);
 	else __raw_writeb(value,DADR0);
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index d7faa16622d8..8eb160bb08eb 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -159,10 +159,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * without volatile and memory clobber.
  */
 #define alternative(oldinstr, newinstr, feature)			\
-	asm volatile (ALTERNATIVE(oldinstr, newinstr, feature) : : : "memory")
+	asm_volatile (ALTERNATIVE(oldinstr, newinstr, feature) : : : "memory")
 
 #define alternative_2(oldinstr, newinstr1, feature1, newinstr2, feature2) \
-	asm volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory")
+	asm_volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory")
 
 /*
  * Alternative inline assembly with input.
@@ -176,7 +176,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Leaving an unused argument 0 to keep API compatibility.
  */
 #define alternative_input(oldinstr, newinstr, feature, input...)	\
-	asm volatile (ALTERNATIVE(oldinstr, newinstr, feature)		\
+	asm_volatile (ALTERNATIVE(oldinstr, newinstr, feature)		\
 		: : "i" (0), ## input)
 
 /*
@@ -189,18 +189,18 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_input_2(oldinstr, newinstr1, feature1, newinstr2,	     \
 			   feature2, input...)				     \
-	asm volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1,	     \
+	asm_volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1,	     \
 		newinstr2, feature2)					     \
 		: : "i" (0), ## input)
 
 /* Like alternative_input, but with a single output argument */
 #define alternative_io(oldinstr, newinstr, feature, output, input...)	\
-	asm volatile (ALTERNATIVE(oldinstr, newinstr, feature)		\
+	asm_volatile (ALTERNATIVE(oldinstr, newinstr, feature)		\
 		: output : "i" (0), ## input)
 
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, feature, output, input...)	\
-	asm volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
+	asm_volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
@@ -211,7 +211,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call_2(oldfunc, newfunc1, feature1, newfunc2, feature2,   \
 			   output, input...)				      \
-	asm volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
+	asm_volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
 		"call %P[new2]", feature2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index 2a56cac64687..8f1c7f32d420 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -28,7 +28,7 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
  *	access_ok().
  */
 
-static __inline__
+static inline
 __wsum csum_partial_copy_nocheck(const void *src, void *dst,
 				       int len, __wsum sum)
 {
@@ -44,7 +44,7 @@ __wsum csum_partial_copy_nocheck(const void *src, void *dst,
  * better 64-bit) boundary
  */
 
-static __inline__
+static inline
 __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
 					 int len, __wsum sum, int *err_ptr)
 {
diff --git a/arch/x86/um/asm/checksum_32.h b/arch/x86/um/asm/checksum_32.h
index 83a75f8a1233..8364af309b85 100644
--- a/arch/x86/um/asm/checksum_32.h
+++ b/arch/x86/um/asm/checksum_32.h
@@ -11,7 +11,7 @@ static inline __sum16 ip_compute_csum(const void *buff, int len)
 }
 
 #define _HAVE_ARCH_IPV6_CSUM
-static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 					  const struct in6_addr *daddr,
 					  __u32 len, __u8 proto,
 					  __wsum sum)
@@ -39,7 +39,7 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  *	Copy and checksum to user
  */
 #define HAVE_CSUM_COPY_USER
-static __inline__ __wsum csum_and_copy_to_user(const void *src,
+static inline __wsum csum_and_copy_to_user(const void *src,
 						     void __user *dst,
 						     int len, __wsum sum, int *err_ptr)
 {
diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index 3ae74d7e074b..4eeb36d2082c 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -66,7 +66,7 @@ __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
  *	Fold a partial checksum
  */
 
-static __inline__ __sum16 csum_fold(__wsum sum)
+static inline __sum16 csum_fold(__wsum sum)
 {
 	unsigned int __dummy;
 	__asm__("extui	%1, %0, 16, 16\n\t"
@@ -87,7 +87,7 @@ static __inline__ __sum16 csum_fold(__wsum sum)
  *	This is a version of ip_compute_csum() optimized for IP headers,
  *	which always checksum on 4 octet boundaries.
  */
-static __inline__ __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
 	unsigned int sum, tmp, endaddr;
 
@@ -122,7 +122,7 @@ static __inline__ __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	return	csum_fold(sum);
 }
 
-static __inline__ __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
+static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 					    __u32 len, __u8 proto,
 					    __wsum sum)
 {
@@ -155,7 +155,7 @@ static __inline__ __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
  * computes the checksum of the TCP/UDP pseudo-header
  * returns a 16-bit checksum, already complemented
  */
-static __inline__ __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
+static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 					    __u32 len, __u8 proto,
 					    __wsum sum)
 {
@@ -167,13 +167,13 @@ static __inline__ __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
  * in icmp.c
  */
 
-static __inline__ __sum16 ip_compute_csum(const void *buff, int len)
+static inline __sum16 ip_compute_csum(const void *buff, int len)
 {
 	return csum_fold (csum_partial(buff, len, 0));
 }
 
 #define _HAVE_ARCH_IPV6_CSUM
-static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 					  const struct in6_addr *daddr,
 					  __u32 len, __u8 proto,
 					  __wsum sum)
@@ -239,7 +239,7 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  *	Copy and checksum to user
  */
 #define HAVE_CSUM_COPY_USER
-static __inline__ __wsum csum_and_copy_to_user(const void *src,
+static inline __wsum csum_and_copy_to_user(const void *src,
 					       void __user *dst, int len,
 					       __wsum sum, int *err_ptr)
 {
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 201e9009efd8..15d62c16de7a 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -52,7 +52,7 @@ __cmpxchg_u32(volatile int *p, int old, int new)
 
 extern void __cmpxchg_called_with_bad_pointer(void);
 
-static __inline__ unsigned long
+static inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {
@@ -146,7 +146,7 @@ static inline unsigned long xchg_u32(volatile int * m, unsigned long val)
 
 extern void __xchg_called_with_bad_pointer(void);
 
-static __inline__ unsigned long
+static inline unsigned long
 __xchg(unsigned long x, volatile void * ptr, int size)
 {
 	switch (size) {
diff --git a/arch/xtensa/include/asm/irq.h b/arch/xtensa/include/asm/irq.h
index 6c6ed23e0c79..ae53e599255f 100644
--- a/arch/xtensa/include/asm/irq.h
+++ b/arch/xtensa/include/asm/irq.h
@@ -23,7 +23,7 @@
 #define NR_IRQS (XTENSA_NR_IRQS + PLATFORM_NR_IRQS + 1)
 #define XTENSA_PIC_LINUX_IRQ(hwirq) ((hwirq) + 1)
 
-static __inline__ int irq_canonicalize(int irq)
+static inline int irq_canonicalize(int irq)
 {
 	return (irq);
 }
diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 560936617d9c..7434b0a0f86c 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -16,7 +16,7 @@
 #include "check.h"
 #include "amiga.h"
 
-static __inline__ u32
+static inline u32
 checksum_block(__be32 *m, int size)
 {
 	u32 sum = 0;
diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index 29f102dcfec4..abb6415f9565 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -178,7 +178,7 @@ static const struct atmdev_ops he_ops =
 
 /* section 2.12 connection memory access */
 
-static __inline__ void
+static inline void
 he_writel_internal(struct he_dev *he_dev, unsigned val, unsigned addr,
 								unsigned flags)
 {
@@ -324,7 +324,7 @@ he_readl_internal(struct he_dev *he_dev, unsigned addr, unsigned flags)
 #define he_writel_rsr7(dev, val, cid) \
 		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 7)
 
-static __inline__ struct atm_vcc*
+static inline struct atm_vcc*
 __find_vcc(struct he_dev *he_dev, unsigned cid)
 {
 	struct hlist_head *head;
@@ -2050,7 +2050,7 @@ he_irq_handler(int irq, void *dev_id)
 
 }
 
-static __inline__ void
+static inline void
 __enqueue_tpd(struct he_dev *he_dev, struct he_tpd *tpd, unsigned cid)
 {
 	struct he_tpdrq *new_tail;
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 6e737142ceaa..226a65a03b70 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -1783,13 +1783,13 @@ set_tct(struct idt77252_dev *card, struct vc_map *vc)
 /*                                                                           */
 /*****************************************************************************/
 
-static __inline__ int
+static inline int
 idt77252_fbq_level(struct idt77252_dev *card, int queue)
 {
 	return (readl(SAR_REG_STAT) >> (16 + (queue << 2))) & 0x0f;
 }
 
-static __inline__ int
+static inline int
 idt77252_fbq_full(struct idt77252_dev *card, int queue)
 {
 	return (readl(SAR_REG_STAT) >> (16 + (queue << 2))) == 0x0f;
@@ -2016,7 +2016,7 @@ idt77252_send_oam(struct atm_vcc *vcc, void *cell, int flags)
 	return idt77252_send_skb(vcc, skb, 1);
 }
 
-static __inline__ unsigned int
+static inline unsigned int
 idt77252_fls(unsigned int x)
 {
 	int r = 1;
diff --git a/drivers/gpu/drm/mga/mga_drv.h b/drivers/gpu/drm/mga/mga_drv.h
index a45bb22275a7..a4bb4ead677f 100644
--- a/drivers/gpu/drm/mga/mga_drv.h
+++ b/drivers/gpu/drm/mga/mga_drv.h
@@ -661,7 +661,7 @@ do {									\
 
 /* Simple idle test.
  */
-static __inline__ int mga_is_idle(drm_mga_private_t *dev_priv)
+static inline int mga_is_idle(drm_mga_private_t *dev_priv)
 {
 	u32 status = MGA_READ(MGA_STATUS) & MGA_ENGINE_IDLE_MASK;
 	return (status == MGA_ENDPRDMASTS);
diff --git a/drivers/gpu/drm/mga/mga_state.c b/drivers/gpu/drm/mga/mga_state.c
index e5f6b735f575..67f261c59111 100644
--- a/drivers/gpu/drm/mga/mga_state.c
+++ b/drivers/gpu/drm/mga/mga_state.c
@@ -65,7 +65,7 @@ static void mga_emit_clip_rect(drm_mga_private_t *dev_priv,
 	ADVANCE_DMA();
 }
 
-static __inline__ void mga_g200_emit_context(drm_mga_private_t *dev_priv)
+static inline void mga_g200_emit_context(drm_mga_private_t *dev_priv)
 {
 	drm_mga_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_mga_context_regs_t *ctx = &sarea_priv->context_state;
@@ -88,7 +88,7 @@ static __inline__ void mga_g200_emit_context(drm_mga_private_t *dev_priv)
 	ADVANCE_DMA();
 }
 
-static __inline__ void mga_g400_emit_context(drm_mga_private_t *dev_priv)
+static inline void mga_g400_emit_context(drm_mga_private_t *dev_priv)
 {
 	drm_mga_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_mga_context_regs_t *ctx = &sarea_priv->context_state;
@@ -115,7 +115,7 @@ static __inline__ void mga_g400_emit_context(drm_mga_private_t *dev_priv)
 	ADVANCE_DMA();
 }
 
-static __inline__ void mga_g200_emit_tex0(drm_mga_private_t *dev_priv)
+static inline void mga_g200_emit_tex0(drm_mga_private_t *dev_priv)
 {
 	drm_mga_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_mga_texture_regs_t *tex = &sarea_priv->tex_state[0];
@@ -143,7 +143,7 @@ static __inline__ void mga_g200_emit_tex0(drm_mga_private_t *dev_priv)
 	ADVANCE_DMA();
 }
 
-static __inline__ void mga_g400_emit_tex0(drm_mga_private_t *dev_priv)
+static inline void mga_g400_emit_tex0(drm_mga_private_t *dev_priv)
 {
 	drm_mga_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_mga_texture_regs_t *tex = &sarea_priv->tex_state[0];
@@ -183,7 +183,7 @@ static __inline__ void mga_g400_emit_tex0(drm_mga_private_t *dev_priv)
 	ADVANCE_DMA();
 }
 
-static __inline__ void mga_g400_emit_tex1(drm_mga_private_t *dev_priv)
+static inline void mga_g400_emit_tex1(drm_mga_private_t *dev_priv)
 {
 	drm_mga_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_mga_texture_regs_t *tex = &sarea_priv->tex_state[1];
@@ -222,7 +222,7 @@ static __inline__ void mga_g400_emit_tex1(drm_mga_private_t *dev_priv)
 	ADVANCE_DMA();
 }
 
-static __inline__ void mga_g200_emit_pipe(drm_mga_private_t *dev_priv)
+static inline void mga_g200_emit_pipe(drm_mga_private_t *dev_priv)
 {
 	drm_mga_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	unsigned int pipe = sarea_priv->warp_pipe;
@@ -249,7 +249,7 @@ static __inline__ void mga_g200_emit_pipe(drm_mga_private_t *dev_priv)
 	ADVANCE_DMA();
 }
 
-static __inline__ void mga_g400_emit_pipe(drm_mga_private_t *dev_priv)
+static inline void mga_g400_emit_pipe(drm_mga_private_t *dev_priv)
 {
 	drm_mga_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	unsigned int pipe = sarea_priv->warp_pipe;
diff --git a/drivers/gpu/drm/r128/r128_drv.h b/drivers/gpu/drm/r128/r128_drv.h
index 2de40d276116..ae32a67dec16 100644
--- a/drivers/gpu/drm/r128/r128_drv.h
+++ b/drivers/gpu/drm/r128/r128_drv.h
@@ -417,7 +417,7 @@ do {									\
 #define CCE_PACKET3(pkt, n)		(R128_CCE_PACKET3 |		\
 					 (pkt) | ((n) << 16))
 
-static __inline__ void r128_update_ring_snapshot(drm_r128_private_t *dev_priv)
+static inline void r128_update_ring_snapshot(drm_r128_private_t *dev_priv)
 {
 	drm_r128_ring_buffer_t *ring = &dev_priv->ring;
 	ring->space = (GET_RING_HEAD(dev_priv) - ring->tail) * sizeof(u32);
diff --git a/drivers/gpu/drm/r128/r128_state.c b/drivers/gpu/drm/r128/r128_state.c
index b9bfa806d346..36a6642f485d 100644
--- a/drivers/gpu/drm/r128/r128_state.c
+++ b/drivers/gpu/drm/r128/r128_state.c
@@ -79,7 +79,7 @@ static void r128_emit_clip_rects(drm_r128_private_t *dev_priv,
 	ADVANCE_RING();
 }
 
-static __inline__ void r128_emit_core(drm_r128_private_t *dev_priv)
+static inline void r128_emit_core(drm_r128_private_t *dev_priv)
 {
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_r128_context_regs_t *ctx = &sarea_priv->context_state;
@@ -94,7 +94,7 @@ static __inline__ void r128_emit_core(drm_r128_private_t *dev_priv)
 	ADVANCE_RING();
 }
 
-static __inline__ void r128_emit_context(drm_r128_private_t *dev_priv)
+static inline void r128_emit_context(drm_r128_private_t *dev_priv)
 {
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_r128_context_regs_t *ctx = &sarea_priv->context_state;
@@ -120,7 +120,7 @@ static __inline__ void r128_emit_context(drm_r128_private_t *dev_priv)
 	ADVANCE_RING();
 }
 
-static __inline__ void r128_emit_setup(drm_r128_private_t *dev_priv)
+static inline void r128_emit_setup(drm_r128_private_t *dev_priv)
 {
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_r128_context_regs_t *ctx = &sarea_priv->context_state;
@@ -136,7 +136,7 @@ static __inline__ void r128_emit_setup(drm_r128_private_t *dev_priv)
 	ADVANCE_RING();
 }
 
-static __inline__ void r128_emit_masks(drm_r128_private_t *dev_priv)
+static inline void r128_emit_masks(drm_r128_private_t *dev_priv)
 {
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_r128_context_regs_t *ctx = &sarea_priv->context_state;
@@ -155,7 +155,7 @@ static __inline__ void r128_emit_masks(drm_r128_private_t *dev_priv)
 	ADVANCE_RING();
 }
 
-static __inline__ void r128_emit_window(drm_r128_private_t *dev_priv)
+static inline void r128_emit_window(drm_r128_private_t *dev_priv)
 {
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_r128_context_regs_t *ctx = &sarea_priv->context_state;
@@ -170,7 +170,7 @@ static __inline__ void r128_emit_window(drm_r128_private_t *dev_priv)
 	ADVANCE_RING();
 }
 
-static __inline__ void r128_emit_tex0(drm_r128_private_t *dev_priv)
+static inline void r128_emit_tex0(drm_r128_private_t *dev_priv)
 {
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_r128_context_regs_t *ctx = &sarea_priv->context_state;
@@ -196,7 +196,7 @@ static __inline__ void r128_emit_tex0(drm_r128_private_t *dev_priv)
 	ADVANCE_RING();
 }
 
-static __inline__ void r128_emit_tex1(drm_r128_private_t *dev_priv)
+static inline void r128_emit_tex1(drm_r128_private_t *dev_priv)
 {
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_r128_texture_regs_t *tex = &sarea_priv->tex_state[1];
diff --git a/drivers/gpu/drm/via/via_irq.c b/drivers/gpu/drm/via/via_irq.c
index c96830ccc0ec..02f2a309ea8d 100644
--- a/drivers/gpu/drm/via/via_irq.c
+++ b/drivers/gpu/drm/via/via_irq.c
@@ -152,7 +152,7 @@ irqreturn_t via_driver_irq_handler(int irq, void *arg)
 		return IRQ_NONE;
 }
 
-static __inline__ void viadrv_acknowledge_irqs(drm_via_private_t *dev_priv)
+static inline void viadrv_acknowledge_irqs(drm_via_private_t *dev_priv)
 {
 	u32 status;
 
diff --git a/drivers/gpu/drm/via/via_verifier.c b/drivers/gpu/drm/via/via_verifier.c
index fb2609434df7..400fe11b128d 100644
--- a/drivers/gpu/drm/via/via_verifier.c
+++ b/drivers/gpu/drm/via/via_verifier.c
@@ -235,7 +235,7 @@ static hazard_t table1[256];
 static hazard_t table2[256];
 static hazard_t table3[256];
 
-static __inline__ int
+static inline int
 eat_words(const uint32_t **buf, const uint32_t *buf_end, unsigned num_words)
 {
 	if ((buf_end - *buf) >= num_words) {
@@ -250,7 +250,7 @@ eat_words(const uint32_t **buf, const uint32_t *buf_end, unsigned num_words)
  * Partially stolen from drm_memory.h
  */
 
-static __inline__ drm_local_map_t *via_drm_lookup_agp_map(drm_via_state_t *seq,
+static inline drm_local_map_t *via_drm_lookup_agp_map(drm_via_state_t *seq,
 						    unsigned long offset,
 						    unsigned long size,
 						    struct drm_device *dev)
@@ -287,7 +287,7 @@ static __inline__ drm_local_map_t *via_drm_lookup_agp_map(drm_via_state_t *seq,
  * very little CPU time.
  */
 
-static __inline__ int finish_current_sequence(drm_via_state_t * cur_seq)
+static inline int finish_current_sequence(drm_via_state_t * cur_seq)
 {
 	switch (cur_seq->unfinished) {
 	case z_address:
@@ -344,7 +344,7 @@ static __inline__ int finish_current_sequence(drm_via_state_t * cur_seq)
 	return 0;
 }
 
-static __inline__ int
+static inline int
 investigate_hazard(uint32_t cmd, hazard_t hz, drm_via_state_t *cur_seq)
 {
 	register uint32_t tmp, *tmp_addr;
@@ -517,7 +517,7 @@ investigate_hazard(uint32_t cmd, hazard_t hz, drm_via_state_t *cur_seq)
 	return 2;
 }
 
-static __inline__ int
+static inline int
 via_check_prim_list(uint32_t const **buffer, const uint32_t * buf_end,
 		    drm_via_state_t *cur_seq)
 {
@@ -621,7 +621,7 @@ via_check_prim_list(uint32_t const **buffer, const uint32_t * buf_end,
 	return ret;
 }
 
-static __inline__ verifier_state_t
+static inline verifier_state_t
 via_check_header2(uint32_t const **buffer, const uint32_t *buf_end,
 		  drm_via_state_t *hc_state)
 {
@@ -713,7 +713,7 @@ via_check_header2(uint32_t const **buffer, const uint32_t *buf_end,
 	return state_command;
 }
 
-static __inline__ verifier_state_t
+static inline verifier_state_t
 via_parse_header2(drm_via_private_t *dev_priv, uint32_t const **buffer,
 		  const uint32_t *buf_end, int *fire_count)
 {
@@ -762,7 +762,7 @@ via_parse_header2(drm_via_private_t *dev_priv, uint32_t const **buffer,
 	return state_command;
 }
 
-static __inline__ int verify_mmio_address(uint32_t address)
+static inline int verify_mmio_address(uint32_t address)
 {
 	if ((address > 0x3FF) && (address < 0xC00)) {
 		DRM_ERROR("Invalid VIDEO DMA command. "
@@ -780,7 +780,7 @@ static __inline__ int verify_mmio_address(uint32_t address)
 	return 0;
 }
 
-static __inline__ int
+static inline int
 verify_video_tail(uint32_t const **buffer, const uint32_t * buf_end,
 		  uint32_t dwords)
 {
@@ -800,7 +800,7 @@ verify_video_tail(uint32_t const **buffer, const uint32_t * buf_end,
 	return 0;
 }
 
-static __inline__ verifier_state_t
+static inline verifier_state_t
 via_check_header1(uint32_t const **buffer, const uint32_t * buf_end)
 {
 	uint32_t cmd;
@@ -832,7 +832,7 @@ via_check_header1(uint32_t const **buffer, const uint32_t * buf_end)
 	return ret;
 }
 
-static __inline__ verifier_state_t
+static inline verifier_state_t
 via_parse_header1(drm_via_private_t *dev_priv, uint32_t const **buffer,
 		  const uint32_t *buf_end)
 {
@@ -850,7 +850,7 @@ via_parse_header1(drm_via_private_t *dev_priv, uint32_t const **buffer,
 	return state_command;
 }
 
-static __inline__ verifier_state_t
+static inline verifier_state_t
 via_check_vheader5(uint32_t const **buffer, const uint32_t *buf_end)
 {
 	uint32_t data;
@@ -883,7 +883,7 @@ via_check_vheader5(uint32_t const **buffer, const uint32_t *buf_end)
 
 }
 
-static __inline__ verifier_state_t
+static inline verifier_state_t
 via_parse_vheader5(drm_via_private_t *dev_priv, uint32_t const **buffer,
 		   const uint32_t *buf_end)
 {
@@ -901,7 +901,7 @@ via_parse_vheader5(drm_via_private_t *dev_priv, uint32_t const **buffer,
 	return state_command;
 }
 
-static __inline__ verifier_state_t
+static inline verifier_state_t
 via_check_vheader6(uint32_t const **buffer, const uint32_t * buf_end)
 {
 	uint32_t data;
@@ -938,7 +938,7 @@ via_check_vheader6(uint32_t const **buffer, const uint32_t * buf_end)
 	return state_command;
 }
 
-static __inline__ verifier_state_t
+static inline verifier_state_t
 via_parse_vheader6(drm_via_private_t *dev_priv, uint32_t const **buffer,
 		   const uint32_t *buf_end)
 {
diff --git a/drivers/isdn/hardware/eicon/platform.h b/drivers/isdn/hardware/eicon/platform.h
index 62e2073c3690..ea861c904cd2 100644
--- a/drivers/isdn/hardware/eicon/platform.h
+++ b/drivers/isdn/hardware/eicon/platform.h
@@ -159,7 +159,7 @@ void diva_xdi_didd_remove_adapter(int card);
 /*
 ** memory allocation
 */
-static __inline__ void *diva_os_malloc(unsigned long flags, unsigned long size)
+static inline void *diva_os_malloc(unsigned long flags, unsigned long size)
 {
 	void *ret = NULL;
 
@@ -168,7 +168,7 @@ static __inline__ void *diva_os_malloc(unsigned long flags, unsigned long size)
 	}
 	return (ret);
 }
-static __inline__ void diva_os_free(unsigned long flags, void *ptr)
+static inline void diva_os_free(unsigned long flags, void *ptr)
 {
 	vfree(ptr);
 }
@@ -185,11 +185,11 @@ void diva_os_free_message_buffer(diva_os_message_buffer_s *dmb);
 /*
 ** mSeconds waiting
 */
-static __inline__ void diva_os_sleep(dword mSec)
+static inline void diva_os_sleep(dword mSec)
 {
 	msleep(mSec);
 }
-static __inline__ void diva_os_wait(dword mSec)
+static inline void diva_os_wait(dword mSec)
 {
 	mdelay(mSec);
 }
@@ -233,12 +233,12 @@ void diva_os_remove_irq(void *context, byte irq);
 */
 typedef long diva_os_spin_lock_magic_t;
 typedef spinlock_t diva_os_spin_lock_t;
-static __inline__ int diva_os_initialize_spin_lock(spinlock_t *lock, void *unused) { \
+static inline int diva_os_initialize_spin_lock(spinlock_t *lock, void *unused) { \
 	spin_lock_init(lock); return (0); }
-static __inline__ void diva_os_enter_spin_lock(diva_os_spin_lock_t *a, \
+static inline void diva_os_enter_spin_lock(diva_os_spin_lock_t *a, \
 					       diva_os_spin_lock_magic_t *old_irql, \
 					       void *dbg) { spin_lock_bh(a); }
-static __inline__ void diva_os_leave_spin_lock(diva_os_spin_lock_t *a, \
+static inline void diva_os_leave_spin_lock(diva_os_spin_lock_t *a, \
 					       diva_os_spin_lock_magic_t *old_irql, \
 					       void *dbg) { spin_unlock_bh(a); }
 
diff --git a/drivers/isdn/i4l/isdn_net.c b/drivers/isdn/i4l/isdn_net.c
index c138f66f2659..09d4cb136382 100644
--- a/drivers/isdn/i4l/isdn_net.c
+++ b/drivers/isdn/i4l/isdn_net.c
@@ -70,7 +70,7 @@
  * Find out if the netdevice has been ifup-ed yet.
  * For slaves, look at the corresponding master.
  */
-static __inline__ int isdn_net_device_started(isdn_net_dev *n)
+static inline int isdn_net_device_started(isdn_net_dev *n)
 {
 	isdn_net_local *lp = n->local;
 	struct net_device *dev;
@@ -86,7 +86,7 @@ static __inline__ int isdn_net_device_started(isdn_net_dev *n)
  * wake up the network -> net_device queue.
  * For slaves, wake the corresponding master interface.
  */
-static __inline__ void isdn_net_device_wake_queue(isdn_net_local *lp)
+static inline void isdn_net_device_wake_queue(isdn_net_local *lp)
 {
 	if (lp->master)
 		netif_wake_queue(lp->master);
@@ -98,7 +98,7 @@ static __inline__ void isdn_net_device_wake_queue(isdn_net_local *lp)
  * stop the network -> net_device queue.
  * For slaves, stop the corresponding master interface.
  */
-static __inline__ void isdn_net_device_stop_queue(isdn_net_local *lp)
+static inline void isdn_net_device_stop_queue(isdn_net_local *lp)
 {
 	if (lp->master)
 		netif_stop_queue(lp->master);
@@ -111,7 +111,7 @@ static __inline__ void isdn_net_device_stop_queue(isdn_net_local *lp)
  * master or slave) is busy. It's busy iff all (master and slave)
  * queues are busy
  */
-static __inline__ int isdn_net_device_busy(isdn_net_local *lp)
+static inline int isdn_net_device_busy(isdn_net_local *lp)
 {
 	isdn_net_local *nlp;
 	isdn_net_dev *nd;
@@ -138,14 +138,14 @@ static __inline__ int isdn_net_device_busy(isdn_net_local *lp)
 	return 1;
 }
 
-static __inline__ void isdn_net_inc_frame_cnt(isdn_net_local *lp)
+static inline void isdn_net_inc_frame_cnt(isdn_net_local *lp)
 {
 	atomic_inc(&lp->frame_cnt);
 	if (isdn_net_device_busy(lp))
 		isdn_net_device_stop_queue(lp);
 }
 
-static __inline__ void isdn_net_dec_frame_cnt(isdn_net_local *lp)
+static inline void isdn_net_dec_frame_cnt(isdn_net_local *lp)
 {
 	atomic_dec(&lp->frame_cnt);
 
@@ -158,7 +158,7 @@ static __inline__ void isdn_net_dec_frame_cnt(isdn_net_local *lp)
 	}
 }
 
-static __inline__ void isdn_net_zero_frame_cnt(isdn_net_local *lp)
+static inline void isdn_net_zero_frame_cnt(isdn_net_local *lp)
 {
 	atomic_set(&lp->frame_cnt, 0);
 }
diff --git a/drivers/isdn/i4l/isdn_net.h b/drivers/isdn/i4l/isdn_net.h
index cca6d68da171..5fdff8a0ac8d 100644
--- a/drivers/isdn/i4l/isdn_net.h
+++ b/drivers/isdn/i4l/isdn_net.h
@@ -64,7 +64,7 @@ extern void isdn_net_write_super(isdn_net_local *lp, struct sk_buff *skb);
 /*
  * is this particular channel busy?
  */
-static __inline__ int isdn_net_lp_busy(isdn_net_local *lp)
+static inline int isdn_net_lp_busy(isdn_net_local *lp)
 {
 	if (atomic_read(&lp->frame_cnt) < ISDN_NET_MAX_QUEUE_LENGTH)
 		return 0;
@@ -76,7 +76,7 @@ static __inline__ int isdn_net_lp_busy(isdn_net_local *lp)
  * For the given net device, this will get a non-busy channel out of the
  * corresponding bundle. The returned channel is locked.
  */
-static __inline__ isdn_net_local *isdn_net_get_locked_lp(isdn_net_dev *nd)
+static inline isdn_net_local *isdn_net_get_locked_lp(isdn_net_dev *nd)
 {
 	unsigned long flags;
 	isdn_net_local *lp;
@@ -104,7 +104,7 @@ static __inline__ isdn_net_local *isdn_net_get_locked_lp(isdn_net_dev *nd)
 /*
  * add a channel to a bundle
  */
-static __inline__ void isdn_net_add_to_bundle(isdn_net_dev *nd, isdn_net_local *nlp)
+static inline void isdn_net_add_to_bundle(isdn_net_dev *nd, isdn_net_local *nlp)
 {
 	isdn_net_local *lp;
 	unsigned long flags;
@@ -125,7 +125,7 @@ static __inline__ void isdn_net_add_to_bundle(isdn_net_dev *nd, isdn_net_local *
 /*
  * remove a channel from the bundle it belongs to
  */
-static __inline__ void isdn_net_rm_from_bundle(isdn_net_local *lp)
+static inline void isdn_net_rm_from_bundle(isdn_net_local *lp)
 {
 	isdn_net_local *master_lp = lp;
 	unsigned long flags;
diff --git a/drivers/media/pci/ivtv/ivtv-ioctl.c b/drivers/media/pci/ivtv/ivtv-ioctl.c
index 4cdc6d2be85d..e4e8b38387ec 100644
--- a/drivers/media/pci/ivtv/ivtv-ioctl.c
+++ b/drivers/media/pci/ivtv/ivtv-ioctl.c
@@ -1622,7 +1622,7 @@ static int ivtv_try_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder
 }
 
 #ifdef CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS
-static __inline__ void warn_deprecated_ioctl(const char *name)
+static inline void warn_deprecated_ioctl(const char *name)
 {
 	pr_warn_once("warning: the %s ioctl is deprecated. Don't use it, as it will be removed soon\n",
 		     name);
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index b9221fc1674d..4da7a3ac3c87 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -640,7 +640,7 @@ static int gem_abnormal_irq(struct net_device *dev, struct gem *gp, u32 gem_stat
 	return 0;
 }
 
-static __inline__ void gem_tx(struct net_device *dev, struct gem *gp, u32 gem_status)
+static inline void gem_tx(struct net_device *dev, struct gem *gp, u32 gem_status)
 {
 	int entry, limit;
 
@@ -710,7 +710,7 @@ static __inline__ void gem_tx(struct net_device *dev, struct gem *gp, u32 gem_st
 	}
 }
 
-static __inline__ void gem_post_rxds(struct gem *gp, int limit)
+static inline void gem_post_rxds(struct gem *gp, int limit)
 {
 	int cluster_start, curr, count, kick;
 
@@ -742,7 +742,7 @@ static __inline__ void gem_post_rxds(struct gem *gp, int limit)
 
 #define ALIGNED_RX_SKB_ADDR(addr) \
         ((((unsigned long)(addr) + (64UL - 1UL)) & ~(64UL - 1UL)) - (unsigned long)(addr))
-static __inline__ struct sk_buff *gem_alloc_skb(struct net_device *dev, int size,
+static inline struct sk_buff *gem_alloc_skb(struct net_device *dev, int size,
 						gfp_t gfp_flags)
 {
 	struct sk_buff *skb = alloc_skb(size + 64, gfp_flags);
@@ -988,7 +988,7 @@ static void gem_tx_timeout(struct net_device *dev)
 	gem_schedule_reset(gp);
 }
 
-static __inline__ int gem_intme(int entry)
+static inline int gem_intme(int entry)
 {
 	/* Algorithm: IRQ every 1/2 of descriptors. */
 	if (!(entry & ((TX_RING_SIZE>>1)-1)))
diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index 06da2f59fcbf..1b7c95d17e46 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -108,7 +108,7 @@ struct hme_tx_logent {
 #define TX_LOG_LEN	128
 static struct hme_tx_logent tx_log[TX_LOG_LEN];
 static int txlog_cur_entry;
-static __inline__ void tx_add_log(struct happy_meal *hp, unsigned int a, unsigned int s)
+static inline void tx_add_log(struct happy_meal *hp, unsigned int a, unsigned int s)
 {
 	struct hme_tx_logent *tlp;
 	unsigned long flags;
@@ -123,7 +123,7 @@ static __inline__ void tx_add_log(struct happy_meal *hp, unsigned int a, unsigne
 	txlog_cur_entry = (txlog_cur_entry + 1) & (TX_LOG_LEN - 1);
 	local_irq_restore(flags);
 }
-static __inline__ void tx_dump_log(void)
+static inline void tx_dump_log(void)
 {
 	int i, this;
 
@@ -136,7 +136,7 @@ static __inline__ void tx_dump_log(void)
 		this = (this + 1) & (TX_LOG_LEN - 1);
 	}
 }
-static __inline__ void tx_dump_ring(struct happy_meal *hp)
+static inline void tx_dump_ring(struct happy_meal *hp)
 {
 	struct hmeal_init_block *hb = hp->happy_block;
 	struct happy_meal_txd *tp = &hb->happy_meal_txd[0];
diff --git a/drivers/net/hamradio/baycom_ser_fdx.c b/drivers/net/hamradio/baycom_ser_fdx.c
index 190f66c88479..bd91fb571927 100644
--- a/drivers/net/hamradio/baycom_ser_fdx.c
+++ b/drivers/net/hamradio/baycom_ser_fdx.c
@@ -229,7 +229,7 @@ static inline unsigned int hweight8(unsigned int w)
 
 /* --------------------------------------------------------------------- */
 
-static __inline__ void ser12_rx(struct net_device *dev, struct baycom_state *bc, struct timespec64 *ts, unsigned char curs)
+static inline void ser12_rx(struct net_device *dev, struct baycom_state *bc, struct timespec64 *ts, unsigned char curs)
 {
 	int timediff;
 	int bdus8 = bc->baud_us >> 3;
diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 0e3f8ed84660..84145ec82a36 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -76,7 +76,7 @@ static struct lapbethdev *lapbeth_get_x25_dev(struct net_device *dev)
 	return NULL;
 }
 
-static __inline__ int dev_is_ethdev(struct net_device *dev)
+static inline int dev_is_ethdev(struct net_device *dev)
 {
 	return dev->type == ARPHRD_ETHER && strncmp(dev->name, "dummy", 5);
 }
diff --git a/drivers/net/wan/n2.c b/drivers/net/wan/n2.c
index c8f4517db3a0..45ea8da79fa5 100644
--- a/drivers/net/wan/n2.c
+++ b/drivers/net/wan/n2.c
@@ -148,13 +148,13 @@ static card_t **new_card = &first_card;
 					 &(card)->ports[port] : NULL)
 
 
-static __inline__ u8 sca_get_page(card_t *card)
+static inline u8 sca_get_page(card_t *card)
 {
 	return inb(card->io + N2_PSR) & PSR_PAGEBITS;
 }
 
 
-static __inline__ void openwin(card_t *card, u8 page)
+static inline void openwin(card_t *card, u8 page)
 {
 	u8 psr = inb(card->io + N2_PSR);
 	outb((psr & ~PSR_PAGEBITS) | page, card->io + N2_PSR);
diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 0c6e8b44b4ed..65baa86dbae7 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -349,7 +349,7 @@ static void led_LCD_driver(unsigned char leds)
    ** (analog to dev_get_info() from net/core/dev.c)
    **   
  */
-static __inline__ int led_get_net_activity(void)
+static inline int led_get_net_activity(void)
 { 
 #ifndef CONFIG_NET
 	return 0;
@@ -401,7 +401,7 @@ static __inline__ int led_get_net_activity(void)
    ** calculate if there was disk-io in the system
    **   
  */
-static __inline__ int led_get_diskio_activity(void)
+static inline int led_get_diskio_activity(void)
 {	
 	static unsigned long last_pgpgin, last_pgpgout;
 	unsigned long events[NR_VM_EVENT_ITEMS];
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 11de0eccf968..a7a79aebae17 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -89,7 +89,7 @@
 #define DBG_RES(x...)
 #endif
 
-#define SBA_INLINE	__inline__
+#define SBA_INLINE	inline
 
 #define DEFAULT_DMA_HINT_REG	0
 
diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index 190c0a7a1c52..20dab463e40d 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -76,7 +76,7 @@ static int clear_epp_timeout(struct parport *pb)
  * Access functions.
  *
  * Most of these aren't static because they may be used by the
- * parport_xxx_yyy macros.  extern __inline__ versions of several
+ * parport_xxx_yyy macros.  extern inline versions of several
  * of these are in parport_gsc.h.
  */
 
diff --git a/drivers/parport/parport_gsc.h b/drivers/parport/parport_gsc.h
index 812214768d27..21a3f96806f9 100644
--- a/drivers/parport/parport_gsc.h
+++ b/drivers/parport/parport_gsc.h
@@ -41,13 +41,13 @@
 #define parport_readb	gsc_readb
 #define parport_writeb	gsc_writeb
 #else
-static __inline__ unsigned char parport_readb( unsigned long port )
+static inline unsigned char parport_readb( unsigned long port )
 {
     udelay(DELAY_TIME);
     return gsc_readb(port);
 }
 
-static __inline__ void parport_writeb( unsigned char value, unsigned long port )
+static inline void parport_writeb( unsigned char value, unsigned long port )
 {
     gsc_writeb(value,port);
     udelay(DELAY_TIME);
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 380916bff9e0..c5d3a1053dff 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -225,7 +225,7 @@ static int clear_epp_timeout(struct parport *pb)
  * Access functions.
  *
  * Most of these aren't static because they may be used by the
- * parport_xxx_yyy macros.  extern __inline__ versions of several
+ * parport_xxx_yyy macros.  extern inline versions of several
  * of these are in parport_pc.h.
  */
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 5c7858e735c9..c278783ad59b 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4481,7 +4481,7 @@ lpfc_info(struct Scsi_Host *host)
  * This routine modifies fcp_poll_timer  field of @phba by cfg_poll_tmo.
  * The default value of cfg_poll_tmo is 10 milliseconds.
  **/
-static __inline__ void lpfc_poll_rearm_timer(struct lpfc_hba * phba)
+static inline void lpfc_poll_rearm_timer(struct lpfc_hba * phba)
 {
 	unsigned long  poll_tmo_expires =
 		(jiffies + msecs_to_jiffies(phba->cfg_poll_tmo));
diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index 20011c8afbb5..299963f8d0ac 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -241,7 +241,7 @@ SYM53C500_int_host_reset(int io_port)
 	chip_init(io_port);
 }
 
-static __inline__ int
+static inline int
 SYM53C500_pio_read(int fast_pio, int base, unsigned char *request, unsigned int reqlen)
 {
 	int i;
@@ -296,7 +296,7 @@ SYM53C500_pio_read(int fast_pio, int base, unsigned char *request, unsigned int
 	return 0;
 }
 
-static __inline__ int
+static inline int
 SYM53C500_pio_write(int fast_pio, int base, unsigned char *request, unsigned int reqlen)
 {
 	int i = 0;
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 4351736b2426..d6db2ad8bf57 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -39,7 +39,7 @@ qla24xx_calc_iocbs(scsi_qla_host_t *vha, uint16_t dsds)
  * Returns:
  *      register value.
  */
-static __inline__ uint16_t
+static inline uint16_t
 qla2x00_debounce_register(volatile uint16_t __iomem *addr)
 {
 	volatile uint16_t first;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 42b8f0d3e580..f48f0b8d0b69 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -344,7 +344,7 @@ struct scsi_transport_template *qla2xxx_transport_vport_template = NULL;
  * Timer routines
  */
 
-__inline__ void
+inline void
 qla2x00_start_timer(scsi_qla_host_t *vha, unsigned long interval)
 {
 	timer_setup(&vha->timer, qla2x00_timer, 0);
@@ -366,7 +366,7 @@ qla2x00_restart_timer(scsi_qla_host_t *vha, unsigned long interval)
 	mod_timer(&vha->timer, jiffies + interval * HZ);
 }
 
-static __inline__ void
+static inline void
 qla2x00_stop_timer(scsi_qla_host_t *vha)
 {
 	del_timer_sync(&vha->timer);
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 110bbe340b78..969b93adc214 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -831,12 +831,12 @@ static void pwr_rpwm_timeout_handler(struct timer_list *t)
 	_set_workitem(&pwrpriv->rpwmtimeoutwi);
 }
 
-static __inline void register_task_alive(struct pwrctrl_priv *pwrctrl, u32 tag)
+static inline void register_task_alive(struct pwrctrl_priv *pwrctrl, u32 tag)
 {
 	pwrctrl->alives |= tag;
 }
 
-static __inline void unregister_task_alive(struct pwrctrl_priv *pwrctrl, u32 tag)
+static inline void unregister_task_alive(struct pwrctrl_priv *pwrctrl, u32 tag)
 {
 	pwrctrl->alives &= ~tag;
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 2c65af319a60..de0476f1f23b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -456,7 +456,7 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 	mutex_unlock(&(adapter_to_dvobj(padapter)->setch_mutex));
 }
 
-__inline u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork)
+inline u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork)
 {
 	return pnetwork->MacAddress;
 }
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index c57f290f605a..9a56fc6c2d1e 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -485,7 +485,7 @@ struct dvobj_priv
 #define dvobj_to_pwrctl(dvobj) (&(dvobj->pwrctl_priv))
 #define pwrctl_to_dvobj(pwrctl) container_of(pwrctl, struct dvobj_priv, pwrctl_priv)
 
-__inline static struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
+inline static struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
 {
 	/* todo: get interface type from dvobj and the return the dev accordingly */
 #ifdef RTW_DVOBJ_CHIP_HW_TYPE
@@ -643,14 +643,14 @@ struct adapter {
 
 /* define RTW_DISABLE_FUNC(padapter, func) (atomic_add(&adapter_to_dvobj(padapter)->disable_func, (func))) */
 /* define RTW_ENABLE_FUNC(padapter, func) (atomic_sub(&adapter_to_dvobj(padapter)->disable_func, (func))) */
-__inline static void RTW_DISABLE_FUNC(struct adapter *padapter, int func_bit)
+inline static void RTW_DISABLE_FUNC(struct adapter *padapter, int func_bit)
 {
 	int	df = atomic_read(&adapter_to_dvobj(padapter)->disable_func);
 	df |= func_bit;
 	atomic_set(&adapter_to_dvobj(padapter)->disable_func, df);
 }
 
-__inline static void RTW_ENABLE_FUNC(struct adapter *padapter, int func_bit)
+inline static void RTW_ENABLE_FUNC(struct adapter *padapter, int func_bit)
 {
 	int	df = atomic_read(&adapter_to_dvobj(padapter)->disable_func);
 	df &= ~(func_bit);
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index bcc8dfa8e672..b95ba81036f4 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -850,18 +850,18 @@ enum ieee80211_state {
 #define IP_FMT "%pI4"
 #define IP_ARG(x) (x)
 
-extern __inline int is_multicast_mac_addr(const u8 *addr)
+extern inline int is_multicast_mac_addr(const u8 *addr)
 {
         return ((addr[0] != 0xff) && (0x01 & addr[0]));
 }
 
-extern __inline int is_broadcast_mac_addr(const u8 *addr)
+extern inline int is_broadcast_mac_addr(const u8 *addr)
 {
 	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&   \
 		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
 }
 
-extern __inline int is_zero_mac_addr(const u8 *addr)
+extern inline int is_zero_mac_addr(const u8 *addr)
 {
 	return ((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) &&   \
 		(addr[3] == 0x00) && (addr[4] == 0x00) && (addr[5] == 0x00));
diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index 76d619585046..3a2eb3cbc0e4 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -110,12 +110,12 @@ int _rtw_netif_rx(_nic_hdl ndev, struct sk_buff *skb);
 
 extern void _rtw_init_queue(struct __queue	*pqueue);
 
-static __inline void thread_enter(char *name)
+static inline void thread_enter(char *name)
 {
 	allow_signal(SIGTERM);
 }
 
-__inline static void flush_signals_thread(void)
+inline static void flush_signals_thread(void)
 {
 	if (signal_pending (current))
 	{
@@ -125,7 +125,7 @@ __inline static void flush_signals_thread(void)
 
 #define rtw_warn_on(condition) WARN_ON(condition)
 
-__inline static int rtw_bug_check(void *parg1, void *parg2, void *parg3, void *parg4)
+inline static int rtw_bug_check(void *parg1, void *parg2, void *parg3, void *parg4)
 {
 	int ret = true;
 
@@ -136,7 +136,7 @@ __inline static int rtw_bug_check(void *parg1, void *parg2, void *parg3, void *p
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
 #define RND4(x)	(((x >> 2) + (((x & 3) == 0) ?  0: 1)) << 2)
 
-__inline static u32 _RND4(u32 sz)
+inline static u32 _RND4(u32 sz)
 {
 
 	u32 val;
@@ -147,7 +147,7 @@ __inline static u32 _RND4(u32 sz)
 
 }
 
-__inline static u32 _RND8(u32 sz)
+inline static u32 _RND8(u32 sz)
 {
 
 	u32 val;
diff --git a/drivers/staging/rtl8723bs/include/osdep_service_linux.h b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
index 58d1e1019241..d5ca84b326ec 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service_linux.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
@@ -66,12 +66,12 @@
 
 	typedef struct work_struct _workitem;
 
-__inline static struct list_head *get_next(struct list_head	*list)
+inline static struct list_head *get_next(struct list_head	*list)
 {
 	return list->next;
 }
 
-__inline static struct list_head	*get_list_head(struct __queue	*queue)
+inline static struct list_head	*get_list_head(struct __queue	*queue)
 {
 	return (&(queue->queue));
 }
@@ -80,28 +80,28 @@ __inline static struct list_head	*get_list_head(struct __queue	*queue)
 #define LIST_CONTAINOR(ptr, type, member) \
 	container_of(ptr, type, member)
 
-__inline static void _set_timer(_timer *ptimer, u32 delay_time)
+inline static void _set_timer(_timer *ptimer, u32 delay_time)
 {
 	mod_timer(ptimer , (jiffies+(delay_time*HZ/1000)));
 }
 
-__inline static void _cancel_timer(_timer *ptimer, u8 *bcancelled)
+inline static void _cancel_timer(_timer *ptimer, u8 *bcancelled)
 {
 	del_timer_sync(ptimer);
 	*bcancelled =  true;/* true == 1; false == 0 */
 }
 
-__inline static void _init_workitem(_workitem *pwork, void *pfunc, void *cntx)
+inline static void _init_workitem(_workitem *pwork, void *pfunc, void *cntx)
 {
 	INIT_WORK(pwork, pfunc);
 }
 
-__inline static void _set_workitem(_workitem *pwork)
+inline static void _set_workitem(_workitem *pwork)
 {
 	schedule_work(pwork);
 }
 
-__inline static void _cancel_workitem_sync(_workitem *pwork)
+inline static void _cancel_workitem_sync(_workitem *pwork)
 {
 	cancel_work_sync(pwork);
 }
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index 1ea9ea0e8d2e..80882a05b6fb 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -525,13 +525,13 @@ extern sint rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv);
 extern sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, sint keyid, u8 set_tx, bool enqueue);
 extern sint rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv);
 
-__inline static u8 *get_bssid(struct mlme_priv *pmlmepriv)
+inline static u8 *get_bssid(struct mlme_priv *pmlmepriv)
 {	/* if sta_mode:pmlmepriv->cur_network.network.MacAddress => bssid */
 	/*  if adhoc_mode:pmlmepriv->cur_network.network.MacAddress => ibss mac address */
 	return pmlmepriv->cur_network.network.MacAddress;
 }
 
-__inline static sint check_fwstate(struct mlme_priv *pmlmepriv, sint state)
+inline static sint check_fwstate(struct mlme_priv *pmlmepriv, sint state)
 {
 	if (pmlmepriv->fw_state & state)
 		return true;
@@ -539,7 +539,7 @@ __inline static sint check_fwstate(struct mlme_priv *pmlmepriv, sint state)
 	return false;
 }
 
-__inline static sint get_fwstate(struct mlme_priv *pmlmepriv)
+inline static sint get_fwstate(struct mlme_priv *pmlmepriv)
 {
 	return pmlmepriv->fw_state;
 }
@@ -551,7 +551,7 @@ __inline static sint get_fwstate(struct mlme_priv *pmlmepriv)
  * ### NOTE:#### (!!!!)
  * MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
  */
-__inline static void set_fwstate(struct mlme_priv *pmlmepriv, sint state)
+inline static void set_fwstate(struct mlme_priv *pmlmepriv, sint state)
 {
 	pmlmepriv->fw_state |= state;
 	/* FOR HW integration */
@@ -560,7 +560,7 @@ __inline static void set_fwstate(struct mlme_priv *pmlmepriv, sint state)
 	}
 }
 
-__inline static void _clr_fwstate_(struct mlme_priv *pmlmepriv, sint state)
+inline static void _clr_fwstate_(struct mlme_priv *pmlmepriv, sint state)
 {
 	pmlmepriv->fw_state &= ~state;
 	/* FOR HW integration */
@@ -573,7 +573,7 @@ __inline static void _clr_fwstate_(struct mlme_priv *pmlmepriv, sint state)
  * No Limit on the calling context,
  * therefore set it to be the critical section...
  */
-__inline static void clr_fwstate(struct mlme_priv *pmlmepriv, sint state)
+inline static void clr_fwstate(struct mlme_priv *pmlmepriv, sint state)
 {
 	spin_lock_bh(&pmlmepriv->lock);
 	if (check_fwstate(pmlmepriv, state) == true)
@@ -581,7 +581,7 @@ __inline static void clr_fwstate(struct mlme_priv *pmlmepriv, sint state)
 	spin_unlock_bh(&pmlmepriv->lock);
 }
 
-__inline static void set_scanned_network_val(struct mlme_priv *pmlmepriv, sint val)
+inline static void set_scanned_network_val(struct mlme_priv *pmlmepriv, sint val)
 {
 	spin_lock_bh(&pmlmepriv->lock);
 	pmlmepriv->num_of_scanned = val;
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 1f53c1c7b0da..ca14532df09f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -405,7 +405,7 @@ struct recv_buf *rtw_dequeue_recvbuf (struct __queue *queue);
 
 void rtw_reordering_ctrl_timeout_handler(struct timer_list *t);
 
-__inline static u8 *get_rxmem(union recv_frame *precvframe)
+inline static u8 *get_rxmem(union recv_frame *precvframe)
 {
 	/* always return rx_head... */
 	if (precvframe == NULL)
@@ -414,7 +414,7 @@ __inline static u8 *get_rxmem(union recv_frame *precvframe)
 	return precvframe->u.hdr.rx_head;
 }
 
-__inline static u8 *get_recvframe_data(union recv_frame *precvframe)
+inline static u8 *get_recvframe_data(union recv_frame *precvframe)
 {
 
 	/* alwasy return rx_data */
@@ -425,7 +425,7 @@ __inline static u8 *get_recvframe_data(union recv_frame *precvframe)
 
 }
 
-__inline static u8 *recvframe_pull(union recv_frame *precvframe, sint sz)
+inline static u8 *recvframe_pull(union recv_frame *precvframe, sint sz)
 {
 	/*  rx_data += sz; move rx_data sz bytes  hereafter */
 
@@ -450,7 +450,7 @@ __inline static u8 *recvframe_pull(union recv_frame *precvframe, sint sz)
 
 }
 
-__inline static u8 *recvframe_put(union recv_frame *precvframe, sint sz)
+inline static u8 *recvframe_put(union recv_frame *precvframe, sint sz)
 {
 	/*  rx_tai += sz; move rx_tail sz bytes  hereafter */
 
@@ -479,7 +479,7 @@ __inline static u8 *recvframe_put(union recv_frame *precvframe, sint sz)
 
 
 
-__inline static u8 *recvframe_pull_tail(union recv_frame *precvframe, sint sz)
+inline static u8 *recvframe_pull_tail(union recv_frame *precvframe, sint sz)
 {
 	/*  rmv data from rx_tail (by yitsen) */
 
@@ -503,7 +503,7 @@ __inline static u8 *recvframe_pull_tail(union recv_frame *precvframe, sint sz)
 
 }
 
-__inline static union recv_frame *rxmem_to_recvframe(u8 *rxmem)
+inline static union recv_frame *rxmem_to_recvframe(u8 *rxmem)
 {
 	/* due to the design of 2048 bytes alignment of recv_frame, we can reference the union recv_frame */
 	/* from any given member of recv_frame. */
@@ -513,13 +513,13 @@ __inline static union recv_frame *rxmem_to_recvframe(u8 *rxmem)
 
 }
 
-__inline static sint get_recvframe_len(union recv_frame *precvframe)
+inline static sint get_recvframe_len(union recv_frame *precvframe)
 {
 	return precvframe->u.hdr.len;
 }
 
 
-__inline static s32 translate_percentage_to_dbm(u32 SignalStrengthIndex)
+inline static s32 translate_percentage_to_dbm(u32 SignalStrengthIndex)
 {
 	s32	SignalPower; /*  in dBm. */
 
diff --git a/drivers/staging/rtl8723bs/include/sta_info.h b/drivers/staging/rtl8723bs/include/sta_info.h
index b9df42d0677e..a4817ea9e4a1 100644
--- a/drivers/staging/rtl8723bs/include/sta_info.h
+++ b/drivers/staging/rtl8723bs/include/sta_info.h
@@ -348,7 +348,7 @@ struct	sta_priv {
 };
 
 
-__inline static u32 wifi_mac_hash(u8 *mac)
+inline static u32 wifi_mac_hash(u8 *mac)
 {
         u32 x;
 
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 559bf2606fb7..74d5cf442354 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -347,7 +347,7 @@ enum WIFI_REG_DOMAIN {
 	(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
 )
 
-__inline static int IS_MCAST(unsigned char *da)
+inline static int IS_MCAST(unsigned char *da)
 {
 	if ((*da) & 0x01)
 		return true;
@@ -355,20 +355,20 @@ __inline static int IS_MCAST(unsigned char *da)
 		return false;
 }
 
-__inline static unsigned char * get_ra(unsigned char *pframe)
+inline static unsigned char * get_ra(unsigned char *pframe)
 {
 	unsigned char *ra;
 	ra = GetAddr1Ptr(pframe);
 	return ra;
 }
-__inline static unsigned char * get_ta(unsigned char *pframe)
+inline static unsigned char * get_ta(unsigned char *pframe)
 {
 	unsigned char *ta;
 	ta = GetAddr2Ptr(pframe);
 	return ta;
 }
 
-__inline static unsigned char * get_da(unsigned char *pframe)
+inline static unsigned char * get_da(unsigned char *pframe)
 {
 	unsigned char *da;
 	unsigned int	to_fr_ds	= (GetToDs(pframe) << 1) | GetFrDs(pframe);
@@ -392,7 +392,7 @@ __inline static unsigned char * get_da(unsigned char *pframe)
 }
 
 
-__inline static unsigned char * get_sa(unsigned char *pframe)
+inline static unsigned char * get_sa(unsigned char *pframe)
 {
 	unsigned char *sa;
 	unsigned int	to_fr_ds	= (GetToDs(pframe) << 1) | GetFrDs(pframe);
@@ -415,7 +415,7 @@ __inline static unsigned char * get_sa(unsigned char *pframe)
 	return sa;
 }
 
-__inline static unsigned char * get_hdr_bssid(unsigned char *pframe)
+inline static unsigned char * get_hdr_bssid(unsigned char *pframe)
 {
 	unsigned char *sa = NULL;
 	unsigned int	to_fr_ds	= (GetToDs(pframe) << 1) | GetFrDs(pframe);
@@ -439,7 +439,7 @@ __inline static unsigned char * get_hdr_bssid(unsigned char *pframe)
 }
 
 
-__inline static int IsFrameTypeCtrl(unsigned char *pframe)
+inline static int IsFrameTypeCtrl(unsigned char *pframe)
 {
 	if (WIFI_CTRL_TYPE == GetFrameType(pframe))
 		return true;
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index bdb14a84e5a5..94cb3248bc71 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -223,7 +223,7 @@ struct wlan_bssid_ex {
 	u8  IEs[MAX_IE_SZ];	/* timestamp, beacon interval, and capability information) */
 } __packed;
 
-__inline  static uint get_wlan_bssid_ex_sz(struct wlan_bssid_ex *bss)
+inline  static uint get_wlan_bssid_ex_sz(struct wlan_bssid_ex *bss)
 {
 	return (sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + bss->IELength);
 }
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 34dead614149..c1bd9b74f4d5 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -171,7 +171,7 @@ static inline int serial_paranoia_check(struct serial_state *info,
 #define SER_CTS     (1<<4)
 #define SER_DSR     (1<<3)
 
-static __inline__ void rtsdtr_ctrl(int bits)
+static inline void rtsdtr_ctrl(int bits)
 {
     ciab.pra = ((bits & (SER_RTS | SER_DTR)) ^ (SER_RTS | SER_DTR)) | (ciab.pra & ~(SER_RTS | SER_DTR));
 }
diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index 8c810733df3d..8ccf8b7ee8bb 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -490,7 +490,7 @@ static irqreturn_t ip22zilog_interrupt(int irq, void *dev_id)
 /* A convenient way to quickly get R0 status.  The caller must _not_ hold the
  * port lock, it is acquired here.
  */
-static __inline__ unsigned char ip22zilog_read_channel_status(struct uart_port *port)
+static inline unsigned char ip22zilog_read_channel_status(struct uart_port *port)
 {
 	struct zilog_channel *channel;
 	unsigned char status;
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 72131b5e132e..ec62843a39f4 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -92,7 +92,7 @@ static char *sab82532_version[16] = {
 #define SAB82532_RECV_FIFO_SIZE	32      /* Standard async fifo sizes */
 #define SAB82532_XMIT_FIFO_SIZE	32
 
-static __inline__ void sunsab_tec_wait(struct uart_sunsab_port *up)
+static inline void sunsab_tec_wait(struct uart_sunsab_port *up)
 {
 	int timeout = up->tec_timeout;
 
@@ -100,7 +100,7 @@ static __inline__ void sunsab_tec_wait(struct uart_sunsab_port *up)
 		udelay(1);
 }
 
-static __inline__ void sunsab_cec_wait(struct uart_sunsab_port *up)
+static inline void sunsab_cec_wait(struct uart_sunsab_port *up)
 {
 	int timeout = up->cec_timeout;
 
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index bc7af8b08a72..5c7f1648f54d 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -590,7 +590,7 @@ static irqreturn_t sunzilog_interrupt(int irq, void *dev_id)
 /* A convenient way to quickly get R0 status.  The caller must _not_ hold the
  * port lock, it is acquired here.
  */
-static __inline__ unsigned char sunzilog_read_channel_status(struct uart_port *port)
+static inline unsigned char sunzilog_read_channel_status(struct uart_port *port)
 {
 	struct zilog_channel __iomem *channel;
 	unsigned char status;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 75ebbbf0a1fb..57f74bf7731f 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -181,10 +181,10 @@ static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table);
 /*
  *  Internal routines
  */
-static __inline__ void ywrap_up(struct vc_data *vc, int count);
-static __inline__ void ywrap_down(struct vc_data *vc, int count);
-static __inline__ void ypan_up(struct vc_data *vc, int count);
-static __inline__ void ypan_down(struct vc_data *vc, int count);
+static inline void ywrap_up(struct vc_data *vc, int count);
+static inline void ywrap_down(struct vc_data *vc, int count);
+static inline void ypan_up(struct vc_data *vc, int count);
+static inline void ypan_down(struct vc_data *vc, int count);
 static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int sx,
 			    int dy, int dx, int height, int width, u_int y_break);
 static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
@@ -1442,7 +1442,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	}
 }
 
-static __inline__ void ywrap_up(struct vc_data *vc, int count)
+static inline void ywrap_up(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -1461,7 +1461,7 @@ static __inline__ void ywrap_up(struct vc_data *vc, int count)
 	scrollback_current = 0;
 }
 
-static __inline__ void ywrap_down(struct vc_data *vc, int count)
+static inline void ywrap_down(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -1480,7 +1480,7 @@ static __inline__ void ywrap_down(struct vc_data *vc, int count)
 	scrollback_current = 0;
 }
 
-static __inline__ void ypan_up(struct vc_data *vc, int count)
+static inline void ypan_up(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
@@ -1504,7 +1504,7 @@ static __inline__ void ypan_up(struct vc_data *vc, int count)
 	scrollback_current = 0;
 }
 
-static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
+static inline void ypan_up_redraw(struct vc_data *vc, int t, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -1528,7 +1528,7 @@ static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
 	scrollback_current = 0;
 }
 
-static __inline__ void ypan_down(struct vc_data *vc, int count)
+static inline void ypan_down(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
@@ -1552,7 +1552,7 @@ static __inline__ void ypan_down(struct vc_data *vc, int count)
 	scrollback_current = 0;
 }
 
-static __inline__ void ypan_down_redraw(struct vc_data *vc, int t, int count)
+static inline void ypan_down_redraw(struct vc_data *vc, int t, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
diff --git a/drivers/video/fbdev/ffb.c b/drivers/video/fbdev/ffb.c
index 6b1915872af1..d86911707e54 100644
--- a/drivers/video/fbdev/ffb.c
+++ b/drivers/video/fbdev/ffb.c
@@ -411,7 +411,7 @@ static int ffb_sync(struct fb_info *p)
 	return 0;
 }
 
-static __inline__ void ffb_rop(struct ffb_par *par, u32 rop)
+static inline void ffb_rop(struct ffb_par *par, u32 rop)
 {
 	if (par->rop_cache != rop) {
 		FFBFifo(par, 1);
diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index d7463a2a5d83..de1ee0f5406a 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -270,7 +270,7 @@ MODULE_PARM_DESC(mode,
 #define OPT_INTVAL(opt, name) simple_strtoul(opt + strlen(name) + 1, NULL, 0)
 #define OPT_STRVAL(opt, name) (opt + strlen(name))
 
-static __inline__ char * get_opt_string(const char *this_opt, const char *name)
+static inline char * get_opt_string(const char *this_opt, const char *name)
 {
 	const char *p;
 	int i;
@@ -288,7 +288,7 @@ static __inline__ char * get_opt_string(const char *this_opt, const char *name)
 	return ret;
 }
 
-static __inline__ int get_opt_int(const char *this_opt, const char *name,
+static inline int get_opt_int(const char *this_opt, const char *name,
 				  int *ret)
 {
 	if (!ret)
@@ -301,7 +301,7 @@ static __inline__ int get_opt_int(const char *this_opt, const char *name,
 	return 1;
 }
 
-static __inline__ int get_opt_bool(const char *this_opt, const char *name,
+static inline int get_opt_bool(const char *this_opt, const char *name,
 				   bool *ret)
 {
 	if (!ret)
@@ -907,7 +907,7 @@ static void intelfb_pci_unregister(struct pci_dev *pdev)
  *                       helper functions                      *
  ***************************************************************/
 
-__inline__ int intelfb_var_to_depth(const struct fb_var_screeninfo *var)
+inline int intelfb_var_to_depth(const struct fb_var_screeninfo *var)
 {
 	DBG_MSG("intelfb_var_to_depth: bpp: %d, green.length is %d\n",
 		var->bits_per_pixel, var->green.length);
@@ -923,7 +923,7 @@ __inline__ int intelfb_var_to_depth(const struct fb_var_screeninfo *var)
 }
 
 
-static __inline__ int var_to_refresh(const struct fb_var_screeninfo *var)
+static inline int var_to_refresh(const struct fb_var_screeninfo *var)
 {
 	int xtot = var->xres + var->left_margin + var->right_margin +
 		   var->hsync_len;
diff --git a/drivers/video/fbdev/intelfb/intelfbhw.c b/drivers/video/fbdev/intelfb/intelfbhw.c
index 57aff7450bce..bbd258330f21 100644
--- a/drivers/video/fbdev/intelfb/intelfbhw.c
+++ b/drivers/video/fbdev/intelfb/intelfbhw.c
@@ -1025,7 +1025,7 @@ static int calc_pll_params(int index, int clock, u32 *retm1, u32 *retm2,
 	return 0;
 }
 
-static __inline__ int check_overflow(u32 value, u32 limit,
+static inline int check_overflow(u32 value, u32 limit,
 				     const char *description)
 {
 	if (value > limit) {
diff --git a/drivers/w1/masters/matrox_w1.c b/drivers/w1/masters/matrox_w1.c
index d83d7c99d81d..8bdee261770f 100644
--- a/drivers/w1/masters/matrox_w1.c
+++ b/drivers/w1/masters/matrox_w1.c
@@ -78,7 +78,7 @@ struct matrox_device
  *
  * Port mapping.
  */
-static __inline__ u8 matrox_w1_read_reg(struct matrox_device *dev, u8 reg)
+static inline u8 matrox_w1_read_reg(struct matrox_device *dev, u8 reg)
 {
 	u8 ret;
 
@@ -89,7 +89,7 @@ static __inline__ u8 matrox_w1_read_reg(struct matrox_device *dev, u8 reg)
 	return ret;
 }
 
-static __inline__ void matrox_w1_write_reg(struct matrox_device *dev, u8 reg, u8 val)
+static inline void matrox_w1_write_reg(struct matrox_device *dev, u8 reg, u8 val)
 {
 	writeb(reg, dev->port_index);
 	writeb(val, dev->port_data);
diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index 126155cadfa9..5f324bb0bd13 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -82,18 +82,18 @@ static inline struct coda_inode_info *ITOC(struct inode *inode)
 	return container_of(inode, struct coda_inode_info, vfs_inode);
 }
 
-static __inline__ struct CodaFid *coda_i2f(struct inode *inode)
+static inline struct CodaFid *coda_i2f(struct inode *inode)
 {
 	return &(ITOC(inode)->c_fid);
 }
 
-static __inline__ char *coda_i2s(struct inode *inode)
+static inline char *coda_i2s(struct inode *inode)
 {
 	return coda_f2s(&(ITOC(inode)->c_fid));
 }
 
 /* this will not zap the inode away */
-static __inline__ void coda_flag_inode(struct inode *inode, int flag)
+static inline void coda_flag_inode(struct inode *inode, int flag)
 {
 	struct coda_inode_info *cii = ITOC(inode);
 
diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index 1f41b25ef38b..a0b32934b1e4 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -74,7 +74,7 @@ vxfs_dumpi(struct vxfs_inode_info *vip, ino_t ino)
  *  vxfs_transmod returns a Linux mode_t for a given
  *  VxFS inode structure.
  */
-static __inline__ umode_t
+static inline umode_t
 vxfs_transmod(struct vxfs_inode_info *vip)
 {
 	umode_t			ret = vip->vii_mode & ~VXFS_TYPE_MASK;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 755e256a9103..f399f4a16fc9 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -166,7 +166,7 @@ __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
 
-static __inline__ struct svc_fh *
+static inline struct svc_fh *
 fh_copy(struct svc_fh *dst, struct svc_fh *src)
 {
 	WARN_ON(src->fh_dentry || src->fh_locked);
@@ -182,7 +182,7 @@ fh_copy_shallow(struct knfsd_fh *dst, struct knfsd_fh *src)
 	memcpy(&dst->fh_base, &src->fh_base, src->fh_size);
 }
 
-static __inline__ struct svc_fh *
+static inline struct svc_fh *
 fh_init(struct svc_fh *fhp, int maxsize)
 {
 	memset(fhp, 0, sizeof(*fhp));
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 085db95a3dae..32abaa61ef96 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -26,7 +26,7 @@ typedef __builtin_va_list va_list;
 #endif
 #endif
 
-#define ACPI_INLINE             __inline__
+#define ACPI_INLINE             inline
 
 /* Function name is used for debug output. Non-ANSI, compiler-dependent */
 
diff --git a/include/acpi/platform/acintel.h b/include/acpi/platform/acintel.h
index 626265833a54..fc013efe606d 100644
--- a/include/acpi/platform/acintel.h
+++ b/include/acpi/platform/acintel.h
@@ -22,7 +22,7 @@
 
 #define COMPILER_DEPENDENT_INT64    __int64
 #define COMPILER_DEPENDENT_UINT64   unsigned __int64
-#define ACPI_INLINE                 __inline
+#define ACPI_INLINE                 inline
 
 /*
  * Calling conventions:
diff --git a/include/asm-generic/ide_iops.h b/include/asm-generic/ide_iops.h
index 81dfa3ee5e06..c7028674a03d 100644
--- a/include/asm-generic/ide_iops.h
+++ b/include/asm-generic/ide_iops.h
@@ -6,7 +6,7 @@
 #define __ide_outsw	outsw
 #define __ide_outsl	outsl
 
-static __inline__ void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
+static inline void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
 {
 	while (count--) {
 		*(u16 *)addr = readw(port);
@@ -14,7 +14,7 @@ static __inline__ void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
 	}
 }
 
-static __inline__ void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
+static inline void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
 {
 	while (count--) {
 		*(u32 *)addr = readl(port);
@@ -22,7 +22,7 @@ static __inline__ void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
 	}
 }
 
-static __inline__ void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
+static inline void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
 {
 	while (count--) {
 		writew(*(u16 *)addr, port);
@@ -30,7 +30,7 @@ static __inline__ void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
 	}
 }
 
-static __inline__ void __ide_mm_outsl(void __iomem * port, void *addr, u32 count)
+static inline void __ide_mm_outsl(void __iomem * port, void *addr, u32 count)
 {
 	while (count--) {
 		writel(*(u32 *)addr, port);
diff --git a/include/linux/atalk.h b/include/linux/atalk.h
index 23f805562f4e..257c986f7f40 100644
--- a/include/linux/atalk.h
+++ b/include/linux/atalk.h
@@ -60,7 +60,7 @@ struct ddpehdr {
 	/* And netatalk apps expect to stick the type in themselves */
 };
 
-static __inline__ struct ddpehdr *ddp_hdr(struct sk_buff *skb)
+static inline struct ddpehdr *ddp_hdr(struct sk_buff *skb)
 {
 	return (struct ddpehdr *)skb_transport_header(skb);
 }
@@ -88,7 +88,7 @@ struct elapaarp {
 	__u8	pa_dst_node;
 } __attribute__ ((packed));
 
-static __inline__ struct elapaarp *aarp_hdr(struct sk_buff *skb)
+static inline struct elapaarp *aarp_hdr(struct sk_buff *skb)
 {
 	return (struct elapaarp *)skb_transport_header(skb);
 }
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index fc2b4491ee0a..63583db288e5 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -82,7 +82,7 @@ enum ceph_msg_data_type {
 	CEPH_MSG_DATA_BVECS,	/* data source/destination is a bio_vec array */
 };
 
-static __inline__ bool ceph_msg_data_type_valid(enum ceph_msg_data_type type)
+static inline bool ceph_msg_data_type_valid(enum ceph_msg_data_type type)
 {
 	switch (type) {
 	case CEPH_MSG_DATA_NONE:
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index db192becfec4..8cc282b7386b 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -248,6 +248,8 @@ struct ftrace_likely_data {
 # define __gnu_inline
 #endif
 
+#define asm_volatile(stmt...) asm volatile __inline__(stmt)
+
 /*
  * Force always-inline if the user requests it so via the .config.
  * GCC does not warn about unused static inline functions for
@@ -268,8 +270,6 @@ struct ftrace_likely_data {
 #define inline inline	__attribute__((unused)) notrace __gnu_inline
 #endif
 
-#define __inline__ inline
-#define __inline inline
 #define noinline	__attribute__((noinline))
 
 #ifndef __always_inline
diff --git a/include/linux/hdlc.h b/include/linux/hdlc.h
index 97585d9679f3..c9e58c889548 100644
--- a/include/linux/hdlc.h
+++ b/include/linux/hdlc.h
@@ -74,7 +74,7 @@ static inline struct hdlc_device* dev_to_hdlc(struct net_device *dev)
 	return netdev_priv(dev);
 }
 
-static __inline__ void debug_frame(const struct sk_buff *skb)
+static inline void debug_frame(const struct sk_buff *skb)
 {
 	int i;
 
@@ -101,7 +101,7 @@ int attach_hdlc_protocol(struct net_device *dev, struct hdlc_proto *proto,
 /* May be used by hardware driver to gain control over HDLC device */
 int detach_hdlc_protocol(struct net_device *dev);
 
-static __inline__ __be16 hdlc_type_trans(struct sk_buff *skb,
+static inline __be16 hdlc_type_trans(struct sk_buff *skb,
 					 struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index c759d1cbcedd..76c97154dc81 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -184,7 +184,7 @@ __be32 inet_confirm_addr(struct net *net, struct in_device *in_dev, __be32 dst,
 struct in_ifaddr *inet_ifa_byprefix(struct in_device *in_dev, __be32 prefix,
 				    __be32 mask);
 struct in_ifaddr *inet_lookup_ifaddr_rcu(struct net *net, __be32 addr);
-static __inline__ bool inet_ifa_match(__be32 addr, struct in_ifaddr *ifa)
+static inline bool inet_ifa_match(__be32 addr, struct in_ifaddr *ifa)
 {
 	return !((addr^ifa->ifa_address)&ifa->ifa_mask);
 }
@@ -193,7 +193,7 @@ static __inline__ bool inet_ifa_match(__be32 addr, struct in_ifaddr *ifa)
  *	Check if a mask is acceptable.
  */
  
-static __inline__ bool bad_mask(__be32 mask, __be32 addr)
+static inline bool bad_mask(__be32 mask, __be32 addr)
 {
 	__u32 hmask;
 	if (addr & (mask = ~mask))
@@ -255,14 +255,14 @@ static inline void in_dev_put(struct in_device *idev)
 
 #endif /* __KERNEL__ */
 
-static __inline__ __be32 inet_make_mask(int logmask)
+static inline __be32 inet_make_mask(int logmask)
 {
 	if (logmask)
 		return htonl(~((1U<<(32-logmask))-1));
 	return 0;
 }
 
-static __inline__ int inet_mask_len(__be32 mask)
+static inline int inet_mask_len(__be32 mask)
 {
 	__u32 hmask = ntohl(mask);
 	if (!hmask)
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 397607a0c0eb..a28dc3e22074 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -385,7 +385,7 @@ extern void parport_release(struct pardevice *dev);
  * timeslice is half a second, but it can be adjusted via the /proc
  * interface.
  **/
-static __inline__ int parport_yield(struct pardevice *dev)
+static inline int parport_yield(struct pardevice *dev)
 {
 	unsigned long int timeslip = (jiffies - dev->time);
 	if ((dev->port->waithead == NULL) || (timeslip < dev->timeslice))
@@ -403,7 +403,7 @@ static __inline__ int parport_yield(struct pardevice *dev)
  * parport_claim_or_block(), and the return value is the same as for
  * parport_claim_or_block().
  **/
-static __inline__ int parport_yield_blocking(struct pardevice *dev)
+static inline int parport_yield_blocking(struct pardevice *dev)
 {
 	unsigned long int timeslip = (jiffies - dev->time);
 	if ((dev->port->waithead == NULL) || (timeslip < dev->timeslice))
diff --git a/include/linux/parport_pc.h b/include/linux/parport_pc.h
index 3d6fc576d6a1..ea368c35a5e7 100644
--- a/include/linux/parport_pc.h
+++ b/include/linux/parport_pc.h
@@ -60,7 +60,7 @@ struct parport_pc_via_data
 	u8 viacfg_parport_base;
 };
 
-static __inline__ void parport_pc_write_data(struct parport *p, unsigned char d)
+static inline void parport_pc_write_data(struct parport *p, unsigned char d)
 {
 #ifdef DEBUG_PARPORT
 	printk (KERN_DEBUG "parport_pc_write_data(%p,0x%02x)\n", p, d);
@@ -68,7 +68,7 @@ static __inline__ void parport_pc_write_data(struct parport *p, unsigned char d)
 	outb(d, DATA(p));
 }
 
-static __inline__ unsigned char parport_pc_read_data(struct parport *p)
+static inline unsigned char parport_pc_read_data(struct parport *p)
 {
 	unsigned char val = inb (DATA (p));
 #ifdef DEBUG_PARPORT
@@ -125,7 +125,7 @@ static inline void dump_parport_state (char *str, struct parport *p)
 
 /* __parport_pc_frob_control differs from parport_pc_frob_control in that
  * it doesn't do any extra masking. */
-static __inline__ unsigned char __parport_pc_frob_control (struct parport *p,
+static inline unsigned char __parport_pc_frob_control (struct parport *p,
 							   unsigned char mask,
 							   unsigned char val)
 {
@@ -143,17 +143,17 @@ static __inline__ unsigned char __parport_pc_frob_control (struct parport *p,
 	return ctr;
 }
 
-static __inline__ void parport_pc_data_reverse (struct parport *p)
+static inline void parport_pc_data_reverse (struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x20, 0x20);
 }
 
-static __inline__ void parport_pc_data_forward (struct parport *p)
+static inline void parport_pc_data_forward (struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x20, 0x00);
 }
 
-static __inline__ void parport_pc_write_control (struct parport *p,
+static inline void parport_pc_write_control (struct parport *p,
 						 unsigned char d)
 {
 	const unsigned char wm = (PARPORT_CONTROL_STROBE |
@@ -171,7 +171,7 @@ static __inline__ void parport_pc_write_control (struct parport *p,
 	__parport_pc_frob_control (p, wm, d & wm);
 }
 
-static __inline__ unsigned char parport_pc_read_control(struct parport *p)
+static inline unsigned char parport_pc_read_control(struct parport *p)
 {
 	const unsigned char rm = (PARPORT_CONTROL_STROBE |
 				  PARPORT_CONTROL_AUTOFD |
@@ -181,7 +181,7 @@ static __inline__ unsigned char parport_pc_read_control(struct parport *p)
 	return priv->ctr & rm; /* Use soft copy */
 }
 
-static __inline__ unsigned char parport_pc_frob_control (struct parport *p,
+static inline unsigned char parport_pc_frob_control (struct parport *p,
 							 unsigned char mask,
 							 unsigned char val)
 {
@@ -208,18 +208,18 @@ static __inline__ unsigned char parport_pc_frob_control (struct parport *p,
 	return __parport_pc_frob_control (p, mask, val);
 }
 
-static __inline__ unsigned char parport_pc_read_status(struct parport *p)
+static inline unsigned char parport_pc_read_status(struct parport *p)
 {
 	return inb(STATUS(p));
 }
 
 
-static __inline__ void parport_pc_disable_irq(struct parport *p)
+static inline void parport_pc_disable_irq(struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x10, 0x00);
 }
 
-static __inline__ void parport_pc_enable_irq(struct parport *p)
+static inline void parport_pc_enable_irq(struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x10, 0x10);
 }
diff --git a/include/net/ax25.h b/include/net/ax25.h
index 3f9aea8087e3..cd0bec7a6d4d 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -270,7 +270,7 @@ static inline struct ax25_cb *sk_to_ax25(const struct sock *sk)
 #define ax25_cb_hold(__ax25) \
 	refcount_inc(&((__ax25)->refcount))
 
-static __inline__ void ax25_cb_put(ax25_cb *ax25)
+static inline void ax25_cb_put(ax25_cb *ax25)
 {
 	if (refcount_dec_and_test(&ax25->refcount)) {
 		kfree(ax25->digipeat);
diff --git a/include/net/checksum.h b/include/net/checksum.h
index aef2b2bb6603..e03914ab9197 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -41,7 +41,7 @@ __wsum csum_and_copy_from_user (const void __user *src, void *dst,
 #endif
 
 #ifndef HAVE_CSUM_COPY_USER
-static __inline__ __wsum csum_and_copy_to_user
+static inline __wsum csum_and_copy_to_user
 (const void *src, void __user *dst, int len, __wsum sum, int *err_ptr)
 {
 	sum = csum_partial(src, len, sum);
diff --git a/include/net/dn_nsp.h b/include/net/dn_nsp.h
index 413a15e5339c..771d3943a8f9 100644
--- a/include/net/dn_nsp.h
+++ b/include/net/dn_nsp.h
@@ -144,7 +144,7 @@ struct  srcobj_fmt {
  * numbers used in NSP. Similar in operation to the functions
  * of the same name in TCP.
  */
-static __inline__ int dn_before(__u16 seq1, __u16 seq2)
+static inline int dn_before(__u16 seq1, __u16 seq2)
 {
         seq1 &= 0x0fff;
         seq2 &= 0x0fff;
@@ -153,7 +153,7 @@ static __inline__ int dn_before(__u16 seq1, __u16 seq2)
 }
 
 
-static __inline__ int dn_after(__u16 seq1, __u16 seq2)
+static inline int dn_after(__u16 seq1, __u16 seq2)
 {
         seq1 &= 0x0fff;
         seq2 &= 0x0fff;
@@ -161,23 +161,23 @@ static __inline__ int dn_after(__u16 seq1, __u16 seq2)
         return (int)((seq2 - seq1) & 0x0fff) > 2048;
 }
 
-static __inline__ int dn_equal(__u16 seq1, __u16 seq2)
+static inline int dn_equal(__u16 seq1, __u16 seq2)
 {
         return ((seq1 ^ seq2) & 0x0fff) == 0;
 }
 
-static __inline__ int dn_before_or_equal(__u16 seq1, __u16 seq2)
+static inline int dn_before_or_equal(__u16 seq1, __u16 seq2)
 {
 	return (dn_before(seq1, seq2) || dn_equal(seq1, seq2));
 }
 
-static __inline__ void seq_add(__u16 *seq, __u16 off)
+static inline void seq_add(__u16 *seq, __u16 off)
 {
         (*seq) += off;
         (*seq) &= 0x0fff;
 }
 
-static __inline__ int seq_next(__u16 seq1, __u16 seq2)
+static inline int seq_next(__u16 seq1, __u16 seq2)
 {
 	return dn_equal(seq1 + 1, seq2);
 }
@@ -185,7 +185,7 @@ static __inline__ int seq_next(__u16 seq1, __u16 seq2)
 /*
  * Can we delay the ack ?
  */
-static __inline__ int sendack(__u16 seq)
+static inline int sendack(__u16 seq)
 {
         return (int)((seq & 0x1000) ? 0 : 1);
 }
@@ -193,7 +193,7 @@ static __inline__ int sendack(__u16 seq)
 /*
  * Is socket congested ?
  */
-static __inline__ int dn_congested(struct sock *sk)
+static inline int dn_congested(struct sock *sk)
 {
         return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
 }
diff --git a/include/net/ip.h b/include/net/ip.h
index e44b1a44f67a..0e9cf4a778f9 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -547,7 +547,7 @@ static inline void ip_ipgre_mc_map(__be32 naddr, const unsigned char *broadcast,
 #include <linux/ipv6.h>
 #endif
 
-static __inline__ void inet_reset_saddr(struct sock *sk)
+static inline void inet_reset_saddr(struct sock *sk)
 {
 	inet_sk(sk)->inet_rcv_saddr = inet_sk(sk)->inet_saddr = 0;
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/include/net/ip6_checksum.h b/include/net/ip6_checksum.h
index cca840584c88..27567477dcc6 100644
--- a/include/net/ip6_checksum.h
+++ b/include/net/ip6_checksum.h
@@ -55,7 +55,7 @@ static inline __wsum ip6_gro_compute_pseudo(struct sk_buff *skb, int proto)
 					    skb_gro_len(skb), proto, 0));
 }
 
-static __inline__ __sum16 tcp_v6_check(int len,
+static inline __sum16 tcp_v6_check(int len,
 				   const struct in6_addr *saddr,
 				   const struct in6_addr *daddr,
 				   __wsum base)
diff --git a/include/net/ipx.h b/include/net/ipx.h
index baf090390998..cf89ef92a5f7 100644
--- a/include/net/ipx.h
+++ b/include/net/ipx.h
@@ -47,7 +47,7 @@ struct ipxhdr {
 /* From af_ipx.c */
 extern int sysctl_ipx_pprop_broadcasting;
 
-static __inline__ struct ipxhdr *ipx_hdr(struct sk_buff *skb)
+static inline struct ipxhdr *ipx_hdr(struct sk_buff *skb)
 {
 	return (struct ipxhdr *)skb_transport_header(skb);
 }
@@ -139,7 +139,7 @@ void ipx_proc_exit(void);
 const char *ipx_frame_name(__be16);
 const char *ipx_device_name(struct ipx_interface *intrfc);
 
-static __inline__ void ipxitf_hold(struct ipx_interface *intrfc)
+static inline void ipxitf_hold(struct ipx_interface *intrfc)
 {
 	refcount_inc(&intrfc->refcnt);
 }
@@ -157,18 +157,18 @@ int ipxrtr_route_skb(struct sk_buff *skb);
 struct ipx_route *ipxrtr_lookup(__be32 net);
 int ipxrtr_ioctl(unsigned int cmd, void __user *arg);
 
-static __inline__ void ipxitf_put(struct ipx_interface *intrfc)
+static inline void ipxitf_put(struct ipx_interface *intrfc)
 {
 	if (refcount_dec_and_test(&intrfc->refcnt))
 		ipxitf_down(intrfc);
 }
 
-static __inline__ void ipxrtr_hold(struct ipx_route *rt)
+static inline void ipxrtr_hold(struct ipx_route *rt)
 {
 	        refcount_inc(&rt->refcnt);
 }
 
-static __inline__ void ipxrtr_put(struct ipx_route *rt)
+static inline void ipxrtr_put(struct ipx_route *rt)
 {
 	        if (refcount_dec_and_test(&rt->refcnt))
 			                kfree(rt);
diff --git a/include/net/llc_c_ev.h b/include/net/llc_c_ev.h
index 3948cf111dd0..266275a945b4 100644
--- a/include/net/llc_c_ev.h
+++ b/include/net/llc_c_ev.h
@@ -120,7 +120,7 @@ struct llc_conn_state_ev {
 	u8 cfm_prim;
 };
 
-static __inline__ struct llc_conn_state_ev *llc_conn_ev(struct sk_buff *skb)
+static inline struct llc_conn_state_ev *llc_conn_ev(struct sk_buff *skb)
 {
 	return (struct llc_conn_state_ev *)skb->cb;
 }
@@ -216,7 +216,7 @@ int llc_conn_ev_qlfy_set_status_refuse(struct sock *sk, struct sk_buff *skb);
 int llc_conn_ev_qlfy_set_status_conflict(struct sock *sk, struct sk_buff *skb);
 int llc_conn_ev_qlfy_set_status_rst_done(struct sock *sk, struct sk_buff *skb);
 
-static __inline__ int llc_conn_space(struct sock *sk, struct sk_buff *skb)
+static inline int llc_conn_space(struct sock *sk, struct sk_buff *skb)
 {
 	return atomic_read(&sk->sk_rmem_alloc) + skb->truesize <
 	       (unsigned int)sk->sk_rcvbuf;
diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index df528a623548..27880d1bfd99 100644
--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -85,12 +85,12 @@ static inline struct llc_sock *llc_sk(const struct sock *sk)
 	return (struct llc_sock *)sk;
 }
 
-static __inline__ void llc_set_backlog_type(struct sk_buff *skb, char type)
+static inline void llc_set_backlog_type(struct sk_buff *skb, char type)
 {
 	skb->cb[sizeof(skb->cb) - 1] = type;
 }
 
-static __inline__ char llc_backlog_type(struct sk_buff *skb)
+static inline char llc_backlog_type(struct sk_buff *skb)
 {
 	return skb->cb[sizeof(skb->cb) - 1];
 }
diff --git a/include/net/llc_s_ev.h b/include/net/llc_s_ev.h
index 84db3a59ed28..00439d3e9f5d 100644
--- a/include/net/llc_s_ev.h
+++ b/include/net/llc_s_ev.h
@@ -44,7 +44,7 @@ struct llc_sap_state_ev {
 	struct llc_addr daddr;
 };
 
-static __inline__ struct llc_sap_state_ev *llc_sap_ev(struct sk_buff *skb)
+static inline struct llc_sap_state_ev *llc_sap_ev(struct sk_buff *skb)
 {
 	return (struct llc_sap_state_ev *)skb->cb;
 }
diff --git a/include/net/netrom.h b/include/net/netrom.h
index 5a0714ff500f..1741b7cc8962 100644
--- a/include/net/netrom.h
+++ b/include/net/netrom.h
@@ -123,7 +123,7 @@ struct nr_node {
 #define nr_node_hold(__nr_node) \
 	refcount_inc(&((__nr_node)->refcount))
 
-static __inline__ void nr_node_put(struct nr_node *nr_node)
+static inline void nr_node_put(struct nr_node *nr_node)
 {
 	if (refcount_dec_and_test(&nr_node->refcount)) {
 		kfree(nr_node);
@@ -133,7 +133,7 @@ static __inline__ void nr_node_put(struct nr_node *nr_node)
 #define nr_neigh_hold(__nr_neigh) \
 	refcount_inc(&((__nr_neigh)->refcount))
 
-static __inline__ void nr_neigh_put(struct nr_neigh *nr_neigh)
+static inline void nr_neigh_put(struct nr_neigh *nr_neigh)
 {
 	if (refcount_dec_and_test(&nr_neigh->refcount)) {
 		if (nr_neigh->ax25)
@@ -145,13 +145,13 @@ static __inline__ void nr_neigh_put(struct nr_neigh *nr_neigh)
 
 /* nr_node_lock and nr_node_unlock also hold/put the node's refcounter.
  */
-static __inline__ void nr_node_lock(struct nr_node *nr_node)
+static inline void nr_node_lock(struct nr_node *nr_node)
 {
 	nr_node_hold(nr_node);
 	spin_lock_bh(&nr_node->node_lock);
 }
 
-static __inline__ void nr_node_unlock(struct nr_node *nr_node)
+static inline void nr_node_unlock(struct nr_node *nr_node)
 {
 	spin_unlock_bh(&nr_node->node_lock);
 	nr_node_put(nr_node);
diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c256..b77be632b440 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -44,16 +44,16 @@ void __scm_destroy(struct scm_cookie *scm);
 struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
 
 #ifdef CONFIG_SECURITY_NETWORK
-static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
+static inline void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
 {
 	security_socket_getpeersec_dgram(sock, NULL, &scm->secid);
 }
 #else
-static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
+static inline void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
 { }
 #endif /* CONFIG_SECURITY_NETWORK */
 
-static __inline__ void scm_set_cred(struct scm_cookie *scm,
+static inline void scm_set_cred(struct scm_cookie *scm,
 				    struct pid *pid, kuid_t uid, kgid_t gid)
 {
 	scm->pid  = get_pid(pid);
@@ -62,20 +62,20 @@ static __inline__ void scm_set_cred(struct scm_cookie *scm,
 	scm->creds.gid = gid;
 }
 
-static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
+static inline void scm_destroy_cred(struct scm_cookie *scm)
 {
 	put_pid(scm->pid);
 	scm->pid  = NULL;
 }
 
-static __inline__ void scm_destroy(struct scm_cookie *scm)
+static inline void scm_destroy(struct scm_cookie *scm)
 {
 	scm_destroy_cred(scm);
 	if (scm->fp)
 		__scm_destroy(scm);
 }
 
-static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
+static inline int scm_send(struct socket *sock, struct msghdr *msg,
 			       struct scm_cookie *scm, bool forcecreds)
 {
 	memset(scm, 0, sizeof(*scm));
@@ -110,7 +110,7 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 { }
 #endif /* CONFIG_SECURITY_NETWORK */
 
-static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
+static inline void scm_recv(struct socket *sock, struct msghdr *msg,
 				struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
diff --git a/include/net/udplite.h b/include/net/udplite.h
index 9185e45b997f..747859a3a00f 100644
--- a/include/net/udplite.h
+++ b/include/net/udplite.h
@@ -17,7 +17,7 @@ extern struct udp_table		udplite_table;
 /*
  *	Checksum computation is all in software, hence simpler getfrag.
  */
-static __inline__ int udplite_getfrag(void *from, char *to, int  offset,
+static inline int udplite_getfrag(void *from, char *to, int  offset,
 				      int len, int odd, struct sk_buff *skb)
 {
 	struct msghdr *msg = from;
diff --git a/include/net/x25.h b/include/net/x25.h
index ed1acc3044ac..4cb533479d61 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -242,12 +242,12 @@ struct x25_neigh *x25_get_neigh(struct net_device *);
 void x25_link_free(void);
 
 /* x25_neigh.c */
-static __inline__ void x25_neigh_hold(struct x25_neigh *nb)
+static inline void x25_neigh_hold(struct x25_neigh *nb)
 {
 	refcount_inc(&nb->refcnt);
 }
 
-static __inline__ void x25_neigh_put(struct x25_neigh *nb)
+static inline void x25_neigh_put(struct x25_neigh *nb)
 {
 	if (refcount_dec_and_test(&nb->refcnt))
 		kfree(nb);
@@ -265,12 +265,12 @@ void x25_route_device_down(struct net_device *dev);
 int x25_route_ioctl(unsigned int, void __user *);
 void x25_route_free(void);
 
-static __inline__ void x25_route_hold(struct x25_route *rt)
+static inline void x25_route_hold(struct x25_route *rt)
 {
 	refcount_inc(&rt->refcnt);
 }
 
-static __inline__ void x25_route_put(struct x25_route *rt)
+static inline void x25_route_put(struct x25_route *rt)
 {
 	if (refcount_dec_and_test(&rt->refcnt))
 		kfree(rt);
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 0eb390c205af..2f03fd96dce9 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -903,7 +903,7 @@ static inline bool addr4_match(__be32 a1, __be32 a2, u8 prefixlen)
 	return !((a1 ^ a2) & htonl(~0UL << (32 - prefixlen)));
 }
 
-static __inline__
+static inline
 __be16 xfrm_flowi_sport(const struct flowi *fl, const union flowi_uli *uli)
 {
 	__be16 port;
@@ -930,7 +930,7 @@ __be16 xfrm_flowi_sport(const struct flowi *fl, const union flowi_uli *uli)
 	return port;
 }
 
-static __inline__
+static inline
 __be16 xfrm_flowi_dport(const struct flowi *fl, const union flowi_uli *uli)
 {
 	__be16 port;
@@ -1325,7 +1325,7 @@ static inline int xfrm6_policy_check_reverse(struct sock *sk, int dir,
 }
 #endif
 
-static __inline__
+static inline
 xfrm_address_t *xfrm_flowi_daddr(const struct flowi *fl, unsigned short family)
 {
 	switch (family){
@@ -1337,7 +1337,7 @@ xfrm_address_t *xfrm_flowi_daddr(const struct flowi *fl, unsigned short family)
 	return NULL;
 }
 
-static __inline__
+static inline
 xfrm_address_t *xfrm_flowi_saddr(const struct flowi *fl, unsigned short family)
 {
 	switch (family){
@@ -1349,7 +1349,7 @@ xfrm_address_t *xfrm_flowi_saddr(const struct flowi *fl, unsigned short family)
 	return NULL;
 }
 
-static __inline__
+static inline
 void xfrm_flowi_addr_get(const struct flowi *fl,
 			 xfrm_address_t *saddr, xfrm_address_t *daddr,
 			 unsigned short family)
@@ -1366,7 +1366,7 @@ void xfrm_flowi_addr_get(const struct flowi *fl,
 	}
 }
 
-static __inline__ int
+static inline int
 __xfrm4_state_addr_check(const struct xfrm_state *x,
 			 const xfrm_address_t *daddr, const xfrm_address_t *saddr)
 {
@@ -1376,7 +1376,7 @@ __xfrm4_state_addr_check(const struct xfrm_state *x,
 	return 0;
 }
 
-static __inline__ int
+static inline int
 __xfrm6_state_addr_check(const struct xfrm_state *x,
 			 const xfrm_address_t *daddr, const xfrm_address_t *saddr)
 {
@@ -1388,7 +1388,7 @@ __xfrm6_state_addr_check(const struct xfrm_state *x,
 	return 0;
 }
 
-static __inline__ int
+static inline int
 xfrm_state_addr_check(const struct xfrm_state *x,
 		      const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		      unsigned short family)
@@ -1402,7 +1402,7 @@ xfrm_state_addr_check(const struct xfrm_state *x,
 	return 0;
 }
 
-static __inline__ int
+static inline int
 xfrm_state_addr_flow_check(const struct xfrm_state *x, const struct flowi *fl,
 			   unsigned short family)
 {
diff --git a/include/uapi/linux/atm.h b/include/uapi/linux/atm.h
index 95ebdcf4fe88..a89c6529d0e0 100644
--- a/include/uapi/linux/atm.h
+++ b/include/uapi/linux/atm.h
@@ -215,13 +215,13 @@ struct sockaddr_atmsvc {
 };
 
 
-static __inline__ int atmsvc_addr_in_use(struct sockaddr_atmsvc addr)
+static inline int atmsvc_addr_in_use(struct sockaddr_atmsvc addr)
 {
 	return *addr.sas_addr.prv || *addr.sas_addr.pub;
 }
 
 
-static __inline__ int atmpvc_addr_in_use(struct sockaddr_atmpvc addr)
+static inline int atmpvc_addr_in_use(struct sockaddr_atmpvc addr)
 {
 	return addr.sap_addr.itf || addr.sap_addr.vpi || addr.sap_addr.vci;
 }
diff --git a/include/uapi/linux/atmsap.h b/include/uapi/linux/atmsap.h
index fc052481eae0..97f3699ead0b 100644
--- a/include/uapi/linux/atmsap.h
+++ b/include/uapi/linux/atmsap.h
@@ -155,7 +155,7 @@ struct atm_sap {
 };
 
 
-static __inline__ int blli_in_use(struct atm_blli blli)
+static inline int blli_in_use(struct atm_blli blli)
 {
 	return blli.l2_proto || blli.l3_proto;
 }
diff --git a/include/uapi/linux/map_to_7segment.h b/include/uapi/linux/map_to_7segment.h
index f9ed18134b83..16c89adab225 100644
--- a/include/uapi/linux/map_to_7segment.h
+++ b/include/uapi/linux/map_to_7segment.h
@@ -76,7 +76,7 @@ struct seg7_conversion_map {
 	unsigned char	table[128];
 };
 
-static __inline__ int map_to_seg7(struct seg7_conversion_map *map, int c)
+static inline int map_to_seg7(struct seg7_conversion_map *map, int c)
 {
 	return c >= 0 && c < sizeof(map->table) ? map->table[c] : -EINVAL;
 }
diff --git a/include/uapi/linux/netfilter_arp/arp_tables.h b/include/uapi/linux/netfilter_arp/arp_tables.h
index a2a0927d9bd6..4d733bbaa183 100644
--- a/include/uapi/linux/netfilter_arp/arp_tables.h
+++ b/include/uapi/linux/netfilter_arp/arp_tables.h
@@ -197,7 +197,7 @@ struct arpt_get_entries {
 };
 
 /* Helper functions */
-static __inline__ struct xt_entry_target *arpt_get_target(struct arpt_entry *e)
+static inline struct xt_entry_target *arpt_get_target(struct arpt_entry *e)
 {
 	return (void *)e + e->target_offset;
 }
diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
index 3b86c14ea49d..0c5bf95a8d44 100644
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -191,7 +191,7 @@ struct ebt_entry {
 	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
-static __inline__ struct ebt_entry_target *
+static inline struct ebt_entry_target *
 ebt_get_target(struct ebt_entry *e)
 {
 	return (void *)e + e->target_offset;
diff --git a/include/uapi/linux/netfilter_ipv4/ip_tables.h b/include/uapi/linux/netfilter_ipv4/ip_tables.h
index 6aaeb14bfce1..06c7900e36c4 100644
--- a/include/uapi/linux/netfilter_ipv4/ip_tables.h
+++ b/include/uapi/linux/netfilter_ipv4/ip_tables.h
@@ -219,7 +219,7 @@ struct ipt_get_entries {
 };
 
 /* Helper functions */
-static __inline__ struct xt_entry_target *
+static inline struct xt_entry_target *
 ipt_get_target(struct ipt_entry *e)
 {
 	return (void *)e + e->target_offset;
diff --git a/include/uapi/linux/netfilter_ipv6/ip6_tables.h b/include/uapi/linux/netfilter_ipv6/ip6_tables.h
index 031d0a43bed2..f84464aab65b 100644
--- a/include/uapi/linux/netfilter_ipv6/ip6_tables.h
+++ b/include/uapi/linux/netfilter_ipv6/ip6_tables.h
@@ -259,7 +259,7 @@ struct ip6t_get_entries {
 };
 
 /* Helper functions */
-static __inline__ struct xt_entry_target *
+static inline struct xt_entry_target *
 ip6t_get_target(struct ip6t_entry *e)
 {
 	return (void *)e + e->target_offset;
diff --git a/include/video/newport.h b/include/video/newport.h
index bcbb3d1b6bf9..108bc554c4b8 100644
--- a/include/video/newport.h
+++ b/include/video/newport.h
@@ -426,7 +426,7 @@ static inline unsigned short newport_vc2_get(struct newport_regs *regs,
 #define NCMAP_REGADDR_RREG   0x00000060
 #define NCMAP_PROTOCOL       (0x00008000 | 0x00040000 | 0x00800000)
 
-static __inline__ void newport_cmap_setaddr(struct newport_regs *regs,
+static inline void newport_cmap_setaddr(struct newport_regs *regs,
 					unsigned short addr)
 {
 	regs->set.dcbmode = (NPORT_DMODE_ACMALL | NCMAP_PROTOCOL |
@@ -437,7 +437,7 @@ static __inline__ void newport_cmap_setaddr(struct newport_regs *regs,
 			   NCMAP_REGADDR_PBUF | NPORT_DMODE_W3);
 }
 
-static __inline__ void newport_cmap_setrgb(struct newport_regs *regs,
+static inline void newport_cmap_setrgb(struct newport_regs *regs,
 				       unsigned char red,
 				       unsigned char green,
 				       unsigned char blue)
@@ -450,7 +450,7 @@ static __inline__ void newport_cmap_setrgb(struct newport_regs *regs,
 
 /* Miscellaneous NEWPORT routines. */
 #define BUSY_TIMEOUT 100000
-static __inline__ int newport_wait(struct newport_regs *regs)
+static inline int newport_wait(struct newport_regs *regs)
 {
 	int t = BUSY_TIMEOUT;
 
@@ -460,7 +460,7 @@ static __inline__ int newport_wait(struct newport_regs *regs)
 	return !t;
 }
 
-static __inline__ int newport_bfwait(struct newport_regs *regs)
+static inline int newport_bfwait(struct newport_regs *regs)
 {
 	int t = BUSY_TIMEOUT;
 
@@ -547,7 +547,7 @@ static __inline__ int newport_bfwait(struct newport_regs *regs)
 #define WAYSLOW_DCB_XMAP9_PROTOCOL DCB_CYCLES (12, 12, 0)
 #define R_DCB_XMAP9_PROTOCOL       DCB_CYCLES (2, 1, 3)
 
-static __inline__ void
+static inline void
 xmap9FIFOWait (struct newport_regs *rex)
 {
         rex->set.dcbmode = DCB_XMAP0 | XM9_CRS_FIFO_AVAIL |
@@ -558,7 +558,7 @@ xmap9FIFOWait (struct newport_regs *rex)
 		;
 }
 
-static __inline__ void
+static inline void
 xmap9SetModeReg (struct newport_regs *rex, unsigned int modereg, unsigned int data24, int cfreq)
 {
         if (cfreq > 119)
diff --git a/lib/zstd/mem.h b/lib/zstd/mem.h
index 3a0f34c8706c..739837a59ad6 100644
--- a/lib/zstd/mem.h
+++ b/lib/zstd/mem.h
@@ -27,7 +27,7 @@
 /*-****************************************
 *  Compiler specifics
 ******************************************/
-#define ZSTD_STATIC static __inline __attribute__((unused))
+#define ZSTD_STATIC static inline __attribute__((unused))
 
 /*-**************************************************************
 *  Basic Types
diff --git a/net/appletalk/atalk_proc.c b/net/appletalk/atalk_proc.c
index 8006295f8bd7..6bc7c80a44de 100644
--- a/net/appletalk/atalk_proc.c
+++ b/net/appletalk/atalk_proc.c
@@ -17,7 +17,7 @@
 #include <linux/export.h>
 
 
-static __inline__ struct atalk_iface *atalk_get_interface_idx(loff_t pos)
+static inline struct atalk_iface *atalk_get_interface_idx(loff_t pos)
 {
 	struct atalk_iface *i;
 
@@ -78,7 +78,7 @@ static int atalk_seq_interface_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static __inline__ struct atalk_route *atalk_get_route_idx(loff_t pos)
+static inline struct atalk_route *atalk_get_route_idx(loff_t pos)
 {
 	struct atalk_route *r;
 
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 9b6bc5abe946..822bf45adb73 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1277,7 +1277,7 @@ static int atalk_getname(struct socket *sock, struct sockaddr *uaddr,
 }
 
 #if IS_ENABLED(CONFIG_IPDDP)
-static __inline__ int is_ip_over_ddp(struct sk_buff *skb)
+static inline int is_ip_over_ddp(struct sk_buff *skb)
 {
 	return skb->data[12] == 22;
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 91592fceeaad..8d2fd114f6e2 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -865,7 +865,7 @@ static void neigh_periodic_work(struct work_struct *work)
 	write_unlock_bh(&tbl->lock);
 }
 
-static __inline__ int neigh_max_probes(struct neighbour *n)
+static inline int neigh_max_probes(struct neighbour *n)
 {
 	struct neigh_parms *p = n->parms;
 	return NEIGH_VAR(p, UCAST_PROBES) + NEIGH_VAR(p, APP_PROBES) +
diff --git a/net/core/scm.c b/net/core/scm.c
index b1ff8a441748..d508a27f8552 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -45,7 +45,7 @@
  *	setu(g)id.
  */
 
-static __inline__ int scm_check_creds(struct ucred *creds)
+static inline int scm_check_creds(struct ucred *creds)
 {
 	const struct cred *cred = current_cred();
 	kuid_t uid = make_kuid(cred->user_ns, creds->uid);
diff --git a/net/decnet/dn_nsp_in.c b/net/decnet/dn_nsp_in.c
index 2fb5e055ba25..508bb7a341aa 100644
--- a/net/decnet/dn_nsp_in.c
+++ b/net/decnet/dn_nsp_in.c
@@ -583,7 +583,7 @@ static void dn_nsp_linkservice(struct sock *sk, struct sk_buff *skb)
  * bh_lock_sock() (its already held when this is called) which
  * also allows data and other data to be queued to a socket.
  */
-static __inline__ int dn_queue_skb(struct sock *sk, struct sk_buff *skb, int sig, struct sk_buff_head *queue)
+static inline int dn_queue_skb(struct sock *sk, struct sk_buff *skb, int sig, struct sk_buff_head *queue)
 {
 	int err;
 
diff --git a/net/decnet/dn_nsp_out.c b/net/decnet/dn_nsp_out.c
index a1779de6bd9c..2ed306ce9010 100644
--- a/net/decnet/dn_nsp_out.c
+++ b/net/decnet/dn_nsp_out.c
@@ -529,7 +529,7 @@ void dn_send_conn_conf(struct sock *sk, gfp_t gfp)
 }
 
 
-static __inline__ void dn_nsp_do_disc(struct sock *sk, unsigned char msgflg,
+static inline void dn_nsp_do_disc(struct sock *sk, unsigned char msgflg,
 			unsigned short reason, gfp_t gfp,
 			struct dst_entry *dst,
 			int ddl, unsigned char *dd, __le16 rem, __le16 loc)
diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
index 1c002c0fb712..6b7c61544d76 100644
--- a/net/decnet/dn_route.c
+++ b/net/decnet/dn_route.c
@@ -174,7 +174,7 @@ static void dn_dst_ifdown(struct dst_entry *dst, struct net_device *dev, int how
 	}
 }
 
-static __inline__ unsigned int dn_hash(__le16 src, __le16 dst)
+static inline unsigned int dn_hash(__le16 src, __le16 dst)
 {
 	__u16 tmp = (__u16 __force)(src ^ dst);
 	tmp ^= (tmp >> 3);
diff --git a/net/decnet/dn_table.c b/net/decnet/dn_table.c
index f0710b5d037d..90b5144c20bf 100644
--- a/net/decnet/dn_table.c
+++ b/net/decnet/dn_table.c
@@ -405,7 +405,7 @@ static void dn_rtmsg_fib(int event, struct dn_fib_node *f, int z, u32 tb_id,
 		rtnl_set_sk_err(&init_net, RTNLGRP_DECnet_ROUTE, err);
 }
 
-static __inline__ int dn_hash_dump_bucket(struct sk_buff *skb,
+static inline int dn_hash_dump_bucket(struct sk_buff *skb,
 				struct netlink_callback *cb,
 				struct dn_fib_table *tb,
 				struct dn_zone *dz,
@@ -434,7 +434,7 @@ static __inline__ int dn_hash_dump_bucket(struct sk_buff *skb,
 	return skb->len;
 }
 
-static __inline__ int dn_hash_dump_zone(struct sk_buff *skb,
+static inline int dn_hash_dump_zone(struct sk_buff *skb,
 				struct netlink_callback *cb,
 				struct dn_fib_table *tb,
 				struct dn_zone *dz)
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 4da39446da2d..177e1f9c6bce 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -18,7 +18,7 @@
  *
  *	Fixes:
  *
- *		Alan Cox	:	Added lots of __inline__ to optimise
+ *		Alan Cox	:	Added lots of inline to optimise
  *					the memory usage of all the tiny little
  *					functions.
  *		Alan Cox	:	Dumped the header building experiment.
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 9a4261e50272..35896e9897c1 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -100,7 +100,7 @@ bool ipv6_mod_enabled(void)
 }
 EXPORT_SYMBOL_GPL(ipv6_mod_enabled);
 
-static __inline__ struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
+static inline struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
 {
 	const int offset = sk->sk_prot->obj_size - sizeof(struct ipv6_pinfo);
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index c9c53ade55c3..488a04e188c0 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -111,7 +111,7 @@ static const struct inet6_protocol icmpv6_protocol = {
 };
 
 /* Called with BH disabled */
-static __inline__ struct sock *icmpv6_xmit_lock(struct net *net)
+static inline struct sock *icmpv6_xmit_lock(struct net *net)
 {
 	struct sock *sk;
 
@@ -126,7 +126,7 @@ static __inline__ struct sock *icmpv6_xmit_lock(struct net *net)
 	return sk;
 }
 
-static __inline__ void icmpv6_xmit_unlock(struct sock *sk)
+static inline void icmpv6_xmit_unlock(struct sock *sk)
 {
 	spin_unlock(&sk->sk_lock.slock);
 }
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 28c4aa5078fc..c5165652929a 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -541,7 +541,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static __inline__ void udpv6_err(struct sk_buff *skb,
+static inline void udpv6_err(struct sk_buff *skb,
 				 struct inet6_skb_parm *opt, u8 type,
 				 u8 code, int offset, __be32 info)
 {
@@ -947,7 +947,7 @@ static void udp_v6_early_demux(struct sk_buff *skb)
 	}
 }
 
-static __inline__ int udpv6_rcv(struct sk_buff *skb)
+static inline int udpv6_rcv(struct sk_buff *skb)
 {
 	return __udp6_lib_rcv(skb, &udp_table, IPPROTO_UDP);
 }
diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index db6e0afe3a20..b797138fec8c 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -52,12 +52,12 @@ static void lapb_free_cb(struct lapb_cb *lapb)
 	kfree(lapb);
 }
 
-static __inline__ void lapb_hold(struct lapb_cb *lapb)
+static inline void lapb_hold(struct lapb_cb *lapb)
 {
 	refcount_inc(&lapb->refcnt);
 }
 
-static __inline__ void lapb_put(struct lapb_cb *lapb)
+static inline void lapb_put(struct lapb_cb *lapb)
 {
 	if (refcount_dec_and_test(&lapb->refcnt))
 		lapb_free_cb(lapb);
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 82cb93f66b9b..6d467c8b1d70 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -72,7 +72,7 @@ void llc_set_station_handler(void (*handler)(struct sk_buff *skb))
  *
  *	This function returns which LLC component must handle this PDU.
  */
-static __inline__ int llc_pdu_type(struct sk_buff *skb)
+static inline int llc_pdu_type(struct sk_buff *skb)
 {
 	int type = LLC_DEST_CONN; /* I-PDU or S-PDU type */
 	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 161b0224d6ae..0cbe8de662a6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -389,7 +389,7 @@ our $Attribute	= qr{
 			__weak
 		  }x;
 our $Modifier;
-our $Inline	= qr{inline|__always_inline|noinline|__inline|__inline__};
+our $Inline	= qr{inline|__always_inline|noinline|inline|inline};
 our $Member	= qr{->$Ident|\.$Ident|\[[^]]*\]};
 our $Lval	= qr{$Ident(?:$Member)*};
 
@@ -5782,13 +5782,13 @@ sub process {
 			      "inline keyword should sit between storage class and type\n" . $herecurr);
 		}
 
-# Check for __inline__ and __inline, prefer inline
+# Check for inline and inline, prefer inline
 		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b(__inline__|__inline)\b/) {
+		    $line =~ /\b(inline|inline)\b/) {
 			if (WARN("INLINE",
 				 "plain inline is preferred over $1\n" . $herecurr) &&
 			    $fix) {
-				$fixed[$fixlinenr] =~ s/\b(__inline__|__inline)\b/inline/;
+				$fixed[$fixlinenr] =~ s/\b(inline|inline)\b/inline/;
 
 			}
 		}
diff --git a/scripts/genksyms/keywords.c b/scripts/genksyms/keywords.c
index 9f40bcd17d07..f8cb811cd97d 100644
--- a/scripts/genksyms/keywords.c
+++ b/scripts/genksyms/keywords.c
@@ -14,8 +14,8 @@ static struct resword {
 	{ "__const", CONST_KEYW },
 	{ "__const__", CONST_KEYW },
 	{ "__extension__", EXTENSION_KEYW },
-	{ "__inline", INLINE_KEYW },
-	{ "__inline__", INLINE_KEYW },
+	{ "inline", INLINE_KEYW },
+	{ "inline", INLINE_KEYW },
 	{ "__signed", SIGNED_KEYW },
 	{ "__signed__", SIGNED_KEYW },
 	{ "__typeof", TYPEOF_KEYW },
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 8f0f508a78e9..9caed6640b58 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1569,8 +1569,8 @@ sub dump_function($$) {
     $prototype =~ s/^extern +//;
     $prototype =~ s/^asmlinkage +//;
     $prototype =~ s/^inline +//;
-    $prototype =~ s/^__inline__ +//;
-    $prototype =~ s/^__inline +//;
+    $prototype =~ s/^inline +//;
+    $prototype =~ s/^inline +//;
     $prototype =~ s/^__always_inline +//;
     $prototype =~ s/^noinline +//;
     $prototype =~ s/__init +//;
diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 56f17410fcea..3d1e603fdcfe 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -344,7 +344,7 @@ struct snd_amd7930 {
 static struct snd_amd7930 *amd7930_list;
 
 /* Idle the AMD7930 chip.  The amd->lock is not held.  */
-static __inline__ void amd7930_idle(struct snd_amd7930 *amd)
+static inline void amd7930_idle(struct snd_amd7930 *amd)
 {
 	unsigned long flags;
 
@@ -355,7 +355,7 @@ static __inline__ void amd7930_idle(struct snd_amd7930 *amd)
 }
 
 /* Enable chip interrupts.  The amd->lock is not held.  */
-static __inline__ void amd7930_enable_ints(struct snd_amd7930 *amd)
+static inline void amd7930_enable_ints(struct snd_amd7930 *amd)
 {
 	unsigned long flags;
 
@@ -366,7 +366,7 @@ static __inline__ void amd7930_enable_ints(struct snd_amd7930 *amd)
 }
 
 /* Disable chip interrupts.  The amd->lock is not held.  */
-static __inline__ void amd7930_disable_ints(struct snd_amd7930 *amd)
+static inline void amd7930_disable_ints(struct snd_amd7930 *amd)
 {
 	unsigned long flags;
 
