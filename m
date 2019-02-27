Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD627C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9708020C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="h8p8r+Rl";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LsUHEw0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfB0Rj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:39:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39092 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726356AbfB0RjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:39:25 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RHW3R2024557;
        Wed, 27 Feb 2019 09:38:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TKvqfJ39UI78xK9Xo6S61PTFQQipChZk8ECWvnoVoIs=;
 b=h8p8r+RlEOHvKt0rhlSZpnYNobhbTxI06cf2zamsOd1EZxCpukc+6cQhODnzJ4LsMg6X
 ceUJenQgj82Qw6xHP7npIN30g+pc3PrNwH221jcuVLndbSLBQ+i1Ud1g39s95J4JPI5t
 5cY6VYYpozAYBBvOuII006VjVWDAvmSNpaM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qwwhfrc00-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 09:38:59 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 27 Feb 2019 09:38:05 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 27 Feb 2019 09:38:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKvqfJ39UI78xK9Xo6S61PTFQQipChZk8ECWvnoVoIs=;
 b=LsUHEw0QFTd3auCIWoenjcgXTdhICNuuGesSFpHIgunWvypruFr5leYIIRI3I+j+dZ155lWv6baJ2OhW4JyuUKf/lzWayqNvYS8MZqso4djMFO5ayTYqlTzm8jvTPrCIFMqrUC9I1vSaq8l9X8erPskHB8AUOU7IE+Cs71tmC2w=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1645.namprd15.prod.outlook.com (10.175.135.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 27 Feb 2019 17:38:03 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 17:38:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v4 perf,bpf 06/15] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Thread-Topic: [PATCH v4 perf,bpf 06/15] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Thread-Index: AQHUzWk+HaljyEBwUke8W+mkg0LMcKXzo9iAgABHtQA=
Date:   Wed, 27 Feb 2019 17:38:03 +0000
Message-ID: <B857ABD1-046A-4B1F-B498-C09273B1FD5E@fb.com>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-7-songliubraving@fb.com>
 <20190227132123.GE18893@krava>
