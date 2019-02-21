Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29393C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0603207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kvR70Btw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KcDSTjXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfBUWoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:44:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47054 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbfBUWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:44:08 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1LMZPSf021726;
        Thu, 21 Feb 2019 14:44:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=s1MXrnL7uro4t+iPYg88is8usA52Zxw7e4MQw6xasYI=;
 b=kvR70Btw4jDwGqhIxSBGtEY4vY6Al1KzBWqYlfq4/Bh1QXqIq4tFyLGzV2eP9YCQ46Z8
 IeAnPfZb6Xj1ivS0hWIYku+9EaKn2ue1OcnsMYc/c/dKgORYloQoFoHl1bfnCVdmOqVS
 2HKEMyaeP6AsZnlTqt9FpDmumN974MIjgGc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2qt1nsrqcf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Feb 2019 14:44:03 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 21 Feb 2019 14:44:00 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 21 Feb 2019 14:44:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1MXrnL7uro4t+iPYg88is8usA52Zxw7e4MQw6xasYI=;
 b=KcDSTjXiyjQt9Bzi85eyqnLxqrNM73i5dE12E+HHY7RI7fmYUJ2WlNVnNP8XfZ2is9XmViGVpFvOp78uIZP0GQQU99JrFdppnwZ+ZtaWLEhVyep19RkHsTvvsR2uP1dIwYGMLLfNidZzK0XBF5gSGDMZ1/16H7pkwkYf0pD5Uwo=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2599.namprd15.prod.outlook.com (20.179.155.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.20; Thu, 21 Feb 2019 22:43:58 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 22:43:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/7] freezer for cgroup v2
Thread-Topic: [PATCH v8 0/7] freezer for cgroup v2
Thread-Index: AQHUyJ7qFcEHOqSfLUmXX0Bn+RgIf6XownUA///1igCAAbv5AIAAaKOA
Date:   Thu, 21 Feb 2019 22:43:58 +0000
Message-ID: <20190221224352.GA24252@tower.DHCP.thefacebook.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190220143748.GA9477@redhat.com>
 <20190220220020.GA16335@castle.DHCP.thefacebook.com>
 <20190221162923.GA26064@redhat.com>
In-Reply-To: <20190221162923.GA26064@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0053.prod.exchangelabs.com (2603:10b6:a03:94::30)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:b358]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bff3a483-cdad-4642-b32b-08d6984e110a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2599;
x-ms-traffictypediagnostic: BYAPR15MB2599:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2599;20:bKhb06VDFllUVVIue4k9xusWbDFmUPE/A7hFw3fDxSht0z8S/OJU10ilR6wLxW4/OGN9seQwB1rUFlqXQ2DHtbts0csJWklIpdOBBxgmjJbc5E0CoKjNdIQ5y3hlTggu7jCQxyv+Ew89cfSwjvRpxWWqZzTxhcxPrtaF6jVAafM=
x-microsoft-antispam-prvs: <BYAPR15MB2599E6171E17E943109F671BBE7E0@BYAPR15MB2599.namprd15.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(97736004)(6246003)(86362001)(186003)(9686003)(102836004)(76176011)(229853002)(81156014)(8676002)(71200400001)(6512007)(106356001)(316002)(7736002)(52116002)(99286004)(6486002)(2906002)(305945005)(53936002)(8936002)(6436002)(33896004)(81166006)(71190400001)(25786009)(33656002)(54906003)(386003)(446003)(93886005)(46003)(11346002)(14454004)(1076003)(6116002)(4326008)(6916009)(476003)(256004)(6506007)(486006)(14444005)(105586002)(5660300002)(68736007)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2599;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u76gwcJpYfTsxjHz6NIy8uCNKI7+ffKRfFuFHAGLW5Ad4I6N5yluUkh1XQqlth2gev3mdDPkPijs1xOZvLwivAQcVxkgRic9AKYUg9dqo8/bWXNhwoFkzoim9dWH02y+AKXaS3p0fsVZHghkJ9RNyvbkZJtfifrmiBJMYO9YbXsYxgTIQ3FazCZs1hAmGHhKBVrKfcp3pU0FuwnZov7SBg6oH4wuWVRey+GDJXpoNZ56ERhtJTnB0CF0ytRHXO5rwilg9XnWHPl8qd8/DjUyPA8DDZbkXhCq/8Gd/yvabI2gWWo/Jq6k0bQoDlgG9mYXpbhchggOrJkL9n+kYo6m3LDNyTfG2ZNTSv42j7guCzFhckwHvDfhaW6kijwO6bBBl84BGRUtw5rCoTnTsXUxXdCvTeWnnuzkS9E3TydfpVE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A383B398F6CA64290A21DCCD68EC6D3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bff3a483-cdad-4642-b32b-08d6984e110a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 22:43:57.6786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2599
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:29:24PM +0100, Oleg Nesterov wrote:
> On 02/20, Roman Gushchin wrote:
> >
> > On Wed, Feb 20, 2019 at 03:37:48PM +0100, Oleg Nesterov wrote:
> > >
> > > I tried to not argue with intent, but to be honest I am more and more
> > > sceptical... Lets forget about ptrace for the moment.
> > >
> > > Once again, why do we want a killable freezer?
> > >
> > > If a user wants to kill a frozen task from CGRP_FROZEN cgroup he can =
simply
> > >
> > > 	1. send SIGKILL to that task
> > >
> > > 	2. migrate it to the root cgroup.
> > >
> > > why this doesn't / can't work?
> >
> > It does work, but it doesn't look as a nice interface to take into
> > the cgroup v2 world.
> >
> > It just not clear, why killing a frozen task requires some cgroup-level
> > operations? It doesn't add anything except some additional complexity
> > to the userspace.
>=20
> Yes.
>=20
> But to me this is a reasonable trade-off because this way we do not add
> additional complexity to the kernel.
>=20
> Actually, "killable" is not that difficult afaics. "ptraceable" looks mor=
e
> problematic to me. Again, user-space can do
>=20
> 	1. PTRACE_SEIZE
> 	2. move the tracee to the root cgroup
> 	3. do anything with the tracee
> 	4. move it back
>=20
> > Generally speaking, any process hanging in D-state
> > for a long time isn't the nicest object from the userspace's point of v=
iew.
>=20
> Roman, this is unfair comparison ;)

