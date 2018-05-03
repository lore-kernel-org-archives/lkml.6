Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZr+Cg+LudepoIpCiTb/+/jWyGqw8cljj6g1T8a+HyXZs4eN5PnZ2yKZmrcwE5nySVRbGFNW
ARC-Seal: i=1; a=rsa-sha256; t=1525346167; cv=none;
        d=google.com; s=arc-20160816;
        b=V+Pv5pogkJ0NKIIbe+1B7uvpbnJoU/eygtCzJskqGIRWNOGI65Dlyk8WF5WmVucLv8
         LSE+/8mzu4u5bppZs9uGS8f0xEuDe770AbJcSwhlcTkqs/F5ljz11GJp+Qf7tEXn7ieI
         6liHaHjQS++L9koppVYOupsr79JnDx+QIDC83mVXl+RqKsrKoC3HeCTKj0IdB2c6CN3l
         7LM6g8uuv+OkTYLBB5e8U14Pw275TWrqWkndq91vA5VlgtYcc//xotEWUMV24n731Q/f
         8p1OJH/DonVnGRRDyjC5OXhNTFAbGhg0yuDhDsQt6PkL3bNwZFDuArZCwnRaqMAj9IKf
         D1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=PfX0yT1XmhtIiO8g+p4LWAZV2eUn5E4YmBPROQd0ayI=;
        b=UbwDPA8dBZ/JrCInWkLmtkJlY5xj9Ta/WIkx0YU1+whbwGwrI+dglt8dWkCJYP4qmf
         SY9s/tDmrCVEHlIWXtrvy/W2q2ADlteVAyQasbD0DWY61c5CPY/3F9JQ6vGJXAqxfPBi
         c7xKkk3DQWsbtYiuKppKn2peVCOWY6eeWwyCVNpQZYwDCfd/IQrRUlEDYT/f5o5xNSGa
         89fjsZd9qD/1tHhp4kOqCJdkkSAbj+0WBIP2Xr+ZzQhn8ZG3h71RcMYLizSRZ8qR4gNo
         z+Vu4sfhTQlHlkj6dgyqdnX4EYIdD0gblrVgaaeD4+Z2cuGU21ysrI1QNwBYl/JjU7mF
         ZJUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=fnHN9SLx;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.106 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=fnHN9SLx;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.106 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v2 04/12] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
 <20180422175900.dsjmm7gt2nsqj3er@esperanza>
 <14ebcccf-3ea8-59f4-d7ea-793aaba632c0@virtuozzo.com>
 <20180424112844.626madzs4cwoz5gh@esperanza>
 <7bf5372d-7d9d-abee-27dd-5044da5ec489@virtuozzo.com>
 <20180424121516.ihn6lewpidc34ayl@esperanza>
 <402281e6-6fea-3541-1435-a2f81e705e2b@virtuozzo.com>
 <20180428150827.b2bh7hhma7pp4av5@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <96bd3025-2b8d-9ed6-c60f-3793102932a9@virtuozzo.com>
