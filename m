Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C35C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EA02082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EA02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeJXR2o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:28:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:47079 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeJXR2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:28:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 02:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="90811378"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Oct 2018 02:01:28 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 02:01:28 -0700
Received: from hasmsx111.ger.corp.intel.com (10.184.198.39) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 02:01:27 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 HASMSX111.ger.corp.intel.com ([169.254.5.194]) with mapi id 14.03.0319.002;
 Wed, 24 Oct 2018 12:01:26 +0300
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
Thread-Index: AQHUZneRpMm4aXcqcE6txCcRpwrMbKUkg60wgAKFoACAAbSoMIAD6zIAgAA5PtCAAQ4lAIAAMqtQ
Date:   Wed, 24 Oct 2018 09:01:25 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9FC1E7@hasmsx109.ger.corp.intel.com>
References: <20181016133716.17842-1-tomas.winkler@intel.com>
 <alpine.DEB.2.21.1810180309430.5022@jsakkine-mobl1>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9F5512@hasmsx109.ger.corp.intel.com>
 <alpine.DEB.2.21.1810200230200.9963@jsakkine-mobl1>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9F85F5@hasmsx109.ger.corp.intel.com>
 <alpine.DEB.2.21.1810231618280.19836@jsakkine-mobl1>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9FB5D1@hasmsx109.ger.corp.intel.com>
 <alpine.DEB.2.21.1810241150580.3525@jsakkine-mobl1>
In-Reply-To: <alpine.DEB.2.21.1810241150580.3525@jsakkine-mobl1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmVhNzdkOTgtMTRiMi00NzhmLTkxMzQtMWQwNDU5M2E5ODY2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWGFKUkV5eEtQNlVhYXdXczQxaFQ3SkVTZjA1K1E4UkMrYXh3bXUzbjRqU0M0S0szcWRPMjNvSEVUaURcLzdGMWIifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.252.19.114]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, 23 Oct 2018, Winkler, Tomas wrote:
> > To  the  out  label we jump after we are  done with locality and cmd
> > read() before we jump to locality 'locality'.  We will need to add
> > another variable to check If cmd_ready() was called or not in order to
> > get rid of the extran label, it's not internally tracked so far.
> 
> I think this is fine.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> I tested this by assigning rc error code instead of requesting locality in
> addition of testig unchanged code.
> 
Great
Thanks
Tomas 
