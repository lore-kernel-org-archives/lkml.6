Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96CA20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OCbyMIGh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JQYoPZq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96CA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeJ3Do0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:44:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35402 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729186AbeJ3DoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:44:25 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9TIs8qM011772;
        Mon, 29 Oct 2018 11:54:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=A0YTgjvwcRlN8Xcu796ORSYbZ44P5hGjw6Z1RAlUH2Q=;
 b=OCbyMIGhOtc3+b4LfbFM28xtJrMIKzw6HJAqUzNdBMINV6skBmawUihgobOp9soVh+by
 FpgPVCbvYjpNJeMjuUkFtA8WNiu5kIVbjQr9G4TXQfqV7iDD0NG1tkhPS3lx5Reu3EUn
 797+KrGrN+ROpQql/KhKcpEbcGVjmQ9WHM0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ne6hv8cu3-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 29 Oct 2018 11:54:23 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 29 Oct 2018 11:54:21 -0700
Received: from FRC-CHUB10.TheFacebook.com (2620:10d:c021:18::29) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 29 Oct 2018 11:54:21 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 29 Oct 2018 14:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0YTgjvwcRlN8Xcu796ORSYbZ44P5hGjw6Z1RAlUH2Q=;
 b=JQYoPZq+EIzQXT+q5T3jzCQI6gkLYFwm5yacrtu4Pj98zlivqIvpIqChGdVl1dSLGiEk98jAWWb5lTr1vnU/81SZEPWHuMNheB5GEIuR+ZW7udE4OA8RJ6aBE4CZ31e/VCfk+5mfRY1AAcJyYCgLKXXy8zgEWjhbLCGqqu176rM=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0405.namprd15.prod.outlook.com (10.163.109.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Mon, 29 Oct 2018 18:54:19 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 18:54:19 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Mike Galbraith <efault@gmx.de>
CC:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: memcg oops:
 memcg_kmem_charge_memcg()->try_charge()->page_counter_try_charge()->BOOM
Thread-Topic: memcg oops:
 memcg_kmem_charge_memcg()->try_charge()->page_counter_try_charge()->BOOM
Thread-Index: AQHUb0zSAmWtK7c9EUKkZgGOS7uZCqU2NcCAgAA2fwCAACa6gA==
Date:   Mon, 29 Oct 2018 18:54:19 +0000
Message-ID: <20181029185412.GA15760@tower.DHCP.thefacebook.com>
References: <1540792855.22373.34.camel@gmx.de>
 <20181029132035.GI32673@dhcp22.suse.cz> <1540830938.10478.4.camel@gmx.de>
In-Reply-To: <1540830938.10478.4.camel@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:300:6c::32) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:843]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0405;20:zYJY/j05bfb01tivFhBwErpgvnNuaUYzM5x+Zm/2jWe/6v6C5kyUmoDe6Fa7szuR6VQ7IJ8N8Pbyl2RZ5aCv3/JUMuJ90O9JikB6RLLflxn4HM/ygsFVfEbs69+KziJVZi54PvWxR8/aiWMv/QkAoTawfER9N//Wv7iDHQUsNJ4=
x-ms-office365-filtering-correlation-id: cc88b4c5-47e4-417b-9b70-08d63dcfee5b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0405;
x-ms-traffictypediagnostic: BY2PR15MB0405:
x-microsoft-antispam-prvs: <BY2PR15MB0405459AD6BF6CB05679D224BEF30@BY2PR15MB0405.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0405;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0405;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(346002)(39860400002)(396003)(199004)(189003)(46003)(5660300001)(2906002)(8936002)(33656002)(81156014)(8676002)(229853002)(25786009)(316002)(6246003)(81166006)(54906003)(9686003)(39060400002)(106356001)(105586002)(68736007)(6436002)(6486002)(4326008)(6512007)(71190400001)(53936002)(71200400001)(1076002)(486006)(6916009)(2900100001)(11346002)(446003)(97736004)(102836004)(14444005)(345774005)(256004)(5250100002)(476003)(99286004)(6506007)(386003)(33896004)(52116002)(76176011)(4001150100001)(7736002)(14454004)(186003)(478600001)(86362001)(575784001)(305945005)(6116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0405;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZEyle5N/YUVXrcfqLpZ/WEqsU16pf+LpleRTl6keRxVk6yOioAcO1yCleE0z2UR+U19gSjrxJMPBcLBo8KIqdJNFvo3yYTxJ/2bDdJCQCdVl5PsePAW3U+nb085ImcmGqAPiEevgnvHM0z8IZ6Bbgl29QuWt45sjw9fp2rgUPcT2oirFZKGpJOR+R3MbjAXXVb+OH7W210H8nzjgKQ63BZc2LmsYJV1VhPvOIILqP7mYUeLo2mLMzwTGHcZ1LYWKkVTAyyyqiBh2u4vmV/oN08fxWi7aYTAg63SD/BpdlqL1Y1hyxYlwsQrYGmUQFSfEkhPtToZ8iL+iGSjx/OtTjquj0rHjzZviNr9cdAE9IsY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73B5251FB95436468B032E02371FF7A6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc88b4c5-47e4-417b-9b70-08d63dcfee5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 18:54:19.2104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-29_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 05:35:38PM +0100, Mike Galbraith wrote:
> On Mon, 2018-10-29 at 14:20 +0100, Michal Hocko wrote:
> >=20
> > > [    4.420976] Code: f3 c3 0f 1f 00 0f 1f 44 00 00 48 85 ff 0f 84 a8 =
00 00 00 41 56 48 89 f8 41 55 49 89 fe 41 54 49 89 d5 55 49 89 f4 53 48 89 =
f3 <f0> 48 0f c1 1f 48 01 f3 48 39 5f 18 48 89 fd 73 17 eb 41 48 89 e8
> > > [    4.424162] RSP: 0018:ffffb27840c57cb0 EFLAGS: 00010202
> > > [    4.425236] RAX: 00000000000000f8 RBX: 0000000000000020 RCX: 00000=
00000000200
> > > [    4.426467] RDX: ffffb27840c57d08 RSI: 0000000000000020 RDI: 00000=
000000000f8
> > > [    4.427652] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffb=
278410bc000
> > > [    4.428883] R10: ffffb27840c57ed0 R11: 0000000000000040 R12: 00000=
00000000020
> > > [    4.430168] R13: ffffb27840c57d08 R14: 00000000000000f8 R15: 00000=
000006000c0
> > > [    4.431411] FS:  00007f79081a3940(0000) GS:ffff92a4b7bc0000(0000) =
knlGS:0000000000000000
> > > [    4.432748] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    4.433836] CR2: 00000000000000f8 CR3: 00000002310ac002 CR4: 00000=
000001606e0
> > > [    4.435500] Call Trace:
> > > [    4.436319]  try_charge+0x92/0x7b0
> > > [    4.437284]  ? unlazy_walk+0x4c/0xb0
> > > [    4.438676]  ? terminate_walk+0x91/0x100
> > > [    4.439984]  memcg_kmem_charge_memcg+0x28/0x80
> > > [    4.441059]  memcg_kmem_charge+0x88/0x1d0
> > > [    4.442105]  copy_process.part.37+0x23a/0x2070
> >=20
> > Could you faddr2line this please?
>=20
> homer:/usr/local/src/kernel/linux-master # ./scripts/faddr2line vmlinux c=
opy_process.part.37+0x23a
> copy_process.part.37+0x23a/0x2070:
> memcg_charge_kernel_stack at kernel/fork.c:401
> (inlined by) dup_task_struct at kernel/fork.c:850
> (inlined by) copy_process at kernel/fork.c:1750
>=20
> I bisected it this afternoon, and confirmed the result via revert.
>=20
> 9b6f7e163cd0f468d1b9696b785659d3c27c8667 is the first bad commit
> commit 9b6f7e163cd0f468d1b9696b785659d3c27c8667
> Author: Roman Gushchin <guro@fb.com>
> Date:   Fri Oct 26 15:03:19 2018 -0700
>=20
>     mm: rework memcg kernel stack accounting


Hi Mike!

Thank you for the report!

Do you see it reliable every time you boot up the machine?
How do you run kvm? Is there something special about your cgroup setup?

I've made several attempts to reproduce the issue, but haven't got anything
so far. I've used your config, and played with different cgroups setups.

Do you know where in the page_counter_try_charge() it fails?

Also, can you, please, check if the following patch mitigates the problem?

Thanks!

--

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 54920cbc46bf..a7d6e95450f8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2597,6 +2597,9 @@ int memcg_kmem_charge(struct page *page, gfp_t gfp, i=
nt order)
                return 0;
=20
        memcg =3D get_mem_cgroup_from_current();
+       if (!memcg)
+               return 0;
+
        if (!mem_cgroup_is_root(memcg)) {
                ret =3D memcg_kmem_charge_memcg(page, gfp, order, memcg);
                if (!ret)
