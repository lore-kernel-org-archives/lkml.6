Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328FEC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECF52086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="q/F/JWnn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="g7+5mI5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECF52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbeKGKjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:39:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387697AbeKGKjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:39:31 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA71AgEE026118;
        Tue, 6 Nov 2018 17:10:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DlsTP3P5Q3w+McDs2S68g4IcgThvwDEsc01uydlMDyw=;
 b=q/F/JWnn65A/lhSKsPdltHyfQUbbUFW+Y0DqnqzLl9/Tdafsx6XjZizjWv2f9QoF+uYW
 KiKla/3UOUYf7X55SdU1eKducxdD2TSalazyUAfWhJLGduFihMxK01YsLV0jgL6dKlyK
 rCl95trMqsBH+sdnKT4UasbjHjKPE4GsYiI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nkp5k800p-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Nov 2018 17:10:51 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 6 Nov 2018 17:09:31 -0800
Received: from FRC-CHUB13.TheFacebook.com (2620:10d:c021:18::32) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 6 Nov 2018 17:09:31 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 6 Nov 2018 20:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlsTP3P5Q3w+McDs2S68g4IcgThvwDEsc01uydlMDyw=;
 b=g7+5mI5nufNr6VdeSvBohWZy0CMDQ5PzojO7PTzwSE2SwJWEh7kvD8phOqHbX2olW90GHHzxKT0SV9pNNvINKjxkR7SpssKUwXJDEY6qgk6RVcJ0aCmaa44TKAjnacWrCVuVzdZI15cLfZ50Yky//WJfX8toMjW/sHMNOuKKsD4=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2392.namprd15.prod.outlook.com (52.135.198.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 7 Nov 2018 01:09:28 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 01:09:28 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     David Ahern <dsahern@gmail.com>, David Miller <davem@davemloft.net>
CC:     Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Topic: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Index: AQHUdhL1gT1g6kXc4U+H9DJqSIZu3qVDSleAgAAXY4CAAAMiAIAAAiiAgAAKXoCAAAKqgP//eqYAgACLKYCAAAcMAA==
Date:   Wed, 7 Nov 2018 01:09:28 +0000
Message-ID: <edda462f-a32c-bc25-94c8-8d06a47bd480@fb.com>
References: <b984776a-ce69-ab16-ed87-1cea89c9d79a@gmail.com>
 <6C5A9FBD-F50D-444C-9038-E9557EC850D2@fb.com>
 <27fc8327-3390-ba5a-6063-89c9e7165e7b@fb.com>
 <20181106.153647.1701013551426767213.davem@davemloft.net>
 <39fe6abc-5c3e-bac3-0c0b-cf68bea23ab0@fb.com>
 <0a05a14c-3a79-e894-ae48-cbe1df4feb91@gmail.com>
 <82745121-339e-2751-c9db-d1fca02d0b33@fb.com>
 <7d0b100b-a64b-0d30-8ec0-2689ef44423d@gmail.com>
In-Reply-To: <7d0b100b-a64b-0d30-8ec0-2689ef44423d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0056.namprd22.prod.outlook.com
 (2603:10b6:301:16::30) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:62d8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2392;20:xuj27s3UpqGvlcGa6RBIuoYSnuYvAcYyLHN+cQY+oselSbhXbOnCtsoWLM2GBz0nH4Bj+2jGB8kdrk1Xcg9qZh1QoLCukiOodztWqqAqtUG7CHZZiYXJgFnJ1CmuxhilNetBMGMnC6br0JbtdsTbAKp2TkxvS2RPHf0nrb0CjHQ=
