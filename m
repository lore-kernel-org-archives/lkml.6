Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD3AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D77205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OW+II2g2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZY+OHmLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D77205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeJWOgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:36:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57288 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726764AbeJWOgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:36:15 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9N6Ab2d028773;
        Mon, 22 Oct 2018 23:13:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kOtJVkDYLdlcuqIYahjG1heBENqSsxkBsmjJDGhbms0=;
 b=OW+II2g2h9diMvSU+vGgi33Hrs2vb1VN6Y0L8tY72bRKl3e5wll7xGizBNPRzkUuGwPF
 Yvh/pmK8agGq7cD6rbDwH3DBtfnR0p+ym0eQGf2XzXNZ/QD5wlVSAFb3dZIkTRNTX+rI
 sMY1RvBxknR7GWMQ7fuAyy5abUuBjqjLqr0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n9p8j17w8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Oct 2018 23:13:33 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 22 Oct 2018 23:13:32 -0700
Received: from PRN-CHUB13.TheFacebook.com (2620:10d:c081:35::22) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 22 Oct 2018 23:13:32 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 22 Oct 2018 23:13:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOtJVkDYLdlcuqIYahjG1heBENqSsxkBsmjJDGhbms0=;
 b=ZY+OHmLfmbpbGmlb+hMGIesyDTT5/Mdu+Qn53xzGxSkmIT790gBwUKJqlgEqEWc3XK3G/DLKi0KeC/HrI0v2VsmYrJtpUSgHLSMpyVmtYhxJQn0+fZu/hfYVlJWZ+Mtk7z9JTEJnRZ6FZALTk9G1oZpH82ogOCnwhFAAtsnKePM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1312.namprd15.prod.outlook.com (10.175.3.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 06:13:29 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b%2]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 06:13:29 +0000
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
Thread-Index: AQHUYIaFJ/VvvMmSxkC06uIJGGK3pKUsbfoA
Date:   Tue, 23 Oct 2018 06:13:29 +0000
Message-ID: <9DFB7D45-76CD-4E77-8360-FBCE1AD9A78F@fb.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
In-Reply-To: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.100.39)
x-originating-ip: [2620:10d:c090:180::1:e69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1312;20:EZUUYIwgLqv9y6WbDz123211seCGcbhQX0C+tze0c0Mw4w1hmIjb2JDuVHomKrVp83f///Lu0qpZzYIxWv9tFyi+u+uSu13WdiBbd0lxVs0n6CG8UGxQUwdaMu6A61bJsDxEcK9GBrP3ripSkt8lo/aZZF4FegY98qwLZE7Dj/4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6122a318-fed7-4318-a5ad-08d638aea6dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1312;
x-ms-traffictypediagnostic: MWHPR15MB1312:
x-microsoft-antispam-prvs: <MWHPR15MB1312D86062A12391846BBA17B3F50@MWHPR15MB1312.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1312;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1312;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(39860400002)(376002)(199004)(189003)(53754006)(106356001)(5250100002)(76176011)(54906003)(316002)(82746002)(97736004)(105586002)(2900100001)(71190400001)(256004)(478600001)(14444005)(6436002)(2906002)(83716004)(57306001)(4326008)(71200400001)(36756003)(25786009)(476003)(53936002)(53546011)(6506007)(14454004)(305945005)(486006)(7416002)(7736002)(6246003)(68736007)(6306002)(6486002)(11346002)(6916009)(2616005)(446003)(8936002)(8676002)(186003)(102836004)(5660300001)(50226002)(229853002)(33656002)(6512007)(46003)(6116002)(86362001)(99286004)(81166006)(81156014)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1312;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AVGERD/cFD9VrNPDb7L1m57kVvQx82JCBjiG6/s5bpJD6CHipaIkkabow62EvIkm7jvSBws70uGotIq+QGoxdTyyuxocLoSlx82ploYnAPqQEqLdp/cMLzH9J1tocw7HCzmix1gdtLcpKhyIScib30JTxYXka3v+a9hjATvh6ApoON4nRL8uRXsDZG7bGK/95AIo904a5xpb1dAdiYc+CoJat4ByrqB36bblWV4Vl824n902b0TsHwg5mtlRjQY8VahjA/F9TGhyBvHr94NUUH0GiCb1FcKUFODHkNtP2PeMEl1zAiWBwFiZMFS5s9YYBVQbGy+4jlULydYY4al64zmTUDYFntQUjBc51ifqGvc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0ED36860CCE2D9458904174C4E9D8A2B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6122a318-fed7-4318-a5ad-08d638aea6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 06:13:29.2415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1312
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-23_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Oct 10, 2018, at 3:45 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> Hi all,
>=20
> There have been various issues and limitations with the way perf uses
> (task) contexts to track events. Most notable is the single hardware PMU
> task context, which has resulted in a number of yucky things (both
> proposed and merged).
>=20
> Notably:
>=20
> - HW breakpoint PMU
> - ARM big.little PMU
> - Intel Branch Monitoring PMU
>=20
> Since we now track the events in RB trees, we can 'simply' add a pmu
> order to them and have them grouped that way, reducing to a single
> context. Of course, reality never quite works out that simple, and below
> ends up adding an intermediate data structure to bridge the context ->
> pmu mapping.
>=20
> Something a little like:
>=20
>              ,------------------------[1:n]---------------------.
>              V                                                  V
>    perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
>              ^                      ^     |                     |
>              `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
>=20
> This patch builds (provided you disable CGROUP_PERF), boots and survives
> perf-top without the machine catching fire.
>=20
> There's still a fair bit of loose ends (look for XXX), but I think this
> is the direction we should be going.
>=20
> Comments?

This might be a little off topic...

What's you plan about this effort and the PMU sharing work=20
(https://lkml.org/lkml/2018/10/4/10)? Would PMU sharing work better/simpler
with this effort?=20

Thanks,
Song



