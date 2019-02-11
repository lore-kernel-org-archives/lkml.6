Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA415C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF97921B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYoJY9Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBKOIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:08:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37170 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfBKOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:08:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so5316686pfb.4;
        Mon, 11 Feb 2019 06:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kT9ky6r8JlCJS8Xjdy3k3DWkoQh3tIk5+T4ct1I1sVo=;
        b=aYoJY9EuFDpKcOJ644NsyeAkUN0r5QN2Vz8SoTjaB+lTi7tD+own9mQQQ+0TQKt/+A
         XTZveuBE27kdBTUQdUaZi1eugKi63EYw3E+Be67a9hXsoLWiHMY6PsN7ooINzyH+oNz+
         zSxX7flR8UjyESJZHadFq711MOlqbAtFXRFJYKEwm0qpaVVOqmZ3qjzommvE6E7UnZVu
         LpAsd7M2Yt5qggSIr9wFaHoPLwCGwogqsZv1YakYpr52n0xVzEVEMH0QEWiVcp/4dFSf
         iauvHqRftU3TtmYh+4Y1uHPhVzcJrX/LXG7UCAspTykmErC6KLw1MM1QVhwAm61ffwKu
         VM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kT9ky6r8JlCJS8Xjdy3k3DWkoQh3tIk5+T4ct1I1sVo=;
        b=mVgpenRPNKl0lKq7CNtkWwDyuuFosMQqrjAvs5Bduk+MoYPNYgDet/N5B6dDP0yd18
         4p/B3zaNwqbKT5+FyK2kNUhBEMckMEn0yFv6BVDR86tbVPtG3nHn6v3ktIhSIwNFo33w
         MJRCttHew8dMHIYXJIpPcRNNh1/1lRHl54s6G4opyFx+/23AVscJ0gUHLl7PwKu7oLp5
         rOH94ERcEEPTySt9vIt//27qeqoWz8YflZMCFTN4DySzpIzXSyT6TGtw+qwM+ltE5D/K
         ldhOy7XSot8yg/AxhsmZ8djfpzL4iXABoOkOlp25FQfqc9Z/1v0k17z/mX+mEdk0FrpR
         UgsA==
X-Gm-Message-State: AHQUAuZv52/0JLVANnZNqsnqFORy2hYR5PT1u3BQV8Lp6cIxdLDp/p4d
        7vXtC6RPBs0hNx9DuZPZyZzOj/hS
X-Google-Smtp-Source: AHgI3IYoBvb4ET2AD1q8E5Rkn4M2dVlWcR5dciR9Ijftauk098Ktabj3nHIjl7hNQVwsHcKUsOqyFQ==
X-Received: by 2002:aa7:8c97:: with SMTP id p23mr140422pfd.229.1549894101041;
        Mon, 11 Feb 2019 06:08:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m67sm17962328pfb.25.2019.02.11.06.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:08:19 -0800 (PST)
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
To:     Borislav Petkov <bp@alien8.de>, Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, mingo@redhat.com,
        thomas.lendacky@amd.com, yamada.masahiro@socionext.com,
        caoj.fnst@cn.fujitsu.com, jgross@suse.com, mingo@kernel.org,
        keescook@chromium.org, x86@kernel.org, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
 <20190211093033.GA1651@localhost.localdomain>
 <20190211100800.GA19041@zn.tnic>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <721f6d96-4f20-0c12-b776-4fe7089397dc@roeck-us.net>
Date:   Mon, 11 Feb 2019 06:08:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190211100800.GA19041@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 2:08 AM, Borislav Petkov wrote:
> On Mon, Feb 11, 2019 at 05:30:33PM +0800, Chao Fan wrote:
>> Yes, I download your ovmf file in linux-build-test/rootfs/firmware/ from
>> your link. There are two files, efi32 and efi64. Then I try to run:
> 
> You need both OVMF-pure-efi-32.fd and rootfs.squashfs from the repo. And
> then this works here. Just put the script below and the two files in a
> directory and point to the kernel where you're building with -kernel.
> 
> ---
> #!/bin/bash
> 
> qemu-system-x86_64 -kernel ~/kernel/linux/arch/x86/boot/bzImage -M q35 -cpu SandyBridge \
>          -no-reboot -snapshot -smp 1 \
>          -gdb tcp::1235 \
>          -bios OVMF-pure-efi-32.fd \
>          -m 1G \
>          -net nic,model=rtl8139,macaddr=12:34:56:78:12:34 \
>          -usb -device usb-storage,drive=d0 \
>          -drive file=rootfs.squashfs,if=none,id=d0,format=raw \
>          --append 'earlycon=uart8250,io,0x3f8,9600n8 root=/dev/sda rootwait panic=-1 earlyprintk=ttyS0,115200,keep console=ttyS0,115200' \
>          -monitor pty \
>          -serial file:log
> 
> I've added some options for debugging.
> 

If you use my rootfs, you can also add "noreboot" as boot parameter and it
won't reboot but stay in a shell. You can also use any of the other root
file systems in the repository - it doesn't have to be squashfs.

The whole point of booting with OVMF-pure-efi-32.fd is just that. I have
other test runs which boot with the 64 bit efi version. The idea is to
test as many combinations as possible. This is also why this specific
boot is from USB drive and with squashfs/q35/SandyBridge.

Thanks,
Guenter
