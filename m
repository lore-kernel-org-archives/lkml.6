Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0965CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE93420866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE93420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeJPOJ0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:09:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:49492 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeJPOJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:09:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 23:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,387,1534834800"; 
   d="scan'208";a="81544531"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2018 23:20:34 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 15 Oct 2018 23:20:34 -0700
Received: from hasmsx108.ger.corp.intel.com (10.184.198.18) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 15 Oct 2018 23:20:34 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 hasmsx108.ger.corp.intel.com ([169.254.9.136]) with mapi id 14.03.0319.002;
 Tue, 16 Oct 2018 09:20:29 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
Thread-Topic: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
Thread-Index: AQHUZHjlTDh1wH1FgU+vrAhOzJfWh6UhKqiAgAA7gaA=
Date:   Tue, 16 Oct 2018 06:20:29 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9F2C7C@hasmsx109.ger.corp.intel.com>
References: <20181015111434.7777-1-tomas.winkler@intel.com>
 <20181016054155.GA18664@ziepe.ca>
In-Reply-To: <20181016054155.GA18664@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDk2ZWMxZTYtY2YwMy00YWZmLThlNWQtYWFjZTgzNWE1Y2VjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUHlkQ2lSYjVcL29YMlZkQXFIeEhsSXNhenNpdXVqdUx5YmNmY045eHZRcjZKdlhqa0VORTUrZDg2UWhoQ2dVcFUifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.110]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> On Mon, Oct 15, 2018 at 02:14:34PM +0300, Tomas Winkler wrote:
> > Ignore the return value of go_to_idle() in tpm_try_transmit().
> > Once it may shadow the return value of actual tpm operation, second
> > the consequent command will fail as well and the error will be caought
> > anyway.
> > Last fix wrong goto, that jumped back instead of forward.
> >
> > Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from
> > runtime_pm")
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > drivers/char/tpm/tpm-interface.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-interface.c
> > b/drivers/char/tpm/tpm-interface.c
> > index 129f640424b7..f69c711bf74a 100644
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -547,9 +547,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> *chip,
> >  		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
> >
> >  out:
> > -	rc = tpm_go_idle(chip, flags);
> > -	if (rc)
> > -		goto out;
> > +	(void)tpm_go_idle(chip, flags);
> 
> We don't really use this style in the kernel, AFAIK.


Right, there are no many of those; just wanted to emphasize that return value is ignored. I can drop (void).

Thanks
Tomas

