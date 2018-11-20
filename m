Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC33AC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D2B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D2B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeKTXSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:18:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:10011 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKTXSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:18:15 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 04:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="87850616"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.177])
  by fmsmga008.fm.intel.com with ESMTP; 20 Nov 2018 04:49:13 -0800
Date:   Tue, 20 Nov 2018 14:49:13 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 04/17] tpm: print tpm2_commit_space() error inside
 tpm2_commit_space()
Message-ID: <20181120124913.GC8813@linux.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <20181118124753.18613-5-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA23561@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA23561@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:25:22PM +0000, Winkler, Tomas wrote:
> 
> 
> > 
> > The error logging for tpm2_commit_space() is in a wrong place. This commit
> > moves it inside that function.
> > 
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  drivers/char/tpm/tpm-interface.c | 2 --
> >  drivers/char/tpm/tpm2-space.c    | 9 ++++++---
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> > interface.c
> > index 64510ed81b46..7ac6ada8428c 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -277,8 +277,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> > *chip,
> >  	}
> > 
> >  	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> > -	if (rc)
> > -		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
> > 
> >  out:
> >  	/* may fail but do not override previous error value in rc */ diff --git
> > a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c index
> > 1131a8e7b79b..5ecc73988f7c 100644
> > --- a/drivers/char/tpm/tpm2-space.c
> > +++ b/drivers/char/tpm/tpm2-space.c
> > @@ -501,19 +501,19 @@ int tpm2_commit_space(struct tpm_chip *chip,
> > struct tpm_space *space,
> >  	rc = tpm2_map_response_header(chip, cc, buf, *bufsiz);
> >  	if (rc) {
> >  		tpm2_flush_space(chip);
> > -		return rc;
> > +		goto out;
> >  	}
> > 
> >  	rc = tpm2_map_response_body(chip, cc, buf, *bufsiz);
> >  	if (rc) {
> >  		tpm2_flush_space(chip);
> > -		return rc;
> > +		goto out;
> >  	}
> > 
> >  	rc = tpm2_save_space(chip);
> >  	if (rc) {
> >  		tpm2_flush_space(chip);
> > -		return rc;
> > +		goto out;
> >  	}
> > 
> >  	*bufsiz = be32_to_cpu(header->length); @@ -526,4 +526,7 @@ int
> > tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
> >  	memcpy(space->session_buf, chip->work_space.session_buf,
> > PAGE_SIZE);
> > 
> >  	return 0;
> > +out:
> Maybe 'out' is too positive name for an error-only exit point? 
> or you can use if (rc) ... dev_err()

out_err?

/Jarkko
