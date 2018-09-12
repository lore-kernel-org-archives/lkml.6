Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35BAC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D87020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ci7V/940"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D87020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeILTpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:45:10 -0400
Received: from mail-sn1nam01on0091.outbound.protection.outlook.com ([104.47.32.91]:51648
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726945AbeILTpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgyaZTLOe82qawMwYiksIZJZTKiEzbyxA7McOGFjUIQ=;
 b=ci7V/9404R0Qc7auG2gz0iXbsHSgvpIQ51RnnvgH8KOu+ByLTShZKtkUDHWnKiPNaSJzkKtyPZj2qwDH/morXUuWdqUzLK68zTJVNShIYHyTM8yc55liJsfJCIKe2OcTZ7ocXsKlfSoo8QKsd/onOlLNbqXEtOytKYF6lWwRHvE=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0860.namprd21.prod.outlook.com (10.173.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Wed, 12 Sep 2018 14:40:19 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1164.006; Wed, 12 Sep 2018
 14:40:19 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Michal Hocko <mhocko@kernel.org>
CC:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Thread-Topic: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Thread-Index: AQHUSQLFF/mQjCkfKkuMMO7HZfKu+6Tpf1cAgAMgwwCAAAn0gIAADVaAgAADooA=
Date:   Wed, 12 Sep 2018 14:40:18 +0000
Message-ID: <38ce1d0b-14bd-9a4a-1061-62c366cb11b5@microsoft.com>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz> <20180912150356.642c1dab@thinkpad>
 <20180912133933.GI10951@dhcp22.suse.cz> <20180912162717.5a018bf6@thinkpad>
In-Reply-To: <20180912162717.5a018bf6@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0860;6:DP8yZP2FAKTXlRjvzGf8i+02lF5FbHLx6nbNIs8oMEMoRqExhShEogIyKM2tYXMbF7VOUrSNKUpk+ou3rhy+PL9Dk4T8WwiXMMky5Ze8hxPOfd5+HftplAebm6nkp6wVDo+C7k7k+AQngRKv0vsqkLZKQ/+ETnnZEIgUbKBMo1/0RQJ1ilID1kl/Ut4hbH/27jJXLfu6SKOXQjrHIO+uW5S6CUU+9evh8GoSDvJZR0DouTxjLJSF711DI94i1UOXsscVGTvaUPqNcZBzISm8XKCAGJzVQerlrnddZ3RUBnZkTGiMbpoSDt92eP0toG0TYzTwLnFrL3pV+qKFTLO5YsP71hWMMmUsjmMDRzdyjId4BCz1rffvJFIjOpGu2qLWVb7R1EZuKRrRg7JGlMmmkzzYEEWoAQE6rog+edDcyV1XcRO2UnKV/5EdOyTmPdgXxJk809KFYqarJ1ar4oJuJg==;5:6XXvjnYciJWxGuBkV/oDwRrTC7Mlzj0Db4MYsbRJMLtMWc9L3cZra9Uzd84mYRLwCIN8dxrFc8JRjUiA4+nk+Xg4bWs1aYN2t3C7nF9xAbABZYVU83Vxu1bnpxWB2bjt3NprvHGal+blmCLsBY0CLfiG3XtrmWWDQ9v3CGcnT8M=;7:MXVZ77C7ui8C5hRXF/Kpr4TK16ZeGOahukxcvgJAUfT068uA+NfGJ3O9x5vuakYYn5LPfXXFbRfd1BRSZ88SuGaOodrp6vVbUlJe9BOmkn3vMGMoNajLyBXkcm1z15AnieyB37d9NI8nye+yO/wRembuuQ+JUuoElMDTedroUC1AqFRdwUvfzryuMMS6Bq4bUrHIv+QmlHXsgoMtG8wLp6dfumrivErnn04ltaa8CuNjXJr+JCq/FmU5kycR4Trk
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 11d26f0a-13f0-4398-d3a4-08d618bda983
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0860;
x-ms-traffictypediagnostic: DM5PR21MB0860:
x-microsoft-antispam-prvs: <DM5PR21MB0860C2ECAAD7841EDBE986F09D1B0@DM5PR21MB0860.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:DM5PR21MB0860;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0860;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(5660300001)(106356001)(93886005)(105586002)(31686004)(3846002)(561944003)(6116002)(72206003)(6486002)(14454004)(99286004)(478600001)(6246003)(6436002)(25786009)(7736002)(305945005)(81166006)(4326008)(8676002)(81156014)(76176011)(8936002)(10090500001)(229853002)(6346003)(26005)(6512007)(2900100001)(68736007)(186003)(5250100002)(66066001)(11346002)(102836004)(6506007)(53546011)(486006)(31696002)(97736004)(2616005)(476003)(36756003)(446003)(256004)(86362001)(14444005)(22452003)(86612001)(53936002)(10290500003)(2906002)(110136005)(54906003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0860;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: sUBvCNPCkHAqWhobRhNa0ecnQO13iDapbQ1e9+L1tDBzrI3kkvWKEwtyVVWdQXMaA1KW9ZNpQtcsngqwe/7fG1uYABl1sEKJlHvNe/BcfCNKTkaqARTIDQDcOcQ8sJKg8D/0PbxQbts6j4jh0MR/6J+5pi8hURmmKEZjFvOUDDH1B6in1uzjYQ8WLc5vARS1s2rDJf4ZyKf1ZMDtl1Jm57ZH7RKofqz9zCMl2t9dBJNzztsXvapKwH3YMVaWoxnOiohT/W2cAIjmfDmadvreQt58epNvH9gGpVBNmAYMMkC2XG764iVjHfh5CUV1aZ9jWopDdxnhank31OLixgmcXkcHMF52VXSWUs1mj9d+b5s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B05514B915A5E944BDC03F796D68E222@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d26f0a-13f0-4398-d3a4-08d618bda983
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 14:40:19.0027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMTIvMTggMTA6MjcgQU0sIEdlcmFsZCBTY2hhZWZlciB3cm90ZToNCj4gT24gV2Vk
LCAxMiBTZXAgMjAxOCAxNTozOTozMyArMDIwMA0KPiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+PiBPbiBXZWQgMTItMDktMTggMTU6MDM6NTYsIEdlcmFsZCBT
Y2hhZWZlciB3cm90ZToNCj4+IFsuLi5dDQo+Pj4gQlRXLCB0aG9zZSBzeXNmcyBhdHRyaWJ1dGVz
IGFyZSB3b3JsZC1yZWFkYWJsZSwgc28gYW55b25lIGNhbiB0cmlnZ2VyDQo+Pj4gdGhlIHBhbmlj
IGJ5IHNpbXBseSByZWFkaW5nIHRoZW0sIG9yIGp1c3QgcnVuIGxzbWVtIChhbHNvIGF2YWlsYWJs
ZSBmb3INCj4+PiB4ODYgc2luY2UgdXRpbC1saW51eCAyLjMyKS4gT0ssIHlvdSBuZWVkIGEgc3Bl
Y2lhbCBub3QtbWVtb3J5LWJsb2NrLWFsaWduZWQNCj4+PiBtZW09IHBhcmFtZXRlciBhbmQgREVC
VUdfVk0gZm9yIHBvaXNvbiBjaGVjaywgYnV0IHcvbyBERUJVR19WTSB5b3Ugd291bGQNCj4+PiBz
dGlsbCBhY2Nlc3MgdW5pbml0aWFsaXplZCBzdHJ1Y3QgcGFnZXMuIFRoaXMgc291bmRzIHZlcnkg
d3JvbmcsIGFuZCBJDQo+Pj4gdGhpbmsgaXQgcmVhbGx5IHNob3VsZCBiZSBmaXhlZC4gIA0KPj4N
Cj4+IE9oaCwgYWJzb2x1dGVseS4gTm9ib2R5IGlzIHF1ZXN0aW9uaW5nIHRoYXQuIFRoZSB0aGlu
ZyBpcyB0aGF0IHRoZQ0KPj4gY29kZSBoYXMgYmVlbiBsaWtlbHkgYWx3YXlzIGJyb2tlbi4gV2Ug
anVzdCBoYXZlbid0IG5vdGljZWQgYmVjYXVzZQ0KPj4gdGhvc2UgdW5pdGlhbGl6ZWQgcGFydHMg
d2hlcmUgemVyb2VkIHByZXZpb3VzbHkuIE5vdyB0aGF0IHRoZSBpbXBsaWNpdA0KPj4gemVyb3lp
bmcgaXMgZ29uZSBpdCBpcyBqdXN0IHZpc2libGUuDQo+Pg0KPj4gQWxsIHRoYXQgSSBhbSBhcmd1
aW5nIGlzIHRoYXQgdGhlcmUgYXJlIG1hbnkgcGxhY2VzIHdoaWNoIGFzc3VtZQ0KPj4gcGFnZWJs
b2NrcyB0byBiZSBmdWxseSBpbml0aWFsaXplZCBhbmQgcGx1Z2dpbmcgb25lIHBsYWNlIHRoYXQg
Ymxvd3MgdXANCj4+IGF0IHRoZSB0aW1lIGlzIGp1c3Qgd2hhY2sgYSBtb2xlLiBXZSBuZWVkIHRv
IGFkZHJlc3MgdGhpcyBtdWNoIGVhcmxpZXIuDQo+PiBFLmcuIGJ5IGFsbG93aW5nIG9ubHkgZnVs
bCBwYWdlYmxvY2tzIHdoZW4gYWRkaW5nIGEgbWVtb3J5IHJhbmdlLg0KPiANCj4gSnVzdCB0byBt
YWtlIHN1cmUgd2UgYXJlIHRhbGtpbmcgYWJvdXQgdGhlIHNhbWUgdGhpbmc6IHdoZW4geW91IHNh
eQ0KPiAicGFnZWJsb2NrcyIsIGRvIHlvdSBtZWFuIHRoZSBNQVhfT1JERVJfTlJfUEFHRVMgLyBw
YWdlYmxvY2tfbnJfcGFnZXMNCj4gdW5pdCBvZiBwYWdlcywgb3IgZG8geW91IG1lYW4gdGhlIG1l
bW9yeSAoaG90cGx1ZykgYmxvY2sgdW5pdD8NCg0KRnJvbSBlYXJseSBkaXNjdXNzaW9uLCBpdCB3
YXMgYWJvdXQgcGFnZWJsb2NrX25yX3BhZ2VzIG5vdCBhYm91dA0KbWVtb3J5X2Jsb2NrX3NpemVf
Ynl0ZXMNCg0KPiANCj4gSSBkbyBub3Qgc2VlIGFueSBpc3N1ZSBoZXJlIHdpdGggTUFYX09SREVS
X05SX1BBR0VTIC8gcGFnZWJsb2NrX25yX3BhZ2VzDQo+IHBhZ2VibG9ja3MsIGFuZCBpZiB0aGVy
ZSB3YXMgc3VjaCBhbiBpc3N1ZSwgb2YgY291cnNlIHlvdSBhcmUgcmlnaHQgdGhhdA0KPiB0aGlz
IHdvdWxkIGFmZmVjdCBtYW55IHBsYWNlcy4gSWYgdGhlcmUgd2FzIHN1Y2ggYW4gaXNzdWUsIEkg
d291bGQgYWxzbw0KPiBhc3N1bWUgdGhhdCB3ZSB3b3VsZCBzZWUgdGhlIG5ldyBwYWdlIHBvaXNv
biB3YXJuaW5nIGluIG1hbnkgb3RoZXIgcGxhY2VzLg0KPiANCj4gVGhlIGJ1ZyB0aGF0IE1pa2hh
aWxzIHBhdGNoIHdvdWxkIGZpeCBvbmx5IGFmZmVjdHMgY29kZSB0aGF0IG9wZXJhdGVzDQo+IG9u
IC8gaXRlcmF0ZXMgdGhyb3VnaCBtZW1vcnkgKGhvdHBsdWcpIGJsb2NrcywgYW5kIHRoYXQgZG9l
cyBub3QgaGFwcGVuDQo+IGluIG1hbnkgcGxhY2VzLCBvbmx5IGluIHRoZSB0d28gZnVuY3Rpb25z
IHRoYXQgaGlzIHBhdGNoIGZpeGVzLg0KDQpKdXN0IHRvIGJlIGNsZWFyLCBzbyBtZW1vcnkgaXMg
cGFnZWJsb2NrX25yX3BhZ2VzIGFsaWduZWQsIHlldA0KbWVtb3J5X2Jsb2NrIGFyZSBsYXJnZXIg
YW5kIHBhbmljIGlzIHN0aWxsIHRyaWdnZXJlZD8NCg0KSSBhc2ssIGJlY2F1c2UgMzA3NU0gaXMg
bm90IDEyOE0gYWxpZ25lZC4NCg0KPiANCj4gV2hlbiB5b3Ugc2F5ICJhZGRyZXNzIHRoaXMgbXVj
aCBlYXJsaWVyIiwgZG8geW91IG1lYW4gY2hhbmdpbmcgdGhlIHdheQ0KPiB0aGF0IGZyZWVfYXJl
YV9pbml0X2NvcmUoKS9tZW1tYXBfaW5pdCgpIGluaXRpYWxpemUgc3RydWN0IHBhZ2VzLCBpLmUu
DQo+IGhhdmUgdGhlbSBub3QgdXNlIHpvbmUtPnNwYW5uZWRfcGFnZXMgYXMgbGltaXQsIGJ1dCBy
YXRoZXIgYWxpZ24gdGhhdA0KPiB1cCB0byB0aGUgbWVtb3J5IGJsb2NrIChub3QgcGFnZWJsb2Nr
KSBib3VuZGFyeT8NCj4gDQoNClRoaXMgd2FzIG15IGluaXRpYWwgcHJvcG9zYWwsIHRvIGZpeCBt
ZW1tYXBfaW5pdCgpIGFuZCBpbml0aWFsaXplIHN0cnVjdA0KcGFnZXMgYmV5b25kIHRoZSAiZW5k
IiwgYW5kIGJlZm9yZSB0aGUgInN0YXJ0IiB0byBjb3ZlciB0aGUgd2hvbGUNCnNlY3Rpb24uIEJ1
dCwgSSB0aGluayBNaWNoYWwgc3VnZ2VzdGVkIChhbmQgaGUgbWlnaHQgY29ycmVjdCBtZSkgdG8N
CnNpbXBseSBpZ25vcmUgdW5hbGlnbmVkIG1lbW9yeSB0byBzZWN0aW9uIG1lbW9yeSBtdWNoIGVh
cmxpZXI6IHNvDQphbnl0aGluZyB0aGF0IGRvZXMgbm90IGFsaWduIHRvIHNwYXJzZSBvcmRlciBp
cyBub3QgYWRkZWQgYXQgYWxsIHRvIHRoZQ0Kc3lzdGVtLg0KDQpJIHRoaW5rIE1pY2hhbCdzIHBy
b3Bvc2FsIHdvdWxkIHNpbXBsaWZ5IGFuZCBzdHJlbmd0aGVuIG1lbW9yeSBtYXBwaW5nDQpvdmVy
YWxsLg0KDQpQYXZlbA==
