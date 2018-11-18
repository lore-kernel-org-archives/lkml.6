Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58201C04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 07:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB6920868
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 07:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB6920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeKRRz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 12:55:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:8717 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbeKRRz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 12:55:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2018 23:36:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,247,1539673200"; 
   d="scan'208";a="280924692"
Received: from kaczmarx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.89])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2018 23:36:21 -0800
Date:   Sun, 18 Nov 2018 09:36:18 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 08/17] tpm: call tpm2_flush_space() on error in
 tpm_try_transmit()
Message-ID: <20181118073618.GD5897@linux.intel.com>
References: <20181116123845.15705-1-jarkko.sakkinen@linux.intel.com>
 <20181116123845.15705-9-jarkko.sakkinen@linux.intel.com>
 <20181116161957.GG1706@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116161957.GG1706@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 11:19:57AM -0500, Sasha Levin wrote:
> On Fri, Nov 16, 2018 at 02:38:32PM +0200, Jarkko Sakkinen wrote:
> > Always call tpm2_flush_space() on failure in tpm_try_transmit() so that
> > the volatile memory of the TPM gets cleared. If /dev/tpm0 does not have
> > sufficient permissions (usually it has), this could lead to the leakage
> > of TPM objects. Through /dev/tpmrm0 this issue does not raise any new
> > security concerns.
> > 
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 745b361e989a ("tpm:tpm: infrastructure for TPM spaces")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Hi Jarkko,
> 
> This patch seems to depend on previous patches in this series, but those
> were not tagged for stable. Do they also need to be backported? If so,
> can you tag them as such?

Hi

Is that the preferred approach?

I've usually followed this workflow:

1. Mark patches with a fix to a regression with the fixes tag.
2. If a merge conflict raises, I'll locate the deps.

I've done it this way because often patches can depend on patches
outside the patch set. Anyway, I'm open to change my workflow if
that is required.

/Jarkko
