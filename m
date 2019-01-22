Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7154C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B928218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548150039;
	bh=EPpeRzLGVlodThXXa3bSpFneaEwy9KHzLtDPMYXPW4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CEfOdRpRcxZTCxtPIFTUUHtDNMz8RWWqibLddGUKZqgN+fMSR/daFcxlUSNMjwi2p
	 Ke4xm3hx3EfoGgjxroKSJ3Foll086IXhNa0m1yv++RkdFVYl+kk3iEAwgLHqF2QD7F
	 0KYIlfkemxMlT8BfGE/VE2RwvOXN0TB/VGI175iU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfAVJki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfAVJki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:40:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E29218D9;
        Tue, 22 Jan 2019 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548150037;
        bh=EPpeRzLGVlodThXXa3bSpFneaEwy9KHzLtDPMYXPW4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sh56/r+5h1kYdEdbHV8/nR/IxyeDDP8z2Y2B9bH8prJBSC3wLWuZi6VDQiZ+k/BSw
         AkANHpmMHvp8Cf4XCRWvLoVwkMykP5GPpGTLnAeSLs31ASnIGR/x91AFj3sf7m7ywu
         QzF/ZRuaddW28ZPhJA/JndBWT3W+nOHtKFIk7Yrg=
Date:   Tue, 22 Jan 2019 10:40:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6]  misc/pvpanic: add pvpanic mmio driver
Message-ID: <20190122094035.GD29657@kroah.com>
References: <1548098711-52497-1-git-send-email-peng.hao2@zte.com.cn>
 <1548098711-52497-5-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548098711-52497-5-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:25:10AM +0800, Peng Hao wrote:
> Add pvpanic mmio driver to pvpanic driver framework.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic/Kconfig      |  4 +++
>  drivers/misc/pvpanic/Makefile     |  1 +
>  drivers/misc/pvpanic/pvpanic-of.c | 53 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
>  create mode 100644 drivers/misc/pvpanic/pvpanic-of.c
> 
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> index d274130..47f8709 100644
> --- a/drivers/misc/pvpanic/Kconfig
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -13,4 +13,8 @@ config PVPANIC_ACPI
>  	depends on ACPI
>  	default PVPANIC
>  
> +config PVPANIC_OF
> +	tristate "pvpanic mmio driver"
> +	depends on OF
> +

Again, you need help text saying what this driver does.

Same for all of these.

thanks,

greg k-h
