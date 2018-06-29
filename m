Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D34FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD9227852
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD9227852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933922AbeF2KgB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:36:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:41528 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752637AbeF2Kf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:35:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 03:35:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="53861567"
Received: from egur-mobl.ger.corp.intel.com ([10.249.254.49])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2018 03:35:53 -0700
Message-ID: <53d76dcd02c69f207a2831f9ede55b867c7438b6.camel@linux.intel.com>
Subject: Re: [PATCH v8] tpm: separate cmd_ready/go_idle from runtime_pm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Struk@vger.kernel.org, Tadeusz <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Fri, 29 Jun 2018 13:35:52 +0300
In-Reply-To: <20180628151333.14368-1-tomas.winkler@intel.com>
References: <20180628151333.14368-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 18:13 +0300, Tomas Winkler wrote:
> Fix tpm ptt initialization error:
> tpm tpm0: A TPM error (378) occurred get tpm pcr allocation.
> 
> We cannot use go_idle cmd_ready commands via runtime_pm handles
> as with the introduction of localities this is no longer an optional
> feature, while runtime pm can be not enabled.
> Though cmd_ready/go_idle provides a power saving, it's also a part of
> TPM2 protocol and should be called explicitly.
> This patch exposes cmd_read/go_idle via tpm class ops and removes
> runtime pm support as it is not used by any driver.
> 
> When calling from nested context always use both flags:
> TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed to resolve
> tpm spaces and locality request recursive calls to tpm_transmit().
> TPM_TRANSMIT_RAW should never be used standalone as it will fail
> on double locking. While TPM_TRANSMIT_UNLOCKED standalone should be
> called from non-recursive locked contexts.
> 
> New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
> streamline tpm_try_transmit code.
> 
> tpm_crb no longer needs own power saving functions and can drop using
> tpm_pm_suspend/resume.
> 
> This patch cannot be really separated from the locality fix.
> Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> locality)
> 
> 
> Cc: stable@vger.kernel.org
> Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> locality)
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
