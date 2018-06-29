Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA7C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7240A26FE9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="b5/2xCrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7240A26FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965695AbeF2Ijj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:39:39 -0400
Received: from mail-by2nam03on0080.outbound.protection.outlook.com ([104.47.42.80]:33504
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965506AbeF2Ije (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3cEfCFxXVBHq3YfyRRaIFt2c3QGhnEhsSCTklPZ0Ts=;
 b=b5/2xCrbaWpSVHF0GBr8IiIhDKHRC0tozhuIu2a5P49EzuXMULzXhfvtA1QgmO7JhqRZ3UJs6n3rntC/ORmfwyW3aqGjQqFcvQNhPVkhdfWh5AKe4rA+YfwgX72+LgwVPq5shC65Cklp432E1jA01SkyC0boMdf02UObGO3i1i0=
Received: from CY1PR03CA0032.namprd03.prod.outlook.com (2603:10b6:600::42) by
 DM2PR03MB558.namprd03.prod.outlook.com (2a01:111:e400:241d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.24; Fri, 29 Jun
 2018 08:39:31 +0000
Received: from BL2FFO11FD020.protection.gbl (2a01:111:f400:7c09::125) by
 CY1PR03CA0032.outlook.office365.com (2603:10b6:600::42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.906.23 via Frontend Transport; Fri, 29 Jun 2018 08:39:30 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD020.mail.protection.outlook.com (10.173.161.38) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.820.5
 via Frontend Transport; Fri, 29 Jun 2018 08:39:30 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w5T8dT37023909
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Fri, 29 Jun 2018 01:39:29 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 29 Jun 2018
 04:39:29 -0400
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
Subject: [PATCH v4 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Date:   Fri, 29 Jun 2018 11:39:10 +0300
Message-ID: <1530261550-21224-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(50466002)(5820100001)(6666003)(7696005)(50226002)(4326008)(23676004)(106466001)(47776003)(126002)(486006)(2616005)(44832011)(14444005)(26005)(426003)(77096007)(5660300001)(476003)(106002)(316002)(110136005)(54906003)(186003)(7416002)(107886003)(7636002)(305945005)(966005)(478600001)(2201001)(246002)(72206003)(53416004)(6306002)(356003)(2906002)(2870700001)(36756003)(336012)(1720100001)(8936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB558;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD020;1:dq1LySMOj2z/676iHQ7BUS9knrCWBQVaBAlnFOLndZXVlYtP8LTSmSOmeDKWV64tP9dsJBlrBrXBYCXoqhvKcR+qqWOR6lGevnC1i46PVkzyXXGmWOCguCwxCvMIN5Jl
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1266113-d3cc-4440-daff-08d5dd9bd4ee
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR03MB558;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB558;3:Ft1V1OrPKi6MQgePiXudHDicvtiIsPSGO3/OmSANCR/bUOg4bTIaAptUA+VH1tjLMCzgr2i64JL1zw3qAmyHyiQTYQ4T0vNOqoIp5qo7IjSdzsWJ9PlB1O2reyikQiZvMuO/hL5kAVTgI0/Rmelc+OxMnNNWqTpw+Ydm15dHoUY4bD8n2hZdLedMhnFTOhB4DlPJDxLfhmqB45xHGH3Co+dUT41DcK64OPdyRkdlJFwwcgw05WJHsHKfIREAU7wZtgAXiYJrip9z8P2ssA9r9P9y6+PwyShrEnZj0c05y3FodqgJnrKF8H7BP4hDqfRaE0lvjkHt4TjsJqDsq0Qt7+9Lkcum6T0cmZ3wiA0HvAI=;25:giEgfWZiCaQVR9sBlgD6ZpDlQT7NDKfXTzvTJ2PfjUNpDTk6u0XXa7XbK1XYrBtSCcJgcZtd8lFWOLpi2TdlQWt1op7RykTX5/RcT1qmIP5URya4dgOUf7fKUitrwsBUFTu63t4Jfr8PTbBF3C3ldmPf/Us2fQ4ZJcEy/nolAMNulTsUEdMkwFiA6hlntXPULTrUzs4plQargWyEMH0cWhABFEmh81wDcKB0zcrx7JINVbptpuiVJBXTJgcdoBjwuNMTNAsnyRaJxUwmhrc6em2cova3LmWT/ZLW8e/JBKXWgL1qfIyHAcmYm33jTesLaetZp71GD4Q0dd6RU97Exw==
X-MS-TrafficTypeDiagnostic: DM2PR03MB558:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB558;31:XP54CS/Hhm0B634Y7ay93tHQQ/SPfrCQ3haGXUN1zwGd7K6b2+q4EXwOiNW0oncJHo6+7h6mbVxLwcHyLKDCuvZl4Hg/zErGprKdsrFECMkpZE5BlSzx+zgnnlszFV/oS38upopSfVztN3UVDOAE0hu+9woQyUjv3u5i9yAID1/mNlL3cp6kDO+SdQ1a+JYaJuaZJgvRtFYMYvuqhF1GmjnehBtBTHJkLQrQAIQwaaA=;20:GovjRjuYcKIho6qi4HyTFdKgcl1D38Dm62kVkpU9AJ2duCnuhIMuo04i5rphmEeFJRfD0krNDSVHsFJabM0QywBvC6lrz+bck1tEa2i9LqSRpnyVv+QfXnAn+DsyxhJnEH12PDEYOk79Aq8JQ4ltRHa8cZulVGiJ4tH51vkIsFztoZoR8BRxC+BIpaGk31cYEsXWxwIdeMP60DXMNTLMEZXCAYLK1qAKtzoZpbflHL4pHbtPHCd6dNZtrez/bVYaATzT1P9zIUgDsrSgQwtBwzdtaSTkigFz3aeJFdYbkw8OoXkjEYnIE08iF5YCWkpRhyY+dUbJDwuVGYJDgBlbf6FY7LInU0O7v1EafvgjaO9MzHFv1KnfAhj74saLj3vr61xib8akmuYRmdnbfI/5hoK6pdxBTs5SHWUjo7fyQvbSsjysg2hF/82oEp08W8+IIBHGbHHn9ML8DvdzOOPFUfWGIRmPYdA+OWJm8YhLmN+TZ+/p+fxtByNNInOoF16M
X-Microsoft-Antispam-PRVS: <DM2PR03MB558F63728785952188943D89D4E0@DM2PR03MB558.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM2PR03MB558;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB558;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB558;4:SRz4QoY4d+EQR/JoDA9MXgpnacHeBqdWuV2TRiXVSDPky0VgPk79nNCvCv02n9bbirb0Bar8Pbn5l8ERRgzdYZhQgKBBriNKNyKCeBjrONm60Rzt3amcabThrHHb9PABv5c52puZY0a08kStjFkdJxM+mrJ4r3KUI4+u7Og9U1fxBrBz8Fy3FIo6wXhUryERhqhERuvZ8VDQgZV+EdbdC4YtQnunD3mGohn9VMcR2SLw0zQ5PUKlc2sYdeQ05AArjlhXfMjQCuil3I99WQ45dDhxwS/QuAjWXUYgM9YKnKgh1wtQF8HUMuEK1TgmU/3c65XehyBJP5lT3uIZuGAHGxd3OqTqQF4ZaomlCnNuF3t+eXIhct3UZiJpS0+0Wc0U
X-Forefront-PRVS: 0718908305
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjAzTUI1NTg7MjM6UWxuYmdPTGgwUXRFWVdZN3JWV0VnY0YxbmNk?=
 =?utf-8?B?R1E4L3ZvSm0wRlFBOE5IL0U4RFVkZkJjdVF2VVFRYi9NOXIyTEY4M1RuVE5V?=
 =?utf-8?B?Y2FwR3NPUVRYeXkrT1FEQmxXd3hsMzNsKzB2Rzl1SUprRWpZbnNjVDlNTmd4?=
 =?utf-8?B?dnNKWm1SVzBFbm9BZ3gzQ0kydE1OSGEvaTlTOVJ5M01GVEIwQVc4elc5ejFF?=
 =?utf-8?B?VlE1KzgwNERCQzhpL2RsSEI5Y0ZYZmJqSGYzcUVCOFAyMisxZGp0NW9makFM?=
 =?utf-8?B?aFRtWWhuK1NIa2pTSlZpQ2tSN2VGTzJKZWgxTEpFM25DTXN1MTFzZklVSHJI?=
 =?utf-8?B?UjgreFpBdFlQUDVuM0JtZnR0YlBDVVdQZk54YXVYT0RoTTdzcnZhOHQ3cUJ5?=
 =?utf-8?B?d2xOMlRYRmpla0hubmxmSks4Z2hkdDJ3TTF3UEtROVR5dzBwaUYrZGo1ZXMz?=
 =?utf-8?B?cHAzWXErMVRhbkJqQjRVSXJ0R2gzQnFOdGJURUxZR0JwdzVpK3ZOTGNhbkNC?=
 =?utf-8?B?d3V2aHE4b21jS3JQbURNckJzQndENmY1am1iOGYzMGtkeWsxTUF4dU5STXRU?=
 =?utf-8?B?R0lGa2dURUFKNjNkODF4cFFpMFp6a1BtMGtYL2lHZFRiMU1IaG9yYXdXNmI3?=
 =?utf-8?B?eWFBK3dwMUZjU08wZlR2TXl6S1pQbGxDZWEzTzBEbTdjTisvS25USXkwa3lj?=
 =?utf-8?B?dWM4YjNoMi9oZVVoa3dncmUrSE56RVZDZlRLRktFbitrMi9lWEtYcml4Mndp?=
 =?utf-8?B?UjR6azE5SWlXYnhpVFZUU253QmxpQmN3OXZoNElWNjVVRXpubjNyR1VlR3lH?=
 =?utf-8?B?RkdJQ045SmpIWWNWWm9KNnV2TGVqK2VPQ3pzRmY2a3kveXphWlNoOUFrZ2Jq?=
 =?utf-8?B?MkhCNkF6U0xlakNEbTBHdnRzTThrSlA1R2k5NlVJQ0o4RkxtcjR0TEJ4aG9O?=
 =?utf-8?B?RERpc3lUaGIxN3RRaHVZUDg0ZGkrYUlWdGNDbVNKbThlUU01QVVzNjBTQXI4?=
 =?utf-8?B?ZU8zTFhkc3BIRU1PL3pwNkc5SDBobEdvZllOZUdNY0Q3TUlvcTJuMzUvRVR1?=
 =?utf-8?B?M05URVJReEJsdVo1VGxFMnV3SGt1WStrMzB5ZmZWbWloOU5qajFzZk9vT3RK?=
 =?utf-8?B?WjNqODMrWGVCRTd0QTgxQ3BUVjNwZDE1Y0RkK2N1ckNyTTFEY3BKSmRJNVpu?=
 =?utf-8?B?RVIxUmVYalptZ3Rnd0JMQkE0ZWYzZVBXTGQrYVdzM0N5YkUxVVpOaktZa0h1?=
 =?utf-8?B?UTl0SWphaWFCeEFFSUF6ZzdQUUZySmhKUXdpck9nOXB4cFFDMDBHNUgraUxR?=
 =?utf-8?B?YWZvdW9YTnR1M1FqN05hTjNHMWhYbGxOa0ZsUVFyeVJYRVpqb2NHMklkMU1Y?=
 =?utf-8?B?MUdWMGx5NUJqbkhBNjh0dVM1UEhsamR5SHEwcVFKUlFaRUZpN0JIR0RpaDB5?=
 =?utf-8?B?VjZyOW8vOUlMekxtYkFqTFN3dFdBbHhVQXNVWHozclFDYlRQaldZcGRXKzl2?=
 =?utf-8?Q?Es0mCtcE4AWGYmbpRY0gncrULSTAbMWo0AMGOjJwKzWbi?=
X-Microsoft-Antispam-Message-Info: Rpkdp9/GyvsDmMaldQL4LszZezSmzGE9HkgpJcrZPc47Up06FkMLUXerFNiVXo6GdrOdTfOF/JrBpQb+HS1yZ8Ae+VVxZr+5eV5sAIMotW/D4ecifFHxPhPkeTLqYLtGPg0oZ58ORmLcpiPwziAi809pMuD6XH8Y3CDE+tdQm3r5a0MjZoBC5hcXwkLU8jE3GvjI9Y25A8hsOaoya6S5PD47wtp3ADaFK0+VBV/vaItYudosP8yVAnUupyKNKakrhMXy2JBMqG2RaZcTQ9j/AOTvdo4jqAs2gxcP29rg9/CYjCwo5fjJAD4Jo9iVT5ezTo90N5jkOEtsyAPHNR9i9+WpqTsrVjmjunPKj57rM6k=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB558;6:O/QXgAzVm1G5pJzyBSBTpW57xT4H6P9/xeLwK4S+QpgC0MfY9TRsU0QdBbNaJmlZUClMRSFhFhmZlMd5jzIi+W1FNg8Q59oaFjcr2bBnLkAUOhy26RWt5/SU3tSPkZp+wBjyH/CHCrbcDnNdfEuWscMn+ltaA0abk+2bbkm+qkYr7d7m5ToG3isNIOxudMWZ+N4cUCY+p5uokm4j0OikgI8mApdfH/AsVEd0zvXTg04c4PNhpsbe1ofhIocyh02ZfxWcRwX/RFDTL6SBX5wMcYckaIzzqISPfzDCypFShGH0vZ5OFAOTvchEyii6y3/FooLhuaGTLVsOyeL6en98pDilNVprycf537/XG1j20XqR6H2MQ81rReh97W97/Vjf+1Gj6V2YuccFlTTsW+E+qUo+UVBmsrs4OglXnMfIZ31lxOQEgDE2LHvpZ2mXmLlH6H6ukL7suw4N+W7m6nsp5g==;5:zwQQTkzxE2WS9YzwL5wg/IY8IKUlPQTMdut3QlAjo7P7sJsF/tZQmSWznKYiJBCIpe5BP067L4oZRT0bnVsHy9OzxQJZuYJMCXd0lEuS6e1LeUf6O2nak3OUeTKr4MGhRceNHZNQGzz/w2ctlDSjNrkHs5vmivOnXX2bDa95H+I=;24:CNqn+++oNjD/QOu4kB3k30tBgtpwGqD+imyQBhnYTBy7MIKVErAP33m+voq2MWansvpHtilEh8xdjQus5mcDwKpDIhBcJ2rmzfjzLgdrco0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB558;7:amWZH3nCNd24zk54GHILpfgfEfRPQSPeFHEWq+3A4GqBS7OIqdc5AprmK9yjswRXKct/PTvZ80bNiNjUzYdiIgZ7xxZ1q2P3AKYkCnwkKuyEIBEd7YGng8pXaFKF7e3H0kpTF2DB4Fu9o+LBAngc6A3pSi4fNvR75qs7y9pNl29fUC9eb2UTO+IOoBHjTHxvIXFs4IEP30vXQL9CYTOYUS8DNIdp0PWb4na80DBuSPtK64aWzWdEN4Sprr0tnwdb
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 08:39:30.3794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1266113-d3cc-4440-daff-08d5dd9bd4ee
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
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
index 0000000..797df9b
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
+	ad5758@0 {
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

