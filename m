Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeBZN7u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:59:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:15937 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752508AbeBZN7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:59:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="178150490"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2 v5] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Topic: [PATCH 1/2 v5] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Index: AQHTrjDkRZgd3gi8J0CeiQ5wU1qUnqO2d3IAgAAitgA=
Date: Mon, 26 Feb 2018 13:59:42 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94229743@hasmsx108.ger.corp.intel.com>
References: <20180225120049.29308-1-tomas.winkler@intel.com>
 <1519646980.12825.4.camel@linux.intel.com>
In-Reply-To: <1519646980.12825.4.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODIwNmU1ZWQtYzllYy00YzNkLTgwMTEtZWRiMDcxODhiYmJjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJRTGtPbVBxQmZOSll4MzVLazJwaWVpSlowZllzRGlWWVZaVlwveHlUdnRyTFlhdmZwN3hcLzNucWd4MVJLS0JsclQifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.20.216]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QE01Dm018355


> 
> On Sun, 2018-02-25 at 14:00 +0200, Tomas Winkler wrote:
> >  	if (need_locality && chip->ops->relinquish_locality) {
> > -		chip->ops->relinquish_locality(chip, chip->locality);
> > +		/* this coud be on error path, don't override error code */
> > +		int l_rc = chip->ops->relinquish_locality(chip, chip-
> > >locality);
> > +
> > +		if (l_rc)
> > +			dev_err(&chip->dev, "%s: relinquish_locality: error
> > %d\n",
> > +				__func__, l_rc);
> > +
> >  		chip->locality = -1;
> >  	}
> 
> The 'l_rc' declaration causes NAK as I've stated before.

I will provide a sixth version that let us both down the tree

> 
> Why don't you just make a helper function:
> 
> static void tpm_relinquish_locality(struct tpm_chip *chip) {
> 	int rc;
> 
> 	if (!chip->ops->relinquish_locality)
> 		return 0;
> 
> 	rc = chip->ops->relinquish_locality(chip);
> 	if (rc)
> 		dev_err(&chip->dev, "%s: error %d\n", __func__, rc);
> 
> 	chip->locality = -1;
> }
> 
> Then the original code would be simply:
> 
> if (need_locality)
> 	tpm_relinquish_locality(chip);
> 
> /Jarkko
