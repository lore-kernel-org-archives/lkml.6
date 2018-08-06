Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9CAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAA621A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="d+c/z8T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAA621A0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeHFO5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:57:10 -0400
Received: from mail-sn1nam02on0088.outbound.protection.outlook.com ([104.47.36.88]:37960
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727561AbeHFO5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ypme9FBsWkbr9Z8hQO85cl0P/Z3T3JX9Lsvlp142zLI=;
 b=d+c/z8T3ThWxFg56Xh6qxGZYy90R8p4aJ/zs+f0AArOx18juzLcy5Of8xnltMEke8bypkeQyqJcBjfsptjuYPlSEmiQZuS2hlvrhdRRs4BN80nWLi9eRgftKnZ00BlROzsSY5UMASBHoEa2zCSA5AtmZkTe0JJTSs8ESSP4NJx8=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB1027.namprd02.prod.outlook.com (10.161.207.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Mon, 6 Aug 2018 12:48:08 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::d4fc:b478:dd6d:55c5]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::d4fc:b478:dd6d:55c5%8]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 12:48:08 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Topic: [PATCH v2] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Index: AQHULXm/D5YmQv4GuEyDLRFyfWs8QKSypEqAgAAHL3A=
Date:   Mon, 6 Aug 2018 12:48:07 +0000
Message-ID: <BN3PR0201MB099304B53FC0F0BB3D266E4AA7200@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1533555373-24400-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <efb57c01-5b22-ac06-cb7f-c863f9f4a9f6@linux.intel.com>
In-Reply-To: <efb57c01-5b22-ac06-cb7f-c863f9f4a9f6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB1027;6:h5SC1JA5aBAqGzmxqE3/3jB2Vee1lAvsi10lLFfeScwL1E2uyEwJTsmGWXCmu1AGgKCTVusDLMTO8DFVLzMue/ghTcdMKK/gzd41mbbIQ9aSS8SCNH2OyTLuTW1BJluP+1hX9DsCm65efRLlx3/a9WW2P6O7CdkOppi+9f8bhbVfeElcxjPXyJMmIJ5hk1yQz1oEwaZvjOUP9Q3zvfEhsqRUnnZuVWPILm5dPoMFrj5qXLyl6lUSJqMWCIrp/H0EJeO8PdAXqFu0uEoQcAAuwV+Smq7/9k1iMuhYyLRUaZFwxKn4SoOTyzYgw8IjVyi+O7J+ey/Xi8mAhN/w69QyVTDudPE3BjzTJDL1XvE+6rrf4lfwmrIPBuO01oqepHBTqAFm1wBVYoYmbh9SH6hN8cqGtTwMISEsjmF94Xn/ANd+D0nlCT49VnaXJ9rDp6A9d+/VrVWtcw7nJCRY7aXSlQ==;5:N0zJDCsO+MIEyWyEtwZmv1T1LrxivqRrdPlOQwV2zkkbyKwOSVtkJ4HvqcWUVhQZhERRXDMmeil6gSkAq3L7pFIm1oTA09DvtMaVu+4He5OPyCznJhLY4zuP2l0/gF70UVZpljV7tudNJwrJ4xiFo4tfW3EDfv2LbHh9niUI/JA=;7:kCYebXe0NPN7+Eowye2GgFgJsEVpluBK6881KFBZDF+/Wuuh5KyoiKNuV3iIz1BznZbg7qbA6yr6RZ6ekVpi0ZBIBwQUAws5oJGtVPJthjOS0zyK2QibRDJiQBPDxlupKhvDYBXSKCj9JjDtPaRE6+QgdUkAuJZltsybkiJ9daD5YSFk42YWGAYGXSkvH746hTzV2uZ7rUuvhwG/1Hfivcq2rjvYJLpv7afaWcTLSWrtHr3Pk5BP6E4Bz3MGAxFQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e055f718-044c-457e-157d-08d5fb9adc3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB1027;
x-ms-traffictypediagnostic: BN3PR0201MB1027:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB1027A09F94A3D51028EDE198A7200@BN3PR0201MB1027.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN3PR0201MB1027;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB1027;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(136003)(199004)(189003)(5250100002)(33656002)(256004)(97736004)(74316002)(99286004)(229853002)(2906002)(25786009)(54906003)(6116002)(3846002)(4326008)(5660300001)(86362001)(2501003)(8936002)(39060400002)(2201001)(305945005)(6246003)(81166006)(446003)(55016002)(53936002)(81156014)(11346002)(76176011)(105586002)(8676002)(106356001)(68736007)(14454004)(476003)(486006)(186003)(7736002)(316002)(26005)(66066001)(9686003)(110136005)(102836004)(7696005)(6506007)(6436002)(478600001)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB1027;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MjNik62UNKky0FIeKz089UPoDK/LG7lDR4YlKpj1JPeQGjKVWgL8hn7+r781i0NYi2KI6aJFr39Jeo+UVvG0B8afLxIrm2CLk6dMQ4ARONQn4eLg9Ygs6XdUEhexF+hb0EkxYcPSt/Yoz9qe6vzjC9pMu836TrG53DERY0MPPGPDLzPXok0lb5t/f2lQWI1FYG4ta+qLiQHshtg/WUmOWAkEyHHi/LT/TG8phrQszpdOoPzbwFvWLM+Jiy6J6eWIy03CcBPC2QJzdN0DLbCjMxph/lbt5xkJexMAzL1cI/HB54umwoYzDdFHWUAmA0p6WW0rigNYh/vgXMKbc0UJUV0iIRvzHyBixlojFt9Sgc4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e055f718-044c-457e-157d-08d5fb9adc3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 12:48:07.9288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB1027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiAtCWlmIChkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKHN5c2RldiwgInVzYjMtbHBtLWNh
cGFibGUiKSkNCj4+IC0JCXhoY2ktPnF1aXJrcyB8PSBYSENJX0xQTV9TVVBQT1JUOw0KPj4gLQ0K
Pj4gLQlpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbCgmcGRldi0+ZGV2LCAicXVpcmstYnJv
a2VuLXBvcnQtcGVkIikpDQo+PiAtCQl4aGNpLT5xdWlya3MgfD0gWEhDSV9CUk9LRU5fUE9SVF9Q
RUQ7DQo+PiAtDQo+PiAgIAkvKiBpbW9kX2ludGVydmFsIGlzIHRoZSBpbnRlcnJ1cHQgbW9kZXJh
dGlvbiB2YWx1ZSBpbiBuYW5vc2Vjb25kcy4gKi8NCj4+ICAgCXhoY2ktPmltb2RfaW50ZXJ2YWwg
PSA0MDAwMDsNCj4NCj54aGNpLT5pbW9kX2ludGVydmFsID0gNDAwMDAgaXMgbm93IGluIHRoZSBj
b3JyZWN0IHBsYWNlDQo+DQo+PiAgIAlkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoc3lzZGV2LCAi
aW1vZC1pbnRlcnZhbC1ucyIsDQo+PiAgIAkJCQkgJnhoY2ktPmltb2RfaW50ZXJ2YWwpOw0KPg0K
PmJ1dCB0aGUgZGV2aWNlX3Byb3BlcnlfcmVhZF91MzIoKSBsaW5lIGFib3ZlIGNhbiBiZSBtb3Zl
ZCBpbnNpZGUgbG9vcCBiZWxvdy4NCj4NCg0KSGkgTWF0aGlhcywNCg0KVGhhbmtzIGZvciByZXZp
ZXdpbmcgdGhlIHBhdGNoLiAgSSBhZ3JlZSB3aXRoIHlvdSwgd2lsbCBjb3JyZWN0IHRoaXMgaW4g
djMNCg0KVGhhbmtzLA0KQW51cmFnIEt1bWFyIFZ1bGlzaGENCj4+DQo+PiArCS8qIEl0ZXJhdGUg
b3ZlciBhbGwgcGFyZW50IG5vZGVzIGZvciBmaW5kaW5nIHF1aXJrcyAqLw0KPj4gKwlmb3IgKHRt
cGRldiA9ICZwZGV2LT5kZXY7IHRtcGRldjsgdG1wZGV2ID0gdG1wZGV2LT5wYXJlbnQpIHsNCj4+
ICsNCj4+ICsJCWlmIChkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKHRtcGRldiwgInVzYjItbHBt
LWRpc2FibGUiKSkNCj4+ICsJCQl4aGNpLT5xdWlya3MgfD0gWEhDSV9IV19MUE1fRElTQUJMRTsN
Cj4+ICsNCj4+ICsJCWlmIChkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKHRtcGRldiwgInVzYjMt
bHBtLWNhcGFibGUiKSkNCj4+ICsJCQl4aGNpLT5xdWlya3MgfD0gWEhDSV9MUE1fU1VQUE9SVDsN
Cj4+ICsNCj4+ICsJCWlmIChkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKHRtcGRldiwgInF1aXJr
LWJyb2tlbi1wb3J0LXBlZCIpKQ0KPj4gKwkJCXhoY2ktPnF1aXJrcyB8PSBYSENJX0JST0tFTl9Q
T1JUX1BFRDsNCj4+ICsJfQ0KPj4gKw0KPj4gICAJaGNkLT51c2JfcGh5ID0gZGV2bV91c2JfZ2V0
X3BoeV9ieV9waGFuZGxlKHN5c2RldiwgInVzYi1waHkiLCAwKTsNCj4+ICAgCWlmIChJU19FUlIo
aGNkLT51c2JfcGh5KSkgew0KPj4gICAJCXJldCA9IFBUUl9FUlIoaGNkLT51c2JfcGh5KTsNCj4+
DQo+DQo+LU1hdGhpYXMNCg==
