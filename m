Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id a2OjB88HGVsETgAAmS7hNA
	; Thu, 07 Jun 2018 10:24:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 396C4607E7; Thu,  7 Jun 2018 10:24:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B545E602FC;
	Thu,  7 Jun 2018 10:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B545E602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbeFGKYh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:24:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:6023 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753166AbeFGKYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:24:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 03:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="235442511"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.62])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2018 03:24:33 -0700
Date: Thu, 7 Jun 2018 13:24:33 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Message-ID: <20180607102433.GA16506@linux.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
 <20180522091732.GA5228@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
 <20180523131616.GD363@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D8A1269@hasmsx109.ger.corp.intel.com>
 <20180530105034.GA14905@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D940DC6@hasmsx108.ger.corp.intel.com>
 <20180530233752.GA31296@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D945893@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D945893@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 11:01:42AM +0000, Winkler, Tomas wrote:
> > 
> > On Wed, May 30, 2018 at 10:52:28AM +0000, Winkler, Tomas wrote:
> > > >
> > > > On Wed, May 23, 2018 at 01:48:17PM +0000, Winkler, Tomas wrote:
> > > > >
> > > > > > On Tue, May 22, 2018 at 09:27:46AM +0000, Winkler, Tomas wrote:
> > > > > > > >
> > > > > > > > On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler
> > wrote:
> > > > > > > > > New wrappers are added tpm_cmd_ready() and tpm_go_idle()
> > > > > > wrappers
> > > > > > > > > to streamline tpm_try_transmit code.
> > TPM_TRANSMIT_UNLOCKED
> > > > > > > > > flag
> > > > > > is
> > > > > > > > abused
> > > > > > > > > to resolve tpm spaces recursive calls to tpm_transmit().
> > > > > > > >
> > > > > > > > This looks good and all but I don't think we want to abuse
> > > > > > > > anything in the driver code, do we?
> > > > > > >
> > > > > > > It's not abuse just the flag UNLOCKED is not really named
> > > > > > > correctly I think this has to be backported so wanted to do
> > > > > > > less invasive
> > > > change.
> > > > > >
> > > > > > It should be renamed anyway and possible merge conflicts are not
> > > > > > hard to sort out in this change. Can you rename it as SPACE?
> > > > >
> > > > > Not sure, I believe UNLOCKED is still better name than SPACE, I'm
> > > > >not  sure this is Do you also want to remove TPM_TRANSMIT_RAW?
> > > > > clk_enable is handling its own anti recursion counter 'data-
> > > > >clkrun_enabled'
> > > > > but it should be all handled under one flag I guess.
> > > > >
> > > > > > Right, and even without rename this will probably cause merge
> > > > > > conflicts at least in v4.4 an v4.9 since in-kernel RM landed in
> > > > > > v4.12, so not much gain not do the rename :-)
> > > > >
> > > > > I belive we should do minimal change and the big cleanup after that.
> > > > > Not sure, I believe UNLOCKED is still better name than SPACE even
> > > > > it wasn't
> > > > the original intention.
> > > > > No the SPACE is the issue, but any recursion call into
> > > > > tpm_transmit. A bigger change is needed and rename to SPACE would
> > > > > be just another
> > > > intermediat change.
> > > > >
> > > > > Please reconsider.
> > > > >
> > > > > Thanks
> > > > > Tomas
> > > >
> > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > >
> > >
> > > Does it mean you're Okay with the patch now?
> > > Thanks
> > > Tomas
> > 
> > The change looks good but I'll have to test it.
> Any updates?
> Thanks

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
