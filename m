Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246DCC04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C1C2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C1C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeKTA5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:57:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:23645 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbeKTA5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:57:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 06:34:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="97444961"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2018 06:33:58 -0800
Date:   Mon, 19 Nov 2018 16:33:57 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v5 6/7] tpm: ensure that the output of PCR read contains
 the correct digest size
Message-ID: <20181119143357.GG8755@linux.intel.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-7-roberto.sassu@huawei.com>
 <20181116134153.GD4163@linux.intel.com>
 <05c7c936-da58-f386-0a43-69e96d6e18a8@huawei.com>
 <20181118073207.GC5897@linux.intel.com>
 <a259a629-def7-b538-2a54-8ca6bfbe772a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a259a629-def7-b538-2a54-8ca6bfbe772a@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:14:00AM +0100, Roberto Sassu wrote:
> On 11/18/2018 8:32 AM, Jarkko Sakkinen wrote:
> > On Fri, Nov 16, 2018 at 05:06:48PM +0100, Roberto Sassu wrote:
> > > On 11/16/2018 2:41 PM, Jarkko Sakkinen wrote:
> > > > On Wed, Nov 14, 2018 at 04:31:07PM +0100, Roberto Sassu wrote:
> > > > > This patch protects against data corruption that could happen in the bus,
> > > > > by checking that that the digest size returned by the TPM during a PCR read
> > > > > matches the size of the algorithm passed to tpm2_pcr_read().
> > > > > 
> > > > > This check is performed after information about the PCR banks has been
> > > > > retrieved.
> > > > > 
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Cc: stable@vger.kernel.org
> > > > 
> > > > Missing fixes tag.
> > > 
> > > Before this patch set, tpm2_pcr_extend() always copied 20 bytes from the
> > > output sent by the TPM.
> > > 
> > > Roberto
> > 
> > Aah, right, of course. Well the patch set is ATM somewhat broken because
> > this would require a fixes tag that points to a patch insdie the patch
> > set.
> > 
> > Probably good way to fix the issue is to just merge this with the
> > earlier commit.
> 
> Unfortunately, it is not possible. The exact digest size has been
> introduced with patch 5/7.

I put this in simple terms: if I merge 5/7 the driver will be broken.
Any commit in the patch set should not leave the tree in broken state.

That implies that 5/7 and 6/7 cannot be separate commits.

/Jarkko
