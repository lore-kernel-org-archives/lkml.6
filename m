Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38336C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F116120858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F116120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeIRN0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:26:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56148 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbeIRN0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:26:44 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BEFnav9tBli0; Tue, 18 Sep 2018 09:55:18 +0200 (CEST)
Received: from nazgul.tnic (unknown [81.19.42.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE29B1EC0118;
        Tue, 18 Sep 2018 09:55:17 +0200 (CEST)
Date:   Tue, 18 Sep 2018 09:55:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        michal.simek@xilinx.com, leoyang.li@nxp.com, sudeep.holla@arm.com,
        amit.kucheria@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
Message-ID: <20180918075522.GC22202@nazgul.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 07:55:00PM +0530, Manish Narani wrote:
> Add platform specific structures, so that we can add different IP
> support later using quirks.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 91 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 26 deletions(-)

...

> @@ -423,6 +465,7 @@ static void edac_mc_init(struct mem_ctl_info *mci,
>   */
>  static int synps_edac_mc_probe(struct platform_device *pdev)
>  {
> +	const struct synps_platform_data *p_data;
>  	struct edac_mc_layer layers[2];
>  	struct synps_edac_priv *priv;
>  	struct mem_ctl_info *mci;
> @@ -435,7 +478,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  	if (IS_ERR(baseaddr))
>  		return PTR_ERR(baseaddr);
>  
> -	if (!edac_get_eccstate(baseaddr)) {
> +	p_data = of_device_get_match_data(&pdev->dev);
> +	if (!(p_data->get_eccstate(baseaddr))) {

From last review round:

"Too many parentheses:

        if (!p_data->...

is enough."

So I'm going to stop reviewing this patchset until you go through the
old review round again and make sure you've incorporated *all* review
feedback and haven't forgotten some, like the one above.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