Why not? This is exactly the point, with v1 freezer you get a task in D sta=
te,
which isn't manageable by userspace without some actions with sysfs.

>=20
> > Exactly as a SIGSTOPped process can be killed without sending SIGCONT,
> > why a frozen task would require some additional operations?
>=20
> this too,
>=20
> > And I'm not talking about the case, when the process which is sending
> > SIGKILL has no write access to cgroupfs.
>=20
> True.
>=20
> But there is another case. If admin wants to freeze a cgroup then it is n=
ot
> clear why a user which can send SIGKILL to a frozen process should wake i=
t up.

But it will woken up only for a short moment. And the cgroup will remain fr=
ozen
in a sense that belonging processes do not consume CPU.
Actually, a signal can be useful: for example, if it was the last process,
the container management software might want to delete the cgroup.

>=20
> -------------------------------------------------------------------------=
-----
> Again, it is not that I hate the idea of killable/ptraceable freezer. Jus=
t I
> personally think it's not worth the trouble. Perhaps I am wrong, but so f=
ar
> I do not see a good implementation...
>=20
> And, apart from reading/writing the registers, what can ptrace do with a =
frozen
> tracee? This doesn't look like a "must have" feature to me.

I think the minimal requirement is that the tracing application should not =
hang
and wait for tracee to be unfrozen.
So, imagine you're trying to debug an application in production with gdb,
and occasionally gdb just hangs because some cluster management stuff froze
the tracee's cgroup. Not the best user experience.

>=20
> At least, may I ask you again to make (if possible) a separate patch whic=
h adds
> the ability to kill/ptrace?

I'll try, but not sure if it can make the code easier for review.
It looks like this ability defines the implementation.

> -------------------------------------------------------------------------=
-----
>=20
> > > Why I am starting to argue... The ability to kill a frozen task compl=
icates
> > > the code, and since cgroup_enter_stopped() (in this version at least)=
 doesn't
> > > properly interacts with freezable_schedule() leads to other problems.
> > >
> > > From 7/7:
> > >
> > > 	+  cgroup.freeze
> > > 	+	A read-write single value file which exists on non-root cgroups.
> > > 	+	Allowed values are "0" and "1". The default is "0".
> > > 	+
> > > 	+	Writing "1" to the file causes freezing of the cgroup and all
> > > 	+	descendant cgroups. This means that all belonging processes will
> > > 	+	be stopped and will not run until the cgroup will be explicitly
> > > 	+	unfrozen. Freezing of the cgroup may take some time;
> > >                                                  ^^^^^^^^^^^^^^^^^^
> > > it may take infinite time.
> > >
> > > Just suppose that a task does vfork() and this races with cgroup_do_f=
reeze(true).
> > > If the new child notices JOBCTL_TRAP_FREEZE before exit/exec the cgro=
up will be
> > > never frozen.
> >
> > Hm, why? cgroup_update_frozen() called from cgroup_post_fork() should b=
ring
> > the cgroup into the frozen state. If it's not true (I'm missing some ra=
ce here),
> > it's a bug, but I don't see why it's not possible in general.
>=20
> A task P calls vfork() and creates the new child C. Now, how can the pare=
nt P
> (which sleeps in TASK_KILLABLE) call cgroup_enter_stopped() ? It can't un=
til C
> exits or execs. C can't exit or exec because it is frozen.

Got it. I'll address it in the next version.

Thanks!
