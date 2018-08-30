Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A692073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A692073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeH3Ooa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:44:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45124 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbeH3Ooa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:44:30 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3gHDOsgZy2sx; Thu, 30 Aug 2018 12:42:40 +0200 (CEST)
Received: from nazgul.tnic (46-10-68-224.ip.btc-net.bg [46.10.68.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90EFE1EC0253;
        Thu, 30 Aug 2018 12:42:40 +0200 (CEST)
Date:   Thu, 30 Aug 2018 12:43:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fan Wu <wufan@codeaurora.org>
Cc:     mchehab@kernel.org, james.morse@arm.com, baicar.tyler@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Kani, Toshi" <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
Message-ID: <20180830104307.GC20005@nazgul.tnic>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 06:33:52PM +0000, Fan Wu wrote:
> The current ghes_edac driver does not update per-dimm error
> counters when reporting memory errors, because there is no
> platform-independent way to find DIMMs based on the error
> information provided by firmware. This patch offers a solution
> for platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records. In this case ghes_edac will
> use the module handles to locate DIMMs and thus makes per-dimm
> error reporting possible.
> 
> Signed-off-by: Fan Wu <wufan@codeaurora.org>
> ---
>  drivers/edac/ghes_edac.c | 36 +++++++++++++++++++++++++++++++++---
>  include/linux/edac.h     |  2 ++
>  2 files changed, 35 insertions(+), 3 deletions(-)

If we're going to do this, it needs to be tested on an x86 box which loads
ghes_edac. Adding Toshi to Cc.

Otherwise it must remain ARM-specific.

> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 473aeec..db527f0 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -81,6 +81,26 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>  		(*num_dimm)++;
>  }
>  
> +static int ghes_edac_dimm_index(u16 handle)

get_dimm_smbios_handle()

> +{
> +	struct mem_ctl_info *mci;
> +	int i;
> +
> +	if (!ghes_pvt)
> +		return -1;

You don't need that test.

> +
> +	mci = ghes_pvt->mci;
> +
> +	if (!mci)
> +		return -1;

Ditto.

> +
> +	for (i = 0; i < mci->tot_dimms; i++) {
> +		if (mci->dimms[i]->smbios_handle == handle)
> +			return i;
> +	}
> +	return -1;
> +}
> +
>  static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  {
>  	struct ghes_edac_dimm_fill *dimm_fill = arg;

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
