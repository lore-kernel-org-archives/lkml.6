Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB633C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C48266BA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C48266BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeFZIWm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:22:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:15442 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932246AbeFZIWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:22:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 01:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="211208116"
Received: from jsakkine-mobl1.tm.intel.com (HELO jyrjanai-mobl2.ger.corp.intel.com) ([10.237.50.56])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2018 01:22:32 -0700
Message-ID: <c0fe8a7c2f2bd02e5bf240c78e0e320b99c0f2b7.camel@linux.intel.com>
Subject: Re: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Date:   Tue, 26 Jun 2018 11:22:31 +0300
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D953997@hasmsx108.ger.corp.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
         <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D953997@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 18:50 +0000, Winkler, Tomas wrote:
> > 
> > On Sun, 2018-06-24 at 23:52 +0300, Tomas Winkler wrote:
> > > Fix tpm ptt initialization error:
> > > tpm tpm0: A TPM error (378) occurred get tpm pcr allocation.
> > > 
> > > We cannot use go_idle cmd_ready commands via runtime_pm handles as
> > > with the introduction of localities this is no longer an optional
> > > feature, while runtime pm can be not enabled.
> > > Though cmd_ready/go_idle provides a power saving, it's also a part of
> > > TPM2 protocol and should be called explicitly.
> > > This patch exposes cmd_read/go_idle via tpm class ops and removes
> > > runtime pm support as it is not used by any driver.
> > > 
> > > A new tpm transmit flag is added TPM_TRANSMIT_NESTED, which implies
> > > TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed
> > 
> > to resolve
> > > tpm spaces and locality request recursive calls to tpm_transmit().
> > > 
> > > New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
> > 
> > streamline
> > > tpm_try_transmit code.
> > > 
> > > tpm_crb no longer needs own power saving functions and can drop using
> > > tpm_pm_suspend/resume.
> > > 
> > > This patch cannot be really separated from the locality fix.
> > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after
> > > granting
> > > locality)
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after
> > > granting
> > > locality)
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > 
> > Please:
> > 
> > 1. Remove NESTED.
> > 2. Where you need call RAW | UNLOCKED.
> > 3. Do not add __ prefix.
> > 
> > Should be simple changes to do.
> 
> It simple to change, but first you've already agreed on NESTED, second I would
> appreciate some reasoning behind your requests.
> There is a logic behind this why RAW is hidden, it's because it always hast be
> coupled with UNLOCKED, and hence NESTED convers both, it gives cleaner API.

From my side this is NAK.

/Jarkko
