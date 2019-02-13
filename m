Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75030C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D6A222A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="m2wSsZof";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iKNVCGoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395024AbfBMWA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:00:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35714 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390000AbfBMWA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:00:26 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DLsmAG009371;
        Wed, 13 Feb 2019 14:00:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qHKCPOrJcNRd8N1tcJ6b89jpPL5eDAmkwvFiz9F1dOI=;
 b=m2wSsZof89XUOoDKH8NHUG1k1onKRWQw2iA0OnITKzgdBAn5CKGLURQOUwiQdpfN0rhD
 M/GiltFJ3ikdFNMISnS1Env/PNl/fYTuD5T3+vgVtk2ESYaxNpr010jYpc7Jv+FqrgIL
 5jvNSaQgx89A8ms71HleV2bXUDsWIXpZjSM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qms4armmc-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 13 Feb 2019 14:00:21 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 13 Feb 2019 14:00:12 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 13 Feb 2019 14:00:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHKCPOrJcNRd8N1tcJ6b89jpPL5eDAmkwvFiz9F1dOI=;
 b=iKNVCGoFcMdVi9wGiN3Y1KErfSJRowBtBBLyDw+sL0NRAHlsYgr8/tP3Y5cPgCRKi+fZQSofmciHyph83cOe6M0jEjhUJFUUM4wzCqMDn8G6lAoZP28Pl0c43PJxYzcy1QIkupf4uZr4dN9Sjta3fT6VbJFupgjoeJPyVN8s75A=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1439.namprd15.prod.outlook.com (10.173.234.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 13 Feb 2019 22:00:10 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 22:00:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [LSF/MM TOPIC] (again) THP for file systems 
Thread-Topic: [LSF/MM TOPIC] (again) THP for file systems 
Thread-Index: AQHUw+d98PJr/f1RW0yrtlybflg8VA==
Date:   Wed, 13 Feb 2019 22:00:10 +0000
Message-ID: <77A00946-D70D-469D-963D-4C4EA20AE4FA@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:f80f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57ec5233-de4e-4423-2a70-08d691fe9fac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1439;
x-ms-traffictypediagnostic: MWHPR15MB1439:
x-ms-exchange-purlcount: 3
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1439;20:hy1n5M+KXnbfYRHZrH+M4PwwePhRQeMxosaf5HpofpptO/oxnWZTFruJH6u813Z6z7Me8LBxvs9bL2+Z6MDEElIJ24TNn/RzQ9qoq8vjoSu08cOtPcmS26VptXLLRcY9HgZ0rK4+E5eL7hmTgyuv1+qvftFemjD7xs5GPQnxCZQ=
x-microsoft-antispam-prvs: <MWHPR15MB14394E936E88F4AD94D3E27CB3660@MWHPR15MB1439.namprd15.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(366004)(39860400002)(346002)(189003)(199004)(2501003)(81166006)(478600001)(6116002)(33656002)(4743002)(966005)(99286004)(57306001)(53936002)(81156014)(8676002)(105586002)(6436002)(7736002)(4326008)(110136005)(106356001)(6486002)(316002)(6306002)(8936002)(83716004)(71200400001)(71190400001)(6512007)(68736007)(102836004)(97736004)(46003)(36756003)(2906002)(2616005)(82746002)(6506007)(305945005)(50226002)(486006)(256004)(25786009)(86362001)(186003)(14454004)(2201001)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1439;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j5JNJSuf3Ta1uW0DAHUEjrTXHZFFekoxIpEMCDEtvdG0invqqin5/4j0fE7vhEmRO4IpuhOF7bTKfm8dwzWSy723uKR3t0Zeo79wA2Y0+hnY/w+XvBFDbisXzWdKogKmbNPU/j79AsFnB4sxNe+dogNYM6cjig5sp4W1UMjS4j5svs/c2O6vlDM8vUzXpp8iyYNLXAWWwSRse6q0A38UxWqwHWfPqYLkr0nWZQ47fDNppnG0/h3ltmmKTg/86J4c8c7qtvQmV9wSUU16dWzD5iR3qMgn5XBfajpqxKCqsLJ4Z6IBx9kUXdA9RPfe1v4/OpipklPCUbGG+dXCLCWnPscdHXRBWlb2LI6uJQPQUI3XNnTTCV61cAFw8ApYb/oeuy91FbYPOkHbPWrX8E6RpGjnYcij/RZ9vWUN9yl05UE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D311F68F799EF74789524BC7643BD169@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ec5233-de4e-4423-2a70-08d691fe9fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 22:00:10.3502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to attend the LSF/MM Summit 2019. I'm interested in topics abo=
ut
BPF, mdraid, and MM. I am a designated reviewer of BPF. I am also helping J=
ens
organize mdraid patches.

I would like to discuss remaining work to bring THP to (non-tmpfs) file sys=
tems.
This topic has been discussed multiple times in previous LSF/MM summits [1]=
[2].
However, there hasn't been much progress since late 2017 (the latest work I=
 can
find is by Kirill A. Shutemov [3]).

We (Facebook) uses THP in many services. We see significant savings by putt=
ing
hot-text on THP. To achieve this with state-of-the-art Linux Kernel, we hav=
e to
either: trick the Kernel to believe certain region is anonymous pages; or p=
ut
the executable in tmpfs. In our case, the tmpfs solution is too expensive.
Therefore, we use a hack to trick the Kernel. This hack breaks other useful
features, e.g. perf symbols and uprobes. Instead of introducing more hacks =
to
use these broken features, it is better to enable THP for file systems.
Therefore, we would like discuss (for one more time) what is needed to brin=
g
THP to file systems like ext4, xfs, btrfs, etc. Once we are aligned on the
direction, we are more than happy to commit time and resource to make it ha=
ppen.

Since this topic is my main focus of this year's summit, I would like an in=
vite
to the MM track.

Thanks,
Song

[1] https://lwn.net/Articles/686690/
[2] https://lwn.net/Articles/718102/
[3] https://kernel.googlesource.com/pub/scm/linux/kernel/git/kas/linux/+/hu=
geext4/wip=
