Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0AFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0BF20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q+ALUkEH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="I+WpMsmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0BF20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbeKJEcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:32:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60688 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727961AbeKJEcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:32:31 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA9Inw40026794;
        Fri, 9 Nov 2018 10:50:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nUQrwEES7R1rPngtH5jxxI1USEeQr6ygVZtXxaz8tFE=;
 b=Q+ALUkEHWW49MUl4DEEqWxwWw7AN9KCCipvLOAHA5Cp43Vu50j4v5fpojxYQvHqauLAl
 JYTg6+Z5Ya+eSl8EBzemDO42hHf1O8zRb0aTeDvOA99H+HNY6PdDmJlRy8xcfD9Nw34p
 MwhZN2CVVVKYvjTlTP5Gt3d7KNjvwC0M5p4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2nn7c2hpt3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 09 Nov 2018 10:50:03 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 9 Nov 2018 10:49:32 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 9 Nov 2018 10:49:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUQrwEES7R1rPngtH5jxxI1USEeQr6ygVZtXxaz8tFE=;
 b=I+WpMsmY8woC0gSQHYQ9i55KtA4o2JtyCRPNfDNlz54WDo5c9uP/1c1zXmxx4NdPsrbfsi/e8baxmAfADeFw0SjXKsxUE+yWpdr1JnH2W5shudzwRhHv6ds5y+kI03UC7m0jSquXZLNjBGcZsOjb6NPJA1miktmUr3ntwLB+qec=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1199.namprd15.prod.outlook.com (10.175.2.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 18:49:27 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b%2]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 18:49:27 +0000
From:   Song Liu <songliubraving@fb.com>
To:     David Ahern <dsahern@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Thread-Topic: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Thread-Index: AQHUdhLRNu0EDS9AC0KZ+9MuHYh4daVD/w6AgACjMoCAAVksAIAAM3wAgAAF/wCAAAZ1AIABdg+AgAAcTwA=
Date:   Fri, 9 Nov 2018 18:49:27 +0000
Message-ID: <74246BC0-EA66-407E-93E6-0D6E8645F486@fb.com>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-2-songliubraving@fb.com>
 <20181107084057.GG9781@hirez.programming.kicks-ass.net>
 <31067290-4B66-4AA1-8027-607397BC0264@fb.com>
 <20181108150028.GU9761@hirez.programming.kicks-ass.net>
 <C858C862-E523-4CE8-AB39-CC9B27BE2538@fb.com>
 <d5043aae-69b0-fd49-e82a-5a13834a3f32@gmail.com>
 <050ABAC6-6C3B-4B6B-BB68-727127E00B51@fb.com>
 <37d2c7a8-fe99-94bd-9b8f-24e9ca9fa39c@gmail.com>
In-Reply-To: <37d2c7a8-fe99-94bd-9b8f-24e9ca9fa39c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::6:5221]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1199;20:BkzLk9BzOkCYX3w+36sBliZQCniQprM/xMT5mbX+eTXZk2Ye+YHKhDPLLFAAk1VXL0OAEMoqMXy3966xgqafA+z7lmQ0WWc07SBbkMLKnu8s4Nv1kVFv/EkdYbU/FFKMiV/QwGRReqQ+AqJ8cMj2HBko4B+4/QLt1Q1MpdtTFKo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2a55843f-b7b3-4912-17f3-08d64674139a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1199;
x-ms-traffictypediagnostic: MWHPR15MB1199:
x-microsoft-antispam-prvs: <MWHPR15MB1199839ABC6C04D3E37AE399B3C60@MWHPR15MB1199.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1199;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1199;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(366004)(136003)(376002)(199004)(189003)(93886005)(229853002)(14454004)(97736004)(57306001)(6116002)(6486002)(54906003)(478600001)(50226002)(8936002)(305945005)(25786009)(83716004)(7736002)(71200400001)(2906002)(106356001)(71190400001)(1411001)(36756003)(316002)(14444005)(2900100001)(81166006)(81156014)(256004)(6916009)(68736007)(105586002)(8676002)(99286004)(82746002)(76176011)(86362001)(486006)(6436002)(6246003)(6512007)(4326008)(11346002)(186003)(5660300001)(39060400002)(33656002)(46003)(6506007)(53936002)(2616005)(102836004)(446003)(53546011)(476003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1199;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cOQB4BiYlCr59rZUgTcnie/ZKbyjrFllUa8azb4VdOyklFKKD7rT/wz5wcqYgv6PmewCwu/h3S7iiRhGdtEQO0HNRcnybK6ZX9Rx20Rpk1MIJIb1CtawBGah//XZyDX7r5O7jz4pn+oMShhO4d2hDwml9HMmj7v0/mcRBveQDgm1tPqxoPAq3L4tkgEi56ulrlPgUka9MxhRHUyK7YMMRQs41xpRZ7SEKvt5AbVkt5Ux3xqmJxC0Adz7o/rUh8NyVpyUlpv7DK57hcnJ3coiHdQmrocuz6s/3phO0GBHJOjrFivuF77aYU5DigiG6GlIGX2J7REeHQUhl8WXyo/wkcleD8uIlE5z+WI0jPZ+ndI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <970D132C03C0654D874540EEB6B1A0E9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a55843f-b7b3-4912-17f3-08d64674139a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 18:49:27.7389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1199
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-09_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 9:08 AM, David Ahern <dsahern@gmail.com> wrote:
>=20
> On 11/8/18 11:49 AM, Song Liu wrote:
>> Could you please point me to more information about the use cases you wo=
rry=20
>> about? I am more than happy to optimize the logic for those use cases.=20
>=20
> bpf load and unload as just another tracepoint to throw into a set of
> events that are monitored. As mentioned before auditing the loads and
> unloads is one example.

For the tracepoint approach, we need similar synchronous logic in perf to=20
process BPF load/unload events. If we agree this is the right direction,=20
I will modify the set with tracepoints.=20

>=20
> And that brings up another comment: Why are you adding a PERF_RECORD_*
> rather than a tracepoint? From what I can see the PERF_RECORD_BPF_EVENT
> definition does not include the who is loading / unloading a bpf
> program. That is important information as well.

bpf_prog_info has "__u32 created_by_uid;" in it, so it is not really needed
in current version.=20

Thanks,
Song=
