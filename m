Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E24C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191C02151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Vln0tJVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191C02151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbeISXRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:17:23 -0400
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:59710
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731569AbeISXRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+c+1DNIqzt9EaBFEameOSYSlLzEOeeEzMzxTwkGORg=;
 b=Vln0tJVYLkVXks8ObR1eAjeXUtLH3rYzjxP/u+vZdCv2xfJ72wVOtMg6bYDZ5OxdiVeAruiP9RbSBDkJ4IO4dbFYPwyWpMNTiBUN5lB2w03exgFYGSroQg4LxwzWYb7l96vwHAxTuC1hH3bWUE9Kmw1kxrYjPiEEnAxxMrAFFeo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
Received: from [10.2.206.68] (217.140.106.49) by
 VI1PR08MB3296.eurprd08.prod.outlook.com (2603:10a6:803:3e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Wed, 19 Sep 2018 17:38:15 +0000
Cc:     nd@arm.com, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] glibc: Perform rseq(2) registration at nptl init and
 thread creation
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
References: <20180919144438.1066-1-mathieu.desnoyers@efficios.com>
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <c58d4d6e-f22a-f5d9-e23a-5bd72cec1a86@arm.com>
Date:   Wed, 19 Sep 2018 18:38:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919144438.1066-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: DB7PR03CA0048.eurprd03.prod.outlook.com
 (2603:10a6:5:2a::25) To VI1PR08MB3296.eurprd08.prod.outlook.com
 (2603:10a6:803:3e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 612269e4-cb3b-43d3-c530-08d61e56aeb9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3296;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3296;3:YfTnwN0oqsHZDpD7lyMucm9KrLGt486k/Ib2M5g62QoY+9biieX5hx0Wz7NHkW7s5fRDWTjlw49T49eL7/oZlD6dP68ZTzUDWH/vX4YXVP9zQUsslR7vsTp8r3IcQqnIPOK4FuLCAkIrcjXJmvzC3VL54fXZjWMdXF85L5BFlIUWOoCrAy37c/i2YRl7lbLnP8lXD4eHeM5HSfDbg3+igfqjkOsozfmwnnv7kXmE5Nw2oSrvCVE37SlnTVzI2Zqb;25:Ey+X7hr9HDYq56vppPsx7CbifnQorRspT7u9DM7v4huj80N8OG0s0sf3r1Bo9lovuh5FDZaFMHBRgq92OIi5ogp6rrZFmycpFB/KE8hFBcKXsIIrwsMulXU2xkwKGv412PNydvit9oq2WquD5yO2/lCEjRXwjmmPoiGHA0ym+/38bA1qwQuXuMfpR1AxlHZn7tAtjEhWXXJXmhiJDkxGXmHc9Nw4brrYWBGpPg9Zbk2mXogDf+EhsdPagOyth37H7texrKdoOVB2awoxQ1mUZg7Gx5G/TgB8wbHBecOkUuB/RkPDAT/R1PzcKSUSqOnfb6Y5g4iWtXtsUIQJLRKZHQ==;31:K4dl2rBZ4YTjJ+iyAgNche4tT/mzZelpZ8wxdodiPQuaNk1NlaQmw2FlvH8q6F9Qo0KA/2QPGclUOPgYVhjxkGHWWLv211a8wUspRzG4+L+GdcYO1/FY7/VClLBZau196+l8SoXl1j14H1pst1LC6F0hhTQY1A8Jy5UrPbpl8CVV0GeLtH+1fjNfKZAC6WonuB9JfIo93AFdojdc6kjHVEvIxtFYWKMo0l/t4FiFhz4=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3296:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3296;20:mYqUmxSufCVGa+DAp51HnKdHiMdPCZ0HDpI9efmf0fHFawYUFkwM3j75yrINx9URZWJ6BsJxeIOnpMnnJGo+tuloR9thtemilhaQud+iy7e3I8mZTZscvh+e5JWXMn2ijnYMr5CViDZFtYlc1rnIw8LFO0GtnK90SXPXKDFQdBxoPE0aHZnXHelBUpfWwDwoTc69RVHVx5nkIkgJcHMRHDQsxVkABOi8az8t3OveebvI1okcMdW3+iUMM7jiOUraMCcsxk5fH1JCSCmOz0eP2CUxGGeWtkge33dlsuKdOW7/5CpIOBBVZ0bSXCxE0HVe+D1FS++QTHI6OLdf00ll2W4b95JNCb95ErydMflGa625ypd4Xu5vd40gexsELT+kcx40TabhAtJOt3PqGKOa7vNA5HJjuguxUf3zyETY3m8=;4:9xNooZeZ5ysOm7acxuGIhaVJRNUx5i+ModR1QlPiouzGyoyoHedyQPFE87j1Wl5BWsZoFL2CPkGbOiXPg9Qm0AOLCHOa4D44DWC09Ys1yCuhwUCdT8zCmu0JtXVAdmeRP61/TkKwGvO8HcQlvJTplCdon2NXCWY/qdZr5yAtyZ88cSBXEgoZFnNMxQfxna7Nuun6aLmBNEA8ZhUegAVw9PmybzlCW/mZfO9n6ZESj5iGAy4CuF/N037kP+BpdLs+D/WKzE7rAPWyaqThkVpMDxxY37LiZgsPQuGsi/p83HQUGsfAIv23nF+pB6KYH2+C
X-Microsoft-Antispam-PRVS: <VI1PR08MB32965C200645F6A5808C7ABFED1C0@VI1PR08MB3296.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR08MB3296;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3296;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(66066001)(76176011)(16576012)(8936002)(7416002)(229853002)(186003)(7736002)(68736007)(6246003)(6486002)(2616005)(11346002)(956004)(39060400002)(305945005)(64126003)(486006)(2906002)(476003)(26005)(53936002)(4326008)(44832011)(386003)(53546011)(77096007)(6666003)(65826007)(81156014)(47776003)(72206003)(8676002)(110136005)(105586002)(16526019)(3846002)(6116002)(31686004)(67846002)(97736004)(2486003)(23676004)(52146003)(478600001)(31696002)(25786009)(230700001)(36756003)(65806001)(54906003)(316002)(58126008)(81166006)(5660300001)(106356001)(52116002)(50466002)(86362001)(65956001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3296;H:[10.2.206.68];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjk2OzIzOkNFVGZxRVZ0UGZ0WGUxRnc0OWkwV1R6dWJl?=
 =?utf-8?B?WDdwT1oyUHZxV2huWDFmcnF0VDNwSWFpaktDZGRwcjBSNEhpRklqTTYrQkhi?=
 =?utf-8?B?eDZsUUE5WTk2SVphTjdxT09GRWhEbmx3aFduNkQwcTdMVFdpRkp0Sk16bVVL?=
 =?utf-8?B?ZVNmQ1k3N2hGQ1l5UXp5QlpWS0FtQWZia2hZemYwME5PRWNEU0pkdytEcndT?=
 =?utf-8?B?ay9Zdm0wWmRUMTNxMHo5amJjSmpiOFJqYjhuZ3RtRFZnMmNXSDhIL0hZT0d4?=
 =?utf-8?B?K2pLSEZNOHBIdUlFTHJKM05PL0cwUTFIcHNBUWZJZUdZVlB1Z2R3MXQ5ajY2?=
 =?utf-8?B?dk4yeVdOL0FrVE9Mb1FLQkxiRlB0WWNKKytYellwN3ZtVGtZS0ZMUzdZVnNa?=
 =?utf-8?B?bm5TY2hTSlVySllPN2I3bkUzOEp0N1VXb2dnR3JCUkN2YVhINENiZS8yZ2My?=
 =?utf-8?B?Tkgxams1Q2RtQTFOOTB2cGk3d044ZzVWNE53M3NoVlFKcXRNdWcrY3BITlpu?=
 =?utf-8?B?b1Y5SVNTSHdTaUtoZkszSGdGUC8zQVJYL1d5UFI0amthVE1YWk5oK01ld0Mr?=
 =?utf-8?B?elRoVnhJcWYxbUcxWlhNYUxXYW9INXFuUnRDdk5iL3lWZ1NlUC96bVJSMUJi?=
 =?utf-8?B?T0hsWHN6RXdIcW0reGJDcEQ1NVlKNi9VbyswM0Rxbm5xQnhEcU1lbmtOK1A1?=
 =?utf-8?B?VUtxeS9qaExnSkJhYllnNlJjMHdQVlNMakZEU1YvUWx6NVVSNko0cDAvQTNq?=
 =?utf-8?B?UzZMNFdSRUlRU2xkU2RPaS8veDd1SytpNzAwL3BiNEFKZFYxTGlRL0ZOQ1hG?=
 =?utf-8?B?MkU4ZUxYWUErMmpUUWVJdnlnTXdKdEIyVUsvV0U4YU9CRHNFazViSzlxODIw?=
 =?utf-8?B?K2hQMHpZcFZSbHhtcWg3R2x1QnNiUzM5c1ZLUGVaTjVKSHdzWXBTV2FGUWs3?=
 =?utf-8?B?Yi9LOEZOWEljako4Ulo1WkU2TUhEWVpJOE44ZENxMFhwUS8xcXpqdUZhSzR4?=
 =?utf-8?B?aEZsMXJCNXg3L0FaSDdwZ0orQnprMHJDUm94UnBKcmwwQTc2RFEwK0RaVDJQ?=
 =?utf-8?B?UStWRlVDdEFDYmZSVG5YVjNRRkV2OXV1TktQUXVVencwa2lBWjZSekxTUDVm?=
 =?utf-8?B?WXpsUTUvY2J3WE9MejFDSXh0ZGp0eDlWVzhkK21HYlNUc2lGRHJBVUpNVm9h?=
 =?utf-8?B?Y1R0OUdHWk1NQzIybWc0dkJLbG83YXNDMEJ6WG1NQ3RUSEN2eUNVamVyTk12?=
 =?utf-8?B?d0x3MTNmT3dmc1FUbStuZXM0ZjQvYlZjeGE2QzVHRWlabDlGd2FuSTlic2M1?=
 =?utf-8?B?a3VIUlozZkpvVzFlMzNaVDBWZExXaWw1a25QQ1Fmd01abElQQWdqZjZwWHFk?=
 =?utf-8?B?UEx6ZFFLSmNvWUNPNUoyVEw3TXVnWk54YVRoQmwvNmlpVGFDZ09aa3NpRUxX?=
 =?utf-8?B?QXdKL2RtRlAyeEN3Rzg4MVNIZEU1V3dRMzFFSmY0ZUpER3lLWHJubnRLMm1R?=
 =?utf-8?B?S0Q3b3k5T0VWeko0WkpXOHpiRGJpVWFhdHQvVURwV2x6emdLUjFDaHZvczBC?=
 =?utf-8?B?NnVIUk9ZSGJNclR3djBQVE5UWFhib2xPdG1HamJrTTNKVjFhdXI1VXZDandD?=
 =?utf-8?B?TDE1SHZGZW1GcmIrRWs2eXJpWWl5OENzRnE0RU1LYTdYMnFiUitJa1U1enpu?=
 =?utf-8?B?Q2NneUFKQURRL1NPa1NHNHhWVHNWaEFZRGNGYXArNU9TME9sZWh5ZTVHbWpO?=
 =?utf-8?B?eWZEVlRzTG1udENUdjNKOXRSS2JUaWRmY0lvZEhWeE55YWt2ODlPeEI5aWtB?=
 =?utf-8?B?cDhKUHk5aXFyT01OV2JNaWxDZUlSeWdFZ2FIUUVXSnZsMUduR1hDeEhIaEhm?=
 =?utf-8?B?UFMwcnhrYTVrVTBpa0R3dS9zL1VJV3MyQ1FCOVNYaTRKLzlGZnNHN0U2Q241?=
 =?utf-8?B?dXFKUit5RDVFcFc0WUt2dHNIVHNUSWFCeFpZU1JhK0pIRmNmRERadnM0QkJ4?=
 =?utf-8?B?MFhvVGQvSDJ1dEtMWElKTnZrK2wwbkpJZHVOK3Nka1Z4TkZUNFdLcVFHRDFZ?=
 =?utf-8?Q?/4WxydzZ2V+QFgZiWWZrbpen8?=
X-Microsoft-Antispam-Message-Info: PWnxtLYNKt6Qt/8PrjXxzzXfWyMmJlPu7lmcMxlRQet9RcuESJh7aUnCF3m6GdXhxmgFfWd/leumOJSr4EdFxfDPS6b24wgGrAIqmB0Vg0CheB4Xc5jOHssvS4WddPrWH98kITS8nj43SEH0JTXboCkY1wYbS5xjEjWdOzh3ZZMpQe5w0Ww3NMAAzC77RXSRXNuaogzQIMfeOUbu8XGgx9EuJZRG1J0SFM0EAxv4/9kUHsL58Kv04zWbfRr8J83fl/RohOfZsHdtm1p9xMMNFy8E7RgXPoEadnVUsmsdNMG/898oqpDKXMQLDk6BSSoGB/xRqoZTzPuyRNLj3/8k+nEDoT4ply4kOtoFgug+/QA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3296;6:scT5nVeC5foK8HcL1/Uscsp0L3+/6Ysq68mpXL+hRyt0U4zmM/MV2b39E99AxA18Ia5acaHX/qrflTEZRv7AzTxzyrlEOwWDOtxfEds6nOVx+navDccrhqmveXYJEvzdGIkY2/uJP+Pyd4AOcujoovQ4BeXvfehwyWyNNgccauvYydVNS8b9osz7oQVWgNJKd1fuLgXqHZBr2e+F6xMa61Rrx8inJdrlERvoH8iRUAtZPN2ZCfVkzL4zDrASvtT1Qi2UMcMjT8wvwKaonlUc/BxK6SRijwYmZAkr/YvIN6sfJLL5qh1Ap+VSbth4ZsWBJhrrdIBDDlaiibckW0WxTfUfdxgvhDXB5tx9I6W1vb+KX0SyolhAxgwseb1VgKPnZJbjnem+a2aVBs40G/ZH+JMdiiDzomQ8rAOsEX0mr7YYgnK7uHPNxnXpQReNn3N/Bg8b4OGAkQDhDYbXvm9jJw==;5:sAWEN2QXssd5NM5VOJb9Rz6uqO9QTJmDpm7rmK771pLZ0NalGtCPeJMjDH39m25rwDB1c6uAUzyZl9aUKfpZioqRCwLUgId9ymLu3rNMJlNmmJuj8PmVC4SuIX02PQzxBlSYymFCnWw21YbCH85+hhMkHooml3B52r0ntzrhYLU=;7:qIOge6dLnTP/QNZJ66p0QnGgIDMO1DJ9LbI76xQ6+WS15xJtwtXiJqPbtPUtSsrXM9b4AamQ7OpXj+WAzf5HsStZQtWmvZH6haQiQ18FGistJoNZU1Vkm04yxXrtE9I+gYhF185LE73A9qQPHkZ59EinzYkmLyFKKffNYEFXgQTGDuQyO1uMHgosh6IIFUq2Oy47vbcnSXKxdohVxwQVVwEE+Ap1iV8lEfRtTYCIPjKm4kbgjjzrfaIX4HnQ0Kv4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 17:38:15.7378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612269e4-cb3b-43d3-c530-08d61e56aeb9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/18 15:44, Mathieu Desnoyers wrote:
> Things to consider:
> 
> - Move __rseq_refcount to an extra field at the end of __rseq_abi to
>    eliminate one symbol. This would require to wrap struct rseq into
>    e.g. struct rseq_lib or such, e.g.:
> 
> struct rseq_lib {
>    struct rseq kabi;
>    int refcount;
> };
> 
> All libraries/programs which try to register rseq (glibc, early-adopter
> applications, early-adopter libraries) should use the rseq refcount.
> It becomes part of the ABI within a user-space process, but it's not
> part of the ABI shared with the kernel per se.
> 
> - Restructure how this code is organized so glibc keeps building on
>    non-Linux targets.
> 
> - We do not need an atomic increment/decrement for the refcount per
>    se. Just being atomic with respect to the current thread (and nested
>    signals) would be enough. What is the proper API to use there ?
>    Should we expose struct rseq_lib in a public glibc header ? Should
>    we create a rseq(3) man page ?
> 
> - Revisit use of "weak" symbol for __rseq_abi in glibc. Perhaps we
>    want a non-weak symbol there ? (and let all other early user
>    libraries use weak)
> 

i don't think there is precedent for exposing tls symbol in glibc
(e.g. errno is exposed via __errno_location function) so there
might be issues with this (but i don't have immediate concerns).

> diff --git a/nptl/pthread_create.c b/nptl/pthread_create.c
> index fe75d04113..20ee197d94 100644
> --- a/nptl/pthread_create.c
> +++ b/nptl/pthread_create.c
> @@ -52,6 +52,13 @@ static struct pthread *__nptl_last_event __attribute_used__;
>   /* Number of threads running.  */
>   unsigned int __nptl_nthreads = 1;
>   
> +__attribute__((weak, tls_model("initial-exec"))) __thread
> +volatile struct rseq __rseq_abi = {
> +	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
> +};
> +
> +__attribute__((weak, tls_model("initial-exec"))) __thread
> +volatile int __rseq_refcount;
>  

note that libpthread.so is built with -ftls-model=initial-exec

(and if it wasn't then you'd want to put the attribute on the
declaration in the internal header file, not on the definition,
so the actual tls accesses generate the right code)

