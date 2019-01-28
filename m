Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9FDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A30B2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfA1SFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:05:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfA1SFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:05:48 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F24D62548;
        Mon, 28 Jan 2019 18:05:46 +0000 (UTC)
Date:   Mon, 28 Jan 2019 10:05:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH v2] sysctl: Add panic-fatal-signals
Message-Id: <20190128100545.b62193aa8f49e1de8d6ea8b7@linux-foundation.org>
In-Reply-To: <20190128084959.13060-1-vincent.whitchurch@axis.com>
References: <20190128084959.13060-1-vincent.whitchurch@axis.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 09:49:59 +0100 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> Add a sysctl which asks the kernel to panic when any userspace process
> receives a fatal signal which would trigger a core dump.  This has
> proven to be quite useful when debugging problems seen during testing of
> embedded systems:  When combined with kernel core dumps (saved due to
> the panic), it allows easier debugging of crashes which have their
> origin in system-wide problems such as buggy drivers or other kernel or
> hardware-related issues.
> 
> The crashing process's core dump can be extracted from the kernel core
> dump using tools such as the crash utility's gcore extension.
> 

I can't speak to the usefulness of this, but the feature is small and
simple.

Some documentation would be appreciated.  I assume in
Documentation/sysctl/kernel.txt.  Please also check that
print-fatal-signals is appropriately documented while we're in there -
it's documented in Documentation/admin-guide/kernel-parameters.rst but
not Documentation/sysctl/kernel.txt.

> v2: Put the sysctl behind a config option

I suppose so...  The option is root-only (surely?) so I'm not sure this
is really needed.

> ...
>
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1242,6 +1242,20 @@ config SYSCTL_SYSCALL
>  
>  	  If unsure say N here.
>  
> +config SYSCTL_PANIC_FATAL_SIGNALS
> +	bool "panic-fatal-signals sysctl" if EXPERT
> +	depends on PROC_SYSCTL
> +	help
> +	  If you say Y here, a kernel.panic-fatal-signals sysctl will be
> +	  offered.  If this sysctl is turned on, the kernel will panic if any
> +	  userspace process receives a fatal signal which would trigger a core
> +	  dump.
> +
> +	  When used together with kernel core dumps, this can be useful for
> +	  debugging some system-wide problems, primarily on embedded systems.
> +
> +	  If unsure, say N.

I suggest that the Kconfig help and the forthcoming documentation
should clearly explain the dangers of enabling this!

