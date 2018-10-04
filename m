Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D2BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEC021470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEC021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeJDSik convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:38:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:11398 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbeJDSik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 04:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,338,1534834800"; 
   d="scan'208";a="96414521"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2018 04:45:33 -0700
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 4 Oct 2018 04:45:33 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.212]) with mapi id 14.03.0319.002;
 Thu, 4 Oct 2018 14:45:30 +0300
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
Thread-Index: AQHUWeozFz0QOr+BiUiSikU4mA0ywaULXotQgAHdBoCAAN6dYIAArEYAgAAyobA=
Date:   Thu, 4 Oct 2018 11:45:30 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9E6D00@hasmsx109.ger.corp.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
 <20181002005208.GH23753@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
 <20181003120141.GA7969@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E5343@hasmsx109.ger.corp.intel.com>
 <20181004113502.GA12498@linux.intel.com>
In-Reply-To: <20181004113502.GA12498@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTMwMWM5Y2UtN2RiMi00ODhhLTg1YWMtMjk3ZDJkN2NjZTY0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidEVWcyt1T3JVWEdNUXlwcW01WkJWN2loN3lNaU9ZWlZYdXVLbzdNNzlXaTJySm5jTEYraExtOUNQMHFpQmp2bCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.254]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Thursday, October 04, 2018 14:35
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; Nayna Jain
> <nayna@linux.vnet.ibm.com>; Usyskin, Alexander
> <alexander.usyskin@intel.com>; Struk, Tadeusz <tadeusz.struk@intel.com>;
> linux-integrity@vger.kernel.org; linux-security-module@vger.kernel.org;
> linux-kernel@vger.kernel.org; roberto.sassu@huawei.com
> Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
> 
> On Wed, Oct 03, 2018 at 10:24:09PM +0000, Winkler, Tomas wrote:
> >
> >
> > > -----Original Message-----
> > > From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> > > Sent: Wednesday, October 03, 2018 15:02
> > > To: Winkler, Tomas <tomas.winkler@intel.com>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>; Nayna Jain
> > > <nayna@linux.vnet.ibm.com>; Usyskin, Alexander
> > > <alexander.usyskin@intel.com>; Struk, Tadeusz
> > > <tadeusz.struk@intel.com>; linux-integrity@vger.kernel.org;
> > > linux-security-module@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; roberto.sassu@huawei.com
> > > Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to
> > > tpm2-cmd.c
> > >
> > > On Tue, Oct 02, 2018 at 04:58:25AM +0000, Winkler, Tomas wrote:
> > > >
> > > >
> > > > >
> > > > > On Sat, Sep 29, 2018 at 01:30:26AM +0300, Tomas Winkler wrote:
> > > > > > Add tpm2_pcr_extend() function to tpm2-cmd.c with signature
> > > > > > required by tpm-interface.c. It wraps the original open code
> > > implementation.
> > > > > > The original original tpm2_pcr_extend() function is renamed to
> > > > > > __tpm2_pcr_extend() and made static, it is called only from
> > > > > > new tpm2_pcr_extend().
> > > > > >
> > > > > > Fix warnings in __tpm2_pcr_extend()
> > > > > > tpm2-cmd.c:251:16: warning: comparison between signed and
> > > > > > unsigned integer expressions [-Wsign-compare]
> > > > > > tpm2-cmd.c:252:17: warning: comparison between signed and
> > > > > > unsigned integer expressions [-Wsign-compare]
> > > > > >
> > > > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > >
> > > > > We do not want the signature change, especially because as we
> > > > > are working on getting Roberto's changes in and also because it
> > > > > has absolutely a zero gain. Who cares if those functions take
> > > > > different
> > > parameters? I don't.
> > > >
> > > > Yes, we do care this series tries to have a clean cut between 1.x
> > > > and 2.x
> > > specs. Please, let's finish one transformation and then move to another.
> > > > I understand that Roberto will have to rebase anyhow, if this
> > > > series goes in
> > > first, if this is hard I can do it myself, it's trivial.
> > > >
> > > > Tomas
> > >
> > > I'm happy to tune this minor stuff.
> > What minor stuff?  This patch is just okay, let's change the API in next
> round.
> 
> The patch is not okay because it does a completely unnecessary API change.
 
There is no API change, in that sense.
The exported API is in tpm-interface.c int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)  
that is used is outside of the tpm reminds the same, only the open coded implementation of tpm2_pcr_extned has moved to
tpm2-cmd.c, This code is not called out of tpm module.
Please review the code again.

Thanks
Tomas


