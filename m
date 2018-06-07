Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id U7/SF0ucGVuXOwAAmS7hNA
	; Thu, 07 Jun 2018 20:58:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 780176074D; Thu,  7 Jun 2018 20:58:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0320E60452;
	Thu,  7 Jun 2018 20:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0320E60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933225AbeFGU5e (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:57:34 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34422 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933067AbeFGU5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:57:31 -0400
Received: from localhost (unknown [66.187.232.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 967781086A89D;
        Thu,  7 Jun 2018 13:57:29 -0700 (PDT)
Date: Thu, 07 Jun 2018 16:57:27 -0400 (EDT)
Message-Id: <20180607.165727.864700268719773969.davem@davemloft.net>
To: ast@kernel.org
Cc: daniel@iogearbox.net, mcgrof@kernel.org, netdev@vger.kernel.org,
        dvyukov@google.com, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH net-next] umh: fix race condition
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180607172310.3121039-1-ast@kernel.org>
References: <20180607172310.3121039-1-ast@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Jun 2018 13:57:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Thu, 7 Jun 2018 10:23:10 -0700

> kasan reported use-after-free:
> BUG: KASAN: use-after-free in call_usermodehelper_exec_work+0x2d3/0x310 kernel/umh.c:195
> Write of size 4 at addr ffff8801d9202370 by task kworker/u4:2/50
> Workqueue: events_unbound call_usermodehelper_exec_work
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_store4_noabort+0x17/0x20 mm/kasan/report.c:437
>  call_usermodehelper_exec_work+0x2d3/0x310 kernel/umh.c:195
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> 
> The reason is that 'sub_info' cannot be accessed out of parent task
> context, since it will be freed by the child.
> Instead remember the pid in the child task.
> 
> Fixes: 449325b52b7a ("umh: introduce fork_usermode_blob() helper")
> Reported-by: syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Applied.
