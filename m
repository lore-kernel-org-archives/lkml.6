Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 26905C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE85208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KQ+2r8OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE85208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934554AbeFLP14 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:27:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52830 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934297AbeFLP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HBIFndO7INtqBkm5SLQ3lqPJxVMydoprSqsdvhR96es=; b=KQ+2r8OE5nFqqf0gi1QEjD0yJa
        cyMk+ysnryx1cBbfdj8ywMvl18W0S+gz08LGHaCu1yoCAe1ZaWtwTM1qeb5GkvzeRkdt2V5+8njiM
        kFyNA9t7FPIiYHb510kB0H9u7ZbNupjE+AKZNMTCyp0iKFB/y0nHgVygncmlNsyYHscht5MtIfAmC
        HcTj8pGW+ZE5qns0mxRrm8TYZeXLJMXRmW9iIWW7l2Xg414fk0Lf0JNe6vdrFQp8fjG5bTcNQ19xY
        cjAvmh2qRpWjdAaB1Gm/8RGGUZJ85g/jwhVpTmBhnadRP6PL5KEVP2MScwdMXH2WsVvRAfxv5xZQr
        JYRU8iWw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSlD6-0004Tw-5L; Tue, 12 Jun 2018 15:27:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v6 23/29] fpga: dfl: add FPGA Accelerated Function Unit driver
 basic framework
To:     Wu Hao <hao.wu@intel.com>, atull@kernel.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-24-git-send-email-hao.wu@intel.com>
Message-ID: <6f4b06a1-65e1-e3b6-960c-e6eb38ad12b8@infradead.org>
Date:   Tue, 12 Jun 2018 08:27:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528798243-2029-24-git-send-email-hao.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/12/2018 03:10 AM, Wu Hao wrote:
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index a0aa163..e3b140e 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -174,6 +174,15 @@ config FPGA_DFL_FME_REGION
>  	help
>  	  Say Y to enable FPGA Region driver for FPGA Management Engine.
>  
> +config FPGA_DFL_AFU
> +	tristate "FPGA DFL AFU Driver"
> +	depends on FPGA_DFL
> +	help
> +	  This is the driver for FPGA Accelerated Function Unit (AFU) which
> +	  implements AFU and Port management features. A User AFU connects
> +	  to the FPGA infrastructure via a Port. There may be more than 1

better:
	                                                      more than one

> +	  Port/AFU per DFL based FPGA device.
> +
>  config FPGA_DFL_PCI
>  	tristate "FPGA DFL PCIe Device Driver"
>  	depends on PCI && FPGA_DFL


-- 
~Randy
