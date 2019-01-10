Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAD8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4F1206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cJYf85YE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="k7miB/5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfAJTau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:30:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728572AbfAJTau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:30:50 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x0AJRr0b028593;
        Thu, 10 Jan 2019 11:30:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WSCok1Io1IC4ErUHEfo+foA4JH6ZNS1qLKu1JsDH9kM=;
 b=cJYf85YEv++uncu+Z02ilKqehcb5Rai3svez4zE08cGYTDgXElCfYE+oZCDiuDKP3+dE
 RV5So4HVlMAMwgKyohCvGmzdwZ84FEeanJsi8xZQejqbMmC3FIfD2xnhshrf7RM8P1nI
 Qz8jP+z5azegJ0fsiiMm+5rUY+mTBSzrUBc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2pxb7sg87y-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Jan 2019 11:30:26 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 10 Jan 2019 11:30:24 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 10 Jan 2019 11:30:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSCok1Io1IC4ErUHEfo+foA4JH6ZNS1qLKu1JsDH9kM=;
 b=k7miB/5V2CvRwEmySFRoF8iYcnUf/KMdW/rU3t0Wa3nSNmLekJtGmiSFim22to38aCIO9d+zAX5J6SxMMuJt1Q0l0qVUc1Bq9Zn5YM5yUoG1l8JzXGnKQbLDZTPF2RdlyXXoMpXWAvO/MOMhRJS8SkCbnOypv10XSgpbVU0RC4M=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1161.namprd15.prod.outlook.com (10.173.208.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Thu, 10 Jan 2019 19:30:22 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::1909:9d4c:715b:faa0]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::1909:9d4c:715b:faa0%5]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 19:30:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Topic: [PATCH v6 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Index: AQHUqFCaPbT+UGXQnkaaX1wm9KrpVKWo0rKAgAAEoACAAAQiAIAACcSA
Date:   Thu, 10 Jan 2019 19:30:22 +0000
Message-ID: <CCB26BF8-9FF5-4BBF-84BE-878CF0D3882A@fb.com>
References: <20190109192111.130995-1-songliubraving@fb.com>
 <20190109192111.130995-2-songliubraving@fb.com>
 <20190110182403.GN22483@kernel.org>
 <064FBBA4-A0D0-4335-BCE7-902724CE2988@fb.com>
 <20190110185524.GO22483@kernel.org>
In-Reply-To: <20190110185524.GO22483@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:3651]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1161;20:pkM3RHfpYgenymV0Tc19MiDShO3RRiYTMv0/RQjIxeI63oGyFm/5WqxT4us/vqPiDuvlVfdL3IYjN2tvp557vPkfWfH6OBY3EopiEsMSGEcGIgbZdhn3RH9MCuQuVbgfeRmSTSEeQUcVFQCTolnpW8y8W+jsZdEP8moPbYHei/c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 303a2e92-baa6-4224-2d4d-08d67732102f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1161;
x-ms-traffictypediagnostic: DM5PR15MB1161:
x-microsoft-antispam-prvs: <DM5PR15MB11611A0BE1D431D62790CEA6B3840@DM5PR15MB1161.namprd15.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(81166006)(81156014)(316002)(476003)(54906003)(478600001)(8676002)(97736004)(46003)(93886005)(106356001)(71190400001)(71200400001)(486006)(82746002)(83716004)(68736007)(229853002)(86362001)(6436002)(57306001)(186003)(11346002)(2616005)(446003)(6916009)(256004)(6486002)(5660300001)(6116002)(8936002)(102836004)(50226002)(76176011)(53546011)(6506007)(53936002)(36756003)(4326008)(2906002)(25786009)(14454004)(33656002)(6246003)(7736002)(6512007)(305945005)(99286004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1161;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5TGq4+XutidWC1BW9vYNOy+rLL0HPJ2AmP6bEna6W+se4uCHznjk2iqGP8lhgJ3KTT+bFXrYlVgTmof2Ou43pY0g6/SwgTR1DrT4i1vL/jdPSVMOy7nkRWQE7nbI/L+zYyOWmgR54DlkfcMhkZEvylvB7q/9lM+BzQk3ZzSc/ZW6fyHi1mtV4fyqXw8XxFFoXwXovoUyFOtcxDh5SCyHTUvNdeAyu7qlpy1LYly7PPV7FES8O9edNPNcsElBz2p8Qw8D1AzyuTZrpglquiPXr98LC7LPCa6P2T+jugZaPdo4ij1sWGL8WtMFtyU6iPl2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58DC48A9088BDE4E84A4126563AF9BB0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 303a2e92-baa6-4224-2d4d-08d67732102f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 19:30:22.2476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1161
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 10, 2019, at 10:55 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Thu, Jan 10, 2019 at 06:40:37PM +0000, Song Liu escreveu:
>>=20
>>=20
>>> On Jan 10, 2019, at 10:24 AM, Arnaldo Carvalho de Melo <acme@kernel.org=
> wrote:
>>>=20
>>> Em Wed, Jan 09, 2019 at 11:21:05AM -0800, Song Liu escreveu:
>>>> For better performance analysis of dynamically JITed and loaded kernel
>>>> functions, such as BPF programs, this patch introduces
>>>> PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
>>>> register/unregister information to user space.
>>>>=20
>>>> The following data structure is used for PERF_RECORD_KSYMBOL.
>>>>=20
>>>>   /*
>>>>    * struct {
>>>>    *      struct perf_event_header        header;
>>>>    *      u64                             addr;
>>>>    *      u32                             len;
>>>>    *      u16                             ksym_type;
>>>>    *      u16                             flags;
>>>>    *      char                            name[];
>>>>    *      struct sample_id                sample_id;
>>>>    * };
>>>>    */
>>>=20
>>> So, I couldn't find where this gets used, the intention here is just to
>>> add the interfaces and afterwards is that you will wire this up? I woul=
d
>>> like to test the whole shebang to see it working.
>>=20
>> I guess you meant PERF_RECORD_BPF_EVENT not being used?=20
>>=20
>> PERF_RECORD_KSYMBOL is used by BPF in 3/7 and 5/7. I tested=20
>=20
> Oops, I didn't look at 3/7, just read its cset summary line and as it
> says:
>=20
> Subject: [PATCH v6 perf, bpf-next 3/7] perf, bpf: introduce PERF_RECORD_B=
PF_EVENT
>=20
> I didn't thought it was related, perhaps break it down into one that
> states that it is wiring up PERF_RECORD_KSYMBOL, and at that point we
> could just test it, getting the notifications for new kallsyms related
> to BPF?

Good idea! I will split it into two patches as:

[3/8] perf, bpf: generate PERF_RECORD_KSYMBOL for BPF program=20
[4/8] perf, bpf: introduce PERF_RECORD_BPF_EVENT

>=20
>> PERF_RECORD_BPF_EVENT with dump_trace. As we separate RECORD_KSYMBOL fro=
m
>> RECORD_BPF_EVENT, user space won't use BPF_EVENT until annotation suppor=
t. =20
>=20
> Right, so why not just introduce PERF_RECORD_KSYMBOL, make it be used by
> tooling, etc, then move on to PERF_RECORD_BPF_EVENT?

I'd like to make sure we all agree on the new ABI for RECORD_KSYMBOL and=20
RECORD_BPF_EVENT. Multiple user space tools dependent on RECORD_BPF_EVENT,
for example, bcc and auditing. Finalizing RECORD_BPF_EVENT will unblock the=
=20
development of these tools. On perf side, it will take us quite some time=20
to finish annotation. Ideally, I don't want to block the development of=20
other tools for so long.=20

Thanks,
Song


