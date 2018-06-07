Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1C6UEiARGVvqJgAAmS7hNA
	; Thu, 07 Jun 2018 11:04:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3A02F608B8; Thu,  7 Jun 2018 11:04:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A342A607DC;
	Thu,  7 Jun 2018 11:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A342A607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeFGLD5 convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 07:03:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:14337 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbeFGLDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:03:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 04:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="65080570"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2018 04:03:54 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 7 Jun 2018 04:03:54 -0700
Received: from lcsmsx155.ger.corp.intel.com (10.186.165.233) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 7 Jun 2018 04:03:53 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.94]) by
 LCSMSX155.ger.corp.intel.com ([169.254.12.62]) with mapi id 14.03.0319.002;
 Thu, 7 Jun 2018 14:03:51 +0300
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
Thread-Index: AQHT7VevIUY7rd7ojEqiu0sBZix5jKQ7TnMAgAAymDCAAaJwAIAAMykwgAqkdACAADKekIAAo8MAgApfPCCAAVXEgIAAOxJg
Date: Thu, 7 Jun 2018 11:03:50 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9477DD@hasmsx108.ger.corp.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
 <20180522091732.GA5228@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
 <20180523131616.GD363@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D8A1269@hasmsx109.ger.corp.intel.com>
 <20180530105034.GA14905@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D940DC6@hasmsx108.ger.corp.intel.com>
 <20180530233752.GA31296@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D945893@hasmsx108.ger.corp.intel.com>
 <20180607102433.GA16506@linux.intel.com>
In-Reply-To: <20180607102433.GA16506@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzU4NTAxZWUtMWVkYi00ZGY5LTkzNDQtMTk1ZmFmNDg5ZDE5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRStxQmxpMDNSZ2FDMHM5NzVFMXpua3hMWml1RldkK3ZIMDJWUEhWWTdCeXB4REdudXBYM3A4a2w1TzBiVnJLYiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.12.116.95]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Thursday, June 07, 2018 13:25
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; Usyskin, Alexander
> <alexander.usyskin@intel.com>; linux-integrity@vger.kernel.org; linux-
> security-module@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
> 
> On Wed, Jun 06, 2018 at 11:01:42AM +0000, Winkler, Tomas wrote:
> > >
> > > On Wed, May 30, 2018 at 10:52:28AM +0000, Winkler, Tomas wrote:
> > > > >
> > > > > On Wed, May 23, 2018 at 01:48:17PM +0000, Winkler, Tomas wrote:
> > > > > >
> > > > > > > On Tue, May 22, 2018 at 09:27:46AM +0000, Winkler, Tomas
> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler
> > > wrote:
> > > > > > > > > > New wrappers are added tpm_cmd_ready() and
> > > > > > > > > > tpm_go_idle()
> > > > > > > wrappers
> > > > > > > > > > to streamline tpm_try_transmit code.
> > > TPM_TRANSMIT_UNLOCKED
> > > > > > > > > > flag
> > > > > > > is
> > > > > > > > > abused
> > > > > > > > > > to resolve tpm spaces recursive calls to tpm_transmit().
> > > > > > > > >
> > > > > > > > > This looks good and all but I don't think we want to
> > > > > > > > > abuse anything in the driver code, do we?
> > > > > > > >
> > > > > > > > It's not abuse just the flag UNLOCKED is not really named
> > > > > > > > correctly I think this has to be backported so wanted to
> > > > > > > > do less invasive
> > > > > change.
> > > > > > >
> > > > > > > It should be renamed anyway and possible merge conflicts are
> > > > > > > not hard to sort out in this change. Can you rename it as SPACE?
> > > > > >
> > > > > > Not sure, I believe UNLOCKED is still better name than SPACE,
> > > > > >I'm not  sure this is Do you also want to remove
> TPM_TRANSMIT_RAW?
> > > > > > clk_enable is handling its own anti recursion counter 'data-
> > > > > >clkrun_enabled'
> > > > > > but it should be all handled under one flag I guess.
> > > > > >
> > > > > > > Right, and even without rename this will probably cause
> > > > > > > merge conflicts at least in v4.4 an v4.9 since in-kernel RM
> > > > > > > landed in v4.12, so not much gain not do the rename :-)
> > > > > >
> > > > > > I belive we should do minimal change and the big cleanup after
> that.
> > > > > > Not sure, I believe UNLOCKED is still better name than SPACE
> > > > > > even it wasn't
> > > > > the original intention.
> > > > > > No the SPACE is the issue, but any recursion call into
> > > > > > tpm_transmit. A bigger change is needed and rename to SPACE
> > > > > > would be just another
> > > > > intermediat change.
> > > > > >
> > > > > > Please reconsider.
> > > > > >
> > > > > > Thanks
> > > > > > Tomas
> > > > >
> > > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > >
> > > >
> > > > Does it mean you're Okay with the patch now?
> > > > Thanks
> > > > Tomas
> > >
> > > The change looks good but I'll have to test it.
> > Any updates?
> > Thanks
> 
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I've just realized we have issue in tpm_unseal_trusted() 
As TPM_TRANSMIT_UNLOCKED is used really just in 'locking' sense of the flow, it's not nested.
Any of testing flows doesn't covers it. It's used only from by security/keys/trusted.c only

Then I don't have a short fix for this issue. Will use TPM_TRANSMIT_RAW,
 maybe calling it TPM_TRANSMIT_NESTED.  

Thanks
Tomas


> 
> /Jarkko
