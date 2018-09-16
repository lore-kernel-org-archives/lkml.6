Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E061ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7332087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7332087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeIQAoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 20:44:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:31787 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbeIQAoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 20:44:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2018 12:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,382,1531810800"; 
   d="scan'208";a="73702809"
Received: from vbsuresh-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.48.189])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2018 12:20:09 -0700
Date:   Sun, 16 Sep 2018 22:20:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, dunlapg@umich.edu,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] tpm: Restore functionality to xen vtpm driver.
Message-ID: <20180916192007.GD7473@linux.intel.com>
References: <20180913194749.32178-1-boris.ostrovsky@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913194749.32178-1-boris.ostrovsky@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
> 
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
> ---
> We've lost this patch a couple of years ago, re-submitting.
> 
> 
>  drivers/char/tpm/xen-tpmfront.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index 911475d36800..b150f87f38f5 100644
> --- a/drivers/char/tpm/xen-tpmfront.c
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
> -- 
> 2.17.1
> 

Please add the fixes-line. Thanks.

/Jarkko
