Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290DAC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB8920882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB8920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeILRS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:18:56 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:59568
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbeILRSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFA5kJUtymI6BOnoXZUwJ9av773ySnkSXc8mKRPYxCI=;
 b=kKPJLJykErfmBXPOtBvtp66ijO7t8YezwSn6iAYIulW3YD0S1G2uUvCQVlIwa4+LI7qXENUDSMrI1DBSTfDvu7U8XL7VjyXSkvzIIK36Nrp+HtxUKis7Y6mgIBwL6mBrbS7gRjSoVCfFrHhpUxb6S2mIWkoT8S/XoQ8HYPPu5z0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
Received: from [10.8.2.103] (193.47.165.251) by
 VI1PR05MB3262.eurprd05.prod.outlook.com (2603:10a6:802:1c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Wed, 12 Sep 2018 12:14:33 +0000
Subject: Re: [PATCH] net: ethernet: Use DIV_ROUND_UP instead of reimplementing
 its function
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net,
        claudiu.manoil@nxp.com, saeedm@mellanox.com,
        derek.chickles@caviumnetworks.com
Cc:     leon@kernel.org, jdmason@kudzu.us, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536671295-14432-1-git-send-email-zhongjiang@huawei.com>
From:   Tariq Toukan <tariqt@mellanox.com>
Message-ID: <decfef92-d22a-a56e-6805-369a0eda07ad@mellanox.com>
Date:   Wed, 12 Sep 2018 15:14:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536671295-14432-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: VI1PR08CA0212.eurprd08.prod.outlook.com
 (2603:10a6:802:15::21) To VI1PR05MB3262.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe4f8670-1f0d-429b-2dfc-08d618a94d69
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB3262;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;3:lyp54u333EAiln/3ly8RaJkC7fJfnAZrC/m/WRXHpO5YT6Ry1Q35Pq4HlfFswKaQpywUspyEFTCOW9YQCT+BP3s+Dm0dDrhqUFgpzwaCvUi/G9B2p4v09pA6noKLSpP78GdT/7tuKCinms9PkOkdJFrUYlJtK898H29XM5KWNWI4XX6D+hyyN25SUJ4jCOqEKOfDQAuOhyExvPdHPvQdVbSKMJ9QZypIxg8rrlSreh0e03qkKXhGn/kHH1nZZ5Ru;25:uF45Bgv4uqJsO5WQRbT0xyj++zv50YOFA4qx3ogaiZAK/CHWE7VxVBwcVpzzwq7yPEjY5R9ILHRNIoua4cfm9yaSAQ6XtdCqGwJ5TohTPGfRCrVcaa0tQn1ZX0NjZ9Bsv4AYQKLi8juxnR6OItqF1e2gTrx3pimwi2OKvoRP5IvwLnoOMPEbZyfygJ90GtpF3gxCE4nm8KvtXyKSDjp5Ji73b99GiOqap4FqQTmnQfMXD3FYs2R0S+LuX6G9HLTJAow4UvLNSyLSXgENk1XDdRiC/tAt4rXMn8VsKKWsjL/6lEBrt+ruv7/vDVKVTD+BAZetiajmvf5G44lxP0do8Q==;31:UmYnYjBUbPvnVMVyXJKA/xnDkDslbR4uL0vRRKZ5UdFPpuZjAUtmFfdjxUnHFSOCez2wqYi2U06vLRfneXqG1WvaEdmkI8liAEr+on5Z+6JdfmmioaElIhmCyotilWpdz6joEawG1YCzx9B5L3gPuTR6uOVK1qn9EF+NKWNZnRReyau6+TGCw/nsI81MV8bp/MHWYfrycz3KcXlxLzGFT9Ev7dkpiIBG33bX1DgPVew=
X-MS-TrafficTypeDiagnostic: VI1PR05MB3262:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;20:RPkvhV5YnN4QLIbKr2tndRsKSHS2WBFernDl92GDvPrBdlHe4ktiVJWemcrVmWMs0v8AFQtDeJp4vt2imIke1SuibOskLnQj2/gaLQNbsjROOInSLXOYkdYWGMaYTiBpJiQJfdkI1S/rpia2gPDwSftO+c6BRbsNYnaC2n8TO5cFPCz3Xb7wlRkEHpV3mJY7VuEKt48ty1tkEs9gOIH2O21hrUIbbnoGX2PSTnk9f3MGx3J7JWajbp6Yr2Nm52sq275clwSolHPS2v5YOuC952VFEskK5FdcDB6tUj44CvcbFk/Tw3JcgldmCwb2j7S3AOyvKCCGo2YwnLTiCD0BIev59EQKP6Ol2frpVgl1A8WUnIv5ziRorTrV/ki4Nk8YiJWiuHMFokNIo9EdGljKsGq6axZHT0Vg9rITn74rrNyNuN5CUTmPDAD/cXWcdQoVwHSaVr8DezosIhvBKpgP/yiDvycgzkXwJQalWfr15e6b784E+9DF/Xfmp0Qlukv+;4:OPXSOquE1koKxuwaEsu6AuzF56KKVHcM1Eb+UF2FAXkOrX8UScksyV/vnNt/iUIvboxxfktCjDezUCv65JBnXVpW6GpaIUv9zTkXMkN+I5O0hIH+vhNN8rQYDIayRNJwYXpMZf5iXWuUIe/YRl+JDRSFc71VqikZFB76jO/yi/OJIiGz7xw858IgGwmuU1kdN51hH7fRNr8Ny5oe9ZWTu0Q7TWvuMd/OVMFyJN3DG14PPY+BXLxjErW8N9TAGY+fwHh+FZr9Djng8n5eleSe9vBP6bRUc4LmLv26zvSXF3pZSn9gHpsZ8C55wYm4uHNMreKOe33za46Pak1zLY6MVS0Ql9uyBGQiKJhGwI8irr0=
X-Microsoft-Antispam-PRVS: <VI1PR05MB3262586F3228BEAB3C5F4830AE1B0@VI1PR05MB3262.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231344)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR05MB3262;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB3262;
X-Forefront-PRVS: 07935ACF08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(189003)(58126008)(16576012)(316002)(50466002)(76176011)(67846002)(2486003)(52146003)(23676004)(52116002)(65826007)(6666003)(36756003)(5660300001)(230700001)(97736004)(478600001)(3846002)(6116002)(64126003)(7736002)(305945005)(66066001)(65956001)(65806001)(47776003)(8676002)(105586002)(2906002)(31686004)(229853002)(31696002)(106356001)(81156014)(81166006)(446003)(11346002)(486006)(956004)(2616005)(476003)(25786009)(8936002)(186003)(386003)(6246003)(53546011)(4326008)(26005)(6486002)(77096007)(16526019)(86362001)(53936002)(68736007)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3262;H:[10.8.2.103];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1TUIzMjYyOzIzOmxtbE1XTkNoRDYvNjJlcDNCQVdDSExmYVlM?=
 =?utf-8?B?RDIrYjlkK01Ua1FHcmNxakswaTVybGFBTzExWUlBY3dZdGJnQmQ5dXRsYmg1?=
 =?utf-8?B?YWFEcm1NZ3I0UjRTQUlYOGlaSEdRc0pRWUZCSHhzTk9qckZLUkw3OXZHSXo1?=
 =?utf-8?B?ZGFRZWYwUU9qVlJMZ2FBK0IzYkZKNEx5VVNwcWx3UkN3TU85aTRkQlhtdmhn?=
 =?utf-8?B?SVQ5TjZtaU8yanF0QU5KbmRIZWVoYlA4VEt4WlJFaURNWlBRaHhvSlZ0N0ZM?=
 =?utf-8?B?VURYdzBMMzlJTVhrdE8xTW5TYzExTDV6UEpkWmpSQjN0aXlPNzdvUmsxcDZl?=
 =?utf-8?B?cnQ1OU5hcCtMb3VkcEp4cGJxb0pwbmMvVG15K2lkWTN2M2dRRkRlK0w4a0Vn?=
 =?utf-8?B?WnhLcHY1UUhxMWliVnI2YTd4OUNlZGVmdFo2bkFEV1hjeVl1Z1pRclV5RUhv?=
 =?utf-8?B?a2dYL0VSa2swZ0tyYWFJOHdhTXR2RVo0OWRrdHpjRXg0UU1sK0pJYjRGcUZW?=
 =?utf-8?B?WklZUDZ6UlhJM1RVbitFOHRVcXV5ZDVUUTJ2bVkva3JjS1UyTDJRVlE1d2FJ?=
 =?utf-8?B?enpOdWZ0QWVaekQ2TVdFeEJqbm1XOG1GeDZRYjlvNTZSb2N2MjR6d0dtdm9P?=
 =?utf-8?B?MXEyYVM1bW9kODF0Q1g5Ym5ZaXNqRTdVd0xXd25jbG1BeHo0YU1VMnlLalIw?=
 =?utf-8?B?N1dzRGxEVlRIOStscjZ0MkJISlJUcm1hQjlzRjgvaVZSazFYYXp5VzRxaDQy?=
 =?utf-8?B?NW1DUys0dzFLTVN3ekFHWEVDeDd6K1VEUTdMQ3l3ZHk1Vi9CekdYZ2hvQXNr?=
 =?utf-8?B?UU4wSlJub1BvZkdzZy9kSkZoWlpnY3Yza0t1dFl0L3RDVlNKYmFldi8xdE1N?=
 =?utf-8?B?RWo4blF5YnVqbFZyaEFpN251VGtiblp5RjFXdmdCWWRicFZQWWs3UFNmSlJk?=
 =?utf-8?B?alJYR2xzMHMreGRZSitIUWdXYTVKYlNVMFgxOW9SaE45bUpEZEhzYmc4THkw?=
 =?utf-8?B?c0ozVGRzekxqbE0wMDlTK21PUzlWbkw5d29xMFJIS0s0WSsrNjdqWHpacUV1?=
 =?utf-8?B?YVMrV3RJVEVIOVp3UHVma3ltcURnYlQzdmZrT2tEQ1Nud1pDNFFJNlFqT1dj?=
 =?utf-8?B?anNUdWJnWlpUb01CaHlIN2czV28xUGYyT0NhMktpanAvZEJ5bTJKaHpnRjNm?=
 =?utf-8?B?ZHo0Wnc0UFNVM2poOTBaZjJaQm1YdjRwaVMyckwxNjVIbVk2NGpNVVZ6aFVa?=
 =?utf-8?B?ZGFYQVpmeDRPckxWV2pORTFJb0lqbGRDNm1tNlFNcm5oY0UyRVpDcXFucTd6?=
 =?utf-8?B?Zy9vY3l0by9QN1JKOS90aE5kOVpmQXpWYldhUHpqcmttZldUNFZiTFg4allQ?=
 =?utf-8?B?TlpWcWFiYzFpUndFOE5LdUpwSlB4a3Z1QVo2QkJIMndWanJsR1JMZ3UvcHIx?=
 =?utf-8?B?aExlc1N3a01TS1hyRlJDLzBIbHpueHBxV3hiVUtjUW9xU2s2OTlVTHFYVEQv?=
 =?utf-8?B?cWJ0RitpRy9GYnNUK29NL0UwM0hPODlmM0Faajd5NUVlUS9DKzVYU3M3NHhj?=
 =?utf-8?B?NXpab08xbFF6ZVprSWt1T3B1NytxMEl2M1FuclJ3ZzludVN3eDhDakV0MWtX?=
 =?utf-8?B?VDc5VUdtdDIxaW9LaFd1TGxNeno3YkhZTHVQcFJobm5iV3MyYTNNRVFYVytD?=
 =?utf-8?B?elhXRWxMSCsyeTVsQm1lTWRRNDUyamdxZmR0ODhuY0U2Zk4vaCtlM0lqc2Fp?=
 =?utf-8?B?bUg4RkdzazhaUmw5RURXMUFhU3hralNlVnZLYXRxSlBPTElNOTlvQkNhYzZK?=
 =?utf-8?B?dnl4ZWlLVGZxMFMvbHNMK1Zhb054QmY0MkRMZXl4UnpiYnhMMDVHbEcwQXNs?=
 =?utf-8?B?ZVRzRm5na0FHVTVnNmxsQ1IxLzVoTzJhdDBBYkFIV0oyZU5CZ3BrR3JLR2RG?=
 =?utf-8?B?NDc4N2l2RVBnPT0=?=
