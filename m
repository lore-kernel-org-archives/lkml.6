Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E9BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9069520832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIV6kga5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9069520832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeK1Tve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:51:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40119 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeK1Tve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:51:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so1649889wmf.5;
        Wed, 28 Nov 2018 00:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VtLSsDsh1WFVqeKQ3regGblelzuW5yA41ua+KR+e/hE=;
        b=sIV6kga5f73q9oITq+0XflnobxTi6lBwbyqGJeGI54m6cilMFxabYkAQEm8FFi6BEw
         pJNtmwbl9+9XpzE6QPXPolv962VlOtXSNxyTGQefGLgi4fNRox3BfQ9jdaaXy7vK6r+V
         VNDAiJHj92jj5MiGCgY/lOdaqtP1CSN0uF47heuMU1CJziKCzcuF1v5uh+Q5+0r7G/jZ
         W3FT3f4BLS5HpOE3mBXis/V9NSO08reH5JeEkrG4aCu8Q0KoknLPODxUNbX9e6KG5BGJ
         XOfNHrChBwef0fLmVhMEJ+G2coP4q6DsBMwm7iBMixKTNT20hPJcYGtUaoNwjttdNVEZ
         KU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VtLSsDsh1WFVqeKQ3regGblelzuW5yA41ua+KR+e/hE=;
        b=nUXEL62L0Msv7e7qsPRpGjELXp7h3FZilzvbXCF2rm7XcaXfLNUaCj0AEezeXaxn1L
         GljuEV2+zIVkUqZitZMIxL+CnzNSQ2+99VHZpuWwVCELS/u9qyQ+4uw0ysd/Nl4nbUAs
         Ky76AbHR/f0Tm65hAg9tI/RExqOuz3+RrVW5xT4LoagPRJ1PbszWygPmVVenQE++SxR2
         ikPUs+bei3FKPw7kyjk3zroVSWPbwysygvoo7Rn2rXei4+wTDkfWwMZ+Z/U4VcpYgcH6
         dec57Qfsh42xEalNd4lG0HqXA4ixB0oVzKQMw7JSCkqUAImj+Mw2IGDaAtWA2vw9GBU/
         yrIA==
X-Gm-Message-State: AA+aEWZ4nomnpXPJwhiuXxcM8T5hje2BtUY8q7hrmAlNHhKEEVGo5Ix4
        Ah5S3aR12o36YBye2toOypcHW+Gq
X-Google-Smtp-Source: AFSGD/U2FeA135fUXqRBO7NinwpXX6RyFig2mSvKZx/+Wz6Q0sCA4USK9KoKebl7OzWF4MgGvNXljw==
X-Received: by 2002:a1c:1801:: with SMTP id 1mr1977663wmy.153.1543395040286;
        Wed, 28 Nov 2018 00:50:40 -0800 (PST)
Received: from inc028000049.lancs.ac.uk (inc028000049.lancs.ac.uk. [148.88.224.78])
        by smtp.gmail.com with ESMTPSA id p6sm6027304wrx.50.2018.11.28.00.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 00:50:39 -0800 (PST)
Date:   Wed, 28 Nov 2018 08:50:39 +0000
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: oops when ext4 fs is full
Message-ID: <20181128085038.iaklny2yuygrixhs@inc028000049.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I got a Oops when the hard drive was COMPLETELY full using a ext4 fs.
After it, any command on the directory where the last write should have occurred freezes, while any other directory behave just fine.

If this email is not relevant for you, please point me what to do.

Best Regards,
Willy


$ cat /proc/version 
Linux version 4.18.7-dirty (willy@inc028000049) (gcc version 6.3.0 20170516 (Debian 6.3.0-18)) #32 SMP PREEMPT Thu Sep 27 19:31:11 BST 2018

The kernel is dirty but the modifications are not related to the fs subsystem. The system is running on a Hardkernel Odroid-xu3 but running with the mainline linux at 8ea7eadbef2f7103d5871016f03fc38b3adeaddb
Also, the fs is on a SD-card. I did a fs check after the oops, no errors are reported.

$ awk -f scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux odroid-xu3-1 4.18.7-dirty #32 SMP PREEMPT Thu Sep 27 19:31:11 BST 2018 armv7l armv7l armv7l GNU/Linux

