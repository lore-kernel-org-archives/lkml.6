Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AA16DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED9E2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FgyrJaEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED9E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934489AbeFLP1e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:27:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52788 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933538AbeFLP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4wLET7dceava13491H7SEL4I88/nHp5KlKmqM1ybaP0=; b=FgyrJaEQBk9B7mY3x/syvsHilz
        HZYS8Nvvs3lPaxeYhlm2XlY+mRGrs+8M2eN4aOA//S4GT7BNWPHu9MuAQzXBIoWW/o6zAfuQLSw4c
        4/pxq6FSfo06c6gbLvOsqbzRjWpkrHGKD/1ZUJy/FkdDgRVH1cz3nuDDn0wzTDeUH6KWAeeBd+oBE
        l0Kin1mXcZRO9bxgvWx0hBE7pbsbxHxUOMN7783FrpZj6t91DHYZ7fw7r9sBWu9Bhp8gucsOsmvIN
        noO7YXDd815a1JLtbJkGYHy9R2jfd2/+o+32oPUGfCXzUyYqZie42HlvEiBZKgPwLlnoaw2t+NPUF
        ZKmxtjLg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSlCk-0004TJ-15; Tue, 12 Jun 2018 15:27:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v6 12/29] fpga: add FPGA DFL PCIe device driver
To:     Wu Hao <hao.wu@intel.com>, atull@kernel.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-13-git-send-email-hao.wu@intel.com>
Message-ID: <87a783f1-9db8-e56d-c4c4-1802c29c416a@infradead.org>
Date:   Tue, 12 Jun 2018 08:27:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528798243-2029-13-git-send-email-hao.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/12/2018 03:10 AM, Wu Hao wrote:
> From: Zhang Yi <yi.z.zhang@intel.com>
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 4052532..5faab48 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -146,4 +146,19 @@ config FPGA_DFL
>  	  Gate Array (FPGA) solutions which implement Device Feature List.
>  	  It provides enumeration APIs, and feature device infrastructure.
>  
> +config FPGA_DFL_PCI
> +	tristate "FPGA DFL PCIe Device Driver"
> +	depends on PCI && FPGA_DFL
> +	help
> +	  Select this option to enable PCIe driver for PCIe based

	                                               PCIe-based

> +	  Field-Programmable Gate Array (FPGA) solutions which implemented

	                                                 which implement

> +	  the Device Feature List (DFL). This driver provides interfaces
> +	  for userspace applications to configure, enumerate, open and access
> +	  FPGA accelerators on the FPGA DFL devices, enables system level
> +	  management functions such as FPGA partial reconfiguration, power
> +	  management, and virtualization with DFL framework and DFL feature
> +	  device drivers.
> +
> +	  To compile this as a module, choose M here.
> +
>  endif # FPGA


-- 
~Randy
