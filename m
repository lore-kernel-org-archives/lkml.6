Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1D2C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5316025F4B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5316025F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754982AbeF0Qmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:42:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:43624 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754976AbeF0Qmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:42:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 09:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,279,1526367600"; 
   d="scan'208";a="67791414"
Received: from tkaikuma-mobl.ger.corp.intel.com ([10.249.254.71])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 09:42:26 -0700
Message-ID: <5c50d7fa2bf495f26443bd2da2e15df34c3d23f7.camel@linux.intel.com>
Subject: Re: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alan Cox <alan@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Date:   Wed, 27 Jun 2018 19:42:24 +0300
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
         <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
         <cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 21:15 +0000, Winkler, Tomas wrote:
> > Right now if I really put head into this I can understand the logic but it
> > is a
> > complete mess.
> 
> I think what is the mess is that we have a recursive call to tpm_transmit
> topped with retries.  All other mess is just the result of that.
> 
> > I will forgot the dependencies between flags within few
> > weeks. 
> 
> Hope the reasons are well documented both in code and the commit message, if
> not let's address that. We really cannot depend on one's memory.
> It's not like I'm not striving for simplest possible code. 
> 
> > A fixed requirement (so that you know) is that they must be
> > independent.
> 
> The flags (hope this what you referring here to) are not independent and
> weren't before, (RAW cannot be called alone as you will have double locking)
> putting them under one name just should make it clear. 
> I beg you to go over the  code one more time, don't get stuck with flags
> names, maybe you even discover some real issue. 
> 
> Thanks
> Tomas

You should then find a solution where you can remove TPM_TRANSMIT_RAW
completely and make it as a separate commit, not part of the bug fix.
This is not in a shape that I would dare to put this in a pull request.

/Jarkko
