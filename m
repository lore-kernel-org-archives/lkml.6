Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A865ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE6C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE6C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbeGSIuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:50:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65175 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeGSIuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:50:55 -0400
Received: from 89-70-153-66.dynamic.chello.pl (89.70.153.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id e28bcdec1ddad4be; Thu, 19 Jul 2018 10:08:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers/base: stop new probing during shutdown
Date:   Thu, 19 Jul 2018 10:07:18 +0200
Message-ID: <2007954.fM6LRbI1xJ@aspire.rjw.lan>
In-Reply-To: <1531977298-21465-1-git-send-email-kernelfans@gmail.com>
References: <1531977298-21465-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 19, 2018 7:14:58 AM CEST Pingfan Liu wrote:
> There is a race window in device_shutdown(), which may cause
> -1. parent device shut down before child or
> -2. no shutdown on a new probing device.
> 
> For 1st, taking the following scenario:
>          device_shutdown                        new plugin device
>   list_del_init(parent_dev);
>   spin_unlock(list_lock);
>                                                   device_add(child)
>                                                   probe child
>   shutdown parent_dev
>        --> now child is on the tail of devices_kset
> 
> For 2nd, taking the following scenario:
>          device_shutdown                        new plugin device
>                                                   device_add(dev)
>   device_lock(dev);
>   ...
>   device_unlock(dev);
>                                                   probe dev
>        --> now, the new occurred dev has no opportunity to shutdown
> 
> To fix this race issue, just prevent the new probing request. With this
> logic, device_shutdown() is more similar to dpm_prepare().

Right.

This still doesn't prevent new children of a device from being added during
shutdown (something like the PM ->prepare callback would be needed for that),
but at least it prevents drivers from binding to the new devices.

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> ---
>  drivers/base/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index df3e1a4..3aba4ad 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2809,6 +2809,9 @@ void device_shutdown(void)
>  {
>  	struct device *dev, *parent;
>  
> +	wait_for_device_probe();
> +	device_block_probing();
> +
>  	spin_lock(&devices_kset->list_lock);
>  	/*
>  	 * Walk the devices list backward, shutting down each in turn.
> 


