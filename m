Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0F1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9460E20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KmVm7576"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9460E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeKGT2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:28:43 -0500
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:22592
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbeKGT2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrVQGKw18OK5PCFILqacK4T2/BaCkkhcpI41SmKiDjA=;
 b=KmVm7576G7Mws+krS70v5mxz3cmb/fkiJSnSj8V/lZQLsL9F0RSZKPdadCiQVwsFjvIJrI05Dbllbf5SJbICqeQWf7aap5VVgtiioj87LPiPybvjoeGkjdcIAk0TzeOhdP7tSahWy+RCDMOZZ1wCEr6jaB2G1LWG0dT6l57L2hQ=
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com (10.170.243.19) by
 HE1PR05MB1868.eurprd05.prod.outlook.com (10.166.86.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.36; Wed, 7 Nov 2018 09:59:02 +0000
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::5829:b089:b09b:ba47]) by HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::5829:b089:b09b:ba47%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 09:59:02 +0000
From:   Tariq Toukan <tariqt@mellanox.com>
To:     Aaron Lu <aaron.lu@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?UGF3ZcWCIFN0YXN6ZXdza2k=?= <pstaszewski@itcare.pl>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yoel Caspersen <yoel@kviknet.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm/page_alloc: free order-0 pages through PCP in
 page_frag_free()
Thread-Topic: [PATCH v2 1/2] mm/page_alloc: free order-0 pages through PCP in
 page_frag_free()
Thread-Index: AQHUdZGVagQSzmtOa0+RnNIAeCEPrqVEFdoA
Date:   Wed, 7 Nov 2018 09:59:02 +0000
Message-ID: <ec2e45bb-5c28-8f89-5bb5-041f68f79b51@mellanox.com>
References: <20181105085820.6341-1-aaron.lu@intel.com>
 <20181106052833.GC6203@intel.com>
