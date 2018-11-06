Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6F6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47FD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qepgSSly";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ELtKdTQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47FD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbeKGGki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:40:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36474 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388465AbeKGGki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:40:38 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA6LAjJT020560;
        Tue, 6 Nov 2018 13:12:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YM+92AU8aTHIYzV+ZrCGkRA7YQ68Cx555OKPCBbh0DU=;
 b=qepgSSlyxuz+CQQvD2zHVaPolXE1W616EMoecsnvdU/QdhiLKxAnlHCIbcMh7YS8piZy
 Nl+V+3Kbf6re0PMG1Mynjp/Q3DEz+lvcuioKHO80QpwNh/NiuYE6D9mMvNSkOJeblQNa
 s8wzu14q1fTAn9aUvQ8pn0HaCgao2quIoeM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nkjn00064-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Nov 2018 13:12:52 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 6 Nov 2018 13:12:38 -0800
Received: from PRN-CHUB14.TheFacebook.com (2620:10d:c081:35::23) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 6 Nov 2018 13:12:38 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 6 Nov 2018 13:11:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM+92AU8aTHIYzV+ZrCGkRA7YQ68Cx555OKPCBbh0DU=;
 b=ELtKdTQvqxXYnRc5a7RRUCiWuXS/XULSbkZQnhzqNiE93arhL801clace+QJ1aW4hyuaE5XGTpb5zQrQpD90NGOjMqWfmQdFsIGGugCrg+fiDC+egrcXYBJ/AhK8CSm+gh9hDaW0oo54/RV4RAHHda0fw3Vsoz3F3FGxhSs66F8=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2341.namprd15.prod.outlook.com (52.135.197.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 21:11:20 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1%2]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 21:11:20 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 4/5] perf util: introduce bpf_prog_info_event
Thread-Topic: [RFC perf,bpf 4/5] perf util: introduce bpf_prog_info_event
Thread-Index: AQHUdhL9Dzfw4SmHqEm2pHtablALcaVDPlwA
Date:   Tue, 6 Nov 2018 21:11:19 +0000
Message-ID: <e6003688-8a9e-5845-97d4-c4c59b53815d@fb.com>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-5-songliubraving@fb.com>
In-Reply-To: <20181106205246.567448-5-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0057.namprd22.prod.outlook.com
 (2603:10b6:300:12a::19) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:62d8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2341;20:Okv87S3w4Z7BAHaJj+hJoBP1kNZiBZaHEmuzOP5ssAR5qhG8mJvQIKk0JmvhUtqnkUyMjQ7no/xMLZjJj/tD7uWj5MKDNyQU0q6U9BeeTYs2FZ5Le322Ic7EBZ7+LQT4ImdDNfPVOiwX6XEf4TTyV22w99tZBxpOZyT0RPIObnE=
x-ms-office365-filtering-correlation-id: 5552e508-dc81-4ade-61fd-08d6442c65a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2341;
x-ms-traffictypediagnostic: BYAPR15MB2341:
x-microsoft-antispam-prvs: <BYAPR15MB234168D28F015A89A3BC4AA7D7CB0@BYAPR15MB2341.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231382)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2341;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2341;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(71200400001)(256004)(186003)(2906002)(31686004)(2900100001)(81156014)(81166006)(8676002)(105586002)(4326008)(7736002)(53936002)(8936002)(305945005)(106356001)(316002)(486006)(46003)(14454004)(36756003)(11346002)(2616005)(54906003)(476003)(446003)(6116002)(6436002)(86362001)(6486002)(478600001)(52116002)(2201001)(110136005)(68736007)(99286004)(6512007)(5660300001)(6246003)(25786009)(97736004)(71190400001)(386003)(6506007)(31696002)(229853002)(2501003)(76176011)(102836004)(53546011)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2341;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rbToFDPaxspj0at42vvrWtiUPcBBzTcM0VkOUG1keSZK9O778Btd4+tQLnHhc6s3AgPF/T+0cp8JXdG3/+s4sOD0fTdJo25LlGyJNdAxcPq5zfat3vygqqRWN4LRe9ZY66jzNssLfnd7PKq6wzLmXfgaiAFpAsIh+qvYZTEu7SkKDx6RkShC8vxkukHIHmtGrQrUpUxWz2Qadk2XxU3mtzK3W5BRQSZjMbrY8eWX9r6H+dG5YMljQurFJOBsNNT6+gQ6KvQ1m5NsX+rr1aBhi2LYHpp8IJdK1C/2hI58ezqBW3akwQO5pPvMjCEDGuPZlKYTCBD/Vw/G8rN1/UXOUudxaUFE+DYvfuuWhuBzapg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D27DA3BC5892143968DBBE2FEA3A2E3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5552e508-dc81-4ade-61fd-08d6442c65a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 21:11:19.8507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2341
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNi8xOCAxMjo1MiBQTSwgU29uZyBMaXUgd3JvdGU6DQo+ICsJLyogZmlsbCBpbiBmYWtl
IHN5bWJvbCBuYW1lIGZvciBub3csIGFkZCByZWFsIG5hbWUgYWZ0ZXIgQlRGICovDQo+ICsJaWYg
KGluZm8ubnJfaml0ZWRfZnVuY19sZW5zID09IDEgJiYgaW5mby5uYW1lKSB7ICAvKiBvbmx5IG1h
aW4gcHJvZyAqLw0KPiArCQlzaXplX3QgbDsNCj4gKw0KPiArCQlhc3NlcnQoaW5mby5ucl9qaXRl
ZF9rc3ltcyA9PSAxKTsNCj4gKwkJbCA9IHNucHJpbnRmKHB0ciwgS1NZTV9OQU1FX0xFTiwgImJw
Zl9wcm9nXyVzIiwgaW5mby5uYW1lKTsNCg0KcGxlYXNlIGluY2x1ZGUgdGhlIHByb2cgdGFnIGhl
cmUuIEp1c3QgbGlrZSBrZXJuZWwga2FsbHN5bXMgZG8uDQpPdGhlciB0aGFuIHRoaXMgc21hbGwg
bml0IHRoZSBwYXRjaCBzZXQgbG9va3MgZ3JlYXQgdG8gbWUuDQo=
