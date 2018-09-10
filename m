Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645EDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0475820865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZY8SwrvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0475820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeIKBrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:47:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeIKBre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C/S3lSy57XdmdpUF/iuHiCVDGIGh0yrj0WRy3BamSao=; b=ZY8SwrvYMYh99U413m2UkWstB
        +WCPe41m24+aUpzZadZoZWsmKQQNppSaXycwhvxTaFKZeFALD8G6xC+lGqB9xIxbXRXxOvLWLGmlx
        4knE2HHEinp2z8QneFh/oTXJmxAhCIKFMYeD/f/T09zQWbGGlOMDdE958GuAQrl9b52bJuPEygIWV
        knhEoc1Fl7n9y0sYxSppRNrBD6a+ZY8J1njZ2f7ApDY2zQ7WXyrbdeATjiFE58znHD+NjdzhxYOs1
        1yITgY5f07ozSggl+76lHZvehFvN+6o5Kd1xvEs0gUaO5aWKgxDR7i2AvdFgrWN+z9/GSvcE7MJji
        nrMsytcHg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzT9p-0004BW-0U; Mon, 10 Sep 2018 20:51:41 +0000
Date:   Mon, 10 Sep 2018 13:51:39 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86: dell-smbios-wmi: Correct a memory leak
Message-ID: <20180910205139.GC5659@wrath>
References: <1536602513-13861-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536602513-13861-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 01:01:52PM -0500, Mario Limonciello wrote:
> ACPI buffers were being allocated but never freed.
> 
> Reported-by: Pinzhen Xu <pinzhen.xu@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Cc: stable@vger.kernel.org

Thanks Mario and Pinzhen, both queued. That's an easy one to miss, the usage not
being particularly obvious.

> ---
>  drivers/platform/x86/dell-smbios-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x86/dell-smbios-wmi.c
> index 88afe56..cf2229e 100644
> --- a/drivers/platform/x86/dell-smbios-wmi.c
> +++ b/drivers/platform/x86/dell-smbios-wmi.c
> @@ -78,6 +78,7 @@ static int run_smbios_call(struct wmi_device *wdev)
>  	dev_dbg(&wdev->dev, "result: [%08x,%08x,%08x,%08x]\n",
>  		priv->buf->std.output[0], priv->buf->std.output[1],
>  		priv->buf->std.output[2], priv->buf->std.output[3]);
> +	kfree(output.pointer);
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
