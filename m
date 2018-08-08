Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5452173C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TcO7b6Ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5452173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeHHOLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:11:32 -0400
Received: from mail-ve1eur01on0126.outbound.protection.outlook.com ([104.47.1.126]:20400
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726756AbeHHOLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL3tLDvm32VWoyfobCYjkRBwXMIpNrqS56onmY3oiuo=;
 b=TcO7b6CivY+l6v1UfhCLeVHhkyXwXsa2ITgosZ0f99wMXk0YpcbO7jQSq39lSnYPpi5loVe6WCMenhMpPCgk6TmkEeYq1CpIagKI8kQTlvlb69jriHIrP5Kxp9DeI/xVL04c7HFk3O7EMky704XVsIZGMrWSiwcDhHtJwqiVt/8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 11:52:01 +0000
Subject: Re: [PATCH RFC 02/10] mm: Make shrink_slab() lockless
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, mhocko@suse.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365626605.19074.16202958374930777592.stgit@localhost.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <591d2063-0511-103d-bef6-dd35f55afe32@virtuozzo.com>
Date:   Wed, 8 Aug 2018 14:51:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153365626605.19074.16202958374930777592.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0133.eurprd05.prod.outlook.com
 (2603:10a6:7:28::20) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d1b541a-ce20-4e78-72ec-08d5fd255b79
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:3+XgJXbldQpLvjC4DYXt3NK+4BarXMaM9MNQUxzZZhwHV9axeeEUiJIqhn5JBxTGSL/tHjDlrn3rq8xbqdAkRazIBZcn+OEbFh3ecmaC8FgvXS9buScqublj0jJHFtw4WN8Z/7kcxxVbkJO2NqwLjectp68ZhGAba1/SzptFfcJ2Rejk2B4LWOf2hK9gAfY59T0xdKm6CrPvb2tvTbmzdeoZyXnKrf0Z7yLkd6OpthehsklOl2UD/mDWnHBjNHAg;25:kQRej21BTVHV79IPNCSfNwVRWyufjT9yaGQJOLiw+WxXa6T7QdCB/rrZR4gocAzggVSX9irQ2ANTMOO8W9vWlu8RECCaF0O20hSdjMSHYoh3a7KlrRJyncMKbQ6huZSl+orwTKOgB/6vS+Ua3Qp0kn0EctOeRV577nJpQVfD/ymt3EG1dbDqmgIb2gCkVjAONmuQsJq4e4CW1z2h/N3CrIpIcJkvKge96RWcGH84HlcFSY3uyX+trET0ESPG1oXZG1fFutk4NbOrGupY6W/liLUtMyUKhbjRCv3JEXdv5iFxR7JUZSdTZRM0PNBTX3KjJgIx1WpG/xxo1uoSjCWKpA==;31:eP1Zc20MocsJQItX4DDYWPJ2nxWN/39BHPx1jbcXuYEaTYK7t5QFPmiDYHbTKZ/KhJW2EqvSiCU4YbnuuPmYyqpSGyIRRnxFlvrtUebeaURG8e6SyD6CCHv0tACVQdlZJ4aMyqovZy+DrPq+6VuBLPx78SpYYbr1x+OIYScM3VSiZoHxUoeP8K1KYDxhyqHhLjZgWC9eNZPRbyJO0Oqtybv2eYnd/G/Tg8kPM/1LkJA=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:bHGnqDtzHQxDZSSGeZvIhx/BWB30jJ14HAaYXp9b1nIgPG4xdelEoLQxNQnIyxNf195N4w43wHojJ55n8ao27Z9auhOBP1WnuI7s8nZJ9jsshFQDA5rLWeehJouZ3eWokRkf09i/LxIol0/p3hsL6g12TCzp++U2t87hAowNKkRkswSnWFL/aQqEEGNA7QugPNHN2ARcg7XzVNVUqjnXCmrx4/fe15lVAggP80ZZagTHyE7BVPXedYjvQoeXaEZiZlhtKILjz/ZGbBjTvXJJEYxKKdG7tBlgE/vGIEGLi6EKV9itu1Qh5HJw0u044k3F40GvdEjO3hYq0hrXIttAArbOvJUutyMhyx/g403w4yeIj4UCMUh0Eg/8V6L2ru/VGX2j+DLoRD8j5VRASn8qH4kV6EATn+IEiNe5Y4X/+EO02DlYwTUXiYc6NrA3vOuYysmVELQVnmpAIAyszsBPYeSm/hPKwzWgzxHMBtb5uNM1Yjg4nUwyosNnvU86ldOM;4:V17lT9yXs+3cUjgWLi4MNuD54lgfolAtc71vDhVa8bbGd7dRUpJPoS0z+EVtHX4H4NmPr1yiBLVuwOYtMXtkUnFmk1HDb5QN453wxyUmTn7dJe2kt1irUORi8/N2Nm9WSHaEaoPNwkJR5yyWYxHfQxob3+PJAVTMLUAdBLtvx3k+sttlBIgwFMWGxM0/JdFGgn+fe9IJGFVitmecTPvmMskD2V4ZzM0SmzhZUSQCJ/FqRyvbDHlkPbHqi9/NJYNvhhV1nuK2i6vpXust+5RQ9g==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2026CC3F67CEBB922B437CB5CD260@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(376002)(136003)(396003)(39850400004)(189003)(199004)(39060400002)(2906002)(386003)(26005)(58126008)(6486002)(478600001)(5660300001)(77096007)(16576012)(68736007)(305945005)(476003)(36756003)(6246003)(7416002)(7736002)(229853002)(7406005)(65826007)(53936002)(186003)(16526019)(956004)(31696002)(11346002)(2616005)(86362001)(486006)(50466002)(446003)(25786009)(66066001)(230700001)(106356001)(47776003)(14444005)(52116002)(3846002)(97736004)(31686004)(64126003)(105586002)(6116002)(52146003)(23676004)(2486003)(76176011)(65806001)(65956001)(316002)(81166006)(8936002)(81156014)(217873002)(8676002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6RmFjN0ZvS3RxaVR6Sm5FUFhuQktRRzdD?=
 =?utf-8?B?MjhsU1pISE5QWXB3Q1dOT1ErQ3U5TWhlM29HeHIrMFRPTmh1S0xOMFVDVHgx?=
 =?utf-8?B?UWFxK2c5VGJqUVl1bTUyeUtVYnh0a080NkpJdGJoRHBob2s5eEdjVWl2TzFM?=
 =?utf-8?B?VTA1WE1EVFdjN3FtS1VhS2FSZXZoMWJKZlh4OHhodFBCdzVLSVRVZFI2clh2?=
 =?utf-8?B?VXYxek9KeEREaFVpK253UmlORWNoMHFRVlFWWHZ0WXUwc1o2TWxHK094ZVpS?=
 =?utf-8?B?dmM5aHdPWWdaZzM4K2JoWitFOThlRFY4VTE1SmRGT0FPTHJDcFlEcmNUekFX?=
 =?utf-8?B?TFg2T1YzRlRaeTdGY1pOOFo4VFExOFNwZFhrWlF1RlQxaVZ5ZmgzenVYbjZR?=
 =?utf-8?B?K25UT1lRRy8vQ2RwNWUxeE5TYXVXdEQ4V20vSzh6empSZUt1Q28yVVlWT0hl?=
 =?utf-8?B?ZEFDZENmRFBYNkp4cW5VYktzcVk2SlBJUzYvWDAzRUtaTEJhQVpOVGNtWVA5?=
 =?utf-8?B?RG5KQlNXUS9rNzRKdzNjQ3lBVmRPRUZTNkNiUjNqeEliOTZlUHhlNUkyUWY4?=
 =?utf-8?B?aTV2NE5ZZFUyOElEbXg3Rm5QTzdRV0lmenluZHhWMGZuQ2hQQ05DMjUxN1lK?=
 =?utf-8?B?TjN5Vy9KNHFWVkl5cFZBZDQ5M3pZY0NuYWQ0dEVhblhIeitJbC9QSWVDQ0ZK?=
 =?utf-8?B?QUg5bVNYejNFOTBEa1ROL1BVZ0Z5bCs5T01LbWZ6RTBXcmF4T25lSFo2Rnor?=
 =?utf-8?B?L3A3bmlHa21UVWVjUHE3Mzk1WVFHbysxMHlPMFVUcERHSjZ0eG5VWFZ2QWFL?=
 =?utf-8?B?T0tkUGlDWDFLTXRkY0tuQzhRak4xMUJURTBtWE4yeU0vb2t2U1dJR0lyRkx1?=
 =?utf-8?B?T1hqcXBtTGh2SzRyM1h3N2c5NkhHeVNpbmNkeEg5V3hxWVV2bFZiTS9RUVNj?=
 =?utf-8?B?NUc3Z1RtOHVlczIxUy9lUm9BcjlhcHBNY3ZJRUF3QWZ0Zmd0ZC80ZDdSeGJX?=
 =?utf-8?B?eGZDUFRBaWE4Tm9Tc2h2dTRsRk9xUkVDTC9yd2xuNkc3YVpyV0RuMXk3ZmZu?=
 =?utf-8?B?T1ZyMDVTd0xEbG1YUzNpSElDNnQ4NXJjMEVQckp0VlJUWjFFTFp6U2Y5QTM4?=
 =?utf-8?B?amQzcnUyYlJadXJLVnMzbFRleU5kMmFGWjQ1aWtRR1pEcWhvWENhZitqZVVt?=
 =?utf-8?B?Q01YM2tZMFQ5Y1IzREN3QUdsWkR4amhMZVVMajByUTZ2cm1yTWk2dUhSYmg4?=
 =?utf-8?B?VUl0TkZRWExXcXFrTHlieTNnVk5McWtFNUk1ckRSTTZ5cjhIb0VDY0dvMXdD?=
 =?utf-8?B?elhrYmIyTHozdDBqRTZINERFWitoTVhKVVlRTlRTelJjd3dRQ3hWY0Zlb1I2?=
 =?utf-8?B?TDhyYlA2Vi9PRmFpMGkwdzczbHllT1B4N3lPeHZ2NFMwZEpVTVVrL1ZXS2Zn?=
 =?utf-8?B?aThDaVlybVlDQW9hTVZCeWNLUlJJTDRsb1lMUVM2OGtZQjhrY0VTTzBaSlBz?=
 =?utf-8?B?VzVDb253dzNWYU5qSnVvZUt1YzUxUStzTUN0NjRKNGhBQWFmZDZyamc2MzFj?=
 =?utf-8?B?SEZTK29BdkJ4bWc5bXVBa2tQSHFCUEJJMElZMWxHOEpoSHRhMjdzbDBIOW03?=
 =?utf-8?B?ajZLVWpSMzNXUUg4a01FVmlrUWh5c1hXaXlpSndNOHE4OGJwTjN0SHBtZ01x?=
 =?utf-8?B?QXNncTQ5WUZiV3FyYlhiVFhrTExncWd0ZEhaRjk1dmNXSy93SjNwdkpqVmtp?=
 =?utf-8?B?dDBGTHF3UmNFVmp0Z0UyNEtuNkFWcmJWRE8vZzVncC9GaEh3THNQakNDZ001?=
 =?utf-8?B?eUQ1Qi9zcU16bWRhZHhiTmN1QzBSYzNFWHdoWW1BL1I3VEtFV2hMYVJmeURj?=
 =?utf-8?B?ZG0xaU1Hbit6N1A1d0EwaXZkQ3RIV29aSGRzM1dFaE45a0FGWFQ1MHdYbnFI?=
 =?utf-8?B?QXhFTCtvMWVlQi8ybnc0S0RQMGtySzJ1VitqblR1MmNZOFJDb3hVc1FLZUVh?=
 =?utf-8?Q?hP6LKK5I?=
X-Microsoft-Antispam-Message-Info: A/DjytrNCb2+XRgbed9ADvTUrRl63uzvxkkV4+B/eKeFjPl79BHNtKi8xzeuJcnIZOPH1VDo2eVe0ICPX4fHFD+QUzfQlhTTg9CsY1iOr79wUjGvXBVug2ofYuesHTPmw0H439FPdvOLArqYP7T5aBtZAQFpILPjCvi8++gdaW+vxU6L+TuBra2t3kbWTQ2s01D934tS1j2zscw7zoFzS0rs4YFe1PbA8EpYVgpXVZZAZnAboFPROzpmFfCRiZTMn+4ANp2ym+McjaocpNk5mJ6XsPQh0BoZgTumFu8c4c5AzAZestD9u0KC6JaeZsqTMDX+yWku9Oh6z265uDeKqXmfNIiO8wTq+hda/sZ3rss=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:EnermH4gg9meJuwkNszPDrCN5VgCtAMyeMID9zowWu0WZUsI1++anZgoqZIYH5lMDE3Zr0hag2wb8fKCP0aY5tqlGd0EE+TiCTp10ra0q/KA4MkII+a9uU+zszxb8ftv07GIgfR3QI2I3W3FZ8NOdiYhzdN4GNm6N+4OrsLCP1D1PT1S9r5eeuz/LkGzt5dRtoL1GiHNdhFBDiaCZhuoJlvZ43rwIkR3qVH7mC9CqFU1xiTp/QWXvTkyu9/A786SnXx5RUtDA1aYCVT/h9H8y76QWEYrZagWarh0G5+cxjCxJZU89WmqZ7cmGysqYYAdTLDzrNwjUFXBPdAQWiFhXcBXmRu7jZWrpJYkdnkmxcZgGsQB41boQS4mnV34+2XW6L+8fLQo4ez4oGnPi3YsG7Mec1nzzz2hAAKhSU996ozpYz4IH7HSr6mY3dpZ3nEVS5LLqS4zBoasPZ6cZ26c4A==;5:qxZ5px0IFPVqO6VTLEG7/Z7hpYwrbSc202v3DDrQVXzl9RJuw2JlKw7ZYdsvtZ3o+S4d/Yfg65B9k874V1gGyUn7UxCel2dbQ6raqWR75HiCRSeenWsNjtcl4Pvr5RzS/71cmu+c/d8dIS6ixpSeVroHkbcIC69abFipP1gntcA=;7:3EP/u9pIn3XMaHHv1N6mJZ1N1GR6UXvLmfHHHYCJU4bL2iH3YFir2liaKBlJ3ruak6gbTA3ySZ1CAOKie1YRTHLsSKtNHvm3gT0LQANuWCsYlQlwBh1IVg9Jp2WADr2m86TCSaMkjzfzSDWMFga/G5k4SpNXxW+osV1xSSMpytUrPxztWb3N9r1HH3xJS6dLlM3Wy/gRwwIRDqxF6Kbxiyqly2DfS8c14m4h2/twqbfP1dZhmHTDdpa5r4ltM3hz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:bIXwg9CsTydkanIa+dm0xyNW6I/VesjMerENymJ5u4AhNknGqJ/lY08yQrxdez6ZNiCB2ZS+mKSuMD5Ig4BOxksti5se8I6KeXKQvk2o57LF+Wzlf30jSgarJ3PN0BdEL3RFMWPcNQFPxHYHavNNixRri7LgaryJZMDH7WimwK8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 11:52:01.5595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1b541a-ce20-4e78-72ec-08d5fd255b79
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This also requires call_srcu() in memcg_expand_one_shrinker_map()
and srcu_dereference() in shrink_slab_memcg(). The updated patch
is below:

[PATCH] mm: Make shrink_slab() lockless

From: Kirill Tkhai <ktkhai@virtuozzo.com>

The patch makes shrinker list and shrinker_idr SRCU-safe
for readers. This requires synchronize_srcu() on finalize
stage unregistering stage, which waits till all parallel
shrink_slab() are finished

Note, that patch removes rwsem_is_contended() checks from
the code, and this does not result in delays during
registration, since there is no waiting at all. Unregistration
case may be optimized by splitting unregister_shrinker()
in tho stages, and this is made in next patches.

Also, keep in mind, that in case of SRCU is not allowed
to make unconditional (which is done in previous patch),
it is possible to use percpu_rw_semaphore instead of it.
percpu_down_read() will be used in shrink_slab_memcg()
and in shrink_slab(), and consecutive calls

	percpu_down_write(percpu_rwsem);
	percpu_up_write(percpu_rwsem);

will be used instead of synchronize_srcu().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/shrinker.h |    2 ++
 mm/memcontrol.c          |    2 +-
 mm/vmscan.c              |   46 +++++++++++++++-------------------------------
 3 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 9443cafd1969..94b44662f430 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -82,6 +82,8 @@ struct shrinker {
 #define SHRINKER_NUMA_AWARE	(1 << 0)
 #define SHRINKER_MEMCG_AWARE	(1 << 1)
 
+extern struct srcu_struct shrinker_srcu;
+
 extern int prealloc_shrinker(struct shrinker *shrinker);
 extern void register_shrinker_prepared(struct shrinker *shrinker);
 extern int register_shrinker(struct shrinker *shrinker);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4e3c1315b1de..a30bc2cc6380 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -347,7 +347,7 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 		memset((void *)new->map + old_size, 0, size - old_size);
 
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
-		call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
+		call_srcu(&shrinker_srcu, &old->rcu, memcg_free_shrinker_map_rcu);
 	}
 
 	return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index da135e1acd94..acb087f3ac35 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -168,6 +168,7 @@ unsigned long vm_total_pages;
 
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_SRCU(shrinker_srcu);
 
 #ifdef CONFIG_MEMCG_KMEM
 
@@ -192,7 +193,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	int id, ret = -ENOMEM;
 
 	down_write(&shrinker_rwsem);
-	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -406,7 +406,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	idr_replace(&shrinker_idr, shrinker, shrinker->id);
 	up_write(&shrinker_rwsem);
 }
@@ -432,8 +432,11 @@ void unregister_shrinker(struct shrinker *shrinker)
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
+	list_del_rcu(&shrinker->list);
 	up_write(&shrinker_rwsem);
+
+	synchronize_srcu(&shrinker_srcu);
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -567,16 +570,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct memcg_shrinker_map *map;
 	unsigned long freed = 0;
-	int ret, i;
+	int ret, i, srcu_id;
 
 	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
 		return 0;
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		return 0;
-
-	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
-					true);
+	srcu_id = srcu_read_lock(&shrinker_srcu);
+	map = srcu_dereference(memcg->nodeinfo[nid]->shrinker_map,
+			       &shrinker_srcu);
 	if (unlikely(!map))
 		goto unlock;
 
@@ -621,14 +622,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 				memcg_set_shrinker_bit(memcg, nid, i);
 		}
 		freed += ret;
-
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
 unlock:
-	up_read(&shrinker_rwsem);
+	srcu_read_unlock(&shrinker_srcu, srcu_id);
 	return freed;
 }
 #else /* CONFIG_MEMCG_KMEM */
@@ -665,15 +661,13 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
-	int ret;
+	int srcu_id, ret;
 
 	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		goto out;
-
-	list_for_each_entry(shrinker, &shrinker_list, list) {
+	srcu_id = srcu_read_lock(&shrinker_srcu);
+	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
@@ -684,19 +678,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
-		/*
-		 * Bail out if someone want to register a new shrinker to
-		 * prevent the regsitration from being stalled for long periods
-		 * by parallel ongoing shrinking.
-		 */
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
+	srcu_read_unlock(&shrinker_srcu, srcu_id);
 
-	up_read(&shrinker_rwsem);
-out:
 	cond_resched();
 	return freed;
 }
