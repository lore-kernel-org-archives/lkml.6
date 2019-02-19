Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D42C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F415F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfBSCZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:25:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56708 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfBSCZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:25:15 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gvv5s-0002Cz-KE; Tue, 19 Feb 2019 02:25:12 +0000
Date:   Tue, 19 Feb 2019 02:25:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dmitry.kasatkin@huawei.com, keescook@chromium.org
Subject: Re: [PATCH -next] exec: Fix mem leak in kernel_read_file
Message-ID: <20190219022512.GW2217@ZenIV.linux.org.uk>
References: <20190219021038.11340-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219021038.11340-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 10:10:38AM +0800, YueHaibing wrote:
> syzkaller report this:
> BUG: memory leak
> unreferenced object 0xffffc9000488d000 (size 9195520):
>   comm "syz-executor.0", pid 2752, jiffies 4294787496 (age 18.757s)
>   hex dump (first 32 bytes):
>     ff ff ff ff ff ff ff ff a8 00 00 00 01 00 00 00  ................
>     02 00 00 00 00 00 00 00 80 a1 7a c1 ff ff ff ff  ..........z.....
>   backtrace:
>     [<000000000863775c>] __vmalloc_node mm/vmalloc.c:1795 [inline]
>     [<000000000863775c>] __vmalloc_node_flags mm/vmalloc.c:1809 [inline]
>     [<000000000863775c>] vmalloc+0x8c/0xb0 mm/vmalloc.c:1831
>     [<000000003f668111>] kernel_read_file+0x58f/0x7d0 fs/exec.c:924
>     [<000000002385813f>] kernel_read_file_from_fd+0x49/0x80 fs/exec.c:993
>     [<0000000011953ff1>] __do_sys_finit_module+0x13b/0x2a0 kernel/module.c:3895
>     [<000000006f58491f>] do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
>     [<00000000ee78baf4>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     [<00000000241f889b>] 0xffffffffffffffff
> 
> It should goto 'out_free' lable to free allocated buf while kernel_read
> fails.

Applied.
