Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA873C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E95920818
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="FbI3TU6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfBIIYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 03:24:31 -0500
Received: from server.eikelenboom.it ([91.121.65.215]:44098 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfBIIYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 03:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=raEBq8iBYzfF5jKBTPcdiAhTqhZv/IFMaQVO95mMnJ8=; b=FbI3TU6lJYCwbf2FXTfqN0lVqj
        ATU0ATM4WnjK7hCp864O8DUpMB2NweU+APwA6Y/NsSA+qE2FB/Clf8MTtV/qHf0eqkPttal/2HXfy
        W8AU8wzPU8eoSRcdqU9T0bfnE6jwtDi6ix2MqNfEnJdoAzUP8/PN/eqzF1qA+Zxhq+Ks=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:60108 helo=[172.16.1.50])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1gsNwC-0006be-Vo; Sat, 09 Feb 2019 09:24:37 +0100
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Subject: Linux 5.0 regression: BUG: unable to handle kernel paging request at
 ffff888023e26778
Message-ID: <39ae9195-cf8f-01fe-df83-38a9a4c52e48@eikelenboom.it>
Date:   Sat, 9 Feb 2019 09:26:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L.S.,


While testing a Linux 5.0-rc5-ish kernel (pull of yesterday) with some additional patches for
already reported other issues i came across the issue below which i haven't seen with 4.20.x

I haven't got a reproducer so i might be hard to hit it again, 
system is AMD and this is from the host kernel running under
the Xen hypervisor might it matter.

--

Sander


[17035.016433] BUG: unable to handle kernel paging request at ffff888023e26778
[17035.025887] #PF error: [PROT] [WRITE]
[17035.035146] PGD 2a2a067 P4D 2a2a067 PUD 2a2b067 PMD 7fe01067 PTE 8010000023e26065
[17035.044371] Oops: 0003 [#1] SMP NOPTI
[17035.053720] CPU: 3 PID: 28310 Comm: apt-get Not tainted 5.0.0-rc5-20190208-thp-net-florian-rtl8169-eric-doflr+ #1
[17035.063440] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
[17035.072635] RIP: e030:move_page_tables+0x7c1/0xae0
[17035.081585] Code: ce 00 48 8b 03 31 ff 48 89 44 24 20 e8 9e 72 e4 ff 66 90 48 89 c6 48 89 df e8 8b 89 e4 ff 66 90 48 8b 44 24 20 b9 0c 00 00 00 <48> 89 45 00 41 f6 46 52 40 0f 85 3f 02 00 00 49 8b 7e 40 45 31 c0
[17035.100225] RSP: e02b:ffffc90000f2bd40 EFLAGS: 00010282
[17035.109208] RAX: 0000000475e42067 RBX: ffff888023e267e0 RCX: 000000000000000c
[17035.118332] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000201
[17035.127378] RBP: ffff888023e26778 R08: aaaaaaaaaaaaaaaa R09: 000000051c1d9000
[17035.136310] R10: deadbeefdeadf00d R11: ffff88807fc17000 R12: 00007fc59fa00000
[17035.145433] R13: ffffea00008f89a8 R14: ffff88801c2286c0 R15: 00007fc59f800000
[17035.154171] FS:  00007fc5a5591100(0000) GS:ffff88807d4c0000(0000) knlGS:0000000000000000
[17035.162730] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[17035.171180] CR2: ffff888023e26778 CR3: 000000001c3f6000 CR4: 0000000000000660
[17035.179545] Call Trace:
[17035.187736]  move_vma.isra.3+0xd1/0x2d0
[17035.195837]  __se_sys_mremap+0x3c6/0x5b0
[17035.203986]  do_syscall_64+0x49/0x100
[17035.212109]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[17035.219971] RIP: 0033:0x7fc5a453527a
[17035.227558] Code: 73 01 c3 48 8b 0d 1e fc 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 19 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ee fb 2a 00 f7 d8 64 89 01 48
[17035.243255] RSP: 002b:00007ffda22d96f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
[17035.251121] RAX: ffffffffffffffda RBX: 0000557d40923a30 RCX: 00007fc5a453527a
[17035.258986] RDX: 0000000001a00000 RSI: 0000000001900000 RDI: 00007fc59f7ff000
[17035.267127] RBP: 0000000001a00000 R08: 0000000000000020 R09: 0000000000000040
[17035.275259] R10: 0000000000000001 R11: 0000000000000246 R12: 00007fc59f7ff060
[17035.282681] R13: 00007fc59f7ff000 R14: 0000557d40923a30 R15: 0000557d40829aa0
[17035.290322] Modules linked in:
[17035.297875] CR2: ffff888023e26778
[17035.305405] ---[ end trace 6ff49f09286816b6 ]---
[17035.313131] RIP: e030:move_page_tables+0x7c1/0xae0
[17035.320326] Code: ce 00 48 8b 03 31 ff 48 89 44 24 20 e8 9e 72 e4 ff 66 90 48 89 c6 48 89 df e8 8b 89 e4 ff 66 90 48 8b 44 24 20 b9 0c 00 00 00 <48> 89 45 00 41 f6 46 52 40 0f 85 3f 02 00 00 49 8b 7e 40 45 31 c0
[17035.334851] RSP: e02b:ffffc90000f2bd40 EFLAGS: 00010282
[17035.341727] RAX: 0000000475e42067 RBX: ffff888023e267e0 RCX: 000000000000000c
[17035.348838] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000201
[17035.356000] RBP: ffff888023e26778 R08: aaaaaaaaaaaaaaaa R09: 000000051c1d9000
[17035.363623] R10: deadbeefdeadf00d R11: ffff88807fc17000 R12: 00007fc59fa00000
[17035.371454] R13: ffffea00008f89a8 R14: ffff88801c2286c0 R15: 00007fc59f800000
[17035.378958] FS:  00007fc5a5591100(0000) GS:ffff88807d4c0000(0000) knlGS:0000000000000000
[17035.386585] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[17035.393797] CR2: ffff888023e26778 CR3: 000000001c3f6000 CR4: 0000000000000660



