Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE799C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E65320882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fNJVNMjD";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ABYGPRBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E65320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIOANy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:13:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbeIOANy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:13:54 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EIsaWY004065;
        Fri, 14 Sep 2018 11:57:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MEaJqV/LIq2CCx7PH9kWdEeLOaK0IofBfd2ZA7pLM+0=;
 b=fNJVNMjDUY5yoOHdXSncxP7qeFK9O7DkJysTBpGyMK4u8yi25OKEOVb3BFi7RO5EbghM
 eMxOj57hAS+lXvwU84+LJRof5UJL9ThDkwtl4LHTNP23SJ7306kFbw/WOu2Sz03C4MyY
 qKF/8Rf1VLXscRl1yrgb3YGJQmdla2+2bBg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mghht871w-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 14 Sep 2018 11:57:27 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 14 Sep 2018 14:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEaJqV/LIq2CCx7PH9kWdEeLOaK0IofBfd2ZA7pLM+0=;
 b=ABYGPRBoUnYRlWtUudLS13ZWAmSydwdrbALnxKbdmNWFzItOfpnzA+RGoUffkkEKOBnqEZeqyiy0fyYdXnkn6Ascd6ZEJ3EvpAGBc7QAQwkh+rxj7O9eI2fN8N+y26CGbfQ3yGj6TNKbibX46W9T1LXHXgsYC1hKpVvz/Sc2SUk=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1192.namprd15.prod.outlook.com (10.172.177.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Fri, 14 Sep 2018 18:57:23 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::3cb5:8b7b:eafb:d86c]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::3cb5:8b7b:eafb:d86c%5]) with mapi id 15.20.1122.018; Fri, 14 Sep 2018
 18:57:23 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "afaerber@suse.de" <afaerber@suse.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] ARM: dts: aspeed: Adding Facebook TioagaPass BMC
Thread-Topic: [PATCH] ARM: dts: aspeed: Adding Facebook TioagaPass BMC
Thread-Index: AQHUS5x6d5C8xbbqn02NqaRIkYdj8aTupmmAgAEGj4A=
Date:   Fri, 14 Sep 2018 18:57:23 +0000
Message-ID: <781180F5-B7E7-44CD-9747-8E2908ACF5E2@fb.com>
References: <20180913195751.1833227-1-vijaykhemka@fb.com>
 <20180913201739.GG23892@lunn.ch>
In-Reply-To: <20180913201739.GG23892@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::5:6ef]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1192;20:g2zC2HCB2Nr00LGAL37x0ll8SCLP1d86NVgiercEbqR04To5Daa2mDeNRRc7xtaPSLLUeV4H0RGq6i0WoLKFl5SkVeBykxcTFwDcuMNNJ3JYFe+iEl0m8GSDClQe2/WkVeu3g3/uH6+CfLonOL0HKJrzYZ952xB4GIvsvmfcP5k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b6ffe58b-de45-4a14-ad69-08d61a73e82a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1192;
x-ms-traffictypediagnostic: CY4PR15MB1192:
x-microsoft-antispam-prvs: <CY4PR15MB11921ADA9873A97383C725DEDD190@CY4PR15MB1192.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(81227570615382);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:CY4PR15MB1192;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1192;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(47680400002)(189003)(199004)(478600001)(8936002)(6246003)(102836004)(81166006)(4326008)(36756003)(86362001)(7416002)(82746002)(186003)(2900100001)(6506007)(6512007)(81156014)(5250100002)(83716003)(256004)(8676002)(2906002)(14444005)(305945005)(68736007)(53936002)(25786009)(6116002)(6916009)(229853002)(97736004)(99286004)(6436002)(6486002)(5660300001)(105586002)(33656002)(46003)(14454004)(54906003)(486006)(2616005)(76176011)(11346002)(476003)(446003)(316002)(7736002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1192;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Fv0IBcnBDn9kVsD4Xt4t7fRFDqEEPfAODbTWTYDbTSZd5AFiRFVdD0oCnD/h/kul0nyhtEeUdaT5ePpcRacyIsJmaieiP+Sr7RZCrU8fbEgF3ueYgreoMnMQHtKaKkhKWH9WG9h/CPu/E6e3SNYVg6ZXiih1I6CWvHgQyKny5kwzKg2l8/kihsDysURjv/3D9b6DVvk5lxOs+c3At5SpBWKwP6kZ6Zp7Ad14GsEUAI4EynlbOKFWVqcDjDSyyT6Q4n/FUiBHEA2stOQwBEQsxc12KgEp+7zeMJRMP9G/DU9xrwEzKlIkNXsD5nEV3dp+q8c1dkhAj1iB6b6H+tmjbEQEx5/5Zj68qIe33Qt6g90=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <06956E895CA90746B59CD81E6214F044@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ffe58b-de45-4a14-ad69-08d61a73e82a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 18:57:23.6754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1192
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEFuZHJldywNCkkgaGF2ZSByZXZpc2VkIHBhdGNoIGFzIEkgZm91bmQgc29tZSBtb3Jl
IGNoYW5nZXMuIFNlbnQgYSBuZXcgdmVyc2lvbi4NCg0KUmVnYXJkcw0KLVZpamF5DQoNCu+7v09u
IDkvMTMvMTgsIDE6MTggUE0sICJBbmRyZXcgTHVubiIgPGFuZHJld0BsdW5uLmNoPiB3cm90ZToN
Cg0KICAgID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCiAgICA+IEBAIC0xMjA2
LDQgKzEyMDYsNSBAQCBkdGItJChDT05GSUdfQVJDSF9BU1BFRUQpICs9IFwNCiAgICA+ICAJYXNw
ZWVkLWJtYy1vcHAtd2l0aGVyc3Bvb24uZHRiIFwNCiAgICA+ICAJYXNwZWVkLWJtYy1vcHAtemFp
dXMuZHRiIFwNCiAgICA+ICAJYXNwZWVkLWJtYy1wb3J0d2VsbC1uZXB0dW5lLmR0YiBcDQogICAg
PiArCWFzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0YiBcDQogICAgDQogICAgSGkgVmlq
YXkNCiAgICANCiAgICBUaGVzZSBlbnRyaWVzIGFyZSBub3JtYWxseSBrZXB0IGluIGFscGhhYmV0
aWMgb3JkZXIuDQogICAgDQogICAgPiArCWxlZHMgew0KICAgID4gKwkJY29tcGF0aWJsZSA9ICJn
cGlvLWxlZHMiOw0KICAgID4gKwkJcG9zdGNvZGUwIHsNCiAgICA+ICsJCQlsYWJlbD0iQk1DX1VQ
IjsNCiAgICANCiAgICBEb2N1bWVudGF0aW9uL2xlZHMvbGVkcy1jbGFzcy50eHQNCiAgICANCiAg
ICBMRUQgRGV2aWNlIE5hbWluZw0KICAgID09PT09PT09PT09PT09PT09DQogICAgDQogICAgSXMg
Y3VycmVudGx5IG9mIHRoZSBmb3JtOg0KICAgIA0KICAgICJkZXZpY2VuYW1lOmNvbG91cjpmdW5j
dGlvbiINCiAgICANCiAgICAJQW5kcmV3DQogICAgDQoNCg==
