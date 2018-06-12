Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9F92FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528F3208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xqknq9Vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528F3208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934519AbeFLP1q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:27:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52800 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934464AbeFLP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YRkX3jG5jp4UkGBnq/JnXSblkxtlNlZKwyV5RlaW9Mo=; b=Xqknq9VzRSCrN/6CnWh1/nilKR
        jUt1Uy2dvpmrnZd91203rJXuVFzZQx77mye7RcqoSEd/p7xzh8qfWbA1OVJxJIwfil2+dn61mMzJ/
        AMEH7QrF181Uo/ECjiKgw1L8RqiAizhjoSodmwWxtYKq/TPnR+wOYy7NGnVP6io+JcOpcoksnZc06
        6mgt0M7WRqWoKVgKlIS2pt09Jiepjp6aSK6JfyoQktwZXJOPtRgMmCsW84EbqINX/7a6PHk0AL4rI
        7RUPfbBZnAEsMvnRh/F6mlRL0lGlhroQ229MMYt6DeCdukd+5LMVk09cpZ+905eM+cwlmZf0XqEm5
        ZI+ENo8g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSlCv-0004TX-PQ; Tue, 12 Jun 2018 15:27:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v6 14/29] fpga: dfl: add FPGA Management Engine driver basic
 framework
To:     Wu Hao <hao.wu@intel.com>, atull@kernel.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-15-git-send-email-hao.wu@intel.com>
Message-ID: <5c9f36f7-74f2-acd1-a3e0-f56238cf85a7@infradead.org>
Date:   Tue, 12 Jun 2018 08:27:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528798243-2029-15-git-send-email-hao.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/12/2018 03:10 AM, Wu Hao wrote:
> From: Kang Luwei <luwei.kang@intel.com>
> 
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5faab48..45e9220 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -146,6 +146,16 @@ config FPGA_DFL
>  	  Gate Array (FPGA) solutions which implement Device Feature List.
>  	  It provides enumeration APIs, and feature device infrastructure.
>  
> +config FPGA_DFL_FME
> +	tristate "FPGA DFL FME Driver"
> +	depends on FPGA_DFL
> +	help
> +	  The FPGA Management Engine (FME) is a feature device implemented
> +	  under Device Feature List (DFL) framework. Select this option to
> +	  enable the platform device driver for FME which implements all
> +	  FPGA platform level management features. There shall be 1 FME

better:
	                                                       be one FME

> +	  per DFL based FPGA device.
> +
>  config FPGA_DFL_PCI
>  	tristate "FPGA DFL PCIe Device Driver"
>  	depends on PCI && FPGA_DFL


-- 
~Randy
