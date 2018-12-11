Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90916C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5257E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NsJfqBDG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EIzO26wJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5257E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeLKS4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:56:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56244 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbeLKS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:56:37 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBItY13002491;
        Tue, 11 Dec 2018 10:56:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HCLGWlhajdCJdc4QL/qT9mOjf+FnGcCGy/OXpBZfDgQ=;
 b=NsJfqBDGr3AVD4vXmc3Pfbc21q/8foKNQGozpCwZ5+mx+wq6wIN+NduLR4FXXT1wYfms
 RaCn0/4fRh5p2y7eACKyyoYSPkQsVMv82BQxssT+rXQWPHjoHzo9U9OUnBHTNkHj7rc8
 1GyDPJKxiQxluBYx0Vm8yIx+s/ojSxhTuqA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pajq2g2pj-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Dec 2018 10:56:05 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 11 Dec 2018 10:55:42 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 11 Dec 2018 10:55:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCLGWlhajdCJdc4QL/qT9mOjf+FnGcCGy/OXpBZfDgQ=;
 b=EIzO26wJC8byITjbiCORp4SWOtWrJLUFS5VpNjD9IbCM5z1FsEA5y2HRqAwxz4KHcp2wqhcRkdQJU4KTMxaUg9x+ysx1yKdkF1L8z0LgPklMikbxS2xPLKJ+vv+TZvv2Z95gvjRQhoKCF8Um+IPxFFIc+ntPsptXzN2jhHHAU4k=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1575.namprd15.prod.outlook.com (10.172.162.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 18:55:40 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04%10]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 18:55:40 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add KCS support for LPC BMC
Thread-Topic: [PATCH 2/2] ARM: dts: aspeed: Add KCS support for LPC BMC
Thread-Index: AQHUkMQadqffnRxH00yiBMxy3CyvtqV54DcA//9+W4A=
Date:   Tue, 11 Dec 2018 18:55:40 +0000
Message-ID: <CA2566BA-428C-4D5A-8B37-835638252B0C@fb.com>
References: <20181210200753.3018124-1-vijaykhemka@fb.com>
 <20181210200753.3018124-3-vijaykhemka@fb.com>
 <584ddf6f-2e0c-5c1c-df06-bdd37ecd2489@linux.intel.com>
