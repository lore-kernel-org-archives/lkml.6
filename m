Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF414C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ED820827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pwJBXyAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ED820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeKHUJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:09:14 -0500
Received: from mail-he1eur01on0083.outbound.protection.outlook.com ([104.47.0.83]:50144
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726517AbeKHUJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07pnc0khEh6Wb471I/ZzbkvieF6xzaVDTTJrRyWbUOU=;
 b=pwJBXyAZw5s9pJuxrJq2PqC+OIJtX4VSG0yBI2S+XlRJ69H9PADsd07NU0kNoymy1wLP+AjOdXBm2wz5lYB21CY8I0Ax/cxqI6XMJpQbIypZMUYXcDZPWLh+Xkand316DdCIr/3tYLPPerRDVG3PhJNMtyE8D4EXIyz8+1hWSEQ=
Received: from AM6PR08MB3397.eurprd08.prod.outlook.com (20.177.112.222) by
 AM6PR08MB3383.eurprd08.prod.outlook.com (20.177.112.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 10:34:21 +0000
Received: from AM6PR08MB3397.eurprd08.prod.outlook.com
 ([fe80::19c8:4ac3:f079:622c]) by AM6PR08MB3397.eurprd08.prod.outlook.com
 ([fe80::19c8:4ac3:f079:622c%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 10:34:21 +0000
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
Subject: Re: [PATCH V3 2/5] mm/hugetlb: Enable PUD level huge page migration
Thread-Topic: [PATCH V3 2/5] mm/hugetlb: Enable PUD level huge page migration
Thread-Index: AQHUatCuf36yBYoRl0mbx6uUI2d/zKVFx4kA
Date:   Thu, 8 Nov 2018 10:34:21 +0000
Message-ID: <20181108103409.35r77mgtpigs5q3b@capper-debian.cambridge.arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-3-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1540299721-26484-3-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
x-originating-ip: [217.140.96.140]
x-clientproxiedby: DM5PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:3:22::11) To AM6PR08MB3397.eurprd08.prod.outlook.com
 (2603:10a6:20b:43::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3383;6:yxW1mQrNQWVDFlgwcDjJjp7VCshzpDcFxls2UCR9E3xqdaGuIVZNVtr6TWO/kHBCMLJmRbAuUGAcNu2Yd8BFXUZsz6vOON9eC/a8IHM9v7RHLkZVOO3mqejCqlLe1nbCnTLSqs0PZUuXwh/T9hqGFXrqhmtfnvS6EstoYUCVkEPU+N9Zcxpp1O0Iu3kZGkEcfWr0VDGBUFkHmwjE4iGTDUU2cydwI/onM87RxPL6Tore4KM1LB9+BcTu584gcm7R+l3Hh6Zha9+c6+hvacSmgrMcNu2T0IWjgblSRT/ByxHsHODnQwiDC8U3ESP4ngYM80cmEMaR0e6Y1sAeiK7WRGF0u1NrZzrlhNURelPay0jC/8nrdYzLeb3Td9VZtUa7Mv2dja9A+K/h+JJeipAGlyN/LqAiIIYO4BNLhXlQrazaNj4K78PiAp0h20FieR71VyVj8eUEOBx2GfvNUtLE8g==;5:3hZo8Ks/VYPa4eki8Yp4UXrxXzPbQejf/9aGBH1cPSMaL2BWSzTuqgE2Anjud/Z8DXP3j8QnMZ6wK6hER9N63zN1GkIUGiLV3wcPjzR59X2nFo2CqweS+r/R5TfgG3lqZTBYlpB1+j5NIw+uPV2g6YVQMXnob5atiUyjk6g3IWw=;7:xbWhqvo9SBEfo3JdzvuCUbAKPhrgMaIzAd+eDaDy+H5gnx7Xo9E+8N+IxTN/9t49c8CaTt0Z3Mc8ZMuHMDq8+irADdHLB2avfEvjfVpHkBdPO2sCYMVBgWSsfZGBO/N3xNvJk9Gz8MC/m8b/siAtrw==
x-ms-office365-filtering-correlation-id: c07c0187-d517-4373-32d3-08d64565bea6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3383;
x-ms-traffictypediagnostic: AM6PR08MB3383:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB338394E3FD42C2F0DF30C3F281C50@AM6PR08MB3383.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3383;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3383;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(8676002)(6506007)(386003)(6636002)(76176011)(11346002)(229853002)(446003)(476003)(486006)(44832011)(102836004)(97736004)(99286004)(54906003)(52116002)(4326008)(58126008)(81166006)(316002)(25786009)(478600001)(6862004)(106356001)(6246003)(105586002)(7736002)(68736007)(8936002)(14454004)(5660300001)(305945005)(66066001)(71200400001)(81156014)(26005)(6486002)(53936002)(6436002)(2900100001)(86362001)(1076002)(2906002)(6512007)(186003)(3846002)(256004)(6116002)(71190400001)(14444005)(72206003)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3383;H:AM6PR08MB3397.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3r6V0SvSlqL9/flqkuFbp/CD+D/2ZFGQaAPPnLe28tI6tPv1olldB/z3Q1DHq2++4WrbxLScelp+aZ/FSp64RZACPBZFvsY7dfhHXMc/bkp4Thov8lF6ceeekcx2kcJddm2429H5p5NBmb8JoDfEB9bGJ+1agZYqP0rmmNIPFR2Ay3EZn4NqQRN11RXj9ulCVJ2GSKOzSX3xVlZmIMBFIUhD2lQrT7Y24Ep1tRdz5MFwvot4CJ1Y5EcedlzV+fwNxfqMCo0ccFxFqj0X+5J98kDR26xxY72Vb86G6DGANhxSeBp6IIfKcd5z/CV4Sl6WIwwdeNuYN1zZ+wE+Zlo9XzjaU9f19N/MFMGpqjhoBOg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27B9F2B55EC4F04BB017B9675CDA0971@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07c0187-d517-4373-32d3-08d64565bea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 10:34:21.5072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 06:31:58PM +0530, Anshuman Khandual wrote:
> Architectures like arm64 have PUD level HugeTLB pages for certain configs
> (1GB huge page is PUD based on ARM64_4K_PAGES base page size) that can be
> enabled for migration. It can be achieved through checking for PUD_SHIFT
> order based HugeTLB pages during migration.
>=20
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Steve Capper <steve.capper@arm.com>

> ---
>  include/linux/hugetlb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1b858d7..70bcd89 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -497,7 +497,8 @@ static inline bool hugepage_migration_supported(struc=
t hstate *h)
>  {
>  #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>  	if ((huge_page_shift(h) =3D=3D PMD_SHIFT) ||
> -		(huge_page_shift(h) =3D=3D PGDIR_SHIFT))
> +		(huge_page_shift(h) =3D=3D PUD_SHIFT) ||
> +			(huge_page_shift(h) =3D=3D PGDIR_SHIFT))
>  		return true;
>  	else
>  		return false;
> --=20
> 2.7.4
>=20
