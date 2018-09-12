Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2F0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4626B2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AdJ4RiuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4626B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeILVcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:32:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeILVcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TeOwPBlB5LDZYvE6pmp/IrHRyLIL3dfdD8wBK7H4DpY=; b=AdJ4RiuZ1lm3gOdtMpyGiTFN6
        M+GYLqF2SD+41Ht5bbYLIsJP06S85jDHkzxwAMNqa5b2yl5zmCuxfIbEI4AQcsKNOULbdhFDUg19Z
        w58ADm/7X1ibXDJAVicFWm7V/jX39lj2qhVeVFMvQ5Tggw0CJmtOnnJeBTuxBekvfqEmtVO0usSdd
        MQXy8U1R5rA5Bv4eYFGsbhiXpAuqiAFxWMLwJCavu1cuzC6Oba6RysQ7ki0vz5BR6kHEoL3YNFACM
        McM1bG01XD5nOoX2vwwb112NCtR/OIFC1tkBmon1TImZUWwovP782DXlxBPmvh+dKdGq6MDio4Fmg
        J6BfDqgXA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g07zF-0004C3-2d; Wed, 12 Sep 2018 16:27:29 +0000
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
References: <20180912142337.21955-1-jlee@suse.com>
 <20180912142337.21955-2-jlee@suse.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b3dd8655-c394-ed62-1efc-8295a95bb7fb@infradead.org>
Date:   Wed, 12 Sep 2018 09:27:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180912142337.21955-2-jlee@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/12/18 7:23 AM, Lee, Chun-Yi wrote:
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 3a6c2f87699e..7c5c30149dbc 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -76,6 +76,20 @@ config HIBERNATION
>  
>  	  For more information take a look at <file:Documentation/power/swsusp.txt>.
>  
> +config HIBERNATION_ENC_AUTH
> + 	bool "Hibernation encryption and authentication"
> + 	depends on HIBERNATION
> + 	depends on TRUSTED_KEYS
> +	select CRYPTO_AES
> + 	select CRYPTO_HMAC
> + 	select CRYPTO_SHA512
> + 	help
> +	  This option will encrypt and authenticate the memory snapshot image
> +	  of hibernation. It prevents that the snapshot image be arbitrary

	                                                         arbitrarily

> +	  modified. User can use TPMs trusted key or user defined key as the

	            The user
or	            A user can use the TPM's trusted key

> +	  master key of hibernation. The TPM trusted key depends on TPM. The
> +	  security of user defined key relies on user space.
> +


-- 
~Randy
