Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F97C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266C02147D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IueTfL2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266C02147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeHQEi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:38:26 -0400
Received: from mail-dm3nam03on0091.outbound.protection.outlook.com ([104.47.41.91]:39663
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbeHQEiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAwms1zLWD50zThmJznj6ABUhyU351sAXlhcEpHdYOQ=;
 b=IueTfL2heLkEHvF5uB47fVWUt9eVhVWNqXt75RCUyqtrtesybKQVDFWpIJLcvIoNyeSosv3AmZnbxFr0GhtJOw+fG6XZD4l4kYCLDbuT0BexASI/aJhKKXeDXFdeIKADevkdPtznUgRNB6JgRzjQwuT13MAZw+iycojWAGXtYYo=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0140.namprd21.prod.outlook.com (10.173.173.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.5; Fri, 17 Aug 2018 01:35:22 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.009; Fri, 17 Aug 2018
 01:35:22 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Jia He <hejianet@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
CC:     Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jia He <jia.he@hxt-semitech.com>
Subject: Re: [RESEND PATCH v10 6/6] mm: page_alloc: reduce unnecessary binary
 search in early_pfn_valid()
Thread-Topic: [RESEND PATCH v10 6/6] mm: page_alloc: reduce unnecessary binary
 search in early_pfn_valid()
Thread-Index: AQHUNcqPgcbvuaLpQECjXKndQXyJeA==
Date:   Fri, 17 Aug 2018 01:35:22 +0000
Message-ID: <c6ed43ee-b09e-1f75-43b3-6cd2808d13f3@microsoft.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-7-git-send-email-hejianet@gmail.com>
In-Reply-To: <1530867675-9018-7-git-send-email-hejianet@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0140;6:Ee4aKeHUqAzkDrxuaCKbQ+yKqn/XR3NCrD+ekX8AemXGiPXRPTZiROjE0og4O7Ve1y3iBLztYZ0Rl8FYxKK0aoDgvUOmKLyYBLHdHTG239hlUnY8k/r/wIVpqI/un5gEISal9VgK0MV5NU8g/S4ZtemgQ+F/gZbjTo6qj8YvbKStZtgZI3OtVDPrPgUibjQlzeDaEUR6UUDDH6jVghPiAWmRvsX3m6Ks/XoR8yC+FAK9+J72GwZ8syAfm90JwiZw5hBiX6SES7tVRGihuV+A7FxWJbamc55okm5GHiFYWa4dOTkSq90U4RVXBolOJSfO9Nmqmzi/QEnulja/faKci/a6dk4IATJ8glr6qzRM9p3HDI/Jz3z0RNGoOTfDhAL/5YH+yTrcisXmCsAmO948k0jz9/IV99WVp2onvvzgYxYF5Ji48sByyMhKsCOKJ/VvyYyboJCxiQsXsKVtPrs4UA==;5:8wBIVCDbiIhYmeS3AfdI/B5d17H2JHA+5nlv2S6JiZJixlJXsRCEZG4hHFvvlTcC2Reziw2uFJ7bfh+g2sjnvRLNqi3EzSLsDkp+hQ8s1Lw/5O9q5hq+aGb1Ixhghi6dkl14eQevBkZtyVbRBWX5DA9nK+bbEskZW1/LvuzW304=;7:mxC4dXb3cQvXb7HNDtrd+Qpzll7J40JlUqGWt4GHsK9UuWq27dWnx/7npgONuCmlt83/k9npKJKPpGdEjVr1KJ2gy7suQB9Ddaeq2K52ClAOSv7f5V0vRG2Ranl77lJ2dXRk4CsZPE94WB2QYxQ4BvHiTaTjUY2FWvyFktEsw6wLb1SOTWoQYKvCHP+Gad4HaAaFsAcKB8QYWBPbHpTNve9hZ4dT/XA+fSyFM1jGcnFwPv63UeuONy1TqnvWwadQ
x-ms-office365-filtering-correlation-id: 62d0278f-7f5d-493e-fe71-08d603e1b319
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0140;
x-ms-traffictypediagnostic: DM5PR21MB0140:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB014054106AC326C98272B9079D3D0@DM5PR21MB0140.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(8121501046)(5005006)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:DM5PR21MB0140;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0140;
x-forefront-prvs: 076777155F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(366004)(396003)(189003)(199004)(10090500001)(31686004)(31696002)(8676002)(86612001)(81156014)(81166006)(476003)(2616005)(22452003)(14454004)(54906003)(110136005)(316002)(486006)(7416002)(7406005)(478600001)(10290500003)(5660300001)(256004)(86362001)(76176011)(217873002)(105586002)(305945005)(7736002)(99286004)(106356001)(11346002)(39060400002)(6512007)(6436002)(4326008)(53936002)(68736007)(229853002)(25786009)(6486002)(5250100002)(6506007)(3846002)(2900100001)(26005)(72206003)(97736004)(53546011)(36756003)(102836004)(6116002)(446003)(8936002)(186003)(6246003)(66066001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0140;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uulbYGsiV1qKuSDJaGMugXKTCXU6tqKaB5bp9E33zxrol3Zin1VwGE5E+G7or5BAbv+akwsC8+BHiKqHSVYXYSZK8/pJZVqu4uABIOGuU7kTUv4Mp2fY5Prtk60VZ6duTiiDse6uC/eNeknnSLkbJQuCgLqIHCOYOTJ6WJaPZrBpdBvvI8LN7TCdagrDxcY7vFw74DPxYcde+Wc60pQQPs8t0TK3EUdbd7ySn3oCBfpbqsdNxppvzcX9wDSJZrlSflQwa1WQeDuG+to4B80zLt/QxTmblqaAzI4jZ9O25cp+gdYlNwtEBXQbnD0NyFZBDJOYfyZxakGQhZ7aMWm95lWPMXgPQLjM5k7qKzePV90=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7278A4BF60453842886E1096077C73BD@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d0278f-7f5d-493e-fe71-08d603e1b319
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2018 01:35:22.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvNi8xOCA1OjAxIEFNLCBKaWEgSGUgd3JvdGU6DQo+IENvbW1pdCBiOTJkZjFkZTVk
MjggKCJtbTogcGFnZV9hbGxvYzogc2tpcCBvdmVyIHJlZ2lvbnMgb2YgaW52YWxpZCBwZm5zDQo+
IHdoZXJlIHBvc3NpYmxlIikgb3B0aW1pemVkIHRoZSBsb29wIGluIG1lbW1hcF9pbml0X3pvbmUo
KS4gQnV0IHRoZXJlIGlzDQo+IHN0aWxsIHNvbWUgcm9vbSBmb3IgaW1wcm92ZW1lbnQuIEUuZy4g
aW4gZWFybHlfcGZuX3ZhbGlkKCksIGlmIHBmbiBhbmQNCj4gcGZuKzEgYXJlIGluIHRoZSBzYW1l
IG1lbWJsb2NrIHJlZ2lvbiwgd2UgY2FuIHJlY29yZCB0aGUgbGFzdCByZXR1cm5lZA0KPiBtZW1i
bG9jayByZWdpb24gaW5kZXggYW5kIGNoZWNrIHdoZXRoZXIgcGZuKysgaXMgc3RpbGwgaW4gdGhl
IHNhbWUNCj4gcmVnaW9uLg0KPiANCj4gQ3VycmVudGx5IGl0IG9ubHkgaW1wcm92ZSB0aGUgcGVy
Zm9ybWFuY2Ugb24gYXJtL2FybTY0IGFuZCB3aWxsIGhhdmUgbm8NCj4gaW1wYWN0IG9uIG90aGVy
IGFyY2hlcy4NCj4gDQo+IEZvciB0aGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQsIGFmdGVyIHRo
aXMgc2V0LCBJIGNhbiBzZWUgdGhlIHRpbWUNCj4gb3ZlcmhlYWQgb2YgbWVtbWFwX2luaXQoKSBp
cyByZWR1Y2VkIGZyb20gMjc5NTZ1cyB0byAxMzUzN3VzIGluIG15DQo+IGFybXY4YSBzZXJ2ZXIo
UURGMjQwMCB3aXRoIDk2RyBtZW1vcnksIHBhZ2VzaXplIDY0aykuDQoNClRoaXMgc2VyaWVzIHdv
dWxkIGJlIGEgbG90IHNpbXBsZXIgaWYgcGF0Y2hlcyA0LCA1LCBhbmQgNiB3ZXJlIGRyb3BwZWQu
DQpUaGUgZXh0cmEgY29tcGxleGl0eSBkb2VzIG5vdCBtYWtlIHNlbnNlIHRvIHNhdmUgMC4wMDAx
cy9UIGR1cmluZyBub3QuDQoNClBhdGNoZXMgMS0zLCBsb29rIE9LLCBidXQgd2l0aG91dCBwYXRj
aGVzIDQtNSBfX2luaXRfbWVtYmxvY2sgc2hvdWxkIGJlDQptYWRlIGxvY2FsIHN0YXRpYyBhcyBJ
IHN1Z2dlc3RlZCBlYXJsaWVyLg0KDQpTbywgSSB0aGluayBKaWEgc2hvdWxkIHJlLXNwaW4gdGhp
cyBzZXJpZXMgd2l0aCBvbmx5IDMgcGF0Y2hlcy4gT3IsDQpBbmRyZXcgY291bGQgcmVtb3ZlIHRo
ZSBmcm9tIGxpbnV4LW5leHQgYmVmb3JlIG1lcmdlLg0KDQpUaGFuayB5b3UsDQpQYXZlbA==