x-ms-office365-filtering-correlation-id: 4c90eb33-bd47-4a03-e399-08d6444daa55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2392;
x-ms-traffictypediagnostic: BYAPR15MB2392:
x-microsoft-antispam-prvs: <BYAPR15MB2392E8939558AD731CFF0A03D7C40@BYAPR15MB2392.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2392;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2392;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(6486002)(81156014)(53936002)(229853002)(6116002)(6436002)(316002)(36756003)(81166006)(8676002)(6512007)(6246003)(8936002)(110136005)(2906002)(97736004)(54906003)(99286004)(39060400002)(5660300001)(305945005)(7736002)(93886005)(106356001)(186003)(46003)(105586002)(52116002)(14454004)(53546011)(6506007)(386003)(68736007)(256004)(76176011)(478600001)(2616005)(102836004)(86362001)(2900100001)(11346002)(446003)(486006)(476003)(31696002)(71190400001)(31686004)(4326008)(25786009)(71200400001)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2392;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HPdAt5uuaruvfRTdFyj7E8Y6w6YErmCS81rwP6/WHe1ZTKmbLnZ1ydidc83L0x6dPzHsV7j8Cavxz+KteV1oqPJxJ15KaLgalCmi91+/wQLbddPE7CfMnWjbhJq2uCvIFcT5IZf2fsmxJvnpnPWaQZxEHueYBLJo1kVXQCy/G3bIaAEjJkB9NxOyT3MqFpZRNk5TDNlEocC8VqeAKZ/DZTuFYMb8KvYOugc+humv2HfzQcaG1mEuPGV1X+V9X4eF095nstoAjn2I4P9A6A6Y8kMlanrH7syspU2/zggDRpkgwXGXnA+gya6Rh/jO/ez7oKow2bXMtgpO7eEmzhYtEbRUMZa44I9Wv9pU0+etUtA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8234598E2BBF747BC5CCCE6693A315F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c90eb33-bd47-4a03-e399-08d6444daa55
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 01:09:28.5983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2392
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNi8xOCA0OjQ0IFBNLCBEYXZpZCBBaGVybiB3cm90ZToNCj4gDQo+IFNvIG9uZSB1c2Ug
Y2FzZSBpcyBwcm9maWxpbmcgYnBmIHByb2dyYW1zLiBJIHdhcyBhbHNvIGNvbnNpZGVyaW5nIHRo
ZQ0KPiBhdWRpdGluZyBkaXNjdXNzaW9uIGZyb20gc29tZSB3ZWVrcyBhZ28gd2hpY2ggSSB0aG91
Z2h0IHRoZSBldmVudHMgYXJlDQo+IGFsc28gdGFyZ2V0aW5nLg0KDQp5ZXMuIHRoZXJlIHNob3Vs
ZCBiZSBzZXBhcmF0ZSBtb2RlIGZvciAncmU6IGF1ZGl0IGRpc2N1c3Npb24nIHdoZXJlDQpvbmx5
IGJwZiBldmVudHMgYXJlIGNvbGxlY3RlZC4gVGhpcyBwYXRjaCBzZXQgZG9lc24ndCBhZGQgdGhh
dCB0bw0KcGVyZiB1c2VyIHNwYWNlIHNpZGUuDQpUaGUga2VybmVsIHNpZGUgaXMgY29tbW9uIHRo
b3VnaC4gSXQgY2FuIGJlIHVzZWQgZm9yIGJwZiBsb2FkL3VubG9hZA0Kb25seSBhbmQgZm9yIGRp
ZmZlcmVudCB1c2UgY2FzZSBpbiB0aGlzIHNldC4gV2hpY2ggaXMgbWFraW5nDQpicGYgcHJvZ3Jh
bSBhcHBlYXIgaW4gbm9ybWFsICdwZXJmIHJlcG9ydCcuDQpQbGVhc2Ugc2VlIGxpbmsgaW4gY292
ZXIgbGV0dGVyLg0KV2UgZGVjaWRlZCB0byBhYmFuZG9uIG15IG9sZCBhcHByb2FjaCBpbiBmYXZv
ciBvZiB0aGlzIG9uZSwNCmJ1dCB0aGUgZW5kIHJlc3VsdCBpcyB0aGUgc2FtZS4NCiBGcm9tIDAu
ODElIGNwdSBvZiBzb21lIG1hZ2ljIDB4MDAwMDdmZmZhMDAxYTY2MA0KaW50byAxOC4xMyUgb2Yg
YnBmX3Byb2dfMWFjY2M3ODhlN2YwNGMzOF9iYWxhbmNlcl9pbmdyZXMNCg0KDQo+IEFzIGZvciB0
aGUgb3ZlcmhlYWQsIEkgZGlkIG5vdCBzZWUgYSBzZXBhcmF0ZSB0aHJlYWQgZ2V0dGluZyBzcHVu
IG9mZg0KPiBmb3IgdGhlIGJwZiBldmVudHMsIHNvIHRoZSBldmVudHMgYXJlIHByb2Nlc3NlZCBp
bmxpbmUgZm9yIHRoaXMgUkZDIHNldC4NCg0KYXJnaC4geW91J3JlIHJpZ2h0LiB3ZSBoYXZlIHRv
IGZpeCB0aGF0Lg0K
