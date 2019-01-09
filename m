Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90E4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B470206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AvznXSZY";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LRpuaMRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfAIQEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:04:47 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37416 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731647AbfAIQEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:04:46 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x09FvRhg030497;
        Wed, 9 Jan 2019 08:04:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=O8Uq8cty70RjazMi2A0yZZKK6SKri8cGU8R3bdM9km4=;
 b=AvznXSZYFa37oraX7PoMjAfLBeOV8hKJBqU5+6S4kiGAAU9N5BAWDUWJYmShK31K45bR
 cn6lYC3oUexxZGBgQQTTkPMqEPR/OeIVMDDZgnjzD/eTq6yWj0OIHg5+b2kab5PQaiyt
 8uxmKW5ctdeogEQcv5Tzf+Gct1JBhdzmM8s= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pwgta0q5s-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Jan 2019 08:04:15 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 9 Jan 2019 08:04:10 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 9 Jan 2019 08:04:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8Uq8cty70RjazMi2A0yZZKK6SKri8cGU8R3bdM9km4=;
 b=LRpuaMRX+Q2pAzzonu4SAVIaUf9N9WjvLkRnnpD5bhMUMXbWpYxjB7bOSDdWcZ6nzEtnq91AEkjf7OZx2kPIUfumzVwkTBTnR3Uv+GnizQBcau+CCWDRCQQsoELIDUDKX8VRVKj6at1qqQJdCWuCx6oevZKPNYQmqeee1br4TMs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1776.namprd15.prod.outlook.com (10.174.255.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 9 Jan 2019 16:04:08 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e%6]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 16:04:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUmJHygB8CuOaEkU2QMQ4A40UscaWl0lUAgAAIHwCAAAktAIAARhkAgACuXQCAABTegIAAGEEAgAAzjIA=
Date:   Wed, 9 Jan 2019 16:04:08 +0000
Message-ID: <135D6A3B-45C8-42F3-ABD5-B0C8225BFAF2@fb.com>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108184116.GC30894@hirez.programming.kicks-ass.net>
 <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
 <20190108194310.GD1900@hirez.programming.kicks-ass.net>
 <A0C713E9-6ACE-4235-87C2-2653A8F22F7B@fb.com>
 <20190109101808.GG1900@hirez.programming.kicks-ass.net>
 <924AE46C-B2B9-4E17-A6FC-C678FEADC03B@fb.com>
 <20190109125938.GJ1900@hirez.programming.kicks-ass.net>
In-Reply-To: <20190109125938.GJ1900@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:1691]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1776;20:F18YLJkIAXP2lZ45tsQ696t8d+Qu8vzAkdkVPs7Q4va5HjxO3dI74+0qoJO7x8HkgyUOR/fC+GRN6uAqixU6svCbkYzu40MMgckiKZ1DuFEukR6+ZhJVtc1Um/RSK9r4uc56UowEQ3yj8acb+8QwzAKidwlVBC7eO0NsctFaNYQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5a7bb1a5-ba01-481d-7470-08d6764c1671
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1776;
x-ms-traffictypediagnostic: MWHPR15MB1776:
x-microsoft-antispam-prvs: <MWHPR15MB17766D01AB14D79DAC715623B38B0@MWHPR15MB1776.namprd15.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(136003)(376002)(366004)(199004)(189003)(4326008)(46003)(25786009)(966005)(476003)(478600001)(11346002)(2616005)(316002)(446003)(53546011)(6506007)(86362001)(99286004)(102836004)(97736004)(76176011)(54906003)(186003)(93886005)(6916009)(6306002)(486006)(53936002)(5660300001)(6116002)(6246003)(229853002)(6486002)(6512007)(82746002)(6436002)(105586002)(106356001)(57306001)(2906002)(14444005)(256004)(33656002)(305945005)(7736002)(68736007)(71190400001)(81166006)(81156014)(8676002)(36756003)(71200400001)(83716004)(14454004)(50226002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1776;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PxllewaOqdHnj0IPwUBugm/g7arDljTtQk/1uuvKtc4Nhe7bw0hoZHeeI/g9bvhfCaNb4BoPsx8N0DrhUvtbBLsRZa70mLv/OvXSOdIpkMseT0CFn/c+mMdYxjUN+1S1LL9loOlZIH/Y5JZJD6CxAzrMDG6iv4mMZ7Rtr1+aVNqrTC95Rq05oNEF4vlwU/JzmV3lphNb5KKFImt8PCnxkV0Eg+vutFTfja2CnhyLBeD2O5rdUx7QJElf/9p+jWybTV8mNQ2VhOjiBiUJaGNpN99VMd5v2OX7p+emmFc5JhM6kaoCPxSiomGq6t2TxV/D
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C9748F267FFE445B357C37907CC190F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7bb1a5-ba01-481d-7470-08d6764c1671
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 16:04:08.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1776
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 9, 2019, at 4:59 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Jan 09, 2019 at 11:32:50AM +0000, Song Liu wrote:
>> I was thinking about modifying the text in-place scenario. In this case,=
=20
>> we can use something like
>>=20
>> struct perf_record_text_modify {
>>    u64 addr;
>>    u_big_enough old_instr;
>>    u_big_enough new_instr;
>=20
> char[15] for x86 ;-)
>=20
> Also, I don't think we need old, we should already have the old text,
> either from a previous event or from the initial kcore snapshot.
>=20
>>    timestamp ;
>=20
> that lives in struct sample_id.
>=20
>> };
>>=20
>> It is a fixed size record, and we don't need process it immediately=20
>> in user space. At the end of perf run, a series of these events will=20
>> help us reconstruct exact text at any time.=20
>=20
> That works for text_poke users, see also:
>=20
>  https://lkml.kernel.org/r/20190109103544.GH1900@hirez.programming.kicks-=
ass.net
>=20
> But is useless for module / bpf / ftrace dynamic text.

