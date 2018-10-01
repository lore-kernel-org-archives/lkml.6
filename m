Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C76C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D717213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VIRiZIE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D717213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJBG3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:29:01 -0400
Received: from mail-eopbgr710102.outbound.protection.outlook.com ([40.107.71.102]:24480
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbeJBG3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RFvJx8SsFsYnMS9BeCJ/9FHjC1D1JWplA0ZOJM2cUA=;
 b=VIRiZIE4Hw+Hs1WcwNxXgITRKQdA+Y9EzgfCysgopdUAV6X5miGx8QDNvnsPRqp8/KwyGdgRBFoRuUpcMqy1ApORY3Vi3pliToP9EBNWWTVX2zQXZFBfoBOx8qm1xaYnYTyOlw014xuZbkG0TFKhL4X+Gzs5qfiUQQe1UC5udi8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0183.namprd21.prod.outlook.com (10.173.193.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 23:48:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.007; Mon, 1 Oct 2018
 23:48:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven French <Steven.French@microsoft.com>
Subject: Re: [PATCH AUTOSEL 4.18 39/65] fs/cifs: suppress a string overflow
 warning
Thread-Topic: [PATCH AUTOSEL 4.18 39/65] fs/cifs: suppress a string overflow
 warning
Thread-Index: AQHUWR8RZGXjAPgZrUO71mo1Ckr61KUJmEYAgAF4C4A=
Date:   Mon, 1 Oct 2018 23:48:43 +0000
Message-ID: <20181001234841.GF69414@sasha-vm>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
 <20181001003754.146961-39-alexander.levin@microsoft.com>
 <20181001112246.4dcbc4fd@canb.auug.org.au>
In-Reply-To: <20181001112246.4dcbc4fd@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0183;6:4pVz6llfNDHvBtVkiy1SXiAI7h2JWDR1vKGhPgH0NPD5CU8SFCKSHrsF2Kn519/pB2HqvM4npWp1faua8D+hNOWeWL0o1DIJu2yxq5c2PTwJpx83LfBy9wQP6rUqxshHmlO8EA9cGQAGavblDHyL324WjLQ5YvYTo92yF0swkvSNDnUGaOpyzGUJOOsHnUv7AjAnNFPUb6mmatGjZK1G7y0dsdY62Q880y0Tq8xUgh0SqQRuPCsDXqMZmmLJT31aD8P2ER+fbluysl6/Kp7zEQJfoc/AseQfaxcnPFjSIoW88O/DYbxnRpyPmQCskz94UQ5d3/ybJLnU8KGJOEmoDA9Qx++nf7X+Coso+23UFQl+YQVigVtHQtlcCNuPDU7TXYH7qeimTXEYHEbIksyne2KmFWpIlPF29FKOoX0iJR98ljPPn32e8XktiA8oyd/1YdqZDA7/cyrA/eW/AdwzeQ==;5:DWw6q0fMjWc4fwxWbjyTYlFe6yfEf/0HWu2U42xKv0+qukzNZkFiXIs0GCMy5qSpEPV0m5rS/Z0XzuSaPnBGtyMBu8xees34xmASoDK32Ncqs1SnlHMte6ryAn+YPl8Xj1TRbudBzrNFannB2mB9M0TPMSlvGkF393oQvk6MFZg=;7:gQ93wJxbs86+yVBP0laiSQbCfyQUZ9SaHXWbS7s37vmLXhIODuaXuApnec0VlX4z/+r3ZSOgMvrYWHH2je0DH/gHt+GwLirbE/9ngTNlLg5Q2EbIap0Nn72WEytCotH5clKTndz7aBBx8D9+JBIikOPszUHYDW8GSF8Sz1pLxpiF0dtWo9ETxpaLjxl5CAnU59dp0ngs/kUY+K0wloxK1SOI9NDzs9UmOQ0RF7Hb4kOrPH88zN9KM5PtqZfV77IJ
x-ms-office365-filtering-correlation-id: d2c5446f-ac92-40ea-25cb-08d627f86be5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0183;
x-ms-traffictypediagnostic: CY4PR21MB0183:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0183BFC86DB9D7BB364730EAFBEF0@CY4PR21MB0183.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0183;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0183;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(99286004)(6916009)(86612001)(478600001)(14454004)(6436002)(7736002)(53936002)(486006)(6246003)(54906003)(72206003)(217873002)(5660300001)(71190400001)(71200400001)(86362001)(33896004)(6486002)(66066001)(76176011)(2900100001)(256004)(9686003)(14444005)(6512007)(10090500001)(6506007)(2906002)(26005)(305945005)(33716001)(186003)(107886003)(22452003)(229853002)(3846002)(8676002)(6116002)(33656002)(1076002)(97736004)(81166006)(8936002)(5250100002)(11346002)(446003)(476003)(10290500003)(81156014)(25786009)(68736007)(102836004)(316002)(106356001)(105586002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0183;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EzQrlcegt/k4RSLtdi3jJEKOneYZcCc84L1p4Tb8cr+PEHM6adR5jcWyif8nYT6okvLXZ2FwoylZ03Y072X8IiWHStTKGDrcl0o5CddH3tc8Hqshq2BjUQLhsMGvPpN2K4ugzziOIKTYcuL38sJCk2m4g5XI3tBlJlWBg0o9GzRCJ+M1tTgHTatkVEFlG0FjdyFztnLxeTRgy82km9Vn9SrDkJGraxHyV78C5j0ec0EyYBH5u3OPCkoAtJXTtCdJOX1yK2pJUIgU/HN1WwXy1FDagpFXejotRqm06hHfPJ7JKHVFj13FTzWs+BFwzzNsuPxD39xGOjDPrpxsfoEmEmTLb/qsnj7882gUGFk0e/w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <234D26CBB809314F9922CCD77A8FCAD9@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c5446f-ac92-40ea-25cb-08d627f86be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 23:48:43.4215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMDEsIDIwMTggYXQgMTE6MjI6NDZBTSArMTAwMCwgU3RlcGhlbiBSb3Rod2Vs
bCB3cm90ZToNCj5IaSBTYXNoYSwNCj4NCj5PbiBNb24sIDEgT2N0IDIwMTggMDA6Mzg6MjcgKzAw
MDAgU2FzaGEgTGV2aW4gPEFsZXhhbmRlci5MZXZpbkBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4+
DQo+PiBGcm9tOiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5hdT4NCj4+DQo+
PiBbIFVwc3RyZWFtIGNvbW1pdCBiY2ZiODRhOTk2ZjZmYTkwYjVlNmUyOTU0YjJhY2NiN2E0NzEx
MDk3IF0NCj4+DQo+PiBBIHBvd2VycGMgYnVpbGQgb2YgY2lmcyB3aXRoIGdjYyB2OC4yLjAgcHJv
ZHVjZXMgdGhpcyB3YXJuaW5nOg0KPj4NCj4+IGZzL2NpZnMvY2lmc3NtYi5jOiBJbiBmdW5jdGlv
biDigJhDSUZTU01CTmVnb3RpYXRl4oCZOg0KPj4gZnMvY2lmcy9jaWZzc21iLmM6NjA1OjM6IHdh
cm5pbmc6IOKAmHN0cm5jcHnigJkgd3JpdGluZyAxNiBieXRlcyBpbnRvIGEgcmVnaW9uIG9mIHNp
emUgMSBvdmVyZmxvd3MgdGhlIGRlc3RpbmF0aW9uIFstV3N0cmluZ29wLW92ZXJmbG93PV0NCj4+
ICAgIHN0cm5jcHkocFNNQi0+RGlhbGVjdHNBcnJheStjb3VudCwgcHJvdG9jb2xzW2ldLm5hbWUs
IDE2KTsNCj4+ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fg0KPj4NCj4+IFNpbmNlIHdlIGFyZSBhbHJlYWR5IGRvaW5nIGEgc3RybGVu
KCkgb24gdGhlIHNvdXJjZSwgY2hhbmdlIHRoZSBzdHJuY3B5DQo+PiB0byBhIG1lbWNweSgpLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1dWcub3Jn
LmF1Pg0KPj4gU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNy
b3NvZnQuY29tPg0KPg0KPkp1c3Qgd29uZGVyaW5nIGlmIHRoaXMgc2hvdWxkIGJlIGluY2x1ZGVk
IGFzIGl0IG9ubHkgZml4ZXMgYSBidWlsZA0KPndhcm5pbmcsIHRoZXJlIGlzIG5vIGFjdHVhbCBi
dWcuICBTYW1lIGZvciB0aGUgNC45IGFuZCA0LjE0IHZlcnNpb25zLg0KDQpIaSBTdGVwaGVuLA0K
DQpXZSB0cnkgdG8gZm9sbG93IHRoZSBzYW1lIG5vLXdhcm5pbmdzIHBvbGljeSBsaWtlIHVwc3Ry
ZWFtIGFuZCB0YWtlDQp3YXJuaW5nIGZpeGVzIGludG8gc3RhYmxlIHRyZWUuIEl0IG1ha2VzIGl0
IHBvc3NpYmxlIHRvIGNhdGNoDQoicmVhbCIgd2FybmluZ3MgaW4gc3RhYmxlIGtlcm5lbCB0aGF0
IHJlc3VsdGVkIGZyb20gYmFja3BvcnRpbmcgaXNzdWVzLg0KDQotLQ0KVGhhbmtzLA0KU2FzaGE=
