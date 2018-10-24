Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ED5C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AABC207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v8dxdars"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AABC207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbeJYABT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:01:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38652 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYABT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Lzf2JzWbYQ3FRLBtkd7NCOlqCcUtoh/qnrmPufEWU3s=; b=v8dxdarsPNISDVCdT9ORTthT+X
        Wc45syCGetYVasmawIXsvUWBhSV5OyBFi3mbtSVLAo0FQ4jGhn7nYLevhj+itTftBYYek3U52+SsR
        QPrqFdkGi9yqc2797Euwq6W1BQGGLu8nof6Ltua1GrihBxhUlT/cZcaLsYh8a6CFt41/ZXCMxKvyI
        AU3+Zp8Nl1kTFOyAPEDEpE5HMaL8FJ0KK6D8f+vBDI+g9UNXlFiT7rgPuA0KZXDMYjlwRAfGUVex3
        iAkV5nwaBfqs20fNFK3bTS/1kfhjH64RnVENttwNJQtJmxBWP0RhcjGiiDIVvaz2PGXZwHswjXwQe
        Twz0k1XQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFL9G-0000fE-9K; Wed, 24 Oct 2018 15:32:45 +0000
Subject: Re: [PATCH] init/main.c Enable watchdog_thresh control from kernel
 line
To:     Laurence Oberman <loberman@redhat.com>,
        linux-kernel@vger.kernel.org
References: <1540394484-18252-1-git-send-email-loberman@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cc05c205-5f98-4709-96d0-947a9316f0c5@infradead.org>
Date:   Wed, 24 Oct 2018 08:32:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540394484-18252-1-git-send-email-loberman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/24/18 8:21 AM, Laurence Oberman wrote:
> Both graphics and serial consoels are exposed to hard lockups

                           consoles

> when handling a large amount of messaging. The kernel watchdog_thresh
> parameter up to now has not been available to be set on the kernel line for
> early boot. 
> This patch allows the setting of watchdog_thresh to be increased
> when needed to avoid the hard lockups in the console code.
> 
> Signed-off-by: Laurence Oberman <loberman@redhat.com>

Please add corresponding documentation to the
Documentation/admin-guide/kernel-parameters.txt file.

Thanks.

> ---
>  init/main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/init/main.c b/init/main.c
> index e4a3160..5882750 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -977,6 +977,15 @@ static int __init set_debug_rodata(char *str)
>  __setup("rodata=", set_debug_rodata);
>  #endif
>  
> +static int __init
> +is_watchdog_thresh_setup(char *str)
> +{
> +	get_option(&str, &watchdog_thresh);
> +	return 1;
> +}
> +__setup("watchdog_thresh=", is_watchdog_thresh_setup);
> +
> +
>  #ifdef CONFIG_STRICT_KERNEL_RWX
>  static void mark_readonly(void)
>  {
> 


-- 
~Randy
