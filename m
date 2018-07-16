Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B26ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A765208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAdaI4J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A765208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeGPRQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:16:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44409 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeGPRQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:16:40 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so15504908pls.11;
        Mon, 16 Jul 2018 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H6cZaN9l3PkVIT6Fo2hjrE86FONeXwBHapClbPEBk74=;
        b=GAdaI4J5VzbnllkuyZvY0tPGFCGeQRpp+BHEfHpjubqXpDy7V1WJPcvPk1pishMgx3
         mrirF53V6qwGCCpGroX1MV3TNtCh2syCAgC3vlMhPAVlCwIKyXYXZJF+mdVKNQ/9Fjkz
         uH7E3etSht3ZU0lTlLT67QayJp/+CoCnyG+EYkI2IYaIQdPx1HNAmLUqccK5pyGG8Cvm
         Mg5DKYUfVPPPIONKOqLsegiXnI7kQcFQoEw2K6WwpSHCfWFmSGEiGdkL0DORIF+EFuxk
         BPPyy2v1591Yh8kS2Ng2TGKDmM2S6O4Z4gCZLk+/WcBgeEiJ+4isj02XOLQKFSYoCfrQ
         33FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H6cZaN9l3PkVIT6Fo2hjrE86FONeXwBHapClbPEBk74=;
        b=kdTyDKRSQe2ij8KFQTruMAIAV2fyA1gYAgtby0jYHK73ddShi5m4kGNebcqJ6fU2fI
         4Z2ooLhbngDRRH61ERVncY58RadA2VLk3yOlrgodhaUvMxU8eoemwwbk85P3vMCcUbPC
         TA/0HFt5bo32rWFLrj4S+iosYWW7AK2humw1BIKiqoloMjvrIHY76+2Itp5QNZkEZyMj
         jpGVozKBZ20KRwZ2XQ+ZXppFP2ysHgY+khEX2oPICcBQHotMjujqMZ6bFb5Y+XBoGMqx
         OwHW7mX6VxBeQBb4x12xjtffkxLgFYKIp4JQB0HnrSedpDFumjYmagVeFe807+DDF6pl
         7/Mg==
X-Gm-Message-State: AOUpUlF3RTpoxB4LzkAhS0mrqWHuBNRfl45K6lbAEMu7IQ226bhiXPTZ
        sScJnel8jtZ7KNnOJfMYyg8=
X-Google-Smtp-Source: AAOMgpcXLRy4RWtsVGUDdRYKQRH+fnnL5ourDTUmfcpKKKVcVqj7rBzpZeMosexUY34lpXodcSiKCg==
X-Received: by 2002:a17:902:aa01:: with SMTP id be1-v6mr17317783plb.296.1531759706239;
        Mon, 16 Jul 2018 09:48:26 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g5-v6sm2431510pgn.73.2018.07.16.09.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 09:48:25 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:48:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/67] 4.17.7-stable review
Message-ID: <20180716164824.GA14451@roeck-us.net>
References: <20180716073443.294323458@linuxfoundation.org>
 <20180716163338.GD12065@roeck-us.net>
 <20180716164033.GA4286@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716164033.GA4286@flashbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:40:33AM -0700, Nathan Chancellor wrote:
> On Mon, Jul 16, 2018 at 09:33:38AM -0700, Guenter Roeck wrote:
> > On Mon, Jul 16, 2018 at 09:34:29AM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.17.7 release.
> > > There are 67 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Jul 18 07:34:11 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 134 pass: 134 fail: 0
> > Qemu test results:
> > 	total: 171 pass: 159 fail: 12
> > Failed tests: 
> > 	i386:Broadwell:q35:defconfig:smp:rootfs 
> > 	i386:Skylake-Client:q35:defconfig:smp:rootfs 
> > 	i386:SandyBridge:q35:defconfig:smp:rootfs
> > 	i386:Haswell:pc:defconfig:smp:rootfs 
> > 	i386:Nehalem:q35:defconfig:smp:rootfs 
> > 	i386:phenom:pc:defconfig:smp:rootfs 
> > 	i386:Opteron_G5:q35:defconfig:smp:initrd 
> > 	i386:Westmere:q35:defconfig:smp:initrd 
> > 	i386:core2duo:q35:defconfig:nosmp:rootfs 
> > 	i386:Conroe:pc:defconfig:nosmp:rootfs 
> > 	i386:Opteron_G1:pc:defconfig:nosmp:initrd
> > 	i386:n270:q35:defconfig:nosmp:rootfs
> > 
> > All 32-bit i386 boot tests crash.
> > 
> > [    0.000000] BUG: unable to handle kernel NULL pointer dereference at 00000000
> > [    0.000000] *pde = 00000000 
> > [    0.000000] Oops: 0002 [#1] SMP
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.7-rc1+ #1
> > [    0.000000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/24
> > [    0.000000] EIP: zero_resv_unavail+0x9b/0x103
> > [    0.000000] EFLAGS: 00200002 CPU: 0
> > [    0.000000] EAX: 00000000 EBX: 00000000 ECX: 00000008 EDX: 00000000
> > [    0.000000] ESI: c6bc5e90 EDI: 00000000 EBP: c6bc5eac ESP: c6bc5e80
> > [    0.000000]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> > [    0.000000] CR0: 80050033 CR2: 00000000 CR3: 06d67000 CR4: 00040690
> > [    0.000000] Call Trace:
> > [    0.000000]  free_area_init_nodes+0x407/0x44c
> > [    0.000000]  zone_sizes_init+0x45/0x5c
> > [    0.000000]  paging_init+0xac/0xaf
> > [    0.000000]  native_pagetable_init+0xc6/0xce
> > [    0.000000]  setup_arch+0x9c6/0xb18
> > [    0.000000]  start_kernel+0x4f/0x3d2
> > [    0.000000]  ? idt_setup_early_handler+0x2b/0x3e
> > [    0.000000]  i386_start_kernel+0x95/0x99
> > [    0.000000]  startup_32_smp+0x164/0x168
> > 
> > Guenter
> 
> I think this is caused by 3e3eda67092b ("mm: zero available pages before
> memmap init"). A fix for it was posted to the mailing list this morning:
> https://lore.kernel.org/lkml/20180716151630.770-1-pasha.tatashin@oracle.com/
> 

Yes, it looks like this was inherited from upstream. The same failure is seen
in in v4.17-rc5 and next-20180716.

Guenter
