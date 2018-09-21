Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4DAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576C721545
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LEWePpWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576C721545
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388801AbeIUGCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:02:02 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:36638
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbeIUGCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDKmZEiJr6IFA8A4rOik5j8w2m1KN73604JXJOGBRwA=;
 b=LEWePpWNoki1BiI0zTLn1edNc8cLl6TGswaXtViZO2zS4G0AtJH3A3D5imWMnmAiZYKssRU0LIYnpS62LqG4H2jw44v0XM3ncp+CzNG4sCAMkP+3vJF70EsG7hp2xduiOqSA916v/pDyMHcwpMLpvIVAzCE/2O1Vfp4G0D/abfQ=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0122.namprd21.prod.outlook.com (10.173.173.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.7; Fri, 21 Sep 2018 00:15:53 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 00:15:53 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Oscar Salvador <osalvador@techadventures.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "malat@debian.org" <malat@debian.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 4/5] mm/memory_hotplug: Simplify
 node_states_check_changes_online
Thread-Topic: [PATCH 4/5] mm/memory_hotplug: Simplify
 node_states_check_changes_online
Thread-Index: AQHUUAC/gnx6/MLUgkO0VCtG4O6fwaT54IEA
Date:   Fri, 21 Sep 2018 00:15:53 +0000
Message-ID: <71676241-8aa5-2b58-b2fa-706bf21b9cfb@microsoft.com>
References: <20180919100819.25518-1-osalvador@techadventures.net>
 <20180919100819.25518-5-osalvador@techadventures.net>
