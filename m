Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B69ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B030E21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eZmXzYEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B030E21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeIUUOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:14:46 -0400
Received: from mail-eopbgr680129.outbound.protection.outlook.com ([40.107.68.129]:7392
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727554AbeIUUOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjKCiasNEmvuCLPKqugkqV9HKnaO5HtK4ZqzMBQzs8o=;
 b=eZmXzYEWEyD26qD7A9OOGcn96bdnsUY5n2xsFV41o853F39h/LZtfaEo1vWA36Zql/UjduybBlVc7EPGVoSgyhB31VN2/KzsXvCkH4dH/wprunqHct6ec0TBBccZYixqE2JWxD8+xdpPb6zNf4iYPSReX0O/z4u/YcW9QZdDjW8=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0153.namprd21.prod.outlook.com (10.173.173.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.7; Fri, 21 Sep 2018 14:25:36 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 14:25:36 +0000
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
Subject: Re: [PATCH v2 3/4] mm/memory_hotplug: Simplify
 node_states_check_changes_online
Thread-Topic: [PATCH v2 3/4] mm/memory_hotplug: Simplify
 node_states_check_changes_online
Thread-Index: AQHUUa6+vfBxYwMuaUGKJREdqGZEZKT6yo6A
Date:   Fri, 21 Sep 2018 14:25:36 +0000
Message-ID: <52890425-5d16-bd34-4b88-df174a2be7ff@microsoft.com>
References: <20180921132634.10103-1-osalvador@techadventures.net>
 <20180921132634.10103-4-osalvador@techadventures.net>
In-Reply-To: <20180921132634.10103-4-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0153;6:cHcXKnietSqZrjGytqnb6wvbsDC0eRInzH1l44pbBtsaw6dTEQVf/5rvsqajeIzmiQHFaHsU0aNyMtyuDfn4Kpo27oCzS3sMbhtWDjwix+fDhYgxOzY0aJpgynvta7mtes64zUwvxkfrn5FMYiTynnMqnnB7ilp/dAZFR5oGY5zamYuW9l3w+h1LPt2qT2w7hkbEF5Q/XrUqm51vw8a5NEWzaUKt3XaewZ89Jg1hy/Whmh4Xc94mdNqaTRfuBcQ5wqxTb612sIR3RdxmA1VzRe52X0etMlZ5JJVlS/eeQb5FF/jQWvA9MRC9cm3ISoitWFsffrY4N65lXyaxmElNM3QRDG+SJk5FCt6VNCII7od8BNrt+BnaSKruM2O4mRdw6WwTSEN3VHhiATNG2f+zaRIjDf4zhpYoURkroa+1KaL61u2eDdCzmng/iX1GYZaG6g2mxKeO7+etRZqSdMI7rA==;5:z3slvFU84itH4F7FTlwcn57H/BqWG9wPUlMTA7XPGIeeieEnsC/BjA3p43rPa7pHhdqTWx6qHzZFFPS336QygjNr5vNVI2WeJ1MgUi1huqKt4rGWChd5ry2WPlUXZLDWR6vSHESRaWzmd+g5pdHYOD67pIvCnC1bufDk+P0YTPs=;7:6dgn6T3uYmQ+9WhHoSO/6kT9NymRogt23DcKQUymGOFQ5PMVjGxIYBJfCB1P1MbqWrTnKmoRCivAdF3w/3yn9bIhwHHlbTKV9DIGu4TgliCpejcwryM6ULI+JbCVQNYcw0QutRd2HFkex2APHOmI2DV3n3oMp3lGhOYtQynp8x2wpTE4xmn5m2qD7B3IlxSPYvVY2xeoffdhzCbd3MNt3Rs63hgrkYr2AeRt2dsMP0iwFH1AZdPR4tCIhadqYb2M
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b0e54b0c-0755-48a3-4107-08d61fce18fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0153;
x-ms-traffictypediagnostic: DM5PR21MB0153:
x-microsoft-antispam-prvs: <DM5PR21MB0153308E8C2D2BFD59AFCCC09D120@DM5PR21MB0153.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0153;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0153;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(81156014)(14454004)(86362001)(81166006)(256004)(10090500001)(76176011)(71190400001)(71200400001)(6436002)(3846002)(6116002)(36756003)(7736002)(2900100001)(99286004)(5660300001)(305945005)(8936002)(97736004)(39060400002)(110136005)(316002)(6486002)(68736007)(86612001)(8676002)(6512007)(31696002)(478600001)(54906003)(6246003)(25786009)(2616005)(446003)(11346002)(476003)(5250100002)(72206003)(186003)(10290500003)(22452003)(2501003)(53546011)(6506007)(31686004)(486006)(7416002)(2906002)(229853002)(66066001)(4326008)(6346003)(26005)(106356001)(105586002)(102836004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0153;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: dVdD+F6GPkFJG3/0KKLy2+R06LeXapI4SJh4EsE8q2ZWsqQXMWvpkUeKOYGN/dIb+GbHcleA6fV8EGXEOBKRTtUaPmfJ2KUQZ6GO1HwbLtdTWQGP0M/9qHMf6s0Lh0WhwZHTfqu3NH/KYctr3C43Pgnush3bszZgwX5Za8spJ/kmtUe74nTXHVEEvU2UV4sO962GixlOue5MIsxrCmEehJAfITKUnAaws7tHf6i2E8/Ou1qMsehwDEp6SzXgRs5OQy5MCozx4V3uIGYwrViXse9VqVxaS6XrLbU3VPb6TV8WhIAS/rpU536S6jtknX0UETJCs5jT6LvvPjMb94MIKhZKtu87+egzALHyFDbJXP4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <59D565C86967C44C915837B450D02570@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e54b0c-0755-48a3-4107-08d61fce18fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 14:25:36.1036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMjEvMTggOToyNiBBTSwgT3NjYXIgU2FsdmFkb3Igd3JvdGU6DQo+IEZyb206IE9z
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
bHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4NCj4gU3VnZ2VzdGVkLWJ5OiBQYXZlbCBUYXRhc2hp
biA8cGF2ZWwudGF0YXNoaW5AbWljcm9zb2Z0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBhdmVsIFRh
dGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg==
