Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541F2C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106CA2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="McXhCOJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfBAJkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:40:18 -0500
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:35376
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729183AbfBAJkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ87ZHPdiBsH1kqEQYWnH4J5oz9ekGVddd/HL529Akw=;
 b=McXhCOJcjYApu8XIDGqU4lqwL3isTtHcKhokPQbq4DoLPEF6sMFVuhGJUxrx439v6YwhN5lt/jU+Rr0IJen1NmL+oGbtpK3cYOYyex8g6zZaqyPHYgvYgSoe1g4bagtFjFPZVwUZ6PQ6mudNvRhwCvGgwWMr319pRWNYrV4yCBc=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB5079.eurprd03.prod.outlook.com (20.178.91.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 09:40:14 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 09:40:14 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
Subject: Re: [Xen-devel] xen/mem-reservation API and out-of-tree kernel
 modules
Thread-Topic: [Xen-devel] xen/mem-reservation API and out-of-tree kernel
 modules
Thread-Index: AQHUuW2awNkJGzJtBUW2HZJ5omKh0aXJ6V2AgAC3LQCAAAmwAIAABy2A
Date:   Fri, 1 Feb 2019 09:40:14 +0000
Message-ID: <b7a8ff51-d929-f8e9-e52e-ea504d36348b@epam.com>
References: <f3ca533d-7f51-c59e-6a96-4e1fba687c8f@epam.com>
 <alpine.DEB.2.10.1901311343370.22962@sstabellini-ThinkPad-X260>
 <6deaf110-44a7-59f9-a4d8-52ff9428cd9d@epam.com>
 <a9f41730-4e51-242e-7625-fc5f6b8ecbe4@suse.com>
In-Reply-To: <a9f41730-4e51-242e-7625-fc5f6b8ecbe4@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB5079;6:IFlnVGDoMr6GQLoEKIjVpE8pOOz44MVsaqVdYZksZZGD3LCfWlbkyPzYfZRdFJD/1BKiz6Y6gcabVtheaYAWw6EN+56BSbUT0cVmnsmuLewF++uCJQMu5Vt/SbZVKTtEco74wjwonUBly7G98N5+Cmwc4JnREYAc4lXp2FXs0BpKvx14keIlqfY11Yk8RNbmVZbXo5sZyivtKxbc1CTBtsVjWbhjSIN+yV78QnEIlrrSar4vc4qxNnkM6EzhoAEWK8y95GPl8ANUzU4zPz8kgoC/IUV+ucytU1rl7ZM78ml39B9rmsWyXmdihPFC0YPasnl4NzU88oJiySk4m+ePJjhcBAOqIl48lbalcne8gBEWyQ3XrfEnB4TzdPzVAZRs3e/6FVW74rW0YVZ2QO6NLhzTmXdBhWjcxATvwGSWPptOINvf9919W5uspd8DN3qwSS1DowXmBu/4wePxzKqakA==;5:oAqj6EzxC5wQgkJRHkWnImNiPnY1+52m2luTHopQnyuK3NLnR5XsEra6JsDVL629ZkskY3oKaUywXIy6SrbM5gAlZNvAOwcwq7fkCYMhLvHi9QtbHKRulG1bnFJnzlpVrCNOyXJDyHNB5htf/UsEY5wGFirai5FO/kL+kzME5Lw66q5h0DXZnTCVWMoqs0vEQZv+Vz+4E7L+hrt4YJ6Fig==;7:Qg/k+x3J5Q4Nni/oOcDY/CSZIBx0shaJLXUU5jNZKOkYK20THTu57yEQtajFKjySv5WfDQia/ULvzh1qrwsAw3qZmc2xDqJqCHc3eNSYBXBOgoO9CV9H3CNDom4e0enYNxGErcNlfwu13RIiWFsctw==
x-ms-office365-filtering-correlation-id: 4bd16c18-a784-425f-46e4-08d68829448f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB5079;
x-ms-traffictypediagnostic: AM6PR03MB5079:
x-microsoft-antispam-prvs: <AM6PR03MB5079C761762609E2904221AAE7920@AM6PR03MB5079.eurprd03.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(476003)(68736007)(2616005)(11346002)(446003)(14444005)(305945005)(486006)(7736002)(26005)(31686004)(71200400001)(256004)(6506007)(8936002)(6306002)(554214002)(6512007)(8676002)(81156014)(97736004)(71190400001)(93886005)(81166006)(80792005)(186003)(66066001)(99286004)(110136005)(229853002)(31696002)(105586002)(6486002)(86362001)(54906003)(316002)(102836004)(106356001)(4326008)(53936002)(36756003)(25786009)(966005)(76176011)(6246003)(6436002)(2906002)(53546011)(72206003)(14454004)(55236004)(478600001)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB5079;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QkTrYe0zGnf3zm7qWKoR5Q2COOcXuact33jvleqCJ3RTA0BhBaY111A5b0hq4wuiHOyak3J+xxqHPeKB3LdE04B7Fxx/Cicx8uuKdDHO7Z3jLa1WwpRo6y/UqPc+rD4J4QnVrbNcD58tWLDwSwVEpl1Jxm99sUGL5xYy82Zzms/+KZcDMuaRnpoOgr6sSx+5lTnTXxPXCU092DyE1T5qWc06FCLRRAs72un8/tVrD2dTrmYkLVr4RQBoBWUMju+nkBSU3j8ywja52v/K+nG2Jl8NJ0AF1ZOjLrNkCQ9JXqN4SE/jQC+tWX2zG+YD9mpgl8soELziIAjteS8QtGxuA7gNxQkcTiqJ2Qg7g44VXsX2NokfSDMJe3JNckr2LDUCXPQrY37Nfcn5Trb2UEbhIWKsbotnKcvJse9IBdA4VKQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2BD4306FC4E0D42A359B852A92D4066@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd16c18-a784-425f-46e4-08d68829448f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 09:40:14.3531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xLzE5IDExOjE0IEFNLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiBPbiAwMS8wMi8yMDE5
IDA5OjM5LCBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyB3cm90ZToNCj4+IE9uIDEvMzEvMTkgMTE6
NDQgUE0sIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4+PiBPbiBUaHUsIDMxIEphbiAyMDE5
LCBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyB3cm90ZToNCj4+Pj4gSGVsbG8sDQo+Pj4+DQo+Pj4+
IEkgYW0gd29ya2luZyBvbiBwb3J0aW5nIGFuIG91dC1vZi10cmVlIGtlcm5lbCBkcml2ZXIgdG8g
dGhlIGtlcm5lbA0KPj4+PiA1LjAgYW5kIHRoYXQgZHJpdmVyIHVzZXMgZnVuY3Rpb25hbGl0eSBw
cm92aWRlZCBieQ0KPj4+PiBkcml2ZXJzL3hlbi9tZW0tcmVzZXJ2YXRpb24uYw0KPj4+PiBtb2R1
bGUuwqAgU2luY2UgY29tbWl0IFsxXSBpdCBpcyBub3QgcG9zc2libGUgdG8gYnVpbGQgYSBrZXJu
ZWwgbW9kdWxlDQo+Pj4+IHdoaWNoIHVzZXMgbWVtLXJlc2VydmF0aW9uIEFQSSBhcyB4ZW5fc2Ny
dWJfcGFnZXMgdmFyaWFibGUsIHdoaWNoIGlzDQo+Pj4+IGNoZWNrZWQgaW4NCj4+Pj4geGVubWVt
X3Jlc2VydmF0aW9uX3NjcnViX3BhZ2UsIGJlY2FtZSBhIGtlcm5lbCBtb2R1bGUgcGFyYW1ldGVy
IGFuZCBpcw0KPj4+PiBub3cgb25seQ0KPj4+PiBhY2Nlc3NpYmxlIGZvciBidWlsdC1pbiBtb2R1
bGVzOg0KPj4+Pg0KPj4+PiBzdGF0aWMgaW5saW5lIHZvaWQgeGVubWVtX3Jlc2VydmF0aW9uX3Nj
cnViX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+Pj4+IF5eXl5eXl5eXl5eXl4NCj4+Pj4gew0K
Pj4+PiAgICDCoMKgwqAgaWYgKHhlbl9zY3J1Yl9wYWdlcykNCj4+Pj4gICAgwqDCoMKgwqDCoMKg
wqAgXl5eXl5eXl5eXl5eXl5eDQo+Pj4+ICAgIMKgwqDCoCDCoMKgwqAgY2xlYXJfaGlnaHBhZ2Uo
cGFnZSk7DQo+Pj4+IH0NCj4+Pj4NCj4+Pj4gVGhpcyByZXN1bHRzIGluIGxpbmstdGltZSB3YXJu
aW5nOg0KPj4+Pg0KPj4+PiAgICDCoMKgwqAgV0FSTklORzogInhlbl9zY3J1Yl9wYWdlcyIgW3lv
dXJtb2R1bGUua29dIHVuZGVmaW5lZCENCj4+Pj4NCj4+Pj4gYW5kIHRodXMgbm90IGFsbG93aW5n
IHRoZSBtb2R1bGUgdG8gcnVuLiBBdCB0aGUgbW9tZW50IEkgY2FuIG9ubHkgc2VlIGENCj4+Pj4g
cG9zc2libGUgZml4DQo+Pj4+IGZvciB0aGlzIGJ5IG1ha2luZyB0aGUgZm9sbG93aW5nIGNoYW5n
ZToNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL21lbS1yZXNlcnZhdGlvbi5j
IGIvZHJpdmVycy94ZW4vbWVtLXJlc2VydmF0aW9uLmMNCj4+Pj4gaW5kZXggMzc4MmNmMDcwMzM4
Li44NWZlY2ZlYzUwZTEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMveGVuL21lbS1yZXNlcnZh
dGlvbi5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMveGVuL21lbS1yZXNlcnZhdGlvbi5jDQo+Pj4+IEBA
IC0xOCw2ICsxOCw3IEBADQo+Pj4+DQo+Pj4+ICAgIMKgYm9vbCBfX3JlYWRfbW9zdGx5IHhlbl9z
Y3J1Yl9wYWdlcyA9DQo+Pj4+IElTX0VOQUJMRUQoQ09ORklHX1hFTl9TQ1JVQl9QQUdFU19ERUZB
VUxUKTsNCj4+Pj4gICAgwqBjb3JlX3BhcmFtKHhlbl9zY3J1Yl9wYWdlcywgeGVuX3NjcnViX3Bh
Z2VzLCBib29sLCAwKTsNCj4+Pj4gK0VYUE9SVF9TWU1CT0woeGVuX3NjcnViX3BhZ2VzKTsNCj4+
Pj4NCj4+Pj4gYnV0IHRoaXMgbG9va3MgYSBiaXQgdW51c3VhbCBmb3IgdGhlIGtlcm5lbD8NCj4+
Pj4NCj4+Pj4gSSBhbSBsb29raW5nIGZvciBjb21tdW5pdHkgYWR2aWNlIGhlcmUgYW5kIGhlbHAN
Cj4+Pj4NCj4+Pj4gVGhhbmsgeW91LA0KPj4+PiBPbGVrc2FuZHINCj4+Pj4NCj4+Pj4gWzFdDQo+
Pj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTE5N2VjYjM4MDJjMDQ0OTlkOGZmNGY4Y2IyOGY2ZWZh
MDA4MDY3ZGINCj4+PiBUaGUgYWx0ZXJuYXRpdmUgd291bGQgYmUgdG8gdHVybiB4ZW5tZW1fcmVz
ZXJ2YXRpb25fc2NydWJfcGFnZSBpbnRvIGENCj4+PiByZWd1bGFyIGZ1bmN0aW9uIChub3QgYSBz
dGF0aWMgaW5saW5lKT8NCj4+IFllcywgaXQgc2VlbXMgdGhlcmUgaXMgbm8gb3RoZXIgcmVhc29u
YWJsZSBzb2x1dGlvbiB0byB0aGlzLCBidXQNCj4+IGEgcmVndWxhciBmdW5jdGlvbi4gSSdsbCBz
ZW5kIGEgcGF0Y2ggZm9yIHRoYXQNCj4gV2hhdCB3b3VsZCB5b3UgZ2Fpbj8gVGhpcyBmdW5jdGlv
biB3b3VsZCBuZWVkIHRvIGJlIGV4cG9ydGVkLg0KWWVzLCB0aGlzIGlzIHRydWUsIHRoZSBmdW5j
dGlvbiBzaG91bGQgYmUgZXhwb3J0ZWQgdGhlbg0KPiBTbyBpdHMgZWl0aGVyIHRoZSB2YXJpYWJs
ZSBvciB0aGUgZnVuY3Rpb24uDQpJIGFtIGEgYml0IGNvbmZ1c2VkIHdpdGggdGhpcyBiZWNhdXNl
IEknbGwgaGF2ZSB0byBleHBvcnQNCm1vZHVsZSBwYXJhbWV0ZXIgaW4gdGhpcyBjYXNlLCBlLmcu
DQoNCmNvcmVfcGFyYW0oeGVuX3NjcnViX3BhZ2VzLCB4ZW5fc2NydWJfcGFnZXMsIGJvb2wsIDAp
Ow0KRVhQT1JUX1NZTUJPTCh4ZW5fc2NydWJfcGFnZXMpOw0KDQp3aGljaCBsb29rcyBhIGJpdCB1
bnVzdWFsIHRvIG1lDQo+DQo+IEp1ZXJnZW4NCg==
