Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA20C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DB120827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FoTCqnqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DB120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeKHULJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:11:09 -0500
Received: from mail-he1eur01on0072.outbound.protection.outlook.com ([104.47.0.72]:30448
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbeKHULI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymHKzbDA18voN5zOyVVotEX7whzi2uRLbYhB8PvWw54=;
 b=FoTCqnqEbzSZLnfeD73rS+KuZxN0ePqBK8jVNnV+FnsotE2p9WDe3cLpPF12VcACyFB7V7Ig3MJhui+tjpJVfdQ66CvcMGjQXMDPKaIWOsG4aZB0DuISAw+DiqgxZ7Y4WnF1lVZTmZ4pgXaPiTAWWRBrKk5Y5Xp1HVqjHvrWouo=
Received: from AM6PR08MB3397.eurprd08.prod.outlook.com (20.177.112.222) by
 AM6PR08MB3559.eurprd08.prod.outlook.com (20.177.114.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 10:35:57 +0000
Received: from AM6PR08MB3397.eurprd08.prod.outlook.com
 ([fe80::19c8:4ac3:f079:622c]) by AM6PR08MB3397.eurprd08.prod.outlook.com
 ([fe80::19c8:4ac3:f079:622c%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 10:35:57 +0000
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
Subject: Re: [PATCH V3 4/5] arm64/mm: Enable HugeTLB migration
Thread-Topic: [PATCH V3 4/5] arm64/mm: Enable HugeTLB migration
Thread-Index: AQHUatC35ZDMGgpmQkaPS4VxvzQLUqVFx/wA
Date:   Thu, 8 Nov 2018 10:35:57 +0000
Message-ID: <20181108103545.c634kha6kpgpy34q@capper-debian.cambridge.arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-5-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1540299721-26484-5-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
x-originating-ip: [217.140.96.140]
x-clientproxiedby: DM5PR18CA0062.namprd18.prod.outlook.com
 (2603:10b6:3:22::24) To AM6PR08MB3397.eurprd08.prod.outlook.com
 (2603:10a6:20b:43::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3559;6:5mBxHYbWCwjJLEDtIL0wNbOqh7YN9R0utXH6MTh9HOqrkIpYfOpEzaM/epHgn3uwV6mOg/VVD9mL+0e7+oQY6U7moe/9ZKHIC7FHjo4aUg2Z61BL95zSbTSWD/0cQj+sc/dAK78SqGFLMqaiSO+8m29RoVWFNzfzxiAHbOKAhN4mDPpRzqzrizp0tVYG9yNEoYhyMhknepkDFj+xWG9FggN56tsg7OHD64qbrPl53dgLaPXJzlPtjW55hiZX4nZxz3MBQJkzkAH5QIXL2dPeXI9xW9uFv+G979cMm08WWm6xCrREJzeaIKBRfxdLBPPkQLfIkyY8gicUK8QQAACL0LYJBw7tXCWaCznH3l4p+yOCGDkj+IJqBz3Yvd9wI6jOKqE6Ema7jyVgd2BWxt/ijuO14IvDfj2dz4DkVH3/eixDjGAmWXUNqpq6B8fWnSLnSfFsOUDwJytIM6W7hnf65Q==;5:W959G0bx2mDcNyLtSmPtTP1be8VKTi8SsJP/UCz9LuM1pX53bS8lx20uTJ5ClB7Ixi4IkNtimAOQ+9ytKguMdJMsmi7WDySl91zaY4CQMPCgNf17EKdv6mY5/JX6ojOi3OJhTfXUjQ1kxiwKaKuUWy7SAZ7EjJFBvQUfWxW5R9Y=;7:d1p1TrdX5wZmzUdQbaMHAvMVJtRiX29nuWtFehhoC6B/Q6vCIV1jNr6gryS1oUrsQ9Dncsi5jMF6kui8vn6HcfzYAA/bC3q+KRfl2Vsv9TqN2XdZWxhBiRwpioBwbF5TsblWg8RUHyu9xps0CJLK4g==
x-ms-office365-filtering-correlation-id: 7d708929-3311-4adb-b14b-08d64565f7e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3559;
x-ms-traffictypediagnostic: AM6PR08MB3559:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB3559479D63A875428F9150F081C50@AM6PR08MB3559.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3559;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3559;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(72206003)(6246003)(256004)(478600001)(7736002)(102836004)(6862004)(6436002)(186003)(66066001)(86362001)(68736007)(71190400001)(6512007)(14454004)(386003)(71200400001)(6506007)(316002)(4326008)(26005)(53936002)(52116002)(99286004)(76176011)(2900100001)(305945005)(54906003)(58126008)(3846002)(6116002)(2906002)(6486002)(229853002)(97736004)(5660300001)(1076002)(6636002)(106356001)(81166006)(81156014)(44832011)(25786009)(8936002)(446003)(11346002)(476003)(486006)(105586002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3559;H:AM6PR08MB3397.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ppIL7tPgE5AkJe4nf9UEocZOgFU7AHqPqLddANwzWuugqDMxDZOm3zzNxiIqW2DTJSsoPTiopDr1EqLfYl3GghUGAl0XAeRtB7Au3OAfLKgiUbRv4DWa288RjAoWG0i00AOyC/n0AvufGyL+tdYqDWOsTgIlsq1y54NwYsh4Prtd3VyQhMxdzSPyCpBrLO/I24bQhQjuV53X9BL9fjjHB6qEpx4ZkLCpTpLkqijE5lbCr7z6Xs9/zF+/p/QOj+z+QCaS2imqJXlHfCVDO4AejUoTHN+Ni/GuXHXksKka97xxK2ekjTc7CXweobscahv3Y937PIqYdcKKEiL+XKFMOVnfrLK3CI8nmvnZwG2gGq8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A8C0C0B04CEEA41863DB68C42ADF47C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d708929-3311-4adb-b14b-08d64565f7e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 10:35:57.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 06:32:00PM +0530, Anshuman Khandual wrote:
> Let arm64 subscribe to generic HugeTLB page migration framework. Right no=
w
> this only works on the following PMD and PUD level HugeTLB page sizes wit=
h
> various kernel base page size combinations.
>=20
>        CONT PTE    PMD    CONT PMD    PUD
>        --------    ---    --------    ---
> 4K:         NA     2M         NA      1G
> 16K:        NA    32M         NA
> 64K:        NA   512M         NA
>=20
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>


Reviewed-by: Steve Capper <steve.capper@arm.com>

> ---
>  arch/arm64/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a8ae30f..4b3e269 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1331,6 +1331,10 @@ config SYSVIPC_COMPAT
>  	def_bool y
>  	depends on COMPAT && SYSVIPC
> =20
> +config ARCH_ENABLE_HUGEPAGE_MIGRATION
> +	def_bool y
> +	depends on HUGETLB_PAGE && MIGRATION
> +
>  menu "Power management options"
> =20
>  source "kernel/power/Kconfig"
> --=20
> 2.7.4
>=20
