Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107D6ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FB421480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FB421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeJROFu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:05:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:25015 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbeJROFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:05:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 23:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,395,1534834800"; 
   d="scan'208";a="96236708"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2018 23:06:26 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 17 Oct 2018 23:06:26 -0700
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 17 Oct 2018 23:06:26 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.212]) with mapi id 14.03.0319.002;
 Thu, 18 Oct 2018 09:06:23 +0300
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
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] tpm: tpm_try_transmit() refactor error flow.
Thread-Topic: [PATCH] tpm: tpm_try_transmit() refactor error flow.
Thread-Index: AQHUZneRpMm4aXcqcE6txCcRpwrMbKUkg60w
Date:   Thu, 18 Oct 2018 06:06:23 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9F5512@hasmsx109.ger.corp.intel.com>
References: <20181016133716.17842-1-tomas.winkler@intel.com>
 <alpine.DEB.2.21.1810180309430.5022@jsakkine-mobl1>
In-Reply-To: <alpine.DEB.2.21.1810180309430.5022@jsakkine-mobl1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTE1YjBhYzAtZjdhNi00ZDI5LWFkNDEtYmNhNTNjYjY4NTM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia0FPYzVqQlFBZ3ZSaktNTjUxR0oyWUg0NmthdHI0aU9WbHNiS1RseUR1ck1XOUhcLzhaMUZMUElxRThaZjNVQ2IifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.154]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Thursday, October 18, 2018 03:15
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Jason Gunthorpe
> <jgg@ziepe.ca>; Nayna Jain <nayna@linux.vnet.ibm.com>; Usyskin,
> Alexander <alexander.usyskin@intel.com>; Struk, Tadeusz
> <tadeusz.struk@intel.com>; linux-integrity@vger.kernel.org; linux-security-
> module@vger.kernel.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: Re: [PATCH] tpm: tpm_try_transmit() refactor error flow.
> 
> On Tue, 16 Oct 2018, Tomas Winkler wrote:
> > First, rename out_no_locality to out_locality for bailing out on both
> > tpm_cmd_ready() and tpm_request_locality() failure.
> 
> This is unnecessary change and technically it is not a rename: the commit
> message text and the code change do not match. Rename is just a rename
> (i.e. change a variable name foo to bar).

I'm renaming the label because it doesn't match the code flow anymore,
I can change the commit message, but you please review the code.
Tomas




