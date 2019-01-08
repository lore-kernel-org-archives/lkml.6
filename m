Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23A2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE56206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jkXDEHeh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OifzEzAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfAHTKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:10:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50386 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727739AbfAHTKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:10:53 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08J9dAp005903;
        Tue, 8 Jan 2019 11:10:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5e7fJDqEZO/xPlsn+qWDt6Km7UWzbnptuTtAJf4gyiA=;
 b=jkXDEHehl42Pq+2aQZXzSZDDcbMT4YstvLtc2y42hye/J7o/fUKYIfI1RIfetKbSo0HI
 xeqLRPjMXe15WimfTCvFKOLlvLkVOAchQeoGy7jAcjFibrnfT1KjJxF0v/YYJGY7lynH
 I7wnFK/9NFLjJMno6s14wPDJOCTgASNP+zE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pvxp7rqb0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Jan 2019 11:10:27 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 8 Jan 2019 11:10:24 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 8 Jan 2019 11:10:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e7fJDqEZO/xPlsn+qWDt6Km7UWzbnptuTtAJf4gyiA=;
 b=OifzEzAC/TFVAlT3II9Uggk+/I01A7Iab3dgEvqub72N3S30Fa1aMn0bObx2p/9XY3ipU9ONN2ltb1F3X858if66j9JoAitcOFl3bj5qPGIITM0/Lp7ehj+HA3ChqS4vvOnOMQlZblC11d9FecwCKh2BWaILsmA/UvZRhdq1oJk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1904.namprd15.prod.outlook.com (10.174.100.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Tue, 8 Jan 2019 19:10:21 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 19:10:21 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUmJHygB8CuOaEkU2QMQ4A40UscaWl0lUAgAAIHwA=
Date:   Tue, 8 Jan 2019 19:10:20 +0000
Message-ID: <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108184116.GC30894@hirez.programming.kicks-ass.net>
In-Reply-To: <20190108184116.GC30894@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::5:43fb]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1904;20:pR9YfwHLJhds5KnQ8tYqeFZvh636pp7uTC43p5iu7zfC/lu4j9m4lwd9aYg9dmpjW7vUywTUN8DbeHy5MtGtgTZFEp4RYRd0D9bAaz2FQFVf0sAWT8JgI4ufVqeRqUh1Sbo+x8ALIOKuzeuKZZKBS4b7WjyjrECAk6TKiKXt2uQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f4d49938-3a00-490e-8e3a-08d6759cef56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1904;
x-ms-traffictypediagnostic: MWHPR15MB1904:
x-microsoft-antispam-prvs: <MWHPR15MB1904DF518BB7EE7F60E76FC3B38A0@MWHPR15MB1904.namprd15.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(229853002)(6436002)(11346002)(478600001)(53546011)(68736007)(186003)(476003)(83716004)(6506007)(97736004)(2616005)(8676002)(6116002)(6486002)(46003)(82746002)(25786009)(57306001)(50226002)(8936002)(81156014)(81166006)(53936002)(86362001)(6512007)(71190400001)(71200400001)(99286004)(76176011)(4326008)(6246003)(2906002)(305945005)(54906003)(7736002)(446003)(486006)(33656002)(102836004)(14454004)(256004)(14444005)(5660300001)(316002)(105586002)(6916009)(106356001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1904;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +KYKRfSA29k2Mbm3abMNkirYIW0lTriX9ApQCNhDO65u9UlyF80MHWcrJPRQaXMjpLSuoj1A9lptMf0+itCXG+0etz70Q2N1Hk1KGDlmpb1Iaco3E78YIWLRkmJ00LEosiA1NgUuhANchmddy1gBL5LN/aEGxniLXU3UXRVKnSbPjjSmEV9gbtxOkkKB185VevlUbI5Y2BrjBpXMhHZOoPLhstTMh87SL6gSyJWa6cYTPEUjfE6s/W4HTWbTt+Khwit7UqTXD7ylK9sxN0FPGbMQt1I4/ajWvM6mSNa/Hg1TL4bMguG1SOiLq/ZGK7fK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2BB3BACED6F3048A26A905C2C903F23@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d49938-3a00-490e-8e3a-08d6759cef56
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 19:10:20.9098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1904
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 8, 2019, at 10:41 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Thu, Dec 20, 2018 at 10:29:00AM -0800, Song Liu wrote:
>> @@ -986,9 +987,35 @@ enum perf_event_type {
>> 	 */
>> 	PERF_RECORD_KSYMBOL			=3D 17,
>>=20
>> +	/*
>> +	 * Record bpf events:
>> +	 *  enum perf_bpf_event_type {
>> +	 *	PERF_BPF_EVENT_UNKNOWN		=3D 0,
>> +	 *	PERF_BPF_EVENT_PROG_LOAD	=3D 1,
>> +	 *	PERF_BPF_EVENT_PROG_UNLOAD	=3D 2,
>> +	 *  };
>> +	 *
>> +	 * struct {
>> +	 *	struct perf_event_header	header;
>> +	 *	u16				type;
>> +	 *	u16				flags;
>> +	 *	u32				id;
>> +	 *	u8				tag[BPF_TAG_SIZE];
>> +	 *	struct sample_id		sample_id;
>> +	 * };
>> +	 */
>> +	PERF_RECORD_BPF_EVENT			=3D 18,
>> +
>=20
> Elsewhere today, I raised the point that by the time (however short
> interval) userspace gets around to reading this event, the actual
> program could be gone again.
>=20
> In this case the program has been with us for a very short period
> indeed; but it could still have generated some samples or otherwise
> generated trace data.

Since we already have the separate KSYMBOL events, BPF_EVENT is only=20
required for advanced use cases, like annotation. So I guess missing=20
it for very-short-living programs should not be a huge problem?

> It was suggested to allow pinning modules/programs to avoid this
> situation, but that of course has other undesirable effects, such as a
> trivial DoS.
>=20
> A truly horrible hack would be to include an open filedesc in the event
> that needs closing to release the resource, but I'm sorry for even
> suggesting that **shudder**.
>=20
> Do we have any sane ideas?

How about we gate the open filedesc solution with an option, and limit
that option for root only? If this still sounds hacky, maybe we should
just ignore when short-living programs are missed?

Thanks,
Song



