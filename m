Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788A2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E61420B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfBFMnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:43:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:54585 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfBFMnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:43:43 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 04:43:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="316779267"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by fmsmga006.fm.intel.com with ESMTP; 06 Feb 2019 04:43:39 -0800
Date:   Wed, 6 Feb 2019 14:43:38 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v3] tpm/tpm_crb: Avoid unaligned reads in crb_recv()
Message-ID: <20190206124324.GA8126@linux.intel.com>
References: <20190205105136.3086-1-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA90A8B@hasmsx108.ger.corp.intel.com>
 <20190205143541.GA18330@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA90C75@hasmsx108.ger.corp.intel.com>
 <20190205205719.GA13023@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205205719.GA13023@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:57:19PM +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 05, 2019 at 02:56:02PM +0000, Winkler, Tomas wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> > > Sent: Tuesday, February 05, 2019 16:36
> > > To: Winkler, Tomas <tomas.winkler@intel.com>
> > > Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > security-module@vger.kernel.org; stable@vger.kernel.org; James Morris
> > > <jmorris@namei.org>; Jerry Snitselaar <jsnitsel@redhat.com>
> > > Subject: Re: [PATCH v3] tpm/tpm_crb: Avoid unaligned reads in crb_recv()
> > > 
> > > On Tue, Feb 05, 2019 at 11:07:16AM +0000, Winkler, Tomas wrote:
> > > > > The current approach to read first 6 bytes from the response and
> > > > > then tail of the response, can cause the 2nd memcpy_fromio() to do
> > > > > an unaligned read (e.g. read 32-bit word from address aligned to a
> > > > > 16-bits), depending on how
> > > > > memcpy_fromio() is implemented. If this happens, the read will fail
> > > > > and the memory controller will fill the read with 1's.
> > > > >
> > > > > This was triggered by 170d13ca3a2f, which should be probably refined
> > > > > to check and react to the address alignment. Before that commit, on
> > > > > x86
> > > > > memcpy_fromio() turned out to be memcpy(). By a luck GCC has done
> > > > > the right thing (from tpm_crb's perspective) for us so far, but we should not
> > > rely on that.
> > > > > Thus, it makes sense to fix this also in tpm_crb, not least because
> > > > > the fix can be then backported to stable kernels and make them more
> > > > > robust when compiled in differing environments.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Cc: James Morris <jmorris@namei.org>
> > > > > Cc: Tomas Winkler <tomas.winkler@intel.com>
> > > > > Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > ---
> > > > > v3:
> > > > > * Fix typo i.e. %s/reminding/remaining/g
> > > >
> > > > Why you haven't fixed all the typos I've pointed out? I think you missed that.
> > > 
> > > I saw only comment about remaining. Was there something else? Can fix.
> > 
> > https://www.spinics.net/lists/stable/msg283648.html
> > 
> > 1. unrecovable -> unrecoverable
> > 2. /* Read 8 bytes (not just 6 bytes, which would cover the tag and the response  length
> > > +	 * fields) in order to make sure that the remaining memory accesses */ 
> 
> Thanks and apologies for missing these.

Fixed comments and applied the patch, thank you. Do I amend your
acked-by?

/Jarkko
