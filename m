Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA107C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38EE2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfBEO4I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:56:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:23261 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfBEO4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:56:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 06:56:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="136065448"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga001.jf.intel.com with ESMTP; 05 Feb 2019 06:56:06 -0800
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 5 Feb 2019 06:56:06 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.55]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.13]) with mapi id 14.03.0415.000;
 Tue, 5 Feb 2019 16:56:03 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: RE: [PATCH v3] tpm/tpm_crb: Avoid unaligned reads in crb_recv()
Thread-Topic: [PATCH v3] tpm/tpm_crb: Avoid unaligned reads in crb_recv()
Thread-Index: AQHUvUDUPtSrjGtlHk6wCuMRxetyu6XRCy8AgAAY64CAACU3gA==
Date:   Tue, 5 Feb 2019 14:56:02 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA90C75@hasmsx108.ger.corp.intel.com>
References: <20190205105136.3086-1-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA90A8B@hasmsx108.ger.corp.intel.com>
 <20190205143541.GA18330@linux.intel.com>
In-Reply-To: <20190205143541.GA18330@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.255.205.248]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Tuesday, February 05, 2019 16:36
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> security-module@vger.kernel.org; stable@vger.kernel.org; James Morris
> <jmorris@namei.org>; Jerry Snitselaar <jsnitsel@redhat.com>
> Subject: Re: [PATCH v3] tpm/tpm_crb: Avoid unaligned reads in crb_recv()
> 
> On Tue, Feb 05, 2019 at 11:07:16AM +0000, Winkler, Tomas wrote:
> > > The current approach to read first 6 bytes from the response and
> > > then tail of the response, can cause the 2nd memcpy_fromio() to do
> > > an unaligned read (e.g. read 32-bit word from address aligned to a
> > > 16-bits), depending on how
> > > memcpy_fromio() is implemented. If this happens, the read will fail
> > > and the memory controller will fill the read with 1's.
> > >
> > > This was triggered by 170d13ca3a2f, which should be probably refined
> > > to check and react to the address alignment. Before that commit, on
> > > x86
> > > memcpy_fromio() turned out to be memcpy(). By a luck GCC has done
> > > the right thing (from tpm_crb's perspective) for us so far, but we should not
> rely on that.
> > > Thus, it makes sense to fix this also in tpm_crb, not least because
> > > the fix can be then backported to stable kernels and make them more
> > > robust when compiled in differing environments.
> > >
> > > Cc: stable@vger.kernel.org
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: Tomas Winkler <tomas.winkler@intel.com>
> > > Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> > > Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > ---
> > > v3:
> > > * Fix typo i.e. %s/reminding/remaining/g
> >
> > Why you haven't fixed all the typos I've pointed out? I think you missed that.
> 
> I saw only comment about remaining. Was there something else? Can fix.

https://www.spinics.net/lists/stable/msg283648.html

1. unrecovable -> unrecoverable
2. /* Read 8 bytes (not just 6 bytes, which would cover the tag and the response  length
> +	 * fields) in order to make sure that the remaining memory accesses */ 
                                                                             
Thanks
Tomas

