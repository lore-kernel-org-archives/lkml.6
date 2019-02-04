Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BE3C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A86020811
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfBDLoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:44:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:13176 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfBDLoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:44:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 03:44:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="119817594"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by fmsmga007.fm.intel.com with ESMTP; 04 Feb 2019 03:44:20 -0800
Date:   Mon, 4 Feb 2019 13:44:19 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
Message-ID: <20190204114419.GA26799@linux.intel.com>
References: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA8E215@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA8E215@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 07:20:42PM +0000, Winkler, Tomas wrote:
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
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Tomas Winkler <tomas.winkler@intel.com>
> > Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> > Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  drivers/char/tpm/tpm_crb.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c index
> > 36952ef98f90..7f47e43aa9f1 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -288,18 +288,18 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf,
> > size_t count)
> >  	unsigned int expected;
> > 
> >  	/* sanity check */
> > -	if (count < 6)
> > +	if (count < 8)
> >  		return -EIO;
> Why don't you already enforce reading at least the whole TPM header 10bytes, we are reading the whole buffer at one call anyway.
> Who every is asking for 8 bytes from the protocol level, is doing something wrong.
> 
> >  	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> >  		return -EIO;
> > 
> > -	memcpy_fromio(buf, priv->rsp, 6);
> > +	memcpy_fromio(buf, priv->rsp, 8);
> Maybe a short comment will spare someone looking into git history 
> >  	expected = be32_to_cpup((__be32 *) &buf[2]);
> > -	if (expected > count || expected < 6)
> > +	if (expected > count || expected < 8)
> Expected should be at least tpm header, right?
> >  		return -EIO;
> > 
> > -	memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
> > +	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> > 
> >  	return expected;
> >  }
> Otherwise ready the first 8 bytes looks good. 
> Thanks 
> Tomas

Your proposals look sane, thank you.

/Jarkko
