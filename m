Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F17C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317F92075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bFPKnxaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317F92075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeKTGfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:35:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46346 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbeKTGfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:35:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so14289884pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 12:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=gESZYH9uiBuTpB4Wq0Lob5Bt7Wx29khIhQqa01TkGDg=;
        b=bFPKnxaBTM0vaQcV98BkEz6gOgVil5ECTGfem5a5sSbKk03HFxS9KG/2qc8z9kYsc7
         Qmb7A/DEYpvtPclbv4569i59LM/fiVJT5PX7GdlwXzcsfk3OM4lCMoHMN+V6CZiPBpvO
         8wkhqExAiWaGuD+YHH7s/XTQ1fM0nSRUujCN1eO1w2ClFFGuxx+2+lJyL8ku2cgXkESH
         BSGvxvAL9qvOPRIpSK4iLTeaQto3fVSEttYIcTLr9xCdC3CnOoi2ki0nx1UR7aHRD2kl
         pY2CXENwlQqi31U7qmoEJjG2aKiM+v+i0gi02SLfbRYPCaJlHBPi1nC+jyj8KanQ1MRK
         jmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gESZYH9uiBuTpB4Wq0Lob5Bt7Wx29khIhQqa01TkGDg=;
        b=jNV3f8Y/qfe4CFO7knvb1oaytJGMscrK0ConAdOulGRHyty9Sx96iuzv4rdIVl0Rk3
         veoUK4Cen6yZWGUU0Y5QcZ6bmV6TbjKuTnUcg+wjMptobKQ1i9Z0+x4/6CMfPQ7GKkF9
         Aj97pqepyJJkupMhSJrA8lz2hKDKSApj2N8FwZl3Jq1bEV3oQyscE+DNwbGbL+nXhyYF
         rJL7U7/UzZZcpC4gZf9m5d5hUjJb8PfmVZ0iMLlXBuOv2lmdW/ICTR1Wtswjvw/4DUEM
         cOe5f69ITRI1M68Wf9AvaMsAkp1rLheZGZ8Ca9fSKpR5IbbFslIn8Ar2aO0Vp2NMRh8y
         ozSg==
X-Gm-Message-State: AA+aEWY6JKJq6+TNFb8j/rEUeGmYs0UDmm097j7qHUMpt4r5eGvuzBNM
        Z0XyIpmd9UR3GK6+20I8E6Us8A==
X-Google-Smtp-Source: AFSGD/XPoc0UFoFzE79tPFfK5JxXElpTAqQjQbRxXNl9Gdl1M8B7JHEzoFcHyVxNlw75uJACXLGp+w==
X-Received: by 2002:a65:534b:: with SMTP id w11mr12021136pgr.125.1542658201074;
        Mon, 19 Nov 2018 12:10:01 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h7sm40028851pfa.105.2018.11.19.12.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 12:10:00 -0800 (PST)
