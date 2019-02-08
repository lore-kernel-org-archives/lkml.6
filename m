Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675CDC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4385C20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfBHR7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:59:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:24675 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfBHR7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:59:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 09:59:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="113460294"
Received: from shivamur-mobl1.gar.corp.intel.com (HELO localhost) ([10.249.254.162])
  by orsmga007.jf.intel.com with ESMTP; 08 Feb 2019 09:59:48 -0800
Date:   Fri, 8 Feb 2019 19:59:46 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tpm: Unify the send callback behaviour
Message-ID: <20190208175946.GA4195@linux.intel.com>
References: <20190208163059.640-1-jarkko.sakkinen@linux.intel.com>
 <20190208163059.640-2-jarkko.sakkinen@linux.intel.com>
 <22ef544f-e841-a8ea-cec7-fb64fe368fe8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22ef544f-e841-a8ea-cec7-fb64fe368fe8@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 11:36:19AM -0500, Stefan Berger wrote:
> On 2/8/19 11:30 AM, Jarkko Sakkinen wrote:
> >   static void tpm_nsc_cancel(struct tpm_chip *chip)
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index 60e2038652b8..1d781c19f112 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -507,7 +507,11 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
> >   	if (!priv->irq_tested)
> >   		disable_interrupts(chip);
> >   	priv->irq_tested = true;
> > -	return rc;
> > +
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	return 0;
> >   }
> 
> 
> That's not all... There's this above it as well with tpm_tis_send_main
> returning with 'return len;'.
> 
>     if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>         return tpm_tis_send_main(chip, buf, len);

OK, looks like that your suggestion to do it in *_main() was correct
after all.

/Jarkko
