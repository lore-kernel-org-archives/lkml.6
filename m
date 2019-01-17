Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20558C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74C320652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rl8e01xS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eyn6aloI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfAQOue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:50:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35884 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbfAQOud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:50:33 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HEnXun017368;
        Thu, 17 Jan 2019 06:49:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7+lOk0/XsTaBBY07cFDYIH9sOarRFE5r9pl1OTEOFas=;
 b=rl8e01xSveDl8kcf37ZmBUzCXpySRjT8ELa79yLv+sqiiMB0JIAgmTWkWQYfdg4rmaqx
 8pktxnhYox3ZKAJEQf+uln5v6xWk0ocIQ1p5S1qe+x3IQqFWfeqPWFwzVQNre8n5Ez9i
 1VRyfoOL8o0XMDXttYthdIdp946KHZePID8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q2uta001f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Jan 2019 06:49:36 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 17 Jan 2019 06:49:13 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 17 Jan 2019 06:49:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+lOk0/XsTaBBY07cFDYIH9sOarRFE5r9pl1OTEOFas=;
 b=eyn6aloIEhgtfiR3+fCnhGP71D7fhzJ4bJsENbZzRLyVV9sdq/ahhrHxi1nH/vVkQXEmyuVc+wCFNBH31QiVxs/TyHhROR8rJsEDvm5jRmoY/3G3u31L4sWNaL7wIgqssclCLUL2svQm7GM3CTy/ESRDIDA+IxYWCpKkCPF4Mis=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1550.namprd15.prod.outlook.com (10.173.235.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Thu, 17 Jan 2019 14:49:10 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 14:49:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "dsahern@gmail.com" <dsahern@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v10 perf, bpf-next 1/9] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Topic: [PATCH v10 perf, bpf-next 1/9] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Index: AQHUrbi9c1EElErIo0qiEt/rp76sWqWzbMuAgAAfXoA=
Date:   Thu, 17 Jan 2019 14:49:10 +0000
Message-ID: <A411D89E-0B62-4DE7-9D70-CD57672FD20A@fb.com>
References: <20190116162931.1542429-1-songliubraving@fb.com>
 <20190116162931.1542429-2-songliubraving@fb.com>
 <20190117125653.GF10486@hirez.programming.kicks-ass.net>
In-Reply-To: <20190117125653.GF10486@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:4cc3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1550;20:+e4euaOJEhWdmrsElgtzg3FrOpUeegCGTU2V79l5WXmEmlwwD97ki0PXABVLVq6u9NfVGbJR2XODUwkSyTkTWIXsSYU/gBnh5j9UrhVe4lPBczv3wU0515Xu3Nl2BDfOmCIQFtbPQOmGkHfOx+Z5ITm7A1I3y7A4nAYzGMkF2YE=
x-ms-office365-filtering-correlation-id: d905e5ee-8aac-478b-92b5-08d67c8af09f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1550;
x-ms-traffictypediagnostic: MWHPR15MB1550:
x-microsoft-antispam-prvs: <MWHPR15MB155079457E1AD053E97C7CD6B3830@MWHPR15MB1550.namprd15.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(54534003)(189003)(6246003)(476003)(229853002)(33656002)(82746002)(14454004)(46003)(2616005)(50226002)(81156014)(5660300001)(2906002)(54906003)(81166006)(8936002)(57306001)(83716004)(106356001)(25786009)(446003)(478600001)(8676002)(105586002)(71190400001)(71200400001)(186003)(5024004)(256004)(36756003)(11346002)(6116002)(6506007)(68736007)(486006)(4326008)(7736002)(53546011)(6486002)(6436002)(6916009)(305945005)(316002)(97736004)(39060400002)(99286004)(86362001)(76176011)(53936002)(102836004)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1550;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pj78ba1ZtNNJFSZ9O/AIjERacD/bUlbpciexRYwj2J3QhdZBwjQdnPKiERsfXVjO6drFDS5BgKzIPe5p8B03BfhDQrC8jyBhU4L2klJwVEVVOHZ7f8UP0azfD0OWf/WcOK5Gg+pjWBrqC9VcQUP2pM/5JM4U16UnSqRQ9XTqe10L++ZP8Rd97OkwlwdTsa3Wwgr6UiUnz/ausTp/XKkIo+5yW5BEqzSHiLutivR+RI4isQmJu/mJH1C7NfITHqB5IJOvq3ID8DWOdFWTovZuswhdFFo2GlEwBwEPV6iDMpTqk5rpSuiDRSJc91TRgHMsBqpblKxNSPsvEFYIgBvPjFKto4FTMh10JSLRcPdZkJo7UpHtk1cJo2DQ/FiK+oJ2fcx4Ub0iRhZmPcCQL8a7hl5lz2/jRhuFxzBpvvTL5qw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F654CED1193F4F4EB206440D50163BFF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d905e5ee-8aac-478b-92b5-08d67c8af09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 14:49:10.1882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1550
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2019, at 4:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Jan 16, 2019 at 08:29:23AM -0800, Song Liu wrote:
>> For better performance analysis of dynamically JITed and loaded kernel
>> functions, such as BPF programs, this patch introduces
>> PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
>> register/unregister information to user space.
>>=20
>> The following data structure is used for PERF_RECORD_KSYMBOL.
>>=20
>>    /*
>>     * struct {
>>     *      struct perf_event_header        header;
>>     *      u64                             addr;
>>     *      u32                             len;
>>     *      u16                             ksym_type;
>>     *      u16                             flags;
>>     *      char                            name[];
>>     *      struct sample_id                sample_id;
>>     * };
>>     */
>=20
> So I've cobbled together the attached patches to see how it would work
> out..
>=20
> I didn't convert ftrace trampolines; because ftrace code has this
> uncanny ability to make my head hurt. But I don't think it should be
> hard, once one figures out the right structure to stick that
> kallsym_node thing in (ftrace_ops ?!).
>=20
> It is compiled only, so no testing what so ever (also, no changelogs).
>=20
> I didn't wire up the KSYM_TYPE thing; I'm wondering if we really need
> that, OTOH it really doesn't hurt having it either.
>=20
> One weird thing I noticed, wth does bpf_prog_kallsyms_add() check
> CAP_ADMIN ?! Surely even a non-priv JIT'ed program generates symbols,
> why hide those?
>=20
> Anyway; with the one nit about the get_names() thing sorted:
>=20
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>=20
> (thanks for sticking with this)
> <peterz-latch-next.patch><peterz-kallsym.patch><peterz-kallsym-bpf.patch>

Aha, now I get the point on perf_event_ksymbol(). Yeah this approach is=20
definitely better.=20

While I run more tests with these patches, could we get current in=20
perf/core? This will enable the development of user space tools like
bcc.=20

Also, I current base this set on bpf-next tree, as tip/perf/core is=20
4 week old. Shall I rebase the set on Linus' tree? Or shall I wait for
tip/perf/core?

Thanks again!
Song

=20

