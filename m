Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC88C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2748C2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP1OynQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbeLOPvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:51:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44663 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbeLOPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:51:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so4269416pfh.11;
        Sat, 15 Dec 2018 07:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ANKuEIpYx+DKEclaq0XDbZDufkbrqbYJHfQSWbwH91s=;
        b=bP1OynQ1YQNQWlOJLVr98T6wNcrs2HVIqlRe8Ywcg2Vpo+xK0k3YPQk+EKwG4ePMpU
         HWQNjEGAPI4DFDOeWljd8dRCu+e7nmA+gCaoeuCKzdGvCQGcBLludiLTHbmJNJYYPSsI
         h+/g5ULKpR7nXLdm327ay1HhB/MYTZ5REY1QXLac0lEAMpJKl+JjOHQouWWNVAsYK5PM
         5RnGCE+eI3mHMcuKS7TjHUEilpabej4KE67O5JsTE5ZmT3OLUIBr6eUN0JXFSGzfBMLJ
         UaeSb72PbtemtTi+RIlge2Tn+781mQcb6utaxFgQmLrSyt0POHAfZMucfsK1iYymt1rA
         ANaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ANKuEIpYx+DKEclaq0XDbZDufkbrqbYJHfQSWbwH91s=;
        b=iYv2+sHsABamXu3SNzQzgzyhSWO5Ttb+oNG9P4L8aRSiGMGhRr9ZpD1UBerbm+acgb
         +7Jel7t2AYZ/+Y59fyShCXSbiBwD+tgymU3Sbw/cwRdFvVm2CdYd2iZQqK2S+bEiz0Tz
         IjwiBGXqc5TVheToBADZFOTyN4qDjGJhDoou88DUb7t2fSCPUm2RP4yHreggFSb0GR+s
         PUUi88oGcCzigW4+eZx0BjlGlLdooyBHysRhYQwPKw3YYfvCRezMpisX/OppwUFS+Bo/
         W2aP3LX3yrpsty4Y/0AGIJGn0SyXwI9NawrITonA2LIRjdT0VoIfwvBMlTFnu3xJQHzS
         NCZw==
X-Gm-Message-State: AA+aEWYI9v+SIYErZM7x+gyrxBCzNPbq/pi9izSHvcsxyGGxbGLmmDvu
        6Zh1dMzKUwIa6Hfjx17gGikJ05y9
X-Google-Smtp-Source: AFSGD/XGIHO6n80izIzNug/WB0c+MpPTYxBzcgbqG2LD43GOwh7cQMHjxDk7SvlqpCI4R1T7BAdD3w==
X-Received: by 2002:a62:3603:: with SMTP id d3mr7092701pfa.146.1544889078438;
        Sat, 15 Dec 2018 07:51:18 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13sm9898541pgf.84.2018.12.15.07.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 07:51:17 -0800 (PST)
Date:   Sat, 15 Dec 2018 07:51:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 14
Message-ID: <20181215155116.GA865@roeck-us.net>
References: <20181214181826.5775b958@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214181826.5775b958@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 06:18:26PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181213:
> 
> The dma-mapping tree gained a conflict against the kbuild tree.
> 
> The rdma tree still had its build failure so I used a supplied patch.
> 
> The net-next tree gained a conflict against the bpf tree.
> 
> The drm tree gained a conflict against the drm-fixes tree.
> 
> The block tree gained a conflict against the scsi-fixes tree.
> 

Not sure what exactly causes the problem, but I see various crashes and
boot stalls with this version. One crash dump and bisect log attached.
More will follow.

Guenter