Date: Thu, 3 May 2018 14:15:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180428150827.b2bh7hhma7pp4av5@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR02CA0105.eurprd02.prod.outlook.com
 (2603:10a6:7:29::34) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:e/WJjxVls4qtqakO1BFTl/mt4lDZoolXPnRINYsCQKbjfDUVS+2IDMEVB+F8S46HtF0xPlSU/OR+zuI+rYCT0fRAZluDHxsaIAGN1q7p9PmFch0fcjHfHew09EjvZACojZh+RIG4g35EMjs+8iIRolEBevK47IZk3xC9anS+5jiTqG68Fjn7MFeZZHwKoZzkulKsxTA5uUX6pHhdNGbnwSpBGgDHgaxDcX6UZbjYBnitRXHFgDp22Nfuv/rynqot;25:GN1IbtcBSHNn+geHWPQoqfTyQ1Af7N2XOQf+wiKmp1dWGo2a9zqY74YE5hbzCwQNaIUxtUVpqgA4EVIvi735hCFCajZp38NHRJGjX2keboO5ZOxRe5jb8+8X9u3URb9bsAuNRheLaCZ747nI3IUkD8YWlYeyAMOrNsLWxZLktiXqPOc+9JvnD+845SA1vJVxUq1cYv+d1xLzOJdcg+MUktmCJ001LbTEO/Rja9sNrrK2PGAVtuycP4IY9wfndvxITK6ZeS5stsJiuk0AHYwPl7Qfl1EVMuwLzJvWhFgSO4fvmJUsI/LtpEXTBBLOIW3B1ST7FSnmePMkLXNw++T5yw==;31:5SMRmu8Ze3pZ/V5q9d5AyQDxT4EejPVcp2Qqf+UkgkY1uK1dfV0tSWgQ2WNKVP8of/vEK/1HraA65fltI/GTLUOy6bKKC/M9rFvhye89/vBah3I+NWBrNke7ZX/vwpHIjelEFf2ZtqZzF2Ekk/FyrH3+QMofKI5CMMf168WEzq6PSnjCNFDnBny2fPvyp0DHn+Pb8gvBrFnD4K0VqFGepeIimjYGwkxF8MtJBrIohyM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:gnCni9HXtOZQ+zX/Q2gEdnBrdmo9dtP0VnvB4xtDpU6F19yNcSXeEnCM9daSNn2Om06dN14CHW4CAlGwfNtEZgzS5JNl/MSYc3kWSeDxmAuCOrzXNS0F5hxTZj9pfVh6JRW9bfmdsuhOH6BNWlUC+vTCUh7KWL5UFv7c6tC6LzS5WdFFEEBpnGjxqLcvPdWvSDwCi1auR22WR81HlMI+EONn/AEeLzQVrW7gowj8MV8smXAsUHqhqckpRb459SV+2F7ebuDJ0wbRTapT6XC5SbpaIZvV5Gvca9Gwj+ByDIyrQWr6mzKfJX75AsFay8rpSGuuCdkZgPA1kW08uH4GPtgUtgtE8n4UpGpXHzBSLaxRC/bUTXaudQanOArPxAk9qhm0q1VeobvuDRq9LPxkC/CZ+/kkZzhG7gGLvgivW+CMddBsX1oftt3MquDWg0KiPGea9QGnFKeTO6aVbSGHNv4YQf6XIEZyAutgUAYPyCZquPACn4oBqYZd8YsRaVD6;4:EO5+65tlJe9J94bq9D/3QeDKrB9x2fDj5RymEQVVxgLqN2KXmi08JCwM2H/EsXLRdqGfxxYh9mauYXey0QXk5c+6WhCY+7/wBdSYe3RaR6zEeq0N73DpXFM9NoH1TftEs6EleF0R+LWcxx5l/5yPjY5StSSbgPrYXdbX8AAvn1SHmOl3DcmGaxor8pKx13JCosAR3POHHx4nJIniC7wrZcut7pNd24AUK5f3lB/M9Ds9KOp+a6ugQjnlhoqZDeTqyUqh5Ezp+6Gpyluj8xTSqw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13382550D2AB6ADDD903E53ACD870@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39840400004)(39380400002)(346002)(376002)(396003)(199004)(189003)(65826007)(6116002)(7736002)(305945005)(86362001)(31696002)(5660300001)(59450400001)(76176011)(64126003)(52116002)(2486003)(52146003)(23676004)(6486002)(446003)(11346002)(2616005)(956004)(3846002)(230700001)(476003)(486006)(97736004)(6916009)(229853002)(7416002)(77096007)(36756003)(26005)(478600001)(316002)(68736007)(53546011)(47776003)(386003)(105586002)(66066001)(65956001)(50466002)(106356001)(65806001)(2906002)(8936002)(81166006)(81156014)(8676002)(39060400002)(31686004)(53936002)(16526019)(25786009)(16576012)(6246003)(107886003)(58126008)(4326008)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.45.234];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6cFFURHM3b2drajBKS2NNcFVWcVUycGlO?=
 =?utf-8?B?RG93UC9XV2pyYTloNVVNOXBET1FkRjNOaFJDT3dIL01FcVY5YUFGZ1JZTFFL?=
 =?utf-8?B?RTZlaHVBeWpDSHRBWmZ2NGdMMWgzdWhtblhHbWszNWJRbEtjMi9RTVJFM2ZC?=
 =?utf-8?B?cXdUMjJ2MnNsSGNWRk04SjZXaHJ2SUdaSTJ0c2Noa2lURHFGTUwvWGlnME1y?=
 =?utf-8?B?Z1FYZGlEVC9pSkFKelVtdHRKTEpXTHdCWUR6SnZxa1c4NW5LcExVeWVoR2xR?=
 =?utf-8?B?VEhhaHlnNWFLSU5OTkl1T05COVJoSnQ0VVU2QzdLclBEakp1b0Zrdi9zdWor?=
 =?utf-8?B?c2s4bEdYRUhOa2lxdjhWNFRPZ0g5NVJhbTlKMWVVdnh2YVU4NFhJdG1ySUNp?=
 =?utf-8?B?WVV2eGo0ZWJwUlRGd3dzQ3ljb29PcUNoWm5ua1FxdEd5RXBkUENrSGRVbU5a?=
 =?utf-8?B?aXoxdi9FQ2ovVUx4QjlIR1prUjhVZTF0bk9mMHhBMm9sVHJqbklGMTdUQXU1?=
 =?utf-8?B?VmRwWTFxMm1TYkczamk2c0xqSHdKaHJBU2ZNRC80ZGRYQXE5M1plQUlnWnhL?=
 =?utf-8?B?SGMzeTh5T05HK1BodHlrWnJudWN4TlBkeWFrR1ZKZmFFcWZwbDNMS1N0aGFX?=
 =?utf-8?B?Y1JINkV5bW1FK0x4S2QwRUUzR3FKNVlMSHQxL0pCWG5GVy9iNTRKa3hPNmRx?=
 =?utf-8?B?Zk83endBZnpSYitDcVZSMWMwYlpBWXQ4bU1zVG5oVmRhQ3BwOHhVczBLN3N2?=
 =?utf-8?B?QmFCaE1BQTFBS0ZuWWpCWm9ScTJ6czdtWHljMVFXZkpBc2p6UVFKczh6c1Ba?=
 =?utf-8?B?cGF2V1RwdlRVS1RkTHcwdVFKUGxOaG80OVl5OGRQem9OUmNHT3Izb1FGN0Vj?=
 =?utf-8?B?UzhwdktDUUwwQklhSkNWZEtsV2RaVXRIQ0FxUEE1MWg5S2hMNXhDUWd3Wmpi?=
 =?utf-8?B?RFNSWWczS2JDWW9VaHpqYW52OFNZcWxhakxQZnRsRHNoL3Nzby9sMXVmYWZz?=
 =?utf-8?B?VzhrclNVWEcvNmM1UVlQSVowVGp3Y0xselJVU1VpbHdqVkczbC9qOXk4MHR2?=
 =?utf-8?B?clI1ZXJ1WFhCRUFYZlErTHd1blBJdmd4UDlicGFUZm8yMTE1M0VnenpEVGQ1?=
 =?utf-8?B?TktvUG9UUVQwcElzTE82ajV4SkE2WUtubDI4UWdVQWMxTlpKZHd6MzRldkN4?=
 =?utf-8?B?RVBzM0V2cko3WUs2bnY5NE9JMktsMmJwOERoaGFUYTZFeTBJWDZGU2hSV1c5?=
 =?utf-8?B?NSs0UHBpMTlMMW9KbXFieHFPSkZSYjFWWXg2SFUwbmNacDF3eXpQcjYyeEp2?=
 =?utf-8?B?aGd2MzBFS0tZRVpiMDR3bHlqNk1qdmt4S0J2YTE4TFQxVkErODAxbE11Y3Ri?=
 =?utf-8?B?TUkzcmNTUDhQV3gzTGV4ZDBoMW9ob0FoZ01XZzM2NC9pNnluTG1qUzVmaXdn?=
 =?utf-8?B?TDl4dm54Um1RZjBURFlqdVNMZWV2MFZnVnJhRWo4WUF5UHpsK0ttMmsxK3Fp?=
 =?utf-8?B?WnpaM01wb1B1WEtSMU10Ym5NSW4xcVN6R1BGVjdiMFVwTUpuWm93YXJ0azFY?=
 =?utf-8?B?a2xMeEU2NTM3WjE4cjZ4bHJ2VGVDZFhHdDhNNlA3aHhiMG5oczM1U0F1aVFj?=
 =?utf-8?B?bTFVYmVtTzlRQys2U3daWWZKbC84R2xJMmxOKy9jYWwraUdVTHlXeGJkT1po?=
 =?utf-8?B?cmswb2hBWi8vemVvY1VhUDZWdVpTd1FxcWQwc3I3YlZSbjlIQm5hNFM2Q01u?=
 =?utf-8?B?eVFWWVYrODFqczYzSUtIYWJucmJsMXA5ZVAvYm5DNkp3aU5KYjlPNTZYaHVC?=
 =?utf-8?B?dTdRd2RUNEhoV0ZKRHFaT0U4endZeThXcGNMR3RzVjNQLzdyMTc1LzR2WHVa?=
 =?utf-8?B?NERmbTlXLy9MaUZwcFJqTVJrb2Y0NzlhMTJGb01YTXN1aExJZmdCN1lPKzhu?=
 =?utf-8?B?L0lqTHhpc25qeHd6OVNLWTFaWXc2cUdrZ213VU84MERNUnJBb3Z5KzlqTE0v?=
 =?utf-8?B?L25WMkJhOVQwUHhLa2xqZUJ3elYwUk1xNktlSGlRPT0=?=