I think we will end up with RECORD_KSYMBOL + something else for all cases.=
=20
For bpf, it is RECORD_KSYMBOL + (optional) RECORD_BPF_EVENT. For text_poke,=
=20
it will be RECORD_KSYMBOL + RECORD_TEXT_POKE. In all cases, RECORD_KSYMBOL
goes to regular buffer and gets saved directly to perf.data. The other=20
record goes to a separate buffer, and requires extra processing.=20

>=20
>>> All we need is some means of ensuring the symbol is still there by the
>>> time we see the event and do the copy.
>>>=20
>>> I think we can do this with a new ioctl() on /proc/kcore itself:
>>>=20
>>> - when we have kcore open, we queue all text-free operations on list-1.
>>>=20
>>> - when we close kcore, we drain all (text-free) list-* and perform the
>>>  pending frees immediately.
>>>=20
>>> - on ioctl(KCORE_QC) we perform the pending free of list-3 and advance
>>>  list-2 to list-3 and list-1 to list-2.
>>>=20
>>> Perf would then open kcore at the start of the record, make a complete
>>> copy and keep the FD open. At the end of every buffer process, we issue
>>> KCORE_QC IFF we observed a ksym unreg in that buffer.
>>=20
>> Does this mean we need to scan every buffer before writing it to perf.da=
ta=20
>> during perf-record?=20
>=20
> Just like the BPF events, yes. Now for PT most of the actual data is not
> in the regular buffer, so it shouldn't be too horrible, but just like
> the BPF event, it can get its own buffer if it does become a problem.

I see. Separate buffer does make it better.=20

>=20
>> Also, if we need ksym unreg here, I guess it is NOT really modifying tex=
t=20
>> in-place, but creating new version and swap? Then can we include somethi=
ng=20
>> like this in perf.data:
>>=20
>> struct perf_record_text_modify {
>>    u64 old_addr;
>>    u64 new_addr;
>>    u32 old_len; /* up to MAX_SIZE */
>>    u32 new_len; /* up to MAX_SIZE */
>>    u8 old_text[MAX_SIZE];
>>    u8 new_text[MAX_SIZE];
>>    timestamp ;
>> };
>>=20
>> In this way, this record is embedded in perf.data, and doesn't require
>> extra processing during perf-record (only at the end of perf-record).=20
>> This would work for text modifying case, as modifying text is simply
>> old-text to new-text.
>>=20
>> Similar solution would not work for BPF case, as bpf_prog_info is=20
>> getting a lot more members in the near future.=20
>>=20
>> Does this make sense...?
>=20
> I don't think we actually need old_text here either. We're creating a
> new text mapping, there was nothing there before.
>=20
> But still, perf events are limited to 64k, so that means we cannot
> support symbols larger than that (although I suppose that would be
> fairly rare).

For larger symbols, I guess we can do one RECORD_KSYMBOL and multiple=20
RECORD_TEXT_MODIFY.=20

Thanks,
Song=
