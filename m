Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E3FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D2720821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfBDXYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:24:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:36787 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfBDXYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:24:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 15:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="272502853"
Received: from baparham-mobl.amr.corp.intel.com (HELO localhost) ([10.249.254.152])
  by orsmga004.jf.intel.com with ESMTP; 04 Feb 2019 15:24:12 -0800
Date:   Tue, 5 Feb 2019 01:24:11 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v2] tpm/tpm_crb: Avoid unaligned reads in crb_recv()
Message-ID: <20190204232411.GA14992@linux.intel.com>
References: <20190204135943.15756-1-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA901F7@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA901F7@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:09:51PM +0000, Winkler, Tomas wrote:
> > 
> > The current approach to read first 6 bytes from the response and then tail of
> > the response, can cause the 2nd memcpy_fromio() to do an unaligned read
> > (e.g. read 32-bit word from address aligned to a 16-bits), depending on how
> > memcpy_fromio() is implemented. If this happens, the read will fail and the
> > memory controller will fill the read with 1's.
> > 
> > This was triggered by 170d13ca3a2f, which should be probably refined to check
> > and react to the address alignment. Before that commit, on x86
> > memcpy_fromio() turned out to be memcpy(). By a luck GCC has done the right
> > thing (from tpm_crb's perspective) for us so far, but we should not rely on that.
> > Thus, it makes sense to fix this also in tpm_crb, not least because the fix can be
> > then backported to stable kernels and make them more robust when compiled
> > in differing environments.
> > 
> > Cc: stable@vger.kernel.org
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Tomas Winkler <tomas.winkler@intel.com>
> > Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> > Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> After fixing the typos you can add my ack. 
> Thanks
> Tomas
> 
> > ---
> > v2:
> > * There was a trailing double colon in the end of the short summary.
> > * Check requested and expected length against TPM_HEADER_SIZE.
> > * Add some explanatory comments to crb_recv().
> >  drivers/char/tpm/tpm_crb.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c index
> > 36952ef98f90..c084e61299aa 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -287,19 +287,29 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf,
> > size_t count)
> >  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> >  	unsigned int expected;
> > 
> > -	/* sanity check */
> > -	if (count < 6)
> > +	/* A sanity check that the upper layer wants to get at least the header
> > +	 * as that is the minimum size for any TPM response.
> > +	 */
> > +	if (count < TPM_HEADER_SIZE)
> >  		return -EIO;
> > 
> > +	/* If this bit is set, according to the spec, the TPM is in unrecovable
>                                                                                                      ^^^ typo ^^^^
> > +	 * condition.
> > +	 */
> >  	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> >  		return -EIO;
> > 
> > -	memcpy_fromio(buf, priv->rsp, 6);
> > -	expected = be32_to_cpup((__be32 *) &buf[2]);
> > -	if (expected > count || expected < 6)
> > +	/* Read 8 bytes (not just 6 bytes, which would cover ^^^ tag and^^^ the response
> > length
> > +	 * field ^^^s^^^) in order to make sure that the reminding memory accesses
>                                                                              ^^^ remaining^^^  
> > will
> > +	 * be aligned.
> > +	 */
> > +	memcpy_fromio(buf, priv->rsp, 8);
> > +
> > +	expected = be32_to_cpup((__be32 *)&buf[2]);
> > +	if (expected > count || expected < TPM_HEADER_SIZE)
> >  		return -EIO;
> > 
> > -	memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
> > +	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> > 
> >  	return expected;
> >  }
> > --
> > 2.19.1
> 

Thanks!

/Jarkko
