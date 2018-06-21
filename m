Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3769C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AA521776
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AA521776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeFURNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:13:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:16581 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752838AbeFURNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:13:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 10:13:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,252,1526367600"; 
   d="scan'208";a="50836000"
Received: from lmrad-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.46])
  by orsmga007.jf.intel.com with ESMTP; 21 Jun 2018 10:13:07 -0700
Date:   Thu, 21 Jun 2018 20:13:08 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180621171308.GH11859@linux.intel.com>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
 <20180620205004.GG27445@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620205004.GG27445@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 02:50:04PM -0600, Jason Gunthorpe wrote:
> On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> > Implement tpm_chip_find() for other subsystems to find a TPM chip and
> > get a reference to that chip. Once done with using the chip, the reference
> > is released using tpm_chip_put().
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >  drivers/char/tpm/tpm-chip.c | 37 +++++++++++++++++++++++++++++++++++++
> >  include/linux/tpm.h         |  9 +++++++++
> >  2 files changed, 46 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 0a62c19937b6..eaaf41ce73d8 100644
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -81,6 +81,43 @@ void tpm_put_ops(struct tpm_chip *chip)
> >  EXPORT_SYMBOL_GPL(tpm_put_ops);
> >  
> >  /**
> > + * tpm_chip_put() - Release a ref to the tpm_chip
> > + * @chip: Chip to put
> > + */
> > +void tpm_chip_put(struct tpm_chip *chip)
> > +{
> > +	if (chip)
> > +		put_device(&chip->dev);
> 
> Rarely like to see those if's inside a put function.. Does it actually
> help anything?
> 
> Jason

The check only helps to hidden regressions here...

/Jarkko
