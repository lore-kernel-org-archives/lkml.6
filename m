Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66BF2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JA5hP/zq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZCRQTY4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfBKVa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:30:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbfBKVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:30:57 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BLQ6oY012174;
        Mon, 11 Feb 2019 13:30:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dAvtRnouoomH/5+FCdXjdiZJP9FTb43GMpkXaL1gt4k=;
 b=JA5hP/zqgslfX+C9Hj6Z7TV9jOwkrn5sv+K3a9R9CNUk3LaKi3amN1hJ94gNCmBY3Szc
 uYcs8O0Yt24OPvsnROvlk51NpdPZt7r35rchsH04wCw8WEk6LyNS0W1W88F0nI4CNfAn
 1gUFjWuQXP46ir5Fod6SSDvtfqCFXWanR/s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qkfpn08he-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 13:30:53 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 11 Feb 2019 13:30:43 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 11 Feb 2019 13:30:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAvtRnouoomH/5+FCdXjdiZJP9FTb43GMpkXaL1gt4k=;
 b=ZCRQTY4nH9dEtQHz0h1m92jg2XRNOwe6V2fIJFZF2Se8hGRw34a+1rXuUP8O2ndOpNcGkpXt5VbkkyYdqwikHgyx+jY0tqvVldx7sLRN5+9Pmv+czw/hPmhZ+osUyr3GY63hhNG7YAhRB+vaZyPKkdDg/YZd5X3zNX0TTfbHxaQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3351.namprd15.prod.outlook.com (20.179.58.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Mon, 11 Feb 2019 21:30:41 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1601.016; Mon, 11 Feb 2019
 21:30:41 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/7] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v6 4/7] cgroup: cgroup v2 freezer
Thread-Index: AQHUmYm/FY3e3nKVvEu5zzs73euDdKXAH4WAgAU1PgCAAvBngIATKdIA
Date:   Mon, 11 Feb 2019 21:30:41 +0000
Message-ID: <20190211213036.GA26063@tower.DHCP.thefacebook.com>
References: <20181222000307.28231-1-guro@fb.com>
 <20181222000307.28231-5-guro@fb.com> <20190125122713.GA18218@redhat.com>
 <CALo0P13XnGiFykMXY3ZKu158ZqnBwHru0gyhQUrJSHEprnmiHQ@mail.gmail.com>
 <20190130165200.GA4131@redhat.com>
In-Reply-To: <20190130165200.GA4131@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0010.prod.exchangelabs.com (2603:10b6:a02:80::23)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:797b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd71d4a4-888a-4e4f-6afc-08d690682c2d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3351;
x-ms-traffictypediagnostic: BYAPR15MB3351:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3351;20:BA9E6z5xmCx/7yKv+GOxt/4lxFIE4JajQRyrBQfs5e67evt86n+5Q+rC2l1gDxYyL4A6hoGt2XlYf4X8QR5skqzWnbUjcWEW3fPv0Qct/KXOYL30gpeAZqAJxUTE+4NLZnYoZ77tEQuH8L87QuzEbe86BmCJT3i2aBMSF+GbA6c=
x-microsoft-antispam-prvs: <BYAPR15MB335169262C2FAB5E8BD009E6BE640@BYAPR15MB3351.namprd15.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(86362001)(106356001)(53936002)(2906002)(229853002)(1076003)(316002)(6436002)(476003)(486006)(93886005)(105586002)(68736007)(11346002)(446003)(54906003)(6506007)(102836004)(8936002)(33896004)(76176011)(8676002)(386003)(33656002)(46003)(256004)(52116002)(71200400001)(71190400001)(6246003)(81166006)(6916009)(186003)(6486002)(6512007)(9686003)(7736002)(14454004)(478600001)(25786009)(305945005)(81156014)(97736004)(4326008)(99286004)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3351;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: My1PP3V+vgnax5x8o25EZ1xuXvdz0ntg/VVnwImLZq5YOeDlu9XaisKahUrFQXZCvm4ZPaJfVGhsxQ/G2VUUZ4dJNuUCKjOMKJfhUt2fUUMVjwawCzei4LMOCQRHOADHF39fy9iuf4lwUiPwvQA42u/acp8vgkfpJrzZIf/s3X4MINY3L6BaDIlFCWiGDGgPTzQcaiTWl0uIOPt7u0ioPniuPBasyZcFp+z2a6lX8kpJMR5fz8tlNuvAZyLlOOMVrxVWuCLE49vr5RH6IordnRmdRjY0v45HPPiMfB1hXKKhZDCW7QSe/GPQ4SWLPgr/45isxxOX+iq5ol4TlUBV9IlEUBmiiloYN4cmV/9/YY5l+Z02hAJdWgH+nWbtR9Gm5SNFoSfYfsXM8absRsA+2M/Gc01Wyo0vGOrwZU6KDRM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5480ACDE97BA074DAD356E05C5290704@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd71d4a4-888a-4e4f-6afc-08d690682c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 21:30:40.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3351
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 05:52:01PM +0100, Oleg Nesterov wrote:
> Hi Roman,
>=20
> On 01/28, Roman Gushchin wrote:
> >
> > Yes, I think you're right: cgroup_exit() should check CGRP_FREEZE bit,
> > not CGRP_FROZEN. Like cgroup_post_fork() does (a one-liner change below=
).

