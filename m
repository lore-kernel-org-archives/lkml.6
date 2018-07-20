Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7860ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3428B20647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Dx4FZiTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3428B20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbeGTQ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:28:53 -0400
Received: from mail-sn1nam02on0084.outbound.protection.outlook.com ([104.47.36.84]:35664
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731892AbeGTQ2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz7R2yZ0IRGZAWBYe0XfT3bQjhEXYsM/JzYNH9tXCGc=;
 b=Dx4FZiTt1GArsxd6CFlXJSWvFAntcj9nL5rjjh7G/rcwmJvP3KyBfHmkvqSYe3UKtwrU2gTI8gDVKtiQ2GL4bynfcHm5WFWhFIn7JG8AlmO94T29hc+8rTm76UT63SUm7cwmukVZoqFEbxxYOaZUi82vz0DydgkKh+iGuc7tXno=
Received: from MWHPR02MB2816.namprd02.prod.outlook.com (10.175.50.14) by
 MWHPR02MB2416.namprd02.prod.outlook.com (10.168.244.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Fri, 20 Jul 2018 15:39:56 +0000
Received: from MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726]) by MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726%3]) with mapi id 15.20.0973.018; Fri, 20 Jul 2018
 15:39:56 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Topic: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Index: AQHT/OD63PyU9kIWfE6vMX/XM+YDdqSYdgMAgAAE67A=