Date:   Mon, 19 Nov 2018 12:10:00 -0800 (PST)
X-Google-Original-Date: Mon, 19 Nov 2018 12:09:55 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Build flat and compressed kernel images
In-Reply-To: <CAAhSdy3+w7xQ9=VdqvKa7HZX3FbcAbu4nJ0zXSKi9-4U0_2cNQ@mail.gmail.com>
CC:     aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-76297324-9bc5-47a8-8be2-73cc11e38138@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 19:32:04 PST (-0800), anup@brainfault.org wrote:
> On Sat, Nov 17, 2018 at 2:43 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Sun, 11 Nov 2018 21:55:15 PST (-0800), anup@brainfault.org wrote:
>> > This patch extends Linux RISC-V build system to build and install:
>> > Image - Flat uncompressed kernel image
>> > Image.gz - Flat and GZip compressed kernel image
>> >
>> > Quiet a few bootloaders (such as Uboot, UEFI, etc) are capable of
>> > booting flat and compressed kernel images. In case of Uboot, booting
>> > Image or Image.gz is achieved using bootm command.
>> >
>> > The flat and uncompressed kernel image (i.e. Image) is very useful
>> > in pre-silicon developent and testing because we can create back-door
>> > HEX files for RAM on FPGAs from Image.
>> >
>> > Signed-off-by: Anup Patel <anup@brainfault.org>
>> > ---
>> >  arch/riscv/Makefile             | 15 ++++++++-
>> >  arch/riscv/boot/.gitignore      |  2 ++
>> >  arch/riscv/boot/Makefile        | 33 ++++++++++++++++++
>> >  arch/riscv/boot/install.sh      | 60 +++++++++++++++++++++++++++++++++
>> >  arch/riscv/kernel/head.S        | 10 ++++++
>> >  arch/riscv/kernel/vmlinux.lds.S |  2 +-
>> >  6 files changed, 120 insertions(+), 2 deletions(-)
>> >  create mode 100644 arch/riscv/boot/.gitignore
>> >  create mode 100644 arch/riscv/boot/Makefile
>> >  create mode 100644 arch/riscv/boot/install.sh
>> >
>> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>> > index d10146197533..d117a60362eb 100644
>> > --- a/arch/riscv/Makefile
>> > +++ b/arch/riscv/Makefile
>> > @@ -71,10 +71,23 @@ KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
>> >  # arch specific predefines for sparse
>> >  CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
>> >
>> > +# Default target when executing plain make
>> > +boot         := arch/riscv/boot
>> > +KBUILD_IMAGE := $(boot)/Image.gz
>> > +
>> >  head-y := arch/riscv/kernel/head.o
>> >
>> >  core-y += arch/riscv/kernel/ arch/riscv/mm/
>> >
>> >  libs-y += arch/riscv/lib/
>> >
>> > -all: vmlinux
>> > +all: Image.gz
>> > +
>> > +Image: vmlinux
>> > +     $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>> > +
>> > +Image.%: Image
>> > +     $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>> > +
>> > +zinstall install:
>> > +     $(Q)$(MAKE) $(build)=$(boot) $@
>> > diff --git a/arch/riscv/boot/.gitignore b/arch/riscv/boot/.gitignore
>> > new file mode 100644
>> > index 000000000000..8dab0bb6ae66
>> > --- /dev/null
>> > +++ b/arch/riscv/boot/.gitignore
>> > @@ -0,0 +1,2 @@
>> > +Image
>> > +Image.gz
>> > diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
>> > new file mode 100644
>> > index 000000000000..0990a9fdbe5d
>> > --- /dev/null
>> > +++ b/arch/riscv/boot/Makefile
>> > @@ -0,0 +1,33 @@
>> > +#
>> > +# arch/riscv/boot/Makefile
>> > +#
>> > +# This file is included by the global makefile so that you can add your own
>> > +# architecture-specific flags and dependencies.
>> > +#
>> > +# This file is subject to the terms and conditions of the GNU General Public
>> > +# License.  See the file "COPYING" in the main directory of this archive
>> > +# for more details.
>> > +#
>> > +# Copyright (C) 2018, Anup Patel.
>> > +# Author: Anup Patel <anup@brainfault.org>
>> > +#
>> > +# Based on the ia64 and arm64 boot/Makefile.
>> > +#
>> > +
>> > +OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
>> > +
>> > +targets := Image
>> > +
>> > +$(obj)/Image: vmlinux FORCE
>> > +     $(call if_changed,objcopy)
>> > +
>> > +$(obj)/Image.gz: $(obj)/Image FORCE
>> > +     $(call if_changed,gzip)
>> > +
>> > +install:
>> > +     $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
>> > +     $(obj)/Image System.map "$(INSTALL_PATH)"
>> > +
>> > +zinstall:
>> > +     $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
>> > +     $(obj)/Image.gz System.map "$(INSTALL_PATH)"
>> > diff --git a/arch/riscv/boot/install.sh b/arch/riscv/boot/install.sh
>> > new file mode 100644
>> > index 000000000000..18c39159c0ff
>> > --- /dev/null
>> > +++ b/arch/riscv/boot/install.sh
>> > @@ -0,0 +1,60 @@
>> > +#!/bin/sh
>> > +#
>> > +# arch/riscv/boot/install.sh
>> > +#
>> > +# This file is subject to the terms and conditions of the GNU General Public
>> > +# License.  See the file "COPYING" in the main directory of this archive
>> > +# for more details.
>> > +#
>> > +# Copyright (C) 1995 by Linus Torvalds
>> > +#
>> > +# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
>> > +# Adapted from code in arch/i386/boot/install.sh by Russell King
>> > +#
>> > +# "make install" script for the RISC-V Linux port
>> > +#
>> > +# Arguments:
>> > +#   $1 - kernel version
>> > +#   $2 - kernel image file
>> > +#   $3 - kernel map file
>> > +#   $4 - default install path (blank if root directory)
>> > +#
>> > +
>> > +verify () {
>> > +     if [ ! -f "$1" ]; then
>> > +             echo ""                                                   1>&2
>> > +             echo " *** Missing file: $1"                              1>&2
>> > +             echo ' *** You need to run "make" before "make install".' 1>&2
>> > +             echo ""                                                   1>&2
>> > +             exit 1
>> > +     fi
>> > +}
>> > +
>> > +# Make sure the files actually exist
>> > +verify "$2"
>> > +verify "$3"
>> > +
>> > +# User may have a custom install script
>> > +if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
>> > +if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
>> > +
>> > +if [ "$(basename $2)" = "Image.gz" ]; then
>> > +# Compressed install
>> > +  echo "Installing compressed kernel"
>> > +  base=vmlinuz
>> > +else
>> > +# Normal install
>> > +  echo "Installing normal kernel"
>> > +  base=vmlinux
>> > +fi
>> > +
>> > +if [ -f $4/$base-$1 ]; then
>> > +  mv $4/$base-$1 $4/$base-$1.old
>> > +fi
>> > +cat $2 > $4/$base-$1
>> > +
>> > +# Install system map file
>> > +if [ -f $4/System.map-$1 ]; then
>> > +  mv $4/System.map-$1 $4/System.map-$1.old
>> > +fi
>> > +cp $3 $4/System.map-$1
>> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> > index 711190d473d4..fe884cd69abd 100644
>> > --- a/arch/riscv/kernel/head.S
>> > +++ b/arch/riscv/kernel/head.S
>> > @@ -44,6 +44,16 @@ ENTRY(_start)
>> >       amoadd.w a3, a2, (a3)
>> >       bnez a3, .Lsecondary_start
>> >
>> > +     /* Clear BSS for flat non-ELF images */
>> > +     la a3, __bss_start
>> > +     la a4, __bss_stop
>> > +     ble a4, a3, clear_bss_done
>> > +clear_bss:
>> > +     REG_S zero, (a3)
>> > +     add a3, a3, RISCV_SZPTR
>> > +     blt a3, a4, clear_bss
>> > +clear_bss_done:
>> > +
>> >       /* Save hart ID and DTB physical address */
>> >       mv s0, a0
>> >       mv s1, a1
>> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
>> > index ece84991609c..65df1dfdc303 100644
>> > --- a/arch/riscv/kernel/vmlinux.lds.S
>> > +++ b/arch/riscv/kernel/vmlinux.lds.S
>> > @@ -74,7 +74,7 @@ SECTIONS
>> >               *(.sbss*)
>> >       }
>> >
>> > -     BSS_SECTION(0, 0, 0)
>> > +     BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
>>
>> What does this do?
>
> If bootloader is loading vmlinux ELF then it will take care of
> zeroing BSS and SBSS section.
>
> If we have FLAT image then the head.S has to zero-out BSS
> and SBSS on boot HART. The secondary/non-boot HART
> don't need to clear BSS and SBSS.
>
> Now with BSS_SECTION(0, 0, 0), there is no alignment
> constraint on start of BSS and SBSS section so the BSS
> zeroing code in head.S has handle unaligned BSS and
> SBSS (i.e. not aligned to XLEN / 8 bytes). To simplify, I have
> made BSS and SBSS start as page aligned and put a simple
> assembly code in head.S to zero-out BSS and SBSS.
>
> Of course, we can also use BSS_SECTION(16, 16, 0)
> but I thought of avoiding magic values and made it
> page aligned (like few other architectures).

Makes sense, at least for now.  We might want to default to alignment to a 
larger alignment (2MiB on rv64i, 4MiB on rv32i) at some point, but that's a 
larger discussion.

I've already queued this up for this week's PR, which I'll tag as soon as I 
managed to get through my email :)

>
>>
>> >
>> >       EXCEPTION_TABLE(0x10)
>> >       NOTES
>>
>> Thanks!  I'm going to target this for the RCs as well: it's technically a new
>> feature, but it seems pretty safe -- assuming the BSS_SECTION change can be
>> explained to me :)
>
> Thanks,
> Anup
