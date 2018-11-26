Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7699BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AFF208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AFF208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeK0KUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:20:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeK0KUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:20:45 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3D2B96C;
        Mon, 26 Nov 2018 23:24:59 +0000 (UTC)
Date:   Mon, 26 Nov 2018 15:24:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] panic: Add options to dump system info when panic
 happens
Message-Id: <20181126152457.42f9917138e02b4ab9f17f7b@linux-foundation.org>
In-Reply-To: <1542870631-77074-1-git-send-email-feng.tang@intel.com>
References: <1542870631-77074-1-git-send-email-feng.tang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 15:10:31 +0800 Feng Tang <feng.tang@intel.com> wrote:

> Kernel panic issues are always painful to debug, partially
> because of it's not easy to get enough information of the
> context when panic happens.
> 
> And we have ramoops and kdump for that, while this commit
> tries to a easier way to show the system info by adding a
> cmdline parameter, referring some idea from sysrq handler.
> 

This seems sensible to me.

> This patch is frequently used by us when debugging panic and system
> stability bugs, and does help much. And the options could be expanded
> more to cover other info like the ftrace, signal etc.

And that info is valuable.

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3081,6 +3081,13 @@
>  			timeout < 0: reboot immediately
>  			Format: <timeout>
>  
> +	panic_dump=	Bitmask for dumping system info when panic happens.
> +			User can chose combination of the following bits:
> +			bit 0: dump all tasks info
> +			bit 1: dump system memory info
> +			bit 2: dump timer info
> +			bit 3: dump locks info if CONFIG_LOCKDEP is on
> +

Using "dump" makes this feature sounds a bit like kdump, which is also
used in this code context.

I think I'd prefer that we use "print" - that's a more accurate
description and avoids such confusion.  So s/dump/print/ and
s/DUMP/PRINT/ throughout the changelog and patch?