In-Reply-To: <20180919100819.25518-5-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0122;6:u0odYqlrMIxXNn6A6vlMK38/PvofhnSSxytnvrhcncnBCjig/7ugk/0qxo2w7EbX/daTH6KhBmQTZWJ/NJ3B9fXTmxG2iHNtPE3WuyfqPgOCKehT1L0yY9lQoBpprfOIFctVRVY0GAUTW3OHHwezqn43ITMyDI7tm0Mvy9tMD/0i0nLmT00hfyRQTLj7DFmPp/HslK0ifSZp28A41ViKLGRK7OUlEBSrAYVISljLESaHkKCbimapN3wipFkyz0CEFD6hExTcCKFTEj9rW05DA9CsUqnTHl+zlpZQGPbBY1JHZwbDqfW6uCyS4pe0rM3kjCeYFqJNAve3PGoHB5KXO6RV6ZJKVYJ06GdpTFuhsR/Q29jrvdh8gkmQmrKSTNLwQ+j+opjbtZtjrM3pgIROzDWh7zB/ErCpDmZLlJRWVmqJMkz301+7mgAw6sifnw9TWq7Pu6bjzGEFZSpESZ/pFA==;5:K4Y4+y56Rc6AkJd2rA7TkoWD9/f4WQhzYCJ92TPvsVmkVJJZp9Md2uSbPHlZnSgU7iiSQXAJ9uQvnz0Q+dktgA36ylNSHXK+2OrAB4AKVbGLoM/CWsaxa1J/lBPPSRJRRxZh/E63igOjN/a0CXUl8pPzwxITtULz9kCifACYvC4=;7:6bFmKdnz0YlUdMoI5CoWKcPA+PJg+Q+E6g49gY3b52p7W8N+5F34TxdX5jmR8Lr/kVXNs1OqRw2gLj4won4sSZvRP5MCYvkO1/2limfmZ88Zt3rs4iD783vjU1jnfpy7T0kMek5GHF52zjoQ/kZ+pbZ0xK2Bzt5JoE0ECXZwaD9JE8ACkCE+01B6PzXHdGmExzhVMf6cFzj8x6UFxvLJIlywabE4k3K1QGjVwh6OM97MtZi2I1qyZECmKTlmsgzf
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a4c6e882-fb2c-4736-3ebf-08d61f5764bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0122;
x-ms-traffictypediagnostic: DM5PR21MB0122:
x-microsoft-antispam-prvs: <DM5PR21MB012252E935D607D58F8C7F6D9D120@DM5PR21MB0122.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0122;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0122;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(396003)(376002)(199004)(189003)(476003)(6512007)(31696002)(22452003)(4326008)(72206003)(86612001)(86362001)(36756003)(53936002)(5660300001)(39060400002)(3846002)(99286004)(6116002)(97736004)(81166006)(316002)(81156014)(71190400001)(71200400001)(2906002)(14454004)(10290500003)(66066001)(478600001)(2900100001)(256004)(105586002)(2616005)(26005)(106356001)(10090500001)(305945005)(6246003)(446003)(11346002)(8676002)(6346003)(6486002)(31686004)(186003)(8936002)(5250100002)(6506007)(53546011)(54906003)(110136005)(2501003)(102836004)(68736007)(7416002)(6436002)(229853002)(7736002)(76176011)(25786009)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0122;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: FuU/ICGwW7v5rWALT0yxA5E0h3zMWn74SVsnELUsIvVmn9Td4fPqrXRtB5MHkBxdelo1d9riSaDez4LpGQeRwWFl+p5+K2Yxz5XqG01sbnbOiEFWvmWoie8BCkVR/rc1KcbNg9lvJjE49o4ZuwmSVhMjnYvNKDPCpuTXmFWRm2HRiv31Qo+TgUtVVVv6ky8uaEqLgZTYu3cC2wzw8nM8Wf0MyyByfUhCu6ghivm0r5sxo++7szQfLvqumNgAh5SGJk7uH4Nc3QjI/GRqJiamrxqDgYjlKgYzId6QSIoF42JCDxiAR0Es+p7yB7OEv/iHsiAIk7gT+x67g+Vv0+pSMdrRGo5Fgjl9a0aSCZmb+mo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DC188685ADE26458591625DF1332AA6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c6e882-fb2c-4736-3ebf-08d61f5764bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 00:15:53.0302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMTkvMTggNjowOCBBTSwgT3NjYXIgU2FsdmFkb3Igd3JvdGU6DQo+IEZyb206IE9z
Y2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4NCj4gDQo+IFdoaWxlIGxvb2tpbmcgYXQg
bm9kZV9zdGF0ZXNfY2hlY2tfY2hhbmdlc19vbmxpbmUsIEkgc3R1bWJsZWQNCj4gdXBvbiBzb21l
IGNvbmZ1c2luZyB0aGluZ3MuDQo+IA0KPiBSaWdodCBhZnRlciBlbnRlcmluZyB0aGUgZnVuY3Rp
b24sIHdlIGZpbmQgdGhpczoNCj4gDQo+IGlmIChOX01FTU9SWSA9PSBOX05PUk1BTF9NRU1PUlkp
DQo+ICAgICAgICAgem9uZV9sYXN0ID0gWk9ORV9NT1ZBQkxFOw0KPiANCj4gVGhpcyBpcyB3cm9u
Zy4NCj4gTl9NRU1PUlkgY2Fubm90IHJlYWxseSBiZSBlcXVhbCB0byBOX05PUk1BTF9NRU1PUlku
DQo+IE15IGd1ZXNzIGlzIHRoYXQgdGhpcyB3YW50ZWQgdG8gYmUgc29tZXRoaW5nIGxpa2U6DQo+
IA0KPiBpZiAoTl9OT1JNQUxfTUVNT1JZID09IE5fSElHSF9NRU1PUlkpDQo+IA0KPiB0byBjaGVj
ayBpZiB3ZSBoYXZlIENPTkZJR19ISUdITUVNLg0KPiANCj4gTGF0ZXIgb24sIGluIHRoZSBDT05G
SUdfSElHSE1FTSBibG9jaywgd2UgaGF2ZToNCj4gDQo+IGlmIChOX01FTU9SWSA9PSBOX0hJR0hf
TUVNT1JZKQ0KPiAgICAgICAgIHpvbmVfbGFzdCA9IFpPTkVfTU9WQUJMRTsNCj4gDQo+IEFnYWlu
LCB0aGlzIGlzIHdyb25nLCBhbmQgd2lsbCBuZXZlciBiZSBldmFsdWF0ZWQgdG8gdHJ1ZS4NCj4g
DQo+IEJlc2lkZXMgcmVtb3ZpbmcgdGhlc2Ugd3JvbmcgaWYgc3RhdGVtZW50cywgSSBzaW1wbGlm
aWVkDQo+IHRoZSBmdW5jdGlvbiBhIGJpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9zY2FyIFNh
bHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4NCj4gLS0tDQo+ICBtbS9tZW1vcnlfaG90cGx1Zy5j
IHwgNzEgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnlfaG90cGx1Zy5jIGIvbW0vbWVtb3J5X2hvdHBs
dWcuYw0KPiBpbmRleCAxMzFjMDgxMDZkNTQuLmFiM2MxZGUxOGM1ZCAxMDA2NDQNCj4gLS0tIGEv
bW0vbWVtb3J5X2hvdHBsdWcuYw0KPiArKysgYi9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+IEBAIC02
ODcsNjEgKzY4NywzNiBAQCBzdGF0aWMgdm9pZCBub2RlX3N0YXRlc19jaGVja19jaGFuZ2VzX29u
bGluZSh1bnNpZ25lZCBsb25nIG5yX3BhZ2VzLA0KPiAgCXN0cnVjdCB6b25lICp6b25lLCBzdHJ1
Y3QgbWVtb3J5X25vdGlmeSAqYXJnKQ0KPiAgew0KPiAgCWludCBuaWQgPSB6b25lX3RvX25pZCh6
b25lKTsNCj4gLQllbnVtIHpvbmVfdHlwZSB6b25lX2xhc3QgPSBaT05FX05PUk1BTDsNCj4gIA0K
PiAgCS8qDQo+IC0JICogSWYgd2UgaGF2ZSBISUdITUVNIG9yIG1vdmFibGUgbm9kZSwgbm9kZV9z
dGF0ZXNbTl9OT1JNQUxfTUVNT1JZXQ0KPiAtCSAqIGNvbnRhaW5zIG5vZGVzIHdoaWNoIGhhdmUg
em9uZXMgb2YgMC4uLlpPTkVfTk9STUFMLA0KPiAtCSAqIHNldCB6b25lX2xhc3QgdG8gWk9ORV9O
T1JNQUwuDQo+IC0JICoNCj4gLQkgKiBJZiB3ZSBkb24ndCBoYXZlIEhJR0hNRU0gbm9yIG1vdmFi
bGUgbm9kZSwNCj4gLQkgKiBub2RlX3N0YXRlc1tOX05PUk1BTF9NRU1PUlldIGNvbnRhaW5zIG5v
ZGVzIHdoaWNoIGhhdmUgem9uZXMgb2YNCj4gLQkgKiAwLi4uWk9ORV9NT1ZBQkxFLCBzZXQgem9u
ZV9sYXN0IHRvIFpPTkVfTU9WQUJMRS4NCj4gKwkgKiB6b25lX2Zvcl9wZm5fcmFuZ2UoKSBjYW4g
b25seSByZXR1cm4gYSB6b25lIHdpdGhpbg0KPiArCSAqICgwLi5aT05FX05PUk1BTF0gb3IgWk9O
RV9NT1ZBQkxFLg0KDQpCdXQgd2hhdCBpZiB0aGF0IGNoYW5nZXMsIHdpbGwgdGhpcyBmdW5jdGlv
biBuZWVkIHRvIGNoYW5nZSBhcyB3ZWxsPw0KDQo+ICsJICogSWYgdGhlIHpvbmUgaXMgd2l0aGlu
IHRoZSByYW5nZSAoMC4uWk9ORV9OT1JNQUxdLA0KPiArCSAqIHdlIG5lZWQgdG8gY2hlY2sgaWY6
DQo+ICsJICogMSkgV2UgbmVlZCB0byBzZXQgdGhlIG5vZGUgZm9yIE5fTk9STUFMX01FTU9SWQ0K
PiArCSAqIDIpIE9uIENPTkZJR19ISUdITUVNIHN5c3RlbXMsIHdlIG5lZWQgdG8gYWxzbyBzZXQN
Cj4gKwkgKiAgICB0aGUgbm9kZSBmb3IgTl9ISUdIX01FTU9SWS4NCj4gKwkgKiAzKSBPbiAhQ09O
RklHX0hJR0hNRU0sIHdlIGNhbiBkaXNyZWdhcmQgTl9ISUdIX01FTU9SWSwNCj4gKwkgKiAgICBh
cyBOX0hJR0hfTUVNT1JZIGZhbGxzIGJhY2sgdG8gTl9OT1JNQUxfTUVNT1JZLg0KPiAgCSAqLw0K
PiAtCWlmIChOX01FTU9SWSA9PSBOX05PUk1BTF9NRU1PUlkpDQo+IC0JCXpvbmVfbGFzdCA9IFpP
TkVfTU9WQUJMRTsNCj4gIA0KPiAtCS8qDQo+IC0JICogaWYgdGhlIG1lbW9yeSB0byBiZSBvbmxp
bmUgaXMgaW4gYSB6b25lIG9mIDAuLi56b25lX2xhc3QsIGFuZA0KPiAtCSAqIHRoZSB6b25lcyBv
ZiAwLi4uem9uZV9sYXN0IGRvbid0IGhhdmUgbWVtb3J5IGJlZm9yZSBvbmxpbmUsIHdlIHdpbGwN
Cj4gLQkgKiBuZWVkIHRvIHNldCB0aGUgbm9kZSB0byBub2RlX3N0YXRlc1tOX05PUk1BTF9NRU1P
UlldIGFmdGVyDQo+IC0JICogdGhlIG1lbW9yeSBpcyBvbmxpbmUuDQo+IC0JICovDQo+IC0JaWYg
KHpvbmVfaWR4KHpvbmUpIDw9IHpvbmVfbGFzdCAmJiAhbm9kZV9zdGF0ZShuaWQsIE5fTk9STUFM
X01FTU9SWSkpDQo+IC0JCWFyZy0+c3RhdHVzX2NoYW5nZV9uaWRfbm9ybWFsID0gbmlkOw0KPiAt
CWVsc2UNCj4gLQkJYXJnLT5zdGF0dXNfY2hhbmdlX25pZF9ub3JtYWwgPSAtMTsNCj4gLQ0KPiAt
I2lmZGVmIENPTkZJR19ISUdITUVNDQo+IC0JLyoNCj4gLQkgKiBJZiB3ZSBoYXZlIG1vdmFibGUg
bm9kZSwgbm9kZV9zdGF0ZXNbTl9ISUdIX01FTU9SWV0NCj4gLQkgKiBjb250YWlucyBub2RlcyB3
aGljaCBoYXZlIHpvbmVzIG9mIDAuLi5aT05FX0hJR0hNRU0sDQo+IC0JICogc2V0IHpvbmVfbGFz
dCB0byBaT05FX0hJR0hNRU0uDQo+IC0JICoNCj4gLQkgKiBJZiB3ZSBkb24ndCBoYXZlIG1vdmFi
bGUgbm9kZSwgbm9kZV9zdGF0ZXNbTl9OT1JNQUxfTUVNT1JZXQ0KPiAtCSAqIGNvbnRhaW5zIG5v
ZGVzIHdoaWNoIGhhdmUgem9uZXMgb2YgMC4uLlpPTkVfTU9WQUJMRSwNCj4gLQkgKiBzZXQgem9u
ZV9sYXN0IHRvIFpPTkVfTU9WQUJMRS4NCj4gLQkgKi8NCj4gLQl6b25lX2xhc3QgPSBaT05FX0hJ
R0hNRU07DQo+IC0JaWYgKE5fTUVNT1JZID09IE5fSElHSF9NRU1PUlkpDQo+IC0JCXpvbmVfbGFz
dCA9IFpPTkVfTU9WQUJMRTsNCj4gKwlpZiAoem9uZV9pZHgoem9uZSkgPD0gWk9ORV9OT1JNQUwp
IHsNCj4gKwkJaWYgKCFub2RlX3N0YXRlKG5pZCwgTl9OT1JNQUxfTUVNT1JZKSkNCj4gKwkJCWFy
Zy0+c3RhdHVzX2NoYW5nZV9uaWRfbm9ybWFsID0gbmlkOw0KPiArCQllbHNlDQo+ICsJCQlhcmct
PnN0YXR1c19jaGFuZ2VfbmlkX25vcm1hbCA9IC0xOw0KPiAgDQo+IC0JaWYgKHpvbmVfaWR4KHpv
bmUpIDw9IHpvbmVfbGFzdCAmJiAhbm9kZV9zdGF0ZShuaWQsIE5fSElHSF9NRU1PUlkpKQ0KPiAt
CQlhcmctPnN0YXR1c19jaGFuZ2VfbmlkX2hpZ2ggPSBuaWQ7DQo+IC0JZWxzZQ0KPiAtCQlhcmct
PnN0YXR1c19jaGFuZ2VfbmlkX2hpZ2ggPSAtMTsNCj4gLSNlbHNlDQo+IC0JLyoNCj4gLQkgKiBX
aGVuICFDT05GSUdfSElHSE1FTSwgTl9ISUdIX01FTU9SWSBlcXVhbHMgTl9OT1JNQUxfTUVNT1JZ
DQo+IC0JICogc28gc2V0dGluZyB0aGUgbm9kZSBmb3IgTl9OT1JNQUxfTUVNT1JZIGlzIGVub3Vn
aC4NCj4gLQkgKi8NCj4gLQlhcmctPnN0YXR1c19jaGFuZ2VfbmlkX2hpZ2ggPSAtMTsNCj4gLSNl
bmRpZg0KPiArCQlpZiAoSVNfRU5BQkxFRChDT05GSUdfSElHSE1FTSkpIHsNCj4gKwkJCWlmICgh
bm9kZV9zdGF0ZShuaWQsIE5fSElHSF9NRU1PUlkpKQ0KPiArCQkJCWFyZy0+c3RhdHVzX2NoYW5n
ZV9uaWRfaGlnaCA9IG5pZDsNCg0KU2hvdWxkIG5vdCB3ZSBoYXZlOg0KCQkJZWxzZQ0KCQkJCWFy
Zy0+c3RhdHVzX2NoYW5nZV9uaWRfaGlnaCA9IC0xOyA/DQoNCj4gKwkJfSBlbHNlDQo+ICsJCQlh
cmctPnN0YXR1c19jaGFuZ2VfbmlkX2hpZ2ggPSAtMTsNCg0KDQpJIHByZWZlciB0byBoYXZlIGJy
YWNlcyBpbiBlbHNlIHBhcnQgYXMgd2VsbCB3aGVuIGlmIGhhcyBicmFjZXMuDQoNCj4gKwl9DQo+
ICANCj4gIAkvKg0KPiAtCSAqIGlmIHRoZSBub2RlIGRvbid0IGhhdmUgbWVtb3J5IGJlZm9yIG9u
bGluZSwgd2Ugd2lsbCBuZWVkIHRvDQo+IC0JICogc2V0IHRoZSBub2RlIHRvIG5vZGVfc3RhdGVz
W05fTUVNT1JZXSBhZnRlciB0aGUgbWVtb3J5DQo+IC0JICogaXMgb25saW5lLg0KPiArCSAqIGlm
IHRoZSBub2RlIGRvZXNuJ3QgaGF2ZSBtZW1vcnkgYmVmb3JlIG9ubGluaW5nIGl0LCB3ZSB3aWxs
IG5lZWQNCj4gKwkgKiB0byBzZXQgdGhlIG5vZGUgdG8gbm9kZV9zdGF0ZXNbTl9NRU1PUlldIGFm
dGVyIHRoZSBtZW1vcnkNCj4gKwkgKiBnZXRzIG9ubGluZWQuDQo+ICAJICovDQo+ICAJaWYgKCFu
b2RlX3N0YXRlKG5pZCwgTl9NRU1PUlkpKQ0KPiAgCQlhcmctPnN0YXR1c19jaGFuZ2VfbmlkID0g
bmlkOw0KPiANCg0KSSB0aGluayBpdCBpcyBzaW1wbGVyIHRvIGhhdmUgc29tZXRoaW5nIGxpa2Ug
dGhpczoNCg0KICAgICAgICBpbnQgbmlkID0gem9uZV90b19uaWQoem9uZSk7DQoNCiAgICAgICAg
YXJnLT5zdGF0dXNfY2hhbmdlX25pZF9oaWdoID0gLTE7DQogICAgICAgIGFyZy0+c3RhdHVzX2No
YW5nZV9uaWQgPSAtMTsNCiAgICAgICAgYXJnLT5zdGF0dXNfY2hhbmdlX25pZCA9IC0xOw0KDQog
ICAgICAgIGlmICghbm9kZV9zdGF0ZShuaWQsIE5fTUVNT1JZKSkNCiAgICAgICAgICAgICAgICBh
cmctPnN0YXR1c19jaGFuZ2VfbmlkID0gbmlkOyANCiAgICAgICAgaWYgKHpvbmVfaWR4KHpvbmUp
IDw9IFpPTkVfTk9STUFMICYmICFub2RlX3N0YXRlKG5pZCwgTl9OT1JNQUxfTUVNT1JZKSkNCiAg
ICAgICAgICAgICAgICBhcmctPnN0YXR1c19jaGFuZ2VfbmlkX25vcm1hbCA9IG5pZDsgDQojaWZk
ZWYgQ09ORklHX0hJR0hNRU0NCiAgICAgICAgaWYgKHpvbmVfaWR4KHpvbmUpIDw9IE5fSElHSF9N
RU1PUlkgJiYgIW5vZGVfc3RhdGUobmlkLCBOX0hJR0hfTUVNT1JZKSkNCiAgICAgICAgICAgICAg
ICBhcmctPnN0YXR1c19jaGFuZ2VfbmlkX2hpZ2ggPSBuaWQ7IA0KI2VuZGlmDQoNCg0KUGF2ZWwN
Cg==