In-Reply-To: <20181106052833.GC6203@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR02CA0024.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::37) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB1868;6:28Elo1OXXEDXdsRFZkz2DMjqONre3CMwJetlkKpfv+VH53QdH4OalW2/VtKjzn7R1X6ShCMc4Q1+X/jimDWl5x0KZVN6lfpv9d2rwHcvU25P0q4MsqpoXMhFKcI6RT4ppptBg3zJJ498pe8pfOxO797+ZIK5UBwaVRe2PpTIoxwqBg9JqEvACR3xEkfpskifAGx7gLuRL1r8oMjuVcbpuvhoQTHADbfemlJSAJkkblE+wRNWOzBeowNo81wfrPPiY1gzkVTRhJXLsJc0+q4RsRPUM+WqD9foLLRiZHobDz5Cj62h0bJx4ZzhqeF+QNLJeYCKn/ngfU1lg+Q67cFRusGReHOUJsBgEoq+ieJl1C3neuESnXZwEjvlaA7EyfyOQZFYFQKl4EW9Lo8/qpRKKZTRnSpc1ktu+6p/wZnmIOauqRjE0Xb5fU+BfG5Humk4qiVONDV1tn4M+ZcUlvBJqA==;5:nSiz569QIAsD4CiuQwVBqzcnHw1v/EmQTdKC7uwFJCnQ1Z6PTQNEEswdd8lMpI+KcM0t5z6FjGOvxMgy03Aaqs9DtBT3uJxxhYimIrEBTk45Pn4UtokICH3VQ76jFTIAb1zJba5gJYYrQm7uiOHzqBMkI+GSpDtKUXS9mDEy9xg=;7:eaYiOBUsz+a555ijmGWEAe3RrrbPWqIY9GUpw1htJ2Gb/F1+W7nWZOLCD2i6CGeGMczRkMD69jGoDf4qYgaMelqh9l4sJ8VjdGFCgYfNcu77j1uQsLPID/q13saGYWSq2+K5uBHfnqy6kk9udq+J0g==
x-ms-office365-filtering-correlation-id: d968f1d9-1130-4be7-c311-08d64497a4ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB1868;
x-ms-traffictypediagnostic: HE1PR05MB1868:
x-microsoft-antispam-prvs: <HE1PR05MB1868ADDD4A0AEEF45D8395EDAEC40@HE1PR05MB1868.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR05MB1868;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB1868;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(366004)(54534003)(189003)(199004)(71190400001)(6512007)(6306002)(71200400001)(6116002)(53936002)(7736002)(305945005)(106356001)(6436002)(31686004)(99286004)(25786009)(3846002)(2201001)(86362001)(6246003)(2900100001)(31696002)(105586002)(486006)(52116002)(2906002)(446003)(476003)(2616005)(11346002)(2501003)(110136005)(229853002)(39060400002)(54906003)(97736004)(4326008)(81156014)(186003)(76176011)(966005)(7416002)(81166006)(478600001)(8676002)(256004)(14444005)(26005)(5660300001)(66066001)(36756003)(68736007)(53546011)(386003)(6506007)(102836004)(14454004)(8936002)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB1868;H:HE1PR05MB3257.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 50yvaebOK6C4d8BIlFJqW186UkHbMgQrBHIB4yxE9Xz3z95TTTzzPCdtH5gycuEfavglW7p+h0YZ+s6Fb5a7YfAUY3Wc33FhJm8xckUZKE03UoHl3FU18X5NFEFxKENnPXppEUl2UxUGX+qE1NCwSpWvEf9/zoyBSNAkuR4mbank/xoVK4RrPIuPMa7ljElSrt13dq8QUTPpo4CJdW6qYcbVkuk1Udhd5wPzdVlyK4F9k7Rz14IUXr6LYUTIHFNJV1efhkr3f1tN2Q27gxqYe5Li/j9VdhyTbGwhsvjNs1B2dkqnrVunNDXiReRUTtzpD0/07uXHU2LVVPoHajmEQDPPwUDqQStcaywLvZfrj/g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E84CDD3EFD6BC4E914933E12F5749A7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d968f1d9-1130-4be7-c311-08d64497a4ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 09:59:02.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB1868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA2LzExLzIwMTggNzoyOCBBTSwgQWFyb24gTHUgd3JvdGU6DQo+IHBhZ2VfZnJhZ19m
cmVlKCkgY2FsbHMgX19mcmVlX3BhZ2VzX29rKCkgdG8gZnJlZSB0aGUgcGFnZSBiYWNrIHRvDQo+
IEJ1ZGR5LiBUaGlzIGlzIE9LIGZvciBoaWdoIG9yZGVyIHBhZ2UsIGJ1dCBmb3Igb3JkZXItMCBw
YWdlcywgaXQNCj4gbWlzc2VzIHRoZSBvcHRpbWl6YXRpb24gb3Bwb3J0dW5pdHkgb2YgdXNpbmcg
UGVyLUNwdS1QYWdlcyBhbmQgY2FuDQo+IGNhdXNlIHpvbmUgbG9jayBjb250ZW50aW9uIHdoZW4g
Y2FsbGVkIGZyZXF1ZW50bHkuDQo+IA0KPiBQYXdlxYIgU3Rhc3pld3NraSByZWNlbnRseSBzaGFy
ZWQgaGlzIHJlc3VsdCBvZiAnaG93IExpbnV4IGtlcm5lbA0KPiBoYW5kbGVzIG5vcm1hbCB0cmFm
ZmljJ1sxXSBhbmQgZnJvbSBwZXJmIGRhdGEsIEplc3BlciBEYW5nYWFyZCBCcm91ZXINCj4gZm91
bmQgdGhlIGxvY2sgY29udGVudGlvbiBjb21lcyBmcm9tIHBhZ2UgYWxsb2NhdG9yOg0KPiANCj4g
ICAgbWx4NWVfcG9sbF90eF9jcQ0KPiAgICB8DQo+ICAgICAtLTE2LjM0JS0tbmFwaV9jb25zdW1l
X3NrYg0KPiAgICAgICAgICAgICAgIHwNCj4gICAgICAgICAgICAgICB8LS0xMi42NSUtLV9fZnJl
ZV9wYWdlc19vaw0KPiAgICAgICAgICAgICAgIHwgICAgICAgICAgfA0KPiAgICAgICAgICAgICAg
IHwgICAgICAgICAgIC0tMTEuODYlLS1mcmVlX29uZV9wYWdlDQo+ICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgIHwNCj4gICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgfC0tMTAuMTAlLS1xdWV1ZWRfc3Bpbl9sb2NrX3Nsb3dwYXRoDQo+ICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgIHwNCj4gICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgIC0tMC42NSUtLV9yYXdfc3Bpbl9sb2NrDQo+ICAgICAgICAgICAgICAgfA0KPiAgICAg
ICAgICAgICAgIHwtLTEuNTUlLS1wYWdlX2ZyYWdfZnJlZQ0KPiAgICAgICAgICAgICAgIHwNCj4g
ICAgICAgICAgICAgICAgLS0xLjQ0JS0tc2tiX3JlbGVhc2VfZGF0YQ0KPiANCj4gSmVzcGVyIGV4
cGxhaW5lZCBob3cgaXQgaGFwcGVuZWQ6IG1seDUgZHJpdmVyIFJYLXBhZ2UgcmVjeWNsZQ0KPiBt
ZWNoYW5pc20gaXMgbm90IGVmZmVjdGl2ZSBpbiB0aGlzIHdvcmtsb2FkIGFuZCBwYWdlcyBoYXZl
IHRvIGdvDQo+IHRocm91Z2ggdGhlIHBhZ2UgYWxsb2NhdG9yLiBUaGUgbG9jayBjb250ZW50aW9u
IGhhcHBlbnMgZHVyaW5nDQo+IG1seDUgRE1BIFRYIGNvbXBsZXRpb24gY3ljbGUuIEFuZCB0aGUg
cGFnZSBhbGxvY2F0b3IgY2Fubm90IGtlZXANCj4gdXAgYXQgdGhlc2Ugc3BlZWRzLlsyXQ0KPiAN
Cj4gSSB0aG91Z2h0IHRoYXQgX19mcmVlX3BhZ2VzX29rKCkgYXJlIG1vc3RseSBmcmVlaW5nIGhp
Z2ggb3JkZXINCj4gcGFnZXMgYW5kIHRob3VnaHQgdGhpcyBpcyBhbiBsb2NrIGNvbnRlbnRpb24g
Zm9yIGhpZ2ggb3JkZXIgcGFnZXMNCj4gYnV0IEplc3BlciBleHBsYWluZWQgaW4gZGV0YWlsIHRo
YXQgX19mcmVlX3BhZ2VzX29rKCkgaGVyZSBhcmUNCj4gYWN0dWFsbHkgZnJlZWluZyBvcmRlci0w
IHBhZ2VzIGJlY2F1c2UgbWx4NSBpcyB1c2luZyBvcmRlci0wIHBhZ2VzDQo+IHRvIHNhdGlzZnkg
aXRzIHBhZ2UgcG9vbCBhbGxvY2F0aW9uIHJlcXVlc3QuWzNdDQo+IA0KDQpUaGFua3MgZm9yIHlv
dXIgcGF0Y2ghDQpBY2tlZC1ieTogVGFyaXEgVG91a2FuIDx0YXJpcXRAbWVsbGFub3guY29tPg0K
DQo+IFRoZSBmcmVlIHBhdGggYXMgcG9pbnRlZCBvdXQgYnkgSmVzcGVyIGlzOg0KPiBza2JfZnJl
ZV9oZWFkKCkNCj4gICAgLT4gc2tiX2ZyZWVfZnJhZygpDQo+ICAgICAgLT4gcGFnZV9mcmFnX2Zy
ZWUoKQ0KPiBBbmQgdGhlIHBhZ2VzIGJlaW5nIGZyZWVkIG9uIHRoaXMgcGF0aCBhcmUgb3JkZXIt
MCBwYWdlcy4NCj4gDQo+IEZpeCB0aGlzIGJ5IGRvaW5nIHNpbWlsYXIgdGhpbmdzIGFzIGluIF9f
cGFnZV9mcmFnX2NhY2hlX2RyYWluKCkgLQ0KPiBzZW5kIHRoZSBiZWluZyBmcmVlZCBwYWdlIHRv
IFBDUCBpZiBpdCdzIGFuIG9yZGVyLTAgcGFnZSwgb3INCj4gZGlyZWN0bHkgdG8gQnVkZHkgaWYg
aXQgaXMgYSBoaWdoIG9yZGVyIHBhZ2UuDQo+IA0KPiBXaXRoIHRoaXMgY2hhbmdlLCBQYXdlxYIg
aGFzbid0IG5vdGljZWQgbG9jayBjb250ZW50aW9uIHlldCBpbg0KPiBoaXMgd29ya2xvYWQgYW5k
IEplc3BlciBoYXMgbm90aWNlZCBhIDclIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50DQo+IHVzaW5n
IGEgbWljcm8gYmVuY2htYXJrIGFuZCBsb2NrIGNvbnRlbnRpb24gaXMgZ29uZS4gSWxpYXMnIHRl
c3QNCj4gb24gYSAnbG93JyBzcGVlZCAxR2JpdCBpbnRlcmZhY2Ugb24gYW4gY29ydGV4LWE1MyBz
aG93cyB+MTElDQo+IHBlcmZvcm1hbmNlIGJvb3N0IHRlc3Rpbmcgd2l0aCA2NGJ5dGUgcGFja2V0
cyBhbmQgX19mcmVlX3BhZ2VzX29rKCkNCj4gZGlzYXBwZWFyZWQgZnJvbSBwZXJmIHRvcC4NCj4g
DQo+IFsxXTogaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbmV0ZGV2L21zZzUzMTM2Mi5o
dG1sDQo+IFsyXTogaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbmV0ZGV2L21zZzUzMTQy
MS5odG1sDQo+IFszXTogaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbmV0ZGV2L21zZzUz
MTU1Ni5odG1sDQo+IFJlcG9ydGVkLWJ5OiBQYXdlxYIgU3Rhc3pld3NraSA8cHN0YXN6ZXdza2lA
aXRjYXJlLnBsPg0KPiBBbmFseXNlZC1ieTogSmVzcGVyIERhbmdhYXJkIEJyb3VlciA8YnJvdWVy
QHJlZGhhdC5jb20+DQo+IEFja2VkLWJ5OiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6
Pg0KPiBBY2tlZC1ieTogTWVsIEdvcm1hbiA8bWdvcm1hbkB0ZWNoc2luZ3VsYXJpdHkubmV0Pg0K
PiBBY2tlZC1ieTogSmVzcGVyIERhbmdhYXJkIEJyb3VlciA8YnJvdWVyQHJlZGhhdC5jb20+DQo+
IEFja2VkLWJ5OiBJbGlhcyBBcGFsb2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+
DQo+IFRlc3RlZC1ieTogSWxpYXMgQXBhbG9kaW1hcyA8aWxpYXMuYXBhbG9kaW1hc0BsaW5hcm8u
b3JnPg0KPiBBY2tlZC1ieTogQWxleGFuZGVyIER1eWNrIDxhbGV4YW5kZXIuaC5kdXlja0BsaW51
eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIEx1IDxhYXJvbi5sdUBpbnRlbC5j
b20+DQo+IC0tLQ0KPiB2Mjogb25seSBjaGFuZ2Vsb2cgY2hhbmdlczoNCj4gICAgICAtIHJlbW92
ZSB0aGUgZHVwbGljYXRlZCBza2JfZnJlZV9mcmFnKCkgYXMgcG9pbnRlZCBieSBKZXNwZXI7DQo+
ICAgICAgLSBhZGQgSWxpYXMnIHRlc3QgcmVzdWx0Ow0KPiAgICAgIC0gYWRkIHBlb3BsZSdzIGFj
ay90ZXN0IHRhZy4NCj4gDQo+ICAgbW0vcGFnZV9hbGxvYy5jIHwgMTAgKysrKysrKystLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbW0vcGFnZV9hbGxvYy5jIGIvbW0vcGFnZV9hbGxvYy5jDQo+IGluZGV4IGFl
MzE4Mzk4NzRiOC4uOTFhOWE2YWY0MWEyIDEwMDY0NA0KPiAtLS0gYS9tbS9wYWdlX2FsbG9jLmMN
Cj4gKysrIGIvbW0vcGFnZV9hbGxvYy5jDQo+IEBAIC00NTU1LDggKzQ1NTUsMTQgQEAgdm9pZCBw
YWdlX2ZyYWdfZnJlZSh2b2lkICphZGRyKQ0KPiAgIHsNCj4gICAJc3RydWN0IHBhZ2UgKnBhZ2Ug
PSB2aXJ0X3RvX2hlYWRfcGFnZShhZGRyKTsNCj4gICANCj4gLQlpZiAodW5saWtlbHkocHV0X3Bh
Z2VfdGVzdHplcm8ocGFnZSkpKQ0KPiAtCQlfX2ZyZWVfcGFnZXNfb2socGFnZSwgY29tcG91bmRf
b3JkZXIocGFnZSkpOw0KPiArCWlmICh1bmxpa2VseShwdXRfcGFnZV90ZXN0emVybyhwYWdlKSkp
IHsNCj4gKwkJdW5zaWduZWQgaW50IG9yZGVyID0gY29tcG91bmRfb3JkZXIocGFnZSk7DQo+ICsN
Cj4gKwkJaWYgKG9yZGVyID09IDApDQo+ICsJCQlmcmVlX3VucmVmX3BhZ2UocGFnZSk7DQo+ICsJ
CWVsc2UNCj4gKwkJCV9fZnJlZV9wYWdlc19vayhwYWdlLCBvcmRlcik7DQo+ICsJfQ0KPiAgIH0N
Cj4gICBFWFBPUlRfU1lNQk9MKHBhZ2VfZnJhZ19mcmVlKTsNCj4gICANCj4gDQo=
