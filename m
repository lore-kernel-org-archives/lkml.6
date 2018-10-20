Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C981EECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2AA2172F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2AA2172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJUHBt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 03:01:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:58913 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeJUHBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 03:01:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2018 15:49:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,405,1534834800"; 
   d="scan'208";a="93669074"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2018 15:49:44 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 20 Oct 2018 15:49:44 -0700
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 20 Oct 2018 15:49:44 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.223]) with mapi id 14.03.0319.002;
 Sun, 21 Oct 2018 01:49:41 +0300
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
Thread-Index: AQHUZneRpMm4aXcqcE6txCcRpwrMbKUkg60wgAKFoACAAbSoMA==
Date:   Sat, 20 Oct 2018 22:49:40 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9F85F5@hasmsx109.ger.corp.intel.com>
References: <20181016133716.17842-1-tomas.winkler@intel.com>
 <alpine.DEB.2.21.1810180309430.5022@jsakkine-mobl1>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9F5512@hasmsx109.ger.corp.intel.com>
 <alpine.DEB.2.21.1810200230200.9963@jsakkine-mobl1>
In-Reply-To: <alpine.DEB.2.21.1810200230200.9963@jsakkine-mobl1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjYwYjJhYjQtN2NlYi00YWUxLWFmYWItNDc0MzE4YzUyYjg3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ29EV3pPM2Nld3V2aWJcL21mV1RsMnJ5QkQ3NGt3OENlRGRxMmp6VW5ubXpVZUtRdFNtbWVPcUhuanpqaGxKZ2EifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.249.90.242]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, 18 Oct 2018, Winkler, Tomas wrote:
> >> -----Original Message-----
> >> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> >> Sent: Thursday, October 18, 2018 03:15
> >> To: Winkler, Tomas <tomas.winkler@intel.com>
> >> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Jason
> >> Gunthorpe <jgg@ziepe.ca>; Nayna Jain <nayna@linux.vnet.ibm.com>;
> >> Usyskin, Alexander <alexander.usyskin@intel.com>; Struk, Tadeusz
> >> <tadeusz.struk@intel.com>; linux-integrity@vger.kernel.org;
> >> linux-security- module@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> stable@vger.kernel.org
> >> Subject: Re: [PATCH] tpm: tpm_try_transmit() refactor error flow.
> >>
> >> On Tue, 16 Oct 2018, Tomas Winkler wrote:
> >>> First, rename out_no_locality to out_locality for bailing out on
> >>> both
> >>> tpm_cmd_ready() and tpm_request_locality() failure.
> >>
> >> This is unnecessary change and technically it is not a rename: the
> >> commit message text and the code change do not match. Rename is just
> >> a rename (i.e. change a variable name foo to bar).
> >
> > I'm renaming the label because it doesn't match the code flow anymore,
> > I can change the commit message, but you please review the code.
> > Tomas
> 
> The flow change is unnecessary and does not really have anything to do with
> the bug fix. 

What I see in the original code is that when 
tpm_cmd_ready()  fails it's jumps to 'out' label and trying to do tpm_go_idle()
but instead it should just undoing the locality, so both cmd_read and go idle had a wrong 
jump. I see both should  be fixed.

Earlier version was better than this and would have been fine
> when taking account the remark from Jason.

