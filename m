Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FF8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864B8222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TPFr9EhP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PEF4hkBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408018AbfBNQl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:41:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49092 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405016AbfBNQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:41:28 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EGe8lG006328;
        Thu, 14 Feb 2019 08:41:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=KPdz73e855N+NeDZITgo6wZDKYSeeAFYIkTCWfsaUEc=;
 b=TPFr9EhP9LO8QuYm2evzCxLCMAgf6LHZ/oAv5epvaKmgZHI9AKNH9uYYQd31iRZDTw5J
 cyi9JcOBo3jOELdGKUZ2eHuesmuls+dHWPphasyrA+Xgxg9fLFzhhBfZ1aqan3KF8Vkq
 apyYLAP0XKdtX47l1ELPzEBBGroWMNxKG7U= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qnawrg9ap-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 08:41:23 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 14 Feb 2019 08:41:07 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 14 Feb 2019 08:41:06 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 14 Feb 2019 08:41:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPdz73e855N+NeDZITgo6wZDKYSeeAFYIkTCWfsaUEc=;
 b=PEF4hkBlFsDENBpmjc/Y7In4d/neXHATSqQYkXRTiCdqKjnY4Sxwi/OPCoklfhryhX1M4qBLac72Pp+Gkp6t68rtQxgPRVfaxwdQj4i4S++ax3gpr8JdL1RDB2QS3p12GPhCysbYJn+KAADampMhAyxzCi9hIGIPy6WsRBMGya8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2744.namprd15.prod.outlook.com (20.179.157.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 16:41:05 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1601.016; Thu, 14 Feb 2019
 16:41:05 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/7] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v6 4/7] cgroup: cgroup v2 freezer
Thread-Index: AQHUmYm/FY3e3nKVvEu5zzs73euDdKXAH4WAgAU1PgCAAvBngIASo7UAgAToDoCAAAQjAA==
Date:   Thu, 14 Feb 2019 16:41:05 +0000
Message-ID: <20190214164100.GA8688@tower.DHCP.thefacebook.com>
References: <20181222000307.28231-1-guro@fb.com>
 <20181222000307.28231-5-guro@fb.com> <20190125122713.GA18218@redhat.com>
 <CALo0P13XnGiFykMXY3ZKu158ZqnBwHru0gyhQUrJSHEprnmiHQ@mail.gmail.com>
 <20190130165200.GA4131@redhat.com>
 <20190211213036.GA26063@tower.DHCP.thefacebook.com>
 <20190214162612.GC19102@redhat.com>
In-Reply-To: <20190214162612.GC19102@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:7cc2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41f7b8f2-1f8e-43ca-79a9-08d6929b3664
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2744;
x-ms-traffictypediagnostic: BYAPR15MB2744:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2744;20:g0KtTycJbzfQZnhtsfavbUFZDQgigjLRwFl3q7M4YDLgqTzKgTmgXE7Z9wy/+DnI3rvLQonRK57RCb4/ByonaYnVfb/ecg/AgCbhvi+FWYIhdDzhTWjR6t+MFFIZxjXORPvS6skzqLGjXK9zBV7uonrBkwk7UEmLsU1SDlNcp9s=
x-microsoft-antispam-prvs: <BYAPR15MB2744C68ECD841A47E30761CDBE670@BYAPR15MB2744.namprd15.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(376002)(396003)(39860400002)(189003)(199004)(6246003)(6506007)(6436002)(54906003)(386003)(316002)(229853002)(6512007)(106356001)(53936002)(6486002)(25786009)(93886005)(6916009)(102836004)(105586002)(2906002)(9686003)(33656002)(186003)(8676002)(81156014)(486006)(7736002)(1076003)(81166006)(476003)(4326008)(68736007)(446003)(33896004)(76176011)(6116002)(46003)(256004)(71200400001)(478600001)(71190400001)(14454004)(8936002)(86362001)(52116002)(11346002)(305945005)(99286004)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2744;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SgTw2t8g0gra4FgVDcoK+THqo/1x7pcuOJu4lctUMjuoZs8/icPRt6WJIEfktAQ7Z7wiUGUyVgV+tRnhpeiZVJnyjRA4KI0pKbPobXmQYTYBYfhHxKkSGUQ30gFgrglZxtm5pN4a4LOqXLsl0mRUFnGb7M1Msf3T7+75n5kAPtwIgFvIWOFJZcqtWGBDsnPJzX7Oq7UfEjMjc45Pacr6ddtQLAlGyvAOW12bBmNV51TUhKqdzfoB8PyiFA40sq0eHQQFk3BRbIWjX6gAlpemG/U23AyphxHCebsBVSDHjoNguS5Ss55lQ/W30PclBhdPaHiZ9xRzoUB48DmVUpw+0moC9ZDMDi9hSDHgxToi2JwiNHag43mmYJuU0GvaP0AA4mLl5Pg3dQBtWRmATrGUrGXzUEmyvyaqr5Wx6oc011Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3889F53817B344196DC0BAE5EFAC3AC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f7b8f2-1f8e-43ca-79a9-08d6929b3664
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 16:41:04.5961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2744
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 05:26:13PM +0100, Oleg Nesterov wrote:
> On 02/11, Roman Gushchin wrote:
> >
> > On Wed, Jan 30, 2019 at 05:52:01PM +0100, Oleg Nesterov wrote:
> > >
> > > Worse, this looks just wrong. In the latter case, cgroup becomes CGRP=
_FROZEN
> > > right after a 2nd task migrates to this cgroup, before this new task =
calls
> > > do_freezer_trap() or cgroup_enter_stopped().
> >
> > You're right. So, it looks like the problem is in the equation
> > nr_tasks_frozen + nr_tasks_stopped =3D=3D nr_tasks_to_freeze ,
> > because a task can be frozen and stopped simultaneously.
> >
> > So, basically it has to be
> > nr_tasks_frozen + nr_tasks_stopped >=3D nr_tasks_to_freeze instead.
>=20
> It seems you didn't read the paragraph above, or I missed something...
>=20
> How can "frozen + stopped >=3D to_freeze" fix the problem with the falsel=
y true
> CGRP_FROZEN ?

It helps with the problem when cgroup is mistakenly reported as non-frozen,
and adding a task makes it frozen due to increased nr_tasks_to_freeze.

But you're right, it's not correct. I have to think more how to make
the accounting work correctly with stopped tasks.

Roman