In-Reply-To: <20190227132123.GE18893@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::eed9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c74e88b6-98b8-46b3-09cc-08d69cda5371
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1645;
x-ms-traffictypediagnostic: MWHPR15MB1645:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1645;20:SuEIRW12BZkVuzpjnknyVwUftZnm6/KPhRGu4XrPXiaEPVJM1JCOMOxQXLTzIlY1b+N/VU4p/p7IK9tz04MgzqIgy7YfQ+xxTwcsT1jdej5qtc9yNDfWiZsrvZj1K3P4xXcLpwXLqhi85utXl6kIrBHMypUXb/oxL10ft2ENanQ=
x-microsoft-antispam-prvs: <MWHPR15MB1645059E0BA18ECF193EB784B3740@MWHPR15MB1645.namprd15.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(136003)(376002)(189003)(199004)(54534003)(316002)(106356001)(478600001)(50226002)(71200400001)(2906002)(71190400001)(57306001)(6246003)(36756003)(97736004)(105586002)(83716004)(33656002)(14454004)(6116002)(68736007)(6506007)(53546011)(102836004)(229853002)(8936002)(6916009)(7736002)(305945005)(76176011)(5660300002)(6512007)(53936002)(81156014)(81166006)(6436002)(82746002)(4326008)(46003)(11346002)(256004)(8676002)(476003)(2616005)(446003)(99286004)(486006)(54906003)(86362001)(25786009)(6486002)(186003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1645;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zYR/fk2iCj6Uz36Zdf+AcBCB5Z90rqu164/59bwqgVDMOhezjQw2FXk7lSqvnetCd98IB0PKHphcalBrt10fb59Op5RUI/5IczN7FHq1j4jXF6GxppLM4cGBf9hKCnb0ixwEPrtDAR0u91BCgMfSyUX9F9nMgZw9nSElMHp6TtsVZg33ub3ipQ0+DYfvaIC0NXHrGrkW48WoFyEjW/sezmNn9MozSCDXpFbiCjroEZ40kb/3Z5UtzR5PmCuq6pFNx1vrpRx1HLKYcmdM2BzR+gYn5TkCCW5gjuBMNx0N0ThywzMWFLq/9SnNsZjxwG4+/OGiZIzc9mB+pIhWMUcG+i6CPZzLDjaB79y5+rnUYzH9Iu72kDSAd4UkNhT2386dQMxDdCO3DsNYNEp150ZaZPw/z8vNDf9UaRlPPTE0C+s=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <598B624780D6BC4D971B7F7A1EF7CF3D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c74e88b6-98b8-46b3-09cc-08d69cda5371
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 17:38:03.4853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1645
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 27, 2019, at 5:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Feb 25, 2019 at 04:20:10PM -0800, Song Liu wrote:
>> bpf_prog_info contains information necessary to annotate bpf programs.
>> This patch saves bpf_prog_info for bpf programs loaded in the system.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/util/bpf-event.c | 32 +++++++++++++-
>> tools/perf/util/bpf-event.h |  7 ++-
>> tools/perf/util/env.c       | 85 +++++++++++++++++++++++++++++++++++++
>> tools/perf/util/env.h       | 17 ++++++++
>> 4 files changed, 139 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
>> index ff7ee149ec46..ce81b2c43a51 100644
>> --- a/tools/perf/util/bpf-event.c
>> +++ b/tools/perf/util/bpf-event.c
>> @@ -10,6 +10,7 @@
>> #include "debug.h"
>> #include "symbol.h"
>> #include "machine.h"
>> +#include "env.h"
>> #include "session.h"
>>=20
>> #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
>> @@ -54,17 +55,28 @@ static int perf_event__synthesize_one_bpf_prog(struc=
t perf_session *session,
>> 	struct bpf_event *bpf_event =3D &event->bpf_event;
>> 	struct bpf_prog_info_linear *info_linear;
>> 	struct perf_tool *tool =3D session->tool;
>> +	struct bpf_prog_info_node *info_node;
>> 	struct bpf_prog_info *info;
>> 	struct btf *btf =3D NULL;
>> 	bool has_btf =3D false;
>> +	struct perf_env *env;
>> 	u32 sub_prog_cnt, i;
>> 	int err =3D 0;
>> 	u64 arrays;
>>=20
>> +	/*
>> +	 * for perf-record and perf-report use header.env;
>> +	 * otherwise, use global perf_env.
>> +	 */
>> +	env =3D session->data ? &session->header.env : &perf_env;
>> +
>> 	arrays =3D 1UL << BPF_PROG_INFO_JITED_KSYMS;
>> 	arrays |=3D 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
>> 	arrays |=3D 1UL << BPF_PROG_INFO_FUNC_INFO;
>> 	arrays |=3D 1UL << BPF_PROG_INFO_PROG_TAGS;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_JITED_INSNS;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_LINE_INFO;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
>>=20
>> 	info_linear =3D bpf_program__get_prog_info_linear(fd, arrays);
>> 	if (IS_ERR_OR_NULL(info_linear)) {
>> @@ -153,8 +165,8 @@ static int perf_event__synthesize_one_bpf_prog(struc=
t perf_session *session,
>> 						     machine, process);
>> 	}
>>=20
>> -	/* Synthesize PERF_RECORD_BPF_EVENT */
>> 	if (opts->bpf_event) {
>> +		/* Synthesize PERF_RECORD_BPF_EVENT */
>> 		*bpf_event =3D (struct bpf_event){
>> 			.header =3D {
>> 				.type =3D PERF_RECORD_BPF_EVENT,
>> @@ -167,6 +179,24 @@ static int perf_event__synthesize_one_bpf_prog(stru=
ct perf_session *session,
>> 		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
>> 		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
>> 		event->header.size +=3D machine->id_hdr_size;
>> +
>> +		/* save bpf_prog_info to env */
>=20
> why do we save this to perf_env in here? we just
> synthesize the same data as event, so report and
> top will read it and fill perf_env again, right?

The synthesized events are same as PERF_RECORD_BPF_EVENT
PROG_LOAD. We need to process them and fill perf_env as
soon as we get PROG_LOAD. Otherwise, the program might=20
unload before we process them.=20

>=20
> could you please explain the whole flow of the
> bpf events and its respective data in perf_env
> and put it into the changelog

I will add more information to the change log.=20

>=20
>> +		info_node =3D malloc(sizeof(struct bpf_prog_info_node));
>> +
>> +		/*
>> +		 * Do not bail out for !info_node, as we still want to
>> +		 * call  perf_tool__process_synth_event()
>=20
> well, we are out of memory, so I dont think perf_tool__process_synth_even=
t
> will get too far.. also the perf_env data would be inconsistent with what
> you store as event.. how can that work?

It is OK we have PERF_RECORD_BPF_EVENT but not related
bpf_prog_info and btf. The perf.data file will show=20
a BPF program was loaded, but we won't be able to do=20
annotation. Does this make sense?

Thanks,
Song

>=20
> thanks,
> jirka
>=20
>> +		 */
>> +		if (info_node) {
>> +			info_node->info_linear =3D info_linear;
>> +			perf_env__insert_bpf_prog_info(env, info_node);
>> +			info_linear =3D NULL;
>> +		}
>> +
>=20
> SNIP

