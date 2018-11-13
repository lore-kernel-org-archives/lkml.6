Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC2AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E072F2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="lixSw4Tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E072F2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbeKMPJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:09:52 -0500
Received: from mail-eopbgr770094.outbound.protection.outlook.com ([40.107.77.94]:20128
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbeKMPJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3srnsdPXAFI1ph55SgLMgvFLy3Pq4Z+vy3o0Ceg0mXQ=;
 b=lixSw4TxK0eTTkyzDPajQ5zFU/PRiVHfc8V7A7ZMCUX5HXGhoggYS+7muc2OopABVutKU9Xvb+LogM8TGZZeZTdAoROkKPvqX/EnfT3DKJdAWJaZMO/NiP22jrLl5y2SwNinCtroJmEORNFeP1sZ6a2fcnFdVQr3zWjKjl26sgk=
Received: from BN4PR13CA0014.namprd13.prod.outlook.com (2603:10b6:403:3::24)
 by CY4PR1301MB2024.namprd13.prod.outlook.com (2603:10b6:910:48::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.11; Tue, 13 Nov
 2018 05:13:25 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BN4PR13CA0014.outlook.office365.com
 (2603:10b6:403:3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.11 via Frontend
 Transport; Tue, 13 Nov 2018 05:13:25 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.42)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.42 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.42; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.42) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.11 via Frontend Transport; Tue, 13 Nov 2018 05:13:25 +0000
Received: from JPYOKXHT107.jp.sony.com (117.103.191.54) by
 JPYOKXEG102.jp.sony.com (117.103.190.42) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 13 Nov 2018 05:13:21 +0000
Received: from JPYOKXMS113.jp.sony.com ([169.254.3.149]) by
 JPYOKXHT107.jp.sony.com ([117.103.191.54]) with mapi id 14.03.0415.000; Tue,
 13 Nov 2018 05:13:21 +0000
From:   <Yasunari.Takiguchi@sony.com>
To:     <narmstrong@baylibre.com>
CC:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] media: cxd2880-spi: fix probe when dvb_attach fails
Thread-Topic: [PATCH] media: cxd2880-spi: fix probe when dvb_attach fails
Thread-Index: AQHUd2DlD/muDFM1tEG6YWFrtrDMZ6VM/sQw
Date:   Tue, 13 Nov 2018 05:13:20 +0000
Message-ID: <02699364973B424C83A42A84B04FDA850B32C7AC@JPYOKXMS113.jp.sony.com>
References: <1541681088-7385-1-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1541681088-7385-1-git-send-email-narmstrong@baylibre.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:cf8:1:aec:0:dddd:6f26:e2ba]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.42;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(438002)(13464003)(189003)(199004)(86152003)(55016002)(16586007)(2876002)(54906003)(4326008)(316002)(106002)(72206003)(2906002)(55846006)(336012)(186003)(86362001)(478600001)(77096007)(53546011)(26005)(426003)(102836004)(5024004)(11346002)(446003)(47776003)(486006)(33656002)(126002)(476003)(305945005)(229853002)(7696005)(7636002)(7736002)(97756001)(6916009)(2920100001)(2900100001)(76176011)(50466002)(6246003)(246002)(46406003)(6116002)(23726003)(356004)(5660300001)(106466001)(8676002)(2351001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1301MB2024;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg102.jp.sony.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT035;1:1YWwhiz9c6DvY46cYTqk90T7XEak42hfdT2mWMjtXPx6CS/6chwayZ2ND0FOwCS5L4ufn+1VKpuwE2KHlfAR+g8qct9g7w94BNK+yRrz/ANq7+Bs4brC9EsR56adBqj1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0b96ff8-e19f-4ee8-3baf-08d64926bd6d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR1301MB2024;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1301MB2024;3:cUs9lR2bS7PeeO/K6WyOqzHi0NTvLu2ekop4H8/vvZU2Eswd5AIJ/Yrz4dAsaAVmH0FhW8T+GBvsb9h+WtVueHoTICiAo9CXUSdIt1/urUSVAdlPQF1nKtKY1O7u1/JHATQATTF0Q6WKef/jTynFOyNhHVhCuDuJqiCYsgsSF0/y/TDW92rQ2sp7UxEpa+p0fEN4OPry6Qp0yFnYAuEsVIZSyj1Ect9gKH2LKCT8uXAc1Cb9zXSECjGac+A7Th4lO6ZCy5Qcrly5qYFRuXAAvEC8MfG/Xzx49iGkLoQfBX4xfkjO3m+Zfhxx/GdAaxhpBndOjyUCvfgDculasXk4aGGUyhnTklWHyrCxgVgpzlk=;25:xFlyUe7jpSZgOwOudbXfIYKt3e8TcEIjL3jQkTnqeRJ8E3sk6hZX0hfdfhzP2mma+pLiNHUskjK0J5lMkgoh4gHlzodCUG5Tp8ugYhI+QI+1hWgI+IV0xTXRtJpLnHIOyfp0hE6kiRAhmRBWHY5vhrnaapDfCxIEYF+NciE1xgyWeMEwcdimbyBPRsBeKpSCJzCS1/X7DNDUB6/CUfpQq89It2hb/rMIAVYkNxc6I017GNpgKrJg5+lfUFozxeCFt5tVtITOsSXcjrBI/u6+zFn0aIpe0xU6wjUH14phoQ4c9vVG4g8q3L+pUQpIGJgFlaOey3bigb9wroNYxurZNQ==
X-MS-TrafficTypeDiagnostic: CY4PR1301MB2024:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1301MB2024;31:N0a996T7MZ0G8YXiUpjKRBI3+I3kGUe6qzqSq+xuSVPi7sI6E+L1tW65kqB4DkL/nYvMLu+SCzIT+niMZ90gnfUiTSMPsjbWFX7jQq11h1/X+e9eYPa/JxuPwPL6vgQYyJ/c4wd+JWgCEqmj6hsUXlWX6GZ5zND6yyqGFXDNVPdKKDlhOHvdePWO90hXaA5BapQt1tKZQjLkUbJB8KvjKEmvFGeiWljtDi9Yfi7csGc=;20:XGALalK1PjgZcQW/pc2p/Gzp+JfgTH/NY7y5XS/X3eFUtT7dlLpyIFvpOBISZEoPyK13NKQUcKqstKUkmH6cVkwQ0UcHkBpD0yNCmYvwjYz2eeH35qvp10ytZE6cUaDV7ryTAeqUqeCVDanc6KPRDbb30ySuTME1flvTwgVnnOeyJ07hBLcgmBJf6CjkaaD0kjR3jP8AoHaGSgaqYLSionZQQ0ygnKYEYu/kyVwmzUxuYM0bKRlf4B2wUWNekayPtQe/uup3UD6e7grD/NKxBXWzQcmkBsIxtLy/C9Jbi7WHr0H3DpXt+wWsrZeHomLtDIPQX35hIRPJQrjm//8iLvqLJcFt612etnbvL1wB9r6VTrpX4MMwIkHLjyUWw+ciKOggmIb2clgYAbc+SH57Pi/LiJtOPYSbJTuq5Km+l6qhb1bH9mgxjFfJYeCXXDIN0wdLnXVBWaoPxOT4xNaMsXYnznsF0xJa3K1iO11F88odrl8HljZ6Cu4Ro2tt4kaX
X-Microsoft-Antispam-PRVS: <CY4PR1301MB2024E3321A1DFFAFDD5D5382FDC20@CY4PR1301MB2024.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(11241501184)(944501410)(52105112)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR1301MB2024;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1301MB2024;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1301MB2024;4:OPFnmpElpLg3p7R+LcI12TEetSSJP4INaqW4Q+urdjCpdQ75zkXna+BtC5RnuIy/tI2syuvS9epdwdYbg5XL1kezbOPgIfQnTxCg3VhZxfO/39zkqIyT7BGyvMBxiByxmB67f7leErfh0FkyisOH7bwVbQgtPr5jYHTsRRQq5LcPNqEELjfDK0epwRQ9KNXLqIBnD7pnchhcGxKZAT+4ZOFjBczygLuRML/7lCREJ36MiRrF0HcUmeTjY+SIghNCtw17KiZMNJX0E2dqJ0QuIw==
X-Forefront-PRVS: 085551F5A8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR1301MB2024;23:2nd9I90Scc9B3JHFNPSVfoJ8vXGQvKdQ0gWlnf6?=
 =?us-ascii?Q?nb/MVjzqDTYHMoWfFEZDxARccHLYBpmMjz1VdxiXsgzB09rq9ufJOMsUrE6q?=
 =?us-ascii?Q?b9ysYQqgUY+vJbhrXnPnR9LBLTKmt/vdJqtwspAxFaXzMx2wf5u0YDWk4ahZ?=
 =?us-ascii?Q?Noz0vjXFyuo915QEVZoo+x26SxHpTWwJcrewlewkkm30B6oF7QcWBLpIa6H/?=
 =?us-ascii?Q?dmiOxrfO8pRV43rresT78gAirEC1hupWL338sV0rmtF0PZiUGFTwC9DLvvbd?=
 =?us-ascii?Q?WM05Zz2LDVMIasMFJkb4WoKgt2NjgosZQKCqekHM8+Em3QyAQqCsgkEfQ9ta?=
 =?us-ascii?Q?LTxaKyQdon6bDKjFk3pt4Jrr8kO24pdKcitf0b4td3nU62BfZswbkLEtMJkQ?=
 =?us-ascii?Q?4K/tBBHrhcm1RUx60c5oIuzNPm70tBA0FCehzUUbSFGXDxogEViRYmDbqvCi?=
 =?us-ascii?Q?7kgr63WlHzapa29NtretN2oYKUM06bZfOGe7Gll1+9NkTnFEiaZaRazPtvod?=
 =?us-ascii?Q?BiLhtdv+ERmUyUsxa5Gv1Lc/cm+h0WYqfftlunNq9u+RWOdXYuDsQj2LalrN?=
 =?us-ascii?Q?+8GyMBNAglYiBFNbgSvYZ32OOke+JpGQL4319i37iAdi5iOTR1JR0AfSWsth?=
 =?us-ascii?Q?8BdLZUQGDCmfPI3av6e0xpFw0HqQH3MlMxGpkG1p7dNCeGkZzZI0i8lVYcam?=
 =?us-ascii?Q?EonrZuIDFJtkI1yOe407wBm3s+R2KXXWo2oRb+LvLR2wmc1dMBddfDT42sBU?=
 =?us-ascii?Q?g9FUcKf8pEo8SqfAdL5SKUm7DDp8ZB5XSyaUQTGgtT3j5VTZxXAeGfNZtr6s?=
 =?us-ascii?Q?sNYHVEhM+hm/6IUsQPt756gxGk842ho4rd5AAmYhCez3D9UDaxy/bM9ll3KT?=
 =?us-ascii?Q?nlskYNAyXW7hYOtn4m49moZ5g+1hb2PuW/wPaZfaB4Nff3RVPssCgQfqMUuD?=
 =?us-ascii?Q?ex/mLWT4AcBCDQutEO0vqTzcL/Xxn3eGLs2vjvy9jF1/gDTLogZJhweO5283?=
 =?us-ascii?Q?+W37lVnih2v8pv8yhUysOqz+jGIqgxs7cqb4NLPSHP3f2pkf0efM4zPSeWaN?=
 =?us-ascii?Q?AyMz40w5HxI6G4lEyEHVnwg+jF/npYKAwvRXAQy5LpZBteW2XTxPwCdrFem1?=
 =?us-ascii?Q?ibE9sL9Tfuah6KGvPa9W1AzPb2XupClHyUPmjxtdIXbPb/VGf/TOyCH1ERb/?=
 =?us-ascii?Q?FQDWR5AKZUW0GoQ6Wr/1/eGwXVUoj0Ry5+cRqVKC0GRYVyP5qM4PVwUm5cr0?=
 =?us-ascii?Q?ikqmrbydmxbsX5tiGNS4TcuCgFITFPtxwypNGKSy+9y7YDBaBDKIwwTvsMlN?=
 =?us-ascii?Q?oCAMZRcT87JN9IDVm3LU5Da8=3D?=
X-Microsoft-Antispam-Message-Info: WKXT06FtAgaCsqwLFPZolXGJ7b+Xy3IJsNWGzwEfPs56BtewaxYZfhQBh9/4paz86aUSPWVGm37Dz96SZ823ixTRhKQJnTxHbW4A4FD6kO+XdN7BOP9J+4vQDrRzSLK0gnEYAJT/ySSpa1HSBixtkuV27lV8H3ahEMinx8TCd2KdXl+r6pKyugZupkAcwDWiNI5Vgty6+M9K5cbO0gIRANIoFMm9/zG+cUo2QTgvkmhS2sEwtourhsXejzvvJigHTJFpgAuIOv5Ru/Ojqa0b9Te4VjlZaN1seSfIWD08W4UhFSv6biJWwnEJ9SY9Ysyep/IQEakqsGdcgbZDAFkScDYxP0crlZ73EConTanmFSE=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1301MB2024;6:5YysyjZc31kNniGdMl6oD7Z90YUHqlxg5IxBYoG0s+o9Fz3g/NaszVXvrHAmCp39cXuRZkrR8Ucmv2ARn7x0HssCMCaTSz69mMa3x9CZbVJnTV8Ep0Z9HpTWmhyB7C6xu4L+b28QClGvXDoR4fTSfjQb1FCK0x9YPHd9xeFANZHEb1rY4UB0jn9JNrNbSFVrIsQa0Wc3tuCKk1LQdOkQTurfMiPSm9N0ftcKhg2sK19iy3tTQGU5fiw/HiEYeoV8kSvJG45zhjL61nQ81a/ipLj2/gS4wFSmReEr546eAy77dykZ3cQTQvdPguLL0fH5vA5PBE/mtobIEdRnt69oB7RDeD0mXK2IGOdzFfeyx4Tz5JVrizSGkxAraIX/YXwE8ig8NM0YaVa+tmK/EgoyVFRjRA0PD1UjJB32RqQJYINfVXAFeINFq7vqkxpmsAd7zY54xaFxzxJFiEJwEC2Euw==;5:M1MP+PnbvvfhiREfxkB+j7HBloWoT9UrhoOghcIn6j7tTKO/hmLozO8yxOc07u20yQSRWr64TFpn9DceKcfmZe/wGe6BKiMHULlNtAaKTTDOtts5vGpcJbPaMfrxrlBnhvr9P++COZKjSWC+QkTEutioYzdFMRdjlLlMXPDP/GI=;7:hy6vviTgs+t5oZJkYKaYxN+rRWNMGr4CkGiP/7DRpSxb2YSJeiX9x5cnTU3DH8NAm5n4waOXmVkanYsKXU4HdrBSNfiJmELE/Yfbs9U6Pb56dAeah8CFQJBuBbaAyE7kff/LdV/G3nOGJ9udh5+W6A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2018 05:13:25.0610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b96ff8-e19f-4ee8-3baf-08d64926bd6d
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.42];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Thanks for finding that.

