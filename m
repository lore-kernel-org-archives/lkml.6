Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD8AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B00F2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ikji5sV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B00F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeJEDAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:00:49 -0400
Received: from mail-co1nam03on0065.outbound.protection.outlook.com ([104.47.40.65]:3560
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbeJEDAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/wQ1hFsQodJU7xhZi9WpQtyAUkJ78GBSrcQOZOIy8M=;
 b=ikji5sV7ZoovO5y+jsz4A6/j6H6FBrf5ape5yeEnNxAljY8M7VDiSqpYLYjb4Ene/9SoHCuugLalVg+oC4wQbEfZig+GTVwIGdGgoRoO1sSLA3qWfwFs1cgcNHJm8BB+a1Ll5cTO+gwhCpt8+uZKZ3j46yG/1WZdn36Tas3fJbQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4232.namprd05.prod.outlook.com (52.135.200.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.13; Thu, 4 Oct 2018 20:05:55 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Thu, 4 Oct 2018
 20:05:55 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Thread-Topic: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Thread-Index: AQHUW2CZEG0GJCpfDkK4fEgcOSwgMqUOuSmAgAAJ9ICAAAHlAIAABIuAgAABwICAAAPpgIAArDAAgAAJJgA=
Date:   Thu, 4 Oct 2018 20:05:55 +0000
Message-ID: <C521E791-673E-4256-9B94-243A72ACF1E7@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <36D6F606-6922-4057-B1F8-2B30993962AE@zytor.com>
 <20181004091651.GB21151@gmail.com>
 <df1bddc1-e71b-dbd8-a24f-01a46d462a79@zytor.com>
In-Reply-To: <df1bddc1-e71b-dbd8-a24f-01a46d462a79@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4232;20:bSuxxN3tV7tdkkFq9VaupQt8hnT/gK1SjiWy/1+3VFVUUzNoY25hPbyVA9moWd+a7NieJjasIyQnbjHR+LUBHZJigkF8iGpJ2OdB0m3Zzx9B2jnh6BleIDynp6mzvNFCoYxCe9s2XwmAFtBQWJPDNZajntURYuNqKN0OXnrXJnU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2fc760b2-e0a4-4823-4d1e-08d62a34cb43
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4232;
x-ms-traffictypediagnostic: BYAPR05MB4232:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4232C2EFA07BDE2EF6AD7776D0EA0@BYAPR05MB4232.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(219752817060721)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(10201501046)(93006095)(93001095)(3002001)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BYAPR05MB4232;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4232;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(366004)(346002)(54534003)(199004)(189003)(6246003)(86362001)(6306002)(25786009)(54906003)(6512007)(5250100002)(82746002)(6486002)(229853002)(4326008)(6436002)(5660300001)(2900100001)(53936002)(106356001)(105586002)(45080400002)(66066001)(6116002)(186003)(26005)(476003)(316002)(68736007)(2906002)(81166006)(7416002)(81156014)(102836004)(7736002)(6506007)(36756003)(478600001)(3846002)(8936002)(76176011)(305945005)(99286004)(8676002)(93886005)(14444005)(11346002)(966005)(256004)(14454004)(97736004)(53546011)(71190400001)(71200400001)(110136005)(486006)(446003)(83716004)(33656002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4232;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /3v+VftDGoYnIgYhENPJMArUgblMOkb0kvt11HuFX5LEylm7H9hAa5hQOixNDK8OUIaVKjUcrdoBpOgfqbSKaVQRP2HejxpeYcizb8TewfanuGE9juiPl3JQzBGkJu/LJNX1BhNWtFBAg19dZ0cRv+6XebN0fsjgy6J4JqWCCJmqV7rJIPRCyU0LLt7wVhmCPk2Va8NT2nzYWsXFBtp2G9M4bLFSvk0iho5iwOKZZfXb8JauM5/SYhgEOB8S9TvxEWdP1BYL9YeOIpxxCd7kKAWnUmSaq7HzD5tEjUpMK/ib+AoQEHvpFcGZB4gjY4m/1B7mXTrT4DRorDcXB5dgmKXKyKRqqlAeIUXOC6d1tVg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BFCC0E8FC8AC74581FEE822669CB8B3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc760b2-e0a4-4823-4d1e-08d62a34cb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 20:05:55.4324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTI6MzMgUE0sIEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPiB3cm90ZToNCg0KPiBP
biAxMC8wNC8xOCAwMjoxNiwgSW5nbyBNb2xuYXIgd3JvdGU6DQo+PiAqIGhwYUB6eXRvci5jb20g
PGhwYUB6eXRvci5jb20+IHdyb3RlOg0KPj4gDQo+Pj4gSW5nbzogSSB3YXNuJ3QgdGFsa2luZyBu
ZWNlc3NhcmlseSBhYm91dCB0aGUgc3BlY2lmaWNzIG9mIGVhY2ggYml0LCBidXQgcmF0aGVyIHRo
ZSBnZW5lcmFsIA0KPj4+IGNvbmNlcHQgYWJvdXQgYmVpbmcgYWJsZSB0byB1c2UgbWFjcm9zIGlu
IGlubGluZXMuLi4NCj4+IA0KPj4gT2ssIGFncmVlZCBhYm91dCB0aGF0IHBhcnQgLSBhbmQgc29t
ZSBvZiB0aGUgcGF0Y2hlcyBkaWQgaW1wcm92ZSByZWFkYWJpbGl0eS4NCj4+IA0KPj4gQWxzbywg
dGhlIDI3NSBsaW5lcyBtYWNyb3MucyBpcyBhIGxvdCBuaWNlciB0aGFuIHRoZSA0LDIwMCBsaW5l
cyBtYWNyb3MuUy4NCj4+IA0KPj4gQWxzbywgSSdtIG5vdCBhZ2FpbnN0IHVzaW5nIHdvcmthcm91
bmRzIHdoZW4gdGhlIGJlbmVmaXRzIGFyZSBsYXJnZXIgdGhhbiB0aGUgY29zdHMsIGJ1dCBJIGFt
IA0KPj4gYWdhaW5zdCAqaGlkaW5nKiB0aGUgZmFjdCB0aGF0IHRoZXNlIGFyZSB3b3JrYXJvdW5k
cyBhbmQgdGhhdCBmb3Igc29tZSBvZiB0aGVtIHRoZXJlIGFyZSBjb3N0cy4NCj4gDQo+IEFncmVl
ZCwgb2YgY291cnNlLg0KPiANCj4+PiBJIGNhbiBzZW5kIHlvdSBzb21ldGhpbmcgSSBoYXZlIGJl
ZW4gd29ya2luZyBvbiBpbiB0aGUgYmFja2dyb3VuZCwgYnV0IGhhdmUgYmVlbiBob2xkaW5nIG9m
ZiANCj4+PiBvbiBiZWNhdXNlIG9mIHRoaXMsIGluIHRoZSBtb3JuaW5nIG15IHRpbWUuDQo+PiAN
Cj4+IEJUVy4sIEkgaGF2ZSBhcHBsaWVkIG1vc3Qgb2YgdGhlIHNlcmllcyB0byB0aXA6eDg2L2ti
dWlsZCBhbHJlYWR5LCBhbmQgd2lsbCBwdXNoIHRoZW0gb3V0IGxhdGVyIA0KPj4gdG9kYXkgYWZ0
ZXIgc29tZSB0ZXN0aW5nLiBJIGRpZG4ndCBhcHBseSB0aGUgZmluYWwgMyBwYXRjaGVzIGFzIHRo
ZXkgaGF2ZSBkZXBlbmRlbmNpZXMsIGJ1dCANCj4+IGFwcGxpZWQgdGhlIGJhc2ljcyBhbmQgZml4
ZWQgdXAgdGhlIGNoYW5nZWxvZ3MuDQo+PiANCj4+IFNvIHlvdSBjYW4gcmVseSBvbiB0aGlzLg0K
PiANCj4gV29uZGVyZnVsLg0KPiANCj4gSGVyZSBpcyB0aGUgaG9ycmlibGUgY29kZSBJIG1lbnRp
b25lZCB5ZXN0ZXJkYXkuICBUaGlzIGlzIGFib3V0DQo+IGltcGxlbWVudGluZyB0aGUgaW1tZWRp
YXRlLXBhdGNoaW5nIGZyYW1ld29yayB0aGF0IExpbnVzIGFuZCBvdGhlcnMgaGF2ZQ0KPiBkaXNj
dXNzZWQgKGl0IGhlbHBzIGJvdGggcGVyZm9ybWFuY2UgYW5kIGtlcm5lbCBoYXJkZW5pbmcpOg0K
PiANCj4gV2FybmluZzogdGhpcyBzdHVmZiBjYW4gY2F1c2Ugc2VyaW91cyBkYW1hZ2UgdG8geW91
ciBleWVzLCBhbmQgdGhpcyBpcyBhDQo+IGp1c3QgYSBzbWFsbCBjaHVuayBvZiB0aGUgd2hvbGUg
bWVzczsgYW5kIHJlbHlpbmcgb24gZ2FzIG1hY3JvcywgYXMNCj4gYnJhaW4gZGFtYWdlZCBhcyB0
aGV5IGFyZSwgcmVhbGx5IGlzIG11Y2gsIG11Y2ggY2xlYW5lciB0aGFuIG5vdDoNCj4gDQo+IAlo
dHRwczovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwOiUy
RiUyRnd3dy56eXRvci5jb20lMkZ+aHBhJTJGZm9vLlMmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0
JTQwdm13YXJlLmNvbSU3QzMyNmYxYTNiZWI0NjQ5ZGYzMTk1MDhkNjJhMzA0MmZhJTdDYjM5MTM4
Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MxJTdDMCU3QzYzNjc0Mjc4NDExMTY3MTEyMiZh
bXA7c2RhdGE9YW5ZSU9YemxTVFhQUUt0dFRCSGpTUWdhcEJtYU85Z2ZpYkJGMzRabEhlUSUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KDQpGdW5ueS4gSW1tZWRpYXRlLXBhdGNoaW5nIGlzIHdoYXQgSSB3YXMg
cGxheWluZyB3aXRoIHdoZW4gSSBlbmNvdW50ZXJlZCB0aGUNCmdjYyBpc3N1ZS4gUGVyZm9ybWFu
Y2UgZ290IHdvcnNlIGluc3RlYWQgb2YgaW1wcm92aW5nIChvciBhdCBsZWFzdCBzdGF5aW5nDQp0
aGUgc2FtZSksIGJlY2F1c2UgaW5saW5pbmcgZ290IGNyYXp5Lg0KDQpBbnlob3csIHdhaXQgZm9y
IG15IHNvb24tdG8tYmUtc2VudCBSRkMgaW4gd2hpY2ggSSBkZWZpbmUgYSBtYWNybyBjYWxsZWQN
CuKAnGNhbGzigJ0gKHRvIHJlZHVjZSB0aGUgcmV0cG9saW5lIG92ZXJoZWFkKSBiZWZvcmUgeW91
IHRhbGsgYWJvdXQgZGFtYWdlIHRvDQp0aGUgZXllcy4NCg0K
