Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C80ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A6E208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMgNF9jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A6E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeGPRBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:01:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33988 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeGPRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:01:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so7712050pgv.1;
        Mon, 16 Jul 2018 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FJW7sJS/LgvBtTmnv+rKlqZbUYPqLFam2tuKg3A2j3U=;
        b=oMgNF9jmlnKtwkLgZQ4cwVK8ELHqfdUIg6hXZaczwRgEXZruZ3CbYLtJ3RuT5ThFIW
         OWOJldVx1kS/KSrWUD0q5SM1IlS6JLHlQ64h7BkFsJG1eKf8R1lVZTS+6/A5OFp6n0ts
         aOxU69fUHqo4ei4c428ErNNqcj2vM8R0P4Bi9j3+bH9aDePY4VkgEwULXGzqr3lQPMsB
         f71wMHvwnOykd3nCaW2CcFqxs8eAVUT96v5JivG23NhpODEN+K3zRkgKtfGSkxQ0EWj1
         mW9VUn7dIrvQgARFF2VAWAFDrJnnGaC0ci4+RgYPphtE0mvnF8mY2M9NdqRkLCL+x111
         lSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FJW7sJS/LgvBtTmnv+rKlqZbUYPqLFam2tuKg3A2j3U=;
        b=conR1jH5FZTeruEjqA3kZyiV2jFakNZUwwB4o7d9pxJIwYSGUkFoMfLBhj6p4GjC5B
         7iTcDe7uUN6ZOEZiWt+YK0SZtYPlz4fjFIkx2na2AzThbY6gUTaRWfRqMeyowUD8WOv+
         Y/OubIQHuZQzkemyud4jeJnbw5iDRdW9MfHFlh2URTZAUXf3KHNo6ma3wcZjZIE7EKym
         MozWoQHQH62hBcifUxcPnVOEBIQESAZtwLuYmFa/Mxpx3IH9ul7Iu2hQgzNgBLVIdioq
         9KYPO+ifhaSL0HCS50VwHUNkKL/ymfLiX1c6WAg27x44gMveCxbEAm1hIvviS2ZbcDAl
         tLEw==
X-Gm-Message-State: AOUpUlEwAMtaj6+b6dMMeh9jcFwDWHJ0ynuv6ZHeKwuxZBFPixxEyN9i
        Pa+m3TEUKGbsRODdDa20EuE=
X-Google-Smtp-Source: AAOMgpdwW/AYJqm0LtbERsWwqETvdKuekDgq5MQb4Mmm5Lmk9iVy2CVvgkfaxvRx0wN19JxfUpMhVg==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr18881152pfg.222.1531758820416;
        Mon, 16 Jul 2018 09:33:40 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g15-v6sm61884045pfg.98.2018.07.16.09.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 09:33:39 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:33:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/67] 4.17.7-stable review
Message-ID: <20180716163338.GD12065@roeck-us.net>
References: <20180716073443.294323458@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:34:29AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.7 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 18 07:34:11 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 171 pass: 159 fail: 12
Failed tests: 
	i386:Broadwell:q35:defconfig:smp:rootfs 
	i386:Skylake-Client:q35:defconfig:smp:rootfs 
	i386:SandyBridge:q35:defconfig:smp:rootfs
	i386:Haswell:pc:defconfig:smp:rootfs 
	i386:Nehalem:q35:defconfig:smp:rootfs 
	i386:phenom:pc:defconfig:smp:rootfs 
	i386:Opteron_G5:q35:defconfig:smp:initrd 
	i386:Westmere:q35:defconfig:smp:initrd 
	i386:core2duo:q35:defconfig:nosmp:rootfs 
	i386:Conroe:pc:defconfig:nosmp:rootfs 
	i386:Opteron_G1:pc:defconfig:nosmp:initrd
	i386:n270:q35:defconfig:nosmp:rootfs

All 32-bit i386 boot tests crash.

[    0.000000] BUG: unable to handle kernel NULL pointer dereference at 00000000
[    0.000000] *pde = 00000000 
[    0.000000] Oops: 0002 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.7-rc1+ #1
[    0.000000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/24
[    0.000000] EIP: zero_resv_unavail+0x9b/0x103
[    0.000000] EFLAGS: 00200002 CPU: 0
[    0.000000] EAX: 00000000 EBX: 00000000 ECX: 00000008 EDX: 00000000
[    0.000000] ESI: c6bc5e90 EDI: 00000000 EBP: c6bc5eac ESP: c6bc5e80
[    0.000000]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[    0.000000] CR0: 80050033 CR2: 00000000 CR3: 06d67000 CR4: 00040690
[    0.000000] Call Trace:
[    0.000000]  free_area_init_nodes+0x407/0x44c
[    0.000000]  zone_sizes_init+0x45/0x5c
[    0.000000]  paging_init+0xac/0xaf
[    0.000000]  native_pagetable_init+0xc6/0xce
[    0.000000]  setup_arch+0x9c6/0xb18
[    0.000000]  start_kernel+0x4f/0x3d2
[    0.000000]  ? idt_setup_early_handler+0x2b/0x3e
[    0.000000]  i386_start_kernel+0x95/0x99
[    0.000000]  startup_32_smp+0x164/0x168

Guenter