---
[   17.490441] Oops: Kernel access of bad area, sig: 11 [#1]
[   17.490630] BE PREEMPT Xilinx Virtex440
[   17.490798] Modules linked in:
[   17.490974] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.20.0-rc6-next-20181214 #1
[   17.491202] NIP:  c03af018 LR: c03af014 CTR: c03a24e4
[   17.491349] REGS: cf82fc00 TRAP: 0300   Tainted: G        W
(4.20.0-rc6-next-20181214)
[   17.491568] MSR:  00029000 <CE,EE,ME>  CR: 24000222  XER: 00000000
[   17.491765] DEAR: 00000040 ESR: 00000000 
[   17.491765] GPR00: c03af014 cf82fcb0 cf82ccc0 00000000 00000000 00000000 00000002 00000000 
[   17.491765] GPR08: 00000000 00000000 c03aec60 00000000 24000222 00000000 c0002b3c 00000000 
[   17.491765] GPR16: c0980000 cf82e000 c0895324 cf82e000 c07fdd28 c07fdd54 c08dd90c 00000000 
[   17.491765] GPR24: c109f0e4 cfa57c10 00000001 cf1a2400 cf1a2cf0 00000000 00000000 cf18b600 
[   17.492758] NIP [c03af018] blk_mq_run_hw_queue+0x24/0x100
[   17.492913] LR [c03af014] blk_mq_run_hw_queue+0x20/0x100
[   17.493057] Call Trace:
[   17.493143] [cf82fcb0] [c03af014] blk_mq_run_hw_queue+0x20/0x100 (unreliable)
[   17.493360] [cf82fce0] [c03af14c] blk_mq_run_hw_queues+0x58/0x80
[   17.493532] [cf82fd00] [c03a2530] blk_set_queue_dying+0x30/0x68
[   17.493698] [cf82fd10] [c03a368c] blk_cleanup_queue+0x2c/0x13c
[   17.493864] [cf82fd30] [c04b0718] ace_probe+0x424/0x4c4
[   17.494017] [cf82fd70] [c0494394] platform_drv_probe+0x40/0x9c
[   17.494179] [cf82fd90] [c0491bf4] really_probe+0x1e8/0x2f8
[   17.494334] [cf82fdc0] [c0491e98] driver_probe_device+0x64/0x448
[   17.494500] [cf82fde0] [c049238c] __driver_attach+0x110/0x114
[   17.494660] [cf82fe00] [c048f7e8] bus_for_each_dev+0x64/0xb4
[   17.494817] [cf82fe30] [c0490dec] bus_add_driver+0x158/0x23c
[   17.494979] [cf82fe50] [c0493294] driver_register+0x84/0x148
[   17.495142] [cf82fe60] [c08c7ee4] ace_init+0x4c/0xa4
[   17.495289] [cf82fe80] [c0002654] do_one_initcall+0xa0/0x304
[   17.495452] [cf82fee0] [c0895eb0] kernel_init_freeable+0x328/0x3fc
[   17.495624] [cf82ff30] [c0002b54] kernel_init+0x18/0x10c
[   17.495778] [cf82ff40] [c000e2f0] ret_from_kernel_thread+0x14/0x1c
[   17.495944] Instruction dump:
[   17.496042] 4ca20020 3863ffd4 4bfffd5c 9421ffd0 7c0802a6 bfa10024 7c7f1b78 7c9e2378 
[   17.496267] 90010034 38810008 4bfffc31 813f008c <81290040> 752a1000 41820028 80810008 
[   17.496737] ---[ end trace 18bf5bd2cee0cf71 ]---


---
# bad: [47475ca018670a0d320e710fb0fcb90fe67d1664] Revert "sparc: remove the sparc32_dma_ops indirection"
# good: [40e020c129cfc991e8ab4736d2665351ffd1468d] Linux 4.20-rc6
git bisect start 'HEAD' 'v4.20-rc6'
# good: [ddfdda7f7d1ebdca0851f30a814e76749f08be99] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect good ddfdda7f7d1ebdca0851f30a814e76749f08be99
# good: [da6ac0ab24dbcd87d98ad50820693a0d8e1f6488] Merge remote-tracking branch 'security/next-testing'
git bisect good da6ac0ab24dbcd87d98ad50820693a0d8e1f6488
# good: [4df3e03af3855f25a7491f5d2010feb37670559a] Merge remote-tracking branch 'char-misc/char-misc-next'
git bisect good 4df3e03af3855f25a7491f5d2010feb37670559a
# good: [773a58db0056af455cb27b8be20be9436a1c1e57] Merge remote-tracking branch 'scsi/for-next'
git bisect good 773a58db0056af455cb27b8be20be9436a1c1e57
# good: [d0c9a0a31d1add66047cbaac7c6838618caf877b] Merge remote-tracking branch 'nvmem/for-next'
git bisect good d0c9a0a31d1add66047cbaac7c6838618caf877b
# good: [842b362182ffd7bbcfc177961c5e0e7344765c8a] mm, memory-hotplug: rework unregister_mem_sect_under_nodes
git bisect good 842b362182ffd7bbcfc177961c5e0e7344765c8a
# good: [9067c8d5a70baac6fb53fa1d5858bf9d72175846] lib/find_bit_benchmark.c: align test_find_next_and_bit with others
git bisect good 9067c8d5a70baac6fb53fa1d5858bf9d72175846
# good: [d04978ca88abfe27a203d2c31f4774cf5fdba901] ipc: conserve sequence numbers in extended IPCMNI mode
git bisect good d04978ca88abfe27a203d2c31f4774cf5fdba901
# bad: [3d147fb5501aa5d76a7603d2a7981cda49dd5a59] kexec: export PG_offline to VMCOREINFO
git bisect bad 3d147fb5501aa5d76a7603d2a7981cda49dd5a59
# bad: [ae1b1cc19da5e900d34e5d1441382408ca47efee] mm: treewide: remove unused address argument from pte_alloc functions
git bisect bad ae1b1cc19da5e900d34e5d1441382408ca47efee
# good: [4f145cd66a1a76136ff5a03a99e37ba082715dc6] XArray tests: Check iterating over multiorder entries
git bisect good 4f145cd66a1a76136ff5a03a99e37ba082715dc6
# good: [d8c6527f968138d4adc03b438ba0901030d0be40] Merge remote-tracking branch 'xarray/xarray'
git bisect good d8c6527f968138d4adc03b438ba0901030d0be40
# bad: [2088c20f85f2cbdcb0052a69b0626a76c6066906] scripts/atomic/check-atomics.sh: don't assume that scripts are executable
git bisect bad 2088c20f85f2cbdcb0052a69b0626a76c6066906
# bad: [07365469c2a11d1593da08ff750d5cd7a11b9ab4] Merge branch 'akpm-current/current'
git bisect bad 07365469c2a11d1593da08ff750d5cd7a11b9ab4
# first bad commit: [07365469c2a11d1593da08ff750d5cd7a11b9ab4] Merge branch 'akpm-current/current'
