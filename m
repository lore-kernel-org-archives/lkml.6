Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F12C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193E42147D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KUI/ygil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193E42147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbeHQEXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:23:54 -0400
Received: from mail-bl2nam02on0110.outbound.protection.outlook.com ([104.47.38.110]:10057
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725756AbeHQEXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNWqr/oGnUPUsUJ5xsMo/qMCaZ6eiHapOlyDeITmXWU=;
 b=KUI/ygiluT5PpWJKFxWOZ4XgY6QSQyQIpWWyHmIwGUOf+zLXKikafWl5YLtsMO4Z+weFYWAEUSWewYZ2fBjvfp2NJKgAvov+ZcYNSO3kAysJD164vFHgwMJAgNAdEp50qaaF3ezsqISFBJFOhJ3qYrrNRlWQsPh70q9vY3JDD+I=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0636.namprd21.prod.outlook.com (10.175.111.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.7; Fri, 17 Aug 2018 01:22:28 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.009; Fri, 17 Aug 2018
 01:22:28 +0000
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
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
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
Subject: Re: [RESEND PATCH v10 3/6] mm: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
Thread-Topic: [RESEND PATCH v10 3/6] mm: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
Thread-Index: AQHUNcbaH4k4ish9Xkq0tGi1N6U6o6TDJfUA
Date:   Fri, 17 Aug 2018 01:22:28 +0000
Message-ID: <91823321-6d66-4b05-e5be-21d024d83854@microsoft.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-4-git-send-email-hejianet@gmail.com>
 <61ca29b9-a985-cce0-03e9-d216791c802c@microsoft.com>
In-Reply-To: <61ca29b9-a985-cce0-03e9-d216791c802c@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0636;6:SwB7bnKd/ZuGpllRXGYRahgVe4MkwrQC75sRcxpHT5HwZjGQ8xQEDzf7Bim+GAMzArSjeK3nzaiea7GX8ILIHcf3cDsI6faMWIvHD1SnI33hPXmhHSRLS/0YnakBgND7Ibx94MV6I1hQJGJ0kjJ8sH1P6kGTiKSBVgiPzrtPNmKIoWvxnR/qvpRrGQrtMBsTRA4fBwFtCKYz3LwkZZnIh1KzJFKNWvrYESVjdFNrA8Nzxx15FWlp5HpWChAvSTGFVF/iEhJ2hDIjLMusV9n+YPI8h3AJOsWwacjGh/U/jARRcfxD8wibsU6JFzsuEEmzCfAfZxl0atecFewjACGO8PsAOv6vtMce97Gul+0/kMRNVg6i0IrtyIJfNYJpxWIGboMI5s2LgO8vsLYH+LhwsUlNi+qw7H0XzucT3ozrmObiVyv+5n7Sbe/Q2kGycA+qhh/My1VI73cLOmRRHvcvWA==;5:zW2tndcmGZCp8EY8NwBb+bO4NCGJr7GXFPiFHrhgMTRlSa81tbxdFQkmJqKjNBff7HcBIdmuyiGY1kUiYV1at4pQxuCw5MAvMqH2PR2v72Q8C2mUIHytTED2QxvdZSVtnYnujAPFzTgv+yPFSe9LgaRomOUpoMV2bobzAWdkiEw=;7:V7zAyuBLbbd1NegozecrLVl9sDvPohSBBex1NYCcAbA/J24aoQ6qSoxLmPg2PAmWlUXrEDc/53m5wSYQuLwHPAbbgHP8UuCiTmDzXmkdirXv1UGKyUTRvzndV/rI+mnxhocZ2YvIlVYo6ca3jnxc+R1XmE3K+5+G4DIlOkGDMvgw0v2Vl1Pp/D+KRFgArUaNU4BvikWoWQbvXup/LanJMPxMXmuD+75vNmPSM6xSPuLRR4IfqHOmB0UXfPrSla+J
x-ms-office365-filtering-correlation-id: 105ca5cf-16ad-4d7e-2d16-08d603dfe5e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0636;
x-ms-traffictypediagnostic: DM5PR21MB0636:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB063692A35B57F8D449A83ADA9D3D0@DM5PR21MB0636.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM5PR21MB0636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0636;
x-forefront-prvs: 076777155F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(396003)(376002)(199004)(189003)(110136005)(229853002)(7416002)(4326008)(25786009)(53936002)(186003)(39060400002)(26005)(11346002)(99286004)(7406005)(6512007)(66066001)(478600001)(217873002)(5250100002)(6486002)(53546011)(6436002)(10290500003)(446003)(2616005)(6506007)(5660300001)(256004)(476003)(14454004)(102836004)(6246003)(72206003)(486006)(76176011)(6116002)(106356001)(68736007)(10090500001)(97736004)(8936002)(81166006)(81156014)(8676002)(316002)(22452003)(31696002)(31686004)(86362001)(2900100001)(54906003)(86612001)(105586002)(36756003)(3846002)(2906002)(7736002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0636;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vb3P+AqnuzSjD3awWFhOo2L3jr3p9uTOtIVerAk7hJQmRFULv6VDo/LkeH+PAWKzmVDESMm5nTbaZi/pOtQkP38ZpzThq98A+Kf7bjSYqGgxxR3GbCINz6ACUz4XULddfawFYDK1KH5EiYcc02ml2Ewi+h8UL390M3hbRGw6JlyCccrjLddvqDY0QDKxf80CTFECsOO+WXnzO5brXeTvvVT/LNfADJ/0dB8nffLCnMqPoeOUMOePy6PiOpsAXe/98bzRbjA6jGD0DAIniQnBcuqmICNlNo/knZtwjtw/LPhvtOZnPgifU/5sYl4C386EVQfdteZwkI2H4Vx+kA3J4+NpDnQBYVPwGCo1MYhmxto=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <956FC95001EB624C9B76803DE75881B7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105ca5cf-16ad-4d7e-2d16-08d603dfe5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2018 01:22:28.6297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDgvMTYvMTggOTowOCBQTSwgUGF2ZWwgVGF0YXNoaW4gd3JvdGU6DQo+IA0KPj4gU2ln
bmVkLW9mZi1ieTogSmlhIEhlIDxqaWEuaGVAaHh0LXNlbWl0ZWNoLmNvbT4NCj4+IC0tLQ0KPj4g
IG1tL21lbWJsb2NrLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL21tL21lbWJsb2NrLmMgYi9tbS9tZW1ibG9jay5jDQo+PiBpbmRl
eCBjY2FkMjI1Li44NGY3ZmE3IDEwMDY0NA0KPj4gLS0tIGEvbW0vbWVtYmxvY2suYw0KPj4gKysr
IGIvbW0vbWVtYmxvY2suYw0KPj4gQEAgLTExNDAsMzEgKzExNDAsNTIgQEAgaW50IF9faW5pdF9t
ZW1ibG9jayBtZW1ibG9ja19zZXRfbm9kZShwaHlzX2FkZHJfdCBiYXNlLCBwaHlzX2FkZHJfdCBz
aXplLA0KPj4gICNlbmRpZiAvKiBDT05GSUdfSEFWRV9NRU1CTE9DS19OT0RFX01BUCAqLw0KPj4g
IA0KPj4gICNpZmRlZiBDT05GSUdfSEFWRV9NRU1CTE9DS19QRk5fVkFMSUQNCj4+ICtzdGF0aWMg
aW50IGVhcmx5X3JlZ2lvbl9pZHggX19pbml0X21lbWJsb2NrID0gLTE7DQo+IA0KPiBPbmUgY29t
bWVudDoNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIF9faW5pdGRhdGEsIGJ1dCBldmVuIGJldHRlciBi
cmluZyBpdCBpbnNpZGUgdGhlIGZ1bmN0aW9uDQo+IGFzIGxvY2FsIHN0YXRpYyB2YXJpYWJsZS4N
Cg0KRGlzcmVnYXJkIHRoaXMgY29tbWVudCwgdGhpcyBnbG9iYWwgaXMgdXNlZCBpbiB0aGUgbmV4
dCBjb21taXRzLiBTbywNCmV2ZXJ5dGhpbmcgaXMgT0suIE5vIG5lZWQgZm9yIF9faW5pdGRhdGEg
ZWl0aGVyLg0KDQo+IA0KPj4gIHVsb25nIF9faW5pdF9tZW1ibG9jayBtZW1ibG9ja19uZXh0X3Zh
bGlkX3Bmbih1bG9uZyBwZm4pDQo+PiAgew0KPiANCj4gT3RoZXJ3aXNlIGxvb2tzIGdvb2Q6DQo+
IA0KPiBSZXZpZXdlZC1ieTogUGF2ZWwgVGF0YXNoaW4gPHBhdmVsLnRhdGFzaGluQG1pY3Jvc29m
dC5jb20+DQo+IA0KPiA=
