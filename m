Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD07AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9382E2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfBHTBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:01:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:33385 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfBHTBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:01:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 11:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="141845693"
Received: from szilberm-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.172])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2019 11:00:58 -0800
Date:   Fri, 8 Feb 2019 21:00:57 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tpm: Unify the send callback behaviour
Message-ID: <20190208190057.GA3439@linux.intel.com>
References: <20190208180857.12330-1-jarkko.sakkinen@linux.intel.com>
 <20190208180857.12330-2-jarkko.sakkinen@linux.intel.com>
 <4072b2b6-0f95-be50-0772-7e2869c2c24e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4072b2b6-0f95-be50-0772-7e2869c2c24e@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:12:34PM -0500, Stefan Berger wrote:
> On 2/8/19 1:08 PM, Jarkko Sakkinen wrote:
> > The send() callback should never return length as it does not in every
> > driver except tpm_crb in the success case. The reason is that the main
> > transmit functionality only cares about whether the transmit was
> > successful or not and ignores the count completely.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Let me know when you put it into your tree, I'll give it a spin while I am
> at it. :-)

Thank you Stefan! I also add your suggested-by to the first commit
because you pointed out the problem.

It all looks now legit, but just in case I'll add a check for the return
value to tpm_try_transmit() and a warning if it is not zero in the
success case (and after that zeroing of rc).

That check can be removed when I do v5.3 pull request. That should
enough window to catch any potential issues and check will ensure that
kernel won't fail even there was something forgotten.

Alexander, I'll push this version now to the master and next with the
additional check described in this commit, but will add your tags
after you have time to test.

Thanks alot!

/Jarkko
