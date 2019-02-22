Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36785C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09F4207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550824071;
	bh=8edfktwJBuX3vEVcGO3bmC4PE498wHxd4TksCyJ72xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qpR3sd0WWc1DBWwkreoejiw72QjVGMy6BL3zWsiRRrhkvyhxrwQjNa1SSkTyIGC9g
	 cHiEk2M54oidgxqIWvsEUl3rnvjuC5wniQhJg3x2WmGtH3MIbfsKfoSVO8XCyRZnWJ
	 RXod+CEc+msD4MPrrTzbIk19klQQXmZzLMiJ3SHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfBVI1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:32834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfBVI1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:27:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D847A20700;
        Fri, 22 Feb 2019 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550824068;
        bh=8edfktwJBuX3vEVcGO3bmC4PE498wHxd4TksCyJ72xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YY7+ejk6GcXseVv8exsO3JbAQTxPjz+xmlakcjcRe+lq8hvGyW3jlPh0SAM9CfMAd
         Wlfgn7qGe1FVbrUtwrEMhIS0nF6WGD5OERKJ/cN1oekhp+69uFGvho7uhtOi82a5dR
         PcBhXWem0TmZATGTlYzjmnHtAlYsYNEDagcgN82Y=
Date:   Fri, 22 Feb 2019 09:27:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: core: add option of only authorizing internal
 devices
Message-ID: <20190222082744.GA6963@kroah.com>
References: <20190217072151.GA244815@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217072151.GA244815@dtor-ws>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 11:21:51PM -0800, Dmitry Torokhov wrote:
> On Chrome OS we want to use USBguard to potentially limit access to USB
> devices based on policy. We however to do not want to wait for userspace to
> come up before initializing fixed USB devices to not regress our boot
> times.
> 
> This patch adds option to instruct the kernel to only authorize devices
> connected to the internal ports. Previously we could either authorize
> all or none (or, by default, we'd only authorize wired devices).
> 
> The behavior is controlled via usbcore.authorized_default command line
> option.
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  3 +-
>  Documentation/usb/authorization.txt           |  4 +-
>  drivers/usb/core/hcd.c                        | 51 +++++++++++--------
>  drivers/usb/core/usb.c                        | 33 +++++++++---
>  include/linux/usb/hcd.h                       | 10 ++--
>  5 files changed, 69 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index aefd358a5ca3..4446919089b9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4675,7 +4675,8 @@
>  	usbcore.authorized_default=
>  			[USB] Default USB device authorization:
>  			(default -1 = authorized except for wireless USB,
> -			0 = not authorized, 1 = authorized)
> +			0 = not authorized, 1 = authorized, 2 = authorized
> +			if device connected to internal port)

Oh nice, another "simple" flag modified over time to be more complex :(

Anyway, that's fine, it's how APIs grow, just grumpy...

This all looks good to me, I'll go queue it up now.

greg k-h
