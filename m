Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0783F20666
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gTg1ynXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0783F20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeI0Kqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:46:55 -0400
Received: from mail-eopbgr680106.outbound.protection.outlook.com ([40.107.68.106]:47232
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbeI0Kqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu3LQ58jZ5EJLhau6G9rDendd+mjjFaFwWIjESUMC4w=;
 b=gTg1ynXmZepJ+IbdyY2JD45+sD4D9ENsF978Jxek1IW3bkIVUAqhzl191mIgioP3Hxsh0Vyn+CscU5l9VHqut7myQbozNoz/gagz5apC+PZorwHd31zR4Qu6OXfQEfyAhbv/r5W7DqBbeaz/bPwRNHGmumpQw+JkRuoBLUR6KLw=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 04:16:30 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 04:16:30 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: RE: [PATCH V3 10/13] x86/hyper-v: Add HvFlushGuestAddressList
 hypercall support
Thread-Topic: [PATCH V3 10/13] x86/hyper-v: Add HvFlushGuestAddressList
 hypercall support
Thread-Index: AQHUVhUk41lXs6hh/02CKUlcu7halqUDhRdA
Date:   Thu, 27 Sep 2018 04:16:30 +0000
Message-ID: <CY4PR21MB0773A8B3292FA78711E580E7DC140@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
 <20180927034829.2230-11-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180927034829.2230-11-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-27T04:16:28.4214914Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [8.25.222.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:s8lsQGJjfsbSa8GNy+19qNHBF3v+i9zDnBz1hV16DLGH2xCroiDQOKlPeflHYOc8472iOjRpUp9brfU7XQ8X1eQMiWwiTsq/lJ453FMGe0Un+cmzSKT1e5Gsc9yai1JEfcOC/YFglW7r1SYBY9pwwyRT6dCCJolU3pai65Bn21TSXA9rimjPUMfTB0iQsEr9ldOh5sZE5dhE9DyMAzgqsmspBkpVLCM3L8eHD53SP6R3qMsLpnKoBWRmF15x+QEaIHjCf1wnRHRGaQuHhO+sSTsNHgpzbNRMd36DzY4luuYqJ+oMCAXamppTeGvUEk3xCPADj0OTlgxy8DY1oOIjTILUxByisPmfcW4cQRbzMFTR1Ri67k8v1UoCaVTArb5RLBN7cHOa1or8fJeV5gWGDWXwUJn55rp4LFcqf3v59D8uQwNwEqPROEOh4VeXO/IIGifeBq6d2lGocKSuqhPqIw==;5:WzKshmR2Pqfu7hJDLie7L7qZ5UaASA/MDIsfCDQoQc+S8wrTOt1ROqG04NRxSTF+hMsWfwmcQqI1yRE6uIamfgB9PQm0LY5yfRRNoWVsG4XW/r2v8FElDpLtyfW1jOVqa4VluWNYbdbbXBefGtGUxAHRVeWWX9mAsbo9R4ZFSnA=;7:qeiVtx0lQn8qEbxZxwQAAYWnKaBDRKLEK+AOnrJT/jmlIhuuV+yldElKCCwDRG/MAKAiE4Eltu441Ai3Y17O2+c6vzpksDWBJlOWjvZwaLTKogKgB2iSi5g0loYba/5a8TLtK5hnrKEqsI6vtOjMNeaJyILngxF6uo9RVgpq7A7szS6y0PSh9AbDOXqGvDL2i9TnO5aXztD3IXYXDuzMqJd75JY+cZbaNj405ECTW7PGUCpBFgVTi75HFfamM97k
x-ms-office365-filtering-correlation-id: 32b36e42-149a-4abc-1a88-08d624300095
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB028007E5BC987A5482E90BBDDC140@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(34290500001)(2906002)(8936002)(74316002)(71190400001)(6436002)(71200400001)(86362001)(9686003)(72206003)(5250100002)(7696005)(99286004)(6116002)(229853002)(6246003)(97736004)(6636002)(53936002)(86612001)(256004)(3846002)(5660300001)(476003)(25786009)(11346002)(106356001)(14454004)(55016002)(4326008)(6506007)(10090500001)(6862004)(486006)(107886003)(76176011)(8990500004)(22452003)(305945005)(7736002)(558084003)(316002)(81156014)(54906003)(81166006)(8676002)(1511001)(68736007)(6346003)(33656002)(446003)(105586002)(10290500003)(66066001)(7416002)(102836004)(2900100001)(26005)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: uChON9OtBChD48dRjz4lD8jwmZktvYLikBGnah9w8+4ieVKCnhNqNgvmEYZUMY1FC9nNcMcAh5PM+sDmBHqodnx2mu8kaSvwMHcq2wGEdkl1lwqFSkXGq+LS8Py4dKGwcR7wqJNWtmG0QN5ZimWVapSDL/daglNmA9S7U8pL7WK8tJlZyygNWqAqs+9yd210GAzgkZ+yqELsiHn5ssl5/mjIjYa21lm4a9fZS8TbnWnYaLzDugTezeQO0EV5i4J2hqbcVbNLbGmSEJqLSZTOa5PWQrLEK+rACK9fV1q1HtGM79+cdpt6sHt7j3hQTReGIrDDX5nMCOaNFHEGJBwVrVzOzv6PE3KNBa30+hr/5dM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b36e42-149a-4abc-1a88-08d624300095
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 04:16:30.3873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan  Sent: Wednesday, September 26, 2018 8:50 PM
>=20
> Hyper-V provides HvFlushGuestAddressList() hypercall to flush EPT tlb
> with specified ranges. This patch is to add the hypercall support.
>=20
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
>

Looks good!

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
