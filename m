Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCBDC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1942086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZI+dpCBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1942086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeIKSAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:00:31 -0400
Received: from mail-eopbgr60114.outbound.protection.outlook.com ([40.107.6.114]:59392
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbeIKSAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSCsQzm77ALJhGIk1lDXouEGGcZJFCB1id8Yp2gFXEg=;
 b=ZI+dpCBftoJ/p1yENao8S5OukYPQSnU3lc/NR2wtoOM4L7LmKJQ56uHzuBMDzzhL89Z/Zmte5/aAJq0QrpTnwYRJjFGy/pVYE/oenyAKko9YgTJX3egW+DAbc3bk5E74s9l4g8Gi1UzELTedThXe84+W9TM3YUErlZT38rsX4yo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM6PR08MB3256.eurprd08.prod.outlook.com (2603:10a6:209:47::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.19; Tue, 11 Sep 2018 13:01:11 +0000
Subject: Re: [PATCH] arm64: lib: use C string functions with KASAN enabled.
To:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
 <20180907145605.GE12788@arm.com>
 <9634affa-b210-d931-e40b-6e8a20f105fc@virtuozzo.com>
 <20180910113257.7rjj5qseu3m2tj6y@lakrids.cambridge.arm.com>
 <20180910125303.dlysg3jba4wv7bhg@lakrids.cambridge.arm.com>
 <20180910130631.GB24619@arm.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <cc08dd75-79f9-bece-8803-772123ebb0d6@virtuozzo.com>
Date:   Tue, 11 Sep 2018 16:01:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910130631.GB24619@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR03CA0061.eurprd03.prod.outlook.com
 (2603:10a6:803:50::32) To AM6PR08MB3256.eurprd08.prod.outlook.com
 (2603:10a6:209:47::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 274fd6f9-6768-4491-0f69-08d617e6a65b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3256;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;3:3xhXRCZaAbXgEO0Y0mN0rWNY+FuSz9BaINmMdghJL7Rkk7Xloi7P7PLttOzzuvIsvWLjlD786YkfSsq58Nq9muWRbzeQvNMqOW7a/2XCptyF+gYG977QQKailoGM5QQMs3sQhLK0sOmz+8EljhaeUw8PXk67JTJjh5du4jVl0RwXlpgj6m+9pfwBfnYXQp890rYLPHXCH4w6HUOET0grXotk35OHYA6HIydyNI9Uz+150JrDqngpfvQPHolVDTEp;25:uci7agFwcSNPcyP/Nv/tw4j4MTFowCB9lyO8blrdHia6wzk0AACr0vPCGt3WPdm00MqWRMHuEBRboi3/fEHFs/2satKYW24JT9EFEbFrOO9V38+MajX79oVyv5RRAA2+y21DIZXlylZRWI529bj8FY5Tt9gZowAvi8J/33dgJgSlleoPHnYhIoTkg1PZwPjTeaHJ/iAc8Zp4UPtmIvkJwKBbUGz0HGO+dzixmPSXlzJhtshq/M3P73XHJxXXhpXmimteiSjcciiVijZEorhgOL6PtYwCAeAemUvO1a+a4OTxhAUKIeuAbqAsY8aC57y5SrS5Dp6jO1uCALF4zycIiw==;31:dIPRcs9+sz23XLl3eP6sE1kbOEkQncxhCGnjyu7nunckHpU/btga0gnLsMpYAWp6t9GW0TkGkFBq1evbgdzmAno4lsSN39pb26+IXzw9fmElfBHeyRG8Y3LDdgnu6sxbwzQxXjI/wGZFzrIC639vEGlgBqfjZv8naPGgroOhJ9mKXgMJTKEwDI2skIqQPn3WG1cBrVHLkdh4wkUfCik2gY6xlHBnjr7gyU2b0AwrjTA=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3256:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:vlCiAzqqqE5YyZFyERlCgAQWv+1jmVJoouc8AnMQM7T0bbHX/YGKOFN9OkjfX36WIaUTpitrNXXQqHXyCXEQNOIbHvYUgXyUzI+y6XoSTXbJDeLTeXGZtYRP09jYA0HGtiZPqo+bqFRAZx7zgtyh4GOu1IXnAy2M4YANUUPegGopIkgHcGDQShgLht4XzY8Wv48GwyUqAlCpMf1BZ4G8TIB2Vl0w7m5Tp7UWmRjmuaqAfi9OtgrldyI+4GD1XIspBDjUFGdEEQt3uNyLlf3JkB7lJB6PM1ag4qj3D9ZLXmOJIQUhJz0DKJFbj+ry8K+sRJ4623xVPMUA3yXDFW++yzobIC06ATHX24thtCZ8C0OEulYtB872ww5g0lW8gZbkVUc8xuZRNrDQS5AWwP85A+Q+28QX/ttlnJtCKdiS1t9yCrgwJjH+KrlqBeiC2Uf77K2eSVFO6NiZVjOWl9XLxIM7/ynyoBUFG4Hy1I4UjSKH+7A8ckpFEXxFa+1esXgI;4:7omzNUU7ABxeuS+QCuAPidBvDPfarMmsPMYr0jUG6qXLTXLPKFCcCSf9RQTmbrG7IAe6WfTfwF+Czh6CHP+zrDOWeIcW8WgUI8ThCjE3noJ0f529Cgv+c9TomX9AzEyCuIZtRj6P2Hs8TsOSm9H3RVXzPIkQpueHYWIGE8FWnxi9U6+BUec9nYvefkQJLPhCsjAOondjnG5hy2RjeHtTDXvgfD259fGtW5MStV9Yx2eA/3s196ys7i5i/7hh7hXiVJWa1Y22+QO1RdHlDhyBvg==
X-Microsoft-Antispam-PRVS: <AM6PR08MB32567A41E2E70AB90542F337B0040@AM6PR08MB3256.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:AM6PR08MB3256;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3256;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(376002)(39850400004)(396003)(346002)(366004)(189003)(57704003)(199004)(230700001)(956004)(2906002)(6116002)(3846002)(2486003)(186003)(52146003)(23676004)(31696002)(50466002)(76176011)(6246003)(64126003)(7736002)(575784001)(8676002)(305945005)(68736007)(97736004)(4326008)(77096007)(14444005)(6666003)(26005)(36756003)(16576012)(5660300001)(58126008)(7416002)(386003)(53546011)(11346002)(446003)(486006)(53936002)(86362001)(81156014)(316002)(81166006)(65806001)(66066001)(65956001)(47776003)(25786009)(106356001)(478600001)(110136005)(93886005)(52116002)(6486002)(2616005)(16526019)(476003)(105586002)(31686004)(229853002)(65826007)(8936002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3256;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU2OzIzOk9sSDhRV1VjbFhGdEFKYllwRnNiTHhOVDhN?=
 =?utf-8?B?VGFaZE5qZDF4cW5PcjROeUwza2IxTXZPRkNBQkxDVGc4R200TGNhOHRiak1E?=
 =?utf-8?B?SVF2OWJuZXZWL0NhY2RUN1YzV3BRcml3MlRDWFFldlJnemlCZHJXY3pPNmxt?=
 =?utf-8?B?LzRnOENaOVlKVzN0U0kwNHI4eTAwbXB4Z3NhclBRMzFpM0NRd1JxaHlOM3hE?=
 =?utf-8?B?NFJVQ0FKQnJ0UW05QXJlQi84ZndzV0UxanBNRGNBMmYrZFFSVEdLd1JaL2My?=
 =?utf-8?B?SmhIbnZkeDE1cmRZWmdGM1ZULzhidDNHUlRLR0MreXczOU84T1ppQnl5WjRS?=
 =?utf-8?B?cTV0Q1B0WHRLUUZlNzFCSStDYW1VekM4Z3JIdHNMazIrSG9FSnM1dWRjSmNH?=
 =?utf-8?B?VXFzWWN4WktpZTN3UGZFQytZM2NvY0pvalhFZFUrTkM5T1AwTnBwVXVnd2dK?=
 =?utf-8?B?S0lUUU5uZUozelhBeGgwVExHdE5TR1htbGRwWm1mUmJLVURZeTRtcnh1TWpi?=
 =?utf-8?B?WFAxdkdibVRYeDF1WFJ3QytkYWpkSGZWTXF3OHoyNHFLaFF6UTEwTWV1aWxn?=
 =?utf-8?B?N1ZscEIwdnR2OTFSWmRKK2R6ekJGMy9hU2xIaGE5dTJrVnpyYzMxdTFON01q?=
 =?utf-8?B?RmU5cHl0aE1qcDhJOGg5c1dZeFlsNHVSQldQeVpac2FYb0VnUWpQVzBDV1pE?=
 =?utf-8?B?RTBCSkF2RVArRFZpVm5xNFJHUmxhNW9iWDI5QlhCcFBSSFNPRGZPTHFlT0Ev?=
 =?utf-8?B?R2dPS0srR0d1c1o5aU8vS2kwRU11ZDRwSXV0Zy9Kb1JxNXRzaHVldk52dE91?=
 =?utf-8?B?c1diZnVPYWNKWFpyUVJFYWRscXcyQVJ5Q1dsVDVoMDR5ZTVFN1dwckh6VzBI?=
 =?utf-8?B?UGt1MnJHZTFyeFljWldaNzNRRCtjdzk0bTBUU1BScysrU3BLTUt2cGRLczhP?=
 =?utf-8?B?bmlOTnZJZ0ZxTGNBa1dGdTMwS3lCc2RZaXVxZnRMMjVydGFtRjVZWHp6VXVB?=
 =?utf-8?B?K2Vvamk1SkZBL2xtSjNuTWE5Sm5uZGpoVmp0aWx4WnZtR1BsYlZHUVVxaFI4?=
 =?utf-8?B?RFVVeUxYelRXdHVSdUpBSUtaZ3kyT3kweENhdFBJOHRYTkNiT0hDMzBaRkhU?=
 =?utf-8?B?ZGFoTUZlRUtvVG5yQVE1d1lEUDlyWWNMUUhaVkZ5eUlOWkgxa1NzQzhoSDJH?=
 =?utf-8?B?WEMwMHI0QUhkNjhhVXZ5Z3FaVWN1c2Mrbjk1TjY2czY4YU1DRm5JQ0hITVMw?=
 =?utf-8?B?dlFlUnJJY2tVMWxUbDQxOWhQNHhoeGpqNVhab1lUUDBQYjdxWWxNdDhyUVF1?=
 =?utf-8?B?UEIwS014R1VYb1dQQ0VaWGU2cFl0SFdwOVpxMEFrdGJrZjJDZXZrOHdnYVhy?=
 =?utf-8?B?aThVVXFRSnB0RVJISFJocnJ0ZE5qZHJrejhsY1FCUnVXcEVOYU0rR3ZBbFpm?=
 =?utf-8?B?M2thTjZmNGJFOTNhY2JQSU5tOGttUU9HY3lWT2d4Mi9DVEZoK2tkR1lwUDJ5?=
 =?utf-8?B?b1B3aks2Q0JRRzlXR1JWTFl5dEREN1M0Ky9NNk91dmVhcWtsY3JUa3FDczg3?=
 =?utf-8?B?OFFpeWt6c0J5TlNKVnFCWlJkNGY3REtMeEt3aFdTT1JVcDZOdmF5cTVEZjNx?=
 =?utf-8?B?MWhjREtaa1VsL0RKTEpPZGdzTDZOY3NmVStoQzV5M09tUDZKRUxtTU9ySmJS?=
 =?utf-8?B?WlhFUkszYnFab0ZsdlNFMkljcUQ4NE14STZoeExaZzdMWXVDWURpMVJkWmNu?=
 =?utf-8?B?ZGt0MkFDN1FubEVHVis3UFlQQ1lnWDVuVENBL2tmQ25KUlA2K0EyWEhtL0x4?=
 =?utf-8?B?KzQ3TVNKMnA1ekx1a21EVVk2ZnBRRytwRHJpNXJudGt3SVZ0dS9ZYmRYcU8r?=
 =?utf-8?B?a2pMekZDRncvMVRqbXFFMk5LNmIyU0pQQ2lYWE0rWHVORDNSRnMvNlNQSFYy?=
 =?utf-8?B?OU4xcDdWM0V5NjFRYXhvQjBBRUs4U2d3ckJxS2xNR3pjV2FrUFZvcE9PdkVP?=
 =?utf-8?B?bFMxTlJWWFBUNjgrSXZ4Z0hSZ2g1V3FKZDRzWFFIKzFLYnZjcitmTEhTdkFw?=
 =?utf-8?Q?8yEVYTN8YLQDqx+Nx6sGXQHw6?=
X-Microsoft-Antispam-Message-Info: EdQXEx3dl2LE8+Jq1FY/pTNECXlf/Tfy6GxoOEtO14F6WjTpatjHeklE0nXrjH/Vt165kNBKTd2Dx30P3WEacHZSxlnryrMiwsVh95FAgHSc9OksIa9ycJ+VS8JG1w7+45AUen1BHFQU3zR7uKpSNEbWJd1axN3Wqdgqbl1zQsp/699vmNnwKZ3p/gXstoG8pw1PbghYvzj6alTE9gIcxRNrpM4o8rnSu1amu7v9ZjCDjcNe8DF45mveERV3Opx/GGPvMbRHyoLtX+7k2753Kf/FbVShahnBL/1wwOIsRPXAZHbbDibF8CiYrBo67pGonHx6YSIVuf1I8/WcTASuJoOqrW0k/2isqAm93j0qLGo=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;6:5mR/nCrZlaahZpBQrDJPjl6oofFvhB0IPCjB3+W87uQB28WcoUNrEMB06VHPMxk7+0TdSeABTz8y1sNKD1mlMLAIjMRqhNfkGRyrTsut+Z77RbbovQlVki18ynu64WMynTs3fgAhsfRLcajk2q4QtuKgoPNqP/p3YJcx7ndMAtxN94xOdavoViws8WrXeb8ODJIeDE3DUArvt9LRIzktskvX6EqYQmIWNYL7pd/xqIYSvhTRjUfPRpaPAmMqN97AwxMdOmIKkv4dPPrOScRvALUkaaaSeLLd64d+tWBIttv/e5ia3/P4CaQUcLJRrYy0lttb7O/i+KuL4Z2GaYvHnNRADH5x6VaekW3Wm5WbKeCdmIuz5UFHQ5sg1Pr/W0/3SZ+cWrHtnRbuEc3EmL/FWPg+iYWaz2Wz8iozyt0GPMwsSyeTxdvLk6BBuDOb4X1pWFkvN9X3cRdGaS4QyF+UxA==;5:OXMIc/8Z8mZxBrNWY/7hl99qFLxrY1E8eZws1YFCig4+a1g0JCdl6XulBHXGJoHn7bllKFc7pk2tQdb+8W1bslNxZqJRdz9NvcewM9vawyXg1/Ua/nF+LVUlem45iFONCmL2OuWo7gEXvSe0wXDu/PG6FNLjR5oz/PLgYuarhI0=;7:xCpZyc+PauWKDKp6K7orZPxJQ1plDig1y8avXahN4SXNMBYPg9Xc6S3m5PR32fJXnBOA3UjVckuDWqf2MzGe+C8imv+5NbPPgaSKy/0zzRkBI1XonuUnSdU1RByRGxbFK5Pl3XmLYvTK+3tfOZ49SIAArO8TkRzpJe7sU5ArB2NdKW2OJYBIwlo10lFABiCOQQaprSrje1gj0n2QSBINfoWVzaInNhfaX9qmgWJ8Fbs3LA+EmbSDi9rKSMglWGPi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:Ze27RYZiNTwnNNdjbrO7hWc9Bic3OLVaD47HfqN7tpDCTosd1PKXK8/Y9xpFXi7cZNrNa3Zyzrxodu4lyUSdflxu2aO9P4iOfjaBixqJ2myhmmB+SltCxiJWSLgx3j+DEX/CurGWK+N2Mv3uCdKFcUheYRe1RmrozO0t4YnKHUs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 13:01:11.0019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274fd6f9-6768-4491-0f69-08d617e6a65b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2018 04:06 PM, Will Deacon wrote:
> On Mon, Sep 10, 2018 at 01:53:03PM +0100, Mark Rutland wrote:
>> On Mon, Sep 10, 2018 at 12:33:22PM +0100, Mark Rutland wrote:
>>> On Fri, Sep 07, 2018 at 06:48:10PM +0300, Andrey Ryabinin wrote:
>>>> On 09/07/2018 05:56 PM, Will Deacon wrote:
>>>>> I don't understand this bit: efistub uses the __pi_ prefixed
>>>>> versions of the routines, so why do we need to declare them as weak?
>>>>
>>>> Weak needed because we can't have two non-weak functions with the same
>>>> name.
>>>>
>>>> Alternative approach would be to never use e.g. "strlen" name for asm
>>>> implementation of strlen() under CONFIG_KASAN=y.  But that would
>>>> require adding some special ENDPIPROC_KASAN() macro since we want
>>>> __pi_strlen() to point to the asm_strlen().
>>>
>>> Somehow, what we have today works with CONFIG_FORTIFY_SOURCE, which
>>> AFAICT would suffer from texactly the same problem with things like
>>> memcpy.
>>>

FORTIFY_SOURCE seems uses "extern inline" to redefine functions.
I obviously cannot make the whole lib/string.c 'extern inline'.


>>> So either we're getting away with that by chance already (and should fix
>>> that regardless of this patch), or this is not actually a problem.
>>
>> I now see those functions are marked weak in the assembly
>> implementation; sorry for the noise.
>>
>> Regardless, I still think it's preferable to avoid weak wherever
>> possible.
> 
> I was thinking along the same lines, but having played around with the code,
> I agree with Andrey that this appears to be the cleanest solution.
> 
> Andrey -- could you respin using WEAK instead of .weak, removing any
> redundant uses of ENTRY in the process? We might also need to throw an
> ALIGN directive into the WEAK definition.
> 

Actually I come up with something that looks decent, without using weak symbols, see below.
"#ifndef CONFIG_KASAN" could be moved to the header. In that ALIAS probably should be renamed to
something like NOKASAN_ALIAS().

---
 arch/arm64/include/asm/assembler.h |  7 +++++++
 arch/arm64/include/asm/string.h    | 14 ++++++++------
 arch/arm64/kernel/arm64ksyms.c     |  7 +++++--
 arch/arm64/lib/memchr.S            |  8 ++++++--
 arch/arm64/lib/memcmp.S            |  8 ++++++--
 arch/arm64/lib/strchr.S            |  8 ++++++--
 arch/arm64/lib/strcmp.S            |  8 ++++++--
 arch/arm64/lib/strlen.S            |  8 ++++++--
 arch/arm64/lib/strncmp.S           |  8 ++++++--
 arch/arm64/lib/strnlen.S           |  8 ++++++--
 arch/arm64/lib/strrchr.S           |  8 ++++++--
 11 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98dbba56..9779c6e03337 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -467,6 +467,13 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	.size	__pi_##x, . - x;	\
 	ENDPROC(x)
 
+#define ALIAS(x, y)			\
+	.globl	y;		\
+	.type 	y, %function;	\
+	.set	y, x;		\
+	.size	y, . - x;	\
+	ENDPROC(y)
+
 /*
  * Annotate a function as being unsuitable for kprobes.
  */
diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index dd95d33a5bd5..8ddc7bd1f03e 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_STRING_H
 #define __ASM_STRING_H
 
+#ifndef CONFIG_KASAN
 #define __HAVE_ARCH_STRRCHR
 extern char *strrchr(const char *, int c);
 
@@ -34,6 +35,13 @@ extern __kernel_size_t strlen(const char *);
 #define __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *, __kernel_size_t);
 
+#define __HAVE_ARCH_MEMCHR
+extern void *memchr(const void *, int, __kernel_size_t);
+
+#define __HAVE_ARCH_MEMCMP
+extern int memcmp(const void *, const void *, size_t);
+#endif
+
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
 extern void *__memcpy(void *, const void *, __kernel_size_t);
@@ -42,16 +50,10 @@ extern void *__memcpy(void *, const void *, __kernel_size_t);
 extern void *memmove(void *, const void *, __kernel_size_t);
 extern void *__memmove(void *, const void *, __kernel_size_t);
 
-#define __HAVE_ARCH_MEMCHR
-extern void *memchr(const void *, int, __kernel_size_t);
-
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *, int, __kernel_size_t);
 extern void *__memset(void *, int, __kernel_size_t);
 
-#define __HAVE_ARCH_MEMCMP
-extern int memcmp(const void *, const void *, size_t);
-
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
 void memcpy_flushcache(void *dst, const void *src, size_t cnt);
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index d894a20b70b2..d72a32ea5335 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -43,6 +43,7 @@ EXPORT_SYMBOL(__arch_copy_in_user);
 	/* physical memory */
 EXPORT_SYMBOL(memstart_addr);
 
+#ifndef CONFIG_KASAN
 	/* string / mem functions */
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
@@ -50,14 +51,16 @@ EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(memchr);
+EXPORT_SYMBOL(memcmp);
+#endif
+
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
-EXPORT_SYMBOL(memchr);
-EXPORT_SYMBOL(memcmp);
 
 	/* atomic bitops */
 EXPORT_SYMBOL(set_bit);
diff --git a/arch/arm64/lib/memchr.S b/arch/arm64/lib/memchr.S
index 4444c1d25f4b..a2f711baaaec 100644
--- a/arch/arm64/lib/memchr.S
+++ b/arch/arm64/lib/memchr.S
@@ -30,7 +30,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
-ENTRY(memchr)
+ENTRY(__pi_memchr)
 	and	w1, w1, #0xff
 1:	subs	x2, x2, #1
 	b.mi	2f
@@ -41,4 +41,8 @@ ENTRY(memchr)
 	ret
 2:	mov	x0, #0
 	ret
-ENDPIPROC(memchr)
+ENDPROC(__pi_memchr)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_memchr, memchr)
+#endif
diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
index 2a4e239bd17a..d2d6b76d1a44 100644
--- a/arch/arm64/lib/memcmp.S
+++ b/arch/arm64/lib/memcmp.S
@@ -58,7 +58,7 @@ pos		.req	x11
 limit_wd	.req	x12
 mask		.req	x13
 
-ENTRY(memcmp)
+ENTRY(__pi_memcmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
 	tst	tmp1, #7
@@ -255,4 +255,8 @@ CPU_LE( rev	data2, data2 )
 .Lret0:
 	mov	result, #0
 	ret
-ENDPIPROC(memcmp)
+ENDPROC(__pi_memcmp)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_memcmp, memcmp)
+#endif
diff --git a/arch/arm64/lib/strchr.S b/arch/arm64/lib/strchr.S
index dae0cf5591f9..5bcfcf66042e 100644
--- a/arch/arm64/lib/strchr.S
+++ b/arch/arm64/lib/strchr.S
@@ -29,7 +29,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
-ENTRY(strchr)
+ENTRY(__pi_strchr)
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
 	cmp	w2, w1
@@ -39,4 +39,8 @@ ENTRY(strchr)
 	cmp	w2, w1
 	csel	x0, x0, xzr, eq
 	ret
-ENDPROC(strchr)
+ENDPROC(__pi_strchr)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strchr, strchr)
+#endif
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 471fe61760ef..e0dd23f36be9 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -60,7 +60,7 @@ tmp3		.req	x9
 zeroones	.req	x10
 pos		.req	x11
 
