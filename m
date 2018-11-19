Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E6BC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA9A20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA9A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbeKSXCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:02:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:9853 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbeKSXCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:02:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 04:38:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="109326160"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2018 04:38:45 -0800
Date:   Mon, 19 Nov 2018 14:38:44 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 14/17] tpm: remove TPM_TRANSMIT_UNLOCKED flag
Message-ID: <20181119123844.GA8755@linux.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <20181118124753.18613-15-jarkko.sakkinen@linux.intel.com>
 <20181118195104.GA21938@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118195104.GA21938@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 12:51:04PM -0700, Jason Gunthorpe wrote:
> On Sun, Nov 18, 2018 at 02:47:47PM +0200, Jarkko Sakkinen wrote:
> > Added locking as part of tpm_try_get_ops() and tpm_put_ops() as they are
> > anyway used in most of the call sites except in tpmrm_release() where we
> > take the locks manually.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  drivers/char/tpm/tpm-chip.c       |  2 ++
> >  drivers/char/tpm/tpm-dev-common.c |  4 +---
> >  drivers/char/tpm/tpm-interface.c  |  8 --------
> >  drivers/char/tpm/tpm.h            |  8 ++------
> >  drivers/char/tpm/tpm2-cmd.c       | 13 ++++---------
> >  drivers/char/tpm/tpm2-space.c     | 15 ++++++---------
> >  6 files changed, 15 insertions(+), 35 deletions(-)
>  
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 32db84683c40..157505b0f755 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -58,6 +58,7 @@ int tpm_try_get_ops(struct tpm_chip *chip)
> >  	if (!chip->ops)
> >  		goto out_lock;
> >  
> > +	mutex_lock(&chip->tpm_mutex);
> >  	return 0;
> 
> It really isn't appropriate for something called 'get' to be exclusive
> like this.. Call it tpm_try_lock_ops() ?

Would definitely be appropriate to rename it, yes.

> > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> > index c7dc54930576..582caefcf19b 100644
> > --- a/drivers/char/tpm/tpm-dev-common.c
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -33,7 +33,6 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
> >  	struct tpm_header *header = (void *)buf;
> >  	ssize_t ret, len;
> >  
> > -	mutex_lock(&chip->tpm_mutex);
> 
> The now implicit locking should be tested for using lockdep calls in
> all places that assume the lock is held by the caller.

Yes. Most importantly trusted keys and IMA should be tested with lockdep
turned on.

/Jarkko