GNU C                   6.4.0
GNU Make                4.1
Binutils                2.26.1
Util-linux              2.27.1
Mount                   2.27.1
Module-init-tools       22
E2fsprogs               1.42.13
Linux C Library         2.23
Dynamic linker (ldd)    2.23
Linux C++ Library       6.0.24
Procps                  3.3.10
Net-tools               1.60
Kbd                     1.15.5
Console-tools           1.15.5
Sh-utils                8.25
Udev                    229
Wireless-tools          30
Modules Loaded          exynos_gsc media s5p_cec s5p_jpeg s5p_mfc v4l2_common v4l2_mem2mem videobuf2_common videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videodev



[545367.991991] CPU: 5 PID: 1235 Comm: D_control Tainted: G        W         4.18.7-dirty #32
[545368.000222] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[545368.006390] [<c0113050>] (unwind_backtrace) from [<c010ecdc>] (show_stack+0x10/0x14)
[545368.014180] [<c010ecdc>] (show_stack) from [<c0a91e40>] (dump_stack+0x98/0xc4)
[545368.021459] [<c0a91e40>] (dump_stack) from [<c0186034>] (register_lock_class+0x604/0x610)
[545368.029688] [<c0186034>] (register_lock_class) from [<c01895fc>] (__lock_acquire+0x98/0x1ac0)
[545368.038266] [<c01895fc>] (__lock_acquire) from [<c018ba50>] (lock_acquire+0xe0/0x2bc)
[545368.046152] [<c018ba50>] (lock_acquire) from [<c0aaf880>] (_raw_spin_lock+0x38/0x48)
[545368.053953] [<c0aaf880>] (_raw_spin_lock) from [<c02b4bb0>] (__d_instantiate+0x30/0x104)
[545368.062098] [<c02b4bb0>] (__d_instantiate) from [<c02b58dc>] (d_instantiate_new+0x40/0x90)
[545368.070417] [<c02b58dc>] (d_instantiate_new) from [<c0365f58>] (ext4_add_nondir+0x54/0x5c)
[545368.078734] [<c0365f58>] (ext4_add_nondir) from [<c03661bc>] (ext4_create+0xdc/0x188)
[545368.086618] [<c03661bc>] (ext4_create) from [<c02ac230>] (path_openat+0x9f4/0xf78)
[545368.094247] [<c02ac230>] (path_openat) from [<c02ad754>] (do_filp_open+0x70/0xdc)
[545368.101787] [<c02ad754>] (do_filp_open) from [<c0299f14>] (do_sys_open+0x134/0x1e4)
[545368.109499] [<c0299f14>] (do_sys_open) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[545368.117294] Exception stack(0xecf2dfa8 to 0xecf2dff0)
[545368.122405] dfa0:                   000a0042 0002b9ed 0002b9ed 000a0042 000001a4 00000000
[545368.130640] dfc0: 000a0042 0002b9ed 000001a4 00000005 00020042 000001a4 b6effb48 b6ee69c8
[545368.138870] dfe0: 00000005 b6b54af0 b6e59ee9 b6e5b456
[545368.144070] Unable to handle kernel NULL pointer dereference at virtual address 000002a0
[545368.152183] pgd = 0eb5bb04
[545368.154904] [000002a0] *pgd=b823c835
[545368.158549] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[545368.164011] Modules linked in: s5p_jpeg s5p_mfc exynos_gsc v4l2_mem2mem v4l2_common videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common videodev media s5p_cec
[545368.179810] CPU: 5 PID: 1235 Comm: D_control Tainted: G        W         4.18.7-dirty #32
[545368.188020] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[545368.194168] PC is at __d_instantiate+0x9c/0x104
[545368.198757] LR is at do_raw_spin_lock+0xac/0x120
[545368.203435] pc : [<c02b4c1c>]    lr : [<c018ef08>]    psr: 800f0013
[545368.209764] sp : ecf2dd68  ip : 7f2b5c30  fp : 00000001
[545368.215047] r10: e9d44980  r9 : 000081a4  r8 : 00000027
[545368.220333] r7 : ecf2c060  r6 : 00400002  r5 : cac82198  r4 : ecf2c000
[545368.226922] r3 : 00000078  r2 : 00010000  r1 : 00000000  r0 : 00000000
[545368.233509] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[545368.240703] Control: 10c5387d  Table: 6b12006a  DAC: 00000051
[545368.246504] Process D_control (pid: 1235, stack limit = 0x77cf525b)
[545368.252831] Stack: (0xecf2dd68 to 0xecf2e000)
[545368.257247] dd60:                   cac82198 ecf2c000 cac82200 00000001 00000027 c02b58dc
[545368.265490] dd80: cac82198 00000000 ecf2c000 c0365f58 cac82198 e9839858 ecf2c000 c0b0ee80
[545368.273723] dda0: 00000027 c03661bc 00000000 00000000 00000000 00000004 0000098f 00000027
[545368.281954] ddc0: e9d44958 c1007448 00000000 2cd8660f ecf2de44 ecf2df70 c03660e0 eb6ef450
[545368.290187] dde0: e9d44958 ee278c80 ecf2dec0 ecf2de8c 00020042 c02ac230 00000001 c17f6460
[545368.298419] de00: 00000006 00000000 00000040 c1007448 00000041 00000001 e9839858 eb6ef450
[545368.306651] de20: 00020042 ecf2c000 000081a4 00000000 00000001 00004511 c1644ac4 ec96f408
[545368.314883] de40: c1007448 00000000 dead4ead ffffffff ffffffff c1800da4 00000000 00000000
[545368.323115] de60: c0d4e9b4 ecf2de64 ecf2de64 00000000 dead4ead ffffffff ffffffff c1800da4
[545368.331347] de80: 00000000 00000000 c0d4e9b4 ecf2de64 ecf2de64 2cd8660f fefefeff c1007448
[545368.339579] dea0: c1007448 ecf2df70 00000001 fffff000 ecf2c000 00000005 b6ee69c8 c02ad754
[545368.347812] dec0: ee13ed10 eb6ef450 ecbeaa78 0000000f ed4d9024 00000000 00000000 edae5000
[545368.356043] dee0: e9839858 00000301 00000002 00000736 00000000 00000000 00000000 ecf2df00
[545368.364276] df00: ecf2c000 ed6541c0 00000001 e9329b80 00000000 00100000 ed6541c0 00000001
[545368.372508] df20: c0d62914 c0aafab0 00000005 c02be5f4 ed4d9000 00000000 00000005 00000002
[545368.380740] df40: ffffff9c 000a0042 c1007448 2cd8660f ed4d9000 00000005 c1007448 ffffff9c
[545368.388972] df60: ed4d9000 c0299f14 5bfb4efe 00000000 00020042 c01881a4 00000006 00000300
[545368.397204] df80: 00000001 2cd8660f 000a0042 0002b9ed 000001a4 00000005 c01011c4 ecf2c000
[545368.405437] dfa0: 00000005 c0101000 000a0042 0002b9ed 0002b9ed 000a0042 000001a4 00000000
[545368.413669] dfc0: 000a0042 0002b9ed 000001a4 00000005 00020042 000001a4 b6effb48 b6ee69c8
[545368.421900] dfe0: 00000005 b6b54af0 b6e59ee9 b6e5b456 800f0030 0002b9ed 00000000 00000000
[545368.430136] [<c02b4c1c>] (__d_instantiate) from [<c02b58dc>] (d_instantiate_new+0x40/0x90)
[545368.438454] [<c02b58dc>] (d_instantiate_new) from [<c0365f58>] (ext4_add_nondir+0x54/0x5c)
[545368.446772] [<c0365f58>] (ext4_add_nondir) from [<c03661bc>] (ext4_create+0xdc/0x188)
[545368.454656] [<c03661bc>] (ext4_create) from [<c02ac230>] (path_openat+0x9f4/0xf78)
[545368.462280] [<c02ac230>] (path_openat) from [<c02ad754>] (do_filp_open+0x70/0xdc)
[545368.469821] [<c02ad754>] (do_filp_open) from [<c0299f14>] (do_sys_open+0x134/0x1e4)
[545368.477533] [<c0299f14>] (do_sys_open) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[545368.485329] Exception stack(0xecf2dfa8 to 0xecf2dff0)
[545368.490436] dfa0:                   000a0042 0002b9ed 0002b9ed 000a0042 000001a4 00000000
[545368.498676] dfc0: 000a0042 0002b9ed 000001a4 00000005 00020042 000001a4 b6effb48 b6ee69c8
[545368.506908] dfe0: 00000005 b6b54af0 b6e59ee9 b6e5b456
[545368.512014] Code: e5843004 0a000015 e5943020 e5933038 (e5932228) 
[545368.518205] ---[ end trace 8eec0ae4f0c9a717 ]---

