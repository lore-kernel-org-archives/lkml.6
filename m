Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92888C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4874222453
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4874222453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeGGHyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:54:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeGGHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:54:02 -0400
Received: from localhost (unknown [37.170.5.79])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A587AD2;
        Sat,  7 Jul 2018 07:54:01 +0000 (UTC)
Date:   Sat, 7 Jul 2018 09:22:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Todd Poynor <toddpoynor@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/gasket: Use refcount_read()
Message-ID: <20180707072224.GA9377@kroah.com>
References: <20180707064310.199121-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707064310.199121-1-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:43:10PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Use the refcount_read accessor function, avoid reaching into refcount
> and atomic struct fields.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
> index d45098c90b4b..b5cdc180772a 100644
> --- a/drivers/staging/gasket/gasket_sysfs.c
> +++ b/drivers/staging/gasket/gasket_sysfs.c
> @@ -122,7 +122,7 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
>  	}
>  
>  	mutex_lock(&mapping->mutex);
> -	if (mapping->refcount.refcount.refs.counter == 0)
> +	if (refcount_read(&mapping->refcount.refcount) == 0)
>  		gasket_nodev_error("Refcount is already 0!");
>  	if (kref_put(&mapping->refcount, release_entry)) {
>  		gasket_nodev_info("Removing Gasket sysfs mapping, device %s",

Thanks for the patch, but ugh, why in the world is this driver even
doing this type of thing?  Odds are all of these reference counting
checks can be removed, something else to add to the "todo" file...

thanks,

greg k-h
