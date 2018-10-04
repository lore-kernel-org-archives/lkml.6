Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EDAC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E652087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IZyU2xFE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RTevvlhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E652087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJECgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:36:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35892 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727489AbeJECgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:36:39 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w94Jexnr030469;
        Thu, 4 Oct 2018 12:41:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dOzAKMtvYvTZ726T3U490htRAD0LuwXYlh6Yw3VVhUQ=;
 b=IZyU2xFEC69UyeS/gDP7/ArA+3M2KlyMc+8Wgle2LNAAWCcdN7cyEy/YkwvsfgaFo2rC
 pqHYyDqXD5XYVHLG16HfwYTSL8P9QX8ldaVUTYioJmk18ZNcz6XL60p2Hzi8F10qgdUy
 QumfAwba0X7hmLKQBePWAk+BPX4cbecXP0g= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mwpub0efy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 04 Oct 2018 12:41:34 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.11) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 4 Oct 2018 12:41:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOzAKMtvYvTZ726T3U490htRAD0LuwXYlh6Yw3VVhUQ=;
 b=RTevvlhSrPXgwYQdPIJzAuJK4SnoDA/rX9pz3IJB0xh11ZC9XJWhdOh0wRE/+jPpaOLchLgVOFyRlkj6TGt8FP6qlzwf7c24UG1ensvmWbd42+BNW9+pvQvTUUDZ+rUEkCDg8JVrULEC+ArwL4gwF2epgmIERcsQ9GbcmEbdZbY=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0519.namprd15.prod.outlook.com (10.163.110.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Thu, 4 Oct 2018 19:41:28 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba%4]) with mapi id 15.20.1185.024; Thu, 4 Oct 2018
 19:41:28 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
Thread-Topic: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
Thread-Index: AQHUW44iIQrL1y3GVkS1yEfPFUvhJaUPfVsA
Date:   Thu, 4 Oct 2018 19:41:28 +0000
Message-ID: <20181004194123.GA12697@castle.DHCP.thefacebook.com>
References: <20181004025750.498303-1-ast@kernel.org>
 <20181004025750.498303-2-ast@kernel.org>
In-Reply-To: <20181004025750.498303-2-ast@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0011.namprd10.prod.outlook.com (2603:10b6:301::21)
 To BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:e832]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0519;20:pFvTot14ZDCA3HKeHLZwt1s5M4Owih6ruGgDue6FO07scIk4lERXehXrvyDDmPitQTufI0iGgHWV5hfGSgPmtWybXLfNZXpzwHyggr2Ctw8BEKWyJlnT2OR+zZtoGXrgw3OnnaDGyXlsjvuNLG+PEMPJVOZmZL+zuYgT5k9BJFk=
x-ms-office365-filtering-correlation-id: 335c62c2-f000-4089-5f77-08d62a316089
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0519;
x-ms-traffictypediagnostic: BY2PR15MB0519:
x-microsoft-antispam-prvs: <BY2PR15MB0519BF95CAE6BB08437B3C9FBEEA0@BY2PR15MB0519.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302090)(3002001)(93006095)(93001095)(10201501046)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:BY2PR15MB0519;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0519;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(102836004)(76176011)(33896004)(6246003)(25786009)(6512007)(6506007)(54906003)(52116002)(46003)(386003)(86362001)(316002)(4326008)(9686003)(229853002)(6436002)(2900100001)(71190400001)(53936002)(99286004)(71200400001)(478600001)(5250100002)(97736004)(486006)(68736007)(6116002)(11346002)(81166006)(6486002)(14454004)(105586002)(7736002)(14444005)(5024004)(186003)(5660300001)(106356001)(8936002)(476003)(256004)(33656002)(1076002)(81156014)(446003)(6916009)(8676002)(305945005)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0519;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wRoZB+0NPBUA5JLXM/PyoBHSt3ULtOyt+wJ4m+/hubbz56uOCHlG3Lje5wv5ZV1BV+rm6NpNzC4gE0M4k7hSHZeLnhiPlUqw5UgpbxwsxmVnqO14l2z0kgc33OYuTUn/G9kR9kKcWgIv5I0jkLl8q85NzIuJ6v6u2tybSp+i8c1tVHlZah923d/bblXNnNgeUe/w4NpXNccIVGH+bUcawDnolf8838x8dXypx/K3mCNQDrqOSJEHu1zfCe4mhUH/QUniQpDIaxdE7sr9hP6FV0Rj3NxuibbYD8DDM1u4PiwTGeSOUCdPg8YXRp9CVdc8lNKbL6Ft2GpvwGUF5ChIO0IUvs06YtvZXrUkGg4GKQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A6F8AA5A92E6241B856E5749AF84C9A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 335c62c2-f000-4089-5f77-08d62a316089
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 19:41:28.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0519
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 07:57:45PM -0700, Alexei Starovoitov wrote:
> Similar to networking sandboxing programs and cgroup-v2 based hooks
> (BPF_CGROUP_INET_[INGRESS|EGRESS,] BPF_CGROUP_INET[4|6]_[BIND|CONNECT], e=
tc)
> introduce basic per-container sandboxing for file access via
> new BPF_PROG_TYPE_FILE_FILTER program type that attaches after
> security_file_open() LSM hook and works as additional file_open filter.
> The new cgroup bpf hook is called BPF_CGROUP_FILE_OPEN.
>=20
> Just like other cgroup-bpf programs new BPF_PROG_TYPE_FILE_FILTER type
> is only available to root.
>=20
> This program type has access to single argument 'struct bpf_file_info'
> that contains standard sys_stat fields:
> struct bpf_file_info {
>         __u64 inode;
>         __u32 dev_major;
>         __u32 dev_minor;
>         __u32 fs_magic;
>         __u32 mnt_id;
>         __u32 nlink;
>         __u32 mode;     /* file mode S_ISDIR, S_ISLNK, 0755, etc */
>         __u32 flags;    /* open flags O_RDWR, O_CREAT, etc */
> };

It's probably nice to have file uid/gid as well.

Thanks!
