Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE26C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4BA27EED
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4BA27EED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755444AbeF2Maj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:30:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:54018 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeF2Mah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:30:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 05:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="70997605"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.88])
  by orsmga002.jf.intel.com with ESMTP; 29 Jun 2018 05:30:32 -0700
Date:   Fri, 29 Jun 2018 15:30:30 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Struk@linux.intel.com, Tadeusz <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8] tpm: separate cmd_ready/go_idle from runtime_pm
Message-ID: <20180629123029.GA21735@linux.intel.com>
References: <20180628151333.14368-1-tomas.winkler@intel.com>
 <53d76dcd02c69f207a2831f9ede55b867c7438b6.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d76dcd02c69f207a2831f9ede55b867c7438b6.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:35:52PM +0300, Jarkko Sakkinen wrote:
> On Thu, 2018-06-28 at 18:13 +0300, Tomas Winkler wrote:
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
> > When calling from nested context always use both flags:
> > TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed to resolve
> > tpm spaces and locality request recursive calls to tpm_transmit().
> > TPM_TRANSMIT_RAW should never be used standalone as it will fail
> > on double locking. While TPM_TRANSMIT_UNLOCKED standalone should be
> > called from non-recursive locked contexts.
> > 
> > New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
> > streamline tpm_try_transmit code.
> > 
> > tpm_crb no longer needs own power saving functions and can drop using
> > tpm_pm_suspend/resume.
> > 
> > This patch cannot be really separated from the locality fix.
> > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> > locality)
> > 
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> > locality)
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Noticed that your author field is malformed (Should be "Tomas Winkler"
instead of "Winkler, Tomas") but I'll fix that.

/Jarkko
