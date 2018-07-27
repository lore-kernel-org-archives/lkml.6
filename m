Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500E4C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE3E208A5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg0RfD6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE3E208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbeG0N1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:27:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33101 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbeG0N1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:27:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so3143524pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9bN/ifC701TPx0ghOJRXi8aQy2MuADOq+mmXBkz+RAk=;
        b=gg0RfD6cgclWNARxw01oENytzrMwSAqCK5/C/zUQE4feh5q4h5dzwJrXVkPu58wYWy
         He7bcDn3PWAh6WQletoxtLnIUd7f/4RPoj23P5at7EmeNcHGtzHLr94VP9DAO1+nrm24
         lCKqpdZdVMt+i67QPI5k4w6ixS78qvkuVKqWWiwJn3WBFzwdsRKXGbd8mJon2cBk61N+
         urNnqaebU8OftNNhLVFaGnJRh+3rX5G/72NoeJ+XTRrvXrj7L24MUJtteDaDFdcDQ/Lg
         mNB2FLYM1aS72z0a6lksEKqXwELrRm/2z9d0SVQ8Ttx/DZRFoccfXz+wGnPuXjVO03ic
         0WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9bN/ifC701TPx0ghOJRXi8aQy2MuADOq+mmXBkz+RAk=;
        b=C0D3ezInNgbpRHp9mWUdM66hSpOOjD7NlqXs0b/w8TkgY9HmuYAaJH7J2KWpQVmIHk
         OgUXQ1c34Hnd+LbnwSAjh/ypaz8S2F2AbV3l8qPihrVQGjAd3Ou1oaRw45OYfIlNGAwo
         aZh+RnFxcNcE5DFKnGStzeMdjof+jhHlGIIVJ3Ili4pfnhfkJXPpm+7X6u1RuWNLcReg
         zF0FbQ2PYE+2qko1VoHsW/Mm3UJDgH5/ySuQG9K2dkk0+gduft/6IADeaB5aCvloxQbN
         9Ve8N4YL8JnKnHMFcU8MmlYFHasW8N/AICZ38UPHQuxwnBbuN301pPbu8TVFeP9SO3by
         Uc3A==
X-Gm-Message-State: AOUpUlH38Hm/w0ngd/adJupWkSQM1v7z/KLwBCkBJylwn5Rn/ObcNjux
        VGGoHyDdlJpy6xwQGKxowTg=
X-Google-Smtp-Source: AAOMgpeyY3DRJDPI7is6G1ERnJkm1TBIjNRpfD9Ji9CWtLQkl7TX9sqTCA+CZjD+q2DoigYuN7IBpQ==
X-Received: by 2002:a63:8648:: with SMTP id x69-v6mr5928745pgd.172.1532693123622;
        Fri, 27 Jul 2018 05:05:23 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id c1-v6sm5568409pfi.142.2018.07.27.05.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 05:05:21 -0700 (PDT)
Date:   Fri, 27 Jul 2018 21:05:17 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Tino Lehnig <tino.lehnig@contabo.de>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180727120517.GB229060@rodete-desktop-imager.corp.google.com>
References: <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725132126.GA2893@rodete-laptop-imager.corp.google.com>
 <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
 <20180726020351.GA221405@rodete-desktop-imager.corp.google.com>
 <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
 <15e3a0af-7e02-83fb-4b72-b05f6d7ded71@contabo.de>
 <20180726103001.GC221405@rodete-desktop-imager.corp.google.com>
 <b914205b-f3eb-7c0e-cd60-88c34341f84a@contabo.de>
 <20180727091431.GA229060@rodete-desktop-imager.corp.google.com>
 <4e0ab1cd-ea7a-0916-eb85-0396c61bd949@contabo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e0ab1cd-ea7a-0916-eb85-0396c61bd949@contabo.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 01:00:01PM +0200, Tino Lehnig wrote:
> On 07/27/2018 11:14 AM, Minchan Kim wrote:
> > I tried to reproduce with KVM but was not successful and I don't have
> > real mahcine to reproduce it. I am asking one device for it.
> > 
> > Anyway, I want to try this patch.
> > Could you apply attached two patches?
> 
> Thanks, I applied the patches on 4.18-rc6, but unfortunately, they do not
> solve the problem for me. Kernel message below.

Thanks for the testing.

> 
> > I am confusing. You mean after 4.15-rc9, you are not seeing*hung*  problem?
> 
> Correct.
> 
> > So you mean you see page state bug with recent kernel right?
> > It seems there are two problems now.
> > 
> > 1. Hung and 2. bad page
> > 
> > What bugs between them happens against what kernel version?
> > Could you clarify it?
> 
> * pre 0bcac06f27d75 (4.15-rc1): all good
> * 4.15-rc1: hung task (I have not encountered bad page here yet...)
> * 4.15-rc2 through 4.15-rc8: hung task + bad page (very rare)
> * 4.15-rc9 and newer: bad page

