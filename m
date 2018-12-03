Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCC6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 01:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7953D20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 01:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F/3rd2RU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7953D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbeLCBro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 20:47:44 -0500
Received: from mail-eopbgr700107.outbound.protection.outlook.com ([40.107.70.107]:23739
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbeLCBrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 20:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvlQfZFfL3yq+iMOb5JchyPIYb16v3RAsqRex1OmtWM=;
 b=F/3rd2RUVg3oP1ZKq019qHtZ+J6AUcCe0zriEjKv3ubKVVtZ2C+V8gCyaa/nG2v4cAuoORp5jCt6AQJLqux4zRixbfh5XWnhZrUwhwyp5o3OAjkiBBCmtOe7c221H+t+ERQovTnpEgfZ5U03pFM30MtsJIDmYvOuBtQwvK06T7A=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.2; Mon, 3 Dec 2018 01:47:39 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c%2]) with mapi id 15.20.1425.000; Mon, 3 Dec 2018
 01:47:39 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Will Deacon <will.deacon@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Thread-Topic: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Thread-Index: AQHUghEmRPt7Kjul9E+Q8Cz+6wluT6VidjKAgAAFstCAAAR8gIAAAInQgACtqgCAAEKKgIAI3aXQ
Date:   Mon, 3 Dec 2018 01:47:39 +0000
Message-ID: <CY4PR21MB077319B5C65A6959D9F4DE86D7AE0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-3-kys@linuxonhyperv.com>
 <20181126192101.GC32208@kroah.com>
 <CY4PR21MB07735AB610D4BFD3EB7556D5D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <20181126195727.GA9957@kroah.com>
 <CY4PR21MB0773AFA3555BC08A4CC129D4D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <20181127062056.GA30285@kroah.com> <20181127101904.GA2928@arm.com>
In-Reply-To: <20181127101904.GA2928@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-03T01:47:37.2184399Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:0E9jyANV6Y8kyhtDX8lAv7LnrmXZMnXe0w/hy8E0fAYna0FtvMwUUqVfgsIiR+sQIXM3vSV3xPjBS/AEL0P3jHlQjMJjNwYQNO0WborPyewRTZ3tE5FpVhEYf7fLIP4RZz3WSmdVIy5CDrC9nr5El0YrsBsgneayowbRZoQILWya+BG70mGNO56ABt672vg5amo57ra839oPAc6/ChjaQF+KEtVvnlrWw/istz/QKcvktOFzBRmd9zehDzVb3Zmnz/66TFXwBtDR/CeYYwrVDHvvGHOptcMLPq7EZ00Udurc7lPLvxmlybkPqaxmSELHJ7zx2aHbn58C5lRR7W6mfSKP1aF+tBatGMEioYGSc6/gt7oRiRfyFsXmfahpzvlZ/2RWOtCohqlWzWcf5uQYYAi4dHSKPZg8eVFrYFGGbI+fZaRdzou8eja5F/bf80EveT0tr5vxsjVMTU8Km6/CDg==;5:n5+S5YF9VzEJdyxBIfiiqo885iLzVv+ek3RyEe3vcTjuZP7P80YElFDhBNfj/sEC7hB2U74kb1YGTtYvk+j27CX6fh+QEJcrTU37fD3Su6GeI3dQY7TT2uPitdTrISthH0hVt1RjF6l/aI7a2MGGMlh5SmtIMuYXglws2FO4Crc=;7:B2/05MKupH6QxwdWy8xje/2qE3T6jcrFeX4RXrDpzm7oBXVTwj7G0j50WmSAwFqLIMMq2vWCanONIW5yyMmiBk3NEqHWhOeLLDkzNVp/d39lgFeFoDkG2UTWVsQOlWzxbkEy102yNOn928jTAkoZNg==
x-ms-office365-filtering-correlation-id: 561051f2-aad7-4a43-6c5e-08d658c14efd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB07735D130B63F4E89507B837D7AE0@CY4PR21MB0773.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3231455)(999002)(944501493)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(8936002)(105586002)(14444005)(74316002)(446003)(7736002)(66066001)(486006)(11346002)(476003)(229853002)(106356001)(86362001)(9686003)(316002)(22452003)(93886005)(86612001)(10090500001)(6436002)(25786009)(186003)(8990500004)(68736007)(26005)(110136005)(54906003)(7696005)(76176011)(99286004)(6116002)(3846002)(97736004)(53936002)(6506007)(10290500003)(6246003)(478600001)(102836004)(33656002)(71190400001)(256004)(8676002)(71200400001)(7416002)(305945005)(55016002)(81156014)(14454004)(81166006)(2906002)(5660300001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f5pqtLkZNB5Pru5OItr3Zh4SCKNCr+sa1Z6oaWP9c6VHktIovoDCzYPwHcQG/VUWwOfXWksLJ30FI1VB+q2JeBD8iYKvB88xRZnRNgbUCypQtiHYD0n0WJ+nYwMixZHLIBPMFZyDI/J9GcQde8uzNUTzLF+7/Pnr/qXhSj8u/ppbirj3L7FZ4l8Mab3WNDWdOt6HJevavKMQEpWEkj5dlU/ccF75iYpK6GIzOJij/AniUGnvPKer0w0KL5fb5BlSk2PnWeQJIHyNh5JCW1VlGRPoeRJLCd5TrpuRkgwWqODkSlN9ryBeMW9iInmGFo0VQiZZ39FAY0vQ1fV+f5qelKEHs3HtOZHxFF7K97Mhmys=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561051f2-aad7-4a43-6c5e-08d658c14efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 01:47:39.5566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>  Sent: Tuesday, November 27, 2018 2=
:19 AM

> > > The general approach is for patches 1 and 2 of the series to provide
> > > all the new code under arch/arm64 to enable Hyper-V.  But the code
> > > won't get called (or even built) with just these two patches because
> > > CONFIG_HYPERV can't be selected.  Patch 3 is separate because it
> > > applies to architecture independent code and arch/x86 code -- I thoug=
ht
> > > there might be value in keeping the ARM64 and x86 patches distinct.
> > > Patch 4 applies to architecture independent code, and enables the
> > > ARM64 code in patches 1 and 2 to be compiled and run when
> > > CONFIG_HYPERV is selected.
> > >
> > > If combining some of the patches in the series is a better approach, =
I'm
> > > good with that.
> >
> > Ok, that makes more sense, if it is easier to get the ARM people to
> > review this, that's fine.  Doesn't seem like anyone did that yet :(
>=20
> It's on the list, but thanks for having a look as well!
>=20
> Will

Will -- I'll hold off on sending a new version, pending comments from
the ARM64 maintainers.  Let me know if you prefer that I do otherwise.

Michael
