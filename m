Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B52C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501CF2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO1q8Qns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfBHTCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:02:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44003 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfBHTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:02:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so1888938plb.10;
        Fri, 08 Feb 2019 11:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tBaN6rwcUyegXem1W7N2lFI0+WKK7Yu7nN9Nn5qD7y0=;
        b=PO1q8Qns0UrPvSyX8uEypkTJxzQV4CVTCvf7q+ducXdh5egJXfIwP6U/GgeqwaybK7
         f8m7Z+47THzkXHqo7MRBw8rin4UGEbsZlpWqXkJdlAqBEs1Cb7iU097d1creJgpZcx7u
         kLGgr9uPgEi9wQ6LkcmAf0HJtvXVdTUyFS2nkK9DSmW4WpAQgue7FsarxwAtV2s88/Vr
         zDkycNqUAjSFuqrCnNCKdHzbHptU9OOB9ihtyijzi43dGAl7DsxtDJ2iQt1g9lTdk5D1
         1L00c6tiN59jSJPnwuLxgl1JcBKODw/nU8X0tB4PWUdyNU3QOyuksVwKmEfj0QEw5cAF
         RTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tBaN6rwcUyegXem1W7N2lFI0+WKK7Yu7nN9Nn5qD7y0=;
        b=SCXYezCM95nFU0syVCZWJ/2ic1SXo2ZkhDZ/fxuEfbDZ0B9TciooPnzf9GLEPajJqO
         Z9WQS7XKJVcdyiz8p42qsy0bcN7Az82mMjwJGvxYRQquZNb4F5cCYHTHLE0Xi/w0U+TF
         nvhmWFXMCQuKw4NJoAJVN8ekV5Qx4ZJYtMTFlOmY6Q1kNZ+TaU+/D8NLmhWCYqxlVUn5
         9UgOisu9wcA9PWuPLqAAmxiSzDdzh7lRdoFgw+TKu9dMWvPGSDK5uQTymjCAw7LddZBZ
         zTZK9pQ+BSMjnKSFJq+wMqPITFqF8fBfkv+22dFsv1M88H5fUwigyZ4VviwZtOjqGluT
         rYXw==
X-Gm-Message-State: AHQUAuYxFOagYaE4q1S1tcT4V6FjDlO0yVgcSuU2FcU8ZQj6yV0RL9af
        om/RMZs6qitBacWcxRJ5bzE=
X-Google-Smtp-Source: AHgI3Ia6tf8qKcnDZGq8pmO0TvjORlvRlsjG6vsahz6VFg/6K4K4nTJ8TdhkLfBX1YfNAhhTSYt9Pg==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr24383572plo.257.1549652571323;
        Fri, 08 Feb 2019 11:02:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h64sm4927076pfc.142.2019.02.08.11.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:02:49 -0800 (PST)
Date:   Fri, 8 Feb 2019 11:02:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, bp@suse.de,
        fanc.fnst@cn.fujitsu.com, mingo@redhat.com,
        thomas.lendacky@amd.com, yamada.masahiro@socionext.com,
        caoj.fnst@cn.fujitsu.com, jgross@suse.com, mingo@kernel.org,
        keescook@chromium.org, x86@kernel.org, hpa@zytor.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190208190248.GA10854@roeck-us.net>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 01, 2019 at 03:01:11AM -0800, tip-bot for Chao Fan wrote:
> Commit-ID:  3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
> Gitweb:     https://git.kernel.org/tip/3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
> Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
> AuthorDate: Wed, 23 Jan 2019 19:08:48 +0800
> Committer:  Borislav Petkov <bp@suse.de>
> CommitDate: Fri, 1 Feb 2019 11:52:55 +0100
> 
> x86/boot: Early parse RSDP and save it in boot_params
> 
> The RSDP is needed by KASLR so parse it early and save it in
> boot_params.acpi_rsdp_addr, before KASLR setup runs.
> 
> RSDP is needed by other kernel facilities so have the parsing code
> built-in instead of a long "depends on" line in Kconfig.
> 
>  [ bp:
>     - Trim commit message and comments
>     - Add CONFIG_ACPI dependency in the Makefile
>     - Move ->acpi_rsdp_addr assignment with the rest of boot_params massaging in extract_kernel().
>  ]
> 

