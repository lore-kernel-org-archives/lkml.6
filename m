Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC70C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E328214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E328214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeHBKr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:47:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeHBKr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:47:28 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 21BD574;
        Thu,  2 Aug 2018 08:57:15 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:57:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] staging: gasket: core: print driver version code at
 registration time
Message-ID: <20180802085706.GA23992@kroah.com>
References: <20180802084245.239689-1-toddpoynor@gmail.com>
 <20180802084245.239689-3-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802084245.239689-3-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 01:42:39AM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Print the driver version code in the kernel log at gasket driver
> registration time for informational purposes.  Add "gasket:" prefix to
> make clear it is the gasket framework logging this information.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index f76f4a0ecbac6..e550c9060dcd2 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -1759,8 +1759,9 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
>  	}
>  	mutex_unlock(&g_mutex);
>  
> -	pr_info("Loaded %s driver, framework version %s\n",
> -		driver_desc->name, GASKET_FRAMEWORK_VERSION);
> +	pr_info("gasket: Loaded %s driver version %s, framework version %s\n",
> +		driver_desc->name, driver_desc->driver_version,
> +		GASKET_FRAMEWORK_VERSION);

This is what pr_fmt is for, please just set that properly and all will
be fine.

But really, just delete this line, drivers, if all is going well, should
not emit any noise to the kernel log.  Especially for something like
doing a 'modprobe', which is really what is happening here.  Just drop
the noisy messages please.

Also, GASKET_FRAMEWORK_VERSION means nothing now, it needs to be dropped :)

thanks,

greg k-h
