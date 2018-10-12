Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81993C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8202064E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jcy5EFEf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Up0CQ3Sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8202064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeJMB5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:57:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54444 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbeJMB5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:57:49 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w9CINkj1014592;
        Fri, 12 Oct 2018 11:23:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5yauCaKdnM7OuyegFx4+ljnzwDrO5W3T4UimejUzZew=;
 b=jcy5EFEffFqoOz7lajARzuZ8O+KjpArrvq21A9Ot1LY0kYovpWsi5W9oZn4mHX9smihy
 cuezBNUJFWG/SajZoYfygHS5slZZkGzNz4hQnzbz2aMtzBVWhWm+LO2qiGQgkiQRSQhS
 iHRWOzZuucYixTiiQKj3NWGwU4s8KjXv0G0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2n30ga82n8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 12 Oct 2018 11:23:52 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 12 Oct 2018 11:23:51 -0700
Received: from PRN-CHUB10.TheFacebook.com (2620:10d:c081:35::19) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 12 Oct 2018 11:23:51 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 12 Oct 2018 11:23:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yauCaKdnM7OuyegFx4+ljnzwDrO5W3T4UimejUzZew=;
 b=Up0CQ3ScjUL3D81hpeASFGU4VW09w62UVSsiuv+jdU80P5T1vDPrr7Hb7o+8IfdVAE4Y77dSyKZDAMwEYKFlmzO266Tc4mhBd+29CH2NfZJYVn+mygQCZK/Ik5XqSCJvidxSI0y+nu/gKElIGjJ/1Dgk4DiTMYuzUIGJ6CQ3fWw=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1894.namprd15.prod.outlook.com (10.174.54.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Fri, 12 Oct 2018 18:23:49 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::2d43:ae9a:18c0:ac8b]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::2d43:ae9a:18c0:ac8b%3]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 18:23:49 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        "Justin.Lee1@Dell.com" <Justin.Lee1@Dell.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH net-next v3 1/2] net/ncsi: Add NCSI Broadcom OEM command
Thread-Topic: [PATCH net-next v3 1/2] net/ncsi: Add NCSI Broadcom OEM command
Thread-Index: AQHUYbb2PU7LFGQsmEiM0XNSz2chY6UaxTWAgACzdYA=
Date:   Fri, 12 Oct 2018 18:23:49 +0000
Message-ID: <51596B01-4863-44D6-AB0E-094E231A32BA@fb.com>
References: <20181011230518.3204700-1-vijaykhemka@fb.com>
 <0291dc2447720438a25c9c922252ab71e92985dd.camel@mendozajonas.com>
