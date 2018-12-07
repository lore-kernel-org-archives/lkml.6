Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9D2C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7170D20672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lUg9gNWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7170D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLGTqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:46:34 -0500
Received: from mail-eopbgr820089.outbound.protection.outlook.com ([40.107.82.89]:9984
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbeLGTqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac3EmtIFanVdas8VpS+tYMrMDaibhIm6edpVL4aPP6M=;
 b=lUg9gNWvh9hAy5XGvEe4A+SWs1JLh2L9HOQzzNsOqAjjfdB2efj0dOp3EX0JuNjiAcdYCVtEOgN6ypTsVck5ONtbz4xGL6ezD23mjqP2U6hopbUmzwHIsigVFiknDE5Ww87+ailS5Z4yEn4NijempjqgCIeYxSwXIxh7j1tQsrc=
Received: from CY4PR12MB1717.namprd12.prod.outlook.com (10.175.62.139) by
 CY4PR12MB1525.namprd12.prod.outlook.com (10.172.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Fri, 7 Dec 2018 19:46:31 +0000
Received: from CY4PR12MB1717.namprd12.prod.outlook.com
 ([fe80::6191:9608:ceb9:9767]) by CY4PR12MB1717.namprd12.prod.outlook.com
 ([fe80::6191:9608:ceb9:9767%11]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 19:46:31 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Eric Anholt <eric@anholt.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sched: Always trace the dependencies we wait on, to
 fix a race.
Thread-Topic: [PATCH] drm/sched: Always trace the dependencies we wait on, to
 fix a race.
Thread-Index: AQHUjmFs0dgG3v/ahUG+an14yjUKCqVzrlCA
Date:   Fri, 7 Dec 2018 19:46:31 +0000
Message-ID: <ba4a98f4-062e-0cb4-bd22-a0a191385f82@amd.com>
References: <20181207191653.30118-1-eric@anholt.net>
In-Reply-To: <20181207191653.30118-1-eric@anholt.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM6PR0502CA0063.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::40) To CY4PR12MB1717.namprd12.prod.outlook.com
 (2603:10b6:903:121::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1525;20:NrJL2XtEMD7ugIM62R403d0B/G8o3sRfPyOUSfFcLwnO4no8LBN/vdIYJnrmuOvf8ZOAmU3WuUm1vuH5jW69bHVFr4u9e23frY80PC4eSCbRLk0zW6H284lWDFl1O91wjZCIsuvsci+rGlNzS612J3M6cxsa/TdE+aBo4LuiuIsjKRqLCcwzFkSllI1+yhVkJb6vY/z77muQEq/RRK3Baeumt4iSTdTBD+NG/gj+rAzAxCoWsImZClq5QQzFZUe7
x-ms-office365-filtering-correlation-id: 6c731807-fa43-4d11-fc22-08d65c7caf6a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1525;
x-ms-traffictypediagnostic: CY4PR12MB1525:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-microsoft-antispam-prvs: <CY4PR12MB1525274F5E759793F8CDD5C083AA0@CY4PR12MB1525.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR12MB1525;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1525;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(366004)(376002)(346002)(136003)(52314003)(199004)(189003)(4326008)(36756003)(446003)(11346002)(6246003)(6486002)(53936002)(64126003)(6512007)(2501003)(478600001)(65956001)(76176011)(65806001)(25786009)(256004)(68736007)(72206003)(52116002)(229853002)(97736004)(6116002)(14454004)(6436002)(2201001)(106356001)(7736002)(105586002)(31686004)(86362001)(386003)(5660300001)(65826007)(305945005)(71190400001)(186003)(102836004)(46003)(6506007)(486006)(2906002)(71200400001)(81156014)(31696002)(8936002)(8676002)(2616005)(316002)(476003)(99286004)(81166006)(110136005)(58126008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1525;H:CY4PR12MB1717.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WshtFYX+mCSD2zP2WCq+JAql2rR4Lkjpkv5thi4lzgkHHHW8LzB0bSIO2RBmDlNt7/8KH3SBxa4/RsQkKb7/LFCSjnVdMy8CvAnJwZ/MW5qGVVZKEb5WE/oQjPDEtzTsHINuH6u+UrNnKgey/MbjW6WSlynvF+npjuMi2jyskyoUUXWNiH4PtMwu7eKqWtXsykQkRgH11BP//v5z/gBHput6MGTW/UUXGq65NFa5j6qpYzI97HfrAXgu8fexjy+DhHXjX3GFH2JbYC2j+dIy+soC8jrfgyx9dwW3qKBxRlaRj0ac9ELMaQaIUou3my2GxNY+NyVmPrJ0pUEBi4FxGxuHMzn57QCTIceMg/C8o0k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <00F4F65421CF6F4E9C3953511C830614@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c731807-fa43-4d11-fc22-08d65c7caf6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 19:46:31.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDcuMTIuMTggdW0gMjA6MTYgc2NocmllYiBFcmljIEFuaG9sdDoNCj4gVGhlIGVudGl0eS0+
ZGVwZW5kZW5jeSBjYW4gZ28gYXdheSBjb21wbGV0ZWx5IG9uY2Ugd2UndmUgY2FsbGVkDQo+IGRy
bV9zY2hlZF9lbnRpdHlfYWRkX2RlcGVuZGVuY3lfY2IoKSAoaWYgdGhlIGNiIGlzIGNhbGxlZCBi
ZWZvcmUgd2UNCj4gZ2V0IGFyb3VuZCB0byB0cmFjaW5nKS4gIFRoZSB0cmFjZXBvaW50IGlzIG1v
cmUgdXNlZnVsIGlmIHdlIHRyYWNlDQo+IGV2ZXJ5IGRlcGVuZGVuY3kgaW5zdGVhZCBvZiBqdXN0
IG9uZXMgdGhhdCBnZXQgY2FsbGJhY2tzIGluc3RhbGxlZCwNCj4gYW55d2F5LCBzbyBqdXN0IGRv
IHRoYXQuDQo+DQo+IEZpeGVzIGFueSBlYXN5LXRvLXByb2R1Y2UgT09QUyB3aGVuIHRyYWNpbmcg
dGhlIHNjaGVkdWxlciBvbiBWM0Qgd2l0aA0KPiAicGVyZiByZWNvcmQgLWEgLWUgZ3B1X3NjaGVk
dWxlcjouXCogZ2x4Z2VhcnMiIGFuZCBERUJVR19TTEFCIGVuYWJsZWQuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IEVyaWMgQW5ob2x0IDxlcmljQGFuaG9sdC5uZXQ+DQoNClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCkdvaW5nIHRvIHBpY2sg
dGhhdCB1cCBmb3IgdXBzdHJlYW0gYW5kIHdpbGwgYWRkIHdpdGggYSBDQzogc3RhYmxlLg0KDQpU
aGFua3MsDQpDaHJpc3RpYW4uDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxl
ci9zY2hlZF9lbnRpdHkuYyB8IDcgKystLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9z
Y2hlZF9lbnRpdHkuYw0KPiBpbmRleCA0NDYzZDM4MjZlY2IuLmUyOTQyYzlhMTFhNyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jDQo+IEBAIC00NDAsMTMg
KzQ0MCwxMCBAQCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqZHJtX3NjaGVkX2VudGl0eV9wb3Bfam9i
KHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkpDQo+ICAgDQo+ICAgCXdoaWxlICgoZW50
aXR5LT5kZXBlbmRlbmN5ID0NCj4gICAJCQlzY2hlZC0+b3BzLT5kZXBlbmRlbmN5KHNjaGVkX2pv
YiwgZW50aXR5KSkpIHsNCj4gKwkJdHJhY2VfZHJtX3NjaGVkX2pvYl93YWl0X2RlcChzY2hlZF9q
b2IsIGVudGl0eS0+ZGVwZW5kZW5jeSk7DQo+ICAgDQo+IC0JCWlmIChkcm1fc2NoZWRfZW50aXR5
X2FkZF9kZXBlbmRlbmN5X2NiKGVudGl0eSkpIHsNCj4gLQ0KPiAtCQkJdHJhY2VfZHJtX3NjaGVk
X2pvYl93YWl0X2RlcChzY2hlZF9qb2IsDQo+IC0JCQkJCQkgICAgIGVudGl0eS0+ZGVwZW5kZW5j
eSk7DQo+ICsJCWlmIChkcm1fc2NoZWRfZW50aXR5X2FkZF9kZXBlbmRlbmN5X2NiKGVudGl0eSkp
DQo+ICAgCQkJcmV0dXJuIE5VTEw7DQo+IC0JCX0NCj4gICAJfQ0KPiAgIA0KPiAgIAkvKiBza2lw
IGpvYnMgZnJvbSBlbnRpdHkgdGhhdCBtYXJrZWQgZ3VpbHR5ICovDQoNCg==
