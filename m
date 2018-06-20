Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77EDC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8147020846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft5zBx8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8147020846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeFTFrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbeFTFrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:47:31 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB2720846;
        Wed, 20 Jun 2018 05:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529473651;
        bh=PUZIkMeL92dvteqZy6CxGctVmCBiSJLVplqj/p3i+SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ft5zBx8WffeUSuI88Jkjvq74r92c8y4EnJSbwte+cDm+A4wRv+HRJbcbuzS0IZUAe
         SJoptzlvzDqkh/bUWacb0n+wCQnk8eS8wA1V7GCj5aT11apIKaRtk0MirO9IoeWMBD
         x45R7ECi1pfDBpbzwbsL0t0FfeyCLDdZiI7tBJBk=
Date:   Wed, 20 Jun 2018 11:17:22 +0530
From:   Vinod <vkoul@kernel.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH V3 6/7] backlight: qcom-wled: add support for short
 circuit handling
Message-ID: <20180620054722.GH13316@vkoul-mobl>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-18, 16:43, Kiran Gunda wrote:

>  struct wled {
>  	const char *name;
>  	struct device *dev;
>  	struct regmap *regmap;
> +	struct mutex lock;	/* Lock to avoid race from ISR */

the comment is wrong as you avoid race with thread handler and not the
main ISR. The ISR runs in atomic context so you cant use a mutex but you
may do so with a thread handler

> +#define WLED_SHORT_DLY_MS			20
> +#define WLED_SHORT_CNT_MAX			5
> +#define WLED_SHORT_RESET_CNT_DLY_US		USEC_PER_SEC

an empty line after defines would be better

> +static int wled_configure_short_irq(struct wled *wled,
> +				    struct platform_device *pdev)
> +{
> +	int rc = 0, short_irq;

superfluous initialization of rc

-- 
~Vinod
