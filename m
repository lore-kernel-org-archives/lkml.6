Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED7CC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B392081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B392081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbeKFPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:18:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:9052 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbeKFPSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:18:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 21:54:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,470,1534834800"; 
   d="scan'208";a="97944968"
Received: from unknown (HELO localhost) ([10.249.254.149])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2018 21:54:25 -0800
Date:   Tue, 6 Nov 2018 07:54:24 +0200
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
Subject: Re: [PATCH v3 03/16] tpm: return 0 from pcrs_show() when
 tpm1_pcr_read() fails
Message-ID: <20181106055424.GC15575@linux.intel.com>
References: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
 <20181105014552.20262-4-jarkko.sakkinen@linux.intel.com>
 <d5296b84-0a2c-56ce-ae65-71e6a6d0c820@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5296b84-0a2c-56ce-ae65-71e6a6d0c820@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 04:54:52PM -0500, Stefan Berger wrote:
> On 11/4/18 8:45 PM, Jarkko Sakkinen wrote:
> > Do not print partial list of PCRs when tpm1_pcr_read() fails but instead
> > return 0 from pcrs_show(). This is consistent behavior with other sysfs
> > functions.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >   drivers/char/tpm/tpm-sysfs.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> > index 7ed7eb6f906a..d3b05c7526c8 100644
> > --- a/drivers/char/tpm/tpm-sysfs.c
> > +++ b/drivers/char/tpm/tpm-sysfs.c
> > @@ -115,13 +115,15 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
> >   	for (i = 0; i < num_pcrs; i++) {
> >   		rc = tpm1_pcr_read(chip, i, digest);
> >   		if (rc)
> > -			break;
> > +			goto out;
> 
> Previous patch said "Return zero when tpm_buf_init() fails as we do for
> other functions in tpm-sysfs.c.". Why not return 0 in this case as well?

Yes, good catch, thank you.

/Jarkko
