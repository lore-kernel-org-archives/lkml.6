Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B4C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973382084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="icOQZZUt";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ivTdbAUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfAVT0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:26:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34746 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbfAVT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:26:14 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MJPLCf005371;
        Tue, 22 Jan 2019 11:25:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SKR5uGh/Jc02cEcf/XGleatmbzTOsYUDnlefQCJP7Og=;
 b=icOQZZUtlAXE2mWW7farOlEtphj4DMZWLXWTpj486qsgY2nT707BNMAlJdejW8RAac3o
 L1S1gtzMaYlYBnMFMtfQmHx5vhhdSisOfPkcdP6lB7ScGxPttOXjgZB2no8ck9aph9zb
 bDW9Cyv1IBphucO7cvyWsbvCLs7XitgvtAE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q677h0hr9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Jan 2019 11:25:26 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 22 Jan 2019 11:24:45 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 22 Jan 2019 11:24:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKR5uGh/Jc02cEcf/XGleatmbzTOsYUDnlefQCJP7Og=;
 b=ivTdbAUQ3pZjJKYmqwsrLlS9QqBt7uGEUamXKYVtbBUqAZHNo5conGxTxmA0Ez5H5IW6ZBPkE0nitKidwKgcT7KJoRL3Gt9dRLt1T3RcsKkr7L/WHsu6NdW5z9kkDA9i/95gxsuO09+ZEcaL3Ezb+82gBdR7phMS9qGTvmfk/wk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1200.namprd15.prod.outlook.com (10.175.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 19:24:44 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 19:24:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v11 perf, bpf-next 7/9] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Thread-Topic: [PATCH v11 perf, bpf-next 7/9] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Thread-Index: AQHUrn/iSbG/DnBf4UmHa+IaoczOfaW1HE+AgAY/8gCAAAUEgIAABZmAgAAB44CAAAadgIAANxeAgAAKVoCAAAJ2gA==
Date:   Tue, 22 Jan 2019 19:24:43 +0000
Message-ID: <CF447261-1B9C-423B-9508-60B32EAC4A5C@fb.com>
References: <20190117161521.1341602-1-songliubraving@fb.com>
 <20190117161521.1341602-8-songliubraving@fb.com>
 <20190118144655.GM5823@kernel.org> <20190122141320.GF14973@kernel.org>
 <20190122143117.GG14973@kernel.org> <20190122145119.GF27625@krava>
 <20190122145805.GI14973@kernel.org> <20190122152145.GG27625@krava>
 <101BF88D-2DA4-4B54-A710-D0641C427136@fb.com> <20190122191555.GH27625@krava>
