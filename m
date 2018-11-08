Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4453BECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A80620825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A80620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeKIEjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:39:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:49869 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbeKIEjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:39:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 11:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="279497280"
Received: from smartikx-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by fmsmga006.fm.intel.com with ESMTP; 08 Nov 2018 11:02:34 -0800
Date:   Thu, 8 Nov 2018 21:02:34 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 14/17] tpm: remove TPM_TRANSMIT_UNLOCKED flag
Message-ID: <20181108190234.GD20608@linux.intel.com>
References: <20181108141541.12832-1-jarkko.sakkinen@linux.intel.com>
 <20181108141541.12832-15-jarkko.sakkinen@linux.intel.com>
 <5a0628cb-84e2-6fab-8fce-a77dc7adceb2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a0628cb-84e2-6fab-8fce-a77dc7adceb2@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:43:46AM -0500, Stefan Berger wrote:
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index f2b0e5c52a57..d6abc964ef66 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -652,17 +652,12 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
> >   	u32 blob_handle;
> >   	int rc;
> > 
> > -	mutex_lock(&chip->tpm_mutex);
> > -	rc = tpm2_load_cmd(chip, payload, options, &blob_handle,
> > -			   TPM_TRANSMIT_UNLOCKED);
> > +	rc = tpm2_load_cmd(chip, payload, options, &blob_handle, 0);
> >   	if (rc)
> > -		goto out;
> > +		return rc;
> > 
> > -	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle,
> > -			     TPM_TRANSMIT_UNLOCKED);
> > -	tpm2_flush_context_cmd(chip, blob_handle, TPM_TRANSMIT_UNLOCKED);
> > -out:
> > -	mutex_unlock(&chip->tpm_mutex);
> > +	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle, 0);
> > +	tpm2_flush_context_cmd(chip, blob_handle, 0);
> 
> 
> This lock was covering quite a few commands from being interfered by others.
> Is this still guaranteed to work after or can different subsystems like
> trusted keys and IMA and /dev/tpm0 users interfere with this previous atomic
> sequence ?

One way to keep this sequence atomic would be to use a TPM space. Then
you can release the lock in-between the sequence.

/Jarkko
