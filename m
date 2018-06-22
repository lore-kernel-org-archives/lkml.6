Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DBCC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6403824993
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZtuSKo7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6403824993
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754671AbeFVXDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:03:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56366 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754482AbeFVXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PRmICZNSZ/UCt6rEh0lRrkBtk5ilQg/9/8YJzyWIers=; b=ZtuSKo7T7AI9X5bnY4GeeYXJ81
        03w4S6KB4ceyWz6YEn1Izu0vOcicY+kanqNyUnVG9zgny4AcSOD+QCLxp95yDtIg1og0sfpWDF5wl
        6MqVuyjsocK1LL2FMbvOz+9lnJFEDpNtWyfOkjWRB01+VqbuP/x3pK9D6ZRfCNAiYXESNEubmxf2E
        DG5rUuf3ZEdzl6eq0k0kr+nAPZs2n0YUEOP3jXVjI9LAjTckTfEnjeILbUTsSA6YAvGLjua8ZwGEG
        jBzkPHNjITYQNzIciXInsiinDrKy2wgKmlx9pVDbLjiDx3qJLthHWHTU6Tm4mSiWlLn7r6d7ndrFy
        w8tzcoOg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWV5k-0003y7-B9; Fri, 22 Jun 2018 23:03:44 +0000
Subject: Re: [PATCH v1 1/4] mhi_bus: core: Add support for MHI host interface
To:     Sujeev Dias <sdias@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tony Truong <truong@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7827dfe9-cca0-d06d-c34c-b8a69c4f847c@infradead.org>
Date:   Fri, 22 Jun 2018 16:03:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/26/2018 07:23 PM, Sujeev Dias wrote:
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index d1c0b60..e15d56d 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -171,6 +171,23 @@ config DA8XX_MSTPRI
>  	  configuration. Allows to adjust the priorities of all master
>  	  peripherals.
>  
> +config MHI_BUS
> +	tristate "Modem Host Interface"
> +	help
> +	  MHI Host Interface is a communication protocol to be used by the host

	  MHI (Modem Host Interface) is

> +	  to control and communcate with modem over a high speed peripheral bus.

	                 communicate

> +	  Enabling this module will allow host to communicate with external
> +	  devices that support MHI protocol.
> +
> +config MHI_DEBUG
> +	 bool "MHI debug support"
> +	 depends on MHI_BUS
> +	 help
> +	   Say yes here to enable debugging support in the MHI transport
> +	   and individual MHI client drivers. This option will impact
> +	   throughput as individual MHI packets and state transitions
> +	   will be logged.
> +
>  source "drivers/bus/fsl-mc/Kconfig"
>  
>  endmenu


-- 
~Randy
