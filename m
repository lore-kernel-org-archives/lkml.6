Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4233DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F28208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dyuukw6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F28208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbeGJTln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:41:43 -0400
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:32224
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732332AbeGJTln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHXCw6pL6PJBaXNatbO9FuO4zI3YxJkjnjkaUeDZtRg=;
 b=dyuukw6/K5baxk8TKuFyIxva2TQT/dHnGbsyGlapVfq79OMz1eTQwLoLrEkCzq6hSOekD6BQGXfZCBbPO/S87WeuG9CtMjHDY1rjMb21fp2T8/5f2Az78yo+e6C2tkIdql8AZGoO022/0z4eVmvGV+Q7omMpdxUgXWHQYlXhn78=
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) by
 SN6PR2101MB0973.namprd21.prod.outlook.com (52.132.114.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.10; Tue, 10 Jul 2018 19:41:09 +0000
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732]) by SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732%4]) with mapi id 15.20.0952.017; Tue, 10 Jul 2018
 19:41:09 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/hyper-v: check for VP_INVAL in
 hyperv_flush_tlb_others()
Thread-Topic: [PATCH 2/2] x86/hyper-v: check for VP_INVAL in
 hyperv_flush_tlb_others()
Thread-Index: AQHUF6vplaCzQub/mU22elwWHEbh1aSI3EUA
Date:   Tue, 10 Jul 2018 19:41:09 +0000
Message-ID: <SN6PR2101MB1120936551C98B99231CB4E6DC5B0@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180709174012.17429-1-vkuznets@redhat.com>
 <20180709174012.17429-3-vkuznets@redhat.com>
In-Reply-To: <20180709174012.17429-3-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-10T19:41:08.2824929Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB0973;7:6p/WejU6JOvshrohEzLQf+e+AgT0obcCQ+UF7fz8Z8krJuc9UcZBeKB0tYAdOnvCuLzvDrla1iEu8Aw5fcjeoKBOdNGEBU65OvXJPvebwlsRPRJBKmt9vqktzoDktX7SW7o+hmmD3EgKVWMpt5fRX0IJShX8GWIvSepT0PLyGwbEBwXZTdKPTAfH/SlyLytPd/T5Czb8vSLyfpVEIQu2NaAS4tXy08NxiOgKyaPWOJvI2hog6pljtZNr8VYXa9aK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a26ebf96-92c8-46a4-d7bc-08d5e69d162d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB0973;
x-ms-traffictypediagnostic: SN6PR2101MB0973:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB09737B7FE405B984372BB506DC5B0@SN6PR2101MB0973.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(190756311086443)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB0973;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB0973;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(86612001)(446003)(256004)(55016002)(68736007)(26005)(110136005)(6436002)(86362001)(575784001)(54906003)(5660300001)(229853002)(2900100001)(74316002)(72206003)(476003)(6506007)(2906002)(14454004)(102836004)(9686003)(11346002)(486006)(186003)(7696005)(76176011)(6246003)(33656002)(25786009)(106356001)(5250100002)(97736004)(105586002)(316002)(305945005)(7736002)(22452003)(10290500003)(99286004)(10090500001)(478600001)(8990500004)(66066001)(4326008)(6116002)(81166006)(2501003)(53936002)(8936002)(8676002)(3846002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0973;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +DbTF2j6zP5lInO8a7JgN4SYIc9hAA832hTG3l5PTuLICGG3Ev0hbVPb2/233aGylAuBT2O8dWJESFtxFZKMt8oadGq2q6JLTldXsOlKDqDepL+CgfKszeIMY18sB7wNrxcHR6C6DdQ60OS6DboEoxr2fRiU4VdHTLcIccbnhmMFFFJArElKRIIo0S2ftSPafkkcFD6yIzTRHDcSGoXit7aW7OBwppbiMHr4F+mVu0btbIlff1ziBzmvvApgMg0pkBsSMgxQ1qqJcbAM7zvCPkSUXbjtn15kScgDJ7ZPhI/KzMiZpBXM6OjaI6syWuf7FfXEl2c6hxykCQkxCt6Tn/ckCcRmBN6YixCy7O1BG3A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26ebf96-92c8-46a4-d7bc-08d5e69d162d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 19:41:09.7318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>  Monday, July 9, 2018 10:40 AM
> Commit 1268ed0c474a ("x86/hyper-v: Fix the circular dependency in IPI
>  enlightenment") pre-filled hv_vp_index with VP_INVAL so it is now
> (theoretically) possible to observe hv_cpu_number_to_vp_number()
> returning VP_INVAL. We need to check for that in hyperv_flush_tlb_others(=
).
>=20
> Not checking for VP_INVAL on the first call site where we do
>=20
>  if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >=3D 64)
>                         goto do_ex_hypercall;
>=20
> is OK, in case we're eligible for non-ex hypercall we'll catch the
> issue later in for_each_cpu() cycle and in case we'll be doing ex-
> hypercall cpumask_to_vpset() will fail.
>=20
> It would be nice to change hv_cpu_number_to_vp_number() return
> value's type to 'u32' but this will likely be a bigger change as
> all call sites need to be checked first.
>=20
> Fixes: 1268ed0c474a ("x86/hyper-v: Fix the circular dependency in IPI enl=
ightenment")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/hyperv/mmu.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
