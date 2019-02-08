Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908A8C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6210C21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549624420;
	bh=qZ0opTzpj0xg4jk+b9bRLCdDqSrWzRNxQq0vSUZxnUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e3FqYkB7od7cR/zz9cAd46erlCfKyCUPjA+IIyz1Ino/bmxFVILwFkJ/LP4OIUQ0F
	 lJ50j4iCDoAsC3NTBmTlUtXbwBETpjS9EloiCMtNsYyWsd5HaXMJ1hu7Yx5Umb8ERJ
	 wEQ12zWBomw8GwnONxuJsuUULWVm5dkMrPdq8bOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfBHLNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfBHLNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:13:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C5420863;
        Fri,  8 Feb 2019 11:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549624417;
        bh=qZ0opTzpj0xg4jk+b9bRLCdDqSrWzRNxQq0vSUZxnUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VE3GF+Uw7rOQZ9h0OHqwDb8kLCIHtFXBRiV9+jhbVQDNpactsHHOWy3YMop1V909Z
         pWSi3NMlIDPh+l0ccEzk2YMQMKt0u6YJezoqpsHRW+fVSU8DkLI41wdtFtyXM/Fd0E
         cQscxrSCE1Y5x4sUhi0lN+LEti9Pi5n9kHeG0WPI=
Date:   Fri, 8 Feb 2019 12:13:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Julien Freche <jfreche@vmware.com>
Subject: Re: [PATCH 2/6] vmw_balloon: support 64-bit memory limit
Message-ID: <20190208111335.GA3632@kroah.com>
References: <20190206235706.4851-1-namit@vmware.com>
 <20190206235706.4851-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206235706.4851-3-namit@vmware.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 03:57:02PM -0800, Nadav Amit wrote:
> From: Xavier Deguillard <xdeguillard@vmware.com>
> 
> Currently, the balloon driver would fail to run if memory is greater
> than 16TB of vRAM. Previous patches have already converted the balloon
> target and size to 64-bit, so all that is left to do add is to avoid
> asserting memory is smaller than 16TB if the hypervisor supports 64-bits
> target.
> 
> The driver advertises a new capability VMW_BALLOON_64_BITS_TARGET.
> Hypervisors that support 16TB of memory or more will report that this
> capability is enabled.
> 
> Signed-off-by: Xavier Deguillard <xdeguillard@vmware.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  drivers/misc/vmw_balloon.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index c4371ec132d3..f96dc3690ade 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -72,15 +72,26 @@ enum vmwballoon_capabilities {
>  	VMW_BALLOON_BATCHED_CMDS		= (1 << 2),
>  	VMW_BALLOON_BATCHED_2M_CMDS		= (1 << 3),
>  	VMW_BALLOON_SIGNALLED_WAKEUP_CMD	= (1 << 4),
> +	VMW_BALLOON_64_BIT_TARGET		= (1 << 5)

Nit, this should be BIT(5), right?

You can change that in a later patch...

thanks,

greg k-h
