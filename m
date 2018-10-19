Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C4EECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C48521470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C48521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJTAEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:04:30 -0400
Received: from www62.your-server.de ([213.133.104.62]:34822 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbeJTAE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:04:29 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gDX9k-0007Nt-91; Fri, 19 Oct 2018 17:57:44 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gDX9k-000XcM-3h; Fri, 19 Oct 2018 17:57:44 +0200
Subject: Re: KASAN: use-after-free Read in sk_psock_link_pop
To:     syzbot <syzbot+1651eee005f9de26ec35@syzkaller.appspotmail.com>,
        davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000a6391e057896e940@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a00a16c1-22dc-a46d-d937-50cd7d082d91@iogearbox.net>
Date:   Fri, 19 Oct 2018 17:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000a6391e057896e940@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/25051/Fri Oct 19 14:59:20 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2018 05:54 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    3a3295bfa6f4 Merge branch 'sctp-fix-sk_wmem_queued-and-use..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10a09791400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=133950703f7759f9
> dashboard link: https://syzkaller.appspot.com/bug?extid=1651eee005f9de26ec35
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1651eee005f9de26ec35@syzkaller.appspotmail.com
> 
> __nla_parse: 2 callbacks suppressed
> netlink: 20 bytes leftover after parsing attributes in process `syz-executor0'.
> ==================================================================
> BUG: KASAN: use-after-free in __lock_acquire+0x37c2/0x4ec0 kernel/locking/lockdep.c:3290
> Read of size 8 at addr ffff8801bcae2ff8 by task syz-executor3/30186
> 
> CPU: 0 PID: 30186 Comm: syz-executor3 Not tainted 4.19.0-rc7+ #266
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  __lock_acquire+0x37c2/0x4ec0 kernel/locking/lockdep.c:3290
>  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
>  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
>  spin_lock_bh include/linux/spinlock.h:334 [inline]
[...]

Looking into it ...
