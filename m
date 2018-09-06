Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EBFC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F2F2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Ij5HaiGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F2F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbeIGATR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:19:17 -0400
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:7136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbeIGATR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCIqaiQnr55OZv6xAtOLMZXGBz/pmBb6fXdBYJMIxpk=;
 b=Ij5HaiGpbICJPeU/sjOBbCN6E+sSbXGRKN3YTUvm7DIQcm2x9U8wFz6tMTu5HAaOJwJzzSdT+WQDXp3yc9Ftf0N7MPX8lGGCYWDqc6ntiYVsrukknUsiN8ZxnyePydprR6QQk3wF84/uXLMBcRn7jE0F3wQrXDAGnCjrEKOVkgs=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4691.namprd05.prod.outlook.com (20.177.145.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.11; Thu, 6 Sep 2018 19:42:14 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112%4]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 19:42:14 +0000
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
Thread-Index: AQHUQuMbEqvSNOHryEuRcEhAlbQ9L6TjrQmAgAAAm4A=
Date:   Thu, 6 Sep 2018 19:42:14 +0000
Message-ID: <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
 <20180906194003.GD4816@worktop.programming.kicks-ass.net>
In-Reply-To: <20180906194003.GD4816@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB4691;20:LMCSzw5Ju8TBpBOdNJJCmikhAYR+ICLK3Dywc4BylfaTKEuM9xzjLQmGILweS0R59MeY80lMxEmZ7N3hhk+1g0rg+Tp6K3ta6CyXpo4R/chzws42hu5EcJ/QWRH2S7EroYT0hhXfdnAp/NzKBkkQy1MYqvM77dcAWUe8fUdLWIY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1e7c24e9-afc1-49cf-62c8-08d61430d8da
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB4691;
x-ms-traffictypediagnostic: BL0PR05MB4691:
bcl:    0
x-microsoft-antispam-prvs: <BL0PR05MB469108941851E60D6046E0CED0010@BL0PR05MB4691.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR05MB4691;BCL:0;PCL:0;RULEID:;SRVR:BL0PR05MB4691;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(366004)(396003)(199004)(189003)(25786009)(316002)(6916009)(14444005)(81156014)(86362001)(2906002)(256004)(81166006)(36756003)(186003)(97736004)(6246003)(14454004)(26005)(6506007)(102836004)(5660300001)(66066001)(83716003)(4326008)(478600001)(8936002)(7416002)(106356001)(11346002)(3846002)(53936002)(6486002)(476003)(6512007)(54906003)(105586002)(33656002)(2616005)(6436002)(68736007)(229853002)(486006)(446003)(2900100001)(76176011)(82746002)(7736002)(99286004)(5250100002)(8676002)(305945005)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4691;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uAoJDP+hoUZME8PlxDC42MF9XcXKjRmHKSOX56+sqw7c3sW9sNrOXSr90hum2e3qGsEVbEcft4jriTBPDnIiBQGK4pdd+u84Ue28Zf0z+DCyBOrZ1RbHuAqINy553YZp5EYDYn7j6BUbQMi+rq2dQBh8kw65EAC9f/9e1g+GV2n0VUUzTw8BlLj+ZpKP3b4m0lLTnw6UWBSjAkJkoZRHRno1XgVsu7P80teffq+iIV2YGxki+54Nh3mhkFez2NqCDClh4M/tH8OzC38LFr8c0cAw1xfe0lAPPiFw7xurRm7IetJ4+JzD+ZPeNBCkJZ4lSIogjWVrYPedTWuGQ1phQECQF0TofaNBOt4UhkP9DHA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9280685D9FEEB04BB4A67C99F6D7439F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7c24e9-afc1-49cf-62c8-08d61430d8da
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 19:42:14.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4691
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTI6NDAgUE0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
DQoNCj4gT24gU3VuLCBTZXAgMDIsIDIwMTggYXQgMTA6MzI6MTlBTSAtMDcwMCwgTmFkYXYgQW1p
dCB3cm90ZToNCj4+IHRleHRfbXV0ZXggaXMgZXhwZWN0ZWQgdG8gYmUgaGVsZCBiZWZvcmUgdGV4
dF9wb2tlKCkgaXMgY2FsbGVkLCBidXQgd2UNCj4+IGNhbm5vdCBhZGQgYSBsb2NrZGVwIGFzc2Vy
dGlvbiBzaW5jZSBrZ2RiIGRvZXMgbm90IHRha2UgaXQsIGFuZCBpbnN0ZWFkDQo+PiAqc3VwcG9z
ZWRseSogZW5zdXJlcyB0aGUgbG9jayBpcyBub3QgdGFrZW4gYW5kIHdpbGwgbm90IGJlIGFjcXVp
cmVkIGJ5DQo+PiBhbnkgb3RoZXIgY29yZSB3aGlsZSB0ZXh0X3Bva2UoKSBpcyBydW5uaW5nLg0K
Pj4gDQo+PiBUaGUgcmVhc29uIGZvciB0aGUgInN1cHBvc2VkbHkiIGNvbW1lbnQgaXMgdGhhdCBp
dCBpcyBub3QgZW50aXJlbHkgY2xlYXINCj4+IHRoYXQgdGhpcyB3b3VsZCBiZSB0aGUgY2FzZSBp
ZiBnZGJfZG9fcm91bmR1cCBpcyB6ZXJvLg0KPiANCj4gQXJnaCwgdGhhdCdzIHByZXR0eSBzaGl0
IGNvZGUuLi4NCj4gDQo+IE5vdCBvbmx5IGlzIHRoYXQgdGV4dF9tdXRleCBhYnVzZSB1Z2x5LCBz
byB0b28gaXMgdGhlIGZpeG1hcCB1c2FnZSBmcm9tDQo+IElSUSBjb250ZXh0LiBJIHN1cHBvc2Ug
dGhpcyByZWFsbHkgZG9lcyByZXF1aXJlIHlvdXIgYWx0ZXJuYXRpdmUgbW0NCj4gcGF0Y2hlcyBm
b3IgdGV4dF9wb2tlKCkuDQoNClJpZ2h0LCBJIGZvcmdvdCBhYm91dCB0aGF04oCmDQoNCg==