Acked-by: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>


> -----Original Message-----
> From: Neil Armstrong [mailto:narmstrong@baylibre.com]
> Sent: Thursday, November 8, 2018 9:45 PM
> To: Takiguchi, Yasunari (SSS)
> Cc: Neil Armstrong; mchehab@kernel.org; linux-media@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH] media: cxd2880-spi: fix probe when dvb_attach fails
> 
> When dvb_attach fails, probe returns 0, and remove crashes afterwards.
> This patch sets the return value to -ENODEV when attach fails.
> 
> Fixes: bd24fcddf6b8 ("media: cxd2880-spi: Add support for CXD2880 SPI
> interface")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/media/spi/cxd2880-spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/spi/cxd2880-spi.c
> b/drivers/media/spi/cxd2880-spi.c
> index 11ce510..c437309 100644
> --- a/drivers/media/spi/cxd2880-spi.c
> +++ b/drivers/media/spi/cxd2880-spi.c
> @@ -536,6 +536,7 @@ cxd2880_spi_probe(struct spi_device *spi)
> 
>  	if (!dvb_attach(cxd2880_attach, &dvb_spi->dvb_fe, &config)) {
>  		pr_err("cxd2880_attach failed\n");
> +		ret = -ENODEV;
>  		goto fail_attach;
>  	}
> 
> --
> 2.7.4

