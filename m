Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231DFC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFEF223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFEF223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeKMVJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:09:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:14522 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeKMVJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:09:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 03:12:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,498,1534834800"; 
   d="scan'208";a="95921696"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Nov 2018 03:12:05 -0800
Date:   Tue, 13 Nov 2018 13:12:04 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 16/17] tpm: take TPM chip power gating out of
 tpm_transmit()
Message-ID: <20181113111204.GD10434@linux.intel.com>
References: <20181108141541.12832-1-jarkko.sakkinen@linux.intel.com>
 <20181108141541.12832-17-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA18602@hasmsx108.ger.corp.intel.com>
 <20181108230700.GA8038@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA190F4@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA190F4@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:37:48PM +0000, Winkler, Tomas wrote:
> > On Thu, Nov 08, 2018 at 06:38:59PM +0000, Winkler, Tomas wrote:
> > > > Call tpm_chip_start() and tpm_chip_stop() in
> > > >
> > > > * tpm_try_get_ops() and tpm_put_ops()
> > > > * tpm_chip_register()
> > > > * tpm2_del_space()
> > > >
> > > > And remove these calls from tpm_transmit(). The core reason for this
> > > > change is that in tpm_vtpm_proxy a locality change requires a
> > > > virtual TPM command (a command made up just for that driver).
> > > >
> > > I don't think you can do that,  locality has to be request for each
> > > command, as  for example tboot can request higher locality any time.
> > 
> > That could be a potential problem. How tboot intervention gets prevented
> > without this patch?
> As it was said, need to request locality and relinquish it for each
> command, I believe thought this is not required for client platforms
> only for servers. 

And what I'm trying to under is why so.

If the intervention can happen at any time that would imply that even if
you would request and relinquish locality for a single TPM command, the
intervention could happen in the middle. That is why I'm asking why
without this patch things are just fine.

/Jarkko
