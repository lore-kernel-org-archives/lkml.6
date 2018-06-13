Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6FBC3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252C6208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252C6208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935460AbeFMTB6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935135AbeFMTB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:01:57 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618C7208C3;
        Wed, 13 Jun 2018 19:01:56 +0000 (UTC)
Date:   Wed, 13 Jun 2018 15:01:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] vsprintf: Add command line option
 debug_boot_weak_hash
Message-ID: <20180613150154.61b52e05@gandalf.local.home>
In-Reply-To: <1528763954-27731-5-git-send-email-me@tobin.cc>
References: <1528763954-27731-1-git-send-email-me@tobin.cc>
        <1528763954-27731-5-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 10:39:14 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:


> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index c445f9f28760..6d2479eb7c2b 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1651,6 +1651,18 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +/* Make pointers available for printing early in the boot sequence. */
> +static int debug_boot_weak_hash __ro_after_init;
> +EXPORT_SYMBOL(debug_boot_weak_hash);


I was too busy trying to make this use a static_branch, that I forgot
to mention this in my review.

Why did you add that EXPORT_SYMBOL()? It's useless with a static
variable. I think you can nuke that line.

-- Steve
