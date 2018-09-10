Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E893C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DE920870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z6yDOaKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DE920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeIJTGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:06:21 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:28672
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIJTGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0evDOwQVx0jfzqEBqd6DJzvrtG/zAFF0LKc9CVJzaY=;
 b=Z6yDOaKjQEE0jo9vrQopIULedekoqmwr1c/MvmEHAR7i+3zeyCHnDRlvRzJjxLX/vvTGH13PsNh8AGSwJZg46SMvKqUN8T6wsAebdpijTkivt0pztOoasyUzRB1HQLAnze9y4/7tHRLBRkgDKD7kBKFmgtyCoUmR4Gn0hEtQia8=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0123.namprd21.prod.outlook.com (10.173.173.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Mon, 10 Sep 2018 14:11:46 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1164.006; Mon, 10 Sep 2018
 14:11:46 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     "mhocko@kernel.org" <mhocko@kernel.org>
CC:     "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Thread-Topic: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Thread-Index: AQHUSQLFF/mQjCkfKkuMMO7HZfKu+6Tpf1cAgAAIDwCAAAOzgIAAAx4A
Date:   Mon, 10 Sep 2018 14:11:45 +0000
Message-ID: <CAGM2reZuGAPmfO8x0TnHnqHci_Hsga3-CfM9+udJs=gUQCw-1g@mail.gmail.com>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz>
 <e8d75768-9122-332b-3b16-cad032aeb27f@microsoft.com>
 <20180910135959.GI10951@dhcp22.suse.cz>
In-Reply-To: <20180910135959.GI10951@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0123;6:XZr+el9lAZ3mwseyrr46Op6j8p3zRyf4/AqpYHjkUZ0vMajVzXMlufL6I9/qcwEwZCISzLr9uD63j4W/GPTZBWHMbya2zoVYIs3ZG502JSomXgON4jNks8etO55eYx/TEfSG3xm4MckVTnyMJZ1CpGrt15R2sek1DE92S+MqJimzGqGOe+CmbC94vot9inUKecztcX5mtnT19hw2IYoUg9b7BOTPv49/r0tAak4fW781jOP1/Vjls4M+JAu9h0lklJziYR0zyDzmobeBY2OXnMHUMnXoGVn6ES3WBJNROkdxRlXoKxCmL67Kw/7Sbz1LEmut6cFz/HfraXd3gycz17PccaNHEm06rUIlkRhvF5acOVGeiQZX9r9KQzxfx9CQI+Q89KhRmg+HQuVdvjUwPdkz3AUfMBt6gdkLlXlFGMoSxgiTBCZICYvvltCpth8Waz7wd7+zh6d6Kg9++6fTfw==;5:BXXE1a7QyLYeBfGtGn+v+EfTzsEWq/JCAhzDDTubv+ifnc6D9AGbwSaUWViGBw1NuHlv2Jzm5dC+KzklQvu1xr7WZOGOrKcuPtKKFdqPUteIB7Dsdr+AHxmpA2J5g5TlYmBveAiDvmAFKGgbG2pq34HxigfdLcHfWXJWuE/sgcY=;7:vYfLdsCJZMwgE3+gtbcr/7UQVFVGZ2zCeJjBnx/HnzcXwD0ET6BBtezDRWVM57I5OMML9TbbIb0j+L/UD357rvQuqWyI+IMvpzvRJJRHwMz/bwlIryGI4gI8UUJx8+s7GeYGoqAYiUunp6j/OscbZ79FFFpueJLTC1g9wYooMum0lFDG8hpxwcpC/8K/OPyJmv8PqiyiKekNHwQ4+HU+YhlMdncCwSLN0YwoACQhWKu/w30s5OCZEqp56tgrdKRs
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 06b75eb2-9850-4982-c1c4-08d6172757a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0123;
x-ms-traffictypediagnostic: DM5PR21MB0123:
x-microsoft-antispam-prvs: <DM5PR21MB01235805FD48FDB7026C915C9D050@DM5PR21MB0123.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991033);SRVR:DM5PR21MB0123;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0123;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(53936002)(478600001)(6506007)(5660300001)(66066001)(10090500001)(186003)(229853002)(256004)(14444005)(53546011)(5250100002)(10290500003)(102836004)(26005)(61266001)(6346003)(6512007)(72206003)(9686003)(6436002)(6916009)(8990500004)(5640700003)(2501003)(6486002)(2351001)(54906003)(106356001)(55446002)(498394004)(81156014)(1730700003)(81166006)(8936002)(68736007)(97736004)(33896004)(316002)(98316002)(76176011)(7736002)(99286004)(86362001)(86612001)(6246003)(11346002)(446003)(2906002)(476003)(93886005)(61726006)(14454004)(22452003)(4326008)(305945005)(3846002)(6116002)(8676002)(25786009)(2900100001)(486006)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0123;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: c5T1n3JiGSAC3JbH1s/7rJVIvaZrt36XxWzRULNJw260VI6pVwAhovjqfc4j7rmutPGSeX1Ws8E4Jn6ry0uQjUfLWLpviLFvph6xtiIggUiGGeuCuHu7O7KLE4MOb7gw6W5gSR15H9+qegtAjW4GPrk9G73kBTcmvDMeAp2fGA1z0vEo9AnJsmO+/YcFXpZgJQgBiZJCqDE3vMTDfZ/yEju1RnmhNEcfwzP5s+obSU0SjOmI+OkrMPcbWe1G6vYO3saZT/f8v3l0yQsOuxqcpLmtvjLJqoAOil/yvshzF+KRZskTzbHDZv9Sv6ucMhgF3AKfpNFDbtLT/sh7+YXoCJpdxVVD+yex6HU6H14lWBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <754194C804C91544ACE43C2AD97E1668@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b75eb2-9850-4982-c1c4-08d6172757a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 14:11:45.9831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQpJdCBpcyB0cmlja3ksIGJ1dCBwcm9iYWJseSBjYW4gYmUgZG9uZS4gRWl0
aGVyIGNoYW5nZQ0KbWVtbWFwX2luaXRfem9uZSgpIG9yIGl0cyBjYWxsZXIgdG8gYWxzbyBjb3Zl
ciB0aGUgZW5kcyBhbmQgc3RhcnRzIG9mDQp1bmFsaWduZWQgc2VjdGlvbnMgdG8gaW5pdGlhbGl6
ZSBhbmQgcmVzZXJ2ZSBwYWdlcy4NCg0KVGhlIHNhbWUgdGhpbmcgd291bGQgYWxzbyBuZWVkIHRv
IGJlIGRvbmUgaW4gZGVmZXJyZWRfaW5pdF9tZW1tYXAoKSB0bw0KY292ZXIgdGhlIGRlZmVycmVk
IGluaXQgY2FzZS4NCg0KRm9yIGhvdHBsdWdnZWQgbWVtb3J5IHdlIGRvIG5vdCBuZWVkIHRvIHdv
cnJ5LCBhcyB0aGF0IG9uZSBpcyBhbHdheXMNCnNlY3Rpb24gYWxpZ25lZC4NCg0KRG8geW91IHRo
aW5rIHRoaXMgd291bGQgYmUgYSBiZXR0ZXIgYXBwcm9hY2g/DQoNClRoYW5rIHlvdSwNClBhdmVs
DQpPbiBNb24sIFNlcCAxMCwgMjAxOCBhdCAxMDowMCBBTSBNaWNoYWwgSG9ja28gPG1ob2Nrb0Br
ZXJuZWwub3JnPiB3cm90ZToNCj4NCj4gT24gTW9uIDEwLTA5LTE4IDEzOjQ2OjQ1LCBQYXZlbCBU
YXRhc2hpbiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gT24gOS8xMC8xOCA5OjE3IEFNLCBNaWNoYWwg
SG9ja28gd3JvdGU6DQo+ID4gPiBbQ2MgUGF2ZWxdDQo+ID4gPg0KPiA+ID4gT24gTW9uIDEwLTA5
LTE4IDE0OjM1OjI3LCBNaWtoYWlsIFphc2xvbmtvIHdyb3RlOg0KPiA+ID4+IElmIG1lbW9yeSBl
bmQgaXMgbm90IGFsaWduZWQgd2l0aCB0aGUgbGludXggbWVtb3J5IHNlY3Rpb24gYm91bmRhcnks
IHN1Y2gNCj4gPiA+PiBhIHNlY3Rpb24gaXMgb25seSBwYXJ0bHkgaW5pdGlhbGl6ZWQuIFRoaXMg
bWF5IGxlYWQgdG8gVk1fQlVHX09OIGR1ZSB0bw0KPiA+ID4+IHVuaW5pdGlhbGl6ZWQgc3RydWN0
IHBhZ2VzIGFjY2VzcyBmcm9tIGlzX21lbV9zZWN0aW9uX3JlbW92YWJsZSgpIG9yDQo+ID4gPj4g
dGVzdF9wYWdlc19pbl9hX3pvbmUoKSBmdW5jdGlvbi4NCj4gPiA+Pg0KPiA+ID4+IEhlcmUgaXMg
b25lIG9mIHRoZSBwYW5pYyBleGFtcGxlczoNCj4gPiA+PiAgQ09ORklHX0RFQlVHX1ZNX1BHRkxB
R1M9eQ0KPiA+ID4+ICBrZXJuZWwgcGFyYW1ldGVyIG1lbT0zMDc1TQ0KPiA+ID4NCj4gPiA+IE9L
LCBzbyB0aGUgbGFzdCBtZW1vcnkgc2VjdGlvbiBpcyBub3QgZnVsbCBhbmQgd2UgaGF2ZSBhIHBh
cnRpYWwgbWVtb3J5DQo+ID4gPiBibG9jayByaWdodD8NCj4gPiA+DQo+ID4gPj4gIHBhZ2UgZHVt
cGVkIGJlY2F1c2U6IFZNX0JVR19PTl9QQUdFKFBhZ2VQb2lzb25lZChwKSkNCj4gPiA+DQo+ID4g
PiBPSywgdGhpcyBtZWFucyB0aGF0IHRoZSBzdHJ1Y3QgcGFnZSBpcyBub3QgZnVsbHkgaW5pdGlh
bGl6ZWQuIERvIHlvdQ0KPiA+ID4gaGF2ZSBhIHNwZWNpZmljIHBsYWNlIHdoaWNoIGhhcyB0cmln
Z2VyZWQgdGhpcyBhc3NlcnQ/DQo+ID4gPg0KPiA+ID4+ICAtLS0tLS0tLS0tLS1bIGN1dCBoZXJl
IF0tLS0tLS0tLS0tLS0NCj4gPiA+PiAgQ2FsbCBUcmFjZToNCj4gPiA+PiAgKFs8MDAwMDAwMDAw
MDM5YjhhND5dIGlzX21lbV9zZWN0aW9uX3JlbW92YWJsZSsweGNjLzB4MWMwKQ0KPiA+ID4+ICAg
WzwwMDAwMDAwMDAwOTU1OGJhPl0gc2hvd19tZW1fcmVtb3ZhYmxlKzB4ZGEvMHhlMA0KPiA+ID4+
ICAgWzwwMDAwMDAwMDAwOTMyNWZjPl0gZGV2X2F0dHJfc2hvdysweDNjLzB4ODANCj4gPiA+PiAg
IFs8MDAwMDAwMDAwMDQ3ZTdlYT5dIHN5c2ZzX2tmX3NlcV9zaG93KzB4ZGEvMHgxNjANCj4gPiA+
PiAgIFs8MDAwMDAwMDAwMDNmYzRlMD5dIHNlcV9yZWFkKzB4MjA4LzB4NGM4DQo+ID4gPj4gICBb
PDAwMDAwMDAwMDAzY2I4MGU+XSBfX3Zmc19yZWFkKzB4NDYvMHgxODANCj4gPiA+PiAgIFs8MDAw
MDAwMDAwMDNjYjljZT5dIHZmc19yZWFkKzB4ODYvMHgxNDgNCj4gPiA+PiAgIFs8MDAwMDAwMDAw
MDNjYzA2YT5dIGtzeXNfcmVhZCsweDYyLzB4YzANCj4gPiA+PiAgIFs8MDAwMDAwMDAwMGMwMDFj
MD5dIHN5c3RlbV9jYWxsKzB4ZGMvMHgyZDgNCj4gPiA+Pg0KPiA+ID4+IFRoaXMgZml4IGNoZWNr
cyBpZiB0aGUgcGFnZSBsaWVzIHdpdGhpbiB0aGUgem9uZSBib3VuZGFyaWVzIGJlZm9yZQ0KPiA+
ID4+IGFjY2Vzc2luZyB0aGUgc3RydWN0IHBhZ2UgZGF0YS4gVGhlIGNoZWNrIGlzIGFkZGVkIHRv
IGJvdGggZnVuY3Rpb25zLg0KPiA+ID4+IEFjdHVhbGx5IHNpbWlsYXIgY2hlY2sgaGFzIGFscmVh
ZHkgYmVlbiBwcmVzZW50IGluDQo+ID4gPj4gaXNfcGFnZWJsb2NrX3JlbW92YWJsZV9ub2xvY2so
KSBmdW5jdGlvbiBidXQgb25seSBhZnRlciB0aGUgc3RydWN0IHBhZ2UNCj4gPiA+PiBpcyBhY2Nl
c3NlZC4NCj4gPiA+Pg0KPiA+ID4NCj4gPiA+IFdlbGwsIEkgYW0gYWZyYWlkIHRoaXMgaXMgbm90
IHRoZSBwcm9wZXIgc29sdXRpb24uIFdlIGFyZSByZWx5aW5nIG9uIHRoZQ0KPiA+ID4gZnVsbCBw
YWdlYmxvY2sgd29ydGggb2YgaW5pdGlhbGl6ZWQgc3RydWN0IHBhZ2VzIGF0IG1hbnkgb3RoZXIg
cGxhY2UuIFdlDQo+ID4gPiB1c2VkIHRvIGRvIHRoYXQgaW4gdGhlIHBhc3QgYmVjYXVzZSB3ZSBo
YXZlIGluaXRpYWxpemVkIHRoZSBmdWxsDQo+ID4gPiBzZWN0aW9uIGJ1dCB0aGlzIGhhcyBiZWVu
IGNoYW5nZWQgcmVjZW50bHkuIFBhdmVsLCBkbyB5b3UgaGF2ZSBhbnkgaWRlYXMNCj4gPiA+IGhv
dyB0byBkZWFsIHdpdGggdGhpcyBwYXJ0aWFsIG1lbSBzZWN0aW9ucyBub3c/DQo+ID4NCj4gPiBX
ZSBoYXZlOg0KPiA+DQo+ID4gcmVtb3ZlX21lbW9yeSgpDQo+ID4gICAgICAgQlVHX09OKGNoZWNr
X2hvdHBsdWdfbWVtb3J5X3JhbmdlKHN0YXJ0LCBzaXplKSkNCj4gPg0KPiA+IFRoYXQgc3VwcG9z
ZWQgdG8gc2FmZWx5IGNoZWNrIGZvciB0aGlzIGNvbmRpdGlvbjogaWYgW3N0YXJ0LCBzdGFydCAr
DQo+ID4gc2l6ZSkgbm90IGJsb2NrIHNpemUgYWxpZ25lZCAoYW5kIHdlIGtub3cgYmxvY2sgc2l6
ZSBpcyBzZWN0aW9uDQo+ID4gYWxpZ25lZCksIGhvdCByZW1vdmUgaXMgbm90IGFsbG93ZWQuIFRo
ZSBwcm9ibGVtIGlzIHRoaXMgY2hlY2sgaXMgbGF0ZSwNCj4gPiBhbmQgb25seSBoYXBwZW5zIHdo
ZW4gaW52YWxpZCByYW5nZSBoYXMgYWxyZWFkeSBwYXNzZWQgdGhyb3VnaCBwcmV2aW91cw0KPiA+
IGNoZWNrcy4NCj4gPg0KPiA+IFdlIGNvdWxkIGFkZCBjaGVja19ob3RwbHVnX21lbW9yeV9yYW5n
ZSgpIHRvIGlzX21lbV9zZWN0aW9uX3JlbW92YWJsZSgpOg0KPiA+DQo+ID4gaXNfbWVtX3NlY3Rp
b25fcmVtb3ZhYmxlKHN0YXJ0X3BmbiwgbnJfcGFnZXMpDQo+ID4gIGlmIChjaGVja19ob3RwbHVn
X21lbW9yeV9yYW5nZShQRk5fUEhZUyhzdGFydF9wZm4pLCBQRk5fUEhZUyhucl9wYWdlcykpKQ0K
PiA+ICAgcmV0dXJuIGZhbHNlOw0KPiA+DQo+ID4gSSB0aGluayBpdCBzaG91bGQgd29yay4NCj4N
Cj4gSSBkbyBub3QgdGhpbmsgd2Ugd2FudCB0byBzcHJpbmtsZSB0aGVzZSB0ZXN0cyBvdmVyIGFs
bCBwZm4gd2Fsa2Vycy4gQ2FuDQo+IHdlIHNpbXBseSBpbml0aWFsaXplIHRob3NlIHVuaW5pdGlh
bGl6ZWQgaG9sZXMgYXMgd2VsbCBhbmQgbWFrZSB0aGVtDQo+IHJlc2VydmVkIHdpdGhvdXQgaGFu
ZGluZyB0aGVtIG92ZXIgdG8gdGhlIHBhZ2UgYWxsb2NhdG9yPyBUaGF0IHdvdWxkIGJlDQo+IG11
Y2ggbW9yZSByb2J1c3QgYXBwcm9hY2ggSU1ITy4NCj4gLS0NCj4gTWljaGFsIEhvY2tvDQo+IFNV
U0UgTGFicw0KPg==
