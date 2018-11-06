Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBECC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEC220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEC220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbeKFPTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:19:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:20686 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbeKFPTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:19:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 21:56:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,470,1534834800"; 
   d="scan'208";a="97945561"
Received: from unknown (HELO localhost) ([10.249.254.149])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2018 21:55:56 -0800
Date:   Tue, 6 Nov 2018 07:55:54 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/16] tpm: call tpm2_flush_space() on error in
 tpm_try_transmit()
Message-ID: <20181106055554.GD15575@linux.intel.com>
References: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
 <20181105014552.20262-5-jarkko.sakkinen@linux.intel.com>
 <c7d48e87-1660-b47b-0dfd-b5daabd1777f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d48e87-1660-b47b-0dfd-b5daabd1777f@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 05:01:46PM -0500, Stefan Berger wrote:
> On 11/4/18 8:45 PM, Jarkko Sakkinen wrote:
> > Always call tpm2_flush_space() on failure in tpm_try_transmit() so that
> > the volatile memory of the TPM gets cleared. If /dev/tpm0 does not have
> > sufficient permissions (usually it has), this could leak to the leakage
> 
> leak ->lead
> 
> 
> > of TPM objects. Through /dev/tpmrm0 this issue does not raise new
> > security concerns.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 745b361e989a ("tpm:tpm: infrastructure for TPM spaces")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >   drivers/char/tpm/tpm-interface.c | 28 +++++++++++++++++-----------
> >   drivers/char/tpm/tpm.h           |  1 +
> >   drivers/char/tpm/tpm2-space.c    |  2 +-
> >   3 files changed, 19 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index 64510ed81b46..ecda6f96cde0 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -224,14 +224,14 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> > 
> >   	rc = tpm2_prepare_space(chip, space, ordinal, buf);
> >   	if (rc)
> > -		goto out;
> > +		goto out_idle;
> > 
> >   	rc = chip->ops->send(chip, buf, count);
> >   	if (rc < 0) {
> >   		if (rc != -EPIPE)
> >   			dev_err(&chip->dev,
> >   				"%s: tpm_send: error %d\n", __func__, rc);
> > -		goto out;
> > +		goto out_space;
> >   	}
> > 
> >   	if (chip->flags & TPM_CHIP_FLAG_IRQ)
> > @@ -247,7 +247,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> >   		if (chip->ops->req_canceled(chip, status)) {
> >   			dev_err(&chip->dev, "Operation Canceled\n");
> >   			rc = -ECANCELED;
> > -			goto out;
> > +			goto out_space;
> >   		}
> > 
> >   		tpm_msleep(TPM_TIMEOUT_POLL);
> > @@ -257,7 +257,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> >   	chip->ops->cancel(chip);
> >   	dev_err(&chip->dev, "Operation Timed out\n");
> >   	rc = -ETIME;
> > -	goto out;
> > +	goto out_space;
> > 
> >   out_recv:
> >   	len = chip->ops->recv(chip, buf, bufsiz);
> > @@ -265,22 +265,28 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> >   		rc = len;
> >   		dev_err(&chip->dev,
> >   			"tpm_transmit: tpm_recv: error %d\n", rc);
> > -		goto out;
> > +		goto out_idle;
> 
> Why not jump to out_space here and in 2 instances below?

Ugh, should (and meant) to be like that. Thanks!

/Jarkko

