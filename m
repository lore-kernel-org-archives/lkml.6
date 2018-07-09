Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B36AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F38208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ud2lj0lX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b1/7hpzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F38208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbeGIU4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:56:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62037 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbeGIU4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531169813; x=1562705813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fuX5BF9CYAS2X7eoC4Awq5bWv51+Nay4j241MjieWiM=;
  b=Ud2lj0lXOlNhgiphG5PY0BAaJfgLvS3965UUAZEN+3TI2qRDbLOZVOPG
   ZMa7OPsZBxirQfhQq9I1WaBRjLbpw/Iyj5gexU1CYSxD2BY8QsFZqtGKc
   V0gabe8sz7gfkH09O/fRjNe9BnHJ7/nV5H9VhrBcd8y1MW2RW9/hb2+BI
   F8uMFuYiUnRJ0M2hBV2j8R8AN9RyNuiMV3OlKpmy8a9Vy3GCrsPzYaVBF
   0MvARs+p+ksypjI6q9x5LJzSlVQBdOW2Xiq4/cY9leavCGpLloUMKGrBW
   IK4/72LO8zJJrs9uX9YD+HOnpZGX7our3Rr3qxiuTBtnKE/7Mu2ys4fQy
   g==;
X-IronPort-AV: E=Sophos;i="5.51,330,1526313600"; 
   d="scan'208";a="187073547"
Received: from mail-dm3nam05lp0111.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([216.32.181.111])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2018 04:56:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuX5BF9CYAS2X7eoC4Awq5bWv51+Nay4j241MjieWiM=;
 b=b1/7hpzLertEGUuFWGt6zBVCK4EsMmeP/ubYWFgyFuIIDErIkeDkBHOcNxfkFAJBbjysePwGI9vSTlj+IHLTb+yPunJM3v+mSsFvzuxAS2q2g2lmbsfO4v5Fmx4VNFrfrx8BC+uoKdlak656YzV3XXkVsnOnJ3bRXVq0w0/BH2o=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0560.namprd04.prod.outlook.com (10.173.49.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 20:56:48 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Mon, 9 Jul 2018
 20:56:48 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jan.dakinevich@virtuozzo.com" <jan.dakinevich@virtuozzo.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "khorenko@virtuozzo.com" <khorenko@virtuozzo.com>,
        "den@virtuozzo.com" <den@virtuozzo.com>
Subject: Re: [PATCH] ib_srpt: use kvmalloc to allocate ring pointers
Thread-Topic: [PATCH] ib_srpt: use kvmalloc to allocate ring pointers
Thread-Index: AQHUF4vtgYRvGL8p4EG6k4CNcrQ9GaSHX5oA
Date:   Mon, 9 Jul 2018 20:56:47 +0000
Message-ID: <130534ba53f2ddba125896834ee34099fa164174.camel@wdc.com>
References: <1531144268-25361-1-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1531144268-25361-1-git-send-email-jan.dakinevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0560;7:nft428WCCMlLevuLbXo5zq63oH8VKFeMjLw6KGOPN3YNOJL+4kn/OLQVvKQAyf6ZXT2wNv695FWeNKm1CUSE6PAc1W19LOuQxHhN4+IzbiXyWgN25htqLh3JVk2bu226deBUek1TgFJkt5Na4uGk1WnpQede9Gtl8j5iPkZPd/3Qpx3MSmO6pYuw5+prIWIka1groOadu8lun6KDohcZZVPM+/AhjFfV+OdYmBXHjCHOgUxyTVt0UZstXfHXOol6;20:LjaGvmDsaGkkB2ByeIETPXOfJ952cOVjq+QKr1saAawUireikoZHg85hBPrgUG3HkDvi5RNvCYvffw9bn4b7vS9ZGdSL1sNGKTIaTPgJb4+8cXOo0sM7/LuTmRZiXxxVUf1djbwFE5QAS9zj+ZRRwizJNi/uFvZ8uVCuCk6np5M=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 499bc8f9-b821-440c-c2ee-08d5e5de7cbe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0560;
x-ms-traffictypediagnostic: MWHPR04MB0560:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB056026F9971F8F72AC23780D98440@MWHPR04MB0560.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0560;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0560;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39860400002)(366004)(136003)(189003)(199004)(5660300001)(558084003)(305945005)(25786009)(3846002)(6116002)(81156014)(6512007)(105586002)(72206003)(97736004)(53936002)(36756003)(478600001)(4326008)(8676002)(106356001)(2906002)(7736002)(6436002)(229853002)(6486002)(6246003)(81166006)(6506007)(118296001)(8936002)(316002)(5250100002)(102836004)(2201001)(486006)(186003)(446003)(99286004)(2616005)(476003)(26005)(11346002)(110136005)(256004)(66066001)(76176011)(86362001)(2900100001)(54906003)(2501003)(68736007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0560;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uYZzaTSryPvJWEDFkd2EA3WuLvFJ8Dopw0PIdiwaYcgZnYXbLrhn8jN9HqVvc76EUnbLYTAnV33t8kZtWlKRpzfq/sDHlv6qZasf1Gz9Y5lwA0uEhdBZ0+DADBlTVGB9FsGDGgG3nJMGm5zslPH190wJjOcFXkKdYjgpis/r1jMTU9bFnDfG7ggyDvgRzfGhQvBQQjngq1OFfNK8jvtsT+bLXlcXofqH7wcNjYPvPLOjn0h40HwUsI5IeJNe1Fe3cWHZAxaQM9cG9gfecaVwkfMUTjjf9CCD0aDj5wEHpuAXJSp9qdZ7+Rrf7+pPKcxCx7jYhj5XnoD5y6sQelm4D81x/anBZa693Aze19huA/w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5C2F60B545A7B498F6BD3F00546D396@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499bc8f9-b821-440c-c2ee-08d5e5de7cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 20:56:48.0049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0560
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTA5IGF0IDE2OjUxICswMzAwLCBKYW4gRGFraW5ldmljaCB3cm90ZToN
Cj4gQW4gYXJyYXkgb2YgcG9pbnRlcnMgdG8gU1JQVCBjb250ZXh0cyBpbiBpYl9kZXZpY2UgaXMg
b3ZlciAzMEtpQiBldmVuDQo+IGluIGRlZmF1bHQgY2FzZSwgaW4gd2hpY2ggYW4gYW1vdW50IG9m
IGNvbnRleHRzIGlzIDQwOTUuIFRoZSBwYXRjaA0KPiBpcyBpbnRlbmRlZCB0byB3ZWVkIG91dCBs
YXJnZSBjb250aWdvdXMgYWxsb2NhdGlvbiBmb3Igbm9uLURNQSBtZW1vcnkuDQoNClJldmlld2Vk
LWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+DQoNCg0KDQoNCg==
