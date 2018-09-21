Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCDCECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB2E21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WrEA9GpW";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PExiF6df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB2E21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbeIUXEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:04:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51500 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390693AbeIUXEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:04:24 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LHBpxZ022957;
        Fri, 21 Sep 2018 10:14:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=pEeW3T+PVOJbwSJkEIsdn93AJfVx5qK1KzTqFxZ01UY=;
 b=WrEA9GpW+ol8VyYeRUQWQKjpK59chH4xKbFRBUczttARlDvKDzJKtb421JRpoHWbw9Hw
 O4U+wD4OiddlaJku+tto56crhby556ljX6AVsLeMqCJnjr7sYCHOHwXg+G7pt6ZSmpm1
 gmj3FFjYa0V+9yMX7G6ixiExh8jFIo73ooY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mn2g88emj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 10:14:15 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 21 Sep 2018 13:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEeW3T+PVOJbwSJkEIsdn93AJfVx5qK1KzTqFxZ01UY=;
 b=PExiF6dfi4n5tjtmImjfl9WZ0+mO5MQGnMAirRz61jALqaqS0zlZdIa8ZS5WJGmD5Cukblj0ThY+x5MixpW+vefvBs2j4kbQYnBDsV0xSvTMVrtXK9L5qcnNfViAPKrrHzfHxhVcTWnLufR//rKkkIOf/PMB1hvLTYNg6vvMMmw=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0327.namprd15.prod.outlook.com (10.163.65.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.14; Fri, 21 Sep 2018 17:14:12 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 17:14:12 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 5/9] bpf: sync include/uapi/linux/bpf.h to
 tools/include/uapi/linux/bpf.h
Thread-Topic: [PATCH bpf-next 5/9] bpf: sync include/uapi/linux/bpf.h to
 tools/include/uapi/linux/bpf.h
Thread-Index: AQHUUc6DXJ7WuUXj6keJJGY/auNkYg==
Date:   Fri, 21 Sep 2018 17:14:11 +0000
Message-ID: <20180921171353.11050-5-guro@fb.com>
References: <20180921171353.11050-1-guro@fb.com>
In-Reply-To: <20180921171353.11050-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0052.namprd10.prod.outlook.com
 (2603:10b6:300:2c::14) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:15ea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0327;20:vhZlsh4IqgeThdMuLpzAZhQN0ht6DW5Q6M5CdFgi08Vo/vk8opCEvj/ThXSAnQ4lbxT+PWfC2pMmLUgicbeSy3C67nErgMkJYTmEz9iNPbkRwYrHsg2mNgzfDAHng3TeS+ztyGI03osqESwnCeJ0jh10RZvDGkiuCxyaoD5skOE=
x-ms-office365-filtering-correlation-id: c0ea2d08-beb2-4020-c7a3-08d61fe5a618
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0327;
x-ms-traffictypediagnostic: BY2PR15MB0327:
x-microsoft-antispam-prvs: <BY2PR15MB0327199796F9B0E36AE595ABBE120@BY2PR15MB0327.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:BY2PR15MB0327;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0327;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(1730700003)(2616005)(446003)(186003)(36756003)(5250100002)(256004)(68736007)(54906003)(6486002)(53936002)(81166006)(5640700003)(81156014)(8676002)(6512007)(8936002)(305945005)(105586002)(386003)(6916009)(2501003)(106356001)(316002)(7736002)(1076002)(4326008)(99286004)(478600001)(46003)(6436002)(2351001)(6346003)(14444005)(2900100001)(11346002)(76176011)(52116002)(102836004)(25786009)(14454004)(2906002)(5660300001)(97736004)(6506007)(86362001)(486006)(476003)(6116002)(71190400001)(71200400001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0327;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nBKAob2kFGz9XYWFiElNF2OEs7JkE9whF5Pa/6HBRLUtzgvo/y3+5oIaMa2zn+mL/JxSkzIy/5vUAUHZkkjGpYzd5Orf1S22lFMZXXuyFOq+HOC+8GD5YS7xk0H/Xi2rPv5KwoZls55L/TaU0OhWTJOX2k0fMF37YY0aRvq1BjHtuW7p25KkzyOZFSSNeeQ52cTF58oGF5wm/tdIR9Qi7FwjHlfIqxpfZYkVu5nVrvyeaeDMZRjjIL7eMSOIbKZoZZWRxMB5JuIjy8yX1uIuHE/J3FpSJxBEiX0ImT3L9QukMmz64dyzQkFeQI2JyRWMvLunjoWdPkgFwiyiWwIlxxo0/yi3L4GJwpphWUN61I0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ea2d08-beb2-4020-c7a3-08d61fe5a618
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 17:14:11.9586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0327
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync is required due to the appearance of a new map type:
BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, which implements per-cpu
cgroup local storage.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index aa5ccd2385ed..e2070d819e04 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -127,6 +127,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_SOCKHASH,
 	BPF_MAP_TYPE_CGROUP_STORAGE,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 };
=20
 enum bpf_prog_type {
--=20
2.17.1