In-Reply-To: <20190122191555.GH27625@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::4:df87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1200;20:YBwtlNYcTmEuP3mUjTydCEBDhkSIaxqzQYJPppCIgkbMkHVE0rQl3S9dl/Dmg7kTxPdhSXgFl3nUOUrndWDzvE8wV7+zu7m5x9aGlcEXfNLSAURi0YCN0ZCDETnyAEY+28ibZDFMcDX66N+2GZtHvBX59f3303EsMg1BXv5nDZM=
x-ms-office365-filtering-correlation-id: 80b6e620-f825-46ee-0af0-08d6809f437f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1200;
x-ms-traffictypediagnostic: MWHPR15MB1200:
x-microsoft-antispam-prvs: <MWHPR15MB120000F413174D011C3BD3B0B3980@MWHPR15MB1200.namprd15.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(189003)(199004)(446003)(5024004)(81166006)(46003)(68736007)(97736004)(53936002)(6436002)(53546011)(8936002)(93886005)(76176011)(186003)(256004)(478600001)(2616005)(6916009)(6506007)(81156014)(83716004)(50226002)(71200400001)(71190400001)(8676002)(476003)(316002)(486006)(305945005)(102836004)(7736002)(14454004)(11346002)(54906003)(99286004)(36756003)(6116002)(86362001)(25786009)(4326008)(82746002)(57306001)(2906002)(6246003)(33656002)(229853002)(6512007)(105586002)(106356001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1200;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: euJPJivjuyz9JUbwS2KzjTUNrxoOazXjgFUil2fSI0qDBtwyVbkQ1fvFqtaMbW8zpIsZmYYuDE6fq585RtSgFCnTUk1Z0BPzeooGQo94ENU4OrnuNzGYI7kILifbbqBQ19lrbm2TZDd5vhADm0jjCwTU0pnEtJCqz758kiTHOzzhMcuIQg1pN7AevqNgSDknUAPDXPiMMoRRRt5PF6etlxPI7Jh8gWLwt4vclVvQZYG0mFhBaSYooV66XkkQuRq0MJIg8RJ6vfW0rG457qIqGtxM5sdi3GteCW7j06O7gVCx8V8u89btpOAJYtpBEz2CT9O+imy+L7FZ4HD+EIRsKWrueJ82EpbbRybBIx54uKEblA7CJ7L5eh/tdRJ2tRkZBk8w2B0NbZV0zcyBM+mrU4QNpYGehuWdk0OXvSnMbUU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3529190B7E45F4ABF2DB6832946103E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b6e620-f825-46ee-0af0-08d6809f437f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 19:24:43.8667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 22, 2019, at 11:15 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Jan 22, 2019 at 06:38:56PM +0000, Song Liu wrote:
>=20
> SNIP
>=20
>>>> in perf_session__process_event, this happens right when processing
>>>> buildids in 'perf record', and also in 'perf report', so that is
>>>> something badly synthesized that hits perf.data for PERF_RECORD_KSYMBO=
L.
>>>=20
>>> it's reproducible with simple:
>>> perf record -e cycles,instructions ls
>>>=20
>>> as you said on irc, it's the machine->id_hdr_size size missing
>>> there's one more glitch, attached patch fixes that for me
>>> you can't use sizeof(struct ksymbol_event), because it includes
>>> the name as well.. which screws the size
>>>=20
>>> but I don't know that code that much.. might be still something
>>> missing
>>>=20
>>> jirka
>>=20
>> Hi Arnaldo and Jiri,
>>=20
>> Thanks for catching and fixing the bug.=20
>>=20
>> I guess the following is OK?
>>=20
>>        *bpf_event =3D (struct bpf_event){
>>                .header =3D {
>>                        .type =3D PERF_RECORD_BPF_EVENT,
>>                        .size =3D sizeof(struct bpf_event),
>>                },
>>                .type =3D PERF_BPF_EVENT_PROG_LOAD,
>>                .flags =3D 0,
>>                .id =3D info.id,
>>        };
>>=20
>> as struct bpf_event doesn't have variable length name:
>>=20
>>        struct bpf_event {
>>                struct perf_event_header header;
>>                u16 type;
>>                u16 flags;
>>                u32 id;
>>=20
>>                /* for bpf_prog types */
>>                u8 tag[BPF_TAG_SIZE];  // prog tag
>>        };
>>=20
>> Or we need similar fix?=20
>=20
> yep, looks good.. also don't forget to add the 'machine->id_hdr_size'
>=20
> jirka

So we still need something like?

diff --git i/tools/perf/util/bpf-event.c w/tools/perf/util/bpf-event.c
index 01e1dc1bb7fb..d7bf45485820 100644
--- i/tools/perf/util/bpf-event.c
+++ w/tools/perf/util/bpf-event.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <linux/btf.h>
+#include "machine.h"
 #include "bpf-event.h"
 #include "debug.h"
 #include "symbol.h"
@@ -187,7 +188,7 @@ static int perf_event__synthesize_one_bpf_prog(struct p=
erf_tool *tool,
                *bpf_event =3D (struct bpf_event){
                        .header =3D {
                                .type =3D PERF_RECORD_BPF_EVENT,
-                               .size =3D sizeof(struct bpf_event),
+                               .size =3D sizeof(struct bpf_event) + machin=
e->id_hdr_size,
                        },
                        .type =3D PERF_BPF_EVENT_PROG_LOAD,
                        .flags =3D 0,

Would you send the official patch? Or would you prefer me sending it?

Thanks,
Song

