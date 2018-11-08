Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA75C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2A02089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="T3uGMsRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2A02089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeKHUIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:08:46 -0500
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:14400
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbeKHUIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boRK+LCF++k+SuEj8B5c3TXlYSk68olsRcBWFlIqtT0=;
 b=T3uGMsRzImUqK/7itIfDswCPn1Fi48kGzaqek5gcqVkFClVqCWX8qyc3HuduUxsYRvsup9gQP6HQGTd/BMb8dRiP7PPsh0BmyurKSKDZeV44WUU8bm3juYS4J5rebmAPeyotvZO+CEOCxTjlulXTBwKMRX9tbPM+kDt/9CCI3VM=
Received: from AM6PR08MB3397.eurprd08.prod.outlook.com (20.177.112.222) by
 AM6PR08MB3239.eurprd08.prod.outlook.com (52.135.164.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 8 Nov 2018 10:33:52 +0000
Received: from AM6PR08MB3397.eurprd08.prod.outlook.com
 ([fe80::19c8:4ac3:f079:622c]) by AM6PR08MB3397.eurprd08.prod.outlook.com
 ([fe80::19c8:4ac3:f079:622c%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 10:33:52 +0000
From:   Steve Capper <Steve.Capper@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <Punit.Agrawal@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH V3 1/5] mm/hugetlb: Distinguish between migratability and
 movability
Thread-Topic: [PATCH V3 1/5] mm/hugetlb: Distinguish between migratability and
 movability
Thread-Index: AQHUatCl7+fKHBAcu0K+ApUorGU6i6VFx2eA
Date:   Thu, 8 Nov 2018 10:33:52 +0000
Message-ID: <20181108103340.ajeg566spidprzzk@capper-debian.cambridge.arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-2-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1540299721-26484-2-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
x-originating-ip: [217.140.96.140]
x-clientproxiedby: DM5PR18CA0068.namprd18.prod.outlook.com
 (2603:10b6:3:22::30) To AM6PR08MB3397.eurprd08.prod.outlook.com
 (2603:10a6:20b:43::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3239;6:n/eVerHSFUelZoff7440R0cXmIkBXYdIfFKzvtH9Y5ZZh0r7Y8pMX5iV1Uq75YECK5oGnDl6SzrMHwdvA/O6JV+76KkGWwteQk4s9rvI0K2FD+XECbkJStkZ08uEq8uRuv3anzMn3lf63VOfy3dt3cCc82kB0NkIzARziJvkdjDi4VyZ6KVQupEVH0OgXslIdofsGTcasRfY08Y/cwBsgNpZgSV+nchB9xfKr7b1WUsaGO1kcKE+S9UABo6v2HCbO1L6oxdR0LwsgDmTfCYHkJg/KR4jyRGFjojHHx4NGaVeKW+O6MJOK6SaHVMbBLe1NPMp24R5kTk7l0W+PXDqaTkBv5kld+jArrupfKdQitNE9l4BiXA9iLxcWl4/o3tY2PQVxAaM4bxvhZUZNRnBr2kqLEFupQBbnlIXURgrfpWSNeqqhz7bUprb7+oGT2sAWg6snn62Xe8+sefOgG898g==;5:NbTsdqdlTZdRBhdfRKe/lDtK3vNU9q6uo47BxFbHKSDDAEFGuISSZdSgEsuBRoUEK0a1kSCsAGy1VSi5ZHKaznDSbh8m5VitjE1iuvSRWoA2XKLvPickiyTc6forYeRYC82z6hansJGkODDmmklJfrp357fS+VC+YOKkoVTSreE=;7:lQyytQ50C3/9qqYWXaVxKBBWCTTH3tFJQNlYgaaUmpCHmeB7JIVE+LRlpv7Nym11poggNLmOKrwGv94GK2soe3gSTzlNHw/dR9Za3id0FunskEoeARdg6Ey7b/XSYqQTgG+a3AptctPgbiP16f1bzg==
x-ms-office365-filtering-correlation-id: 5a4848d8-1f94-41eb-70ab-08d64565ad40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3239;
x-ms-traffictypediagnostic: AM6PR08MB3239:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB32395CE394032923B038CA7881C50@AM6PR08MB3239.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3239;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3239;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(25786009)(11346002)(6116002)(3846002)(386003)(6506007)(6862004)(68736007)(6636002)(4326008)(105586002)(2906002)(7736002)(71190400001)(305945005)(71200400001)(106356001)(86362001)(14454004)(5660300001)(52116002)(72206003)(6512007)(44832011)(446003)(1076002)(486006)(99286004)(186003)(476003)(478600001)(6436002)(256004)(26005)(6486002)(97736004)(53936002)(76176011)(316002)(54906003)(66066001)(58126008)(102836004)(8936002)(229853002)(81156014)(6246003)(2900100001)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3239;H:AM6PR08MB3397.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Va3ebJ0Lx4xb7uYNmai8ZlR/J1IetjkrWapAvTvSTtVVg288FRBKwpUZ6LaAXOT7lKBgjExSCAB3l7CInBK5gB2XlVZK5Wumq3aTAiXtBJOAIaAtJ/R5H2fTj8w/H6W8xG/KRBGVii+GS86ZJ4jX4KLOMcgaUeK3dI+n10T0VEhoHPTkuZLe88E1pFEgbPygHd/G8yW3zE2kzwpMTrrzZBKDAPfSQp1IAUkxc9U2rNkCmzmFJyP2mi5/qakx/UW0qneUc8Xe6HvqbHPLkxDIuBcMw7+WjY+/JM6Vx/C/n5u6G1MzTSUQLxUEZ0HkpaplXllq4gJee3uVBF5MUWHF5XMthuIyZhE+CR/kMod/E6E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C4C4AF369624046874B8669A50CA08E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4848d8-1f94-41eb-70ab-08d64565ad40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 10:33:52.4171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Tue, Oct 23, 2018 at 06:31:57PM +0530, Anshuman Khandual wrote:
> During huge page allocation it's migratability is checked to determine if
> it should be placed under movable zones with GFP_HIGHUSER_MOVABLE. But th=
e
> movability aspect of the huge page could depend on other factors than jus=
t
> migratability. Movability in itself is a distinct property which should n=
ot
> be tied with migratability alone.
>=20
> This differentiates these two and implements an enhanced movability check
> which also considers huge page size to determine if it is feasible to be
> placed under a movable zone. At present it just checks for gigantic pages
> but going forward it can incorporate other enhanced checks.
>=20
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

FWIW:
Reviewed-by: Steve Capper <steve.capper@arm.com>
