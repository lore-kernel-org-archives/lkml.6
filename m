Return-Path: <richard@sigma-star.at>
X-Google-Smtp-Source: AH8x2266pdwqRE/6ir60/u4jEtBTPEeqWIXFnC3caTIuBCT/FHQlou6jTe0maWJqp++ycMTqtf4+
ARC-Seal: i=1; a=rsa-sha256; t=1518736275; cv=none;
        d=google.com; s=arc-20160816;
        b=isgJ53iBfBxPC2Nq8L7h2wB1dsDUsqGqVQGhXqj3XB2DCviiLS06XcqoL/GG/B9Zu5
         F7ss+6QW9KNmeZiduUetcrnMQiDiQrqfalsVdnYNoJ5hrPJoAbpFGZHmjHE8YZ27811s
         +Wm+4yaoS/dr316xKULB90WxkZwYTSwdnX6GrCMLU5oz4PJVnzk95+8/6eT+VZ49zaqu
         nDIXWr5VWx3rgjjfpFu92P0iGvi9skxE7w9PAcVTXFZ4c4V69VW7gi9LbpFiGxZd7NNT
         CTba9TAZVqc/PbvFJKkN51lr2AoFBuzzHcyMgiNzYpb3y0kh4m7tiKylv8lrxLCI2dYz
         jESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=lLAOtgRQzQAWU9cBtMhUG2pReTsOWKGYnhwCYGXvwu4=;
        b=RQpXU42J62KVENutKcLOkh//fN+pCZuaUwUPUmo6NksO9+fooW/d+KxqhFIL6Hh3Qq
         dsWNvdX9fJcwZMJPX81qcE4AftayJOPthtcYhoQY23ck/TIJbIVqFQuR1NEVvhB7DFr5
         GIRZ34tfmijki1r5NMECD4duP1w8wfeQ5BNOH+ZllIc/ijLAZTo3By9TYTb1iLKxBjwk
         RIch0+35+7K6CPLhbAScSsPpDSQjs8zT1pBVEuQ+IXcz441ZvpMJ4cV1V41lNPndalSo
         o2yz+sXDhMHdxDCX4JZXiVHP/x8YNEy9Uiu+QizhRhnm+NinTm9mFSXqI9esSViLkvjO
         lKfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of richard@sigma-star.at designates 109.75.188.150 as permitted sender) smtp.mailfrom=richard@sigma-star.at
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of richard@sigma-star.at designates 109.75.188.150 as permitted sender) smtp.mailfrom=richard@sigma-star.at
From: Richard Weinberger <richard@sigma-star.at>
To: dwmw@amazon.co.uk
Cc: mingo@kernel.org, luto@kernel.org, arjan@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com, dave.hansen@linux.intel.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com, torvalds@linux-foundation.org, peterz@infradead.org, tglx@linutronix.de, arjan.van.de.ven@intel.com, dave.hansen@intel.com, jmattson@google.com, karahmed@amazon.de, kvm@vger.kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com, sironi@amazon.de, linux-kernel@vger.kernel.org
Subject: Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()" crashes KVM guest
Date: Fri, 16 Feb 2018 00:12:00 +0100
Message-ID: <1753460.Vme2X1QhPT@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592510409183573045?=
X-GMAIL-MSGID: =?utf-8?q?1592510409183573045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi!

commit f208820a321f9b23d77d7eed89945d862d62a3ed
Author: David Woodhouse <dwmw@amazon.co.uk>
Date:   Sat Feb 10 23:39:23 2018 +0000

    Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()"
    
    This reverts commit 64e16720ea0879f8ab4547e3b9758936d483909b.
    
    We cannot call C functions like that, without marking all the
    call-clobbered registers as, well, clobbered. We might have got away
    with it for now because the __ibp_barrier() function was *fairly*
    unlikely to actually use any other registers. But no. Just no.

causes a crash here. When I revert this revert on top of Linus' tree, it works fine.
Host is v4.13 + qemu-2.9.1 (openSUSE).

[    2.776181] general protection fault: 0000 [#1] SMP PTI
[    2.777146] Modules linked in:
[    2.777422] CPU: 1 PID: 1208 Comm: systemd-journal Not tainted 4.16.0-rc1+ #111
[    2.778079] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[    2.778988] RIP: 0010:switch_mm_irqs_off+0x2f1/0x3c0
[    2.779372] RSP: 0018:ffffac6f0053bd60 EFLAGS: 00010097
[    2.779808] RAX: 0000000000000001 RBX: ffff99c9ba6c5dc0 RCX: 0000000000000049
[    2.780490] RDX: 0000000000000000 RSI: ffff99c9ba6c5dc0 RDI: ffff99c9baac6e40
[    2.781087] RBP: 0000000000000001 R08: 0000000000000202 R09: 0000000000000000
[    2.781739] R10: 0000000000000001 R11: 0000000000000000 R12: ffff99c9baac6e40
[    2.782400] R13: ffff99c9bc509c40 R14: ffff99c9ba6c5dc0 R15: ffff99c9baac6e40
[    2.783000] FS:  00007f410fff3840(0000) GS:ffff99c9bfc80000(0000) knlGS:0000000000000000
[    2.783630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.784059] CR2: 00007f410df0d000 CR3: 000000007a8f4000 CR4: 00000000000006e0
[    2.784606] Call Trace:
[    2.784807]  __schedule+0x20e/0x6d0
[    2.785083]  schedule+0x23/0x80
[    2.785331]  schedule_hrtimeout_range_clock+0x158/0x170
[    2.785744]  ? ep_scan_ready_list.constprop.16+0x1de/0x1e0
[    2.786178]  ? file_has_perm+0x57/0x90
[    2.786472]  ep_poll+0x26f/0x370
[    2.786730]  ? wake_up_q+0x70/0x70
[    2.786998]  SyS_epoll_wait+0xb8/0xd0
[    2.787285]  do_syscall_64+0x5c/0x110
[    2.787575]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[    2.787967] RIP: 0033:0x7f410f904be3
[    2.788245] RSP: 002b:00007ffff3e65c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
[    2.788828] RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 00007f410f904be3
[    2.789376] RDX: 000000000000000f RSI: 00007ffff3e65c60 RDI: 0000000000000007
[    2.789919] RBP: 00007ffff3e65e40 R08: 00000000000216c7 R09: 00000000ff9746cd
[    2.790466] R10: 00000000ffffffff R11: 0000000000000246 R12: 000055b4dd2270d0
[    2.791009] R13: 000055b4dd2270f0 R14: 000055b4dd2270b0 R15: 00007ffff3e65c60
[    2.791518] Code: 8b 45 00 49 8b 7d 08 49 83 c5 18 31 d2 31 f6 ff d0 49 8b 45 00 48 85 c0 75 e9 eb b1 b9 49 00 00 00 b8 01 00 00 00 ba 00 00 00 00 <0f> 30 e9 68 fd ff ff 9c 58 0f 1f 44 00 00 48 89 c5 fa 66 0f 1f 
[    2.792931] RIP: switch_mm_irqs_off+0x2f1/0x3c0 RSP: ffffac6f0053bd60
[    2.793518] ---[ end trace eb29cfddc2907c66 ]---

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