-ENTRY(strcmp)
+ENTRY(__pi_strcmp)
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
 	tst	tmp1, #7
@@ -231,4 +231,8 @@ CPU_BE(	orr	syndrome, diff, has_nul )
 	lsr	data1, data1, #56
 	sub	result, data1, data2, lsr #56
 	ret
-ENDPIPROC(strcmp)
+ENDPROC(__pi_strcmp)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strcmp, strcmp)
+#endif
diff --git a/arch/arm64/lib/strlen.S b/arch/arm64/lib/strlen.S
index 55ccc8e24c08..f73e6a6c2fc0 100644
--- a/arch/arm64/lib/strlen.S
+++ b/arch/arm64/lib/strlen.S
@@ -56,7 +56,7 @@ pos		.req	x12
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
-ENTRY(strlen)
+ENTRY(__pi_strlen)
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
 	ands	tmp1, srcin, #15
@@ -123,4 +123,8 @@ CPU_LE( lsr	tmp2, tmp2, tmp1 )	/* Shift (tmp1 & 63).  */
 	csinv	data1, data1, xzr, le
 	csel	data2, data2, data2a, le
 	b	.Lrealigned
-ENDPIPROC(strlen)
+ENDPROC(__pi_strlen)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strlen, strlen)
+#endif
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e267044761c6..640dc77d4a2c 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -64,7 +64,7 @@ limit_wd	.req	x13
 mask		.req	x14
 endloop		.req	x15
 
