Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178A8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C221C20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C221C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeH3LUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:20:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:55754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727416AbeH3LUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52287AEFE;
        Thu, 30 Aug 2018 07:19:52 +0000 (UTC)
Date:   Thu, 30 Aug 2018 09:19:51 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: efi boot failures due to PTI with 32 bit builds and Intel CPUs
Message-ID: <20180830071951.dv6wgnn6ikfhh7yt@suse.de>
References: <20180829201659.GA29801@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829201659.GA29801@roeck-us.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Guenter,

On Wed, Aug 29, 2018 at 01:16:59PM -0700, Guenter Roeck wrote:
> I see boot failures on mainline when trying to boot x86 images with an efi
> bios on Intel CPUs in qemu. Behavior is quite unusual: qemu dies silently
> after the kernel displays "Run /sbin/init as init process". With debugging
> enabled, qemu reports a CR3 update followed by a triple fault.
> Here is the end of the log file:
> 
> ----------------
> IN:
> 0xc75f1d1a:  66 90                    nop
> 0xc75f1d1c:  0f 20 d8                 movl     %cr3, %eax
> 0xc75f1d1f:  0d 00 10 00 00           orl      $0x1000, %eax
> 0xc75f1d24:  0f 22 d8                 movl     %eax, %cr3
> 
> CR3 update: CR3=0e39b000

Thanks for the bug report, from a quick glance it looks like the kernel
is switching to an empty page-table. But I need to debug that further.

> qemu-system-i386 -kernel arch/x86/boot/bzImage -M q35 -cpu core2duo \
> 	-no-reboot -m 256 \
> 	-bios OVMF-pure-efi-32.fd \
> 	-usb -device usb-storage,drive=d0 \
> 	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
> 	--append 'root=/dev/sda rw rootwait mem=256M console=ttyS0 console=tty noreboot' \
> 	-nographic

Can you please provide the exact OVMF-pure-efi-32.fd image and the
.config of the kernel?

Thanks a lot,

       Joerg
