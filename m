Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C073C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112A520878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547254391;
	bh=2AK5mFxBvJ2lWr2n0C2PUbDTRP7PiPrT/iZ0rdJxoYo=;
	h=Date:From:To:Subject:List-ID:From;
	b=w0ZRQFJ4JhM30k4hpGyGMua67TVGqaC254s/mfurr114RoZ+YHvvJ92+9HP5FX3LU
	 ym9wM0lyLBylKbEOa0+m7IL/EwaL6caFKhbDl2+lMKea1Qs3URrujSH6E+agcMwvL7
	 MYzGHQVxAxyIqWqaSZx8ABrYHqlrVBrkT2V/RqJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfALAxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:32768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbfALAxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:53:08 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E864220872;
        Sat, 12 Jan 2019 00:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547254388;
        bh=2AK5mFxBvJ2lWr2n0C2PUbDTRP7PiPrT/iZ0rdJxoYo=;
        h=Date:From:To:Subject:From;
        b=Zwmdc0+9nZfkxLf7tCx0uyTFaFxPOr3gOYRbcUiEoAVLdKfI1l4gj0TnPWWftkIG2
         v07CJW+2CrxNNmPovufmrGhx+XIC+c+Ng1ca0yoS60Num9kSraSUWSSuWvUrxKLH6F
         tnS3ei8hsHxpdBpei12654K++f1VyA7RcINLnbWM=
Date:   Fri, 11 Jan 2019 16:53:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Bug (since v4.20): integer underflow in known_siginfo_layout() when
 sig=0
Message-ID: <20190112005305.GB77447@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

The following commit, which went into v4.20, introduced undefined behavior when
sys_rt_sigqueueinfo() is called with sig=0:

commit 4ce5f9c9e7546915c559ffae594e6d73f918db00
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Tue Sep 25 12:59:31 2018 +0200

    signal: Use a smaller struct siginfo in the kernel

In sig_specific_sicodes(), used from known_siginfo_layout(), the expression
'1ULL << ((sig)-1)' is undefined as it evaluates to 1ULL << 4294967295.

Reproducer:

#include <signal.h>
#include <sys/syscall.h>
#include <unistd.h>

int main(void)
{
	siginfo_t si = { .si_code = 1 };
	syscall(__NR_rt_sigqueueinfo, 0, 0, &si);
}

UBSAN report for v5.0-rc1:

UBSAN: Undefined behaviour in kernel/signal.c:2946:7
shift exponent 4294967295 is too large for 64-bit type 'long unsigned int'
CPU: 2 PID: 346 Comm: syz_signal Not tainted 5.0.0-rc1 #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x70/0xa5 lib/dump_stack.c:113
 ubsan_epilogue+0xd/0x40 lib/ubsan.c:159
 __ubsan_handle_shift_out_of_bounds+0x12c/0x170 lib/ubsan.c:425
 known_siginfo_layout+0xae/0xe0 kernel/signal.c:2946
 post_copy_siginfo_from_user kernel/signal.c:3009 [inline]
 __copy_siginfo_from_user+0x35/0x60 kernel/signal.c:3035
 __do_sys_rt_sigqueueinfo kernel/signal.c:3553 [inline]
 __se_sys_rt_sigqueueinfo kernel/signal.c:3549 [inline]
 __x64_sys_rt_sigqueueinfo+0x31/0x70 kernel/signal.c:3549
 do_syscall_64+0x4c/0x1b0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x433639
Code: c4 18 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 27 00 00 c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffcb289fc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000081
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000433639
RDX: 00007fffcb289fd0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006b2018 R08: 000000000000004d R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401560
R13: 00000000004015f0 R14: 0000000000000000 R15: 0000000000000000