Date:   Fri, 20 Jul 2018 15:39:56 +0000
Message-ID: <MWHPR02MB281619CD8CFDA93B9ADB3D89A7510@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <b819a5fc-82aa-dc9c-4272-fecdacbd5880@intel.com>
In-Reply-To: <b819a5fc-82aa-dc9c-4272-fecdacbd5880@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2416;6:OO7VbsEYTh4s+7CzyRen5vlvTqGzUuxKo/08+rSBq9OCsfmEDMfeqfW0UmGn3fM/7eLx0AaZrA89vzsZcqMt4fWjnpRwlvBq3l/P68rdSiQIdt2WovC98IyO+Q7mduBsxW62PMWoW1E+o/r4hACJoJFyzHEIaf27Azr0yQ2Q0mSORZhfus9fiXeokAdYO45u+RYqoDCtfV0i6YwPeV6LPCLPSL+YL0/zp92wxgUCrL0DOvSPh8jTFJxiQNFm9GXbv2Q5c2Uvnz+ujPPxkqs4PuGlkzBgepmUyXNvNGhKTtWOukecVD8NKbW7fJiVwFREMfRB8mWtvsSUkaCUPH7UAhfodaTC6aM9KFMet1O9zyxZEORHovjzrJCdy1UHSgxRZwmhLi+LnB4lPS6ynPOhSWFrJvNCU4wGeetJOfPyLIx5MQFAYWli0mgv+O0Z3uoXKQqGz/7Mzpru2kgHoxiN/w==;5:XfyuIIeLlm/+FZr6btXIu4sdHNuAYopXxPgu2J6Y8/uRgkNEZdfT6hni0YTZV8ggAxGc+WSb1GyjHbp5dhaVBXEmvcxr4GAcuP2O5vt4YH4i+TEwHxrIR0WNKza6axt9QostMgKpSOc9V6Im3eMphUkO11fWG7AIU1/XaJ7n3Fc=;7:sCMSmhFPgvN58uIUHcz4jctLmQkNZki66a6t1M/9LVCtxFp8nF1kkvCxC2CM0QCA3etFxZVPeHF4M5f72c5KNoa+cumnp16XAfOfj8TUnzNEJTKjVfNMEpm+1S0YFGaYseimPj6lTL0o5jn7+g+OECqDjOf+UfBAsnp4LvP+r581E073RKtJt2e0J/pNhxihmy7MwjfsYSz/PHS9Q+XhhycizVQRZ037pc5ViC+4J8fFe/EiMyMtSfC8lw5K7pkY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 625e47ae-4106-4fe5-27e2-08d5ee570b63
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2416;
x-ms-traffictypediagnostic: MWHPR02MB2416:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB2416A0DD30C19F719AE94A5FA7510@MWHPR02MB2416.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2416;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2416;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(13464003)(199004)(189003)(305945005)(4326008)(476003)(486006)(110136005)(54906003)(99286004)(5660300001)(5250100002)(25786009)(316002)(229853002)(6436002)(186003)(26005)(14454004)(55016002)(11346002)(76176011)(74316002)(446003)(6506007)(7696005)(256004)(86362001)(9686003)(55236004)(102836004)(478600001)(33656002)(105586002)(3846002)(106356001)(2900100001)(97736004)(2906002)(8936002)(81166006)(53936002)(81156014)(6246003)(6116002)(68736007)(66066001)(8676002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2416;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Rm8kLYb0Ybr1+kf9NIcTbq7cH3y5uzpIJyZwS79OxnTsfn33MWhzyIaNsEcP0nu9ANVy7u7AVP2wuhXbsK8sN9m8KYjKJglhi+4/NbCif/NIY+2bCW3oqJgHyaJbKhzdEozCC0da26nEI7lhl7Tsk5P5RfPZbsQTPE0CQ5/25KlrtHOd1gOX2pJ+hna4cEKQk0cI0B7pIra1CSbh8NwtNZUnMfza6erTW0ZHVcAiw1l7P6sEHI5Ykou7b9IRuDks1MHw7k/N/vGrEF7UQUG9474xorzbLFFIFua4aA6bf38ohjKQW8IblHEI77IeAZEEl3xm1CGvoZhgVHu686EWZNfCymd/5CNoiO35ok7xYAs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625e47ae-4106-4fe5-27e2-08d5ee570b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 15:39:56.1843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBNYXRoaWFzLA0KDQpUaGFua3MgZm9yIHByb3ZpZGluZyB5b3VyIGNvbW1lbnRzLCBwbGVh
c2UgZmluZCBteSBjb21tZW50cyBpbmxpbmUNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+RnJvbTogTWF0aGlhcyBOeW1hbiBbbWFpbHRvOm1hdGhpYXMubnltYW5AaW50ZWwuY29tXQ0K
PlNlbnQ6IEZyaWRheSwgSnVseSAyMCwgMjAxOCA4OjEzIFBNDQo+VG86IEFudXJhZyBLdW1hciBW
dWxpc2hhIDxhbnVyYWdrdUB4aWxpbnguY29tPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+PGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPkNjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBo
b3N0OiB4aGNpLXBsYXQ6IEl0ZXJhdGUgb3ZlciBwYXJlbnQgbm9kZXMgZm9yIGZpbmRpbmcgcXVp
cmtzDQo+DQo+SGkNCj4NCj5Tb3JyeSBhYm91dCB0aGUgZGVsYXkgd2l0aCB0aGlzIHBhdGNoLA0K
PkkgaGF2ZSBhIGNvdXBsZSBjb21tZW50cyBpbmxpbmUuDQo+DQoNCk5vIHByb2JzLCBJICBjYW4g
dW5kZXJzdGFuZC4gSSB3YXMgaGF2aW5nIHNvbWUgaW50ZXJuYWwgZGVwZW5kZW5jeSBvbiB0aGlz
IHBhdGNoLA0Kc28gcGluZ2VkIGFnYWluLiBTb3JyeSBmb3IgdHJvdWJsaW5nIHlvdS4NCg0KPk9u
IDA1LjA2LjIwMTggMTg6MjAsIEFudXJhZyBLdW1hciBWdWxpc2hhIHdyb3RlOg0KPj4gSW4geGhj
aV9wbGF0X3Byb2JlKCkgYm90aCBzeXNkZXYgYW5kIHBkZXYtPmRldiBhcmUgYmVpbmcgdXNlZCBm
b3INCj4+IGZpbmRpbmcgcXVpcmtzLiBUaGVyZSBhcmUgc29tZSBkcml2ZXJzKGxpa2UgZHdjMyBo
b3N0LmMpIHdoaWNoIGFkZHMNCj4+IHF1aXJrcyhsaWtlIHVzYjMtbHBtLWNhcGFibGUpIGludG8g
cGRldiBhbmQgdGhlIGxvZ2ljIHByZXNlbnQgaW4NCj4+IHhoY2lfcGxhdF9wcm9iZSgpIGNoZWNr
cyBmb3IgcXVpcmtzIGluIGVpdGhlciBzeXNkZXYgb3IgcGRldiBmb3INCj4+IGZpbmRpbmcgdGhl
IHF1aXJrcy4gQmVjYXVzZSBvZiB0aGlzIGxvZ2ljLCBzb21lIG9mIHRoZSBxdWlya3MgYXJlDQo+
PiBnZXR0aW5nIG1pc3NlZCh1c2IzLWxwbS1jYXBhYmxlIHF1aXJrIGFkZGVkIGJ5IGR3YzMgaG9z
dC5jIGRyaXZlciBpcw0KPj4gZ2V0dGluZyBtaXNzZWQpLlRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBi
eSBpdGVyYXRpbmcgb3ZlciBhbGwgdGhlDQo+PiBhdmFpbGFibGUgcGFyZW50cyBmb3IgZmluZGlu
ZyB0aGUgcXVpcmtzLiBJbiB0aGlzIHdheSBhbGwgdGhlIHF1aXJrcw0KPj4gd2hpY2ggYXJlIHBy
ZXNlbnQgaW4gY2hpbGQgb3IgcGFyZW50IGFyZSBjb3JyZWN0bHkgdXBkYXRlZC4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBBbnVyYWcgS3VtYXIgVnVsaXNoYSA8YW51cmFnLmt1bWFyLnZ1bGlzaGFA
eGlsaW54LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGxhdC5jIHwg
MjkgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktcGxhdC5jDQo+PiBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wbGF0
LmMgaW5kZXggYzFiMjJmYy4uMGNkMDQ4OSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2hv
c3QveGhjaS1wbGF0LmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wbGF0LmMNCj4+
IEBAIC0xNTIsNyArMTUyLDcgQEAgc3RhdGljIGludCB4aGNpX3BsYXRfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgew0KPj4gICAJY29uc3Qgc3RydWN0IHhoY2lfcGxh
dF9wcml2ICpwcml2X21hdGNoOw0KPj4gICAJY29uc3Qgc3RydWN0IGhjX2RyaXZlcgkqZHJpdmVy
Ow0KPj4gLQlzdHJ1Y3QgZGV2aWNlCQkqc3lzZGV2Ow0KPj4gKwlzdHJ1Y3QgZGV2aWNlCQkqc3lz
ZGV2LCAqdG1wZGV2Ow0KPj4gICAJc3RydWN0IHhoY2lfaGNkCQkqeGhjaTsNCj4+ICAgCXN0cnVj
dCByZXNvdXJjZSAgICAgICAgICpyZXM7DQo+PiAgIAlzdHJ1Y3QgdXNiX2hjZAkJKmhjZDsNCj4+
IEBAIC0yNzIsMTkgKzI3MiwyNiBAQCBzdGF0aWMgaW50IHhoY2lfcGxhdF9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICAJCWdvdG8gZGlzYWJsZV9jbGs7DQo+PiAgIAl9
DQo+Pg0KPj4gLQlpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChzeXNkZXYsICJ1c2IyLWxw
bS1kaXNhYmxlIikpDQo+PiAtCQl4aGNpLT5xdWlya3MgfD0gWEhDSV9IV19MUE1fRElTQUJMRTsN
Cj4+ICsJLyogSXRlcmF0ZSBvdmVyIGFsbCBwYXJlbnQgbm9kZXMgZm9yIGZpbmRpbmcgcXVpcmtz
ICovDQo+PiArCWZvciAodG1wZGV2ID0gJnBkZXYtPmRldjsgdG1wZGV2OyB0bXBkZXYgPSB0bXBk
ZXYtPnBhcmVudCkgew0KPg0KPklzbid0IHN5c2RldiBhdCB0aGlzIHBvaW50IHRoZSB0b3Btb3N0
IGRldmljZSB0aGF0IGNhbiBoYXZlIGFueSBvZiB0aG9zZSBkZXZpY2UNCj5wcm9wZXJ0aWVzIHNl
dD8NCj5XZSBjb3VsZCBsb29wIGZyb20gJnBkZXYtPmRldiB1cCB0byBhbmQgaW5jbHVkaW5nIHN5
c2Rldi4NCj4NCj5JdCBkb2Vzbid0IG1hdHRlciBtdWNoIGJ1dCBtYXliZSBhdm9pZCB3YWxraW5n
IHNvbWUgZXh0cmEgcGFyZW50cy4NCj4NCg0KSSBoYXZlIHNlZW4gc29tZSBkcml2ZXJzICggbGlr
ZSBkd2MzIGhvc3QuYykgd2hpY2ggY3JlYXRlIGEgY2hpbGQgZGV2LCB3aGljaCBpcw0KdGhlIHBk
ZXYgdGhhdCBpcyBiZWluZyBwYXNzZWQgdG8geGhjaV9wbGF0X3Byb2JlKCkuIFNvLCBzeXNkZXYg
bWF5IG5vdCBiZSB0aGUNCnRvcG1vc3QgcGFyZW50LiBUaGVyZSBjb3VsZCBiZSBzb21lIHByb3Bl
cnRpZXMgd2hpY2ggbWF5IGJlIHByZXNlbnQgaW4gcGFyZW50DQphbmQgbWF5IG5vdCBiZSBwb3B1
bGF0ZWQgaW4gdGhlIGNoaWxkLiBTbywgSSBtYWRlIHRoaXMgY2hhbmdlIHRvIHNlYXJjaCBvbiBh
bGwNCmF2YWlsYWJsZSBwYXJlbnRzIGZvciBmaW5kaW5nIGEgdmFsaWQgcHJvcGVydHkNCg0KPj4N
Cj4+IC0JaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woc3lzZGV2LCAidXNiMy1scG0tY2Fw
YWJsZSIpKQ0KPj4gLQkJeGhjaS0+cXVpcmtzIHw9IFhIQ0lfTFBNX1NVUFBPUlQ7DQo+PiArCQlp
ZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbCh0bXBkZXYsICJ1c2IyLWxwbS1kaXNhYmxlIikp
DQo+PiArCQkJeGhjaS0+cXVpcmtzIHw9IFhIQ0lfSFdfTFBNX0RJU0FCTEU7DQo+Pg0KPj4gLQlp
ZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbCgmcGRldi0+ZGV2LCAicXVpcmstYnJva2VuLXBv
cnQtcGVkIikpDQo+PiAtCQl4aGNpLT5xdWlya3MgfD0gWEhDSV9CUk9LRU5fUE9SVF9QRUQ7DQo+
PiArCQlpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbCh0bXBkZXYsICJ1c2IzLWxwbS1jYXBh
YmxlIikpDQo+PiArCQkJeGhjaS0+cXVpcmtzIHw9IFhIQ0lfTFBNX1NVUFBPUlQ7DQo+Pg0KPj4g
LQkvKiBpbW9kX2ludGVydmFsIGlzIHRoZSBpbnRlcnJ1cHQgbW9kZXJhdGlvbiB2YWx1ZSBpbiBu
YW5vc2Vjb25kcy4gKi8NCj4+IC0JeGhjaS0+aW1vZF9pbnRlcnZhbCA9IDQwMDAwOw0KPg0KPlNl
dHRpbmcgdGhlIGRlZmF1bHQgaW1vZF9pbnRlcnZhbCBjb3VsZCBiZSBtb3ZlZCBiZWZvcmUgdGhl
IGZvcigpIGxvb3ANCj4NCg0KSSB0aG91Z2h0IGl0IHdvdWxkIGJlIGJldHRlciBpZiBldmVyeXRo
aW5nIHJlbGF0ZWQgdG8gaW1vZF9pbnRlcnZhbCBpcyBpbiBvbmUgcGxhY2UsIA0Kc28ga2VwdCBp
dCBhcyBpcy4gSSBjYW4gZml4IHRoaXMgaW4gdjIgaWYgeW91IHN1Z2dlc3QuDQoNCj4+IC0JZGV2
aWNlX3Byb3BlcnR5X3JlYWRfdTMyKHN5c2RldiwgImltb2QtaW50ZXJ2YWwtbnMiLA0KPj4gLQkJ
CQkgJnhoY2ktPmltb2RfaW50ZXJ2YWwpOw0KPj4gKwkJaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFk
X2Jvb2wodG1wZGV2LCAicXVpcmstYnJva2VuLXBvcnQtcGVkIikpDQo+PiArCQkJeGhjaS0+cXVp
cmtzIHw9IFhIQ0lfQlJPS0VOX1BPUlRfUEVEOw0KPj4gKw0KPj4gKwkJLyoNCj4+ICsJCSAqIGlt
b2RfaW50ZXJ2YWwgaXMgdGhlIGludGVycnVwdCBtb2RlcmF0aW9uDQo+PiArCQkgKiB2YWx1ZSBp
biBuYW5vc2Vjb25kcy4NCj4+ICsJCSAqLw0KPj4gKwkJeGhjaS0+aW1vZF9pbnRlcnZhbCA9IDQw
MDAwOw0KPj4gKwkJZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKHRtcGRldiwgImltb2QtaW50ZXJ2
YWwtbnMiLA0KPj4gKwkJCQkJICZ4aGNpLT5pbW9kX2ludGVydmFsKTsNCj4+ICsJfQ0KPj4NCj4+
ICAgCWhjZC0+dXNiX3BoeSA9IGRldm1fdXNiX2dldF9waHlfYnlfcGhhbmRsZShzeXNkZXYsICJ1
c2ItcGh5IiwgMCk7DQo+PiAgIAlpZiAoSVNfRVJSKGhjZC0+dXNiX3BoeSkpIHsNCj4+DQo+DQo+
T3RoZXJ3aXNlIGV2ZXJ5dGhpbmcgbG9va3MgZmluZS4NCj5JIHdpbGwgdW5mb3J0dW5hdGVseSBi
ZSBhd2F5IGFnYWluIGZvciBhbm90aGVyIHR3byB3ZWVrcy4NCg0KTm8gcHJvYnMuIElmIHlvdSBm
ZWVsIHRoZXJlIGlzIG5vIGhhcm0gaW4gYXBwbHlpbmcgYW5kIHNhdGlzZmllZCB3aXRoIHRoZSBj
aGFuZ2VzLCBpdA0Kd291bGQgYmUgaGVscGZ1bCBpZiB5b3UgY2FuIGFwcGx5IHRoaXMgcGF0Y2gu
IFRoaXMgaXMgYmVjYXVzZSBJIGhhdmUgc29tZSBkZXBlbmRlbmN5DQpvbiB0aGlzIHBhdGNoIHdh
aXRpbmcgIHRvIGJlIGFwcGxpZWQuIFNvcnJ5IGZvciB0cm91YmxpbmcgeW91IGFnYWluLg0KDQpU
aGFua3MsDQpBbnVyYWcgS3VtYXIgVnVsaXNoYQ0KDQo+DQo+LU1hdGhpYXMNCg==