X-Microsoft-Antispam-Message-Info: vkjTljr5KK6fADGbRMk6sSF4c3dqsjK0gfNM/SfUElxd0U5FTLT9knYMqUa8mtsMxr1kBwQLMWEQDYTP4RGOkVZeEF0EqVDlCzUenpOnGI7lNMybRmJlLtd2UR0Ri2670YdHYSctvOIHp6lOZQYmvI+befu7FjABo8PuFK1sRxA3gADpvtNKO4P6ifEzB1pp
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:CI5McpClnJXoMdwlBTsPRAFhhFNmkDTU32uVl5X0bLv47H6xELpM7A7HLLixWaDvh+/HcP0R86D6iJnQuoa/wE9ECwZz2vbHiFuyw8AI7YtijXdxX72LimXSxUUFXORJxzfzu7tYrMcd2hHLLUHNsJb8g1WU3csTaq50dEMcAoRSqkx3Q6t5QYrggdE77PYqKS18sLSZMP8vdNS7ZkF68UYIG1tquYOnsdtEclBrogN6n6H6EB/exTndVYF0eKdG6nN5zXf149jnuODwP0AMMe4PYk6zXZk2vB2TCSuMng5qxxWcsqIg7cBLuKsqevkFcJ2VA3RFEq3xf4B+wdCT1osFzI2mXIO6ghPoRHO320zVYDD7rDrRHWNk81Eo7zGVeFBVmkm1Chlc/reEx1zFMYOpwsgBetqWrVH/OFWNY+D4BroqZciWEosNgLz8Mi6i/lnSR6sG3iLQomeZhi9taw==;5:+WPoFm89HCkbrH98tJrsmlU0B+5yqAC/dkxI648eAYr6HtI0OXzlopETjpj8uwMBQvUGLzPFJfQJ4+K23c5FhAaSd2bGiDanfpEJrsCRKvIcl+77IUsvHG+7+4uBl9vTp/5r65+9Bue4OkLpG6J2sVK0UNucrSdVImVUaXQQHxw=;24:j5h6Ifje4XXWgxENhVccD2OTKn/iyn0E8Z09aCq9uawaYk1/hn2ryHsOptAPJDUwuM+iLdD7if51eknTfLEL+JWFlhJhGlmrsqRA4nfrgK8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:lBvGDYC26TsPp6MRSzfJhrcNqyAFQ/ohfrfdb/S/V3Qtf36azwFsgzVi+weXSm4pjGPW7o7ochVerNGQHU8SnxvT7u/XvkQMGoiOCT8NDXreA1pl4Ll9vhJ4FRsTynC7upzE93OzEekZakWZGk3CTjWgrwdKcWLj1iVvhaze2Z7RnN3aAPuiL2w9iI9yFnIV3/lvf5rLKPrmrzG4jWXtj8z7hAkq6gB2xT4Cj33OQZpYHNcDCEed5dzayzlbcRrG;20:H8y66Lc8lsgQjKymeF7mUdraSaNSmA4jFNTzPzoQp95YAPGya2EgfufEdZfjBSBo/gxYPKGYfmXANNrdkPIlgxQtwOZtqbIp3/sOY2Gfu794q0uTFaRUr88ov9d3GargD07I4HfWwtW/kzUmRzEQYocfKa0IJNZNP5KxBmSNs2c=
X-MS-Office365-Filtering-Correlation-Id: 43d5b98e-5a77-465c-5fe3-08d5b0e74130
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 11:16:01.1041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d5b98e-5a77-465c-5fe3-08d5b0e74130
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1599441382939148990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28.04.2018 18:08, Vladimir Davydov wrote:
> On Tue, Apr 24, 2018 at 03:24:53PM +0300, Kirill Tkhai wrote:
>>>>>>>> +int expand_shrinker_maps(int old_nr, int nr)
>>>>>>>> +{
>>>>>>>> +	int id, size, old_size, node, ret;
>>>>>>>> +	struct mem_cgroup *memcg;
>>>>>>>> +
>>>>>>>> +	old_size = old_nr / BITS_PER_BYTE;
>>>>>>>> +	size = nr / BITS_PER_BYTE;
>>>>>>>> +
>>>>>>>> +	down_write(&shrinkers_max_nr_rwsem);
>>>>>>>> +	for_each_node(node) {
>>>>>>>
>>>>>>> Iterating over cgroups first, numa nodes second seems like a better idea
>>>>>>> to me. I think you should fold for_each_node in memcg_expand_maps.
>>>>>>>
>>>>>>>> +		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
>>>>>>>
>>>>>>> Iterating over mem_cgroup_idr looks strange. Why don't you use
>>>>>>> for_each_mem_cgroup?
>>>>>>
>>>>>> We want to allocate shrinkers maps in mem_cgroup_css_alloc(), since
>>>>>> mem_cgroup_css_online() mustn't fail (it's a requirement of currently
>>>>>> existing design of memcg_cgroup::id).
>>>>>>
>>>>>> A new memcg is added to parent's list between two of these calls:
>>>>>>
>>>>>> css_create()
>>>>>>   ss->css_alloc()
>>>>>>   list_add_tail_rcu(&css->sibling, &parent_css->children)
>>>>>>   ss->css_online()
>>>>>>
>>>>>> for_each_mem_cgroup() does not see allocated, but not linked children.
>>>>>
>>>>> Why don't we move shrinker map allocation to css_online then?
>>>>
>>>> Because the design of memcg_cgroup::id prohibits mem_cgroup_css_online() to fail.
>>>> This function can't fail.
>>>
>>> I fail to understand why it is so. Could you please elaborate?
>>
>> mem_cgroup::id is freed not in mem_cgroup_css_free(), but earlier. It's freed
>> between mem_cgroup_css_offline() and mem_cgroup_free(), after the last reference
>> is put.
>>
>> In case of sometimes we want to free it in mem_cgroup_css_free(), this will
>> introduce assymmetric in the logic, which makes it more difficult. There is
>> already a bug, which I fixed in
>>
>> "memcg: remove memcg_cgroup::id from IDR on mem_cgroup_css_alloc() failure"
>>
>> new change will make this code completely not-modular and unreadable.
> 
> How is that? AFAIU all we need to do to handle css_online failure
> properly is call mem_cgroup_id_remove() from mem_cgroup_css_free().
> That's it, as mem_cgroup_id_remove() is already safe to call more
> than once for the same cgroup - the first call will free the id
> while all subsequent calls will do nothing.

I seemed confusing a reader for me, but now I'll agree with you, since
it's OK for you as for a reader.
 
>>  
>>>>
>>>> I don't think it will be good to dive into reworking of this stuff for this patchset,
>>>> which is really already big. Also, it will be assymmetric to allocate one part of
>>>> data in css_alloc(), while another data in css_free(). This breaks cgroup design,
>>>> which specially introduces this two function to differ allocation and onlining.
>>>> Also, I've just move the allocation to alloc_mem_cgroup_per_node_info() like it was
>>>> suggested in comments to v1...
>>>
>>> Yeah, but (ab)using mem_cgroup_idr for iterating over all allocated
>>> memory cgroups looks rather dubious to me...
>>
>> But we have to iterate over all allocated memory cgroups in any way,
>> as all of them must have expanded maps. What is the problem?
>> It's rather simple method, and it faster then for_each_mem_cgroup()
>> cycle, since it does not have to play with get and put of refcounters.
> 
> I don't like this, because mem_cgroup_idr was initially introduced to
> avoid depletion of css ids by offline cgroups. We could fix that problem
> by extending swap_cgroup to UINT_MAX, in which case mem_cgroup_idr
> wouldn't be needed at all. Reusing mem_cgroup_idr for iterating over
> allocated cgroups deprives us of the ability to reconsider that design
> decision in future, neither does it look natural IMO. Besides, in order
> to use mem_cgroup_idr for your purpose, you have to reshuffle the code
> of mem_cgroup_css_alloc in a rather contrived way IMO.
> 
> I agree that allocating parts of struct mem_cgroup in css_online may
> look dubious, but IMHO it's better than inventing a new way to iterate
> over cgroups instead of using the iterator provided by cgroup core.
> May be, you should ask Tejun which way he thinks is better.
> 
> Thanks,
> Vladimir
> 
