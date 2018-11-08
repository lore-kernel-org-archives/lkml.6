Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A84C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB422089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Idr3pF6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB422089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeKHULX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:11:23 -0500
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:53496
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbeKHULX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Pi8YDw+FD0CyXd5iJQ9YsqZ+yPFtQV6G1PUXvkUyE=;
 b=Idr3pF6t6Xx0L5xu7fzlfw00raxGagBHPUYrDQAZoyuW7MiT07NoVMcj3vGnCVFsicOa/U8EM7x4nRmOPBh6ADmgDPPHla+CyzRD1OXpKICd1qCmvTy9D3XJ8EcoOFqgCeprF5Lm8MwoglFqEXCvWmjSGdwgP3YSgLQgHB4aapo=
Received: from AM6PR08MB3397.eurprd08.prod.outlook.com (20.177.112.222) by
 AM6PR08MB3189.eurprd08.prod.outlook.com (52.135.164.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.24; Thu, 8 Nov 2018 10:36:27 +0000
Received: from AM6PR08MB3397.eurprd08.prod.outlook.com
 ([fe80::19c8:4ac3:f079:622c]) by AM6PR08MB3397.eurprd08.prod.outlook.com
 ([fe80::19c8:4ac3:f079:622c%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 10:36:27 +0000
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
Subject: Re: [PATCH V3 5/5] arm64/mm: Enable HugeTLB migration for contiguous
 bit HugeTLB pages
Thread-Topic: [PATCH V3 5/5] arm64/mm: Enable HugeTLB migration for contiguous
 bit HugeTLB pages
Thread-Index: AQHUatC5nzttvSWjHEqkqFoygeri/aVFyB8A
Date:   Thu, 8 Nov 2018 10:36:27 +0000
Message-ID: <20181108103616.22z3imossjb5ffkw@capper-debian.cambridge.arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-6-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1540299721-26484-6-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
x-originating-ip: [217.140.96.140]
x-clientproxiedby: DM5PR18CA0061.namprd18.prod.outlook.com
 (2603:10b6:3:22::23) To AM6PR08MB3397.eurprd08.prod.outlook.com
 (2603:10a6:20b:43::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3189;6:QRzZH4GXifte8REO0VxcpT3f6nFqOlsHGsAj05iHvlWYVa4mBwU3AVbPXwMN6RXLxYJaYhtCfoNRDuzjdpZy+9MMY5JOPBsX7hfkm5F2aYIFJclAxxuUkfOOdOka//d1NLz445hX1T95pa72ueRWIAzhKgpsLCPSnNgAsHGQXK0w+2QcmwwUnOOH064M5ptqiF7gqccJYf07zYQcNHZL8H287MYJZ7WutuywoTErU18H4l21to/30Mf5q+7Y8HOJopcJAtWWEdoES2mKfVby4Ulyz9ZHxweqfk6nFbmqwtouOjvRIVx2Kl06bu3WdLZGj/fO/G8LnqadokUFg9D8MiD3M9sHFQO7qGBuN5M/HZXag7lQUOiZF2fzdA9D5X6mSlJf8PaHM8Fe/bQMSg19TNELrA4gWKJA3N/p4xBZlXBLWFQV5fLieYUQqeN1WsCVMHTAPo9Unnut1DstF8uJSQ==;5:b/0g4Pa/NdOIImrHdFyc/B6OSuSLngGLzlyWCCkNJjU1o+l6kZKEyeatwVJoswAzw7ZisvYmj3PVareAl34CgTIBxV9NeeL0TiZ8g9/5hwvrXTD5fBwrN4hd2D/i3z+aE/TiUc/AlKQ/4x5hZO5XV9P1ffx0fJfRCEBxoRRnkME=;7:FeUjfso8rtocNKYr3vjvHNQkBZBYG+yx4QICpgiCMUXHGcdP1r+MB2Q00lxXpJAsv2lvnTEcT7DF2YLAqy28jfq7YT3iNekFuDnMd10az2XHpq60d/+2+ws2ldA6AMHfuOrxrl88ZQJtumpoY8ogSQ==
x-ms-office365-filtering-correlation-id: 6eec370c-7742-4903-ff23-08d6456609d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3189;
x-ms-traffictypediagnostic: AM6PR08MB3189:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB31892D9D9177A7C716DD585F81C50@AM6PR08MB3189.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3189;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3189;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(44832011)(446003)(86362001)(11346002)(106356001)(2906002)(53936002)(6246003)(6636002)(6512007)(105586002)(6862004)(4326008)(25786009)(6436002)(1076002)(476003)(2900100001)(486006)(256004)(6486002)(6506007)(66066001)(52116002)(76176011)(478600001)(5660300001)(58126008)(26005)(386003)(316002)(54906003)(3846002)(99286004)(71190400001)(68736007)(72206003)(305945005)(81166006)(102836004)(7736002)(6116002)(81156014)(8936002)(8676002)(97736004)(14454004)(186003)(229853002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3189;H:AM6PR08MB3397.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qADQhfToa3Tgr4C0vkHQ5cfT+TOhh+0WlN3V/NhUMiYZITfR6JdXcBgBQTGdOFc7APdhXxJfmceoJLME2SRnM29qrJaA+yR9MizcqWjNr461PB+l+plY731uyKxTVwLn5FUTMkoCV6DgMPTD8e3CwCrKo3nUP1l2JRHlIbAetNnz4wiCRL/I3sWvYthnAdyquz7Sckj/YrP1+GAP4qsS743IXRyybo/KFtWC64Q031s0BLhjh1XoUxrzTAe0G4TByQd8CcYt/l645PrC/MHiZN/KMvvicAWmBKB5gMNDgRyBqOYMV6yzpZq08+hrH78VCKZRILo8KTlelQqkhkAQRBGvIu+pTvWChD+oehQLgtI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A03D333A85F0754B8AA6BA2F0663AD20@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eec370c-7742-4903-ff23-08d6456609d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 10:36:27.8118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 06:32:01PM +0530, Anshuman Khandual wrote:
> Let arm64 subscribe to the previously added framework in which architectu=
re
> can inform whether a given huge page size is supported for migration. Thi=
s
> just overrides the default function arch_hugetlb_migration_supported() an=
d
> enables migration for all possible HugeTLB page sizes on arm64. With this=
,
> HugeTLB migration support on arm64 now covers all possible HugeTLB option=
s.
>=20
>         CONT PTE    PMD    CONT PMD    PUD
>         --------    ---    --------    ---
> 4K:        64K      2M        32M      1G
> 16K:        2M     32M         1G
> 64K:        2M    512M        16G
>=20
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Steve Capper <steve.capper@arm.com>

> ---
>  arch/arm64/include/asm/hugetlb.h |  5 +++++
>  arch/arm64/mm/hugetlbpage.c      | 20 ++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hu=
getlb.h
> index e73f685..656f70e 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -20,6 +20,11 @@
> =20
>  #include <asm/page.h>
> =20
> +#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> +#define arch_hugetlb_migration_supported arch_hugetlb_migration_supporte=
d
> +extern bool arch_hugetlb_migration_supported(struct hstate *h);
> +#endif
> +
>  static inline pte_t huge_ptep_get(pte_t *ptep)
>  {
>  	return READ_ONCE(*ptep);
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 21512ca..f3afdcf 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -27,6 +27,26 @@
>  #include <asm/tlbflush.h>
>  #include <asm/pgalloc.h>
> =20
> +#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> +bool arch_hugetlb_migration_supported(struct hstate *h)
> +{
> +	size_t pagesize =3D huge_page_size(h);
> +
> +	switch (pagesize) {
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	case PUD_SIZE:
> +#endif
> +	case PMD_SIZE:
> +	case CONT_PMD_SIZE:
> +	case CONT_PTE_SIZE:
> +		return true;
> +	}
> +	pr_warn("%s: unrecognized huge page size 0x%lx\n",
> +			__func__, pagesize);
> +	return false;
> +}
> +#endif
> +
>  int pmd_huge(pmd_t pmd)
>  {
>  	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
> --=20
> 2.7.4
>=20
