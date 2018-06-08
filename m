Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TsWOObFAGlvwWAAAmS7hNA
	; Fri, 08 Jun 2018 08:39:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DBACC607DC; Fri,  8 Jun 2018 08:39:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2437860290;
	Fri,  8 Jun 2018 08:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2437860290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeFHIjK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:39:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbeFHIjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:39:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49018AC2E;
        Fri,  8 Jun 2018 08:39:07 +0000 (UTC)
Date: Fri, 8 Jun 2018 10:39:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH v2] printk: make sure to print log on console.
Message-ID: <20180608083906.fwx3r3y2pxtv3ga6@pathway.suse.cz>
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
 <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-06-01 14:26:42, Maninder Singh wrote:
> This patch make sure printing of log on console if loglevel
> at time of storing log is less than current console loglevel.
> 
> @why
> In SMP printk can work asynchronously, logs can be missed on console
> because it checks current log level at time of console_unlock,
> not at time of storing logs.
> 
> func()
> {
> ....
> ....
>         console_verbose();  // user wants to have all the logs on console.
>         pr_alert();
> 	dump_backtrace(); //prints with default loglevel.
>         ...
>         console_silent(); // stop all logs from printing on console.
> }
> 
> Now if console_lock was owned by another process, the messages might
> be handled after the consoles were silenced.

It might make sense to document the limitations reported by
Sergey. I mean to add something like:

"There are still some corner cases where this patch is not enough,
for example, when the messages are flushed later from printk_safe
buffers or when there are races between console_verbose() and
console_silent() callers."


> reused flag LOG_NOCONS as its usage is gone long back.
> (5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb)
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Anyway. the patch helps in many situations and it is a step in the right
direction:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: There is no need to resend the patch. I could update the commit
message when pushing the patch. I am just going to wait a bit for
other potential reviewers.
