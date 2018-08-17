Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F6AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5C321479
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h4MLRYEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5C321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbeHQEKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:10:24 -0400
Received: from mail-eopbgr680116.outbound.protection.outlook.com ([40.107.68.116]:65072
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbeHQEKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8finH9m9DyD/KNhCbSyTEXBWdlxLUbLgqIikVAY54Q=;
 b=h4MLRYEXtoNT77UyqEdEOG4Dtv2uzZTYxSnGdfdp7mMDk/lIDJm8O7FMfnPeMaAHpPH2q0aWbNNkXN/TavTEr6Eb63Mrt2t5l/QsAvmYCUDHdpKSAaduG5aR+9HRYfTU+kajYNRcH5mgpKxspjNpCuGXH1IW+SbfAzmcrxPTRro=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0188.namprd21.prod.outlook.com (10.173.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.1; Fri, 17 Aug 2018 01:08:50 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.009; Fri, 17 Aug 2018
 01:08:50 +0000
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
Subject: Re: [RESEND PATCH v10 3/6] mm: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
Thread-Topic: [RESEND PATCH v10 3/6] mm: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
Thread-Index: AQHUNcbaH4k4ish9Xkq0tGi1N6U6ow==
Date:   Fri, 17 Aug 2018 01:08:50 +0000
Message-ID: <61ca29b9-a985-cce0-03e9-d216791c802c@microsoft.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-4-git-send-email-hejianet@gmail.com>
In-Reply-To: <1530867675-9018-4-git-send-email-hejianet@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0188;6:6x+fttJi33W/nZ7X68FK7Zu+oihk09TvRip5QBXuH/teYl0hwk35pOSQX7YtbdaqrKUZ7RTRvKcvGnIoTt8jKyPn/jiUeL85QZsay8tfoDB2NrvHgoQvTyg6vTVnswiOqDGmZID4ZWzBsx+fwjFrcIgJf+KGqZBanJRr4sEr6Q/6xV4iiQSzN98eA4YCGJZMwNCiKNPCIfzm0Hm92laaceFXOAQ8OZ4KqEVR34+9lRnyWv81tVhje1lro+qfcrUXrBCARLel8bHgasyAA4Ykw1GxvuiscpZyWanrkskg3xFmGXDRsEP3uuOQpy60JCO4H0jNsZW8W3Ff3Qap27tePMY9Xdw/W/zh0KY1lpCdzRl2rWQ0q3eZc7eJwxKu9ToAXmaJgjo6UuJ5WWQY1GRM+onctEE4Sj8IJu1wiSPpUkLVHQNrMB7KPcDzeil/R7ipNBErvBQWCJpvZvU02scigA==;5:EJ3hi3T46H687RqgAtuS4IYt8Efoqy518tJjj/79I3q0ruoGSM9PfR03n3pL6+XFksp27El9Cp7lqXvFgL/7A3kaa2YhUY2q3yioI9U8rydXXNW4JMEP68au/rn7U0MY/lZsHWgY/tj+SgqJn95Hglh4AdEWHipPxoF20fXGNS8=;7:uJ+MOJYPfsuEOAOfZqhDAWQ6HzvzzkRek/c+0fUdtjG6naQ+zeZycYK8tIMwL0g3OV9vnH4Ivz7Bz0njdafN3+eDE4u+oht3pm5xELOEuYyk6L8F1+PcUpn94X5QCwEn+FGMS29JXhNeA9rkeUboTUsKFz01bBol4MOfVwVx1vODKpLwjGzf0v/OqD8iT54mVJXuTW5EvAZTbWh8pxPNx2J8or9lXN6znnyv57P2wwE2fDOivNVtWSRvy33Wlbmp
x-ms-office365-filtering-correlation-id: e62dadc8-0ee1-45f9-e5c5-08d603ddfe05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0188;
x-ms-traffictypediagnostic: DM5PR21MB0188:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB01889ABA1FC29AA133541DC29D3D0@DM5PR21MB0188.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699016);SRVR:DM5PR21MB0188;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0188;
x-forefront-prvs: 076777155F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(6246003)(476003)(10290500003)(25786009)(31686004)(478600001)(72206003)(5250100002)(14454004)(53936002)(256004)(39060400002)(106356001)(4326008)(105586002)(36756003)(229853002)(2616005)(486006)(6486002)(6436002)(97736004)(6512007)(81156014)(2900100001)(305945005)(446003)(11346002)(316002)(86612001)(81166006)(8676002)(110136005)(86362001)(76176011)(22452003)(102836004)(68736007)(31696002)(6506007)(5660300001)(54906003)(7406005)(10090500001)(217873002)(26005)(186003)(2906002)(7416002)(3846002)(99286004)(66066001)(6116002)(8936002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0188;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QqFKFC23HzaTtItzt0WivnDnxhbYDVfWrVTXbNTrHrYzApVX3rJQBqA6qJ9OF6kZkmM/dY5/FxFK0zF2uX5CBodQvUZ4JtAOk4D/p8ob/pH7YANtCMuFwoCgvBO+jIArX4PN6J68PIMYUkXtZAW2K149Dxn+zOgDGI187ZrpyFyVjMnXnRnDAgK7+q7UqTBhtCScCuq0v6YDKwtncX8KI/oYa9VFjAPwIYxLK2qSW4lHfrLBEhZwziUkU2QB6MEtZQSzEBkncSSNEIbEAc66V1SoOpa/N4zeawnjRlXkSZPv2qnlhEzv63sFrhS7I2tPBmVEbfq44XLG+rs6vXh+lDPyJJxzDsZhjZQNw+s9fps=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EA3EB841819D74C911EF6E2CD4115AB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62dadc8-0ee1-45f9-e5c5-08d603ddfe05
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2018 01:08:50.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8amlhLmhlQGh4dC1zZW1pdGVjaC5jb20+DQo+IC0t
LQ0KPiAgbW0vbWVtYmxvY2suYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL21lbWJsb2NrLmMgYi9tbS9tZW1ibG9jay5jDQo+IGlu
ZGV4IGNjYWQyMjUuLjg0ZjdmYTcgMTAwNjQ0DQo+IC0tLSBhL21tL21lbWJsb2NrLmMNCj4gKysr
IGIvbW0vbWVtYmxvY2suYw0KPiBAQCAtMTE0MCwzMSArMTE0MCw1MiBAQCBpbnQgX19pbml0X21l
bWJsb2NrIG1lbWJsb2NrX3NldF9ub2RlKHBoeXNfYWRkcl90IGJhc2UsIHBoeXNfYWRkcl90IHNp
emUsDQo+ICAjZW5kaWYgLyogQ09ORklHX0hBVkVfTUVNQkxPQ0tfTk9ERV9NQVAgKi8NCj4gIA0K
PiAgI2lmZGVmIENPTkZJR19IQVZFX01FTUJMT0NLX1BGTl9WQUxJRA0KPiArc3RhdGljIGludCBl
YXJseV9yZWdpb25faWR4IF9faW5pdF9tZW1ibG9jayA9IC0xOw0KDQpPbmUgY29tbWVudDoNCg0K
VGhpcyBzaG91bGQgYmUgX19pbml0ZGF0YSwgYnV0IGV2ZW4gYmV0dGVyIGJyaW5nIGl0IGluc2lk
ZSB0aGUgZnVuY3Rpb24NCmFzIGxvY2FsIHN0YXRpYyB2YXJpYWJsZS4NCg0KPiAgdWxvbmcgX19p
bml0X21lbWJsb2NrIG1lbWJsb2NrX25leHRfdmFsaWRfcGZuKHVsb25nIHBmbikNCj4gIHsNCg0K
T3RoZXJ3aXNlIGxvb2tzIGdvb2Q6DQoNClJldmlld2VkLWJ5OiBQYXZlbCBUYXRhc2hpbiA8cGF2
ZWwudGF0YXNoaW5AbWljcm9zb2Z0LmNvbT4NCg0K
