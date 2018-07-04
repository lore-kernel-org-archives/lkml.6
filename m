Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C93C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E8723D30
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="uBZrqfRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E8723D30
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeGDOil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:38:41 -0400
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:58208
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752136AbeGDOih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC9YQ1xn4lH7Ygajwf7lULNtJKj6RK4/CYkViT69DVs=;
 b=uBZrqfRlcRcvTn+cEZ7lX+zRUjoyKceO3Nak68hZtuGFnbwmSdkqbx6S41L9qCwIV6fYQvXYBbd+fr2/wbGyV0fPTtL6MHXsHnhor6mJqGeWmL9PNv0FKk+8jkXImxD0fDHVQGhJ0o8vq1uoqoPRMJctVrxWidqnOt+rKMGA6AQ=
Received: from BN3PR03CA0099.namprd03.prod.outlook.com (2603:10b6:400:4::17)
 by BN6PR03MB3121.namprd03.prod.outlook.com (2603:10b6:405:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.18; Wed, 4 Jul
 2018 14:38:36 +0000
Received: from BN1BFFO11FD013.protection.gbl (2a01:111:f400:7c10::1:193) by
 BN3PR03CA0099.outlook.office365.com (2603:10b6:400:4::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.906.24 via Frontend Transport; Wed, 4 Jul 2018 14:38:36 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD013.mail.protection.outlook.com (10.58.144.76) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.820.5
 via Frontend Transport; Wed, 4 Jul 2018 14:38:28 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w64EcRI8000793
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Wed, 4 Jul 2018 07:38:27 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Wed, 4 Jul 2018
 10:38:27 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
CC:     <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v5 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Date:   Wed, 4 Jul 2018 17:32:53 +0300
Message-ID: <1530714773-18956-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(36756003)(6666003)(5660300001)(356003)(305945005)(7636002)(246002)(8676002)(54906003)(107886003)(110136005)(316002)(106002)(50466002)(2616005)(426003)(476003)(336012)(2201001)(23676004)(186003)(126002)(8936002)(77096007)(26005)(44832011)(486006)(7696005)(50226002)(2906002)(478600001)(2870700001)(72206003)(106466001)(6306002)(966005)(7416002)(1720100001)(4326008)(5820100001)(53416004)(14444005)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3121;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD013;1:c6o+bjST9dfv0dLLV/GkXignhEsm5fIdmnrwnUWBA64jFhLMgVDt/NVAcfAXUV1K6YUWXrQ7bZI8Dq94CJFGxt/d9UtMROfZKL74CAZqxdB4gjfyzGY6DkDxOgaiuiW0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84cbfe6a-c75b-4285-8c8a-08d5e1bbd1e5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN6PR03MB3121;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;3:n5bryekABi6HDwxeguH4KQs5tADlNJiRvuA00z400rhDTpeDdeFTzlfvTR6d47nZCM6YlIopnyKzgEZMXAtwn7mVS2HOjJ6zUwcLa8+2qo5lGJ3joGXksjN0F7ygpE19uZQqQ+dUSxxLpx1jVDIkW2qsBXimRfTKqKHKQs53Igalvrn+eHMnofWeZDY8v7oreqMqDjVfdKCjb9qsZZUCjHRgLGHwLF75fXs2UBOZBE9It0PBN1ZUPi0ogikFzQz+UrlopIbFzkRfyyvIUzcLL6qsGTFcx9gJqKZj3gEJcSKYe0J1kHEl7DnEkxgpyrJ2CZ1U/4jox2TaehFcXGA6scBu/qk5XAfHGz7vjWqREJk=;25:ciGSHCKOnQRFjTvpxE5kZCwge06/3HZDFSJ7P0I46dPFqzFkrBG6F9L194E6x09OABDQcLTqCjUOcGU7NZ25FVehlp/s/QM+Yl0/TKDYdiwcO0ztrXji+PiT/6teVQXpidiXjN12qX1WbIBNiWLnbE5M3BsCFNHYdRg9QxwtO+tTFeJzaZTM6LZwQpTdaAH5bb4ON0zz+iJw2sxacgpX63LvtYQcY5EAgci9yInqMEX++bhUN4Ai70eJOfKCcywFGJ6NO7fp2TDmS1LqkUyHfHOg4OpHLxPuInPG+AHMlCzqv9j5ZsMoC0scYEEpFCC70tn2nXYAuhSZCY3JrnYX+w==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3121:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;31:L4bRQ2PV5TU/ZswUKs7hyLAoPR8aL+8dxZBogOYhn+rhQ9/OBrhBPnFXZrdMSqO4LBiNf2YLhRw5ExAAQG0YHwIbkkY516qG061tIOTriGnebvHcw5uAKDzzxZB2QYyTX9yVn/nAVCXY/jPhf34+AaKJf+BYevTKwodf/1pMZsK2E89mns6tLkJEfLsNC0zwyBkdEVoW7tNBkeY2D/1h1qL0ZzdoWd9EmCfGVV5R/dc=;20:Vwb25rGM07Pv5swOD+KKRZpPvygT/K5PZsUvSGtCOc9J7gBHrUA90m2U7IVs57FiEjCTO633StgTHuPFeqgCMkC9aA1bLIY0WrJbRRTVCSkf5kb+vrf2P5fiQgJPkSXHv+1I68P5g51wB5/rZunhu3kfAq4PXeMYdYn0W4xq3wHR/7BXTyMSNNntF2VM5NHMuiGADWwUlEyYFPYwpA7eqgkJ4vy5RLcy/vjIcG8/ZiyOwcfLISiOOJGE1+rBFkVmtLkckJxPEs9/E8+XEP00huvMD8WnLAlm/b4dVOh8cpNB/YVAjEtnZKpl3QZPsHWLqQfpoUkf+axW9m96WVOAbVgL/grClOV4JpbSY76LhvxNDRMoassXdSmSZqFs+cQZl2VXy6Ge0Ugh7EEI8/vFlNelxgMjAR9T8MTqwjicdCCK91qQdIdM0gMGRW7+JuOhcntpeCd8aZ3gUgj0y4T2SD6RDX0gAgZSVsnGTRK6ByTZ6eHocIPdYdmjisNmL9/2
X-Microsoft-Antispam-PRVS: <BN6PR03MB312175749213442B5FBA5F269D410@BN6PR03MB3121.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB3121;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3121;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;4:IoguQbpHhI1J/Fb4xNOp2ng2yIAjfEnG88utWMHgXi5M72BodBD+61sbNUZ6cCCuF5HehSWdCLM7JPAPXOE3LSJFphzEfBfSQpDSh9LdCROK0vC7oJbAdPb87e9jEQ4xPsLvcvPiGnPAFIrh8wDWwq3qjwQflgxf5C0ahBangyoI73ckvyS3as1Xa1JUoYGaZi/eR3ouGXV01lz6Ud2JUXGDgBughFpVhFt7u5G/FpdtXoP3ziKgpU3aYDW4oe/tO05YOetqjK2gEikeBdP2eQ3wxIj1bAPf/Ir1cygLRiv3c/A1Zyd/uoawKbFZnnTkibEC2WgdvN3qwumZjEOvKmoPIjp64PzBNK0RlNyuVDO6HMUXLK5yA3nY+wE05abA
X-Forefront-PRVS: 0723A02764
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIzMTIxOzIzOklSOUQ1U1ZXZ2FJUklyZm5YWTMrMVZVdVVz?=
 =?utf-8?B?RnE2WU5ZUThLeERTM1JReEtldS9QZ0R4L1NGU1Z5TGFKRlBzRkFJMFMxVDFX?=
 =?utf-8?B?eit4MW1qWHg5QUVvbEZKK01xLy80c0xiSGxnTU1vamt3Ty9LbXg2Tk9GNkNo?=
 =?utf-8?B?QmN1K1psWllSdmlaVU5PZ1lmN1FZMDkveTBFQU9WeUZkRkJBaThWUi95dU9Z?=
 =?utf-8?B?ZEMraGttaWNnRmhWalpQSkMvUUdITnQ5SlFZdkR2Tk0rQ3U0bWRqWHlrUnFk?=
 =?utf-8?B?eHZvQ3JKdXN1TUFFREovUGNRZGIxajhxNUNzQkJxK2JoTEVwRU9KRlpMWXZ2?=
 =?utf-8?B?VXcxTlFJdVh2di9LblFKL3dmOWpBb1BMaG9kdGhLWm9LSDBucXUwWVM0Y2pn?=
 =?utf-8?B?WUtEQUhEWEtoeTQvVEdEb2RKWS81K1Y0K1FaZFJ3cEt0UHF6Z0FneVIzcEdE?=
 =?utf-8?B?OTZqQzlaUS9IYzZBU00ydDJESzZtMEtzc2lCN0lubUpZZFV6OWpBSnY0dkll?=
 =?utf-8?B?QzlZSDZvWldTK2xtbWk0SEJOK21jbk0raEoyZVNjVHlOd1d1TnNwZmE2TXhH?=
 =?utf-8?B?WVpwbTdSRElpQmg1WXl1eWErN0UwQkRjLzNhWmh5T01abzNXYkh0cjNUaFZT?=
 =?utf-8?B?bXhSUFpMQTJSdjFoTkxVZVgvODFLNkdySzRnUnlpVHpOWWN6dndSekI4TWVD?=
 =?utf-8?B?MDJOYzloNGM0Wkk1SDkvU1JMenBYRTdUdkVyMi9CNXlYWmlOaGtXK28valRR?=
 =?utf-8?B?ck44TGdWYmorYk1Ma0Z3Zm9ucDdHYWZhejByR252S201MDNxeE8yMUdSTlpT?=
 =?utf-8?B?ZXR1SldoZnFMZTlkZm9XSGxZQytQR2VVbEJaVlRCaTNhK1ZzUzlXOHB1ckUv?=
 =?utf-8?B?MVNDS2dKY1NCdmVXZVlhVWZmTTFicnRScjlLVEZhQkdGbkV1TVZyQzBoQ0NF?=
 =?utf-8?B?YWpiYTdTKzllUmo2QnNHeXNuOWdoTVNjcXMxRk41YU1IQkdTU1hBRUpYYWV3?=
 =?utf-8?B?aEpCOEs4UWlST0JWdnlpUnVwdmMwKzlQdllGczdTYUJwRmdFNVdIUVMvNWRz?=
 =?utf-8?B?djc2cTNQUURkWXRSWjAzZzV3UjFPb0lKR1p0TXpLZ0hyWG8vZHd6WTRUQk1J?=
 =?utf-8?B?STZHS1dISGQ0bTE3UzQvSTd4cWlhSmtQcHNwM01VOVZpTHRRSUFKZUd6VE9v?=
 =?utf-8?B?cWFVTFBReGlvdGVFamZLc0dveHlzWjdtcDZkNERTU2g3bk96aE9HejBWTVlP?=
 =?utf-8?B?Ym5XTzl3V2I5aFdzV1kwT1ZwdEREemljcEZqaUo5ekhRTXNnd3Nqc3V5Mms0?=
 =?utf-8?B?ZUxKMTlXZkZZZDNOZW9CY1pFUnR1VnF3bmZVd0xUMjJ1RTdKZVZ4YkRTWURP?=
 =?utf-8?B?dEZ4aDJUMWJ5Qk5OdjEzRGl0c1hWU0x3VWthUXBKMzBvdVFGN2QvdnRSU3Nv?=
 =?utf-8?B?aStWcnlHd0tTMHU0RmlTdlJPZDRmaDU4Y2ZxSTlVS2Y4ZGt1L2NMNG1XSG1H?=
 =?utf-8?B?Q0FteGhtYWJ4V1F5RmNHeGhLM01xc3pjOXB4Q3RPWnFRckYvRG1Xd0hwdkdq?=
 =?utf-8?B?ZmxiS0d2SytPY3JESUxhdXZqcFZBTUE9PQ==?=
X-Microsoft-Antispam-Message-Info: Sdw4od+2/qib7xW0lW/sjTBYsLIbwf7somuplhpWVXsSfHjTLTf1uUUpI3DAKUiW/jGe4a+MZJ3SVZD4ywt6sprlXVqFUHKEap15tRMR7DxdglG4+7WSn06knvc3p9YoJ4gn4JEHtMhzp3TrFWMub5Z/z6mJusO94MHFn3Rbj51SGll4cKWvxcNeeW0/l0eAlzbFmlu98Kz/NG5mmDC6pRr0C+/XUvA8/sEY8ybtj+lNTmke6QJygV7N23l2jUSzS9dySkuUx0oo/8v8xWGI9DnhGmfb69lzT2ATDtZeYS63MWGA3PpfhiRU83JmlovmYP39gIacJqfdAFtXdzbyJUh+NPYF3F+rDxt2nQdKaHA=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;6:MUb9avA8RyZEtkvoB30cePsUp4pZG0n2csvP/v1HalNRX+y+nl3DllFvPnFGgmjrtmwkIEqmmYdHraTLs5KXt6cy09T+YvNB3u/aEJ4H9/zkx0Lt+wQ0ibzVk077kTZX6n+pK/aSsgfefEc2CxaqH0+BE3htVbZhQZTxoGZ6ZiU9SY9JdshAdLrnjve1XTm7vSRSZnczGBNeN4rFI3wZy/zkNxCwjeXRvdeyc9E42Qq4neYF+BSUyATYbHAhxLjrcYFYw0L1PlOP+H8ckMNBUaZ9Xkb2c2VIElsvK643pGVU1yHAxX6HpeZ0bqKbVvkseqCVTSQT4lrI0PkWlABjxCGLl1kBnmekh1icec9uVmfZ6avjMXDGMkHPMpB4tSjMqNIe9tRbbEvPRZAxxF86AdgQtBjgLWDsto4MP5mngQYBD6QvSSJjQgLh4avD6/tXM8zKEw5x9GxZCsN6gJw83w==;5:woJD/O2hIgZsp3RMTn4DOltSnm7sAW1dCL6CMCvhMfO2dYeLnmAKxKpZ9jvKyqAvbUaMZ1sOvqXJb9yYon+mt7AKTeAmno8i1tM8k9vT+TveA8lw2+TKH9+OtQSttj1CHg6f792crbbebn2q936JkIqPsPKV/mr2YUYUbF1tS0U=;24:+Fgi6hvWZo7/5VLlvD0L5Gqn1dUt7xojw898MJ/W8thUAeu6sPL1Q1mUbhMJ3+J2aoXy1Ag1r5bwbu6gm0hnM5uny1tZvGkvKCMiTipxyTg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;7:crDD2VmHuH0UJRtQHNQ+iyPFHK8AahnFIzrlTkrSqcj2GKJtTYOw//ukE0qRuVMlIhQAMioLusgk29YQwOG71o8yqs196MqymXn27pjZxBXBCooyURDNiZ8bAnFIRYu/1rHBnf4k3fvCkugwxwEc7AbfLcp2NUwsKmiTVXXZICTMA/LJmmadKB2rZsTx/1cfl2EITMiNXFj0XufWZNVR5huUeDMJLuiMWxP1tjhUI7OIKFlu8c/qWZEvbIn8HIQL
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 14:38:28.4965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cbfe6a-c75b-4285-8c8a-08d5e1bbd1e5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v5:
	- used a dac@0 as a more generic node name instead of ad5758@0.
Changes in v4:
	- Nothing changed, just to follow the patch set version.
Changes in v3:
	- AD5758 can be both a current and voltage output DAC. The
	  decision is made based on the DT and the channel type is set
	  during probe.
	- range was replaced by range-microvolt and range-microamp
	- dc-dc-mode, range-microvolt and range-microamp are required
	  properties.
	- Introduced a slew-time-us property from which slew rate clock
	  and slew rate step are calculated using a best match algorithm.
	- Added units in the name of the properties.
	- Offered more explanation for the various modes of operation.

Changes in v2:
	- Nothing changed, just to follow the patch set version.

 .../devicetree/bindings/iio/dac/ad5758.txt         | 73 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
new file mode 100644
index 0000000..90bc496
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
@@ -0,0 +1,73 @@
+Analog Devices AD5758 DAC device driver
+
+Required properties for the AD5758:
+	- compatible: Must be "adi,ad5758"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use (< 50000000)
+	- spi-cpha: is the only mode that is supported
+
+Required properties:
+
+ - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
+ 		   Dynamic Power Control (DPC)
+		   In this mode, the AD5758 circuitry senses the output voltage and
+		   dynamically regulates the supply voltage, VDPC+, to meet compliance
+		   requirements plus an optimized headroom voltage for the output buffer.
+
+		   Programmable Power Control (PPC)
+		   In this mode, the VDPC+ voltage is user-programmable to a fixed level
+		   that needs to accommodate the maximum output load required.
+
+		   The output of the DAC core is either converted to a current or voltage
+		   output at the VIOUT pin. Only one mode can be enabled at any one time.
+
+		   The following values are currently supported:
+			* 1: DPC current mode
+			* 2: DPC voltage mode
+			* 3: PPC current mode
+
+ Depending on the selected output mode (voltage or current) one of the two properties must
+ be present:
+
+ - adi,range-microvolt: Voltage output range
+ 		The array of voltage output ranges must contain two fields:
+	      	* <0 5000000>: 0 V to 5 V voltage range
+		* <0 10000000>: 0 V to 10 V voltage range
+		* <(-5000000) 5000000>: ±5 V voltage range
+		* <(-10000000) 10000000>: ±10 V voltage range
+ - adi,range-microamp: Current output range
+ 		The array of current output ranges must contain two fields:
+		* <0 20000>: 0 mA to 20 mA current range
+		* <0 24000>: 0 mA to 24 mA current range
+		* <4 24000>: 4 mA to 20 mA current range
+		* <(-20000) 20000>: ±20 mA current range
+		* <(-24000) 24000>: ±24 mA current range
+		* <(-1000) 22000>: −1 mA to +22 mA current range
+
+Optional properties:
+
+ - adi,dc-dc-ilim-microamp: The dc-to-dc converter current limit
+		   The following values are currently supported [uA]:
+		   	* 150000
+			* 200000
+			* 250000
+			* 300000
+			* 350000
+			* 400000
+
+ - adi,slew-time-us: The time it takes for the output to reach the full scale [uS]
+ 		     The supported range is between 133us up to 1023984375us
+
+AD5758 Example:
+
+	dac@0 {
+		compatible = "adi,ad5758";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpha;
+
+		adi,dc-dc-mode = <2>;
+		adi,range-microvolt = <0 10000000>;
+		adi,dc-dc-ilim-microamp = <200000>;
+		adi,slew-time-us = <125000>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 12d102d..60b1028 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -802,6 +802,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/dac/ad5758.c
+F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
 ANALOG DEVICES INC AD5686 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.7.4

