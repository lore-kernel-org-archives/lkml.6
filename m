Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D628C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AC221533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AC221533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeI0UJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:09:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:4917 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbeI0UJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:09:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 06:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="93846913"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.69])
  by fmsmga001.fm.intel.com with ESMTP; 27 Sep 2018 06:51:00 -0700
Date:   Thu, 27 Sep 2018 16:50:59 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Safford <david.safford@ge.com>
Subject: Re: [PATCH v2, RESEND 0/3] tpm: retrieve digest size of unknown
 algorithms from TPM
Message-ID: <20180927135059.GD8242@linux.intel.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
 <1537972840.3459.6.camel@linux.ibm.com>
 <1537985014.3459.24.camel@linux.ibm.com>
 <8bbff5b1-f4ba-4e38-57fc-05d9ddabea5c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bbff5b1-f4ba-4e38-57fc-05d9ddabea5c@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 08:50:14AM +0200, Roberto Sassu wrote:
> On 9/26/2018 8:03 PM, Mimi Zohar wrote:
> > On Wed, 2018-09-26 at 10:40 -0400, Mimi Zohar wrote:
> > > On Mon, 2018-09-17 at 11:38 +0200, Roberto Sassu wrote:
> > > > Resending to maintainer with correct mailing lists in CC.
> > > > 
> > > > The TPM driver currently relies on the crypto subsystem to determine the
> > > > digest size of supported TPM algorithms. In the future, TPM vendors might
> > > > implement new algorithms in their chips, and those algorithms might not
> > > > be supported by the crypto subsystem.
> > > > 
> > > > Usually, vendors provide patches for the new hardware, and likely
> > > > the crypto subsystem will be updated before the new algorithm is
> > > > introduced. However, old kernels might be updated later, after patches
> > > > are included in the mainline kernel. This would leave the opportunity
> > > > for attackers to misuse PCRs, as PCR banks with an unknown algorithm
> > > > are not extended.
> > > > 
> > > > This patch set provides a long term solution for this issue. If a TPM
> > > > algorithm is not known by the crypto subsystem, the TPM driver retrieves
> > > > the digest size from the TPM with a PCR read. All the PCR banks are
> > > > extended, even if the algorithm is not yet supported by the crypto
> > > > subsystem.
> > > 
> > > Other than checking the digest size before copying the pcrread buffer,
> > > the patches look good.  Please add my Ack on all 3 patches.
> > > 
> > > (New address) Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > I've reviewed, and am currently running with these patches.
> > 
> > Even if the IMA changes were in a separate patch, we wouldn't be able
> > to break up the patch set anyway.  Jarkko, I'd appreciate your
> > carrying the entire patch set.
> > 
> > Roberto, a similar change needs to be made for tpm_pcr_extend.  Are
> > you planning on posting those changes as well?
> 
> Yes, I was planning to send the patch after this patch set is accepted.
> 
> Roberto

Mimi, I can carry it yes.

/Jarkko
