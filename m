Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC0DC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689D320851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689D320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeKTCbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:31:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:25571 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbeKTCbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:31:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 08:07:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,253,1539673200"; 
   d="scan'208";a="101479862"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2018 08:07:02 -0800
Date:   Mon, 19 Nov 2018 18:07:02 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v5 6/7] tpm: ensure that the output of PCR read contains
 the correct digest size
Message-ID: <20181119160702.GE13298@linux.intel.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-7-roberto.sassu@huawei.com>
 <20181116134153.GD4163@linux.intel.com>
 <05c7c936-da58-f386-0a43-69e96d6e18a8@huawei.com>
 <20181118073207.GC5897@linux.intel.com>
 <a259a629-def7-b538-2a54-8ca6bfbe772a@huawei.com>
 <20181119143357.GG8755@linux.intel.com>
 <ed2d769b-2917-7d8b-ff9c-16220fa17833@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed2d769b-2917-7d8b-ff9c-16220fa17833@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 04:09:34PM +0100, Roberto Sassu wrote:
> On 11/19/2018 3:33 PM, Jarkko Sakkinen wrote:
> > On Mon, Nov 19, 2018 at 09:14:00AM +0100, Roberto Sassu wrote:
> > > On 11/18/2018 8:32 AM, Jarkko Sakkinen wrote:
> > > > On Fri, Nov 16, 2018 at 05:06:48PM +0100, Roberto Sassu wrote:
> > > > > On 11/16/2018 2:41 PM, Jarkko Sakkinen wrote:
> > > > > > On Wed, Nov 14, 2018 at 04:31:07PM +0100, Roberto Sassu wrote:
> > > > > > > This patch protects against data corruption that could happen in the bus,
> > > > > > > by checking that that the digest size returned by the TPM during a PCR read
> > > > > > > matches the size of the algorithm passed to tpm2_pcr_read().
> > > > > > > 
> > > > > > > This check is performed after information about the PCR banks has been
> > > > > > > retrieved.
> > > > > > > 
> > > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > 
> > > > > > Missing fixes tag.
> > > > > 
> > > > > Before this patch set, tpm2_pcr_extend() always copied 20 bytes from the
> > > > > output sent by the TPM.
> > > > > 
> > > > > Roberto
> > > > 
> > > > Aah, right, of course. Well the patch set is ATM somewhat broken because
> > > > this would require a fixes tag that points to a patch insdie the patch
> > > > set.
> > > > 
> > > > Probably good way to fix the issue is to just merge this with the
> > > > earlier commit.
> > > 
> > > Unfortunately, it is not possible. The exact digest size has been
> > > introduced with patch 5/7.
> > 
> > I put this in simple terms: if I merge 5/7 the driver will be broken.
> > Any commit in the patch set should not leave the tree in broken state.
> 
> Patch 6/7 does not fix patch 5/7. The check in patch 6/7 is not done for
> the PCR read performed by patch 5/7, because the digest sizes are not
> yet available.

Ah, right. Point taken :-)

/Jarkko
