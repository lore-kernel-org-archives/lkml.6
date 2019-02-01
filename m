Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D34C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05B121872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfBALkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:40:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:32546 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfBALko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:40:44 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 03:40:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,548,1539673200"; 
   d="scan'208";a="143365139"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2019 03:40:41 -0800
Date:   Fri, 1 Feb 2019 13:40:41 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        tomas.winkler@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190201114041.GA15858@linux.intel.com>
References: <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com>
 <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com>
 <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
 <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
 <CAHk-=whYtqGO7v7c=Ak0xQfonGVbC_1sRHfxS4xNO-Sa6mFevw@mail.gmail.com>
 <20190131204710.GB354@linux.intel.com>
 <CAHk-=wgPCL9WgkwvK5ehJxg7Df1DHQqGZ0KtBxtjN93QjzUyog@mail.gmail.com>
 <20190131233136.3dhadb7a46lp2nu6@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131233136.3dhadb7a46lp2nu6@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 04:31:36PM -0700, Jerry Snitselaar wrote:
> On Thu Jan 31 19, Linus Torvalds wrote:
> > On Thu, Jan 31, 2019 at 12:47 PM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > > 
> > > I'll try it first thing when I wake up tomorrow (11PM in Finland ATM).
> > 
> > Thanks.
> > 
> > > Appreciate for taking time on this.
> > 
> > Hey, it was my commit that broke it for you. Even if it happened to
> > work before, and only did so by pure luck, it was a functional
> > regression.
> > 
> > I get very upset when other developers don't step up when *their*
> > changes break something, and I don't consider "it shouldn't have
> > worked in the first place" to be a valid excuse. You broke it, you'd
> > better fix it.
> > 
> > So I had better fix my own mess too, in order to not look too hypocritical.
> > 
> > And I was very aware that hardcoding the memcpy_*io() access patterns
> > might break something. I just _hoped_ it wouldn't, because we actually
> > ended up going back to the very original access patterns (but it was
> > from a long long time ago).
> > 
> > In fact, while it's slightly annoying, in many ways it's actually good
> > that we found breakage, and could pinpoint exactly *why* it broke.
> > That does validate the whole "we shouldn't just depend on the random
> > implementation detail of 'memcpy()'" argument.
> > 
> > So I'll wait to hear back whether that patch fixes things for you, but
> > I _think_ it will, and we'll be better off in the long range with this
> > whole thing.
> > 
> >              Linus
> 
> I just did a quick test here of booting and running a couple commands
> (tpm2_getcap, tpm2_pcrlist), and the patch seems to work for me. I was
> seeing the error during tpm_crb initialization without the patch.

Works for me too. Just submitted tpm_crb level fix too for the reasons
explained in accompanied commit message.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
