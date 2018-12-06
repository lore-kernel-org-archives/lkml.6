Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5415920838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Erg2GV48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5415920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLFQiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:38:25 -0500
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:43936
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbeLFQiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qujxz7HqmhT6jWV9rRLjw3fmJdV52CwVMPQZ16RCzGs=;
 b=Erg2GV48VO6aH+W+NgkaVCUEvxKQNiWOT2O1401jb2QgW+LRe2XopPTM1Y7/si0xz+KckgHiugf9MhRzgNeAcW73LhSuYt34QtuggsgST0o9W5Vr82imWgx/fktSGvz1pxZqZ6cYHrRa619RNxlq3FP6PBunIHOvgvEV7ZoH+as=
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com (10.168.11.142) by
 DB6PR0801MB1942.eurprd08.prod.outlook.com (10.168.85.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 16:38:20 +0000
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07]) by DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07%7]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 16:38:20 +0000
From:   Steve Capper <Steve.Capper@arm.com>
To:     Allen Pais <allen.pais@oracle.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Will Deacon <Will.Deacon@arm.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>
Subject: Re: [PATCH] arm64: hugetlb: Register hugepages during arch init
Thread-Topic: [PATCH] arm64: hugetlb: Register hugepages during arch init
Thread-Index: AQHUamzWh21jCJGCvkCd5Sdgg3o/0aVyL0sA
Date:   Thu, 6 Dec 2018 16:38:20 +0000
Message-ID: <20181206163810.GA1084@capper-debian.cambridge.arm.com>
References: <1540256817-3327-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1540256817-3327-1-git-send-email-allen.pais@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0068.namprd18.prod.outlook.com
 (2603:10b6:3:22::30) To DB6PR0801MB1366.eurprd08.prod.outlook.com
 (2603:10a6:4:b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1942;6:9QUZww0M1iqyeCKxF7SXKeP+SFU/fzY0lvTQ8SctkgZt/4brCVmmP5UQfNNRBwPG/nbUKhEErI2nO17RUkliEUbrPznRsI87a5MUuvWGz6JQ5PtRdLcJF7cFOu8oG0CKlEf3f9+FKbJGsi6cdEjldDNfol/+QwNNE+HMMod8o8S70Ksxd41CDgJcZ8uRdDmfrID494X7FPRFFPYaF+/vbwu3V7MCX7LfQa8XgNR5B0w4KlkrUoCb3+3ORBpxg883XeSNFjAQplq/uwpEwjehUz22oM1n3v1btdM3n68PgDHPKkzOwg9nPp7+E+YuAxDFNjYVJvuZi/UM9dN5LSplfdnoTFd3OKKbttG74VZG1kpNBIhAF++3co3HJdQcO8Jzr8wWqJhXFko8S7qJ3TSee2qGvMYWrhI8ih5QsXKiWj3MuheQmxPFQMoNlPHiGKkY2ZN7H/Ea6JavzV8FkxFL9g==;5:ULwNqp+vH0yuWrW4HJLRjmNxAVwqZmhvFUGpkEcL7bo9djvhgm5B3FHNuSxQWu/1i+UBohUq5LSOygbGg+PKVsu2UOMwV+6PQy4B/Yo0E/nv0zEyPLrhruWLr9QOPhIy/pNmhLZgkjmxAuMco3n632P+BuKR48kODREo6dqAVX0=;7:9PfqLy/7G+AXssWzfWOFO2hebvPmQRslq4n01F9DXk4J0lHZd+C5HI4VKQuSjczF/2HX4zfL1FdsjkFf/QT+GQ8a1BiZPxEcGyAa+nn6utMxRM6OGMAE0PNXUX3QRDPxcimEcN+XH3XaK2HEihYIMw==
x-ms-office365-filtering-correlation-id: 283a4714-ad57-4f1a-50a5-08d65b993ae1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1942;
x-ms-traffictypediagnostic: DB6PR0801MB1942:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1942FB0014055A653A06AC2881A90@DB6PR0801MB1942.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0801MB1942;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1942;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(58126008)(7736002)(86362001)(229853002)(26005)(305945005)(106356001)(105586002)(256004)(186003)(1076002)(54906003)(71200400001)(44832011)(2906002)(71190400001)(76176011)(5660300001)(8936002)(316002)(6512007)(99286004)(476003)(11346002)(446003)(14454004)(68736007)(478600001)(6116002)(3846002)(486006)(25786009)(52116002)(53936002)(6246003)(6506007)(386003)(6436002)(6916009)(66066001)(72206003)(102836004)(8676002)(4326008)(6486002)(81156014)(81166006)(33656002)(97736004)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1942;H:DB6PR0801MB1366.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KG+tAiqUQk6iqJS6ZNWIRrgy8c6y7pstYexD2wN2f47sAuKEaAal+83ydY9WTdGZgzMwGbwiztAuw4PmHel23PtoJqZiJA5GJ/f3t1TECMAWQvp+Xr75zvFe7rUnJFZinWb9v3ZmcYlTZQw2+TGrUKoA9fK+iJmWF9mkDCbG/VstYYh8Ez0R1sOMd4uVpOWk5M9fbklGrpaNj7nbAkoo1m0m7rlPaVoyEKtSEMXvR3+5QsQc8ogvndTlK3rQ8DEsnujr/sFXwzbKUmKoIwcDM6xA2lziFMoJLst3tCm2uXnrtF+8dWviiswiJa7h+eU0VBw19BDBSBRENdoBcMOQFmE6iVeoBrqSWb/eVmzvSsc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93B0BFDA9607C644A8C07B230C56C8A0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283a4714-ad57-4f1a-50a5-08d65b993ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 16:38:20.0766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 06:36:57AM +0530, Allen Pais wrote:
> Add hstate for each supported hugepage size using arch initcall.
>=20
> * no hugepage parameters
>=20
>   Without hugepage parameters, only a default hugepage size is
>   available for dynamic allocation.  It's different, for example, from
>   x86_64 and sparc64 where all supported hugepage sizes are available.
>=20
> * only default_hugepagesz=3D is specified and set not to HPAGE_SIZE
>=20
>   In spite of the fact that default_hugepagesz=3D is set to a valid
>   hugepage size, it's treated as unsupported and reverted to
>   HPAGE_SIZE.  Such behaviour is also different from x86_64 and
>   sparc64.
>=20
> Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
> Signed-off-by: Dmitry Klochkov <dmitry.klochkov@oracle.com>
> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index f58ea50..28cbc22 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -429,6 +429,27 @@ void huge_ptep_clear_flush(struct vm_area_struct *vm=
a,
>  	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>  }
> =20
> +static void __init add_huge_page_size(unsigned long size)
> +{
> +	if (size_to_hstate(size))
> +		return;
> +
> +	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
> +}
> +
> +static int __init hugetlbpage_init(void)
> +{
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	add_huge_page_size(PUD_SIZE);
> +#endif
> +	add_huge_page_size(PMD_SIZE * CONT_PMDS);
> +	add_huge_page_size(PMD_SIZE);
> +	add_huge_page_size(PAGE_SIZE * CONT_PTES);
> +
> +	return 0;
> +}
> +arch_initcall(hugetlbpage_init);
> +
>  static __init int setup_hugepagesz(char *opt)
>  {
>  	unsigned long ps =3D memparse(opt, &opt);
> @@ -440,7 +461,7 @@ static __init int setup_hugepagesz(char *opt)
>  	case PMD_SIZE * CONT_PMDS:
>  	case PMD_SIZE:
>  	case PAGE_SIZE * CONT_PTES:
> -		hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
> +		add_huge_page_size(ps);
>  		return 1;
>  	}
> =20
> @@ -449,13 +470,3 @@ static __init int setup_hugepagesz(char *opt)
>  	return 0;
>  }
>  __setup("hugepagesz=3D", setup_hugepagesz);
> -
> -#ifdef CONFIG_ARM64_64K_PAGES
> -static __init int add_default_hugepagesz(void)
> -{
> -	if (size_to_hstate(CONT_PTES * PAGE_SIZE) =3D=3D NULL)
> -		hugetlb_add_hstate(CONT_PTE_SHIFT);
> -	return 0;
> -}
> -arch_initcall(add_default_hugepagesz);
> -#endif
> --=20
> 1.8.3.1
>=20


Apologies for missing this, I like the idea of having all the hugetlb
sizes accessible right away.

FWIW:
Acked-by: Steve Capper <steve.capper@arm.com>

Cheers,
--=20
Steve
