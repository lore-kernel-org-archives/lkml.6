Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA5BECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C79C20869
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C79C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJRG7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:59:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:53352 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbeJRG7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:59:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 16:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="98357807"
Received: from unknown (HELO jsakkine-mobl1) ([10.249.254.40])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2018 16:01:23 -0700
Date:   Thu, 18 Oct 2018 02:01:22 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     Tomas Winkler <tomas.winkler@intel.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
In-Reply-To: <20181015111434.7777-1-tomas.winkler@intel.com>
Message-ID: <alpine.DEB.2.21.1810180057470.5022@jsakkine-mobl1>
References: <20181015111434.7777-1-tomas.winkler@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Tomas Winkler wrote:
> Ignore the return value of go_to_idle() in tpm_try_transmit().
> Once it may shadow the return value of actual tpm operation,
> second the consequent command will fail as well and the error
> will be caought anyway.
> Last fix wrong goto, that jumped back instead of forward.
>
> Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from runtime_pm")
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> drivers/char/tpm/tpm-interface.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 129f640424b7..f69c711bf74a 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -547,9 +547,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> 		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
>
> out:
> -	rc = tpm_go_idle(chip, flags);
> -	if (rc)
> -		goto out;
> +	(void)tpm_go_idle(chip, flags);
>
> 	if (need_locality)
> 		tpm_relinquish_locality(chip, flags);
> -- 
> 2.14.4
>
>

LGTM. Should be probably Cc'd to stable (can add).

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
