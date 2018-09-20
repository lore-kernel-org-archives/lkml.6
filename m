Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3230BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD71021532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hd9tVR2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD71021532
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbeIUAue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:50:34 -0400
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:33664
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388174AbeIUAue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E81qf4YBrrRr8jO9LFK3malSekBR+TuDJXEu+V24tw=;
 b=Hd9tVR2t18v5CWKIDIT5PGX1qXjfrlLMUn1GJ1i8oZYxHhjaierZJohKuSDnjpbIk51EOhlKJAXdCkZBlOgiv+G9upuy1zE8aXEx9OniMT380YZ1gSOR6K5zWYDPAhOvQGEX+cj2nmdjt4kyn8kt16Qj4zdCZ3hb/uFcJB0WZXA=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0152.namprd21.prod.outlook.com (10.173.189.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 19:05:35 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 19:05:35 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: RE: [PATCH V2 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Topic: [PATCH V2 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Index: AQHUTv5LoppePkpNT0ychcducOMOjqT3x7YAgAF3MACAAEyqsA==
Date:   Thu, 20 Sep 2018 19:05:35 +0000
Message-ID: <CY4PR21MB0773653B56E22C2D0EB21FE7DC130@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
 <20180918031754.113013-5-Tianyu.Lan@microsoft.com>
 <CY4PR21MB077308B3F20B235B994FF6A5DC1C0@CY4PR21MB0773.namprd21.prod.outlook.com>
 <53f4c88b-14b7-c5b1-9690-1aad98cf56d4@microsoft.com>
In-Reply-To: <53f4c88b-14b7-c5b1-9690-1aad98cf56d4@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-20T19:05:33.3467935Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:2:c0d3:3e3a:d039:31db]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0152;6:6mXklMT6X/wNL4lbIOfoL/mVIIzQeWHr7xqqjZGnjbITuPvzonQvdHrwHFGsPRNXgpKZj3KDD1n9+2S8ohOhMP+P6BS6lFsuQ7felNm9qnfEtmoyq6lLLJwJaA+hlT7u2aut9RCxhYsvgU5+EK6r+IUKYLPy6aMkyqv8XeTnbnFv9sWcwbtlbyR5TSXBt2tdQQN1/U3xIDzt4Eif5PrT8firtvN6R8bvKNDhtx55sPgwGM1gSzeH7G5b6mb8tYP3DNc2awlhaVwpGna2aNpBIO6HsGKnUjKhR1neia/EaTLfJ9162P/6fMCnwyelXwpCLqtiIA5dbq3CHQFSGEHpA56H5FM/wjcFyY5NTLeTdPmCT847YEdavzg93AX2ApHV0joisEkYhyKbVmUCouSSwzIyp3egiV+tYJZz28LTHM4dNkqcq/I/jIC4PYw5HCDR358mNPTxX+DsQHJ8VwScFA==;5:YOUQfRa/wgJIpaPVps6L4eEGm4GPAqJYaL80MTnI/hcyKWJ/3GUqOWGZy2TGFeO03gMSl7wcbf/h5FVGUtMHkf7/QlJDoyMhDltASONQZXQIG/Rc2T/CFC6kZc/wQlGXgF3XYWkcqnhYf5N7HJHbgcWa9rVHXjrMzxKJhryiGL0=;7:Yrn35iI5nqFWl0DcA7ZW/iGbuMDReVDgoN0QKH5m3WixygsA7TfSrzbnDFYLQEOjJ3rJ2CLHohI6nCcyzJEhR/Kf7BFmbC9rYgZwisfAyPUPabKe0OTjWB3Alg41U/0MZlzzG/gsqJFZRkyz2Vt+5nRoLkJpKZ5kpZyRX4dVifEuKr8TxbBdm3kY7rw1n2X6fySXesoCAke6OE/WcslYUPtp9bTpT2M9XI1iIc75j0X1uEZO59xIijBPcAFNTgaI
x-ms-office365-filtering-correlation-id: 2f030572-fa79-46f2-17ea-08d61f2c0bb0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0152;
x-ms-traffictypediagnostic: CY4PR21MB0152:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0152CFE02289C31673DFF702DC130@CY4PR21MB0152.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0152;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0152;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(81156014)(81166006)(476003)(71200400001)(46003)(6346003)(71190400001)(5660300001)(22452003)(6436002)(93886005)(486006)(446003)(11346002)(10090500001)(229853002)(53936002)(55016002)(256004)(9686003)(7416002)(68736007)(14454004)(7696005)(8936002)(6506007)(6116002)(33656002)(86362001)(10290500003)(74316002)(76176011)(316002)(72206003)(2900100001)(305945005)(25786009)(8676002)(478600001)(102836004)(6636002)(54906003)(105586002)(97736004)(4326008)(8990500004)(86612001)(5250100002)(2906002)(53546011)(6246003)(107886003)(99286004)(1511001)(6862004)(106356001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0152;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: SP5AK5RzpnX6sutofaOLWPKTmA8J2T2czx/CSD4KlO+FLYT5B4U10424EALxoiAbYehYjrQ85IScUUQ3WtMbeoD6O0MHTilDlnrRFrLXZgL4nBOrcS8h444QV+VoALyYr6t59vfGNMAIp/9IMyQLmh2OaZJPx4FGqZZVKCEMY4BNiquhxZ4gp8+tjmiqAV0dXrTZljSj5rUbXC4u+M7FTBtOV8G3r/+K4jpfO68uzJiIlmfDa1tk4V8n0CHGRPr39+ajf9i8MYD4TrF5EuEhtPwc+6vYfbnUtAUf5V+h2le/YZ28miZKOQmEviY3VkIBEkf+xBaJ7z84WQPxzJ6YZ2bnQAlgB2QYUhTX16bHbog=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f030572-fa79-46f2-17ea-08d61f2c0bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 19:05:35.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGlhbnl1IExhbiAgU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyMCwgMjAxOCA3OjMw
IEFNDQo+IE9uIDkvMjAvMjAxOCAxMjowOCBBTSwgTWljaGFlbCBLZWxsZXkgKEVPU0cpIHdyb3Rl
Og0KPiA+IEZyb206IFRpYW55dSBMYW4gIFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE3LCAyMDE4
IDg6MTkgUE0NCj4gPj4gKw0KPiA+PiArCQkJaWYgKHJldCAmJiBrdm1fYXZhaWxhYmxlX2ZsdXNo
X3RsYl93aXRoX3JhbmdlKCkpIHsNCj4gPj4gKwkJCQlrdm1fZmx1c2hfcmVtb3RlX3RsYnNfd2l0
aF9hZGRyZXNzKGt2bSwNCj4gPj4gKwkJCQkJCWdmbl9zdGFydCwNCj4gPj4gKwkJCQkJCWdmbl9l
bmQgLSBnZm5fc3RhcnQpOw0KPiA+DQo+ID4gRG9lcyB0aGUgYWJvdmUgbmVlZCB0byBiZSBnZm5f
ZW5kIC0gZ2ZuX3N0YXJ0ICsgMT8NCj4gDQo+IFRoZSBmbHVzaCByYW5nZSBkZXBlbmRzIG9uIHRo
ZSBpbnB1dCBwYXJhbWV0ZXIgZnJhbWUgc3RhcnQgYW5kIGZyYW1lIGVuZA0KPiBvZiBmb3JfZWFj
aF9zbG90X3JtYXBfcmFuZ2UoKS4NCj4gDQo+ICAgICAgICAgIGZvcl9lYWNoX3Nsb3Rfcm1hcF9y
YW5nZShtZW1zbG90LCBQVF9QQUdFX1RBQkxFX0xFVkVMLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgUFRfTUFYX0hVR0VQQUdFX0xFVkVMLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZ2ZuX3N0YXJ0LCBnZm5fZW5kIC0gMSwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZpdGVyYXRvcikNCj4gICAgICAgICAgICAgICAgICByZXQg
fD0gaGFuZGxlcihrdm0sIGl0ZXJhdG9yLnJtYXAsIG1lbXNsb3QsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaXRlcmF0b3IuZ2ZuLCBpdGVyYXRvci5sZXZlbCwgZGF0YSk7DQo+
IA0KPiANCj4gVGhlIHN0YXJ0IGlzICJnZm5fc3RhcnQiIGFuZCB0aGUgZW5kIGlzICJnZm5fZW5k
IC0gMSIuIFRoZSBmbHVzaCBzaXplIGlzDQo+IChnZm5fZW5kIC0gMSkgLSBnZm5fc3RhcnQgKyAx
ID0gZ2ZuX2VuZCAtIGdmbl9zdGFydC4NCj4gDQoNCkdvdCBpdC4gIEkgYWdyZWUuDQoNCk1pY2hh
ZWwNCg==
