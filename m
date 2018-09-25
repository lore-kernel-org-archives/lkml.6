Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23709C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF18920867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="h6igYv/N";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ALWb33UJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF18920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIZBOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:14:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726589AbeIZBOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:14:19 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PIvU5I031482;
        Tue, 25 Sep 2018 12:05:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BAotR4uEh4jEVPYr2tXl/pujq7B+jPC8op1Iel5bYfA=;
 b=h6igYv/NzzoQzT12qnxhKLZWxTpilauDMf3sv++wFtJY1ve84ggnZ9JYgEeCZ53M3j5f
 QpBORamDzr3DqPvPCvTLHgXMRtQR4RLhMm/mg2Kt0BjyqNMeodl/Vd/ilsdVfOYiifYf
 tS0x2wgyiewHRuGJLI+NKb4ot2Mf+nxg6eA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2mqtbfg4pr-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 12:05:21 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 15:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAotR4uEh4jEVPYr2tXl/pujq7B+jPC8op1Iel5bYfA=;
 b=ALWb33UJWdR0XEgXI/27mqZNgoRoYyAsL43SlAGwJLD3wd5W4lgovJ/ntXf8npxVkNfU8D7g7Dv8twr/ISukZC0syq6epENMUCMiKBRk1sJDyz9RbgWn7Y2GZ7VUDL8voVEJsHehbmu5Y0pyVCFfpCI45cwF0VeRDjwECKr/Cbo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1597.namprd15.prod.outlook.com (10.173.235.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Tue, 25 Sep 2018 19:05:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705%7]) with mapi id 15.20.1143.019; Tue, 25 Sep 2018
 19:05:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Roman Gushchin <guro@fb.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 00/10] bpf: per-cpu cgroup local storage
