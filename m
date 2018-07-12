Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C8BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFCF21476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hu0A6ikF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFCF21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391232AbeGLCdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:33:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391219AbeGLCdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8BqBBJyp1oNkbpOWn01Ij1ndA7Z+B/E5WN7N8yaKkng=; b=hu0A6ikF/dJOgli9EGZJ5RlHC
        QdP+jUvYyQTOJB/mDjcls1SRgPZAQcn7/T3kRtQeVPy+oeNJptSoXQ8NcTdx7kXRFVRDnfg9z1g5q
        VeaCX85VHVZ+t6Ynn43m/AX4CwKYaePemVjY+54XFCgtQQjAp5Et/7HcbeoM1F+JdWThUc5lli8Dm
        Bb9ceijAcGfRT4BKVbr8+IXCZKoRvxOwgqUv1ZhpL0nAkDFDPnZhPuCpj9M00IC839BNuebzQ8yr/
        EpkJ4RkpzgL/BakBRsD7n3Nx6uQ1l18DTbVZPlTBzI/b5jpGA2Ckx32yMBiaXh2qH135/Z43VBFI+
        lRmUD96fw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdRJJ-0004GI-D9; Thu, 12 Jul 2018 02:26:25 +0000
Subject: Re: [PATCH] extcon: max3355: include mod_devicetable.h
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
References: <20180711155039.3600663-1-arnd@arndb.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <04b7a06c-5f85-2ac7-6b32-3a87c9b65f75@infradead.org>
Date:   Wed, 11 Jul 2018 19:26:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180711155039.3600663-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 08:50 AM, Arnd Bergmann wrote:
> Another driver turned up that is missing linux/mod_devicetable.h after
> the device IDs are split out from linux/platform_device.h:
> 
> drivers/extcon/extcon-max3355.c:127:34: error: array type has incomplete element type 'struct of_device_id'
>  static const struct of_device_id max3355_match_table[] = {
> 
> Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sorry for the delay.  I've been traveling.
And Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> Greg, please add that to the char-misc tree that already has
> other related patches.
> ---
>  drivers/extcon/extcon-max3355.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/extcon/extcon-max3355.c b/drivers/extcon/extcon-max3355.c
> index 0aa410836f4e..1335a476bfec 100644
> --- a/drivers/extcon/extcon-max3355.c
> +++ b/drivers/extcon/extcon-max3355.c
> @@ -14,6 +14,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  struct max3355_data {
> 


-- 
~Randy
