Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281A9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D05205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZHRopWRG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E4dAvfpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D05205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966406AbeFSPUo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:20:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56551 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965783AbeFSPUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529421642; x=1560957642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FyewgNzidKIGcGWaQvuUqWDKXVEOFN+Ka44txKkCsLg=;
  b=ZHRopWRGMBNlQIeDkm1OqgUsJjaiiEXYjDj7aVzaDpEE9LSCuq6zygml
   ZjNQtM6hlzCJLy6fq5BPIM0cU/6zMrY9cpugPM1bz1l6jzQk8uy0aYpGe
   H4u96hJsQRYa1i6Zc3k0hFg6ceDVM8ZzVJHQWw1ROMT5Ju7weLEQNPwT1
   PFnDaLUgyPklj1RERIzZyevvH341Fbcs5+yhLB3EUnspJGmccU8Le7kCk
   D3U6tfdI+nJD15TKDpDPGxgi+JjOPG3ucjCjQ+NDttxm5RTnoOkw+hfGf
   /FwUSGKSwBSD895TWKmaEo9PfdActUmN46PvkY6AaQI20V2zUs7LTejQp
   A==;
X-IronPort-AV: E=Sophos;i="5.51,243,1526313600"; 
   d="scan'208";a="83185658"
Received: from mail-dm3nam05lp0119.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([216.32.181.119])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2018 23:20:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyewgNzidKIGcGWaQvuUqWDKXVEOFN+Ka44txKkCsLg=;
 b=E4dAvfpvCDdHbg0yeYcC8GW1f+DRO4z6Zx6xGBEbCcQyEVYywGQQqgwBJzfXqEA+HaOqA6Ux7zAywCj93xzYSjr1k+ScG8Xatoj1xPlSGdJcYfechTvgeqdttUyCTFrJmsISjmxu/kRtXg/IjuoiSaVgiTKdo9+t4imd2vZ5RI0=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0192.namprd04.prod.outlook.com (10.169.201.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Tue, 19 Jun 2018 15:20:39 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0863.016; Tue, 19 Jun 2018
 15:20:39 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
Thread-Topic: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
Thread-Index: AQHUB5sTat++auXTF02av9K10QZViaRnsvCA
Date:   Tue, 19 Jun 2018 15:20:39 +0000
Message-ID: <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0192;7:pfNlPjkSXSw6zVfzOmopSEa0n7U9dOpdrBIoL7tW7WfU+Aa4tOC/cJxZa7KeyAeS5NM0GGi+WasdEw6HiZzNmA8T61Buxr413Aoi5AS9TT/RCXs4Hiu2FLLOCjc7cJ9uycsOryoRLkGe1CUEIbKVfJYE9p3fBaircPOok4k4csmjHDhFOF9zaQzGZbyUqBQG+b9PdGrDd3YO8ovtThLU1hsC5eVFt0S5c/9YD9cNaWLGBmKsV+hilzRxWL8wCTSF;20:dey91qJrvhA9U/bPgFoEbVpGT6SgjpjCV/rPv4o5ALmaOIDbtocT8iFeDKPiGAES6QabLq5P11uz7X/Jq1FaSolIN1p51c6p3vh9IW/NSX7m+M82ch01wpC3cL2a6CgTRViekSplR/dxAoV+QyiKFZipujgFj7RJj0NnW/FQ9c4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: da90dab2-5471-4b76-4f70-08d5d5f83709
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0192;
x-ms-traffictypediagnostic: MWHPR04MB0192:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB01927C3C88A156036FABE19098700@MWHPR04MB0192.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0192;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0192;
x-forefront-prvs: 07083FF734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39860400002)(39380400002)(376002)(189003)(199004)(8676002)(105586002)(99286004)(106356001)(2906002)(54906003)(316002)(7736002)(6486002)(110136005)(6436002)(68736007)(8936002)(6116002)(3846002)(5660300001)(6512007)(66066001)(229853002)(6246003)(36756003)(11346002)(446003)(4326008)(476003)(2616005)(81166006)(81156014)(72206003)(86362001)(186003)(486006)(25786009)(97736004)(5250100002)(53936002)(3280700002)(2501003)(59450400001)(305945005)(2900100001)(6506007)(3660700001)(76176011)(118296001)(102836004)(26005)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0192;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: bVtie7karNXueHZSVBZ9AILHN2cQLJqf8cGs2cqEarboU7HwOT0r82J4ZnciWufMOm+h+cihsZetci5q+AObvVw2mhQ1nH6LjUc2JKt5eDNX1VaiUUYquAwEDDlJ463n2jy9aUyL96O1LbnuHsofWBnZUNMXeiQl9evJ9cLU/WDUJZ9tBSqmjsjXarYLwxDLWlm9a0sAYVmgaM+Iggwv8yf/vJUWbZD4mN9Lnz/+QccKT3VAco3p62BeE8t4TaZUt2mkPvrdzSE9YS5V+TQRhHkuAKyK5IPrFTtR513X7qZ31VJdcx7VKx6MzslrPb9qYM7qUsZNi99gLaL6GOYZjA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4326E9209A13414FA8686AC83BDD809B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da90dab2-5471-4b76-4f70-08d5d5f83709
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 15:20:39.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTE5IGF0IDE1OjAwICswODAwLCBKaWFuY2hhbyBXYW5nIHdyb3RlOg0K
PiBDdXJyZW50bHksIHRoZSBrb2JqZWN0X2RlbCBmb3Iga29ianMgb2YgbXEsIGhjdHggYW5kIGN0
eCBpcyBpbnZva2VkDQo+IHVuZGVyIHN5c2ZzX2xvY2ssIGxvY2sgaW52ZXJzaW9uIHdpbGwgY29t
ZSB1cCB3aGVuIG90aGVyIG9uZSBpcw0KPiBhY2Vzc2luZyB0aGUgYXNzb2NpYXRlZCBzeXNmcyBm
aWxlIGFuZCB0cnlpbmcgdG8gYWNxdWlyZSB0aGUNCj4gc3lzZnNfbG9jay4gVG8gZml4IGl0LCB1
c2UgbXV0ZXhfdHJ5bG9jayBpbiBibGtfbXFfc3lzZnNfb3BzIGFuZA0KPiBibGtfbXFfaHdfc3lz
ZnNfb3BzLCBpZiB0aGUgbG9jayBpbiBvbiBjb250ZW5kaW5nLCByZXR1cm4gLUVBR0FJTi4NCg0K
SXMgdGhpcyBhIHRoZW9yZXRpY2FsIGlzc3VlIG9yIHNvbWV0aGluZyB5b3UgYWN0dWFsbHkgcmFu
IGludG8/IFdoaWNoIGxvY2sNCm90aGVyIHRoYW4gc3lzZnNfbG9jayBkbyB5b3UgdGhpbmsgaXMg
aW52b2x2ZWQgaW4gdGhlIGxvY2sgaW52ZXJzaW9uPw0KDQpCYXJ0Lg0KDQoNCg0K
