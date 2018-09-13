Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEEDC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30022086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aecOU2/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30022086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeINBb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:31:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38217 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbeINBb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:31:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id u11-v6so3105217plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CDDSUKz9NtNvHaoyexLzc+koabhzRYXuUDJ1jOIoVyQ=;
        b=aecOU2/HD16ahGO5kxNviohY2SmqTveCvEFppZ+3uPPgjUnp4DRqIiAYtI9zYKUOSZ
         Im+feYEmJg9kvZvCMJP2NzuXwCBfamd6G1ai7u5AlSxhiP6F7x+JCBCesG9AkZqiruNd
         GqlTEmIDtcb2DWxWO/bHMf+wfveeAn/IFxl4s6F6q+TBpjTLgJr/Rf0lSp7NFCFnfMW1
         RxcB+nStLXKdvxjFuyugDO9wCFZdSlGeTj++tt8joBcuLJ5pxupR34vCCHbgmC447jhO
         yXV+JQiCPaIz9zkvsB8y5K/06V/NyogyMVun9phUuslGB1kDweHcyVN4C2O7e7YOSWLk
         DAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CDDSUKz9NtNvHaoyexLzc+koabhzRYXuUDJ1jOIoVyQ=;
        b=oWKWcsX9+QGnFBtUt5tR+1g51fmSlMKmvL4yx5OtHIrWB+gTiIJmPYj4Wi2Oz98zmz
         eLvAgA2xYa337CRKvO6w7xDXS58MGBHSgAmI8wKO9L1HdEq5Tn8igRs50Bh4+oPpUp0N
         VWItn+6BF3ADSaFvkVXokQ5vBTz5Ii84743KKyBZi0BPh4tlw9cB2/AO+MCuvumgzX8R
         lJHc/aMyE9sDOW993bxo6PFhBCAOcnC5S7gXMbjKSTUC66+jcHYXsI9vApBWM32klYi3
         obxdM+2Vs56TKLkl8x4ddFniH56UuTzIFX4549rIL1gY9XQ2tOB5G+GaU+TkV91FMpyI
         fxbg==
X-Gm-Message-State: APzg51AKI/H/q1zze7hQiGrv2mCYfi+ffzYamgkPIsiqN8WK2P108duC
        Bj4A1qdqsShkUr7uk0qqgGxxpA==
X-Google-Smtp-Source: ANB0VdbWTaFvVKF4bG8GllZsGevdSVgETCrsj1RyIGUwYreJkd70L0GQ/d8rKsMxBBMdjMGMRkfE9w==
X-Received: by 2002:a17:902:292b:: with SMTP id g40-v6mr8677271plb.223.1536870023016;
        Thu, 13 Sep 2018 13:20:23 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v22-v6sm8301533pfi.60.2018.09.13.13.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 13:20:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g0Y69-00040f-74; Thu, 13 Sep 2018 14:20:21 -0600
Date:   Thu, 13 Sep 2018 14:20:21 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, jgross@suse.com, dunlapg@umich.edu,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] tpm: Restore functionality to xen vtpm driver.
Message-ID: <20180913202021.GD31953@ziepe.ca>
References: <20180913194749.32178-1-boris.ostrovsky@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913194749.32178-1-boris.ostrovsky@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:47:49PM -0400, Boris Ostrovsky wrote:
> From: "Dr. Greg Wettstein" <greg@wind.enjellic.com>
> 
> Functionality of the xen-tpmfront driver was lost secondary to
> the introduction of xenbus multi-page support in commit ccc9d90a9a8b
> ("xenbus_client: Extend interface to support multi-page ring").

This should be in a Fixes: line..

> In this commit a pointer to the shared page address was being
> passed to the xenbus_grant_ring() function rather then the
> address of the shared page itself.  This resulted in a situation
> where the driver would attach to the vtpm-stubdom but any attempt
> to send a command to the stub domain would timeout.
> 
> A diagnostic finding for this regression is the following error
> message being generated when the xen-tpmfront driver probes for a
> device:
> 
> <3>vtpm vtpm-0: tpm_transmit: tpm_send: error -62
> 
> <3>vtpm vtpm-0: A TPM error (-62) occurred attempting to determine
> the timeouts
> 
> This fix is relevant to all kernels from 4.1 forward which is the
> release in which multi-page xenbus support was introduced.
> 
> Daniel De Graaf formulated the fix by code inspection after the
> regression point was located.
> 
> Signed-off-by: Dr. Greg Wettstein <greg@enjellic.com>
> 
> [boris: fixed commit message formatting]
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: stable@vger.kernel.org # v4.1+
> We've lost this patch a couple of years ago, re-submitting.
> 
> 
>  drivers/char/tpm/xen-tpmfront.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index 911475d36800..b150f87f38f5 100644
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -264,7 +264,7 @@ static int setup_ring(struct xenbus_device *dev, struct tpm_private *priv)
>  		return -ENOMEM;
>  	}
>  
> -	rv = xenbus_grant_ring(dev, &priv->shr, 1, &gref);
> +	rv = xenbus_grant_ring(dev, priv->shr, 1, &gref);
>  	if (rv < 0)
>  		return rv;
>  
