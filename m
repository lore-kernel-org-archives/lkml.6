Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8ADC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B0120663
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gEn7FGoO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Dgo2WQxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B0120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeK1GV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:21:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42956 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbeK1GV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:21:56 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARJHk5t015378;
        Tue, 27 Nov 2018 11:22:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pSgeUBszt/3t5ANmyYiA4EnWrduMyf6qUicd9qtQtiY=;
 b=gEn7FGoOZSUJsKec8EG3LiDLg00t+c0lt4cGCreH852BCF0QMkqYTgDNY51pE++OWwX3
 Wf+uQy/7zwHUDOaKTlHNJ1P7h8rLlvafQo3ikq9tgYRQ2AUKjngMkKTjFC+AY65svDiM
 3UD2v2MOqneuoEY5c7Grxz/A5OvzCpiB91s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p1ad80cma-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Nov 2018 11:22:26 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 27 Nov 2018 11:22:01 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 27 Nov 2018 11:22:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSgeUBszt/3t5ANmyYiA4EnWrduMyf6qUicd9qtQtiY=;
 b=Dgo2WQxJg8v1WqtY+biXwZQ8Cqo24BMEQQBOYnYVlX2IFPxL2Z8mjmqR55nVXbyx7zzKbGsTlFrZdYRR2adi1pa2S2cHZHDY81X4JjhEm8MD4G1ZzYYArivj46YslERTzvHE8P+MTVpfAaW5RZPiClcTp0aqBbOo7npL1piZRLs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1517.namprd15.prod.outlook.com (10.173.235.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Tue, 27 Nov 2018 19:21:41 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c%3]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 19:21:41 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH perf,bpf 0/5] reveal invisible bpf programs
Thread-Topic: [PATCH perf,bpf 0/5] reveal invisible bpf programs
Thread-Index: AQHUgdQ11TRJMN8CIkSD/uQZUfyfEaVbiN6AgACRn4CABhB7AIAACnEAgAHTxwA=
Date:   Tue, 27 Nov 2018 19:21:41 +0000
Message-ID: <E268FE5F-E2CE-4266-8B1F-A134BFAC6462@fb.com>
References: <20181121195502.3259930-1-songliubraving@fb.com>
 <20181122093219.GK2131@hirez.programming.kicks-ass.net>
 <71189F83-A09F-4A03-95EC-694D37FD7675@fb.com>
 <20181126145004.GO2113@hirez.programming.kicks-ass.net>
 <20181126152726.GA5518@kernel.org>
In-Reply-To: <20181126152726.GA5518@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::6:8f0c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1517;20:aPMlJq5eFNkVPdThXc1mNgNnIi+Oi6AhAEpPiNH30q5yilgotdm96xRQ6Q2iWhM6cDLEbT7g3gxYyOHBrw8/mFdaIDuFTR3GrxmtHiX3FmeSuDA0iVEx9cLgTDkplYHKZIHQGeNBPuDG+XA4N1SU84Jb5rC88qi6xRppXU9iz8w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1ecf11a9-6dfc-43fb-a0a8-08d6549d8f97
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1517;
x-ms-traffictypediagnostic: MWHPR15MB1517:
x-microsoft-antispam-prvs: <MWHPR15MB15177507C6C79803F0ECC567B3D00@MWHPR15MB1517.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(3002001)(10201501046)(3231443)(11241501185)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1517;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1517;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(376002)(366004)(136003)(189003)(199004)(229853002)(53936002)(476003)(6246003)(305945005)(2616005)(11346002)(7736002)(14454004)(4326008)(6506007)(6512007)(6916009)(71190400001)(50226002)(83716004)(316002)(25786009)(186003)(82746002)(54906003)(71200400001)(446003)(486006)(6116002)(57306001)(33656002)(97736004)(5660300001)(256004)(106356001)(105586002)(46003)(6436002)(2906002)(478600001)(99286004)(36756003)(8676002)(53546011)(93886005)(81156014)(81166006)(102836004)(76176011)(86362001)(8936002)(6486002)(68736007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1517;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1Pf7gCq1diobxnLNI4tDGcthkvxapcSbxMnO7gDZQSzme5T7PyXvlz+gKo4r24r4ASm+2H8XJ10tUoV4jGO/RCPf8LqlzzvTHZ2yS6IQy23FqgNFpDChXkqus8s8VVAG7zEEdwd0fhY4b5MsQNLr7pq+9d82WD7l15JIDy91JtmuM5wjkAW+J2Ux3T/3r2EKDZsupZ7YEbdqgjCBO1PNg9pS0KCbXwdMmzdLs0HFKQOOPegARHvHsGoZ2hu8Qb5v/dA6Z7FsRWN6bt6Lzkd3/tYduv+Yd0gEYFmoNeSSiDAKI+mCDyUxPYAv7LfbqZk/8nS/26RowB/zlmgC18PRaUCcTG9liLuL/qL30BGSgbU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B969F263CF47A04DB154821CF196699F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecf11a9-6dfc-43fb-a0a8-08d6549d8f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 19:21:41.3931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1517
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 26, 2018, at 7:27 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Mon, Nov 26, 2018 at 03:50:04PM +0100, Peter Zijlstra escreveu:
>> Now, I'm not saying this patch set is useless; but I'm saying most
>> people should not need this, and it is massive overkill for the needs of
>> most people.
>=20
> So, the comparision is sort of with kernel modules, that can come and go
> while you're profiling/tracing, if that happens, then samples, in post
> processing, are not resolvable, and that is the case for kernel modules
> right now. Sure, you're right, that doesn't happen so frequently, so
> nobody hollered (thankfully that is now verbotten ;-)) at us so far.
>=20
> You need to have the load-kernel-bin/unload-kernel-bin events recorded,
> and you need to somehow match those addresses to some symtab/src(for
> people that want to have src mixed up with assembly) and you need that
> jitted code, with timestamps of when it was loaded and it was unloaded.
>=20
> People doing post processing analysis of weird problems need all those
> details.
>=20
> Now I don't know how frequently those binary blobs gets loaded/unloaded
> in the brave new world of eBPF, but for completeness sake, we need those
> load/unload events and we need to grab a copy of the raw jitted binary,
> etc.

BPF programs get loaded/unloaded more often than kernel modules. This is=20
because BPF verifier makes sure BPF program will never crash the kernel,=20
thus BPF programs could often be debugged as user space apps.=20

Typical debug/tune process is like:

    perf record -- ./test_work
    perf report

    # make changes to bpf program and repeat

or even:

    perf record -o perf_1.data -- ./test_v1
    perf record -o perf_2.data -- ./test_v2
    perf record -o perf_3.data -- ./test_v3

    # perf report in 3 terminals, and compare the output

In such use cases, including all details in the perf.data is very helpful,=
=20
as /proc/kcore doesn't have details of the program when perf-report runs.=20

Thanks,
Song=
