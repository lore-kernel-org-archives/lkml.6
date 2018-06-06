Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41910601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeFFLBt convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Wed, 6 Jun 2018 07:01:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:17568 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750808AbeFFLBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:01:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="64756718"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Topic: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Index: AQHT7VevIUY7rd7ojEqiu0sBZix5jKQ7TnMAgAAymDCAAaJwAIAAMykwgAqkdACAADKekIAAo8MAgApfPCA=
Date: Wed, 6 Jun 2018 11:01:42 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D945893@hasmsx108.ger.corp.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
 <20180522091732.GA5228@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
 <20180523131616.GD363@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D8A1269@hasmsx109.ger.corp.intel.com>
 <20180530105034.GA14905@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D940DC6@hasmsx108.ger.corp.intel.com>
 <20180530233752.GA31296@linux.intel.com>
In-Reply-To: <20180530233752.GA31296@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzY0ODc0YjAtMDc5Zi00NWE2LTg5MWEtZTU1NzZkOGI2MjI2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR01GWE9JTWdBWlhGZjhtMEJGb3BHQ1l6TFBMRUUySGlcLzZvZm1DY1FNdEpvREJyVmc4ZWc0MFQzOTlJU25UZGEifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.12.116.162]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, May 30, 2018 at 10:52:28AM +0000, Winkler, Tomas wrote:
> > >
> > > On Wed, May 23, 2018 at 01:48:17PM +0000, Winkler, Tomas wrote:
> > > >
> > > > > On Tue, May 22, 2018 at 09:27:46AM +0000, Winkler, Tomas wrote:
> > > > > > >
> > > > > > > On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler
> wrote:
> > > > > > > > New wrappers are added tpm_cmd_ready() and tpm_go_idle()
> > > > > wrappers
> > > > > > > > to streamline tpm_try_transmit code.
> TPM_TRANSMIT_UNLOCKED
> > > > > > > > flag
> > > > > is
> > > > > > > abused
> > > > > > > > to resolve tpm spaces recursive calls to tpm_transmit().
> > > > > > >
> > > > > > > This looks good and all but I don't think we want to abuse
> > > > > > > anything in the driver code, do we?
> > > > > >
> > > > > > It's not abuse just the flag UNLOCKED is not really named
> > > > > > correctly I think this has to be backported so wanted to do
> > > > > > less invasive
> > > change.
> > > > >
> > > > > It should be renamed anyway and possible merge conflicts are not
> > > > > hard to sort out in this change. Can you rename it as SPACE?
> > > >
> > > > Not sure, I believe UNLOCKED is still better name than SPACE, I'm
> > > >not  sure this is Do you also want to remove TPM_TRANSMIT_RAW?
> > > > clk_enable is handling its own anti recursion counter 'data-
> > > >clkrun_enabled'
> > > > but it should be all handled under one flag I guess.
> > > >
> > > > > Right, and even without rename this will probably cause merge
> > > > > conflicts at least in v4.4 an v4.9 since in-kernel RM landed in
> > > > > v4.12, so not much gain not do the rename :-)
> > > >
> > > > I belive we should do minimal change and the big cleanup after that.
> > > > Not sure, I believe UNLOCKED is still better name than SPACE even
> > > > it wasn't
> > > the original intention.
> > > > No the SPACE is the issue, but any recursion call into
> > > > tpm_transmit. A bigger change is needed and rename to SPACE would
> > > > be just another
> > > intermediat change.
> > > >
> > > > Please reconsider.
> > > >
> > > > Thanks
> > > > Tomas
> > >
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> >
> > Does it mean you're Okay with the patch now?
> > Thanks
> > Tomas
> 
> The change looks good but I'll have to test it.
Any updates?
Thanks
