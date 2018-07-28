Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360FBC6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD9720842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD9720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeG1ItX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:49:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37508 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeG1ItX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:49:23 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D407474;
        Sat, 28 Jul 2018 07:23:52 +0000 (UTC)
Date:   Sat, 28 Jul 2018 09:23:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Todd Poynor <toddpoynor@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: gasket: core: hold reference on device kobj
 while in use
Message-ID: <20180728072350.GA9809@kroah.com>
References: <20180728052200.228796-1-toddpoynor@gmail.com>
 <20180728052200.228796-6-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180728052200.228796-6-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:22:00PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Hold a reference on the struct device kobject while a pointer to that
> device is in use by gasket.
> 
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 859a6df9e12df..1dc7273e38734 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -449,6 +449,7 @@ static int gasket_alloc_dev(
>  	gasket_dev->dev_idx = dev_idx;
>  	snprintf(gasket_dev->kobj_name, GASKET_NAME_MAX, "%s", kobj_name);
>  	gasket_dev->dev = parent;
> +	kobject_get(&gasket_dev->dev->kobj);

Hint, if you are a driver, working with devices, you should never call a
kobject_* or sysfs_* call.  If you are, you are doing something really
wrong and odd and should seriously reconsider it.  No driver should ever
be touching a "raw" kobject.

For this case, get_device()/put_device() is what you should be using.

thanks,

greg k-h
