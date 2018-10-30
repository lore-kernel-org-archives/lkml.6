Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16319C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AB02081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="RFIKp/iH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AB02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJ3VWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:22:25 -0400
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:55120
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbeJ3VWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDYWgPJqFaSgdClnj6d/7zdWqF1CVsT1ndzrcukfXsk=;
 b=RFIKp/iHPV2oK5sZ15ARrM33lsHe72OXIGEbVLbE/VTMmtpw+XQODp4L9dSY8l4avNXjJr3izeDUEkEzBeiOWvqZdnagiR0UiCzZ0qn+XzKSm0g+ophMntp2HOMJzbDUPSckCS2R30WvJFnrOZCFRoVw3xAE4qWTI+suG/W7lJY=
Received: from BYAPR07MB4920.namprd07.prod.outlook.com (52.135.237.93) by
 BYAPR07MB5383.namprd07.prod.outlook.com (20.177.125.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.20; Tue, 30 Oct 2018 12:29:07 +0000
Received: from BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5]) by BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5%4]) with mapi id 15.20.1273.028; Tue, 30 Oct 2018
 12:29:07 +0000
From:   George Cherian <gcherian@caviumnetworks.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        "Cherian, George" <George.Cherian@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3] xhci: Add quirk to workaround the errata seen on
 Cavium Thunder-X2 Soc
Thread-Topic: [PATCH v3] xhci: Add quirk to workaround the errata seen on
 Cavium Thunder-X2 Soc
Thread-Index: AQHUcD4detu6/VwpiUybz2IrVAWqaaU3pl+AgAARX4A=
Date:   Tue, 30 Oct 2018 12:29:07 +0000
Message-ID: <f218c1fb-dd5f-3d45-52e3-1825118cd1de@caviumnetworks.com>
References: <1540896507-23876-1-git-send-email-george.cherian@cavium.com>
 <d450f63d-b1ed-afe2-4bde-4d1aa246d079@intel.com>
In-Reply-To: <d450f63d-b1ed-afe2-4bde-4d1aa246d079@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::23) To BYAPR07MB4920.namprd07.prod.outlook.com
 (2603:10b6:a03:55::29)
