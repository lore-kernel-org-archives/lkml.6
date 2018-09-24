Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C8ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115752087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VWZIm8bD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115752087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbeIXUwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:50 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:44640
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388287AbeIXUwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx/HLT6UXxeZQ452/+uMG/xel7TlVyc0ItjFgSMgK1M=;
 b=VWZIm8bD8mn5TqdMZndsNeKHxqZ9KO+HeeM/Iqv9l+Hp4KWHT9uNj3sEzlDqJzUgebtQnjYBRmc0uhqgOFmbKR0OHFmDB1mAbFiHRsGHGcH2ru/aRrWrb9+lRKHBkNzDQH5WrR5cRhp00OiqwJqxWF+kVA4GiTv5U+F11VKyRu0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Raspl <stefan.raspl@de.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 18/36] tools/kvm_stat: fix python3 issues
Thread-Topic: [PATCH AUTOSEL 4.14 18/36] tools/kvm_stat: fix python3 issues
Thread-Index: AQHUVBW8BC6S1IBkFEGZr1pLZso70A==
Date:   Mon, 24 Sep 2018 14:49:04 +0000
Message-ID: <20180924144851.164533-18-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:9wrcqIolQ+0k+rTN0hmh+vHg3TD+XctCPDROGULl64BnkDtW6Xiha73oBCUaHgszDfShiwHZVocNj/gmz9+7sn8LgUXpfC9qwJZ9rBXCaMM4nOr+980zhXkIar+tyCkEUH8uVRdcDRRv1oOurivFUOzCrYDZXLXD8pkGi3dRGgxlruXhMNW3cCKdbdJ/pcMHPdFxWJgpy1m2MiOYsnNJMPpSXWV2Wdrz8U2aeV5qju/2sFXVeq0EY/GWYGDtwMMrgMMgvRF8ZHuPM7WsK34gQv+H+WhupokVH763/xC/E7hOTibtfG5Os0X8mK3Wkpp+6QzA6+n8WC5SHXpE8H/G8ae3R9tq7IbAU+sL1Qlllm5Kig//oj9vbJXRe1JvBdmOHnKwOCM2jDgwVMEQlI2gJvH+wga0Rqyaru6yk7noNx/xHWxtDDRDQQsENxNspc4taC2vAG6wHuBlHkFBL5k14Q==;5:py+i0Q3aTbMrGrko98uOLvNAFmV9F5Qfx97jyXG25gkJLj0tbHVA/CYbAhwWRx/k1dEfS81cee9L7hsLm/k07qQhom6dCeOzacp4bDvjqBgw36hh3IA6kNi0MQgZWWuz1miiWahryXdvJZu18wWYxbi7Je3URgjXhvalGZkN3r8=;7:3zgoYMKZ4FcPS+4m5uCIF6KuQU9oCUOKZMrPnwZJ+vddDcgv+8v/cVCiQi5CuVKtm/bGpYAuTrY3T4O0W/RkCMyDnhULAwoWSM5uWfkLMQLYtph/48yfVTJoV36YfD+JgExFqkS+1vQegMCDa0A13qTUI6v/c8OtXBRQ2KYhc0QkqEeZYVQSuXdQTgMZdvloJYzjtFiQAX+kPmJ+9zvDSjdLrz++whBjH2pp4X+C8FP9RTnHGcJ4RWopnFz64si7
x-ms-office365-filtering-correlation-id: 70525526-a821-4d59-2aa8-08d6222d0a00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181CD4F6E7D1B03C2C4D78EFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190383065149520)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +eReF3FcluUc7e5PE4EaC0+dk0FmnRcQ63FBnKZQAkWQsirpM9NmnuwI2DkzYL8Zqb/GN5tjYC/415MmVhHgAlJunpki4MDzrVN3FCU1n8teFlchXMiABWCarxiPhj9ELX3qAab1vepUWlM7gJgGswdHVxT69B6bTCVamtcEen5OvZktsK+6/O6Lp4Lt75C14/kOqS79SiE7XK/vM2EkTa3EpQig8m+jLtU0zDxTwh96OnQNQNgO46XunQjgWPg1QC0QTbHzzike9R9pp0KhMMh18uSM6AYaXTAmLzoc0TTUdBiu8NDnCUZGKwS1OEFJTiOmRH6uEx11wzKxRb34vN0H1tJ6Mw666DkdpCVZ9R8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BBDFC8103BB2A4E865C34158BB0106E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70525526-a821-4d59-2aa8-08d6222d0a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:04.2721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlZmFuIFJhc3BsIDxzdGVmYW4ucmFzcGxAZGUuaWJtLmNvbT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgNThmMzNjZmU3MzA3NmI2NDk3YmFkYTRmN2I1YmRhOTYxZWQ2ODA4MyBdDQoNClB5
dGhvbjMgcmV0dXJucyBhIGZsb2F0IGZvciBhIHJlZ3VsYXIgZGl2aXNpb24gLSBzd2l0Y2ggdG8g
YSBkaXZpc2lvbg0Kb3BlcmF0b3IgdGhhdCByZXR1cm5zIGFuIGludGVnZXIuDQpGdXJ0aGVybW9y
ZSwgZmlsdGVycyByZXR1cm4gYSBnZW5lcmF0b3Igb2JqZWN0IGluc3RlYWQgb2YgdGhlIGFjdHVh
bA0KbGlzdCAtIHdyYXAgcmVzdWx0IGluIHlldCBhbm90aGVyIGxpc3QsIHdoaWNoIG1ha2VzIGl0
IHN0aWxsIHdvcmsgaW4NCmJvdGgsIFB5dGhvbjIgYW5kIDMuDQoNClNpZ25lZC1vZmYtYnk6IFN0
ZWZhbiBSYXNwbCA8cmFzcGxAbGludXguaWJtLmNvbT4NClNpZ25lZC1vZmYtYnk6IFJhZGltIEty
xI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4g
PGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogdG9vbHMva3ZtL2t2bV9zdGF0
L2t2bV9zdGF0IHwgNiArKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMva3ZtL2t2bV9zdGF0L2t2bV9zdGF0
IGIvdG9vbHMva3ZtL2t2bV9zdGF0L2t2bV9zdGF0DQppbmRleCAzMjI4M2Q4ODcwMWEuLjQwY2Y2
NGM3YWMzYiAxMDA3NTUNCi0tLSBhL3Rvb2xzL2t2bS9rdm1fc3RhdC9rdm1fc3RhdA0KKysrIGIv
dG9vbHMva3ZtL2t2bV9zdGF0L2t2bV9zdGF0DQpAQCAtNzI0LDcgKzcyNCw3IEBAIGNsYXNzIERl
YnVnZnNQcm92aWRlcihQcm92aWRlcik6DQogICAgICAgICAgICAgaWYgbGVuKHZtcykgPT0gMDoN
CiAgICAgICAgICAgICAgICAgc2VsZi5kb19yZWFkID0gRmFsc2UNCiANCi0gICAgICAgICAgICBz
ZWxmLnBhdGhzID0gZmlsdGVyKGxhbWJkYSB4OiAie30tIi5mb3JtYXQocGlkKSBpbiB4LCB2bXMp
DQorICAgICAgICAgICAgc2VsZi5wYXRocyA9IGxpc3QoZmlsdGVyKGxhbWJkYSB4OiAie30tIi5m
b3JtYXQocGlkKSBpbiB4LCB2bXMpKQ0KIA0KICAgICAgICAgZWxzZToNCiAgICAgICAgICAgICBz
ZWxmLnBhdGhzID0gW10NCkBAIC0xMTE5LDEwICsxMTE5LDEwIEBAIGNsYXNzIFR1aShvYmplY3Qp
Og0KICAgICAgICAgKHgsIHRlcm1fd2lkdGgpID0gc2VsZi5zY3JlZW4uZ2V0bWF4eXgoKQ0KICAg
ICAgICAgcm93ID0gMg0KICAgICAgICAgZm9yIGxpbmUgaW4gdGV4dDoNCi0gICAgICAgICAgICBz
dGFydCA9ICh0ZXJtX3dpZHRoIC0gbGVuKGxpbmUpKSAvIDINCisgICAgICAgICAgICBzdGFydCA9
ICh0ZXJtX3dpZHRoIC0gbGVuKGxpbmUpKSAvLyAyDQogICAgICAgICAgICAgc2VsZi5zY3JlZW4u
YWRkc3RyKHJvdywgc3RhcnQsIGxpbmUpDQogICAgICAgICAgICAgcm93ICs9IDENCi0gICAgICAg
IHNlbGYuc2NyZWVuLmFkZHN0cihyb3cgKyAxLCAodGVybV93aWR0aCAtIGxlbihoaW50KSkgLyAy
LCBoaW50LA0KKyAgICAgICAgc2VsZi5zY3JlZW4uYWRkc3RyKHJvdyArIDEsICh0ZXJtX3dpZHRo
IC0gbGVuKGhpbnQpKSAvLyAyLCBoaW50LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1
cnNlcy5BX1NUQU5ET1VUKQ0KICAgICAgICAgc2VsZi5zY3JlZW4uZ2V0a2V5KCkNCiANCi0tIA0K
Mi4xNy4xDQo=
