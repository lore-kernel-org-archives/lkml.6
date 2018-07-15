Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CE8ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 19:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC31C20882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 19:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="f1WZmCLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC31C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeGOUNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:13:00 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:6016
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726910AbeGOUNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGD0RImV8v7GqUw73TvUQ17onR7J0fiTUuu/rG6YgwI=;
 b=f1WZmCLEwRbDGrr5zvG1c5Qc5o9b0q8rjdL3tRkxNlBw77C7oPDcz01XVeA0b2BwqmFmX25frgsosdjftaev9uuHVlFLCehoUbOjw2hPGGKXe6t4UnlnkRF/PNn6t+CxPIVF/V3eT/mZdElhJQ6sq1RS8Kj9WoVRdhqUhVEP+Kc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=danielj@mellanox.com; 
Received: from [192.168.2.114] (70.112.170.246) by
 DB6PR0501MB2261.eurprd05.prod.outlook.com (2603:10a6:4:4c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Sun, 15 Jul 2018 19:48:52 +0000
Subject: Re: [PATCH] IB/mlx5: avoid binding a new mpi unit to the same devices
 repeatedly
To:     Or Gerlitz <gerlitz.or@gmail.com>,
        Parav Pandit <parav@mellanox.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, gerald.gibson@oracle.com,
        Qing Huang <qing.huang@oracle.com>
References: <20180713235021.18141-1-qing.huang@oracle.com>
 <CAJ3xEMi5zF83aA_SWfYT+JtWGGhqRhLyTKe-qYwevSBLuiK=cA@mail.gmail.com>
From:   Daniel Jurgens <danielj@mellanox.com>
Message-ID: <dc4d502c-bc3c-46e3-a984-41271951a5f7@mellanox.com>
Date:   Sun, 15 Jul 2018 14:48:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJ3xEMi5zF83aA_SWfYT+JtWGGhqRhLyTKe-qYwevSBLuiK=cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.170.246]
X-ClientProxiedBy: BN6PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:404:f5::19) To DB6PR0501MB2261.eurprd05.prod.outlook.com
 (2603:10a6:4:4c::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36d6148d-2f54-4ada-a0b5-08d5ea8bfef0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2261;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2261;3:wnhgEI0mhp/F35RvNVQz9dRoEmN6SA/XLiRgR7siA8B87EXT6AXhWUgNexAhgnmTWyOzIDMjUUVGiGaRgDaOwmT5fopm3k7EVcIGM162NMLLrhmvMrHxsY8odHNDzWCJFKUg8Gc1hXUiJ563fuYqqmTKX6qx4QW6Z8TZ58UWW0jAhSPxfIQVx80c4PNBWqxHhgSXlNClaG+MsuFolb49i5wXLD1UfhjRdGWi2f/yV9/IoRNRvQdXX5h/EXsce5dG;25:YCNE8tsMPFtR6u2VAtqsSsy+QYbPEXMeMx3G4kFyXOOj3nnGU3k30Or0ep7hDufQ1GGxFH/kCz/RHdc57qRvKp4LYaPVmkwHpIqyRMrAiXR+ew29iwYLjQtR6nbLigfHMRvpWr6JC+xPDY+fAke04RpiXoOPxHCIC0CwUNKgWUTx7nQQWVJybvX+Cx9GlaXLfIw0dyHnptOqX8Amd7/bcnDU7ZyYgM9SMORVGvWYbfF2aI1TYOQhqnTQxatPoTzfxXSjecAal0nivILh+lp2eQUGY5Dj1yWdnu46voYzqT03lKmxKk5QktQ/MPlrtFIFgkEgq0f/1j8XF6OVXgVu0A==;31:wyZu97Xbx9SI14RJm4UF/7e82MpygqtJFp+n/MfrxhxkEHeeGBBGGIodjZ54OvI/MugQvuAFeixOkE4KXNS35WcVOrI+Q/MFM5hf5E7V7Z+Rr/9VoqDaw5EGJsZL0DU/WTeLNiv583Sfls3qxDXbyDv9NPrWu+5B5gQq0CQZ1IPTbXHWPKRU5rYSV5gNOYS/e0dVfA/HpdNryYe/u8scD695ZezCo0WNHsCFEJLGkx0=
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2261:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2261;20:tx7LqmMZm5Y5Y5uZ6/V/AJ//kcoja2dc4Ae0hu7Y1ALaUz7GCsdQct1y+jznbB8h/t9vyn/+Ik2AtKmk9C3MRIffkTiTAYbhKstfAaOSs1Q+RHOlTuZPVjBQR5+6mMWMoGZZxDMWDNRqV0/USrMTkvwDL/aqI6ImGEXc+A7knpWz0MnhG29b++oyffYeNNbogDr0r20OHWp7Pa62CDqNks4eGG+N6p1MeZZg1+LoZYM8gRD4ZtsUtw7JrDtzUL0+KOzQ5MsXsv0ytyQVlXEekrSsmwT37nAjGD7FCHstIza5jMIsHP3mXB4TTnE3P+gcXSgs/UnCK+Uwhha0nH8vpxAhBWi2HciFHVZEjySl/vcihX4ki7A7RCqMcNrDA40Gvy7EoPVblH41N2j1vkmJX8qrDkvmPTfuntOArwVxuqCcIzaP+HDh66CDDogEfOab20TL7GrS6Y5IKLfaEsTZtLrfunQGJIhtqbPcB6hXowQc8RFop80IX6xqZvKgAptJ;4:5tNQy06FPSg1gOxpd0QBmayvJ4l7n6tHpcIrdohnBy0VhS96hvyjCDfVyzK0yxWtY0DBmP0cb/IUQGiyCcCPdRgnQyfJFsG/tb3axspcURlAeJ1L4CCQ3Ay37aHkwZh74Xgy3ZDoNdxnspuKpouREMNlt1X8TI7SjYImGI+tIa8CvpuGN6M8/jH9E9LzJnavHGpy7D/hRnXySPPG18RLC7c7g2QupKCYJcjY3S2X1+OfwwIZvyloYz7PGcm7YP1596yLBgajK8bemRTh/CvgLHkbfR2OlXxXUwInb2odbde5S+VMgEADok/7PR9TP/bM4kXcYbTKvBgPpdOFcL8QO9taI370dG6E1pMddrp1nDI=
X-Microsoft-Antispam-PRVS: <DB6PR0501MB2261B1F49E0F7CD2A30AB46EC45E0@DB6PR0501MB2261.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0501MB2261;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2261;
X-Forefront-PRVS: 07349BFAD2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(396003)(39860400002)(366004)(346002)(376002)(189003)(199004)(6246003)(58126008)(64126003)(478600001)(97736004)(316002)(14444005)(77096007)(966005)(186003)(47776003)(53936002)(26005)(50466002)(66066001)(6486002)(105586002)(65956001)(65806001)(31686004)(16576012)(16526019)(110136005)(229853002)(54906003)(117156002)(106356001)(36756003)(3260700006)(3846002)(6116002)(386003)(25786009)(486006)(6636002)(6666003)(65826007)(230700001)(23676004)(305945005)(6306002)(5660300001)(7736002)(76176011)(52146003)(52116002)(2486003)(53546011)(39060400002)(2906002)(446003)(11346002)(956004)(68736007)(86362001)(81166006)(81156014)(8676002)(476003)(8936002)(4326008)(2616005)(31696002)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2261;H:[192.168.2.114];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1MDFNQjIyNjE7MjM6dWtvQ0lXc0p6ZTEyZzlCQVFZeEF0REdP?=
 =?utf-8?B?ZnlUaG5NNUtLejhhWUk5cnkrcXRoU01WeUhxc3d0RkRjQ2pBeTREdU5WUGcz?=
 =?utf-8?B?UlBuZlJiMld2bkhWWG5WN1RHUnhpNU9rV1pQKzBMMlRHb3dXY25BM2xXQ3Jl?=
 =?utf-8?B?RG5Nc2Z5dHBKc0xETlpSSldnenlRaHloeDNnWHFoOUxiYWIzZWdCMjlaV2ZE?=
 =?utf-8?B?QjQ0bDMrRWhCUjlaNlYxZ2Jqbmp3Z3R4cHZYeDZkMnhLTnJLaGNNbk1CT0I5?=
 =?utf-8?B?TlIvMTVIZU50cHhOM2duZkJlam40SlpRcStaT05pY0xoUTY1dEh6VW96WVVD?=
 =?utf-8?B?cXhwSnQyaTZOK1dGWUprUklOQkRGTVpvRG8wQUFQWmV1MTUvalJxMVhSVTQ0?=
 =?utf-8?B?RDFJTTg1eEF1KzhXdTA2TU1ZSHVncVlwNGh1R0tWdFZxTFdiY0pXd3NqRlhV?=
 =?utf-8?B?Rm5YLzVmS3I2N05FSkc3aVlCZ3NrSzExbGpwek5DMk5jb3k0b2dsNGsxYzR3?=
 =?utf-8?B?SFpvOFJaK002Z0VBekNkZDgrY2ZadWZlTHZPVFEyQzlKLzd4dVRPcWVWbTFL?=
 =?utf-8?B?ZjI0MzZTL28rVnBVakpJR1hpV2RrbjZYS0xkY3Z5L0wzcGRiZVR1U1VBaTVu?=
 =?utf-8?B?Qk1tQXl1bWlyNzlEZUMxY1FCdHA2SThCSlE5NG5sa21EZjBOUzhURytHT0JZ?=
 =?utf-8?B?QWpWWVhnMS9pSHlzelZIVWYyeGg2TnZYN2RRL2NVcTZKcTdOZlJ3SkhTMkVh?=
 =?utf-8?B?eUlvRnFmY1VJVXM1TU02U3QxR0RxazkzUGpGVytHSitXaEVHOEFxTXR1SGV4?=
 =?utf-8?B?ZEVyZnZ1YWkzekhQY1ZEWkRIcHNKeFhxSlUya1Y3dHZvZi9nZ0Rac29lcC9T?=
 =?utf-8?B?QjN5T1lDQzBDZy9kWGpFV0NidGdlVTZpb2JUVllWZXJFUEVQUmVCTVIvWTZB?=
 =?utf-8?B?b3ZxNFoydGlZcW5TSXRQakhVTVNDWnhOUE9NdXYvN241QmVWeDk0ejBBUzZ3?=
 =?utf-8?B?ZkJ3RTJIeDUwU2l1ZnJyeGRCeTFXUno2KzdOSTdSSENCUkUrT216OWtEVi80?=
 =?utf-8?B?Z3ZhOG9mWGszUjdlb05FemFGLzFEWDQ0RTF1M2ZDTW02aXVERTQvQm8yMjRX?=
 =?utf-8?B?bE9mZUx6eXMwRy9ETjgxSFJUcVkvK2VTRHNKbnRhZkZrM1pmTENZNDBjK3F0?=
 =?utf-8?B?SDJxY2piVzJ4VTUvZDNtcHdEbDI5Y3lSVzQ0bVYyd3lnWGE2SkpvZW5lbkta?=
 =?utf-8?B?UUtXWjd4Tkt5QUNmbVBaUlhTNU04MUtuYVFvY3A3ZVk2QytNRnBSTEcxdVpq?=
 =?utf-8?B?MDdhbmF2RnY0MHFiYzkxL0NtbWdUWW9wbHJ3RFhLTS9DNjFtMGszOW04ZnBy?=
 =?utf-8?B?K1VXeXEwUVZ0N1FZWFdrc2xFdDg3eTY3ZFRMNjZ0S3FqQ1pJNlN3NHcya1lo?=
 =?utf-8?B?Slp3dXJmMnB6S3VZVk5ZVnNxZWNJWCtNbW5NM1NxSlVtNitOWTVTODFTSldX?=
 =?utf-8?B?dmZZUHZjZjJKTVZTVXE1UVk1MkNEQU81blJaazNXem5tZ1lQQkIxeExTK0xZ?=
 =?utf-8?B?OGJ4c1djTm41UGJhckplNDhhSHdjYUxvc0s5RktleGgxMm0xUERld2c2Q2V6?=
 =?utf-8?B?TzN1aFdaK1dURnIrbWxNVGVxTDI4THdzdm4zL3YxdDNpdnFFMEptbDJHT2lh?=
 =?utf-8?B?anA3bE9aSnVoRlF0ZmdobjRDVlFYMHp1bUtGWkxxY2JyaUxDQ0lpWkh1Wjh1?=
 =?utf-8?B?bmFKdXJNdEo5U3ZjSldpYjJjWng5MWNUZ0tOZ210cHNjeTdmZU5EOHBRQmxN?=
 =?utf-8?B?TTRuZnpDYWdKb21sU1dvcW9BTG5tdFYvYmRaa2s3WEs0WmFINTREZDhHZWdL?=
 =?utf-8?B?U2NnZjBQZnNubUdsYTAxbWwrQ2xyN0pPYzhWNUVuWEpNc01lVzYzMnl5cnNO?=
 =?utf-8?B?TnpIdEhsTzZnaDhOOHVhZUkwN1FrdUd3aU1zazR4QWpxNTVkaXNFQ01sZlRx?=
 =?utf-8?B?a0Nlalg2ZkNhS0dkM091VVJjMGtPTGFnUTFGdFAvZWhtdDVjKzAxc1JEc0lV?=
 =?utf-8?B?TnNXYk1TNXN4V2RMc3MvZnh6L2MreEZ4T3cyUTVqMkhJQWMyMjlJay81UU16?=
 =?utf-8?Q?updpzABKoitC/o5Cpg1RWSMnH9GkyGQTWqoU7QLQAGc94N?=
X-Microsoft-Antispam-Message-Info: 38O41coK/0j8gb1RwZHPuMGwFjJ1V4Sr9x+OA8b+4cF9WK+yuGMDz51iy571OvOTFIOqaoUgnTOHCS+ta/tp+gZzsJCXbCbH9wkihOATnYIItU2UBOVNQFR7gCpFyQH+uz8VY73fpHVsLQ7n+aGg10kcMkpeHCxccXIyV1HpVh86mI+QlBMwc5CYcvG0SiAZyWJBnR++nItgA7fL4MpYNriNFimCavuH3AtxklKO7G4yZDVJaDQAZ1opJIeFda6+UQLkj+PZVurkMC0thYsmc4YHjkWFgX4qI03cBSm+XGOVAib44CjsXV0qQmn+5b/1pvNm4Ai8/eKn/T2EqGUQv3p1n/ykGwM3vXE1iLynJ9c=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2261;6:WKc1BfswqchPj3mS4ciF3aggxT5Y0ScVoqAvXtMT2Nl0RH5zV6Ckus0YlZoSrFd1+w/1jr+7F4XmmC7VZPpOtrlXtEJZ/m/mfbLUiDiNuNV+G506ftTEIoAIZPmLzswGlDV714PndJLUM0s3tX3fj+gAnTyhIT/kqXUFaikRht9DGD6BfRIvKLVzF2EfpWv6IEKm+MZBUArZHysHsmpiFxVTC1XhcAvb4nB7Q5HW2WEfwx0NXpRva1+IsoMqvXydNB7VfzE3EoCcSOOrj9VfchxUyLT7Ws6Wr0nz5NdnKLH9bLMKZwF2GP8kS5z55PPPzjwMhN+ocLoACwbpcsrc7Z823BBVt+OeC49tfra525khWOqxd1ojBLJeIpwEPa3qaAFBhNGqWJtYsbdQgR4YrUWsC3gqMqwVBFTAY8MEh09fxOr0cyCswJDV+7b0G9zS7gIG2Ugwd5y7HatHplgZ4Q==;5:yWaXm6r9Bjg/Q2xr03OdYKVTGq4mgsvdSODdzVUylmXzxJGiSvb5/dD4mrU+1xgH1BkoUew7IzAeK5MYR4n8zXsmS2CsCDzwVPRGoXS516VTmGeqWTy71QtAt4KzPSCeeNhPtuLfcCFp9jOIadPi+T9g/AdZJW36eg9Ri72RuKU=;24:HBCBA7+uygsvm9cyf0BXItTSmRTn/IFndbpQbNHTnneFcE/LyqdglbUVwBG7EkV6K6M1cVX81Mf/Rk8Vq1GnJI8wa0EFAnVrE4lZG2nsMFA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2261;7:lyD53pKb19dfILvj4HwuZLp7RIWiOzNX0qfkZIM/435peEIAaZ8aWt86a0Et0TRiSAFQVlwL4wZD5EnPE6pZ4UUz+74OPQUhbpH1OFIwgadHTOypprcukoqk4afBb7EuNFs48kKls5/pmw3LA30LX4xJEqx5P0n8AtbgwZE6b0C9qYJqyo3rEc2COj2Jw84f5Ibbt7i7AoW3xcInfEjHXOhUaJsrMcZsOhcL7SYy0ITslUbE2FoVtjU2eiCC2XlQ
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2018 19:48:52.3234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d6148d-2f54-4ada-a0b5-08d5ea8bfef0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/2018 10:57 AM, Or Gerlitz wrote:
> On Sat, Jul 14, 2018 at 2:50 AM, Qing Huang <qing.huang@oracle.com> wrote:
>> When a CX5 device is configured in dual-port RoCE mode, after creating
>> many VFs against port 1, creating the same number of VFs against port 2
>> will flood kernel/syslog with something like
>> "mlx5_*:mlx5_ib_bind_slave_port:4266:(pid 5269): port 2 already
>> affiliated."
>>
>> So basically, when traversing mlx5_ib_dev_list, mlx5_ib_add_slave_port()
>> shouldn't repeatedly attempt to bind the new mpi data unit to every device
>> on the list until it finds an unbound device.
> Daniel,
>
> What is mpi data unit?
It's a structure to keep track affiliated port info in dual port RoCE mode, mpi meaning multi-port info. Parav can review this it my absence, otherwise I can take a closer look when I return to the office.
>
> Or.
>
>> Reported-by: Gerald Gibson <gerald.gibson@oracle.com>
>> Signed-off-by: Qing Huang <qing.huang@oracle.com>
>> ---
>>  drivers/infiniband/hw/mlx5/main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
>> index b3ba9a2..1ddd1d3 100644
>> --- a/drivers/infiniband/hw/mlx5/main.c
>> +++ b/drivers/infiniband/hw/mlx5/main.c
>> @@ -6068,7 +6068,8 @@ static void *mlx5_ib_add_slave_port(struct mlx5_core_dev *mdev, u8 port_num)
>>
>>         mutex_lock(&mlx5_ib_multiport_mutex);
>>         list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
>> -               if (dev->sys_image_guid == mpi->sys_image_guid)
>> +               if (dev->sys_image_guid == mpi->sys_image_guid &&
>> +                   !dev->port[mlx5_core_native_port_num(mdev) - 1].mp.mpi)
>>                         bound = mlx5_ib_bind_slave_port(dev, mpi);
>>
>>                 if (bound) {
>> --
>> 2.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

