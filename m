Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELu9tXiobLm3LrtT1Gb8+hwPM2x07ofaaN6Q/4DcvFuHHKrforgJ+Gxdfb9DsEBk3hXBkwdx
ARC-Seal: i=1; a=rsa-sha256; t=1522077665; cv=none;
        d=google.com; s=arc-20160816;
        b=gjzdQWAr5QkMT7mXOZFKr7YTEAOjbpLC21aBbY37kaUtkTPkE77dgkplYz6gPtaxgX
         YiLGvIl3/mZ7qbngFAizmXohSl0wiiTYsuufYJU1LDYwrr+jgpJIVKT76eGvtJC+71BM
         fIRkFt7Hc6Rf/O3SB9qsko9TwL6YW0jpD5fKiHpuBfjBvSbvHPfuZCX23lnnODQKL+OS
         dpaaVlPtv8fFIF6PTT1dyITlC6qElOQeTe3aDt725msoDGWNTEYpyTFtJy/nXjL2LW5V
         R4NP5dDB8/CgzKgk04ilTC92OKLKDbjrjsVylGfI9hz5eDAEVihTxhSJJX2bHUd/9rcS
         xbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=SoDZwmnoeH6OvZOXIclGYlw7SFAaGaaXf9Ft4pfz1WA=;
        b=n7yZYTolaSzUmXhdniutElfZZez+OSv5NfppbeelZcoqvlclPHxi5lzGfGsQ6+uzXN
         OfiWNdKA0xMGGSaz8PC/YtrsJ09GlrWc4KEN2nc8RHHxI+ZZJqvabL4NIWRTqqSlVtIX
         JL+AXUXAAbWGmC92Dngz2R/KkD/QTCYijOD3C7D3YS54N11TVU0+pIxvgbm7sL51j0/M
         6MAfwG4zrOb0X5QTcuDBad+gwhY54P4QAjjxxwgQj1PVtf/p/vY88DkT3M088XNEOhdy
         LhhR2yd2ICpbg2P6RmMZYzVP5SqYtNtus5hIg2sXHGB6BLLMm+CpTlW2pbMGMEuR/ECU
         pGnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=GngoChAU;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.107 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=GngoChAU;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.107 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 02/10] mm: Maintain memcg-aware shrinkers in mcg_shrinkers
 array
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163848990.21546.2153496613786165374.stgit@localhost.localdomain>
 <20180324184516.rogvydnnupr7ah2l@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <448bb904-a861-c2ae-0d3f-427e6a26f61e@virtuozzo.com>
