Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBAEECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4D3208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4D3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeJRHGs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:06:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:51969 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbeJRHGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:06:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 16:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="83479894"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga006.jf.intel.com with ESMTP; 17 Oct 2018 16:08:49 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 17 Oct 2018 16:08:49 -0700
Received: from hasmsx106.ger.corp.intel.com (10.184.198.20) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 17 Oct 2018 16:08:49 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 HASMSX106.ger.corp.intel.com ([169.254.10.144]) with mapi id 14.03.0319.002;
 Thu, 18 Oct 2018 02:08:46 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
Thread-Topic: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
Thread-Index: AQHUZm1STDh1wH1FgU+vrAhOzJfWh6UkD5xw
Date:   Wed, 17 Oct 2018 23:08:46 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9F52A9@hasmsx109.ger.corp.intel.com>
References: <20181015111434.7777-1-tomas.winkler@intel.com>
 <alpine.DEB.2.21.1810180057470.5022@jsakkine-mobl1>
In-Reply-To: <alpine.DEB.2.21.1810180057470.5022@jsakkine-mobl1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWJkYzRiM2EtMWVmYi00OGVjLTk2MmUtMmZiNDgyZGM3NGI1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicEo5TjhrSjA3QVpHSE9mQ0Y2YkVIanlkY1pmRFRzbEQ1c3A2Q3lvdVU5R0h3VGVLVDRNZm03TUY0WHlTR2V4VSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.154]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Thursday, October 18, 2018 02:01
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Jason Gunthorpe
> <jgg@ziepe.ca>; Nayna Jain <nayna@linux.vnet.ibm.com>; Usyskin,
> Alexander <alexander.usyskin@intel.com>; Struk, Tadeusz
> <tadeusz.struk@intel.com>; linux-integrity@vger.kernel.org; linux-security-
> module@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
> 
> On Mon, 15 Oct 2018, Tomas Winkler wrote:
> > Ignore the return value of go_to_idle() in tpm_try_transmit().
> > Once it may shadow the return value of actual tpm operation, second
> > the consequent command will fail as well and the error will be caought
> > anyway.
> > Last fix wrong goto, that jumped back instead of forward.
> >
> > Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from
> > runtime_pm")
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> > drivers/char/tpm/tpm-interface.c | 4 +---
> > 1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-interface.c
> > b/drivers/char/tpm/tpm-interface.c
> > index 129f640424b7..f69c711bf74a 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -547,9 +547,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> *chip,
> > 		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
> >
> > out:
> > -	rc = tpm_go_idle(chip, flags);
> > -	if (rc)
> > -		goto out;
> > +	(void)tpm_go_idle(chip, flags);
> >
> > 	if (need_locality)
> > 		tpm_relinquish_locality(chip, flags);
> > --
> > 2.14.4
> >
> >
> 
> LGTM. Should be probably Cc'd to stable (can add).
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
I've posted another one, there are more issues in the flow.