X-Microsoft-Antispam-Message-Info: QniRgNbsA8A+6sv1jThgiLxCtH7DQPJw7O8tyhmj4vpthTu65hSLFkdbZcJV+XshhIS+Qej8XGPMymkNCL6bDgY9OGoASbQDyS5pRPJrNbFsJ+G/2XKyRpIKv9+UT/CS908fzi20EUOHAx239DIruro5oDCDPF78YbpNizChfo80kXLnCHGytGEdUymAdf9tga7iQZs3cMnnfG9QCDSbp1lVOeLRsCO6gljI7oNtSOxqBp+XTQbQDXfnbHjb8Pmt7Qk40Sf8FCITnAjN4icBf11CPSY8GHsR1WIglaO1zXkaI14wwUWj0HSTjZbx8NiLU3fVCDsH5IgwYjKU+e3BhnipkWIoRuRXGKzda9ICs+4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;6:QfpL7kzEa8m+vvQb+zLCTDEHP3qVmQiuNwnfecl+Y8m0y+8qruitVyr6EJ7PafFO6w+UqIe5c/q2TAR9NqrQ1AfeBdiaKyC34KwKlqBMtgKoxOLx0PlFxplSnvXbgn6TXJ//fbx5ZNBACz4oZgOB6Rta8z0zAtTTaMwzk+ZY2j+74zeGIHbYZgaZjilu6e/T2QagMpIb/ZOUHe1JGzmoqFVUaE/bVsVHsvkMFizJqRalv3Dzf99jfXvj02RNiyMcICbe+wsNzaPxt9U7OKFwcmgneJ4GDN3g2mHChxUmVPAS+HLjVaGP9TFrlFDWq2bFzUIivcMHcIS6l+f4HGK8l5XRDcvx+D6+Rw2U5pbO99YOO+bpJjf96Lok4Ajq+HSxywsPokEOIgK8U2JUNPwSSR3eEdEtPsriAO3Q5wyqDs+RDihbbt5yNlZ8oiG9YfiA4if7XmW+z8UfVc3e/z696A==;5:H0CtzN5YNrYLyKENYScu0nasQzxJ+qNC34ypewuNh4xToiak7/DaICtRoDJ41xBk+9iPY+XJXLG/b3Owy/GnjIIeausufF3R1WUYeNL1qDwNTlwCVXLIkbFNdzPLQAJeDhaDY8FPfl0khFPTnaWqkleNQ7ZNELNPLPCt90GL9Po=;7:XQcaAjAgmB6RMmHjU68Y+J+CS9PXttWFQfn+pZaGVlSh52wTbKnDCQ1Vd3bXpOYJMlrh6c1BX+SKIqE3BTJdBUjfe3lqNBwcUuqw1PjVV6H5uGEY/fc7Sdwk5BzQb6yJdIm1GdzKvf/v42Al1wCEs1rZyZO9h+8bNKE1IMIEPkW/i6L8SlDwKhhszD8ELUBnw+/kBPjCVmtv3RrJgl4k1mHhUYCHYDx+tbUJGYsvsd3bZMUrwe97sfGKJ88j/6mM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 12:14:33.6444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4f8670-1f0d-429b-2dfc-08d618a94d69
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/2018 4:08 PM, zhong jiang wrote:
> DIV_ROUND_UP has implemented the code-opened function. Therefore, just
> replace the implementation with DIV_ROUND_UP.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>   drivers/net/ethernet/broadcom/sb1250-mac.c         | 2 +-
>   drivers/net/ethernet/cavium/liquidio/octeon_droq.c | 2 +-
>   drivers/net/ethernet/freescale/gianfar_ethtool.c   | 2 +-
>   drivers/net/ethernet/ibm/emac/mal.h                | 2 +-
>   drivers/net/ethernet/mellanox/mlx4/alloc.c         | 2 +-
>   drivers/net/ethernet/mellanox/mlx4/icm.c           | 2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/srq.c      | 2 +-
>   drivers/net/ethernet/neterion/s2io.c               | 2 +-
>   8 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
> index ef4a0c3..1082529 100644
> --- a/drivers/net/ethernet/broadcom/sb1250-mac.c
> +++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
> @@ -156,7 +156,7 @@ enum sbmac_state {
>   			  (d)->sbdma_dscrtable : (d)->f+1)
>   
>   
> -#define NUMCACHEBLKS(x) (((x)+SMP_CACHE_BYTES-1)/SMP_CACHE_BYTES)
> +#define NUMCACHEBLKS(x) DIV_ROUND_UP(x, SMP_CACHE_BYTES)
>   
>   #define SBMAC_MAX_TXDESCR	256
>   #define SBMAC_MAX_RXDESCR	256
> diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
> index a71dbb7..b57008d 100644
> --- a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
> +++ b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
> @@ -530,7 +530,7 @@ void octeon_droq_check_oom(struct octeon_droq *droq)
>   static inline u32
>   octeon_droq_get_bufcount(u32 buf_size, u32 total_len)
>   {
> -	return ((total_len + buf_size - 1) / buf_size);
> +	return DIV_ROUND_UP(total_len, buf_size);
>   }
>   
>   static int
> diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
> index 395a526..b536eb0 100644
> --- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
> +++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
> @@ -230,7 +230,7 @@ static unsigned int gfar_usecs2ticks(struct gfar_private *priv,
>   
>   	/* Make sure we return a number greater than 0
>   	 * if usecs > 0 */
> -	return (usecs * 1000 + count - 1) / count;
> +	return DIV_ROUND_UP(usecs * 1000, count);
>   }
>   
>   /* Convert ethernet clock ticks to microseconds */
> diff --git a/drivers/net/ethernet/ibm/emac/mal.h b/drivers/net/ethernet/ibm/emac/mal.h
> index eeade2e..e4c20f0 100644
> --- a/drivers/net/ethernet/ibm/emac/mal.h
> +++ b/drivers/net/ethernet/ibm/emac/mal.h
> @@ -136,7 +136,7 @@ static inline int mal_rx_size(int len)
>   
>   static inline int mal_tx_chunks(int len)
>   {
> -	return (len + MAL_MAX_TX_SIZE - 1) / MAL_MAX_TX_SIZE;
> +	return DIV_ROUND_UP(len, MAL_MAX_TX_SIZE);
>   }
>   
>   #define MAL_CHAN_MASK(n)	(0x80000000 >> (n))
> diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
> index 4bdf250..deef5a9 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
> @@ -614,7 +614,7 @@ int mlx4_buf_alloc(struct mlx4_dev *dev, int size, int max_direct,
>   		int i;
>   
>   		buf->direct.buf = NULL;
> -		buf->nbufs	= (size + PAGE_SIZE - 1) / PAGE_SIZE;
> +		buf->nbufs      = DIV_ROUND_UP(size, PAGE_SIZE);
>   		buf->npages	= buf->nbufs;
>   		buf->page_shift  = PAGE_SHIFT;
>   		buf->page_list   = kcalloc(buf->nbufs, sizeof(*buf->page_list),
> diff --git a/drivers/net/ethernet/mellanox/mlx4/icm.c b/drivers/net/ethernet/mellanox/mlx4/icm.c
> index 7262c63..4b43511 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/icm.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/icm.c
> @@ -406,7 +406,7 @@ int mlx4_init_icm_table(struct mlx4_dev *dev, struct mlx4_icm_table *table,
>   	obj_per_chunk = MLX4_TABLE_CHUNK_SIZE / obj_size;
>   	if (WARN_ON(!obj_per_chunk))
>   		return -EINVAL;
> -	num_icm = (nobj + obj_per_chunk - 1) / obj_per_chunk;
> +	num_icm = DIV_ROUND_UP(nobj, obj_per_chunk);
>   
>   	table->icm      = kvcalloc(num_icm, sizeof(*table->icm), GFP_KERNEL);
>   	if (!table->icm)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/srq.c b/drivers/net/ethernet/mellanox/mlx5/core/srq.c
> index 23cc337..7e20666 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/srq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/srq.c
> @@ -73,7 +73,7 @@ static int get_pas_size(struct mlx5_srq_attr *in)
>   	u32 rq_sz	  = 1 << (log_srq_size + 4 + log_rq_stride);
>   	u32 page_size	  = 1 << log_page_size;
>   	u32 rq_sz_po      = rq_sz + (page_offset * po_quanta);
> -	u32 rq_num_pas	  = (rq_sz_po + page_size - 1) / page_size;
> +	u32 rq_num_pas    = DIV_ROUND_UP(rq_sz_po, page_size);
>   
>   	return rq_num_pas * sizeof(u64);
>   }
> diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
> index b8983e7..f980f10 100644
> --- a/drivers/net/ethernet/neterion/s2io.c
> +++ b/drivers/net/ethernet/neterion/s2io.c
> @@ -491,7 +491,7 @@ static void do_s2io_copy_mac_addr(struct s2io_nic *sp, int offset, u64 mac_addr)
>   };
>   
>   /* A simplifier macro used both by init and free shared_mem Fns(). */
> -#define TXD_MEM_PAGE_CNT(len, per_each) ((len+per_each - 1) / per_each)
> +#define TXD_MEM_PAGE_CNT(len, per_each) DIV_ROUND_UP(len, per_each)
>   
>   /* netqueue manipulation helper functions */
>   static inline void s2io_stop_all_tx_queue(struct s2io_nic *sp)
> 

For the Mellanox parts:
Acked-by: Tariq Toukan <tariqt@mellanox.com>

