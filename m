Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC3DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD96920666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kSJ5fVWZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dvYwEr9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD96920666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeI1VJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:09:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52366 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbeI1VJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:09:46 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SEhKse016425;
        Fri, 28 Sep 2018 07:45:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=0gR48aqTBe8eEaHS2zyEsCmu43/pMjIBdRsCNGr/vb4=;
 b=kSJ5fVWZN3CP2o310WgZNLscoj70NzxsJaWJQTFl0Y1yfAlArIZnRFZkmZ4o9A064SVw
 llE4VDYhCy4tKp4htJEx93laigr2gAdDqoeR1HfAnmRM6oGxXAOWB8vrsr5ijPcnKFpB
 aP+CH1F+rtN++ZRkOxxA/7P101d/HqM+3rE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msj270u77-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:45:38 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.11) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 07:45:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gR48aqTBe8eEaHS2zyEsCmu43/pMjIBdRsCNGr/vb4=;
 b=dvYwEr9K5DuQr2kzVXwE7wEOGnP4Zgq6HJ5zXPpfep5BPyGlc611W5EYe+CZHC971/xkqsslb1A55fWE2Z3OtQw5Gw0bXmKWZWoMBB2J3qyMolHXH35Qy/6FhZAVkRvNFkHh9PqpMA21jjAVTu/iyLv2roWdXsKW8gy8XsNPfrU=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0887.namprd15.prod.outlook.com (10.164.171.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 14:45:33 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.027; Fri, 28 Sep 2018
 14:45:33 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v4 bpf-next 00/10] bpf: per-cpu cgroup local storage
Thread-Topic: [PATCH v4 bpf-next 00/10] bpf: per-cpu cgroup local storage
Thread-Index: AQHUVznpM/+bbBDgpk+UxyzrsVEbfA==
Date:   Fri, 28 Sep 2018 14:45:33 +0000
Message-ID: <20180928144452.5284-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0022.eurprd04.prod.outlook.com
 (2603:10a6:209::35) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c092:180::1:8a29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0887;20:2O4v2nObELrAsY0JdIhWRF1LxwcOdXzqAuJV2h4NAjVGO5nXW0KD82Tow3QJlPHrSsvALZ07oVBfs5FBZPROmopHHJDi/HT7kiEj7bJxw9XzGko3O41N5Ie3mC0AAm+Ht3MMkWJYVbnm6SSQnLSbkdVtjkbvBOGAz6CKQafVfsY=
x-ms-office365-filtering-correlation-id: 7a241bf4-2a3f-4db6-50e4-08d625510b22
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0887;
x-ms-traffictypediagnostic: BY2PR15MB0887:
x-microsoft-antispam-prvs: <BY2PR15MB0887A7D37454833DFCF7BFFFBEEC0@BY2PR15MB0887.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR15MB0887;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0887;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(6916009)(476003)(2616005)(5640700003)(6486002)(7736002)(305945005)(1076002)(54906003)(6436002)(486006)(97736004)(46003)(53936002)(6512007)(386003)(6506007)(2906002)(5024004)(14444005)(256004)(5660300001)(102836004)(34290500001)(86362001)(52116002)(186003)(99286004)(6116002)(36756003)(71190400001)(71200400001)(8936002)(81166006)(8676002)(1730700003)(81156014)(68736007)(2900100001)(316002)(4326008)(450100002)(5250100002)(2501003)(106356001)(105586002)(478600001)(25786009)(14454004)(2351001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0887;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /CrkwUXT5fQ2biz6W6Nf7wVRf/9rbV0dx/hXmSLg49viQ2W/fTzIl1fpocWpXo232U0O4gBwDk7mF14NXUwxTwgsOmLLZGAafk8Ff/eZv3KoRFvyJGNn5/+6AC2tTAmkBa6N0KaFvb6KlzZcwkYiCiB5n6l+Jyry/l+FLNp/kasA2gl5a/6dvMa7xcMX74BVDIKUzOpOyLJoROS1om2N2oUyD2x6xmgjubfOCG3nO5guZQe3EMX5Azp7EALJpaI+ulD+bOa/bPhMeTv1SLhj/8pUCbU1lWzcsWj43PaNEI3eazIlCMBcqaIqHMN6WkglSSbn427ava0ycvHiSxXPsT5s9NXRnxRVbPTadhAI98k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a241bf4-2a3f-4db6-50e4-08d625510b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:45:33.7678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0887
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements per-cpu cgroup local storage and provides
an example how per-cpu and shared cgroup local storage can be used
for efficient accounting of network traffic.

v4->v3:
  1) incorporated Alexei's feedback

v3->v2:
  1) incorporated Song's feedback
  2) rebased on top of current bpf-next

v2->v1:
  1) added a selftest implementing network counters
  2) added a missing free() in cgroup local storage selftest

Roman Gushchin (10):
  bpf: extend cgroup bpf core to allow multiple cgroup storage types
  bpf: rework cgroup storage pointer passing
  bpf: introduce per-cpu cgroup local storage
  bpf: don't allow create maps of per-cpu cgroup local storages
  bpf: sync include/uapi/linux/bpf.h to tools/include/uapi/linux/bpf.h
  bpftool: add support for PERCPU_CGROUP_STORAGE maps
  selftests/bpf: add verifier per-cpu cgroup storage tests
  selftests/bpf: extend the storage test to test per-cpu cgroup storage
  samples/bpf: extend test_cgrp2_attach2 test to use per-cpu cgroup
    storage
  selftests/bpf: cgroup local storage-based network counters

 include/linux/bpf-cgroup.h                    |  55 ++++--
 include/linux/bpf.h                           |  12 +-
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/cgroup.c                           |  74 +++++---
 kernel/bpf/helpers.c                          |  25 ++-
 kernel/bpf/local_storage.c                    | 169 +++++++++++++++---
 kernel/bpf/map_in_map.c                       |   3 +-
 kernel/bpf/syscall.c                          |  20 ++-
 kernel/bpf/verifier.c                         |  23 ++-
 net/bpf/test_run.c                            |  20 ++-
 samples/bpf/test_cgrp2_attach2.c              |  19 +-
 tools/bpf/bpftool/map.c                       |   4 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/netcnt_common.h   |  24 +++
 tools/testing/selftests/bpf/netcnt_prog.c     |  71 ++++++++
 .../selftests/bpf/test_cgroup_storage.c       |  60 ++++++-
 tools/testing/selftests/bpf/test_netcnt.c     | 158 ++++++++++++++++
 tools/testing/selftests/bpf/test_verifier.c   | 139 +++++++++++++-
 20 files changed, 786 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/netcnt_common.h
 create mode 100644 tools/testing/selftests/bpf/netcnt_prog.c
 create mode 100644 tools/testing/selftests/bpf/test_netcnt.c

--=20
2.17.1