x-originating-ip: [111.93.218.67]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5383;6:lXAiZXyHBAGNb6DNxxaKrd5Zr6xA2UlkA1Ft7k1wuhIw47Xrnb7f07oIao2v/O9CtSqN/YZrL4eurdLY9lFwg+iGhCXcalri3I01lq77YXhxMSoZ/mntidqiBBuA6D1kKWhBu75LxyJjqG6dnIeHFbub9f8GGgKURN8qkNHfnDs4V6g2XleDnzNDboX7KrPEmJ8O8OwLCK8TcYfOpTph4hNtlSB1aV2N7z6w/bOR5cmi1Lb1lQVhpTps/GdrffDIglOjQr3dg4uvXvacmwWFowx/xitWj51tKjp4JSkUraTZ9K1alVlyFXUkEG7IhIIOjo8n6w0dne1NWLqpYHZYZD9MTZP3YB46FTViKDMgRZU2guD1T82BfszjmoYhOql6Gn7tjfUXtvyxGpQ7tYdAKfhjpefNxbASvFgr2arNsWzpnJ4ZV195Zndm0CNTaXPIq+PCH4djpZsmXIQ5jxYDcg==;5:XZjRRwBqCeYRk3wq85lSxzKiRP+Y3Uvd+n8rH8aJ1FZL7q3vIB9G547Btm/4k3o6wMth7R+3wy43AbX+5rieEkjVS7Z/K3JJAFUE53XzBsyOp3uNl7ZBPj8mN08mNrz2pzvnWf2uf4DMn+zVU66o5Gg68k26ZIJ2/NPUPqLXOCM=;7:PJkZj9o3LIomOKg7Erm/7OoqJ77psurk4Q6ffohnemv6oMWVmxt51F4oeCmx/TlbNueystjoi+BYyRK94MN2jwImCk+X6QQCgMUl6x0/Jn1KZ42XeiCVDdoe+kFrmgZ38+Vd/6uHXiRcq4+44UvQdw==
x-ms-office365-filtering-correlation-id: 9ebdcfa7-bb10-4a45-1188-08d63e6348f7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5383;
x-ms-traffictypediagnostic: BYAPR07MB5383:
x-microsoft-antispam-prvs: <BYAPR07MB53832300AD20CC760248FB74F9CC0@BYAPR07MB5383.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5383;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5383;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(52116002)(53936002)(31696002)(186003)(6116002)(256004)(6512007)(2501003)(26005)(4326008)(3846002)(5250100002)(25786009)(14444005)(2201001)(316002)(76176011)(2906002)(72206003)(6436002)(99286004)(386003)(53546011)(102836004)(6506007)(14454004)(6486002)(478600001)(105586002)(305945005)(106356001)(110136005)(6246003)(68736007)(54906003)(446003)(486006)(11346002)(476003)(2616005)(36756003)(5660300001)(42882007)(66066001)(71200400001)(81166006)(7736002)(81156014)(71190400001)(97736004)(8936002)(78486012)(2900100001)(31686004)(229853002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5383;H:BYAPR07MB4920.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OTGE3cJVXlgoFaWmJQzkHXVPlyYHoKSwcHWpLXbEJ66iPbmwJHhfTmEk6osgnMntuT33WyjVOrlXUY0VQ1QReQlBATaoFRvDLw7rcnMCt4kMYRGs9YRSq3Le3M6fvCXrkgHwtZIVlQZEnf+ANq1UZCofIoKB6UKyrIjEVMTj8U7febvmiA23VqKln234holl7M4rfSltu0acQ5NwD4n4PLGuFs3JxGB3f7dA8I+4LqjVkDlR+4+FkB73lXqPsAWHDYb+bdZu3LJLaFq37is0Z6uvWF/0ThBJXyPfnjpWN582cnL/JivInVpdRJ+5VOSXY4vNtqYXsxI2jlu4veUMNNLJa8hB7or8D4AxPq6/pH0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA1EAE03E747DE408D18B6D35916FE4D@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebdcfa7-bb10-4a45-1188-08d63e6348f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 12:29:07.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzMwLzIwMTggMDQ6NTYgUE0sIE1hdGhpYXMgTnltYW4gd3JvdGU6DQo+IA0KPiBP
biAzMC4xMC4yMDE4IDEyOjQ4LCBDaGVyaWFuLCBHZW9yZ2Ugd3JvdGU6DQo+PiBJbXBsZW1lbnQg
d29ya2Fyb3VuZCBmb3IgVGh1bmRlclgyIEVycmF0YS0xMjkgKGRvY3VtZW50ZWQgaW4NCj4+IENO
OTlYWCBLbm93biBJc3N1ZXMiIGF2YWlsYWJsZSBhdCBDYXZpdW0gc3VwcG9ydCBzaXRlKS4NCj4+
IEFzIHBlciBUaHVuZGVyWDJlcnJhdGEtMTI5LCBVU0IgMiBkZXZpY2UgbWF5IGNvbWUgdXAgYXMg
VVNCIDENCj4+IGlmIGEgY29ubmVjdGlvbiB0byBhIFVTQiAxIGRldmljZSBpcyBmb2xsb3dlZCBi
eSBhbm90aGVyIGNvbm5lY3Rpb24gdG8NCj4+IGEgVVNCIDIgZGV2aWNlLCB0aGUgbGluayB3aWxs
IGNvbWUgdXAgYXMgVVNCIDEgZm9yIHRoZSBVU0IgMiBkZXZpY2UuDQo+Pg0KPj4gUmVzb2x1dGlv
bjogUmVzZXQgdGhlIFBIWSBhZnRlciB0aGUgVVNCIDEgZGV2aWNlIGlzIGRpc2Nvbm5lY3RlZC4N
Cj4+IFRoZSBQSFkgcmVzZXQgc2VxdWVuY2UgaXMgZG9uZSB1c2luZyBwcml2YXRlIHJlZ2lzdGVy
cyBpbiBYSENJIHJlZ2lzdGVyDQo+PiBzcGFjZS4gQWZ0ZXIgdGhlIFBIWSBpcyByZXNldCB3ZSBj
aGVjayBmb3IgdGhlIFBMTCBsb2NrIHN0YXR1cyBhbmQgcmV0cnkNCj4+IHRoZSBvcGVyYXRpb24g
aWYgaXQgZmFpbHMuIEZyb20gb3VyIHRlc3RzLCByZXRyeWluZyA0IHRpbWVzIGlzIA0KPj4gc3Vm
ZmljaWVudC4NCj4+DQo+PiBBZGQgYSBuZXcgcXVpcmsgZmxhZyBYSENJX1JFU0VUX1BMTF9PTl9E
SVNDT05ORUNUIHRvIGludm9rZSB0aGUgDQo+PiB3b3JrYXJvdW5kDQo+PiBpbiBoYW5kbGVfeGhj
aV9wb3J0X3N0YXR1cygpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEdlb3JnZSBDaGVyaWFuIDxn
ZW9yZ2UuY2hlcmlhbkBjYXZpdW0uY29tPg0KPiANCj4gVGhhbmtzLCBhZGRpbmcgdG8gcXVldWUN
Cj4gDQpUaGFuayB5b3UhIQ0KPiAtTWF0aGlhcw0KDQpSZWdhcmRzLA0KLUdlb3JnZQ0K
