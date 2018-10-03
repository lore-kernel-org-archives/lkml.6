Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CC2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F3B213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F3B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJDFRO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:17:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:4900 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeJDFRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:17:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 15:26:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,337,1534834800"; 
   d="scan'208";a="75207171"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2018 15:24:12 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 3 Oct 2018 15:24:12 -0700
Received: from hasmsx108.ger.corp.intel.com (10.184.198.18) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 3 Oct 2018 15:24:11 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 hasmsx108.ger.corp.intel.com ([169.254.9.136]) with mapi id 14.03.0319.002;
 Thu, 4 Oct 2018 01:24:09 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>
Subject: RE: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
Thread-Topic: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
Thread-Index: AQHUWeozFz0QOr+BiUiSikU4mA0ywaULXotQgAHdBoCAAN6dYA==
Date:   Wed, 3 Oct 2018 22:24:09 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9E5343@hasmsx109.ger.corp.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
 <20181002005208.GH23753@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
 <20181003120141.GA7969@linux.intel.com>
In-Reply-To: <20181003120141.GA7969@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTJhN2FjNzctYTcwOC00ZmQ0LTkyNWEtMTkxNGEzZDg4NmU3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicmRHcG4zRmh1UFhZZXpPS2VGek00ZzJ4WGhMXC9cL3pDMDl1aTZ0bWVCTzhVZWYwMFRlTGxiemdqU3Y2MkU4d0ZDIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.191]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Wednesday, October 03, 2018 15:02
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; Nayna Jain
> <nayna@linux.vnet.ibm.com>; Usyskin, Alexander
> <alexander.usyskin@intel.com>; Struk, Tadeusz <tadeusz.struk@intel.com>;
> linux-integrity@vger.kernel.org; linux-security-module@vger.kernel.org;
> linux-kernel@vger.kernel.org; roberto.sassu@huawei.com
> Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
> 
> On Tue, Oct 02, 2018 at 04:58:25AM +0000, Winkler, Tomas wrote:
> >
> >
> > >
> > > On Sat, Sep 29, 2018 at 01:30:26AM +0300, Tomas Winkler wrote:
> > > > Add tpm2_pcr_extend() function to tpm2-cmd.c with signature
> > > > required by tpm-interface.c. It wraps the original open code
> implementation.
> > > > The original original tpm2_pcr_extend() function is renamed to
> > > > __tpm2_pcr_extend() and made static, it is called only from new
> > > > tpm2_pcr_extend().
> > > >
> > > > Fix warnings in __tpm2_pcr_extend()
> > > > tpm2-cmd.c:251:16: warning: comparison between signed and unsigned
> > > > integer expressions [-Wsign-compare]
> > > > tpm2-cmd.c:252:17: warning: comparison between signed and unsigned
> > > > integer expressions [-Wsign-compare]
> > > >
> > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > >
> > > We do not want the signature change, especially because as we are
> > > working on getting Roberto's changes in and also because it has
> > > absolutely a zero gain. Who cares if those functions take different
> parameters? I don't.
> >
> > Yes, we do care this series tries to have a clean cut between 1.x  and 2.x
> specs. Please, let's finish one transformation and then move to another.
> > I understand that Roberto will have to rebase anyhow, if this series goes in
> first, if this is hard I can do it myself, it's trivial.
> >
> > Tomas
> 
> I'm happy to tune this minor stuff.
What minor stuff?  This patch is just okay, let's change the API in next round.

 I'll wait for Nayna to test the one patch
> and make those adjustments :-) Would not make sense to roll another series
> for these changes.
I agree 
Tomas