In-Reply-To: <0291dc2447720438a25c9c922252ab71e92985dd.camel@mendozajonas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:f05c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1894;20:EwDZOGW3LAeuS3AaUT4fWFGFsXOW5p0b567aWY1wojUyBvCncmFdIzZ7ab2PvTqlY48zD+A2J1V9awXGCavLSaNLBrFqtPI5CLcy6+oMQoMpaPHO8rgmlqf3s6Tec5F6+1Z8ecArlR1zec/1i1X+lhyaT6HiMS2FRQTYsKy0NTQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b49a1445-0e3a-4e93-3e8d-08d6306fdb52
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1894;
x-ms-traffictypediagnostic: CY4PR15MB1894:
x-microsoft-antispam-prvs: <CY4PR15MB1894748CFCB6EA1CC2BA8374DDE20@CY4PR15MB1894.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991067);SRVR:CY4PR15MB1894;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1894;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(199004)(189003)(186003)(14454004)(7736002)(6116002)(305945005)(2906002)(478600001)(229853002)(486006)(446003)(11346002)(476003)(2616005)(256004)(2900100001)(46003)(14444005)(36756003)(2201001)(82746002)(2501003)(5250100002)(81166006)(86362001)(81156014)(8936002)(102836004)(99286004)(5660300001)(33656002)(76176011)(4326008)(6436002)(8676002)(110136005)(54906003)(83716004)(71190400001)(105586002)(25786009)(106356001)(97736004)(68736007)(71200400001)(53936002)(6486002)(6246003)(6506007)(6512007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1894;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UYUxTErzjtPxedaVD2Sfg34oG8iqB4zssn6Uw411jJlf0qDjEi+XTaEQ0ODJQ8RdWWJGzkl34IHuXNAf3DV6EbFNeoLZHwodnM+kk88765G9i7W2unycyLGxdEF4bqwuuWtAKD6bha09au2wmFZAxL1l2ewmKcE6kBH7ywb9M9ZfpqdFYvPPzYH9+9ZgWj+K2DpyIM4w1DE9rRJMkM8tHwlA7vUj+j4LgFxySCIcownFHr6RUAecNGzPK04pGJ7iaNDP2ObPyev0ADrvytzJgLxGYHAc+ergRi7xzW5a5j0HPehWjWDCeD8Z2YgK7PL1fJu4dP2QygzFIBWnHbM5TCdj5Lvz+8BnNvs292gCL6M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D61883744E8044BAF097A61EB6133D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b49a1445-0e3a-4e93-3e8d-08d6306fdb52
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 18:23:49.7496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1894
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEwLzExLzE4LCA1OjQyIFBNLCAiU2FtdWVsIE1lbmRvemEtSm9uYXMiIDxzYW1A
bWVuZG96YWpvbmFzLmNvbT4gd3JvdGU6DQoNCiAgICA+IGRpZmYgLS1naXQgYS9uZXQvbmNzaS9u
Y3NpLW1hbmFnZS5jIGIvbmV0L25jc2kvbmNzaS1tYW5hZ2UuYw0KICAgID4gaW5kZXggMDkxMjg0
NzYwZDIxLi43NTUwNGNjZDFiOTUgMTAwNjQ0DQogICAgPiAtLS0gYS9uZXQvbmNzaS9uY3NpLW1h
bmFnZS5jDQogICAgPiArKysgYi9uZXQvbmNzaS9uY3NpLW1hbmFnZS5jDQogICAgPiBAQCAtNjM1
LDYgKzYzNSwzOSBAQCBzdGF0aWMgaW50IHNldF9vbmVfdmlkKHN0cnVjdCBuY3NpX2Rldl9wcml2
ICpuZHAsIHN0cnVjdCBuY3NpX2NoYW5uZWwgKm5jLA0KICAgID4gIAlyZXR1cm4gMDsNCiAgICA+
ICB9DQogICAgPiAgDQogICAgPiArI2lmIElTX0VOQUJMRUQoQ09ORklHX05DU0lfT0VNX0NNRF9H
RVRfTUFDKQ0KICAgID4gKw0KICAgID4gKy8qIE5DU0kgT0VNIENvbW1hbmQgQVBJcyAqLw0KICAg
ID4gK3N0YXRpYyB2b2lkIG5jc2lfb2VtX2dtYV9oYW5kbGVyX2JjbShzdHJ1Y3QgbmNzaV9jbWRf
YXJnICpuY2EpDQogICAgPiArew0KICAgID4gKwlpbnQgcmV0ID0gMDsNCiAgICA+ICsJdW5zaWdu
ZWQgY2hhciBkYXRhW05DU0lfT0VNX0JDTV9DTURfR01BX0xFTl07DQogICAgPiArDQogICAgPiAr
CW5jYS0+cGF5bG9hZCA9IE5DU0lfT0VNX0JDTV9DTURfR01BX0xFTjsNCiAgICA+ICsNCiAgICA+
ICsJbWVtc2V0KGRhdGEsIDAsIE5DU0lfT0VNX0JDTV9DTURfR01BX0xFTik7DQogICAgPiArCSoo
dW5zaWduZWQgaW50ICopZGF0YSA9IG50b2hsKE5DU0lfT0VNX01GUl9CQ01fSUQpOw0KICAgID4g
KwlkYXRhWzVdID0gTkNTSV9PRU1fQkNNX0NNRF9HTUE7DQogICAgPiArDQogICAgPiArCW5jYS0+
ZGF0YSA9IGRhdGE7DQogICAgPiArDQogICAgPiArCXJldCA9IG5jc2lfeG1pdF9jbWQobmNhKTsN
CiAgICA+ICsJaWYgKHJldCkNCiAgICA+ICsJCW5ldGRldl9lcnIobmNhLT5uZHAtPm5kZXYuZGV2
LA0KICAgID4gKwkJCSAgICJOQ1NJOiBGYWlsZWQgdG8gdHJhbnNtaXQgY21kIDB4JXggZHVyaW5n
IGNvbmZpZ3VyZVxuIiwNCiAgICA+ICsJCQkgICBuY2EtPnR5cGUpOw0KICAgID4gK30NCiAgICA+
ICsNCiAgICA+ICsvKiBPRU0gQ29tbWFuZCBoYW5kbGVycyBpbml0aWFsaXphdGlvbiAqLw0KICAg
ID4gK3N0YXRpYyBzdHJ1Y3QgbmNzaV9vZW1fZ21hX2hhbmRsZXIgew0KICAgID4gKwl1bnNpZ25l
ZCBpbnQJbWZyX2lkOw0KICAgID4gKwl2b2lkCQkoKmhhbmRsZXIpKHN0cnVjdCBuY3NpX2NtZF9h
cmcgKm5jYSk7DQogICAgPiArfSBuY3NpX29lbV9nbWFfaGFuZGxlcnNbXSA9IHsNCiAgICA+ICsJ
eyBOQ1NJX09FTV9NRlJfQkNNX0lELCBuY3NpX29lbV9nbWFfaGFuZGxlcl9iY20gfQ0KICAgID4g
K307DQogICAgPiArDQogICAgPiArI2VuZGlmIC8qIENPTkZJR19OQ1NJX09FTV9DTURfR0VUX01B
QyAqLw0KICAgID4gKw0KICAgID4gIHN0YXRpYyB2b2lkIG5jc2lfY29uZmlndXJlX2NoYW5uZWwo
c3RydWN0IG5jc2lfZGV2X3ByaXYgKm5kcCkNCiAgICA+ICB7DQogICAgPiAgCXN0cnVjdCBuY3Np
X2RldiAqbmQgPSAmbmRwLT5uZGV2Ow0KICAgID4gQEAgLTY4NSw2ICs3MTgsNDMgQEAgc3RhdGlj
IHZvaWQgbmNzaV9jb25maWd1cmVfY2hhbm5lbChzdHJ1Y3QgbmNzaV9kZXZfcHJpdiAqbmRwKQ0K
ICAgID4gIAkJCWdvdG8gZXJyb3I7DQogICAgPiAgCQl9DQogICAgPiAgDQogICAgPiArI2lmIElT
X0VOQUJMRUQoQ09ORklHX05DU0lfT0VNX0NNRF9HRVRfTUFDKQ0KICAgID4gKwkJbmQtPnN0YXRl
ID0gbmNzaV9kZXZfc3RhdGVfY29uZmlnX29lbV9nbWE7DQogICAgPiArCQlicmVhazsNCiAgICA+
ICsJY2FzZSBuY3NpX2Rldl9zdGF0ZV9jb25maWdfb2VtX2dtYToNCiAgICA+ICsJCW5jYS50eXBl
ID0gTkNTSV9QS1RfQ01EX09FTTsNCiAgICA+ICsJCW5jYS5wYWNrYWdlID0gbnAtPmlkOw0KICAg
ID4gKwkJbmNhLmNoYW5uZWwgPSBuYy0+aWQ7DQogICAgPiArCQluZHAtPnBlbmRpbmdfcmVxX251
bSA9IDE7DQogICAgPiArDQogICAgPiArCQkvKiBDaGVjayBmb3IgbWFudWZhY3R1cmVyIGlkIGFu
ZCBGaW5kIHRoZSBoYW5kbGVyICovDQogICAgPiArCQlzdHJ1Y3QgbmNzaV9vZW1fZ21hX2hhbmRs
ZXIgKm5jaCA9IE5VTEw7DQogICAgPiArCQlpbnQgaTsNCiAgICA+ICsNCiAgICANCiAgICBUaGlz
IGhhcyB0aGUgb3Bwb3NpdGUgYWZmZWN0LCBub3cgaWYgd2UgZG8gY29tcGlsZSB3aXRoDQogICAg
Q09ORklHX05DU0lfT0VNX0NNRF9HRVRfTUFDIHdlIGdldDoNCiAgICANCiAgICAuLi9uZXQvbmNz
aS9uY3NpLW1hbmFnZS5jOiBJbiBmdW5jdGlvbiDigJhuY3NpX2NvbmZpZ3VyZV9jaGFubmVs4oCZ
Og0KICAgIC4uL25ldC9uY3NpL25jc2ktbWFuYWdlLmM6NzY5OjM6IHdhcm5pbmc6IElTTyBDOTAg
Zm9yYmlkcyBtaXhlZCBkZWNsYXJhdGlvbnMgYW5kIGNvZGUgWy1XZGVjbGFyYXRpb24tYWZ0ZXIt
c3RhdGVtZW50XQ0KICAgICAgIHN0cnVjdCBuY3NpX29lbV9nbWFfaGFuZGxlciAqbmNoID0gTlVM
TDsNCiAgICAgICBefn5+fn4NCiAgICANCiAgICBQZXJoYXBzIHdlIHNob3VsZCBsYXkgdGhpcyBv
dXQgc2xpZ2h0bHkgZGlmZmVyZW50bHkuIEZvciBleGFtcGxlIHdlIGNvdWxkIGdvDQogICAgdGhy
b3VnaCB0aGUgbmNzaV9kZXZfc3RhdGVfY29uZmlnX29lbV9nbWEgc3RhdGUgcmVnYXJkbGVzcyBh
bmQgY2FsbCBzb21lIG90aGVyDQogICAgZnVuY3Rpb24gdGhhdCBmaW5kcyBhbmQgY2FsbHMgdGhl
IGhhbmRsZXIsIG9yIGRvZXMgbm90aGluZyBpZiB0aGUgY29uZmlnIG9wdGlvbg0KICAgIGlzbid0
IHNldC4NCiAgICANCiAgICBSZWdhcmRzLA0KICAgIFNhbQ0KICAgIA0KICBTYW0sDQogIEkgaGF2
ZSBjcmVhdGVkIGEgbmV3IHBhdGNoIHY0IGFuZCBpbnRyb2R1Y2VkIG5ldyBmdW5jdGlvbi4gSSB3
YXMganVzdCB3b25kZXJpbmcgaWYgSSBjYW4gcmVtb3ZlDQogIENPTkZJR19OQ1NJX09FTV9DTURf
R0VUX01BQyBjb25maWcgYWxsIHRvZ2V0aGVyLiBBbmQgaXQgYWx3YXlzIGdldCBhbmQgc2V0IG1h
YyBhZGRyZXNzIGlmDQogIEhhbmRsZXIgaXMgYXZhaWxhYmxlLiBMb29raW5nIGZvciB5b3VyIHRo
b3VnaHQgaGVyZS4NCiANCiAgLVZpamF5DQoNCg==
