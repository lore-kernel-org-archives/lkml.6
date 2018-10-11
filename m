Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE3C67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B8621470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Z02qZMDe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YnbcFbXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B8621470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJLGHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:07:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35684 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbeJLGHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:07:10 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BMbKQC021872;
        Thu, 11 Oct 2018 15:37:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kFRmNFmVBv9vl3qioDJqw2TxqxhXg0ABIeCIsUTx8/A=;
 b=Z02qZMDePJWElxNYxTrDMnuuSOdm+Fqmd5/IKQSgDfqqq7iz1c/U2wFWduqllgQdeEYP
 A3GIKjvdou7d98CPP8tjcEmPDPM2ed3PRbR6F7Af7aWASyTD6gtVebOjaJmlQ9SoeySE
 KOa9d8YkBcruQVK0VbM4h4H1HA+raXqmHNw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2n2cg10m82-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 11 Oct 2018 15:37:20 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 11 Oct 2018 15:37:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFRmNFmVBv9vl3qioDJqw2TxqxhXg0ABIeCIsUTx8/A=;
 b=YnbcFbXZX19qLliS0cPZlPRzE+txds0hPHWTxRU7zgxULCT5VZSA6/AGh8fYdnMaicjnQKE12bLJEvCTQ3+pM+d3/1DCcx4QeqOUA0nRf1mulvLy8IGIZPOuxJqV8+d6siH19oJ8JTCfnnaA7dKpTBPKs4/DTz/JX+52V+O6fY0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1693.namprd15.prod.outlook.com (10.175.141.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Thu, 11 Oct 2018 22:37:15 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%8]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 22:37:15 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "eranian@google.com" <eranian@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Thread-Topic: [RFC][PATCH] perf: Rewrite core context handling
Thread-Index: AQHUYIaFJ/VvvMmSxkC06uIJGGK3pKUZrRIAgAAbn4CAANwqgA==
Date:   Thu, 11 Oct 2018 22:37:14 +0000
Message-ID: <70079805-1CAE-4CAA-813A-F8DDB929F22B@fb.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
 <20181011092913.GA9848@hirez.programming.kicks-ass.net>
In-Reply-To: <20181011092913.GA9848@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::6:1c07]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1693;20:bCC6m+cWkErsd3i70qNSgG9D8Su8myiPmY+DmCZFFKITD1ilJ/iw2KU5mLhAASXXb9J3R1a1pM/6veX9d7EPbzI6BaMXViHcq7WNuRXTeleu9RIqDs5Y7JKdNxJpLvIL4MGUC2ju5APyflIBOQ9iYjAj/00ItAhRPYWgxUIYblQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 084ed7d7-021f-4543-8334-08d62fca17ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1693;
x-ms-traffictypediagnostic: MWHPR15MB1693:
x-microsoft-antispam-prvs: <MWHPR15MB1693FD2EAB84F9AB694A99A8B3E10@MWHPR15MB1693.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:MWHPR15MB1693;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1693;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(396003)(366004)(469094003)(53484002)(53474002)(199004)(189003)(25786009)(97736004)(6436002)(2900100001)(82746002)(256004)(71190400001)(71200400001)(54906003)(68736007)(83716004)(229853002)(33656002)(316002)(5250100002)(6486002)(36756003)(81166006)(5660300001)(50226002)(106356001)(8676002)(81156014)(105586002)(478600001)(446003)(14454004)(4326008)(57306001)(8936002)(6512007)(6506007)(186003)(2616005)(11346002)(476003)(102836004)(53546011)(7736002)(305945005)(2906002)(6916009)(6116002)(86362001)(6246003)(76176011)(7416002)(486006)(99286004)(53936002)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1693;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: btCiK9xoV0Pv1p5KlAueoGjynmU/ysh7/udh7jzuyrsCkDgNYstnKgEIVGkrPsDVUiMta+VV5H8z/0tuXDFobdNp7ixqfYvfzx5l8Y3BF03uX52gPDfufu6hoQ9i0T96LeM/k5g8/cROsXDoK3c9HOXZtJES5tG2iX4HrT+HZvhcmosd3G/A0NXTtPWfauRhvfuqGdJg7QrHaJkQSif0ckIHOnPWSCJWNpeKKi5gwMIdtStSyQYXnnJ4AGMF/PKmbkv/GlbwO6GdWR6XOzSi8vTE6tpD/kSRGQ8hPoL8HE8WXkoNv4bNxx8l2E+chWkG4jSRSgRgsWfJoSlloTXDuwHCvoiN8vbmCETwE0rDP+E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D66425F5E7A0240B3DA861E33DF4A9E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 084ed7d7-021f-4543-8334-08d62fca17ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 22:37:15.0142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1693
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Peter! These are really really helpful.=20