And bad page is always with writeback enable?

writeback enable means "echo "some dev" > /sys/block/zram0/backing_dev,
not just enable CONFIG_ZRAM_WRITEBACK.

> --
> 
> [  809.149272] BUG: Bad page state in process kvm  pfn:1cb08a8
> [  809.149332] flags: 0x57ffffc0000008(uptodate)
> [  809.149350] raw: 0057ffffc0000008 dead000000000100 dead000000000200
> 0000000000000000
> [  809.149378] raw: 0000000000000001 0000000000000000 00000000ffffffff
> 0000000000000000
> [  809.149405] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag set
> [  809.149427] bad because of flags: 0x8(uptodate)
> [  809.149444] Modules linked in: lz4 lz4_compress zram
> [  809.149450] CPU: 14 PID: 3734 Comm: kvm Not tainted 4.18.0-rc6+ #1
> [  809.149450] Hardware name: Supermicro Super Server/X10DRL-i, BIOS 3.0a
> 02/09/2018
> [  809.149451] Call Trace:
> [  809.149458]  dump_stack+0x63/0x85
> [  809.149463]  bad_page+0xc1/0x120
> [  809.149465]  check_new_page_bad+0x67/0x80
> [  809.149467]  get_page_from_freelist+0xe25/0x12f0
> [  809.149469]  __alloc_pages_nodemask+0xfd/0x280
> [  809.149472]  alloc_pages_vma+0x88/0x1c0
> [  809.149475]  do_swap_page+0x346/0x910
> [  809.149477]  __handle_mm_fault+0x815/0x1170
> [  809.149479]  handle_mm_fault+0x102/0x200
> [  809.149481]  __get_user_pages+0x131/0x680
> [  809.149483]  get_user_pages_unlocked+0x145/0x1e0
> [  809.149488]  __gfn_to_pfn_memslot+0x10b/0x3c0
> [  809.149491]  try_async_pf+0x86/0x230
> [  809.149494]  tdp_page_fault+0x12d/0x290
> [  809.149496]  kvm_mmu_page_fault+0x74/0x5d0
> [  809.149499]  ? call_function_interrupt+0xa/0x20
> [  809.149502]  ? vmexit_fill_RSB+0x10/0x40
> [  809.149503]  ? vmexit_fill_RSB+0x1c/0x40
> [  809.149504]  ? vmexit_fill_RSB+0x10/0x40
> [  809.149505]  ? vmexit_fill_RSB+0x1c/0x40
> [  809.149506]  ? vmexit_fill_RSB+0x10/0x40
> [  809.149507]  ? vmexit_fill_RSB+0x1c/0x40
> [  809.149508]  ? vmexit_fill_RSB+0x10/0x40
> [  809.149509]  ? vmexit_fill_RSB+0x1c/0x40
> [  809.149510]  ? vmexit_fill_RSB+0x10/0x40
> [  809.149513]  handle_ept_violation+0xdf/0x1a0
> [  809.149514]  vmx_handle_exit+0xa5/0x11c0
> [  809.149516]  ? vmx_vcpu_run+0x3bb/0x620
> [  809.149519]  kvm_arch_vcpu_ioctl_run+0x9b3/0x1980
> [  809.149522]  kvm_vcpu_ioctl+0x3a0/0x5e0
> [  809.149523]  ? kvm_vcpu_ioctl+0x3a0/0x5e0
> [  809.149526]  do_vfs_ioctl+0xa6/0x620
> [  809.149527]  ksys_ioctl+0x75/0x80
> [  809.149529]  __x64_sys_ioctl+0x1a/0x20
> [  809.149532]  do_syscall_64+0x5a/0x110
> [  809.149534]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  809.149536] RIP: 0033:0x7fd3c5572dd7
> [  809.149536] Code: 00 00 00 48 8b 05 c1 80 2b 00 64 c7 00 26 00 00 00 48
> c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48>
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 80 2b 00 f7 d8 64 89 01 48
> [  809.149563] RSP: 002b:00007fd3b07fc538 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  809.149565] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
> 00007fd3c5572dd7
> [  809.149566] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
> 0000000000000014
> [  809.149566] RBP: 00007fd3b9b13000 R08: 0000558cb94bb350 R09:
> 00000000ffffffff
> [  809.149567] R10: 0005577fd3b06fe6 R11: 0000000000000246 R12:
> 0000000000000000
> [  809.149568] R13: 00007fd3ba146000 R14: 0000000000000000 R15:
> 00007fd3b9b13000
> [  809.149570] Disabling lock debugging due to kernel taint
> 
> -- 
> Kind regards,
> 
> Tino Lehnig
