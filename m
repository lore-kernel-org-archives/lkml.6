Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9D9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE3920862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE3920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbeKGDcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:32:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58108 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730164AbeKGDcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:32:12 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aErmr-VjR_Gk; Tue,  6 Nov 2018 19:05:46 +0100 (CET)
Received: from zn.tnic (p200300EC2BD1C800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:c800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 385891EC0958;
        Tue,  6 Nov 2018 19:05:46 +0100 (CET)
Date:   Tue, 6 Nov 2018 19:05:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-edac@vger.kernel.org, ravi@jetztechnologies.com,
        arvino55@gmail.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] edac: i82975x: remove set but not used variable
 'dtype'
Message-ID: <20181106180526.GL13712@zn.tnic>
References: <20181101022604.7312-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181101022604.7312-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 10:26:04AM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/edac/i82975x_edac.c:378:16: warning:
>  variable ‘dtype’ set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit
> 084a4fccef39 ("edac: move dimm properties to struct dimm_info")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/edac/i82975x_edac.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
> index 892815e..ae0d8fa 100644
> --- a/drivers/edac/i82975x_edac.c
> +++ b/drivers/edac/i82975x_edac.c
> @@ -375,7 +375,6 @@ static void i82975x_init_csrows(struct mem_ctl_info *mci,
>  	u32 cumul_size, nr_pages;
>  	int index, chan;
>  	struct dimm_info *dimm;
> -	enum dev_type dtype;
>  
>  	last_cumul_size = 0;
>  
> @@ -413,7 +412,6 @@ static void i82975x_init_csrows(struct mem_ctl_info *mci,
>  		 *   [0-7] for single-channel; i.e. csrow->nr_channels = 1
>  		 *   [0-3] for dual-channel; i.e. csrow->nr_channels = 2
>  		 */
> -		dtype = i82975x_dram_type(mch_window, index);

Please get rid of that silly function too and move the comment and the
assignment to the single place where it is done:

        /*
         * ECC is possible on i92975x ONLY with DEV_X8
         */
        dimm->dtype = DEV_X8;


Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
