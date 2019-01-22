Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A346C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AEB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfAVN3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:29:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:3672 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfAVN3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:29:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 05:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,506,1539673200"; 
   d="scan'208";a="293447219"
Received: from fflynn-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.153])
  by orsmga005.jf.intel.com with ESMTP; 22 Jan 2019 05:29:30 -0800
Date:   Tue, 22 Jan 2019 15:29:28 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190122132910.GA2720@linux.intel.com>
References: <20190118142559.GA4080@linux.intel.com>
 <1547849358.2794.90.camel@HansenPartnership.com>
 <20190120160413.GB30478@linux.intel.com>
 <20190122010218.GA26713@linux.intel.com>
 <20190122025836.GH25163@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122025836.GH25163@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 07:58:36PM -0700, Jason Gunthorpe wrote:
> On Tue, Jan 22, 2019 at 03:02:18AM +0200, Jarkko Sakkinen wrote:
> > On Sun, Jan 20, 2019 at 06:04:13PM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Jan 18, 2019 at 02:09:18PM -0800, James Bottomley wrote:
> > > > On Fri, 2019-01-18 at 16:25 +0200, Jarkko Sakkinen wrote:
> > > > > I get this on a Geminilake NUC after rebasing my maintainer trees:
> > > > > 
> > > > > tpm tpm0: A TPM error (-1) occurred attempting the self test
> > > > > 
> > > > > I checked the latest commit ID from drivers/char/tpm to make sure
> > > > > that I did not put anything broken to my last PR [1]. It works
> > > > > without issues.
> > > > > 
> > > > > In addition [2] gives me an empty diff.
> > > > > 
> > > > > Something outside of the TPM driver must have happened that breaks
> > > > > the driver. Any ideas?
> > > > > 
> > > > > [1] commit 9488585b21bef0df1217e510c7134905d1d376a7
> > > > > [2] git diff 9488585b21bef0df1217e510c7134905d1d376a7 master
> > > > > drivers/char/tpm/
> > > > 
> > > > I'm afraid you're going to have to bisect to find the offending in-
> > > > kernel commit, which is going to be painful since it seems to depend on
> > > > physical hardware.  My first instinct is that we're getting a zero
> > > > length read somewhere, but I still can't see anything in the merge
> > > > window that would cause that behaviour.
> > > 
> > > Yeah, I've started to bisect it (still 9 rounds to go).
> > 
> > Fails on commit 170d13ca3a2fdaaa0283399247631b76b441cca2. Still works on
> > preceding commit a959dc88f9c8900296ccf13e2f3e1cbc555a8917.
> 
> This changes the IO access pattern in memcpy_to/fromio.. Presumably
> CRB HW doesn't like the new 4 byte move? Swap each one in crb to
> memcpy to confirm..
> 
> If the HW requires particular access patterns you can't use
> memcpy_to/fromio

Did not have time to look at the commit at all but your deduction
is correct. I know it without testing.

Memory controller will feed 1's on unaligned read from IO memory,
and as we can see from the TPM header, this change causes two of
those:

struct tpm_output_header {
	__be16	tag;
	__be32	length;
	__be32	return_code;
} __packed;

/Jarkko
