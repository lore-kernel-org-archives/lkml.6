Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03D1C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974382085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974382085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbeKEW7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:59:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:2318 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbeKEW7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:59:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 05:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="103526625"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.180])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2018 05:39:47 -0800
Date:   Mon, 5 Nov 2018 15:39:47 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2] tpm: add support for partial reads
Message-ID: <20181105133947.GA21757@linux.intel.com>
References: <154084273717.29396.1021945733871865594.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154084273717.29396.1021945733871865594.stgit@tstruk-mobl1.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 12:52:17PM -0700, Tadeusz Struk wrote:
> Currently to read a response from the TPM device an application needs
> provide big enough buffer for the whole response and read it in one go.
> The application doesn't know how big the response it beforehand so it
> always needs to maintain a 4K buffer and read the max (4K).
> In case if the user of the TSS library doesn't provide big enough
> buffer the TCTI spec says that the library should set the required
> size and return TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the
> application could allocate a bigger buffer and call receive again.
> To make it possible in the TSS library, this requires being able to do
> partial reads from the driver.
> The library would read the 10 bytes header first to get the actual size
> of the response from the header, and then read the rest of the response.
> This patch adds support for partial reads, i.e. the user can read the
> response in one or multiple reads, until the whole response is consumed.
> The user can also read only part of the response and ignore
> the rest by issuing a new write to send a new command.
> 
> The usecase is implemented in this TSS commit:
> https://github.com/tpm2-software/tpm2-tss/commit/ce982f67a67dc08e24683d30b05800648d8a264c
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
> Changes in v2:
>  - Allow writes after only partial response is consumed to maintain
>    backwords compatibility.

I do not understand what this bullet means. Do you deny writes somehow?

/Jarkko
