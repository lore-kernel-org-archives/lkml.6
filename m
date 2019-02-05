Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA08C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A93F206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfBEOfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:35:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:16654 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbfBEOfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:35:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 06:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="122160687"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by fmsmga008.fm.intel.com with ESMTP; 05 Feb 2019 06:35:49 -0800
Date:   Tue, 5 Feb 2019 16:35:41 +0200
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
Message-ID: <20190205143541.GA18330@linux.intel.com>
References: <20190205105136.3086-1-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA90A8B@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA90A8B@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:07:16AM +0000, Winkler, Tomas wrote:
> > The current approach to read first 6 bytes from the response and then tail of
> > the response, can cause the 2nd memcpy_fromio() to do an unaligned read
> > (e.g. read 32-bit word from address aligned to a 16-bits), depending on how
> > memcpy_fromio() is implemented. If this happens, the read will fail and the
> > memory controller will fill the read with 1's.
> > 
> > This was triggered by 170d13ca3a2f, which should be probably refined to check
> > and react to the address alignment. Before that commit, on x86
> > memcpy_fromio() turned out to be memcpy(). By a luck GCC has done the right
> > thing (from tpm_crb's perspective) for us so far, but we should not rely on that.
> > Thus, it makes sense to fix this also in tpm_crb, not least because the fix can be
> > then backported to stable kernels and make them more robust when compiled
> > in differing environments.
> > 
> > Cc: stable@vger.kernel.org
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Tomas Winkler <tomas.winkler@intel.com>
> > Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> > Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > ---
> > v3:
> > * Fix typo i.e. %s/reminding/remaining/g
> 
> Why you haven't fixed all the typos I've pointed out? I think you missed that.

I saw only comment about remaining. Was there something else? Can fix.

/Jarkko
