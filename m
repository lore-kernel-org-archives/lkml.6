Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81170C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B92821773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dgpnal0Y";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eXY8XyD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfBSOVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:21:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48266 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbfBSOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:21:52 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JEEQd1016585;
        Tue, 19 Feb 2019 06:21:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tpSpmtQH9sPHKxv/KrgxaVnKto8SKKMUcwFkurOkNhg=;
 b=dgpnal0YkYQsWFXrmoCS52PObG8ergHQG9FPurhfL/oZLMmL8FzI7fXKOX23R1KJy5qN
 oGXyG/OKmZLCfa07kEeImw2hl3riw1zTJHdo9rG+Tjrm2zWc1bgWTj4pVxTgyeZReIKy
 y0/ZAbl0b54bRPo0bUafEwqUvNQsvDhtKVE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qrey5gqvq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Feb 2019 06:21:24 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 19 Feb 2019 06:21:22 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 19 Feb 2019 06:21:22 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 19 Feb 2019 06:21:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpSpmtQH9sPHKxv/KrgxaVnKto8SKKMUcwFkurOkNhg=;
 b=eXY8XyD+o+dkS1lKAtc0G32ce/RQDat+OncehBVwphRe8GLXzCAY12apj4w8jV4BdyGeK6eM3jwDxgJmBiEW/FwA242PVicq4dArtDAdSn8aCleIh5Nn6F3PfDCFIn3hdx1/P/KV7LyuKX4xM7zm4zkx6kCVGgJYbGHFCsvZjEQ=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1817.namprd15.prod.outlook.com (10.174.246.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 14:21:03 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560%7]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 14:21:03 +0000
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
Subject: Re: [PATCH v3 perf,bpf 05/11] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Thread-Topic: [PATCH v3 perf,bpf 05/11] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Thread-Index: AQHUxXkOtC9zjVEe5kKW+v5YXb3KDaXkn4sAgAIECoCAADIngIAAXAAA
Date:   Tue, 19 Feb 2019 14:21:03 +0000
Message-ID: <55885497-4542-4FED-97E0-64664059FFC3@fb.com>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-6-songliubraving@fb.com>
 <20190217230516.GA7443@krava> <4784383E-1BFA-4387-8864-B1814FFEC937@fb.com>
 <20190219085145.GC13284@krava>
In-Reply-To: <20190219085145.GC13284@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:eac4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0ecf842-d399-4781-1b0e-08d696757abf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1817;
x-ms-traffictypediagnostic: DM5PR15MB1817:
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1817;20:NRXxsebuXBUfAjJF7esdYOlM9C3kI2OOIo+w6Sj3cLXdym05qzHs+Ue5c4XfHHmjorrH2uT9XU1Hp+PZ5rtSKlU4x4otD9CcpVBDBpvevGF5GMJL7MEG65IWAr3VOLjwF3wGVvGObYd33o5EbDVQX+fp/fIsQx3Y0xoVKSsPy6E=
x-microsoft-antispam-prvs: <DM5PR15MB1817E9D1AEFCDA13F10E8101B37C0@DM5PR15MB1817.namprd15.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(366004)(396003)(376002)(199004)(189003)(83716004)(106356001)(36756003)(5660300002)(6512007)(86362001)(6506007)(68736007)(478600001)(71190400001)(71200400001)(256004)(102836004)(105586002)(6436002)(6916009)(82746002)(316002)(4326008)(6246003)(53936002)(305945005)(25786009)(6116002)(7736002)(53546011)(93886005)(54906003)(97736004)(57306001)(50226002)(2906002)(446003)(11346002)(6486002)(2616005)(33656002)(76176011)(486006)(81156014)(8676002)(46003)(14454004)(99286004)(476003)(81166006)(229853002)(186003)(8936002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1817;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QhDKBMBDG4W0ytO9x+PkZSDdsbD+SF13PIHEOcLXp6wfczsGBVe1YmUJv2IRRIXf0mRzych475Ez2eZJQhy40mPTblSVngD0SmwpXg93nEx0tYGZuJ47O7p/u6qrgp5sKmKwo3KoIq2CGHo6oiy/dvawWVomXJeKZs+UYHwKD1mZRtDX252+YP8TbKbh7euo8lKsr4yC5qscAd1g2LS3l4eyxSj1E0OSytd1vHOZu1wZ6g8GbPu2akBOD8jlYb6pca07V7rJOztFt+Cb1MwGLzhFZB+KBjY2NmTVJT5xrPG+o/uNsMfE3YFNT86nWPJLV0rY3Rpdt6fRNOxzGC2TzEPQTnmMm+ifqTfUMLev8S91PcJTO8kLTU9/wSumkBCsEOTzgtu91fCfTdJwrdGB6oMMj+ag+qrs90HlkF4cj5c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <703DEB218527A349A2E97465E69E672E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ecf842-d399-4781-1b0e-08d696757abf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 14:21:03.2146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1817
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 19, 2019, at 12:51 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Feb 19, 2019 at 05:52:20AM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Feb 17, 2019, at 3:05 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Fri, Feb 15, 2019 at 01:53:48PM -0800, Song Liu wrote:
>>>=20
>>> SNIP
>>>=20
>>>> 	info_linear =3D bpf_program__get_prog_info_linear(fd, arrays);
>>>> 	if (IS_ERR_OR_NULL(info_linear)) {
>>>> @@ -151,8 +165,8 @@ static int perf_event__synthesize_one_bpf_prog(str=
uct perf_tool *tool,
>>>> 						     machine, process);
>>>> 	}
>>>>=20
>>>> -	/* Synthesize PERF_RECORD_BPF_EVENT */
>>>> 	if (opts->bpf_event) {
>>>> +		/* Synthesize PERF_RECORD_BPF_EVENT */
>>>> 		*bpf_event =3D (struct bpf_event){
>>>> 			.header =3D {
>>>> 				.type =3D PERF_RECORD_BPF_EVENT,
>>>> @@ -165,6 +179,19 @@ static int perf_event__synthesize_one_bpf_prog(st=
ruct perf_tool *tool,
>>>> 		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
>>>> 		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
>>>> 		event->header.size +=3D machine->id_hdr_size;
>>>> +
>>>> +		/* save bpf_prog_info to env */
>>>> +		info_node =3D malloc(sizeof(struct bpf_prog_info_node));
>>>> +		if (info_node) {
>>>> +			info_node->info_linear =3D info_linear;
>>>> +			perf_env__insert_bpf_prog_info(env, info_node);
>>>> +			info_linear =3D NULL;
>>>> +		}
>>>=20
>>> what if the allocation fails? we don't care?
>>>=20
>>> jirka
>>=20
>> My original plan is to just ignore it and accept that this program
>> doesn't have annotation. Any suggestion on what would be a better=20
>> approach?
>=20
> there's an error path in the function, I'd bail out if the malloc fails
>=20
> jirka

If we go to bail out here, we will skip processing PERF_RECORD_BPF_EVENT.=20
When malloc fails, this is still valuable information that we should try=20
to save. So I think we don't have to bail out here. I will add a comment
to explain this.=20

Thanks,
Song



