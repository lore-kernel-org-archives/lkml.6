Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5590EC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061FE20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061FE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeGIN2B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:28:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:54344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750996AbeGIN17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:27:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86FA2ACE7;
        Mon,  9 Jul 2018 13:27:58 +0000 (UTC)
Date:   Mon, 9 Jul 2018 15:27:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] printk: Deadlock in NMI regression
Message-ID: <20180709132757.cpfwn5qcgonzhhhi@pathway.suse.cz>
References: <20180627140817.27764-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627140817.27764-1-pmladek@suse.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-27 16:08:14, Petr Mladek wrote:
> The commit 719f6a7040f1bdaf96 ("printk: Use the main logbuf in NMI
> when logbuf_lock is available") brought back the possible deadlocks
> in printk() and NMI.
> 
> This is rework of the proposed fix, see
> https://lkml.kernel.org/r/20180606111557.xzs6l3lkvg7lq3ts@pathway.suse.cz
> 
> I realized that we could rather easily move the check to vprintk_func()
> and still avoid any race. I believe that this is a win-win solution.
> 
> 
> Changes against v1:
> 
>   + Move the check from vprintk_emit() to vprintk_func()
>   + More straightforward commit message
>   + Fix build with CONFIG_PRINTK_NMI disabled
> 
> 
> Petr Mladek (3):
>   printk: Split the code for storing a message into the log buffer
>   printk: Create helper function to queue deferred console handling
>   printk/nmi: Prevent deadlock when accessing the main log buffer in NMI
> 
>  include/linux/printk.h      |  4 ++++
>  kernel/printk/internal.h    |  9 ++++++-
>  kernel/printk/printk.c      | 57 +++++++++++++++++++++++++++-----------------
>  kernel/printk/printk_safe.c | 58 +++++++++++++++++++++++++++++----------------
>  kernel/trace/trace.c        |  4 +++-
>  lib/nmi_backtrace.c         |  3 ---
>  6 files changed, 87 insertions(+), 48 deletions(-)

JFYI, I have renamed the new function defer_console() to
defer_console_output() and pushed everything to printk.git,
branch for-4.19-nmi.

Best Regards,
Petr
