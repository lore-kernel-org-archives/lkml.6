Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D086C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407572086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfBUBra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:47:30 -0500
Received: from ozlabs.org ([203.11.71.1]:37979 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfBUBra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:47:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444cmG48S0z9s5c;
        Thu, 21 Feb 2019 12:47:26 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 00/16] powerpc/32: Use BATs/LTLBs for STRICT_KERNEL_RWX
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
Date:   Thu, 21 Feb 2019 12:47:26 +1100
Message-ID: <87mumpx68h.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this serie is to:
> - use BATs with STRICT_KERNEL_RWX on book3s (See patch 13 for details.)
> - use LTLBs with STRICT_KERNEL_RWX on 8xx (See patch 15 for a few details.)

This doesn't boot qemu-mac99 for me:

  spawn ~/src/qemu/ppc-softmmu/qemu-system-ppc -nographic -vga none -M mac99 -m 1G -kernel build/vmlinux -initrd ppc32-initrd.gz -append console=ttyPZ0 init=/bin/sh
  >> =============================================================
  >> OpenBIOS 1.1 [Feb 15 2019 10:05]
  >> Configuration device id QEMU version 1 machine id 1
  >> CPUs: 1
  >> Memory: 1024M
  >> UUID: 00000000-0000-0000-0000-000000000000
  >> CPU type PowerPC,G4
  milliseconds isn't unique.
  Welcome to OpenBIOS v1.1 built on Feb 15 2019 10:05
  >> [ppc] Kernel already loaded (0x01000000 + 0x00c2c338) (initrd 0x01d2d000 + 0x007e72f0)
  >> [ppc] Kernel command line: console=ttyPZ0 init=/bin/sh
  >> switching to new context:
  OF stdout device is: /pci@f2000000/mac-io@c/escc@13000/ch-a@13020
  Preparing to boot Linux version 5.0.0-rc2-gcc-8.2.0-00125-g4fcb83ca7936 (michael@ka4) (gcc version 8.2.0 (Buildroot 2018.11-rc2-00003-ga0787e9)) #724 Thu Feb 21 12:03:14 AEDT 2019
  Detected machine type: 00000400
  command line: 
  memory layout at init:
    memory_limit : 00000000 (16 MB aligned)
    alloc_bottom : 02515000
    alloc_top    : 30000000
    alloc_top_hi : 40000000
    rmo_top      : 30000000
    ram_top      : 40000000
  copying OF device tree...
  Building dt strings...
  Building dt structure...
  Device tree strings 0x02516000 -> 0x025150a4
  Device tree struct  0x02517000 -> 0x3fde7eb0
  Quiescing Open Firmware ...
  Booting Linux via __start() @ 0x01000000 ...
  FAIL! Booting BE pmac32


That's pmac32 defconfig ish.
I haven't had time to debug it further sorry.

cheers
