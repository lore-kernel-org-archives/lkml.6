Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8D5C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5909220645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5909220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJCSuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:50:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:43142 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeJCSuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:50:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 05:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="85399694"
Received: from hoffmann-mobl.ger.corp.intel.com (HELO localhost) ([10.249.38.250])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2018 05:01:44 -0700
Date:   Wed, 3 Oct 2018 15:01:41 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
Message-ID: <20181003120141.GA7969@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
 <20181002005208.GH23753@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 04:58:25AM +0000, Winkler, Tomas wrote:
> 
> 
> > 
> > On Sat, Sep 29, 2018 at 01:30:26AM +0300, Tomas Winkler wrote:
> > > Add tpm2_pcr_extend() function to tpm2-cmd.c with signature required
> > > by tpm-interface.c. It wraps the original open code implementation.
> > > The original original tpm2_pcr_extend() function is renamed to
> > > __tpm2_pcr_extend() and made static, it is called only from new
> > > tpm2_pcr_extend().
> > >
> > > Fix warnings in __tpm2_pcr_extend()
> > > tpm2-cmd.c:251:16: warning: comparison between signed and unsigned
> > > integer expressions [-Wsign-compare]
> > > tpm2-cmd.c:252:17: warning: comparison between signed and unsigned
> > > integer expressions [-Wsign-compare]
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > 
> > We do not want the signature change, especially because as we are working
> > on getting Roberto's changes in and also because it has absolutely a zero
> > gain. Who cares if those functions take different parameters? I don't.
> 
> Yes, we do care this series tries to have a clean cut between 1.x  and 2.x specs. Please, let's finish one transformation and then move to another.
> I understand that Roberto will have to rebase anyhow, if this series goes in first, if this is hard I can do it myself, it's trivial.
> 
> Tomas

I'm happy to tune this minor stuff. I'll wait for Nayna to test
the one patch and make those adjustments :-) Would not make sense
to roll another series for these changes.

/Jarkko
