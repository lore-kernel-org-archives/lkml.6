Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55BB20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="CzwUsnf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfBKKIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:08:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48742 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKKIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:08:09 -0500
Received: from zn.tnic (p200300EC2BC7A100B5A7B0033B3D5267.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:a100:b5a7:b003:3b3d:5267])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3F531EC02FF;
        Mon, 11 Feb 2019 11:08:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549879687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sz9MQYH23DdzPuuS1RgkT18s4Bao/7xMzJpz+5hOS3w=;
        b=CzwUsnf5TyUmgL4naHKSNnRcWbLkF1vBGkAdNHEQzu8DIZ5JotKRfpPAMCwIv3/aif9RKY
        KmlsvpKmA+coDJ2bHhKX8PAz1yMxxH/8yKREfguAd1sDoe87HyuTmzJ96vqgzwLqg7HYBJ
        prsawVA4yRF7Ez/plKiJ4/OQKbMwwRo=
Date:   Mon, 11 Feb 2019 11:08:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mingo@redhat.com, thomas.lendacky@amd.com,
        yamada.masahiro@socionext.com, caoj.fnst@cn.fujitsu.com,
        jgross@suse.com, mingo@kernel.org, keescook@chromium.org,
        x86@kernel.org, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190211100800.GA19041@zn.tnic>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
 <20190211093033.GA1651@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211093033.GA1651@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:30:33PM +0800, Chao Fan wrote:
> Yes, I download your ovmf file in linux-build-test/rootfs/firmware/ from
> your link. There are two files, efi32 and efi64. Then I try to run:

You need both OVMF-pure-efi-32.fd and rootfs.squashfs from the repo. And
then this works here. Just put the script below and the two files in a
directory and point to the kernel where you're building with -kernel.

---
#!/bin/bash

qemu-system-x86_64 -kernel ~/kernel/linux/arch/x86/boot/bzImage -M q35 -cpu SandyBridge \
        -no-reboot -snapshot -smp 1 \
        -gdb tcp::1235 \
        -bios OVMF-pure-efi-32.fd \
        -m 1G \
        -net nic,model=rtl8139,macaddr=12:34:56:78:12:34 \
        -usb -device usb-storage,drive=d0 \
        -drive file=rootfs.squashfs,if=none,id=d0,format=raw \
        --append 'earlycon=uart8250,io,0x3f8,9600n8 root=/dev/sda rootwait panic=-1 earlyprintk=ttyS0,115200,keep console=ttyS0,115200' \
        -monitor pty \
        -serial file:log

I've added some options for debugging.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