I am trying to think through the case of a group of two events on two=20
separate hardware PMUs. In current implementation, this will not trigger
move_group, so they will not be able to rotate together? And actually,=20
they may not be able to run at all? Maybe this case is never supported?=20

On the other hand, would something like this work:

    perf_cpu_context <-[1:2]-> perf_event_context <-[1:n]-> perf_event=20
              |                                                |
              `----[1:n]---->     pmu    <----- [1:n]----------'=20

1. Every cpu has only one perf_cpu_context. No perf_cpu_pmu_context.=20
2. perf_cpu_context has two perf_event_context, one for the cpu, the=20
   other for the task.=20
3. Each perf_event_context has 3 perf_event_groups, pinned_groups,=20
   flexible_groups, and software_groups (for sw event only groups).=20
4. All flexible_groups of the same cpu rotate a the same time. If=20
   there are two hardware PMUs on the cpu, the rotation will look=20
   like: 1) stop both PMUs; 2) rotate events; 3) start both PMUs.=20

I feel this will make the implementation simpler. Is it too broken in=20
some cases? Or did I miss anything obvious? One thing I noticed is=20
that we need to drop per PMU config perf_event_mux_interval_ms.=20

Please let me know whether this makes sense at all. I will read=20
more of current version in the meanwhile.=20

Thanks again,
Song


> On Oct 11, 2018, at 2:29 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Thu, Oct 11, 2018 at 07:50:23AM +0000, Song Liu wrote:
>> Hi Peter,=20
>>=20
>> I am trying to understand this. Pardon me if any question is silly.=20
>>=20
>> I am not sure I fully understand the motivation here. I guess we
>> see problem when there are two (or more) independent hardware PMUs=20
>> per cpu? Then on a given cpu, there are two (or more)=20
>> perf_cpu_context, but only one task context?=20
>=20
> Right.
>=20
>> If this is correct (I really doubt...), I guess perf_rotate_context()
>> is the problem?=20
>=20
> No, everything comes apart. Where would you put the events of the second
> PMU?
>=20
> The thing most often proposed it pretending the second PMU is a
> 'software' PMU and sticking the events on the software PMU context.
>=20
> But because software PMUs must never fail to schedule an event, that
> results in some quite horrible things -- including that we cannot RR the
> events.
>=20
> Similarly the big.little guys have the problem that the PMUs are not the
> same between big and little cores, and they fudge something horrible. By
> having clear ordering on PMU, that can be cleaned up too.
>=20
>> And if this is still correct, this patch may not help,
>> as we are doing rotation for each perf_cpu_pmu_context? (or rotation=20
>> per perf_event_context is the next step?).=20
>=20
> We do indeed to rotation per perf_cpu_pmu_context, however:
>=20
> - perf_cpu_pmu_context embeds a cpu scope perf_event_pmu_context,
> - perf_cpu_pmu_context tracks the currently associated task scope
>   perf_event_pmu_context.
>=20
> So it can rotate all current events for a particular PMU.
>=20
>> Or step back a little... I see two big changes:
>>=20
>> 1. struct perf_ctx_context is now per cpu (instead of per pmu per cpu);
>> 2. one perf_event_ctxp per task_struct (instead of 2). =20
>=20
> Correct, we reduce to 1 cpu context and 1 task context at all times.
> This in fact simplifies quite a bit of things.
>=20
>> I think #1 is a bigger change than #2. Is this correct?=20
>=20
> They're the 'same' change. But yes the primary purpose was 2, but having
> only a single cpu context is a direct consequence.
>=20
>> Could you please help me understand it better?=20
>=20
> I hope this helps to understand, please feel free to ask more.

