Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8CCC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A0C20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfBEKry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:47:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:20030 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfBEKry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:47:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 02:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="scan'208";a="144297225"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by fmsmga001.fm.intel.com with ESMTP; 05 Feb 2019 02:47:51 -0800
Date:   Tue, 5 Feb 2019 12:47:47 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
Message-ID: <20190205104747.GB1823@linux.intel.com>
References: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
 <0446c899270a4b128a6d05e62d63e704@AcuMS.aculab.com>
 <20190205104406.GA1823@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205104406.GA1823@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 12:44:06PM +0200, Jarkko Sakkinen wrote:
> On Mon, Feb 04, 2019 at 12:17:43PM +0000, David Laight wrote:
> > From: Jarkko Sakkinen
> > > Sent: 01 February 2019 11:20
> > > The current approach to read first 6 bytes from the response and then tail
> > > of the response, can cause the 2nd memcpy_fromio() to do an unaligned read
> > > (e.g. read 32-bit word from address aligned to a 16-bits), depending on how
> > > memcpy_fromio() is implemented. If this happens, the read will fail and the
> > > memory controller will fill the read with 1's.
> > 
> > To my mind memcpy_to/fromio() should only be used on IO addresses that are
> > adequately like memory, and should be implemented in a way that that won't
> > generate invalid bus cycles.
> > Also memcpy_fromio() should also be allowed to do 'aligned' accesses that
> > go beyond the ends of the required memory area.
> > 
> > ...
> > > 
> > > -	memcpy_fromio(buf, priv->rsp, 6);
> > > +	memcpy_fromio(buf, priv->rsp, 8);
> > >  	expected = be32_to_cpup((__be32 *) &buf[2]);
> > > -	if (expected > count || expected < 6)
> > > +	if (expected > count || expected < 8)
> > >  		return -EIO;
> > > 
> > > -	memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
> > > +	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> > 
> > Why not just use readl() or readq() ?
> > 
> > Bound to generate better code.
> 
> For the first read can be done. The second read is of variable
> length.

Neither can be done to the first one, because readq() does
le64_to_cpu(). Shoud not do any conversions, only raw read.
So I'll just stick it to what we have.

/jarkko
