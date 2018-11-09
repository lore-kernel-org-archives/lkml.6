Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF93C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E138A20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E138A20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeKJHUR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:20:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:29687 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeKJHUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:20:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 13:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,484,1534834800"; 
   d="scan'208";a="107365449"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 09 Nov 2018 13:37:51 -0800
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 9 Nov 2018 13:37:51 -0800
Received: from hasmsx112.ger.corp.intel.com (10.184.198.40) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 9 Nov 2018 13:37:51 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.165]) by
 HASMSX112.ger.corp.intel.com ([169.254.11.97]) with mapi id 14.03.0415.000;
 Fri, 9 Nov 2018 23:37:48 +0200
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
Thread-Index: AQHUd238CNv13jYvhU+0nbO7Ml7SjKVGNDswgAAq4wCAAZjFgA==
Date:   Fri, 9 Nov 2018 21:37:48 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA190F4@hasmsx108.ger.corp.intel.com>
References: <20181108141541.12832-1-jarkko.sakkinen@linux.intel.com>
 <20181108141541.12832-17-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA18602@hasmsx108.ger.corp.intel.com>
 <20181108230700.GA8038@linux.intel.com>
In-Reply-To: <20181108230700.GA8038@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODY2ZmE1NjQtNTcyZC00NjIzLTgyMWMtY2RlNWRlYWQyOTg3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTlpOdjN0TFhjdjBQM3BVNHdJWDNoM3FrVUtnYTRTSEk5VFFTT3VcL2FydktBTU1yQWpOM2NsQnRWQlFPeENiRlIifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.255.203.64]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> On Thu, Nov 08, 2018 at 06:38:59PM +0000, Winkler, Tomas wrote:
> > > Call tpm_chip_start() and tpm_chip_stop() in
> > >
> > > * tpm_try_get_ops() and tpm_put_ops()
> > > * tpm_chip_register()
> > > * tpm2_del_space()
> > >
> > > And remove these calls from tpm_transmit(). The core reason for this
> > > change is that in tpm_vtpm_proxy a locality change requires a
> > > virtual TPM command (a command made up just for that driver).
> > >
> > I don't think you can do that,  locality has to be request for each
> > command, as  for example tboot can request higher locality any time.
> 
> That could be a potential problem. How tboot intervention gets prevented
> without this patch?
As it was said, need to request locality and relinquish it for each command, I believe thought this is not required for client platforms only for servers. 
> 
> > Same for cmd_ready()/go_idle() powergatin, you will prevent the whole
> > platform entering power save state.
> 
> Why would you want that in a middle of using the TPM anyway?
If I'm reading this patch correctly you do cmd_ready when tpm is opened, it doesn't mean there is a real traffic, so why to keep it awake. 
Thanks
Tomas