In-Reply-To: <584ddf6f-2e0c-5c1c-df06-bdd37ecd2489@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::5:caa3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1575;20:nJU8tA60UtlQu3ZRHqtX9QyXMw1+MUkYbxifazNnC+fgT/i6tHqLkxJbFnL5HDJzHTQSUMg+PerPw8AJAGS00iXHm+ONuYMRUGuE7FSEL4oVTiYrYGWr+w5Bx73JvkmKAbxnvS8Ed3ZhEIvSWnjo63NDL5Fr5hG3d6BMDSRWjLY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a580fd8a-a5a9-4ff1-e573-08d65f9a3ee4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1575;
x-ms-traffictypediagnostic: CY4PR15MB1575:
x-microsoft-antispam-prvs: <CY4PR15MB1575FAFD271C771AC986A3BADDA60@CY4PR15MB1575.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(11241501185)(944501520)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1575;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1575;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(43544003)(106356001)(8676002)(99286004)(82746002)(6246003)(36756003)(105586002)(53936002)(2906002)(6512007)(110136005)(2201001)(575784001)(8936002)(86362001)(305945005)(81166006)(81156014)(14454004)(14444005)(7736002)(256004)(7416002)(5660300001)(6116002)(486006)(83716004)(76176011)(2616005)(53546011)(11346002)(102836004)(446003)(476003)(6506007)(6486002)(97736004)(478600001)(71190400001)(71200400001)(2501003)(46003)(68736007)(33656002)(186003)(6436002)(25786009)(4326008)(229853002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1575;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y/0Gtfb7YldlFj+4WIXdPgH7pkL5kgwqZPCbNZcROB51mkdsOdMfDqzimchX9gnqx8TIrmXMUOByaYtPbZp/8IQxhMIduEPR7j3U1XMtby2XYrgp3fCefhB0ZDPHDTqt3qCG6EMxSMVrAnhUb5jheEfIU1G+ixY4tUNqDW8fuItAYx65WUsFUk2qDEMlz2E05YvLlBOoibAQUVy7cKLBImxFaRfsaIH2W8l+PIJ5oKPYmmkPye/Z80cTBoJP0yh8YPMZKUEJQ8/OCFzSBJvGo7DBuSmC0ugwWrFvYrEqFD0fH+ekwkXjKg+MSjtxgaFa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E0B8371460E964098B5D00D6F51865E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a580fd8a-a5a9-4ff1-e573-08d65f9a3ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 18:55:40.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1575
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEpheSwNCkkgd2lsbCB0YWtlIGNhcmUgb2YgeW91ciBjb21tZW50cyBhbmQgc2VuZCBu
ZXh0IHZlcnNpb24uDQoNClJlZ2FyZHMNCi1WaWpheQ0KDQrvu79PbiAxMi8xMS8xOCwgMTA6NDAg
QU0sICJKYWUgSHl1biBZb28iIDxqYWUuaHl1bi55b29AbGludXguaW50ZWwuY29tPiB3cm90ZToN
Cg0KICAgIEhpIFZpamF5LA0KICAgIA0KICAgIE9uIDEyLzEwLzIwMTggMTI6MDcgUE0sIFZpamF5
IEtoZW1rYSB3cm90ZToNCiAgICA+IEFkZGVkIGtjcyBkZXZpY2Ugc3VwcG9ydCBmb3IgbHBjIEJN
Qy4NCiAgICA+IA0KICAgID4gU2lnbmVkLW9mZi1ieTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1r
YUBmYi5jb20+DQogICAgPiAtLS0NCiAgICA+ICAgYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWc1
LmR0c2kgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KICAgID4gICAxIGZpbGUg
Y2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KICAgID4gDQogICAgPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWc1LmR0c2kgYi9hcmNoL2FybS9i
b290L2R0cy9hc3BlZWQtZzUuZHRzaQ0KICAgID4gaW5kZXggZDEwNzQ1OWZjMGY4Li4xYmQ0ODY1
NWJhY2IgMTAwNjQ0DQogICAgPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtZzUuZHRz
aQ0KICAgID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWc1LmR0c2kNCiAgICA+IEBA
IC0zMzAsOCArMzMwLDM1IEBADQogICAgPiAgIAkJCQlyYW5nZXMgPSA8MHgwIDB4MWU3ODkwMDAg
MHgxMDAwPjsNCiAgICA+ICAgDQogICAgPiAgIAkJCQlscGNfYm1jOiBscGMtYm1jQDAgew0KICAg
ID4gLQkJCQkJY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjUwMC1scGMtYm1jIjsNCiAgICA+ICsJ
CQkJCWNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI1MDAtbHBjLWJtYywgInNpbXBsZS1tZmQiLCAi
c3lzY29uIiI7DQogICAgPiAgIAkJCQkJcmVnID0gPDB4MCAweDgwPjsNCiAgICA+ICsJCQkJCXJl
Zy1pby13aWR0aCA9IDw0PjsNCiAgICA+ICsNCiAgICA+ICsJCQkJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KICAgID4gKwkJCQkJI3NpemUtY2VsbHMgPSA8MT47DQogICAgPiArCQkJCQlyYW5nZXMg
PSA8MHgwIDB4MCAweDgwPjsNCiAgICA+ICsNCiAgICA+ICsJCQkJCWtjczE6IGtjczFAMCB7DQog
ICAgPiArCQkJCQkJY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjUwMC1rY3MtYm1jIjsNCiAgICA+
ICsJCQkJCQlyZWcgPSA8MHgwIDB4ODA+Ow0KICAgIA0KICAgIFRoaXMgcmVnIHByb3BlcnR5IGlz
bid0IG5lZWRlZCBhdCBoZXJlIGJlY2F1c2Uga2NzX2JtY19hc3BlZWQgbW9kdWxlDQogICAgcmVh
ZHMgcmVnbWFwIGZyb20gdGhlIHBhcmVudCBub2RlLiBQbGVhc2UgY2hlY2sgYmVsb3cgY29kZSBp
biB0aGUNCiAgICBkcml2ZXIgY29kZS4NCiAgICANCiAgICBwcml2LT5tYXAgPSBzeXNjb25fbm9k
ZV90b19yZWdtYXAoZGV2LT5wYXJlbnQtPm9mX25vZGUpOw0KICAgIA0KICAgID4gKwkJCQkJCWlu
dGVycnVwdHMgPSA8OD47DQogICAgPiArCQkJCQkJa2NzX2NoYW4gPSA8MT47DQogICAgPiArCQkJ
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAgICA+ICsJCQkJCX07DQogICAgPiArCQkJCQlrY3My
OiBrY3MyQDAgew0KICAgID4gKwkJCQkJCWNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI1MDAta2Nz
LWJtYyI7DQogICAgPiArCQkJCQkJcmVnID0gPDB4MCAweDgwPjsNCiAgICANCiAgICBkaXR0by4N
CiAgICANCiAgICA+ICsJCQkJCQlpbnRlcnJ1cHRzID0gPDg+Ow0KICAgID4gKwkJCQkJCWtjc19j
aGFuID0gPDI+Ow0KICAgID4gKwkJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogICAgPiArCQkJ
CQl9Ow0KICAgID4gKwkJCQkJa2NzMzoga2NzM0AwIHsNCiAgICA+ICsJCQkJCQljb21wYXRpYmxl
ID0gImFzcGVlZCxhc3QyNTAwLWtjcy1ibWMiOw0KICAgID4gKwkJCQkJCXJlZyA9IDwweDAgMHg4
MD47DQogICAgDQogICAgZGl0dG8uDQogICAgDQogICAgPiArCQkJCQkJaW50ZXJydXB0cyA9IDw4
PjsNCiAgICA+ICsJCQkJCQlrY3NfY2hhbiA9IDwzPjsNCiAgICA+ICsJCQkJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KICAgID4gKwkJCQkJfTsNCiAgICA+ICAgCQkJCX07DQogICAgPiAgIA0KICAg
ID4gICAJCQkJbHBjX2hvc3Q6IGxwYy1ob3N0QDgwIHsNCiAgICA+IA0KICAgIA0KICAgIFlvdSBt
aWdodCBuZWVkIHRvIGFkZCBrY3M0IGFzIGEgc3ViLW5vZGUgdW5kZXIgbHBjX2hvc3QgbGlrZSBi
ZWxvdzoNCiAgICANCiAgICBrY3M0OiBrY3M0QDAgew0KICAgIAljb21wYXRpYmxlID0gImFzcGVl
ZCxhc3QyNTAwLWtjcy1ibWMiOw0KICAgIAlpbnRlcnJ1cHRzID0gPDg+Ow0KICAgIAlrY3NfY2hh
biA9IDw0PjsNCiAgICAJc3RhdHVzID0gImRpc2FibGVkIjsNCiAgICB9Ow0KICAgIA0KICAgIFRo
aXMgd291bGQgYmUgdXNlcyBhcyBhbiBTTU0gY2hhbm5lbC4NCiAgICANCiAgICAtSmFlDQogICAg
DQoNCg==
