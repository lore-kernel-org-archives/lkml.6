Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeBSLn0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:43:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:1048 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752528AbeBSLnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:43:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,534,1511856000";
   d="scan'208";a="18732371"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2 v3] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Topic: [PATCH 1/2 v3] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Index: AQHTqXSOCW/YZdaFTEqM/gtR9RwwAKOrln9Q
Date: Mon, 19 Feb 2018 11:43:19 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B942240B1@hasmsx108.ger.corp.intel.com>
References: <20180214134319.4400-1-tomas.winkler@intel.com>
 <20180214134319.4400-2-tomas.winkler@intel.com>
 <20180219112700.yfoywzegqzrpynlk@linux.intel.com>
In-Reply-To: <20180219112700.yfoywzegqzrpynlk@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDM4YzgyZTgtMDZjNS00NzlkLWE0MzMtMTYxNDNmOWVkZWIyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJrSGpndFwvQnlwdUFNK0Z4aW1Meks2V0FtTmlEXC90QXNxakhjOHgwN3FvdDdGMFMzVnNMcGV0SDRRc2pCbEhIbUcifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.12.116.195]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Feb 14, 2018 at 03:43:18PM +0200, Tomas Winkler wrote:
> >  	if (need_locality && chip->ops->relinquish_locality) {
> > -		chip->ops->relinquish_locality(chip, chip->locality);
> > +		/* this coud be on error path, don't override error code */
> > +		int l_rc = chip->ops->relinquish_locality(chip, chip->locality);
> 
> All local variable declarations must be in the beginning of the function.

Who says?


> 
> > +
> > +		if (l_rc) {
> > +			dev_err(&chip->dev, "%s: relinquish_locality: error
> %d\n",
> > +				__func__, l_rc);
> > +			rc = l_rc;
> > +		}
> 
> Your comment about not overriding error code is incorrect. 

Please explain? 

> The value of 'rc' should be never overridden, which kind of supports to "just
> print" behavior that we had for a locality error.

You are not consistent, you've agreed with propagating it to user space. 
The error will  be propagated in case of an error in locality relinquish
the device is pretty much in non functional state and provious errors do not matter much,
but rc value won't be modified if locality_reliquish succeeds.

> Is your fix somehow dependent on changing relinquish_locality() behavior? If
> not, please remove this change. If you want to contribute such behavioral
> change, you should make a separate patch of it.

The issue is structural, this is required just because the relinquish locality  is inside the error path handling.

> Now it's like a trojan horse bundled inside a bug fix.

Not sure I understand your methaphore. 
Please review again.

Thanks
Tomas
