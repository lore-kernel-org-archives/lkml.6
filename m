Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DFEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4086F20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5hnCwEId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4086F20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbeISEow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:44:52 -0400
Received: from mail-eopbgr710082.outbound.protection.outlook.com ([40.107.71.82]:2931
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727988AbeISEow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DsjnlofhMOZqn5kVHVrE+Jd+0v2+7yP9hJ+IaGZaxo=;
 b=5hnCwEIdoM3+32YLcM3WxVWWQuKvYoZN0LMhtJOlmYECODyAmGlIh8vM8l97HP+vMeVgsOWbOK48OXOBey9zjPBBES3xOQ6MKMfHbI/n9Atu2crejT7bGTMrOhdR00wbZ6xk7Bda9ibdZLtW7/xyWHxhtqdbLnAX7s/A8pVdNIc=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0862.namprd12.prod.outlook.com (10.164.27.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 23:09:58 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 23:09:57 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     David Miller <davem@davemloft.net>,
        "ahs3@redhat.com" <ahs3@redhat.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "isubramanian@apm.com" <isubramanian@apm.com>,
        "kchudgar@apm.com" <kchudgar@apm.com>,
        "qnguyen@apm.com" <qnguyen@apm.com>
Subject: Re: [PATCH] net: apm: xgene: force XGene enet driver to re-balance
 IRQ usage
Thread-Topic: [PATCH] net: apm: xgene: force XGene enet driver to re-balance
 IRQ usage
Thread-Index: AQHUTt8og7okeCVjiUW6cBT1Gl1HMKT1UsqAgAFY4YA=
Date:   Tue, 18 Sep 2018 23:09:57 +0000
Message-ID: <a5adee73-dde7-d00f-e7ef-1f81dc7c813a@amd.com>
References: <20180917233533.28626-1-ahs3@redhat.com>
 <20180917.193531.1424852853827678152.davem@davemloft.net>
In-Reply-To: <20180917.193531.1424852853827678152.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0084.namprd07.prod.outlook.com (2603:10b6:100::52)
 To SN1PR12MB0175.namprd12.prod.outlook.com (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0862;20:w9lYY7ppJXXBoLVAu7xbPdMCi/3Jw97+6RlVNcuecK9z+XUFGZE/szKYz2Bn6HPlbCD7aEcmLDbUrK2/pT96Kk7oivv4AwjyrtpJantHJrh6XlnieeUhoOPqGRxNgoAkM6Tml28N9p5Tp6SX/jH+p8oYuTQAktOaeZIvmn1UGhuhuHPQjga6YZWmvT+Y8ksyDl+1JgjVIBfLA0TJpAaDOA3tffC4efTbPyGfnydW7E/bvWAzFdeFcRbDwxCYiuDl
x-ms-office365-filtering-correlation-id: a48bbd97-8520-4fd7-43f5-08d61dbbd9ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0862;
x-ms-traffictypediagnostic: SN1PR12MB0862:
x-microsoft-antispam-prvs: <SN1PR12MB086269BBBC2F585BEE2FDD77EC1D0@SN1PR12MB0862.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:SN1PR12MB0862;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0862;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(316002)(68736007)(229853002)(110136005)(54906003)(2501003)(81166006)(2616005)(81156014)(5660300001)(8936002)(2900100001)(11346002)(446003)(5250100002)(6512007)(106356001)(66066001)(105586002)(76176011)(52116002)(6436002)(8676002)(99286004)(486006)(25786009)(256004)(53936002)(86362001)(53546011)(476003)(36756003)(31686004)(31696002)(305945005)(2906002)(14454004)(6246003)(6506007)(386003)(478600001)(6486002)(4326008)(3846002)(6116002)(97736004)(26005)(102836004)(186003)(7736002)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0862;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DaZdB8KyPDZbH9Loa1fpWwlswXQJBr16bmRgc9CtelnkyJYJcWSVZUtTUcaXrz8zvaaip///7A5SSGKftg6ctDGvcaZt7tiwStS29g9/hV131YtMKCO6mVVj8XoDnUJ/pr0nvqddoTutUdQ+I3WfAoRKuQYYHYpEpKKiN79kZplzFXvGzfhrAI7/L1cxaDwV1Db0m29ysQkWVYzhDoko+7yXXp1il/hCUtynWuZ4qVDH/TLtEMtWPrLucNPIy1DQbChkZqzZithRt11cGCK9mnMSb7vgxdatvlUAMJUdlY4dpahWNZcW80sqARY/DenXtfdTxgGwzFFlqu8DTyPrGWDXnaWshyAOHB9bDaKw6DA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B113EA9BF943E4887D31F15B268AA38@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48bbd97-8520-4fd7-43f5-08d61dbbd9ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 23:09:57.8492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0862
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzE3LzIwMTggMDk6MzUgUE0sIERhdmlkIE1pbGxlciB3cm90ZToNCj4gRnJvbTog
QWwgU3RvbmUgPGFoczNAcmVkaGF0LmNvbT4NCj4gRGF0ZTogTW9uLCAxNyBTZXAgMjAxOCAxNzoz
NTozMyAtMDYwMA0KPiANCj4+IEBAIC04NjYsOCArODY2LDExIEBAIHN0YXRpYyBpbnQgeGdlbmVf
ZW5ldF9uYXBpKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgY29uc3QgaW50IGJ1ZGdldCkNCj4+
ICAJcHJvY2Vzc2VkID0geGdlbmVfZW5ldF9wcm9jZXNzX3JpbmcocmluZywgYnVkZ2V0KTsNCj4+
ICANCj4+ICAJaWYgKHByb2Nlc3NlZCAhPSBidWRnZXQpIHsNCj4+ICsJCXN0cnVjdCBpcnFfZGVz
YyAqZGVzYyA9IGlycV90b19kZXNjKHJpbmctPmlycSk7DQo+PiArDQo+PiAgCQluYXBpX2NvbXBs
ZXRlX2RvbmUobmFwaSwgcHJvY2Vzc2VkKTsNCg0KVGhlIHByb2JsZW0gY291bGQgYmUgdGhhdCB0
aGUgZHJpdmVyIGlzbid0IGNoZWNraW5nIHRoZQ0KbmFwaV9jb21wbGV0ZV9kb25lKCkgcmV0dXJu
IGNvZGUuICBJdCB3YXMgY2hhbmdlZCB0byByZXR1cm4gYSBib29sIGFuZA0KdGhlIGNoZWNrIHNo
b3VsZCBiZSBtb3JlIGxpa2U6DQoNCiAgaWYgKChwcm9jZXNzZWQgIT0gYnVkZ2V0KSAmJiBuYXBp
X2NvbXBsZXRlX2RvbmUobmFwaSwgcHJvY2Vzc2VkKSkgew0KDQpJZiBpdCByZXR1cm5zIGZhbHNl
LCB0aGVuIHRoZSBkcml2ZXIgd2lsbCBnZXQgY2FsbGVkIGZvciBwb2xsaW5nIGFnYWluDQphZnRl
ciBoYXZpbmcgaXNzdWVkIGVuYWJsZV9pcnEoKSBhbmQgaXQgd2VsbCB0aGVuIGlzc3VlIHRoZSBl
bmFibGVfaXJxKCkNCmEgc2Vjb25kIChvciBtb3JlKSB0aW1lIHdpdGhvdXQgaGF2aW5nIHRoZSBt
YXRjaGluZyBkaWFibGVfaXJxKCkuDQoNClRoYW5rcywNClRvbQ0KDQo+PiAtCQllbmFibGVfaXJx
KHJpbmctPmlycSk7DQo+PiArCQlpZiAoZGVzYyAmJiBkZXNjLT5kZXB0aCA+IDApDQo+PiArCQkJ
ZW5hYmxlX2lycShyaW5nLT5pcnEpOw0KPiANCj4gSSByZWFsbHkgY2FuJ3QgYWNjZXB0IGEgcGF0
Y2ggdGhhdCBncm92ZWxzIGludG8gSVJRIGxheWVyIGludGVybmFscw0KPiB0byB3b3JrIGFyb3Vu
ZCBhIGRyaXZlcidzIElSUSBlbmFibGUvZGlzYWJsZSB1c2FnZSBwcm9ibGVtLg0KPiANCj4gU29y
cnkuDQo+IA0K