Date: Mon, 26 Mar 2018 18:20:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324184516.rogvydnnupr7ah2l@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6P193CA0006.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::16)
 To VI1PR0801MB1343.eurprd08.prod.outlook.com (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69762b07-2d83-4a5a-73c7-08d5932d2eb5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:UkwmDXFZRoxuEWftio3J87KjwdGEZaIu22Yp11VkQJ5LTO7cZw64lIsdm0uucCIJlGU/mqb64MKLVaUuDuPAWRiQ3SFGSpt1ON5AsBTg4GvKi1HGz69Reuzv6adTMYmSXvgSukouqzlzrbih8eHyNwWDodKSXSSAeSmgmQxfwDJYGoOUhi1FsbmLs5/pTREGh0V0J5EekUe74s3VEwCoWn+UtX7rJzyx1b+AmOhLyjn7LdLxY9zXCQEMt2lmWoE0;25:VEjV+JMODajs0+E+5iIyEAj8MV+LwRSU8DYxjJBZ1C3ck3MbhnfSMVc86HH2X78SZcHoBce53vqkLecuyfpVzuwcKxRmQR0ny1fmtrEWzN+Dn9kdzgrkwnqOEBj2M5y3XiU1q/L0LQk0v6qhPCY4yWzQ/4cmRDwhTbD75CQwVJEcgv31Zv2OkGNGAPyLYt7QaTRpJKFt7SNYjjSV6XNDpCmzwisoOChGuQWUMcehi1Udmv0HNoVzFAFxno5hO2MDMtP0bAPafggxAfJzcR2XNcvN0D+5lmov1/t4U9Nk/K6p657l22CyL3r/qzCJjwBUY7q+3UOtATkpBw8l0WbDCA==;31:iAIWIq5VZcvPwYZsgk3TpnFf4lajILoDw3cLDR/5HBAAOAV4zFFNB/aBQ8RLBNBadyHITuFVW4DaFb9KnqNbxSyn+p1ZVFG3ZBJMxlP5DkaZZ1IWrayGGPu5dDPvFEdqyO3IZgXOajX5xrsTTn+HN2DjkkhlxVyJMQOlHuZzigIdnK/GwvhBOvzh2j0T0YPaJGfZyathTfY1dHfeIaZ5Lwc/LIHm/uB3rxF1EFGCzwM=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:7/YpYQc8BARXjd0+RrebH+n/saV8wmk9mqBm2jTwue9D/Ycn6bXJHPR8v59OxiDY+TfPwRpysvP2pGf58FbvElvtefofXlE25pqVbNpJNXNPMnmDhFLxaFJXcw2H9g4SUXkv3Me9qqp2Gg3rqA43dwTsfO16kcE74ZwEBUL1OoUfWOSmvA5vEwCucg3Xd3QIKS8eg+wlSeaAhMAYICgQabWgRvvhRjfiRYxnl0XFfiq/JLFTCFzgbn3Tdzi71qotqHlh22wuXyR31szx5vfQq5qikhGqBSe5XAf8FQmeccO6DCs/3nlmkTogcPnohxwqZ6zUETIXOlOq81amZyQtEcYkIxFCPLtsywUXD78tEfQnYBeUt8AZj4AGc3MOB8VEHuFlsNcPgp+1YPVGL8DTQyewAzqmQW/kQlQOCaVpsQToPuDu4RiCJIRa4weQVcO3GO3UK+jJPExdH7bbPKSUbgnaWkHn7779JZh8K4EGq8CdgtxG9yp5fr1JbmePbpVA;4:N1L+yvcPAVa1c7crAbJ3q7oagYPyWq1rW6E0VFkOikXxTmVVo3LkEo1hbMb1cN8eGZi1t50WYnZHSmCZo6pK/RhEI0/7RZEyFNHhIe9F50E2PNwm+GQGidR1SptppJE0fRXEXl2tAS5dAMZAAnhYZrOPwKOuECwi5jzXNFWOkwXDRe+sIOEKwId6VNNIgCorZTq6H6Gz5ZkHOfee43kB5y1WrhMv5VMhfKSfzmlxbkyMpQ5s1Zw0qmzKOm6mkLUz/3jYlX0lb5teZkqJ2Mus6g==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13433D66541C3A36A5F5AFAECDAD0@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(396003)(39380400002)(39840400004)(376002)(199004)(189003)(64126003)(76176011)(86362001)(65826007)(52116002)(65806001)(31696002)(65956001)(66066001)(316002)(8936002)(81166006)(81156014)(59450400001)(31686004)(68736007)(229853002)(6116002)(486005)(476003)(486005)(3846002)(23676004)(8676002)(16576012)(2486003)(52146003)(106356001)(55236004)(186003)(77096007)(53546011)(386003)(5660300001)(6486002)(97736004)(26005)(58126008)(16526019)(39060400002)(6246003)(36756003)(25786009)(4326008)(446003)(956004)(2616005)(11346002)(6666003)(305945005)(7736002)(6916009)(53936002)(50466002)(2906002)(230700001)(105586002)(478600001)(7416002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6S1NjcnZSNnFBOW10dXBBZHZ2L2tkcmMv?=
 =?utf-8?B?RWVBUThMWDJkd0ZDUTR1VUxnbXJ6KzFvR0lNMktPZTZlamRXSHpxaG5TTXh0?=
 =?utf-8?B?UG9sTXloV2FwQ1owaGZpQ0pGZk5ld1Z0ZWhIUHVLdVc1aWhMTkxYRTk4bXhE?=
 =?utf-8?B?UCtqeC9FTEt5NnJJdjY0Wm4yRkFZTHM1YTJkYklPZVg3c2VsSkxDREJpejZU?=
 =?utf-8?B?dnRtLzF6b2hmSWZFbkRsUXhGZHJJQ0Jid01Ec1MvTXNpOG1iYXdKN2FCcndx?=
 =?utf-8?B?V1FKRHdLUFhORmxDbmk1bjllN1ZGV0habU9DK2E1ejVxSEg1Mm9qUnRxOXVN?=
 =?utf-8?B?dVNnUk9QRjFncHB2clJnN2VSY1J3TDg2RWNPMWE2RFpUaFNDQ3hFTVNzZFAx?=
 =?utf-8?B?VFluQkpJQytaVFMvVWxZNXFBaEJJNm5mYWlBNjR2UU9XQ1NYdHpRMmdkSmVz?=
 =?utf-8?B?YVZ3SFNDcXprNEJ2UXMwa3drM3VXQURYWkNUUFhnWTFxM21YN0E3Mmk4d1Ex?=
 =?utf-8?B?V0JSTHIrRTNDOGVUTlBXYkpCV2dwSGNieVkrZ1pMRnQyOC9kMWUzYTd3T0Q0?=
 =?utf-8?B?SnhUMFpnRFc2b2lHYVY2TXJoRFIwMStlK05hbE8rQy9PZURPNGMwempSOXRG?=
 =?utf-8?B?dXNNU0ZFM1RxVU5VZm1tME9Ba21xRXIrbGQ2QlVUaFNWTFVkK1g3dUtBTmJn?=
 =?utf-8?B?K1ZFMVFVQjkxOVk3a21Lelh3WUQ1RVJIUnRUTkRuTmVWZi9lK2ZmcXJHS1cv?=
 =?utf-8?B?SnU2SmZtRlc0bXczUUs5c2thRXBxNmNMMURVcURTZjB6MGx1WjU1N0gzUmoy?=
 =?utf-8?B?bCt1Z01lczVOU2VJdWF1bkJmeEsvWEk1T2VtRjlMK3dkUXVRR3NPVmpjTzRR?=
 =?utf-8?B?VExCL3J2YTdQeGtjZEZUdFBZVTNIeDI5V2RkQUE4WHEyUkFLZDkzMnNTdFZT?=
 =?utf-8?B?Z1g2QngrR2FxQXJyYW0rUFNXVEFOMC9IK2VjeUpyd2hvQWFXdFJPKzU1M0tu?=
 =?utf-8?B?aGZyV1U0cDhvTHJobnZxTVZsUCsvckMvdm5OZ2hYeklKMi9ZVkNDM1lsWitE?=
 =?utf-8?B?VE9wb0hoWVNZazNEcEFValBUcHlZbEU0VjF0VWJEZTVGbitYUGZ6TnM1MjBw?=
 =?utf-8?B?Snh4MW9oNVZiMEpFREJYQVVsajZIdmhQbjZ4Q2MxcEdRZWpMMmdabmhQbkov?=
 =?utf-8?B?NFFVZmU2SVBISHQwOEpMYkZ3VjlqYTY5Wk1aeGI2dkNxU2dCNW9IRXFQVTlh?=
 =?utf-8?B?UG44cllHZWNBMTRKMDR2M216ZkdzMElXS05kRE5BSmlVNXFweDJzWkFUbTJJ?=
 =?utf-8?B?bEpBRVBJcmp6QVg3a3dkRHlQOVdta2toVXdUbDFZNkVlMXJOckVWYmJFZlkx?=
 =?utf-8?B?MW5Ea1ZqakVMM1YwbFNscGZ0WEtqWjc0MDlRNVNaUmtxd0R4aXJ4S0J5ckR1?=
 =?utf-8?B?cXYxUnNjSmE2dU5CZlhsckFmUU1VVFlxSUc1QU9ZUjVpS0RLRTNYSHIrUldU?=
 =?utf-8?B?TktJb2puT2RUazNlQ2FYcmhoQ3VUak4wL284NmZFWS9RZmdtVkVDbWJPdmps?=
 =?utf-8?B?aW12S0VYWTJwTlgwVm1JL21JVGlNaXB6NG9mVHRtNFg0SmpCd0FrVDRnc1pz?=
 =?utf-8?B?UVZ1eVRKWlI2Tmp2MEpJZ3VLdG5IcXFCajhRYk1XVW1VUkNhZzJ4Rzhqa05U?=
 =?utf-8?B?ZEFudTRXZHV3S0pxa0dyQ2huVkVSZmd5cFVScW1GNGhMaFRkdUhIbG4wTzhn?=
 =?utf-8?B?WngwMzNZTnhLb25SNFB0cUkraXBOdDdUaUJWS1Q5VTMxNS9mK1BiVVI3dWVT?=
 =?utf-8?B?Wi9PVzFGQlZpdFNBOTVQVEVTbG83WDJSc2I2QWFteWErbEFPYXVHUWlRazdL?=
 =?utf-8?B?OG82ZHdFdVBkVUxSQm1MbmhhKzJ0WDhWSEtZdGRtVW9VMzlRcmxFeUV3WXBH?=
 =?utf-8?B?a0txR1JJbEl1SkMzNGovbzhLZjV4QmUxOSt0SGF3cmk1VWxOWkpESE1ydW9x?=
 =?utf-8?B?b21xKzN2cEpNSFhXVDlrVFJiZ3NwTUFiRVVybFdWNWl5YnNSbytQQlJKN3JJ?=
 =?utf-8?Q?nhG9eY1lMY6nlWm6A9Qji+0MB76?=
X-Microsoft-Antispam-Message-Info: bT4SAW0g42y9yJGtHmz186wv0tlhOXw9OFbjsp15t1EwFaRwp6eCjv9hnXEj89yiDPxuEhy3b0nU/o1c0p8Zcf5Zm0zAaUQZQcnb1NuxMLRyKmmU3HynYFgRUHar+/v4D3mg5ZfE/HxnCx1ifHM8XmsmFNgHL8JfrhbuxNHCIykHYg2IHuwyDXUTqVLMjcIM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:9FxFFhqPyZ3Fheusc4LzzO2Aulq50tZehbd+uOxeLzz8Ed39sYRbGhPk5/L+YNQPOW9zqhK3XJOjUPTp9j9WF+6Q68BzfdhoPl7HX7k3gMCsnITLeLxA7yn7uyBBi9zo+1vMSG4zrN6mcKZGNioY7Fl99ohcLib/GpEjJiyLXqfbriNTxC0in+pwxdwKzROzpVOMt43K6cY92pZ48ZMcgQtVPAgpib5FYDn0pfWttmMsZAZNUh969rAWKAw1I9qrMEFJtAdsEt70ElGoICFRuJBxlOHChQW+/DdLpSfMZHJTWaBKKfQxwWHaQRM+oEukuuuZu3yiv1x5mi3eU5eFy/rcigDha9NsB646kxyo4egTchmmKJmRVVqeeNRR5Nn10pZP4VB1Uyurlq13p26/QSGbapHae5wZTEHG5VYDx8YiwHnB6bA0Bnn8Vl0HO024tXdo0vI7jZHI+j7mIqW73A==;5:DXR+8+n8sQS9/QXeRKK+gIau4SFov353idptLViaLtPm/0g1SNjMvZ/mrD3BBN/66zYwodQPJr0lkfLX3Q89EGkoNBaCpXrcGvGbAsfHJAmuV3KYhkDt7Xymr/JVTfd+MUiR7xGIrMH63sBLz1p4pL9D/anofRF5OXIxEGUGQGA=;24:ayInagppZJoAOackt8/H+SbtRtv0Z/2vEthINDJqURkkkgibC0j47vGYwP4ks5TBNZ3HRfwx4NFdFvOVc67n7h+k0IE7x/RIdgPTUtKvz4c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:WPbZu0nCbnrnuh2dAE5PI4cN67FB6FQ/xbFWPdfReF4w5/Q9GRmPXXFL2EXSMCjZ11u8Iah9FSp7E4PlhUvu0ce01Tk9srasJDmqrG++nRjsgXcTE0CdXLHV/UYTdmOyLu2jVEvn+T3dESt6AeukwGl2b+uURs5R3e6LmldRJEceXW3DdS+ETuvRTIvscdSEIgRjI6vmi16+MZ6e2JVgg87S9xjHySTVvCCMPh/4YC+O1YhK2c9e5N0DOZpP5mBr;20:F1YUYas5t5eovH724zs156FEKeV6KzUia/xJVSwPAhN0Y37bNdComr4z3yHbzJEL8zU5eX6MarXqJA1aRQZR1x4dVN7R63YEt9o1kv9zCTcRqL2BJFgL/1O7pMiO/MjeavT0Yf/jqbyxXdLi05HRm9xpCxGIMEB0ZREtRKnqYPk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 15:20:58.2216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69762b07-2d83-4a5a-73c7-08d5932d2eb5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553609558263575?=
X-GMAIL-MSGID: =?utf-8?q?1596014110085785036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24.03.2018 21:45, Vladimir Davydov wrote:
> On Wed, Mar 21, 2018 at 04:21:29PM +0300, Kirill Tkhai wrote:
>> The patch introduces mcg_shrinkers array to keep memcg-aware
>> shrinkers in order of their shrinker::id.
>>
>> This allows to access the shrinkers dirrectly by the id,
>> without iteration over shrinker_list list.
> 
> Why don't you simply use idr instead of ida? With idr you wouldn't need
> the array mapping shrinker id to shrinker ptr. AFAIU you need this
> mapping to look up the shrinker by id in shrink_slab. The latter doesn't
> seem to be a hot path so using idr there should be acceptable. Since we
> already have shrinker_rwsem, which is taken for reading by shrink_slab,
> we wouldn't even need any additional locking for it.

The reason is ida may allocate memory, and since list_lru_add() can't fail,
we can't do that there. If we allocate all the ida memory at the time of
memcg creation (i.e., preallocate it), this is not different to the way
the bitmap makes.

While bitmap has the agvantage, since it's simplest data structure (while
ida has some radix tree overhead).

Also, bitmap does not require a lock, there is single atomic operation
to set or clear a bit, and it scales better, when anything.

Kirill
