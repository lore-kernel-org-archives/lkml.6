Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAC0C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E10B24DEF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E10B24DEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeFXHJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:09:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeFXHJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:09:35 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWz93-0002cc-J3; Sun, 24 Jun 2018 09:09:09 +0200
Date:   Sun, 24 Jun 2018 09:09:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+a4eb8c7766952a1ca872@syzkaller.appspotmail.com>
cc:     ast@kernel.org, daniel@iogearbox.net,
        David Miller <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, kuznet@ms2.inr.ac.ru,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        x86@kernel.org, yoshfuji@linux-ipv6.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: BUG: unable to handle kernel paging request in
 bpf_int_jit_compile
In-Reply-To: <000000000000d48c8e056f5b6c67@google.com>
Message-ID: <alpine.DEB.2.21.1806240849150.8650@nanos.tec.linutronix.de>
References: <000000000000d48c8e056f5b6c67@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018, syzbot wrote:
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a4eb8c7766952a1ca872@syzkaller.appspotmail.com
> 
> RAX: ffffffffffffffda RBX: 0000000001429914 RCX: 0000000000455a99
> RDX: 0000000000000048 RSI: 0000000020000240 RDI: 0000000000000005
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
> R13: 00000000004bb7d5 R14: 00000000004c8508 R15: 0000000000000023
> BUG: unable to handle kernel paging request at ffffffffa0008002
> PGD 8e6d067 P4D 8e6d067 PUD 8e6e063 PMD 1b4528067 PTE 1d433d161
> Oops: 0003 [#1] SMP KASAN
> CPU: 1 PID: 4811 Comm: syz-executor0 Not tainted 4.18.0-rc1+ #114
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> 01/01/2011
> RIP: 0010:bpf_jit_binary_lock_ro include/linux/filter.h:703 [inline]
> RIP: 0010:bpf_int_jit_compile+0xc36/0xf30 arch/x86/net/bpf_jit_comp.c:1168

static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
{
        WARN_ON_ONCE(set_memory_ro((unsigned long)hdr, hdr->pages));
}

Qualitee. set_memory_ro() has legitimate reasons to fail, but sure it does
not most of the time.

So instead of implementing proper error handling, this adds complete bogus
wrappers. Hell, set_memory_*() have stub functions which return 0 for the
CONFIG_ARCH_HAS_SET_MEMORY=n case.

The unlock function is even more hilarious:

static inline void bpf_prog_unlock_ro(struct bpf_prog *fp)
{
        if (fp->locked) {
                WARN_ON_ONCE(set_memory_rw((unsigned long)fp, fp->pages));
                /* In case set_memory_rw() fails, we want to be the first
                 * to crash here instead of some random place later on.
                 */
                fp->locked = 0;
        }
}

Great approach for a facility, which deals with untrusted user space
stuff. Yeah. I know. The BPF mantra is: "Performance first"

I'm really tempted to make the BPF config switch depend on BROKEN. 

Thanks,

	tglx
