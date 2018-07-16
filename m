Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ADBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE0A208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T7NBY8lK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE0A208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeGPLM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:12:26 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com ([40.107.7.134]:65243
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727494AbeGPLM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfbmU4jA6iLUbR1yIcuuVs7/Zs9Lq8I5Fw5osBLloEQ=;
 b=T7NBY8lK6YqJYrsWrXDGjNmOu80QLL9/MsDwtuqK0GoVy9tIuHNcZ/iu4aWWXVvT2TnYm35WIuyeSKNJdDLkXDvQpOMTvE9H6E/MGpZV0DHV/VpzqSkz3KhcKPGLhjZVKsvcg9li6efkBQ+939Ru/Nhgc2ttiP7qKnXNl6ZwUIw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 VI1PR0801MB2031.eurprd08.prod.outlook.com (2603:10a6:800:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Mon, 16 Jul
 2018 10:45:30 +0000
Subject: Re: [PATCH V2] sched/deadline: Update rq_clock of later_rq when
 pushing a task
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
References: <52d533238eb69a09fbf40b34765be312e0fd0296.1531490101.git.bristot@redhat.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <12b65bbb-e82a-7fa5-1225-5047096d48f8@virtuozzo.com>
Date:   Mon, 16 Jul 2018 13:45:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <52d533238eb69a09fbf40b34765be312e0fd0296.1531490101.git.bristot@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0211.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::11) To VI1PR0801MB2031.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db92a6e1-0ec3-46af-942f-08d5eb0940a3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2031;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;3:xBzOUulc6YdhsvXurvx5OUa+DB3e3StFroSu7/bbHuLR7/4DIjC2GLfeVdznK3ggLLp1cVedTyR2SkwOpEsmXw6T4Mca4TPaoM9oip2aq/4h5cl5Adbk8sWeRJiR3zV2a311CuzkqXDgOLJQDYKGoLk/KfOGNh07pu9bG+Fno0liwMIy6vinOPIeNSXvoZqH4kMmSOkViCyVXR2URO05d9SUyVCncY1SVuNsel0YzLb2VZONUGW3ZAgIYXoYB9EX;25:ll/SkmoHUVG9IhMZPRgEuFGrCeEySiHssR/vtOjzKm5atDGK0ovKZrCdpAsayfOyiKGGqetSDKVZltHUoBRn8p7x4kRBWw1f20xOaVOvY9MfCZUjMCKTsC8a0FjCD3yIDEAGo6tM+fxZoNtQ2jSktG3ThGi83DF3EFQznkV3lw9Ukv/G5XSFzxoDH3Qwu1w7XRLx0Y6mtgCofG4g34r0w3q8TIDx9CQExQ1ru4v6Fi1N1vrnJQpG2FtRTAMRGkRpvICHw4rHG/nOlIlEFu7OufCxgJdd4+OLzllGn4spQ282Sa+NDWb3h+QIFu0BCU8YgTs4hf08qE2O/lEURiVMZg==;31:BBAaSOdRaZEyTOArtG5nej8UNZoSDvPFCLQI52WDTR4oTsin0EqHCQawoQw5NZyAn8VVEKkD46n0rZe3sqpkhSY3v6mZUX74pfECBM7wnCMbBaJ9B2z3O8pT4TqnNfKu61SpperJz3/LpFBE7yiv9KWZVXV/W3/X177/5WG27xzSwWiJxiIj6mAdZE6etCEmMVQt1K9fXT/gCGo+lHLEUqiEHVH1DDvZ7IYyd2I3Oiw=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2031:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;20:DOelS646PsJxRzaXPEgGWirudVsqe0XGgpCtoWv3kpX1fJVDObycUBaFeXEreTG4+HBGfJMED2pePZs0TWpKsAGW6BLcSjtJgSta1oPm2H66fyrFYjk8SXN0+Z0KdpQHvucl/+qvhp0cqTMnYWChvIjKRr8p+uyNP0J6tDHjNKdMVXsfy/Bp6qNwuJ8taVwFDJmHRMMPMX7xSDJN51z+BZ7uy8rOwNFBKcrRstd7raQXV/6rw2v0sQLqgb0A20vCPW3oDAPU2LRbBMQn2bkyGOvI9Cnx3m+PdhhL94kraLDbtuq0ndYMcn5LtmumQY865J7NkmrZVmFTk8cL9BciXGwBHD4kf4RWVaaRmtnXxblc4zahEpETvaDUZZEinHnvhTPVILA8sGM433B93J7IfXSvF9tzYgmeH9tQtOXipUeKUkph6KeM+9AZAC9mKLcsswHm/VUCkm/KVBWtK54dKvY3IqcRQmfYgVeC34ZJwtSpP0U+wzR+qrqkmYrQIHQE;4:rylx0xnKQM4loZWu5oI4h8kCDfSngOQzkcs0bk3c1pbzNndLUmGWSH8RbXSfLMMgkhgVpmrlkysDtiIGtn15SNZdsVMEe0WDdrZ9OVpRmRAv8DF1od/26+k4vSH9Ku89pEBwizIozECrzb0ZlfbGXIPWCxHzdtM0xZuJcm9rHedmQ23tKzeRC4j+zJKCq/5P53tUIeIul2E+yaqrys87yo8PyOJoqvYzWg4jL9QjMWeP5yOfFYYnVsrEJcAbcP8z8VqGnXL/iO5uYVLjfJ5Z+hLM+0sUE0Q6GVnyGe3fJIC7hewykb9z0mkYZX/aa/yUru+o6Km9tVRRnjul2No24z0icD/ZVw2WyglL+2MV3eQ=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2031B230C7FCCA277808971ECD5D0@VI1PR0801MB2031.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2031;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2031;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(136003)(376002)(346002)(396003)(366004)(189003)(199004)(64126003)(4326008)(26005)(2906002)(2486003)(52146003)(6486002)(229853002)(52116002)(478600001)(76176011)(23676004)(54906003)(316002)(15650500001)(36756003)(386003)(16576012)(58126008)(53546011)(25786009)(68736007)(31686004)(7736002)(97736004)(6116002)(53936002)(65826007)(14444005)(6666003)(6246003)(2616005)(105586002)(230700001)(106356001)(8676002)(186003)(305945005)(65956001)(956004)(11346002)(31696002)(476003)(47776003)(5660300001)(65806001)(446003)(16526019)(77096007)(8936002)(486006)(81166006)(66066001)(3846002)(86362001)(50466002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2031;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzE7MjM6SGtVVm5iR0V2UmxyMS80bHc5eHd4TlhJ?=
 =?utf-8?B?STlZNXE1ZmtaODdaUjlvZVBsS1AwbndtUFNZMU5Qc1NQU1ZRVVlRQjhEK1Q4?=
 =?utf-8?B?dFhCSWs2YVFlWXQ1Z2JWbnp2Q2RITExIZDljYVo0N2F2aVk3RXgxRm45YXIz?=
 =?utf-8?B?NFNrWDBlSGVYVmwvek14QVd6YlQrb3lQSWFZTmVoUHd0L29vQURTWCt1aDI1?=
 =?utf-8?B?NmliYldzdC9ibzdIOEZRSEJqV3kzMDA3YkNJYjhrUjRKWm1zelJuaVRHUkwr?=
 =?utf-8?B?dmM4WnZtbFpqemo4UUNodjRFd2RBYldQT2JWcWg5dDhzSFpPbSs3OFAvL3Jw?=
 =?utf-8?B?TXBoYklqdDZibUREUHNPSFBiK1ZGMlZDdy9pN040UG9KTmwzOXVtUk80YzFT?=
 =?utf-8?B?RzRZcEljNURSOHRadnFrM2YrN1daZWt2NWNMTnFhdWdSYklnVXdzWlRadlVr?=
 =?utf-8?B?ZU9JOFh3ZmNJN3dCZ3BRZ0ZUT2d3WVNZR3ZIM2UwbGZQdGhLTGlyWHpJRDIz?=
 =?utf-8?B?alJrQklGNlJqS2w1MFN4K1ovNU5jT3FHbXlCMXBoZTd3RVlac2NSQUgrcTAx?=
 =?utf-8?B?QXFsOW0vcVBib0tsQ3J4UzYraWlwd2k4UWd5L1F1WUo3TTJWdFZmamNESG5H?=
 =?utf-8?B?NVNqU2wwQWNkTlpvalFJRVpKMjBOTENNVXZnZGVzYng2ODBVSU92RUg4QXU5?=
 =?utf-8?B?WjJPUWJSUmhlYkFuOWt1OGtBclY3UkEzMjNWNjMxcjFhVk9ka3ZvN3RVcitj?=
 =?utf-8?B?azN0b1d4c1ZiRDNaZko4Y1YwN1lnTmthQ3VDOWZWQXNtNEZXbTgwb3diRTlL?=
 =?utf-8?B?SlZaYlNUdTI3eU9jVzF3Z3U4RlV4U0xzWm9QT0wrZjVlTnRjQkNqVlRhdCt4?=
 =?utf-8?B?SHN4YWcxaE5PWjJLWTNFaXZPc2IzajV6VS84U2taL1RrOUd2bmxVWXJDeGZ6?=
 =?utf-8?B?Z1pDTHEwb0FLVjF0U0U2cXFoNUNYUWsrVGI4b0tYMzRDNXl2cThZSGhMZWMw?=
 =?utf-8?B?RHc3Y0JoNHBWOFRqb3dwVVZRMFpDTWJkU3YvU2ZURlpGVmZScTBQWnhxcXNV?=
 =?utf-8?B?ZlhNNUFVVVFrVzRjZTlrR0txNklvUHYydW1FMnVubnZIRjBEYVYzS2dvRjJW?=
 =?utf-8?B?VE1aWW5pc2t1RitUUUNMdnZMZkdpTHFHVTlkaVVtTjRlUmllQTBwL0VsUnU0?=
 =?utf-8?B?dHdEbHptM0s5RFpXR1hjZCtwN0RzSENQNC9XbEtSS0psY1BLVnNPVGJpNkh2?=
 =?utf-8?B?M2FhZzYvM0hrVkZWRzBhcUFWZHYyUVRCbUZoQ0lnM2J4QnZPdnhjSkY4U05K?=
 =?utf-8?B?b1pSaHhlYkltbDNwZUhGeXRnQXZ4VUVtcjBaT3NtZjVJUFVTTytiL0JRallk?=
 =?utf-8?B?dTVnYjg0TW13ZzBIVXVVTzgvOUlPSmNzbnBaNVpQWUNLTDJmQ1VrcXpobGdM?=
 =?utf-8?B?YXordkJEeERpemVNN3dUaG1WOEdOZFY3T0tLd2NqMThseCtvdTBQR21UUVdQ?=
 =?utf-8?B?VDUxUDZGRXNvb0JURXZqWlZKSTZSYTczcUlQOHl6ejN6ZndDQ1dkSGRUMkdp?=
 =?utf-8?B?MTRlU3VIUjRxbTRCOXJSYlV2dU9PT1pQeFdaMXpoOGVBQlBvYjVPTWVYVEhs?=
 =?utf-8?B?ZmJEaHVNQ0dlWWlTZlhnTVFMYmdobGUzc2NoNWZ5K2V0bjhZeFJNZ3BMU2o1?=
 =?utf-8?B?SGV4NmtEZUMydDVUckE1Y3kxdDEyT2ZJVEFWL1NyRG1jNVk5UzcxTm92ek1J?=
 =?utf-8?B?aW9ka3pTaGpDYUx3a1VTbDVkaEFBblMwbmhCZTAySXQ2ZEpUMit1MDNTV3Q0?=
 =?utf-8?B?YzU5LzVUVnQ1THI0T2FNWnVJaGZMNkoxVW9Pa29vYm5DWURNZHpIbXNEb01M?=
 =?utf-8?B?a2xGTnNJREE1MHFvOXZHbXR3bENoMXNMVitHWmNZNkN1cmxPb0RNMGdmT0Nu?=
 =?utf-8?Q?cJUCD9W5JZVXwUxdo/maaNl5zsrDsiw4=3D?=
X-Microsoft-Antispam-Message-Info: W92S6iH+nLJYWmpvrOYJuMC4NJWg6rGKC3zDjEM2wDLFsJO3iteF+80qxYGZBSJXRnNNFU8uYhfGe3/4p1ZpIs62iYuBYPoFCca+AtwJYVwIKctAa+avSVjvT6GYp78xC8bbFqSULEvSi4dhAjl2nAa7V1HQEz3mRD0zOA+9Eyy9xEqOCPw7G5FbGVvPi4e/r2BBz/+AoF3NtREhXo0uLDaLGSc4EtzLUSs0T7gM6WoUd0c/IsDlOOUc0ACXFheJzKEM1XCJawi/XN3+FMKTT7pJ8KxX4UIsBSvWCKCU3rw/v5c50LfUmBkmJVi/RInmhATBkfjawCXBy6vYT9SXI8LOsntNvvFVyphinE/R6UM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;6:Hjh90hS8ikuc8aDM8C2n7Z5fgTVYPepxOx40rU8TnAKKZVQ7+IYJ5dGQoaXoVOujinm2D5fk4+lTW7hPnNyvSvRqRyjbOngYSCYK6rCPJdb2R0x0tpq82liWtmqkRxAmv5jvMiUyU3Q9u3r7XlIDijKFutFwK6qnrw/Mm7OTsELKEZaMXBRAlL0CuSUw8ZBwFZZ/xGxX38mMOLtNBK+6xHDfP2XyyiBg8P1YSXpPx/uzfDFY8+6Jkd3nLUo5sARCSHFgQHL5q8WNHEsG4646NI0isPXXOZAYAdC3ZWUctUAlR0p2LcxIbf2E7Yxje5hKwezlI3JtVMOvCeck3Tkpm5nmVkKNDYd0Z9WU9fQRQc37AODkbSXz12iMEbtJgGHYKNm6MOIzsQMQmKG9VyarPvNYRqgwTUKkJMeRTgAIzma2JiZc5UnRvtOhOFFpZG8KQeNc68iOq7wYbkRVXQ/38g==;5:g/FcjST+GK3X8AFquN3GDgpoCXlNMW+by9mw5K7ggUBG2t+MkMIUZ55q2PR/O+jtt6/TfmjwOd1TSQff5GFp15QODR1JuKE/Zy9hQL7TGgraiNYqaeePbDSrATbRpXLNttxc9ZC3G8FIg9D+kLeWv/5CKWW0vBKnc1yCXNFjRtc=;24:dbbGdUhV/dHImaKh5goSuyDFMd4jI/h4UjuvTgLCFavnywBgx7FV3ipGo+lAsrZ6RBiMfXtneR5QAiKtj3yHd2rPPtRb91NOYhR6L0rWOM8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;7:vmUSAn0PbuaZqtn/9HcwzvaSCQj0c8D3gfVBAYLdohg5SeZUYN0W3audwEUkS2UF+2O8/T7trq8x3BMKu5L2Lcs/tBlpOKNLIeHvPozXWz6d62HnsrqWqjgCYhq9RddKea096zrLeuJ7LbSmCGHWUQlz3Ht3p15+3CxMUk87SZuq3SuHwGf+MUQ4EOHFam9oUORn4IBTA6DBozmB2Qd6Wp9pX8Z7ilX5X9ugg36nmheHBW8OVrcB6NVLZVK2678q;20:ypP2kNVxQ9VWcN2H03K4J5WZvcqWAm20lqc8qLKPB12qoRjSD64JNw5SbF1UcKxA1jcGT2P4FVgVRF+b/iQWUuxMbPUJV1xD/7mnC6yxAuABCZDk72/YeueQ+RkINRyZ8H/Pli/n6sHYPurPVMwYS1iTwvh0eiefLtR80ID69pg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 10:45:30.3649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db92a6e1-0ec3-46af-942f-08d5eb0940a3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.2018 16:37, Daniel Bristot de Oliveira wrote:
> Daniel Casini got this warn while running a DL task here at RetisLab:
> 
>   [  461.137582] ------------[ cut here ]------------
>   [  461.137583] rq->clock_update_flags < RQCF_ACT_SKIP
>   [  461.137599] WARNING: CPU: 4 PID: 2354 at kernel/sched/sched.h:967 assert_clock_updated.isra.32.part.33+0x17/0x20
>       [a ton of modules]
>   [  461.137646] CPU: 4 PID: 2354 Comm: label_image Not tainted 4.18.0-rc4+ #3
>   [  461.137647] Hardware name: ASUS All Series/Z87-K, BIOS 0801 09/02/2013
>   [  461.137649] RIP: 0010:assert_clock_updated.isra.32.part.33+0x17/0x20
>   [  461.137649] Code: ff 48 89 83 08 09 00 00 eb c6 66 0f 1f 84 00 00 00 00 00 55 48 c7 c7 98 7a 6c a5 c6 05 bc 0d 54 01 01 48 89 e5 e8 a9 84 fb ff <0f> 0b 5d c3 0f 1f 44 00 00 0f 1f 44 00 00 83 7e 60 01 74 0a 48 3b
>   [  461.137673] RSP: 0018:ffffa77e08cafc68 EFLAGS: 00010082
>   [  461.137674] RAX: 0000000000000000 RBX: ffff8b3fc1702d80 RCX: 0000000000000006
>   [  461.137674] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8b3fded164b0
>   [  461.137675] RBP: ffffa77e08cafc68 R08: 0000000000000026 R09: 0000000000000339
>   [  461.137676] R10: ffff8b3fd060d410 R11: 0000000000000026 R12: ffffffffa4e14e20
>   [  461.137677] R13: ffff8b3fdec22940 R14: ffff8b3fc1702da0 R15: ffff8b3fdec22940
>   [  461.137678] FS:  00007efe43ee5700(0000) GS:ffff8b3fded00000(0000) knlGS:0000000000000000
>   [  461.137679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [  461.137680] CR2: 00007efe30000010 CR3: 0000000301744003 CR4: 00000000001606e0
>   [  461.137680] Call Trace:
>   [  461.137684]  push_dl_task.part.46+0x3bc/0x460
>   [  461.137686]  task_woken_dl+0x60/0x80
>   [  461.137689]  ttwu_do_wakeup+0x4f/0x150
>   [  461.137690]  ttwu_do_activate+0x77/0x80
>   [  461.137692]  try_to_wake_up+0x1d6/0x4c0
>   [  461.137693]  wake_up_q+0x32/0x70
>   [  461.137696]  do_futex+0x7e7/0xb50
>   [  461.137698]  __x64_sys_futex+0x8b/0x180
>   [  461.137701]  do_syscall_64+0x5a/0x110
>   [  461.137703]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   [  461.137705] RIP: 0033:0x7efe4918ca26
>   [  461.137705] Code: 00 00 00 74 17 49 8b 48 20 44 8b 59 10 41 83 e3 30 41 83 fb 20 74 1e be 85 00 00 00 41 ba 01 00 00 00 41 b9 01 00 00 04 0f 05 <48> 3d 01 f0 ff ff 73 1f 31 c0 c3 be 8c 00 00 00 49 89 c8 4d 31 d2
>   [  461.137738] RSP: 002b:00007efe43ee4928 EFLAGS: 00000283 ORIG_RAX: 00000000000000ca
>   [  461.137739] RAX: ffffffffffffffda RBX: 0000000005094df0 RCX: 00007efe4918ca26
>   [  461.137740] RDX: 0000000000000001 RSI: 0000000000000085 RDI: 0000000005094e24
>   [  461.137741] RBP: 00007efe43ee49c0 R08: 0000000005094e20 R09: 0000000004000001
>   [  461.137741] R10: 0000000000000001 R11: 0000000000000283 R12: 0000000000000000
>   [  461.137742] R13: 0000000005094df8 R14: 0000000000000001 R15: 0000000000448a10
>   [  461.137743] ---[ end trace 187df4cad2bf7649 ]---
> 
> This warning happened in the push_dl_task(), because
> __add_running_bw()->cpufreq_update_util() is getting the rq_clock of
> the later_rq before its update, which takes place at activate_task().
> The fix then is to update the rq_clock before calling add_running_bw().
> 
> To avoid double rq_clock_update() call, we set ENQUEUE_NOCLOCK flag to
> activate_task().
> 
> Changes from v1:
>   Cosmetic changes in the log, and correct Juri's email (Daniel).
> 
> Reported-by: Daniel Casini <daniel.casini@santannapisa.it>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org> # 4.16+
> Fixes: e0367b12674b sched/deadline: Move CPU frequency selection triggering points
> ---
>  kernel/sched/deadline.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fbfc3f1d368a..e733c15b7695 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2090,8 +2090,16 @@ static int push_dl_task(struct rq *rq)
>  	sub_rq_bw(&next_task->dl, &rq->dl);
>  	set_task_cpu(next_task, later_rq->cpu);
>  	add_rq_bw(&next_task->dl, &later_rq->dl);
> +
> +	/*
> +	 * Update the later_rq clock here, because the clock is used
> +	 * by the cpufreq_update_util() inside __add_running_bw().
> +	 * Then, set ENQUEUE_NOCLOCK flag to avoid updating the rq_clock
> +	 * again in the activate_task()->enqueue_task().

Is the second sentence really needed? It seems everybody knows, what NOCLOCK
flag does, and we does not have to paraphrase this in every place it's used :)

> +	 */
> +	update_rq_clock(later_rq);
>  	add_running_bw(&next_task->dl, &later_rq->dl);
> -	activate_task(later_rq, next_task, 0);
> +	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
>  	ret = 1;
>  
>  	resched_curr(later_rq);
> 
