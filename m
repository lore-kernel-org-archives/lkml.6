Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD6BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76032081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mWZQj/6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76032081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389626AbeKGC3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:29:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389245AbeKGC3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k1mHlqxdbKYBCQWkRxtFUGsy8NdskMo6ABAFGCVNkFM=; b=mWZQj/6vZLG2cMyc4/QI2+bDF
        aQSf1cRMy2mCGoZKe5HGf+GxvpiQ0OE0sASe/RiCnuQNUgmyMfgDj1nNduOiW/BmIafrUxjw1bhaV
        3sVurzvIqx0H3B7GD6exuwSUJMrcvqJbiqPtDEaftz6Sy8IWnPafA/KrxgfBf2JYdQcuEMufftY5f
        cT8sHlHTzu24wP/o4U/U0CXovTWydapd9mGKsg2dVPy7tBKC1w/oT4ZjGkf66qn5M7bducfAf65Si
        lTPI1IF4PCF7QLh62hHFxMB/CqAssq9gHFUuOebFBkv2SuZHtetvlRqqLUgrEQ80JBaYPoh2+XEUG
        +7ude4fYA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK4lD-0001a1-0n; Tue, 06 Nov 2018 17:03:27 +0000
Subject: Re: [PATCHv10 3/8] firmware: add Intel Stratix10 service layer driver
To:     richard.gong@linux.intel.com, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org,
        mdf@kernel.org, arnd@arndb.de, corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, todd.riffel@intel.com,
        richard.gong@intel.com
References: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
 <1541523172-5171-4-git-send-email-richard.gong@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <595b853f-6a8c-d608-e716-95ef1c84d0b9@infradead.org>
Date:   Tue, 6 Nov 2018 09:03:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541523172-5171-4-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 8:52 AM, richard.gong@linux.intel.com wrote:
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 7273e50..b6813bc 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -216,6 +216,18 @@ config FW_CFG_SYSFS_CMDLINE
>  	  WARNING: Using incorrect parameters (base address in particular)
>  	  may crash your system.
>  
> +config INTEL_STRATIX10_SERVICE
> +       tristate "Intel Stratix10 Service Layer"
> +       depends on HAVE_ARM_SMCCC
> +       default n
> +       help
> +        Intel Stratix10 service layer runs at privileged exception level,
> +	interfaces with the service providers (FPGA manager is one of them) and
> +	manages secure monitor call to communicate with secure monitor software
> +	at secure monitor exception level.
> +
> +        Say Y here if you want Stratix10 service layer support.

from Documentation/process/coding-style.rst:

Lines under a ``config`` definition are indented with one tab,
while help text is indented an additional two spaces.


thanks.
-- 
~Randy