Thread-Topic: [PATCH v2 bpf-next 00/10] bpf: per-cpu cgroup local storage
Thread-Index: AQHUVONzWqXNIP7aqkyUYPLdxeMb76UBW5wA
Date:   Tue, 25 Sep 2018 19:05:17 +0000
Message-ID: <920DCF94-46EF-4969-8C8E-B89E934F3D5E@fb.com>
References: <20180925152114.13537-1-guro@fb.com>
In-Reply-To: <20180925152114.13537-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [199.201.64.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1597;20:5W8+2Z8ayMxlpH5grMAnmPFgiYg2ClrXH53EIGfOhG/3moRhGCEmpCvxAUy2C6FZbwGUViOTdoIZCXvbE0PlBdH88NHkWiBZOI/fp4oBAxLI+5Wh5hFxA6zRcPxtKta4hR/RvEESsRmMBf/AkLplFIODbx8PJWzJdBKIMIN3Xxc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: c1c7dcf5-7db5-447d-065d-08d62319d4fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1597;
x-ms-traffictypediagnostic: MWHPR15MB1597:
x-microsoft-antispam-prvs: <MWHPR15MB15972D1A0AC2F4072935C3D0B3160@MWHPR15MB1597.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:MWHPR15MB1597;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1597;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(4326008)(316002)(97736004)(6246003)(2900100001)(50226002)(14444005)(6862004)(256004)(57306001)(8936002)(5024004)(6636002)(5660300001)(106356001)(36756003)(450100002)(81156014)(81166006)(8676002)(2906002)(14454004)(478600001)(105586002)(7736002)(305945005)(66066001)(6436002)(83716004)(6512007)(6506007)(6486002)(53546011)(476003)(229853002)(82746002)(446003)(486006)(99286004)(11346002)(68736007)(6116002)(2616005)(54906003)(37006003)(71190400001)(53936002)(86362001)(3846002)(33656002)(71200400001)(5250100002)(102836004)(26005)(25786009)(34290500001)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1597;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FZSklSB/hCqqZcAEKb1CcCMu9+jCxHSIR40ES837PTB+gznAORyChnRPo6PaU26KdHCbnsu0siJ8vATEfJlWodcz4I3ZeXivjakUEqjgkhKSjEUw8ctaI9lxWJFAxv77Ht9FE5Bpp9eM8ax98zayyQkxfE32ItKJ8F8q0EQFqqyP1X+uS65L4Z6cfAog7KOhGxLmIST3SCGLO9NnAEQ2FrvnJu6wyrrtLtPx+udHE51+gnf9UYNwrVoTsI+1UOTHifV2aLXopM7a+RFdRGaAYWdtJCThM8QJx5ttUQZ3TlOOJgZOUF470bnHkkG5YI6YcPsUFqYGkjRrlKyliT7nSCTeEhWU13x/trL1YeIBfIQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04A2FB7022D28B4D9377343631C84AAB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c7dcf5-7db5-447d-065d-08d62319d4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 19:05:17.1431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1597
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 25, 2018, at 8:21 AM, Roman Gushchin <guro@fb.com> wrote:
>=20
> This patchset implements per-cpu cgroup local storage and provides
> an example how per-cpu and shared cgroup local storage can be used
> for efficient accounting of network traffic.
>=20
> v2->v1:
>  1) added a selftest implementing network counters
>  2) added a missing free() in cgroup local storage selftest
>=20
> Roman Gushchin (10):
>  bpf: extend cgroup bpf core to allow multiple cgroup storage types
>  bpf: rework cgroup storage pointer passing
>  bpf: introduce per-cpu cgroup local storage
>  bpf: don't allow create maps of per-cpu cgroup local storages
>  bpf: sync include/uapi/linux/bpf.h to tools/include/uapi/linux/bpf.h
>  bpftool: add support for PERCPU_CGROUP_STORAGE maps
>  selftests/bpf: add verifier per-cpu cgroup storage tests
>  selftests/bpf: extend the storage test to test per-cpu cgroup storage
>  samples/bpf: extend test_cgrp2_attach2 test to use per-cpu cgroup
>    storage
>  selftests/bpf: cgroup local storage-based network counters
>=20
> include/linux/bpf-cgroup.h                    |  55 ++++--
> include/linux/bpf.h                           |  12 +-
> include/linux/bpf_types.h                     |   1 +
> include/uapi/linux/bpf.h                      |   1 +
> kernel/bpf/cgroup.c                           |  74 +++++---
> kernel/bpf/helpers.c                          |  25 ++-
> kernel/bpf/local_storage.c                    | 167 +++++++++++++++---
> kernel/bpf/map_in_map.c                       |   3 +-
> kernel/bpf/syscall.c                          |  20 ++-
> kernel/bpf/verifier.c                         |  23 ++-
> net/bpf/test_run.c                            |  20 ++-
> samples/bpf/test_cgrp2_attach2.c              |  19 +-
> tools/bpf/bpftool/map.c                       |   4 +-
> tools/include/uapi/linux/bpf.h                |   1 +
> tools/testing/selftests/bpf/Makefile          |   6 +-
> tools/testing/selftests/bpf/netcnt_common.h   |  23 +++
> tools/testing/selftests/bpf/netcnt_prog.c     |  71 ++++++++
> .../selftests/bpf/test_cgroup_storage.c       |  60 ++++++-
> tools/testing/selftests/bpf/test_netcnt.c     | 153 ++++++++++++++++
> tools/testing/selftests/bpf/test_verifier.c   | 139 ++++++++++++++-
> 20 files changed, 778 insertions(+), 99 deletions(-)
> create mode 100644 tools/testing/selftests/bpf/netcnt_common.h
> create mode 100644 tools/testing/selftests/bpf/netcnt_prog.c
> create mode 100644 tools/testing/selftests/bpf/test_netcnt.c
>=20
> --=20
> 2.17.1
>=20

For 04/10 to 10/10:

Acked-by: Song Liu <songliubraving@fb.com>

