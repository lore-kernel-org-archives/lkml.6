Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E991FC4161B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE0F20671
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE0F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbeKSXlh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:41:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:48839 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbeKSXlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:41:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 05:18:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="97429762"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2018 05:18:00 -0800
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 19 Nov 2018 05:18:00 -0800
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 19 Nov 2018 05:18:00 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.165]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.194]) with mapi id 14.03.0415.000;
 Mon, 19 Nov 2018 15:17:57 +0200
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
Subject: RE: [PATCH v9 16/17] tpm: take TPM chip power gating out of
 tpm_transmit()
Thread-Topic: [PATCH v9 16/17] tpm: take TPM chip power gating out of
 tpm_transmit()
Thread-Index: AQHUfz1kjDc6O/MrFEGwY/E2owDDkKVWI+9QgADIXQCAAChmIA==
Date:   Mon, 19 Nov 2018 13:17:56 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA230D9@hasmsx108.ger.corp.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <20181118124753.18613-17-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA225B9@hasmsx108.ger.corp.intel.com>
 <20181119124822.GB8755@linux.intel.com>
In-Reply-To: <20181119124822.GB8755@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWIyNDVmOTctMTQ0Mi00NWFhLTgxOTYtYmY5Njk3NTQ2MDQxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNXVSQ09yUndMUUlya3J2SFBCT1p2RGJ1UEhZT3luWE9MUDJyc08xbmJSd1pjNGV1T2tQVGZDOVpcL0tCQmhETDUifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Sun, Nov 18, 2018 at 10:52:46PM +0000, Winkler, Tomas wrote:
> > This is still NACK from my side
> 
> Last time you spoke about tboot intervention but I don't see why as even
> sending a single command is not atomic in the true sense of the word i.e. if
> there was a problem that would already affect the existing code and would
> essentially mean that tboot itself is broken.
So I've consulted the issue, I wasn't not correct in the description. Tboot cannot acquire  the locality, unless the host driver relinquish it,
so the issue is opposite, driver is expected to relinquish the locality for tboot to work correctly. This is current status, other behavior will need a different implementation on both sides. 

Hopes that clears the question.

Thanks

