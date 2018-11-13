Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49392C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE7420818
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE7420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbeKMV4w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:56:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:18115 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbeKMV4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:56:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 03:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="85461526"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 13 Nov 2018 03:59:03 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 13 Nov 2018 03:59:03 -0800
Received: from lcsmsx155.ger.corp.intel.com (10.186.165.233) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 13 Nov 2018 03:59:02 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.165]) by
 LCSMSX155.ger.corp.intel.com ([169.254.12.124]) with mapi id 14.03.0415.000;
 Tue, 13 Nov 2018 13:58:58 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Nayna Jain" <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 16/17] tpm: take TPM chip power gating out of
 tpm_transmit()
Thread-Topic: [PATCH v5 16/17] tpm: take TPM chip power gating out of
 tpm_transmit()
Thread-Index: AQHUd238CNv13jYvhU+0nbO7Ml7SjKVGNDswgAAq4wCAAZjFgIAFeyMAgAAuTKA=
Date:   Tue, 13 Nov 2018 11:58:58 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA1CC0A@hasmsx108.ger.corp.intel.com>
References: <20181108141541.12832-1-jarkko.sakkinen@linux.intel.com>
 <20181108141541.12832-17-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA18602@hasmsx108.ger.corp.intel.com>
 <20181108230700.GA8038@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA190F4@hasmsx108.ger.corp.intel.com>
 <20181113111204.GD10434@linux.intel.com>
In-Reply-To: <20181113111204.GD10434@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjhiZDQwMmMtNDQwZi00NGI5LWJkM2EtMjI1MTRkNmE1ZTA0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNnBOa2ZzQ0pUZ2M5WHVqMjFzZXpndGxoZHc1ZnJiRDFVYithcDdodERqYmc5STlqNWpaSHcyaGx4UjlQQXE0dyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.92]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Tuesday, November 13, 2018 13:12
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: linux-integrity@vger.kernel.org; linux-security-module@vger.kernel.org;
> James Bottomley <James.Bottomley@HansenPartnership.com>; Struk,
> Tadeusz <tadeusz.struk@intel.com>; Stefan Berger
> <stefanb@linux.vnet.ibm.com>; Nayna Jain <nayna@linux.ibm.com>; Peter
> Huewe <peterhuewe@gmx.de>; Jason Gunthorpe <jgg@ziepe.ca>; Arnd
> Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v5 16/17] tpm: take TPM chip power gating out of
> tpm_transmit()
> 
> On Fri, Nov 09, 2018 at 09:37:48PM +0000, Winkler, Tomas wrote:
> > > On Thu, Nov 08, 2018 at 06:38:59PM +0000, Winkler, Tomas wrote:
> > > > > Call tpm_chip_start() and tpm_chip_stop() in
> > > > >
> > > > > * tpm_try_get_ops() and tpm_put_ops()
> > > > > * tpm_chip_register()
> > > > > * tpm2_del_space()
> > > > >
> > > > > And remove these calls from tpm_transmit(). The core reason for
> > > > > this change is that in tpm_vtpm_proxy a locality change requires
> > > > > a virtual TPM command (a command made up just for that driver).
> > > > >
> > > > I don't think you can do that,  locality has to be request for
> > > > each command, as  for example tboot can request higher locality any
> time.
> > >
> > > That could be a potential problem. How tboot intervention gets
> > > prevented without this patch?
> > As it was said, need to request locality and relinquish it for each
> > command, I believe thought this is not required for client platforms
> > only for servers.
> 
> And what I'm trying to under is why so.
> 
> If the intervention can happen at any time that would imply that even if you
> would request and relinquish locality for a single TPM command, the
> intervention could happen in the middle. That is why I'm asking why without
> this patch things are just fine.
Yes, w/o this constrain it would be okay to request locality only once, 
we can ask tboot ask again but at the time the requirement was that locality can be taken of at any point, 
I believe that the locality won't be granted till a single command is completed.

Anyhow still the power gating is wrong in this patch do not ignore that part.

Thanks
Tomas

