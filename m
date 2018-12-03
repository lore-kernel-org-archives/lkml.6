Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F185C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC2C20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC2C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeLCOPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:15:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:56424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbeLCOPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:15:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AEB1AD17;
        Mon,  3 Dec 2018 14:14:36 +0000 (UTC)
Date:   Mon, 3 Dec 2018 15:14:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: don't unconditionally shortcut print_time()
Message-ID: <20181203141435.iyaawog4i6ecgxyi@pathway.suse.cz>
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
 <201811300226.wAU2Q2JG060388@www262.sakura.ne.jp>
 <20181130123027.cyqfi2k34nh2gjmx@pathway.suse.cz>
 <02b4ce85-c1e5-6601-e3a7-cecfbd5298dc@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b4ce85-c1e5-6601-e3a7-cecfbd5298dc@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-11-30 23:33:39, Tetsuo Handa wrote:
> and (I can't find the reproducer but) sometimes crashes like
> 
> [  451.988242] BUG: pagefault on kernel address 0xffff8881337fa000 in non-whitelisted uaccess
> [  451.990465] BUG: unable to handle kernel paging request at ffff8881337fa000
> [  451.992254] PGD 3602067 P4D 3602067 PUD 3605067 PMD 13ff65067 PTE 800ffffecc805060
> [  451.994066] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
> [  451.995284] CPU: 0 PID: 8147 Comm: a.out Kdump: loaded Not tainted 4.20.0-rc4+ #537
> [  451.997268] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
> [  451.999857] RIP: 0010:copy_user_generic_unrolled+0x54/0xc0
> [  452.001312] Code: 83 e2 3f c1 e9 06 74 4a 4c 8b 06 4c 8b 4e 08 4c 8b 56 10 4c 8b 5e 18 4c 89 07 4c 89 4f 08 4c 89 57 10 4c 89 5f 18 4c 8b 46 20 <4c> 8b 4e 28 4c 8b 56 30 4c 8b 5e 38 4c 89 47 20 4c 89 4f 28 4c 89
> [  452.006119] RSP: 0018:ffffc90002573e90 EFLAGS: 00010202
> [  452.007230] RAX: 0000000000701060 RBX: 0000000000100000 RCX: 0000000000002f02
> [  452.008792] RDX: 0000000000000000 RSI: ffff8881337f9fd4 RDI: 0000000000644fe0
> [  452.010399] RBP: 0000000000601060 R08: 8b494e7401000000 R09: 00000b88858b4900
> [  452.011916] R10: 0f02000000c980f6 R11: b4bb830000025d85 R12: ffff8881337b6054
> [  452.013351] R13: 0000000000601060 R14: ffff8881337b5fa8 R15: 00000000000000ac
> [  452.014807] FS:  00007fb3c9eec740(0000) GS:ffff88813b200000(0000) knlGS:0000000000000000
> [  452.016931] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  452.018234] CR2: ffff8881337fa000 CR3: 0000000139153002 CR4: 00000000001606f0
> [  452.020038] Call Trace:
> [  452.020708]  _copy_to_user+0x56/0x70
> [  452.021580]  do_syslog+0x47d/0x7b0
> [  452.022359]  ? syscall_trace_enter+0x1c3/0x360
> [  452.023395]  ? trace_hardirqs_on_thunk+0x1a/0x1c
> [  452.024438]  ? lockdep_hardirqs_off+0x73/0xe0
> [  452.025433]  __x64_sys_syslog+0x13/0x20
> [  452.026363]  do_syscall_64+0x4f/0x1f0
> [  452.027235]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> >  			/* message fits into buffer, move forward */
> >  			syslog_idx = log_next(syslog_idx);
> 
> But we need to make this "static bool time;" accessible from SYSLOG_ACTION_SIZE_UNREAD case
> because syslog_partial subtraction assumes that msg_print_text() used printk_time value
> as of syslog_print() updated syslog_partial.
> 
> 	while (seq < log_next_seq) {
> 		struct printk_log *msg = log_from_idx(idx);
> 
> 		error += msg_print_text(msg, true, NULL, 0);
> 		idx = log_next(idx);
> 		seq++;
> 	}
> 	error -= syslog_partial;
> 

Great catch.

Well, IMHO, it does not explain the pagefault above. The copy_to_user()
could come either from syslog_print() or from syslog_print_all(). They
both have their own checks that prevent the buf overflow.

The code is tricky but it looks safe now. Is it possible that
the crash was with some old, still broken, code? Or did you
add some extra changes that you used to trigger a testing
scenario?

Best Regards,
Petr
