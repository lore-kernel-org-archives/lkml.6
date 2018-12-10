Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CE1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1862084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1862084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeLJSRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbeLJSRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:17:33 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C87720672;
        Mon, 10 Dec 2018 18:17:31 +0000 (UTC)
Date:   Mon, 10 Dec 2018 13:17:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org
Subject: Re: [PATCH v4] panic: Avoid the extra noise dmesg
Message-ID: <20181210131729.04b8e0d3@gandalf.local.home>
In-Reply-To: <1544176279-77828-1-git-send-email-feng.tang@intel.com>
References: <1544176279-77828-1-git-send-email-feng.tang@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Dec 2018 17:51:19 +0800
Feng Tang <feng.tang@intel.com> wrote:

> When kernel panic happens, it will first print the panic call stack,
> then the ending msg like:
> 
> [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> [   35.749975] ------------[ cut here ]------------
> 
> The above message are very useful for debugging.
> 
> But if system is configured to not reboot on panic, say the "panic_timeout"
> parameter equals 0, it will likely print out many noisy message like
> WARN() call stack for each and every CPU except the panic one, messages
> like below:


> Keeping the interrupt disabled will avoid the noisy message.
> 
> When code runs to this point, it means user has chosed to not reboot, or
> do any special handling by using the panic notifier method, the only reason
> to enable the interrupt may be sysrq migic key and panic_blink function
> (though may not work even with irq enabled). 
> 
> So make the irq disabled by default and add a cmdline parameter
> "panic_keep_irq_on" to turn it on when needed.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
