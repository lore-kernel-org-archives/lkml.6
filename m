Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69A4C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAE221700
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAE221700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeHHLgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:36:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbeHHLgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:36:49 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 04068C7F;
        Wed,  8 Aug 2018 09:17:59 +0000 (UTC)
Date:   Wed, 8 Aug 2018 11:17:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Todd Poynor <toddpoynor@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] staging: gasket: core: convert remaining info logs
 to debug
Message-ID: <20180808091757.GA17913@kroah.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
 <20180805200749.116693-5-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805200749.116693-5-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 01:07:38PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Remaining info-level logs in gasket core converted to debug-level; the
> information is not needed during normal system operation.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 01cafe1ff6605..2741256eacfe8 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -1819,7 +1819,7 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
>  	g_descs[desc_idx].driver_desc = NULL;
>  	mutex_unlock(&g_mutex);
>  
> -	pr_info("removed %s driver\n", driver_desc->name);
> +	pr_debug("removed %s driver\n", driver_desc->name);
>  }
>  EXPORT_SYMBOL(gasket_unregister_device);
>  
> @@ -1827,7 +1827,7 @@ static int __init gasket_init(void)
>  {
>  	int i;
>  
> -	pr_info("Performing one-time init of the Gasket framework.\n");
> +	pr_debug("%s\n", __func__);

Lines like this should just be deleted, that is what ftrace is for :)

>  	/* Check for duplicates and find a free slot. */
>  	mutex_lock(&g_mutex);
>  	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
> @@ -1843,8 +1843,7 @@ static int __init gasket_init(void)
>  
>  static void __exit gasket_exit(void)
>  {
> -	/* No deinit/dealloc needed at present. */
> -	pr_info("Removing Gasket framework module.\n");
> +	pr_debug("%s\n", __func__);

No need to have an exit function at all, right?

I'll take this for now, as this is the last day for me to take patches
for 4.19-rc1, but keep this in mind for the future.

thanks,

greg k-h
