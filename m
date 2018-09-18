Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59E4ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796652146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796652146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbeISCxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:53:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43678 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISCxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:53:45 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5853111E7;
        Tue, 18 Sep 2018 21:19:18 +0000 (UTC)
Date:   Tue, 18 Sep 2018 14:19:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <zhe.he@windriver.com>
Cc:     <mhocko@suse.com>, <vbabka@suse.cz>, <pasha.tatashin@oracle.com>,
        <mgorman@techsingularity.net>, <aaron.lu@intel.com>,
        <osalvador@suse.de>, <iamjoonsoo.kim@lge.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_alloc: Fix panic caused by passing
 debug_guardpage_minorder or kernelcore to command line
Message-Id: <20180918141917.2cb16b01c122dbe1ead2f657@linux-foundation.org>
In-Reply-To: <1537284788-428784-1-git-send-email-zhe.he@windriver.com>
References: <1537284788-428784-1-git-send-email-zhe.he@windriver.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 23:33:08 +0800 <zhe.he@windriver.com> wrote:

> From: He Zhe <zhe.he@windriver.com>
> 
> debug_guardpage_minorder_setup and cmdline_parse_kernelcore do not check
> input argument before using it. The argument would be a NULL pointer if
> "debug_guardpage_minorder" or "kernelcore", without its value, is set in
> command line and thus causes the following panic.
> 
> PANIC: early exception 0xe3 IP 10:ffffffffa08146f1 error 0 cr2 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #1
> [    0.000000] RIP: 0010:parse_option_str+0x11/0x90
> ...
> [    0.000000] Call Trace:
> [    0.000000]  cmdline_parse_kernelcore+0x19/0x41
> [    0.000000]  do_early_param+0x57/0x8e
> [    0.000000]  parse_args+0x208/0x320
> [    0.000000]  ? rdinit_setup+0x30/0x30
> [    0.000000]  parse_early_options+0x29/0x2d
> [    0.000000]  ? rdinit_setup+0x30/0x30
> [    0.000000]  parse_early_param+0x36/0x4d
> [    0.000000]  setup_arch+0x336/0x99e
> [    0.000000]  start_kernel+0x6f/0x4ee
> [    0.000000]  x86_64_start_reservations+0x24/0x26
> [    0.000000]  x86_64_start_kernel+0x6f/0x72
> [    0.000000]  secondary_startup_64+0xa4/0xb0

From my quick reading, more than half of the __setup handlers in mm/
will crash in the same way if misused in this fashion.

> This patch adds a check to prevent the panic and adds KBUILD_MODNAME to
> prints.

So a better solution might be to add a check into the calling code
(presumably in init/main.c) to print a warning if we have kernel
command line arguments such as "kernelcore=".  That way, users will see
the warning immediately before the oops and will know how to fix things
up.

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -14,6 +14,8 @@
>   *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/stddef.h>
>  #include <linux/mm.h>
>  #include <linux/swap.h>
> @@ -630,6 +632,11 @@ static int __init debug_guardpage_minorder_setup(char *buf)
>  {
>  	unsigned long res;
>  
> +	if (!buf) {
> +		pr_err("Config string not provided\n");

If were going to do it this way, we should tell the operator which
argument was bad.  pr_err("kernel option debug_guardpage_minorder
requires an argument").

And then perhaps we should just let the kernel crash anyway.  That
seems better than hoping that the user will notice that line in the
logs one day.  

And note that the preceding two paragraphs will produce the same result
as my do-it-in-init/main.c suggestion!

