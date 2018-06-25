Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6D1C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83B725E47
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83B725E47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755260AbeFYQaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:30:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:14647 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754834AbeFYQaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:30:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 09:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="60045532"
Received: from mstribae-mobl.ger.corp.intel.com ([10.249.254.44])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jun 2018 09:30:17 -0700
Message-ID: <cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
Subject: Re: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Mon, 25 Jun 2018 19:30:15 +0300
In-Reply-To: <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
         <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 19:24 +0300, Jarkko Sakkinen wrote:
> On Sun, 2018-06-24 at 23:52 +0300, Tomas Winkler wrote:
> > Fix tpm ptt initialization error:
> > tpm tpm0: A TPM error (378) occurred get tpm pcr allocation.
> > 
> > We cannot use go_idle cmd_ready commands via runtime_pm handles
> > as with the introduction of localities this is no longer an optional
> > feature, while runtime pm can be not enabled.
> > Though cmd_ready/go_idle provides a power saving, it's also a part of
> > TPM2 protocol and should be called explicitly.
> > This patch exposes cmd_read/go_idle via tpm class ops and removes
> > runtime pm support as it is not used by any driver.
> > 
> > A new tpm transmit flag is added TPM_TRANSMIT_NESTED, which implies
> > TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed to resolve
> > tpm spaces and locality request recursive calls to tpm_transmit().
> > 
> > New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
> > streamline tpm_try_transmit code.
> > 
> > tpm_crb no longer needs own power saving functions and can drop using
> > tpm_pm_suspend/resume.
> > 
> > This patch cannot be really separated from the locality fix.
> > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after
> > granting
> > locality)
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after
> > granting
> > locality)
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> Please:
> 
> 1. Remove NESTED.
> 2. Where you need call RAW | UNLOCKED.
> 3. Do not add __ prefix.

Right now if I really put head into this I can understand the logic
but it is a complete mess. I will forgot the dependencies between
flags within few weeks. A fixed requirement (so that you know) is
that they must be independent.

/Jarkko
