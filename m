Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C285C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3072086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ReG69GkX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Xt8e5bks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfBTWBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:01:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46216 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbfBTWBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:01:51 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KLv4rn015266;
        Wed, 20 Feb 2019 14:01:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vhEPKFB/oj8EfoFHOMrNae0jBKCk68arb5bwwFSNXDo=;
 b=ReG69GkXug5aAoN8VT77IziQoOQ8Y9MAe5rGUtl9GvyGweYZmSOvNigc9X+BNPxVJipi
 2+TnYi2yjEHg5NWCKe2boTopJibkrk4urveEOGQIFDMe1Tr5fMJY7JupcudhEk+2lk3x
 oUfqjbcf7nlH91titLMzRk0ZPqh570kDUNo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qsd7e0e9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 14:01:45 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 20 Feb 2019 14:00:29 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 20 Feb 2019 14:00:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhEPKFB/oj8EfoFHOMrNae0jBKCk68arb5bwwFSNXDo=;
 b=Xt8e5bksH3fd/GPGtb71pEsRTnVO6TQXG60DMkcMFq3CMPLyTLRNaTT1TrrbbyAd94K0kTwadg8Ok9rLmNnduwtt4DiWMaqaJS66zpqaXlVnznCsW4klV0KRl0WhJPGWDfCM6/ubc+sdNJsKDG5GkCfXJBg1+0VEbc8S5msrDbA=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2568.namprd15.prod.outlook.com (20.179.155.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 20 Feb 2019 22:00:27 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1601.016; Wed, 20 Feb 2019
 22:00:27 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/7] freezer for cgroup v2
Thread-Topic: [PATCH v8 0/7] freezer for cgroup v2
Thread-Index: AQHUyJ7qFcEHOqSfLUmXX0Bn+RgIf6XownUAgAB7qIA=
Date:   Wed, 20 Feb 2019 22:00:27 +0000
Message-ID: <20190220220020.GA16335@castle.DHCP.thefacebook.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190220143748.GA9477@redhat.com>
In-Reply-To: <20190220143748.GA9477@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::40) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:6aef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4308127-159a-4b01-9ffe-08d6977ed21e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2568;
x-ms-traffictypediagnostic: BYAPR15MB2568:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2568;20:mmIcYkQWBN/GhbdX5OZtw3DPC4ISQtdMOgH8wgUvQAm2JesUhloWbwTQv0o9fpgDfTCuZiqcxkaw9nXZfLpN/rs42udba7J+f8l2ug330ZiIJIBErlTY0GHXp+4R+81W5JTH5EcrNGO7q25h3Pa6pu9S36IOdNV+M/rCqpCKD7M=
x-microsoft-antispam-prvs: <BYAPR15MB2568145F43FE0D007AB8A85CBE7D0@BYAPR15MB2568.namprd15.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(189003)(2906002)(14444005)(1076003)(256004)(4326008)(71200400001)(71190400001)(81156014)(33656002)(8936002)(8676002)(81166006)(186003)(25786009)(6506007)(386003)(53936002)(68736007)(6346003)(33896004)(102836004)(6246003)(5660300002)(6916009)(6512007)(9686003)(106356001)(6486002)(14454004)(6116002)(52116002)(99286004)(86362001)(97736004)(105586002)(76176011)(6436002)(486006)(446003)(46003)(478600001)(11346002)(476003)(316002)(7736002)(305945005)(229853002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2568;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o+WvQKBGbRVEQDMUhhr8Ui4Xl3M0JcppggOpz/jpW34GIVssv9QIVK74fLxh0FyKJhoEDvqefkXOQsG8qnsqSDoD4xeK6vhGmYutfPHNc8UEr7UWdirNF0ob5yvIVzYFqYMUTxhmcVuT7NCWwf7souUZGd8atokO3UmQvJxGIXVY1+mTv9kLac9TFEdn8raiGIH2yqPqpkrhd58xsbGWOIkcH/TsJPawnDJaiySLmEEUQRL4T/w15ElfBx7Sc7BUiTjkOKjmBj3p9/RPD6SIjcg77xl4YBXAh95uu4FxraSiVmt96WFINjdMZDsLFBcip7I9rmg48TBtkH3jyiq999R6iepOQVjiUrLJ6Y7iMLhA1ZEHN3mL694GDZYuz0cCFuH9Sqw7dBFCBRMhH6Qm/tgUs4c5XfL0nejd1vAanw8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EA294F400D2BD4998284D50FB893001@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4308127-159a-4b01-9ffe-08d6977ed21e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 22:00:26.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2568
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:37:48PM +0100, Oleg Nesterov wrote:
> On 02/19, Roman Gushchin wrote:
> >
> > It provides similar functionality as v1 freezer, but the interface
> > conforms to the cgroup v2 interface design principles, and it
> > provides a better user experience: tasks can be killed, ptrace works,
>=20
> I tried to not argue with intent, but to be honest I am more and more
> sceptical... Lets forget about ptrace for the moment.
>=20
> Once again, why do we want a killable freezer?
>=20
> If a user wants to kill a frozen task from CGRP_FROZEN cgroup he can simp=
ly
>=20
> 	1. send SIGKILL to that task
>=20
> 	2. migrate it to the root cgroup.
>=20
> why this doesn't / can't work?

It does work, but it doesn't look as a nice interface to take into
the cgroup v2 world.

It just not clear, why killing a frozen task requires some cgroup-level
operations? It doesn't add anything except some additional complexity
to the userspace. Generally speaking, any process hanging in D-state
for a long time isn't the nicest object from the userspace's point of view.

Exactly as a SIGSTOPped process can be killed without sending SIGCONT,
why a frozen task would require some additional operations?

And I'm not talking about the case, when the process which is sending
SIGKILL has no write access to cgroupfs.


> Why I am starting to argue... The ability to kill a frozen task complicat=
es
> the code, and since cgroup_enter_stopped() (in this version at least) doe=
sn't
> properly interacts with freezable_schedule() leads to other problems.
>=20
> From 7/7:
>=20
> 	+  cgroup.freeze
> 	+	A read-write single value file which exists on non-root cgroups.
> 	+	Allowed values are "0" and "1". The default is "0".
> 	+
> 	+	Writing "1" to the file causes freezing of the cgroup and all
> 	+	descendant cgroups. This means that all belonging processes will
> 	+	be stopped and will not run until the cgroup will be explicitly
> 	+	unfrozen. Freezing of the cgroup may take some time;
>                                                  ^^^^^^^^^^^^^^^^^^
> it may take infinite time.
>=20
> Just suppose that a task does vfork() and this races with cgroup_do_freez=
e(true).
> If the new child notices JOBCTL_TRAP_FREEZE before exit/exec the cgroup w=
ill be
> never frozen.

Hm, why? cgroup_update_frozen() called from cgroup_post_fork() should bring
the cgroup into the frozen state. If it's not true (I'm missing some race h=
ere),
it's a bug, but I don't see why it's not possible in general.

>=20
> If I read the current kernel/cgroup/freezer.c correctly, CGROUP_FREEZING =
should
> "always" work (unless a task hangs in D state) and to me this looks more =
important
> than kill/ptrace support...

Again, I don't see a case, when cgroup v1 freezer will work and the propose=
d
v2 freezer won't work in general.

>=20
> > there is no separate controller, which has to be enabled, etc.
>=20
> agreed, this is nice.

Thanks!
