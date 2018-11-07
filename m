Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AFAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7786120827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ONaH8rhF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VybPph2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7786120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeKHEAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:00:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39876 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbeKHEAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:00:48 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7IO4Fm028365;
        Wed, 7 Nov 2018 10:28:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wd1OZDM1NupPVezRnGXGxm8uzgJ0CTro6nj3IawCnPQ=;
 b=ONaH8rhFnyj6Wypx6TNcUtXCgBvax01b4zMGYj6pphpy00HVKaFy+pSlblSKJ84n5FHw
 Mm/HGeOWx4dbkCBrOOtR6qotLxCL1Mj78tGAmc58vi9BML0gKwGBLtW7bB8KoIDr4Y9P
 cgK3m2XipIAy71gj9+cwXAa0RAjv7S5l1SE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nm4m985rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Nov 2018 10:28:37 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 7 Nov 2018 10:28:35 -0800
Received: from PRN-CHUB05.TheFacebook.com (2620:10d:c081:35::14) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Wed, 7 Nov 2018 10:28:35 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 7 Nov 2018 10:28:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd1OZDM1NupPVezRnGXGxm8uzgJ0CTro6nj3IawCnPQ=;
 b=VybPph2OU8+AwFp4xMeyXifjAZnWtI4B4NRfWlGXlzm1LD6EnJs9hkFbUoqHPi2m1+Jaxv71y6is4caVQzaUP4d5ng8pI65FZ/pHZ+Z+hNTfkqcMFmF4BcHsI4JhF0yJznTOqUyl6HiX2EWhRrSgGWyv59lxbW61Ibo2lfFnkP0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1166.namprd15.prod.outlook.com (10.175.2.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Wed, 7 Nov 2018 18:28:33 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 18:28:33 +0000
From:   Song Liu <songliubraving@fb.com>
To:     David Ahern <dsahern@gmail.com>
CC:     Alexei Starovoitov <ast@fb.com>,
        David Miller <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Topic: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Index: AQHUdhL1KSxo541SK0a40CXb4K6c4qVDSleAgAAXYgCAAAMngIAAAiSAgAAKYQCAAAKngIAAAMsAgAAFBICAAAcOAIABHeeAgAAEaQA=
Date:   Wed, 7 Nov 2018 18:28:33 +0000
Message-ID: <8BBFB3CA-C33A-4662-ACD0-BC9CF30CC6CE@fb.com>
References: <b984776a-ce69-ab16-ed87-1cea89c9d79a@gmail.com>
 <6C5A9FBD-F50D-444C-9038-E9557EC850D2@fb.com>
 <27fc8327-3390-ba5a-6063-89c9e7165e7b@fb.com>
 <20181106.153647.1701013551426767213.davem@davemloft.net>
 <39fe6abc-5c3e-bac3-0c0b-cf68bea23ab0@fb.com>
 <0a05a14c-3a79-e894-ae48-cbe1df4feb91@gmail.com>
 <82745121-339e-2751-c9db-d1fca02d0b33@fb.com>
 <7d0b100b-a64b-0d30-8ec0-2689ef44423d@gmail.com>
 <edda462f-a32c-bc25-94c8-8d06a47bd480@fb.com>
 <c1355a46-77b7-f340-855e-6237b223e43a@gmail.com>
In-Reply-To: <c1355a46-77b7-f340-855e-6237b223e43a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::5:11dd]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1166;20:7Z6Ipl/5RuXsljO2S5kI/OOiOoCkjctgfq2TDXyiCVhXLCNtnr+TLkZn/3v7MTIX415UXqbkPbQ7wOPkiirIJawvKYltQpSqCKlGXqAwA61b8wy/NqZ7ixIJEWj3w3TSpXHecm4DdKyiQOCLUrxPZJh4LdHHoWS7wMLcXQ2ofWI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 810c258f-c125-41a3-5f0b-08d644ded324
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1166;
x-ms-traffictypediagnostic: MWHPR15MB1166:
x-microsoft-antispam-prvs: <MWHPR15MB1166174AC3CD312B13847BB0B3C40@MWHPR15MB1166.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1166;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1166;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(83716004)(478600001)(97736004)(256004)(68736007)(102836004)(186003)(2906002)(86362001)(8676002)(6506007)(50226002)(53546011)(2900100001)(82746002)(81156014)(81166006)(6436002)(71200400001)(6116002)(36756003)(7736002)(8936002)(76176011)(25786009)(71190400001)(5660300001)(305945005)(53936002)(33656002)(46003)(54906003)(446003)(2616005)(229853002)(39060400002)(6246003)(6512007)(99286004)(93886005)(11346002)(476003)(57306001)(106356001)(14454004)(6486002)(316002)(105586002)(486006)(1411001)(6916009)(4326008)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1166;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OF5BZuHNgILHIwTgd6x9sr93C3QBG8y0rLlKom8lko9Y9alZNtX4N6fmzGd+N5DD0Z+U3D0aw6r3EyBaBENBNnTE/4dvBvWS+O6t/tSJS2PgFaubrkFRzUt5JcNJ67KoiNzdGVAjeDfmTAVsGRbVHChqJkRAAjWraEpvSve9W+tkSF96mwMt3uFaGCTz1OPcPWlKqZOqwpkVnWpq5iPEuaVXil/EH2MBXHNKsW2ck3qrntu40YQDkxFqbpFxb1kooV86w+Io7Prk73yv4oHeTIBMbPuD7COIJwSFY2UoGBT1pEPrtwhDQS+z1R2/hl6vBrdf7OZGHWoh55wJEfAOm0/IwqozIm/3kZf03gUFqr4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19EB51302A151842ADF15CF5052B991D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 810c258f-c125-41a3-5f0b-08d644ded324
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 18:28:33.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 7, 2018, at 10:12 AM, David Ahern <dsahern@gmail.com> wrote:
>=20
> On 11/6/18 6:09 PM, Alexei Starovoitov wrote:
>> On 11/6/18 4:44 PM, David Ahern wrote:
>>>=20
>>> So one use case is profiling bpf programs. I was also considering the
>>> auditing discussion from some weeks ago which I thought the events are
>>> also targeting.
>>=20
>> yes. there should be separate mode for 're: audit discussion' where
>> only bpf events are collected. This patch set doesn't add that to
>> perf user space side.
>> The kernel side is common though. It can be used for bpf load/unload
>> only and for different use case in this set. Which is making
>> bpf program appear in normal 'perf report'.
>=20
> It would be good for perf-script to work in the next version. Users
> should be able to dump the event from the kernel and the synthesized
> events. Should be trivial to add and allows a review of both
> perspectives -- profiling and monitoring events.

Yes, we do plan to include these information in other perf commands,=20
including perf-script, perf-top, perf-annotate, etc.=20

Thanks,
Song