Hi Oleg!

Sorry for the late reply, I was out of work for some time...
Now I'm fully back.

>=20
> but this won't fix all problems? it seems that you missed my other concer=
ns.
>=20
> Firstly, this doesn't look consistent. Suppose a cgroup contains a single
> process sleeping in ptrace_stop(). Then it becomes CGRP_FROZEN right afte=
r
> "echo 1 > cgroup.freeze".
>=20
> OTOH. if this single task sleeps in do_freezer_trap() and gets PTRACE_INT=
ERRUPT,
> it will equally sleep ptrace_stop() but cgroup won't be CGRP_FROZEN. Neve=
r.
>=20
> Worse, this looks just wrong. In the latter case, cgroup becomes CGRP_FRO=
ZEN
> right after a 2nd task migrates to this cgroup, before this new task call=
s
> do_freezer_trap() or cgroup_enter_stopped().

You're right. So, it looks like the problem is in the equation
nr_tasks_frozen + nr_tasks_stopped =3D=3D nr_tasks_to_freeze ,
because a task can be frozen and stopped simultaneously.

So, basically it has to be
nr_tasks_frozen + nr_tasks_stopped >=3D nr_tasks_to_freeze instead.

I'll cover it with an unit test, and will post v7 soon.

>=20
>=20
>=20
> > About spurious transitions (like frozen->non frozen->frozen on a task
> > being SIGKILLed):
> > in early versions of the patchset I've tried to avoid them, but then
> > following the Tejun's advice
> > switched over to expose them to a user. The logic behind is simple: if
> > the state of the cgroup has been changed (a task is gone, for
> > example), let's notify a user.
>=20
> OK, I won't argue...
>=20
> actually I can't argue because I do not really understand why do we want
> a "killable" freezer, let alone ptraceable ;)

So the problem with the frozen state as in cgroup v1 that it's a very
special and "non-natural" task state, which requires special handling
in many places.

Just for an example, we're using oomd (userspace OOM handling daemon),
which selects and kills one of the workloads in case of too high memory
pressure. It should be able to kill all tasks in the selected cgroup,
but we definitely don't want to let it to fiddle with cgroup controls
to unfreeze the cgroup. Etc.

In other words, the cgroup freezer has a simple task of preventing
processes in the given cgroup to consume CPU resources. Unlike the system-w=
ide
freezer, it shouldn't try to make a "snapshot", it just a non-goal.

Thanks!
