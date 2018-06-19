Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB15C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F02C20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Srjm0XNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F02C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030397AbeFSR4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:56:55 -0400
Received: from mail-bn3nam01on0133.outbound.protection.outlook.com ([104.47.33.133]:27872
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030228AbeFSR4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq9L1XN7GhTXNM5/0nLrIpAuod752t7YwjaBDloXNpI=;
 b=Srjm0XNN67NEodYiW9Sj/jpmUQMtrmeAMjIQMpSLyc0iLoRxuvYvmquO5R6JXiDwdEn0j4jpgG+nV7wO853gm8dy3LQwim+4nPoswLoU6eWVZ9GC+WrQbIr/lc7P4K84cThkqkx1bvDj68Pa0kD54lfSNzl/HW0HBiozFHPQOT8=
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.3; Tue, 19 Jun 2018 17:56:51 +0000
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::6c1f:4f28:2e32:101e]) by SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::6c1f:4f28:2e32:101e%3]) with mapi id 15.20.0906.004; Tue, 19 Jun 2018
 17:56:51 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH] x86/hyper-v: use cheaper
 HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
Thread-Topic: [PATCH] x86/hyper-v: use cheaper
 HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
Thread-Index: AQHUBMYydHRhY0vPjEmpcPt1Qt9b2aRn0ylQ
Date:   Tue, 19 Jun 2018 17:56:51 +0000
Message-ID: <SN6PR2101MB11209236A3C18C7CA01F4061DC700@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180615163010.20381-1-vkuznets@redhat.com>
In-Reply-To: <20180615163010.20381-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-19T17:56:49.2148706Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1054;7:+Ruco8ymXTzExpdm0lblaQc+btVp5JTIr27oV555sS/QBbn7BrzQomipbFt/sOD8rgG/nQ0XM5xJX8/vHnRM+nA+TPkeEdWWTSqK4tCCP7dJk2nZEJjCU3ejxq6o4By5nT4J9lA/5+Hz1pRN9JWcgYUoXpIoAm8h5kCdWRmhv0bxsP0ablX8ei79v3UJyGVCTLxywpJlA8nh9bpiGQqlwgOMyYJdq+WzwtGTo80VoVtUBJ5KD3P+2cAbmohEGFjJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 18671824-f49d-4ba6-57e0-08d5d60e0915
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB1054335969BDA45732A42F27DC700@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1054;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1054;
x-forefront-prvs: 07083FF734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(13464003)(199004)(189003)(74316002)(7696005)(6436002)(102836004)(76176011)(55016002)(6506007)(53546011)(9686003)(86362001)(305945005)(26005)(186003)(486006)(446003)(8676002)(86612001)(81156014)(11346002)(476003)(81166006)(229853002)(2906002)(5250100002)(2900100001)(2501003)(8936002)(66066001)(7736002)(316002)(5660300001)(3280700002)(8990500004)(105586002)(478600001)(10290500003)(25786009)(3660700001)(97736004)(53936002)(99286004)(22452003)(10090500001)(107886003)(3846002)(4326008)(14454004)(72206003)(54906003)(110136005)(33656002)(6246003)(6116002)(68736007)(106356001)(12043001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cLTbM3J3R1fd7LCizNbIr45Fp6B+mvWUcJcpuHkzAaUVs/oWpxqo6P4UcgW/oOIbp9sz/BHKo0WXODW0Rw8Y2tR2lHWaxcTkNTTVklC2o4hiJdiRUC5n+QEMU3vgOOiJBAf0UZZlm0nsBQAuzsB/HiP4JbRylEGW1AEHFwTX5/MIdZJMN6eEnK/cNIiljvQyzSl+Ai5pkrl/mzVrJyM87pWAtE8dtQ9a33Q/qbkN0Mpk6aE9lvNyw2XKx5BtHjXkRkx4t1WgWYB05bvA4hXmnSMaiL30xDeX+Y+2jq8L8RVIb9m9rdO5t138hDytDRksuaBJM3huZSb9LMv6euVZIw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18671824-f49d-4ba6-57e0-08d5d60e0915
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 17:56:51.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf
> Of Vitaly Kuznetsov
> Sent: Friday, June 15, 2018 9:30 AM
> To: x86@kernel.org
> Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; KY Sriniv=
asan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemm=
inger
> <sthemmin@microsoft.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo Moln=
ar
> <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Tianyu Lan
> <Tianyu.Lan@microsoft.com>
> Subject: [PATCH] x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{L=
IST,SPACE}
> hypercalls when possible
>=20
> While working on Hyper-V style PV TLB flush support in KVM I noticed that
> real Windows guests use TLB flush hypercall in a somewhat smarter way: wh=
en
> the flush needs to be performed on a subset of first 64 vCPUs or on all
> present vCPUs Windows avoids more expensive hypercalls which support
> sparse CPU sets and uses their 'cheap' counterparts. This means that
> HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED name is actually a misnomer: EX
> hypercalls (which support sparse CPU sets) are "available", not
> "recommended". This makes sense as they are actually harder to parse.
>=20
> Nothing stops us from being equally 'smart' in Linux too. Switch to
> doing cheaper hypercalls whenever possible.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

This is a good idea.  We should probably do the same with the hypercalls fo=
r sending
IPIs -- try the simpler version first and move to the more complex _EX vers=
ion only
if necessary.

A complication:  We've recently found a problem with the code for doing IPI
hypercalls, and the bug affects the TLB flush code as well.  As secondary C=
PUs
are started, there's a window of time where the hv_vp_index entry for a
secondary CPU is uninitialized.  We are seeing IPIs happening in that windo=
w, and
the IPI hypercall code uses the uninitialized hv_vp_index entry.   Same thi=
ng could
happen with the TLB flush hypercall code.  I didn't actually see any occurr=
ences of
the TLB case in my tracing, but we should fix it anyway in case a TLB flush=
 gets
added at some point in the future.

KY has a patch coming.  In the patch, hv_cpu_number_to_vp_number()
and cpumask_to_vpset() can both return U32_MAX if they encounter an
uninitialized hv_vp_index entry, and the code needs to be able to bail out =
to
the native functions for that particular IPI or TLB flush operation.  Once =
the
initialization of secondary CPUs is complete, the uninitialized situation w=
on't
happen again, and the hypercall path will always be used.

We'll need to coordinate on these patches.  Be aware that the IPI flavor of=
 the
bug is currently causing random failures when booting 4.18 RC1 on Hyper-V V=
Ms
with large vCPU counts.

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
