Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C35CC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F73E20892
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F73E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJOS0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:26:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:28519 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOS0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:26:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 03:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="88441574"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.171])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Oct 2018 03:41:57 -0700
Date:   Mon, 15 Oct 2018 13:41:56 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Message-ID: <20181015104156.GA13408@linux.intel.com>
References: <20181010133817.GA11485@embeddedor.com>
 <20181010140638.GA3894@ziepe.ca>
 <20181011120140.GA15767@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9EEC12@hasmsx109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9EEC12@hasmsx109.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 01:27:58PM +0000, Winkler, Tomas wrote:
> > 
> > On Wed, Oct 10, 2018 at 08:06:38AM -0600, Jason Gunthorpe wrote:
> > > On Wed, Oct 10, 2018 at 03:38:17PM +0200, Gustavo A. R. Silva wrote:
> > > > Currently, there are some values assigned to variable *rc*, which
> > > > are never actually used in any computation, because such variable is
> > > > updated at line 550, before they can be used:
> > > >
> > > > 549out:
> > > > 550        rc = tpm_go_idle(chip, flags);
> > > > 551        if (rc)
> > > > 552                goto out;
> > > >
> > > > Fix this by removing such assignments.
> > >
> > > Should this be done by not quashing rc during the error unwind rather
> > > than dropping the errors?
> > 
> > Yeah.`
> > 
> > Wondering if tpm_go_idle() should simply be a void-function i.e. issue just a
> > warning inside (disclaimer: did not revisit its code when writing this).
> 
> We did have rather a long discussion about it when it was merged.
> There are two flows that may crash 
> rc = tpm2_commit_space()
> 
> but you still can need to 
> 
> rc  = go_idle()  
> 
> which also may crash which may override the previous value. 
> 
> Frankly the second one is fatal, the stack will go out of sync.
> We may do void here as the stack will crash in a subsequent command. 
> 
> The 'goto out' is quite a  bug, probably caused by code movement.

I just looked at the code properly and noticed that there is a regression
caused by 627448e85c76 ("tpm: separate cmd_ready/go_idle from
runtime_pm") i.e. when tpm_go_idle() fails it loops back and retries
tpm_go_idle().

/Jarkko
