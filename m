Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149A6C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C073A2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C073A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeGLJDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:03:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeGLJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:03:44 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 910F1D02;
        Thu, 12 Jul 2018 08:55:05 +0000 (UTC)
Date:   Thu, 12 Jul 2018 10:55:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     broonie@kernel.org, p.paillet@st.com, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] base: core: Remove WARN_ON from link dependencies check
Message-ID: <20180712085501.GA25313@kroah.com>
References: <20180712080623.21203-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712080623.21203-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:06:23AM +0200, Benjamin Gaignard wrote:
> In some cases the link between between customer and supplier
> already exist. Do not warn about already existing dependencies
> because device_link_add() take care of this case.

Why would a link already exist that is asked to be created again?  What
code path causes this?

> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index df3e1a44707a..fcdc17f0f349 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -105,7 +105,7 @@ static int device_is_dependent(struct device *dev, void *target)
>  	struct device_link *link;
>  	int ret;
>  
> -	if (WARN_ON(dev == target))
> +	if (dev == target)
>  		return 1;
>  
>  	ret = device_for_each_child(dev, target, device_is_dependent);
> @@ -113,7 +113,7 @@ static int device_is_dependent(struct device *dev, void *target)
>  		return ret;
>  
>  	list_for_each_entry(link, &dev->links.consumers, s_node) {
> -		if (WARN_ON(link->consumer == target))
> +		if (link->consumer == target)
>  			return 1;

Both of these WARN_ON are for valid code?  That feels really odd to me,
I need more explanation here please.

thanks,

greg k-h
