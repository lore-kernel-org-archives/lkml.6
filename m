Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeB1Bbj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 20:31:39 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:32893 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeB1Bbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 20:31:37 -0500
X-Google-Smtp-Source: AH8x224yozjHDldffySYMnWa3ea95Uz4UFsxBicuvtHcmL4aY8D60/0T/mAvY2nHpkFvh7bgzZE6jA==
Date: Tue, 27 Feb 2018 17:31:33 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: dns_resolver_preparse tries to print arbitrarily-large
 user-provided strings
Message-ID: <20180228013133.GA251056@gmail.com>
References: <20180227164313.g7dt7bd73shyedr2@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227164313.g7dt7bd73shyedr2@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1S1VksZ031721

Hi Mark,

On Tue, Feb 27, 2018 at 04:43:13PM +0000, Mark Rutland wrote:
> Hi,
> 
> As a heads-up, while fuzzing v4.16-rc3 on arm64 with Syzkaller, I hit a
> system hang which I was able to minize to the reproducer below. It looks
> like the system hang is an artifact of Syzkaller using panic_on_warn, as
> dns_resolver_preparse can trigger a WARN_ONCE() in the bowels of
> printk(), and we recurse on a lock that's already held.
> 
> The underlying issue is that dns_resolver_preparse() may try to dump an
> arbitrarily large chunk of user-provided data, even from an unprivileged
> user, while printk() has some internal limit on string precision.
> 
> On bare metal (without panic_on_warn), this means I get the following in
> my dmesg:
> 
> $ ./repro
> [   56.870339] Option '                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
> [   56.870350] ------------[ cut here ]------------
> [   56.870355] precision 1044478 too large
> [   56.870362] WARNING: CPU: 2 PID: 2450 at lib/vsprintf.c:2179 vsnprintf+0xdf0/0x1268
> [   56.870366] Modules linked in:
> [   56.870376] CPU: 2 PID: 2450 Comm: repro Not tainted 4.16.0-rc3-00002-g544c20187688-dirty #4
> [   56.870382] Hardware name: ARM Juno development board (r1) (DT)
> [   56.870386] pstate: 80000085 (Nzcv daIf -PAN -UAO)
> [   56.870390] pc : vsnprintf+0xdf0/0x1268
> [   56.870394] lr : vsnprintf+0xdf0/0x1268
> [   56.870398] sp : ffff80092b41f6f0
> [   56.870401] x29: ffff80092b41f6f0 x28: ffff20000b093f36
> [   56.870411] x27: 00000000000003e0 x26: 0000000000000002
> [   56.870421] x25: 00000000000feffe x24: 1ffff00125683eee
> [   56.870431] x23: ffff20000a433200 x22: ffff20000bc5f3c0
> [   56.870440] x21: dfff200000000000 x20: ffff20000bc5efea
> [   56.870450] x19: ffff20000a4329ce x18: 0000ffffc51e5860
> [   56.870459] x17: 0000000000411018 x16: ffff200008957d28
> [   56.870469] x15: 00000000f2000000 x14: ffff20000aa0a6c0
> [   56.870479] x13: 0000000000000000 x12: ffff20000aa0a000
> [   56.870488] x11: 1ffff00126eda462 x10: ffff100126eda462
> [   56.870498] x9 : dfff200000000000 x8 : 0000000000000000
> [   56.870507] x7 : ffff8009376d2311 x6 : ffff8009376d2312
> [   56.870517] x5 : ffff100126eda463 x4 : ffff100126eda463
> [   56.870526] x3 : 0000000000000000 x2 : 0000000000000001
> [   56.870536] x1 : fdb9418241605c00 x0 : 0000000000000000
> [   56.870545] Call trace:
> [   56.870549]  vsnprintf+0xdf0/0x1268
> [   56.870553]  vscnprintf+0x48/0x88
> [   56.870556]  vprintk_emit+0xac/0x5f0
> [   56.870560]  vprintk_default+0x44/0x50
> [   56.870564]  vprintk_func+0x3dc/0x630
> [   56.870568]  printk+0xbc/0xec
> [   56.870572]  dns_resolver_preparse+0x5bc/0x6e8
> [   56.870576]  key_create_or_update+0x298/0x828
> [   56.870580]  SyS_add_key+0x110/0x3c8
> [   56.870584]  el0_svc_naked+0x30/0x34
> [   56.870589] ---[ end trace 2b46801cfa43d927 ]---
> 
> Any ideas on how to avoid this?
> 
> Thanks,
> Mark.
> 
> ---->8----
> #include <sys/syscall.h>
> #include <unistd.h>
> 
> #define BUF_SIZE 0xff000
> 
> static char buf[BUF_SIZE] = {
> 	[0] = '#',
> 	[1 ... BUF_SIZE - 2] = 'a'
> };
> 
> int main()
> {
> 	syscall(__NR_add_key, "dns_resolver", "a", buf, BUF_SIZE, -1);
> 	return 0;
> }
> 

Thanks for the bug report.  At the very least I think dns_resolver_preparse()
should limit the option string lengths.  After all, the only accepted option
currently is "dnserror".  I'll send a patch.

Eric
