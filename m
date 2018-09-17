Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E499C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ETS1mifZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E499C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbeIQIeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:34:02 -0400
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:35136
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731099AbeIQIeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFP08Q0e7aaIId0OLTbIVxXxqtHi/RlDd3CIBsoRcik=;
 b=ETS1mifZY/jCDvC4jq9B7Lx1LrS9Z+bUzmJ0qfbbXvkheNyo61fV//ZouNOcg4t5KDs5iqofRgf7eGLCJE+ncAqeimTktiq1AxYWm/E00xpH6dq/2cTe2nQsaa36u1j7NLPWlOaPWVjhWkWAPW2KezP6leYVve1GJT23zoF10LU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:08:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:08:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 26/29] audit: Fix extended comparison of GID/EGID
Thread-Topic: [PATCH AUTOSEL 3.18 26/29] audit: Fix extended comparison of
 GID/EGID
Thread-Index: AQHUTjNYvqAcxgM/vEuIA32TxTu5ew==
Date:   Mon, 17 Sep 2018 03:05:53 +0000
Message-ID: <20180917030533.592-26-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:v8HP+rDOzlP3liRZFc8pGhZfrJ8LywY86C4scc66de9k4I8qWUa1YpeMv51RdwRJoRDLCZ5NSGYwYxCYV/xpxBhyJDpNNrS9uC/xASAF6KndJh0sKoAVGMHgryUfQZsx8ALRoQ9POnGWQZRM3KQSAoENDSYSItR/K7EGzahzcoEgcAZzHrMmOy6aKluRiMv3c1umhwnI6Epueu6NKnBmljiHpHc7QyPltM3AEHNnbF4z+1BTWAUuEzjlGakJC/+HmQWj0wegUWNhxM4vIZ9O3lKg/IuM5f+CHZgvVPAqoOKcIitzz6S1aSHHc/eNA+VK7buZ2tmJJiTJ3UEcIjMXD3TBrqgD1xyvMXupyCmsOh9LIYOQ16RZMRC4DwKLHF0TbK7RSqFPZ+poiq7MFagj6vQswcbz7bT1ivnQakXEpaapRxBNb9Qodvr1zreYKFO65TnrpjRKglnz31f5ct6evg==;5:dXMHM+4z2g1LKKlvvmmsMOtk74xKzqZv/HoQmxgZcebZTVlYcMDjDvbgKC42+B/iqQsItKIrHUV7H+P1rfrtyDPt/DCPRL6JawIxIE5JJnUzPQc4fMeEGU70QHtnGehXkK1h+aK8GgH2LoKkeH8SSVc+zOvROYeFQcfD+lurgNA=;7:wB1ZBBSM6doMyv8b3/QhBPauV/uJOUKwiL4Ou9n8y0tWRq7FECAG6xpVx7953V8MaIYRAqDyewWq+oc7p7nVDLP6cQtUr3AgKC+ExORhj2wVrL/wAdBoguJ1BEo54hUxTcVpb9VmmB4vDkn4RDDSgntq0muw4vu+I/FZzoBRBKZLw8UegNZcxzD9fp+ANASzzshQaOjZ+C2CpjVL1HAwUy3xVBZ6XSiJUCuDlqYADjfIT5aUIgmbGr90HOnI26zw
x-ms-office365-filtering-correlation-id: e6a7ef3b-3502-490c-92d4-08d61c4ad705
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB082184FDCC086EE1660D9D4AFB1E0@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5250100002)(53936002)(14454004)(10090500001)(6306002)(6436002)(97736004)(68736007)(7736002)(8936002)(305945005)(105586002)(106356001)(36756003)(10290500003)(81166006)(81156014)(966005)(72206003)(6486002)(8676002)(99286004)(6512007)(478600001)(2501003)(2906002)(446003)(217873002)(256004)(2616005)(66066001)(6666003)(2900100001)(4326008)(107886003)(86612001)(5660300001)(3846002)(86362001)(110136005)(54906003)(186003)(316002)(22452003)(102836004)(6506007)(25786009)(26005)(11346002)(476003)(76176011)(486006)(6116002)(6346003)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: LSkayxqKXXkveKmmHsapSCefRLjLreFA6ayFd+tJ3NVFRnzX87VQ5KExbRJq/B3WMe2F7bUWJ2BPGeG2aiP/eJFCqYE1abXDiJRWF9VpleRR518vKtYbxOcoQkq6T/lYx/RwRjZdPJDaZD0SVubKKo9wIXZDHl2dMDhJFJnTszei1QHlWtlrGX1iyUr6greujv+c8QqVVzNYbfV240ZFsOqgoJoAtS9/oL7uOp5xhva8w54G+dL2lqHJXrc81xzp3XlNZMrSJpEqweRowX4IByvUzLJDyFip4br5QsevodItPqWRJzD+eqZbyKjq0PRX9zulvtbBqTOn/174DO+MWD01jnDr4jDh6WJ7facfETY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7612505AE9BB2945A4D2BCAC0B0C25D6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a7ef3b-3502-490c-92d4-08d61c4ad705
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:53.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT25kcmVqIE1vc27DocSNZWsgPG9tb3NuYWNlQHJlZGhhdC5jb20+DQoNClsgVXBzdHJl
YW0gY29tbWl0IGFmODVkMTc3MmUzMWZlZDM0MTY1YTFiM2RlY2VmMzQwY2Y0MDgwYzAgXQ0KDQpU
aGUgYXVkaXRfZmlsdGVyX3J1bGVzKCkgZnVuY3Rpb24gaW4gYXVkaXRzYy5jIHVzZWQgdGhlIGlu
X1tlXWdyb3VwX3AoKQ0KZnVuY3Rpb25zIHRvIGNoZWNrIEdJRC9FR0lEIG1hdGNoLCBidXQgdGhl
c2UgZnVuY3Rpb25zIHVzZSB0aGUgY3VycmVudA0KdGFzaydzIGNyZWRlbnRpYWxzLCB3aGlsZSB0
aGUgY29tcGFyaXNvbiBzaG91bGQgdXNlIHRoZSBjcmVkZW50aWFscyBvZg0KdGhlIHRhc2sgZ2l2
ZW4gdG8gYXVkaXRfZmlsdGVyX3J1bGVzKCkgYXMgYSBwYXJhbWV0ZXIgKHRzaykuDQoNCk5vdGUg
dGhhdCB3ZSBjYW4gdXNlIGdyb3VwX3NlYXJjaChjcmVkLT5ncm91cF9pbmZvLCAuLi4pIGFzIGEN
CnJlcGxhY2VtZW50IGZvciBib3RoIGluX2dyb3VwX3AgYW5kIGluX2Vncm91cF9wIGFzIHRoZXNl
IGZ1bmN0aW9ucyBvbmx5DQpjb21wYXJlIHRoZSBwYXJhbWV0ZXIgdG8gY3JlZC0+ZnNnaWQvZWdp
ZCBhbmQgdGhlbiBjYWxsIGdyb3VwX3NlYXJjaC4NCg0KSW4gZmFjdCwgdGhlIHVzYWdlIG9mIGlu
X2dyb3VwX3Agd2FzIGV2ZW4gbW9yZSBpbmNvcnJlY3Q6IGl0IGNvbXBhcmVzIHRvDQpjcmVkLT5m
c2dpZCAod2hpY2ggaXMgdXN1YWxseSBlcXVhbCB0byBjcmVkLT5lZ2lkKSBhbmQgbm90IGNyZWQt
PmdpZC4NCg0KR2l0SHViIGlzc3VlOg0KaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LWF1ZGl0L2F1
ZGl0LWtlcm5lbC9pc3N1ZXMvODINCg0KRml4ZXM6IDM3ZWViZTM5Yzk3MyAoImF1ZGl0OiBpbXBy
b3ZlIEdJRC9FR0lEIGNvbXBhcmF0aW9uIGxvZ2ljIikNClNpZ25lZC1vZmYtYnk6IE9uZHJlaiBN
b3NuYWNlayA8b21vc25hY2VAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFBhdWwgTW9vcmUg
PHBhdWxAcGF1bC1tb29yZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFu
ZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBrZXJuZWwvYXVkaXRzYy5jIHwgOCArKysr
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9rZXJuZWwvYXVkaXRzYy5jIGIva2VybmVsL2F1ZGl0c2MuYw0KaW5kZXgg
M2E2ZTAxMDEzYjM0Li44ODliYTRjOWE1ZTMgMTAwNjQ0DQotLS0gYS9rZXJuZWwvYXVkaXRzYy5j
DQorKysgYi9rZXJuZWwvYXVkaXRzYy5jDQpAQCAtNDg0LDIwICs0ODQsMjAgQEAgc3RhdGljIGlu
dCBhdWRpdF9maWx0ZXJfcnVsZXMoc3RydWN0IHRhc2tfc3RydWN0ICp0c2ssDQogCQkJcmVzdWx0
ID0gYXVkaXRfZ2lkX2NvbXBhcmF0b3IoY3JlZC0+Z2lkLCBmLT5vcCwgZi0+Z2lkKTsNCiAJCQlp
ZiAoZi0+b3AgPT0gQXVkaXRfZXF1YWwpIHsNCiAJCQkJaWYgKCFyZXN1bHQpDQotCQkJCQlyZXN1
bHQgPSBpbl9ncm91cF9wKGYtPmdpZCk7DQorCQkJCQlyZXN1bHQgPSBncm91cHNfc2VhcmNoKGNy
ZWQtPmdyb3VwX2luZm8sIGYtPmdpZCk7DQogCQkJfSBlbHNlIGlmIChmLT5vcCA9PSBBdWRpdF9u
b3RfZXF1YWwpIHsNCiAJCQkJaWYgKHJlc3VsdCkNCi0JCQkJCXJlc3VsdCA9ICFpbl9ncm91cF9w
KGYtPmdpZCk7DQorCQkJCQlyZXN1bHQgPSAhZ3JvdXBzX3NlYXJjaChjcmVkLT5ncm91cF9pbmZv
LCBmLT5naWQpOw0KIAkJCX0NCiAJCQlicmVhazsNCiAJCWNhc2UgQVVESVRfRUdJRDoNCiAJCQly
ZXN1bHQgPSBhdWRpdF9naWRfY29tcGFyYXRvcihjcmVkLT5lZ2lkLCBmLT5vcCwgZi0+Z2lkKTsN
CiAJCQlpZiAoZi0+b3AgPT0gQXVkaXRfZXF1YWwpIHsNCiAJCQkJaWYgKCFyZXN1bHQpDQotCQkJ
CQlyZXN1bHQgPSBpbl9lZ3JvdXBfcChmLT5naWQpOw0KKwkJCQkJcmVzdWx0ID0gZ3JvdXBzX3Nl
YXJjaChjcmVkLT5ncm91cF9pbmZvLCBmLT5naWQpOw0KIAkJCX0gZWxzZSBpZiAoZi0+b3AgPT0g
QXVkaXRfbm90X2VxdWFsKSB7DQogCQkJCWlmIChyZXN1bHQpDQotCQkJCQlyZXN1bHQgPSAhaW5f
ZWdyb3VwX3AoZi0+Z2lkKTsNCisJCQkJCXJlc3VsdCA9ICFncm91cHNfc2VhcmNoKGNyZWQtPmdy
b3VwX2luZm8sIGYtPmdpZCk7DQogCQkJfQ0KIAkJCWJyZWFrOw0KIAkJY2FzZSBBVURJVF9TR0lE
Og0KLS0gDQoyLjE3LjENCg==