This patch causes x86_64 boots with efi32 bios to crash early and hard
(before any console output is seen).

Sample qemu command line:

qemu-system-x86_64 -kernel arch/x86/boot/bzImage -M q35 -cpu SandyBridge \
	-no-reboot -snapshot -smp 4 \
	-bios OVMF-pure-efi-32.fd \
	-m 1G \
	-usb -device usb-storage,drive=d0 \
	-drive file=rootfs.squashfs,if=none,id=d0,format=raw \
	--append 'earlycon=uart8250,io,0x3f8,9600n8 root=/dev/sda rootwait panic=-1 console=ttyS0' \
	-nographic

This is with qemu 3.1, though details other than "-bios OVMF-pure-efi-32.fd"
don't really matter.

Files used above are available from https://github.com/groeck/linux-build-test/.

The patch can not be reverted alone, but

Revert "x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only"
Revert "x86/boot: Parse SRAT table and count immovable memory regions"
Revert "x86/boot: Early parse RSDP and save it in boot_params"

fixes the problem.

Bisect log attached below.

Guenter

---
# bad: [a46228f6598a191e25ca160870f20c3cd1743d13] Add linux-next specific files for 20190208
# good: [8834f5600cf3c8db365e18a3d5cac2c2780c81e5] Linux 5.0-rc5
git bisect start 'HEAD' 'v5.0-rc5'
# good: [d5ee02f33ec5ade9c9afb9d45bfc4f5cb1375e58] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect good d5ee02f33ec5ade9c9afb9d45bfc4f5cb1375e58
# good: [f34bff29873986d260d7a491fb6f543d12fbe7cd] Merge remote-tracking branch 'devicetree/for-next'
git bisect good f34bff29873986d260d7a491fb6f543d12fbe7cd
# bad: [68182cb929ec6a676655887cbfb12b09662c1e5b] Merge remote-tracking branch 'icc/icc-next'
git bisect bad 68182cb929ec6a676655887cbfb12b09662c1e5b
# bad: [0a5c6189664123753c298d90dec3a5a6b907f06f] Merge remote-tracking branch 'driver-core/driver-core-next'
git bisect bad 0a5c6189664123753c298d90dec3a5a6b907f06f
# bad: [e2a43b09bfc24369719437b5f8f703c5d7003af2] Merge remote-tracking branch 'tip/auto-latest'
git bisect bad e2a43b09bfc24369719437b5f8f703c5d7003af2
# good: [ba1ef96ac73d2a9851dc64d0a991ac8699aa6a22] Merge branch 'timers/core'
git bisect good ba1ef96ac73d2a9851dc64d0a991ac8699aa6a22
# good: [473a78a7bbeb7c77b81b596095f59ce4fbbd49dc] spi-atmel: support inter-word delay
git bisect good 473a78a7bbeb7c77b81b596095f59ce4fbbd49dc
# bad: [132dc31173c99bd252f6a54e3a9fba90f7417a43] Merge branch 'x86/cleanups'
git bisect bad 132dc31173c99bd252f6a54e3a9fba90f7417a43
# bad: [6eb09d138a331121740a4cf7458ab317979d9a17] Merge branch 'x86/boot'
git bisect bad 6eb09d138a331121740a4cf7458ab317979d9a17
# good: [e2c403557ebbcd1f0052e1ae51cfaff596cf259d] Merge branch 'x86/asm'
git bisect good e2c403557ebbcd1f0052e1ae51cfaff596cf259d
# good: [33f0df8d843deb9ec24116dcd79a40ca0ea8e8a9] x86/boot: Search for RSDP in the EFI tables
git bisect good 33f0df8d843deb9ec24116dcd79a40ca0ea8e8a9
# bad: [3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce] x86/boot: Early parse RSDP and save it in boot_params
git bisect bad 3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
# good: [93a209aaaad495d7d0bc9b6186a4495934f70402] x86/boot: Search for RSDP in memory
git bisect good 93a209aaaad495d7d0bc9b6186a4495934f70402
# first bad commit: [3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce] x86/boot: Early parse RSDP and save it in boot_params