-ENTRY(strncmp)
+ENTRY(__pi_strncmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
@@ -307,4 +307,8 @@ CPU_BE( orr	syndrome, diff, has_nul )
 .Lret0:
 	mov	result, #0
 	ret
-ENDPIPROC(strncmp)
+ENDPROC(__pi_strncmp)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strncmp, strncmp)
+#endif
diff --git a/arch/arm64/lib/strnlen.S b/arch/arm64/lib/strnlen.S
index eae38da6e0bb..c9749b807f84 100644
--- a/arch/arm64/lib/strnlen.S
+++ b/arch/arm64/lib/strnlen.S
@@ -59,7 +59,7 @@ limit_wd	.req	x14
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
-ENTRY(strnlen)
+ENTRY(__pi_strnlen)
 	cbz	limit, .Lhit_limit
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
@@ -168,4 +168,8 @@ CPU_LE( lsr	tmp2, tmp2, tmp4 )	/* Shift (tmp1 & 63).  */
 .Lhit_limit:
 	mov	len, limit
 	ret
-ENDPIPROC(strnlen)
+ENDPROC(__pi_strnlen)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strnlen, strnlen)
+#endif
diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
index f8e2784d5752..27bb369de8d9 100644
--- a/arch/arm64/lib/strrchr.S
+++ b/arch/arm64/lib/strrchr.S
@@ -29,7 +29,7 @@
  * Returns:
  *	x0 - address of last occurrence of 'c' or 0
  */
-ENTRY(strrchr)
+ENTRY(__pi_strrchr)
 	mov	x3, #0
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
@@ -40,4 +40,8 @@ ENTRY(strrchr)
 	b	1b
 2:	mov	x0, x3
 	ret
-ENDPIPROC(strrchr)
+ENDPROC(__pi_strrchr)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strrchr, strrchr)
+#endif
-- 
2.16.4
