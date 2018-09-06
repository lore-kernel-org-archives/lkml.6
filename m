Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5536AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A712075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="sSBJi2aR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A712075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbeIGBe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:34:57 -0400
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:15392
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbeIGBe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KprjpXuBUX/g5uhbG43EBePwvf7eIoU36dJLG+jKB6c=;
 b=sSBJi2aR4I83zFyvZfwRBZ7jhFeawxxEWyX4+Bybd3CMVPlAIkL6qbfQ/DDV2ztMfmIrUwb1/i3oR48otVKwmedqZVcrUoWhATu1CJ6a35TDFetRcRrU3d5NUv4qVOaUcNG39rncxJNmLZI1rC59sZf2AOMn8uiouvLmuZyQIN4=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4676.namprd05.prod.outlook.com (20.177.145.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Thu, 6 Sep 2018 20:57:38 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112%4]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 20:57:38 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Thread-Topic: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Thread-Index: AQHUQuMbEqvSNOHryEuRcEhAlbQ9L6TjrQmAgAAAm4CAAANAgIAAAVYAgAAHloCAAAjkAA==
Date:   Thu, 6 Sep 2018 20:57:38 +0000
Message-ID: <E8934715-B8B1-4E37-A37F-18D040885C4F@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
 <20180906194003.GD4816@worktop.programming.kicks-ass.net>
 <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
 <20180906195351.GB9358@worktop.programming.kicks-ass.net>
 <D8CE0D88-9507-421C-9C97-ACAB05388F8D@vmware.com>
 <20180906202547.GC9358@worktop.programming.kicks-ass.net>
In-Reply-To: <20180906202547.GC9358@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB4676;20:EHjqGcs8JunfhvIE091B1xCAgdlylYMURLs363KZE/ym1cg2z+L242CVs7LeVGh1Q8hy5b01Dz9OVfcpi6l8/3yqjtYFk/mPnzqaSCrhYj0361FEuylLf86t27gZovAEIzV3UtMmVcD1FJKkxLjQ1PORtcK680g01cbOuvw4v2U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 931d7fd5-485b-46e3-b019-08d6143b6121
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB4676;
x-ms-traffictypediagnostic: BL0PR05MB4676:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
bcl:    0
x-microsoft-antispam-prvs: <BL0PR05MB4676754FB62A5C814F4C56B9D0010@BL0PR05MB4676.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231344)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:BL0PR05MB4676;BCL:0;PCL:0;RULEID:;SRVR:BL0PR05MB4676;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(5660300001)(99286004)(2900100001)(316002)(54906003)(8676002)(81156014)(81166006)(102836004)(6486002)(8936002)(229853002)(53936002)(6436002)(6512007)(33656002)(6506007)(5250100002)(76176011)(478600001)(6116002)(3846002)(83716003)(25786009)(36756003)(7416002)(6916009)(7736002)(68736007)(97736004)(2906002)(4326008)(305945005)(106356001)(105586002)(82746002)(6246003)(93886005)(66066001)(256004)(186003)(14454004)(476003)(11346002)(2616005)(26005)(486006)(446003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4676;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nFEFbj2I1wK29weIJ3czSk62EVsNXp37DzeW/Nqjr6iOxi/ARi1rm+gNHuckSI95EbphXr4tyj6JRt4cunChQq5Te/GVAgEdMaVOV1bpjPUjjNrNXl/A0FNcBX/EShxUfBdHJ7qM7Y+MOtbUcVOk+Fj7wTlIFIXJhAQmJglScw9M312QQEqIedCDt6MUckvw0LE9XrfkvySUibXEmhwYLc+GdwlM99IFhF5/efWvC7NDBK3+AHW5S6uKD73MzZyuy1lKKDzBpj8K3b14I4VkCf4XzWH5TXGkxyNEZbpdfaVYfOcU12yL6xh/4mzNV4P28ExS4gGkGzL+cFeCiiRbQfjbRNhb0XnWOgrzYMZMkes=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEF9D4F61EC9694CB9241994A6E72CE0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931d7fd5-485b-46e3-b019-08d6143b6121
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 20:57:38.2696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMToyNSBQTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiB3cm90ZToN
Cg0KPiBPbiBUaHUsIFNlcCAwNiwgMjAxOCBhdCAwNzo1ODo0MFBNICswMDAwLCBOYWRhdiBBbWl0
IHdyb3RlOg0KPj4+IFdpdGggdGhhdCBDUjMgdHJpY2tlcnksIHdlIGNhbiByaWQgb3Vyc2VsdmVz
IG9mIHRoZSB0ZXh0X211dGV4DQo+Pj4gcmVxdWlyZW1lbnQsIHNpbmNlIGNvbmN1cnJlbnQgdGV4
dF9wb2tlIGlzICdzYWZlJy4gVGhhdCB3b3VsZCBjbGVhbiB1cA0KPj4+IHRoZSBrZ2RiIGNvZGUg
cXVpdGUgYSBiaXQuDQo+PiANCj4+IEkgZG9u4oCZdCBrbm93LiBJ4oCZbSBzb21ld2hhdCB3b3Jy
aWVkIHdpdGggbXVsdGlwbGUgbWVjaGFuaXNtcyBwb3RlbnRpYWxseQ0KPj4gY2hhbmdpbmcgdGhl
IHNhbWUgY29kZSBhdCB0aGUgc2FtZSB0aW1lIC0gYW5kIG1heWJlIGVuZGluZyB1cCB3aXRoIHNv
bWUNCj4+IG1lc3MuDQo+IA0KPiBrZ2RiIG9ubHkgcG9rZXMgSU5UMywgdGhhdCBzaG91bGQgYmUg
cHJldHR5IHNhZmUuDQoNCk1heWJlIEkgbWlzdW5kZXJzdGFuZCB5b3VyIHBvaW50LiBJZiB5b3Ug
d2FudCBtZSB0byBnZXQgcmlkIG9mIHRleHRfbXV0ZXgNCmNvbXBsZXRlbHksIEkgYW0gYWZyYWlk
IGl0IHdpbGwgYmUgYWJsZSB0byBjYXVzZSBtZXNzIGJ5IGNoYW5naW5nIHRoZSBzYW1lDQpwaWVj
ZSBvZiBjb2RlIHRocm91Z2gga3Byb2JlcyBhbmQgdGhlIHN0YXRpYy1rZXlzIG1lY2hhbmlzbS4N
Cg0KSSBkb3VidCBpdCB3b3VsZCB3b3JrIHRvZGF5IHdpdGhvdXQgZmFpbGluZywgYnV0IGdldHRp
bmcgcmlkIG9mIHRleHRfbXV0ZXgNCmlzIGxpa2VseSB0byBtYWtlIGl0IGV2ZW4gd29yc2UuDQoN
Cg==
