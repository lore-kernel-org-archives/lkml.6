Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1B4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529EE20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZLx3ltNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529EE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754522AbeGIInk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:43:40 -0400
Received: from mail-eopbgr00096.outbound.protection.outlook.com ([40.107.0.96]:61777
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754374AbeGIIng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSGJqD8pmV7MHbhsRgsvdnVNjI/OpQVGhlyKJqKdnsc=;
 b=ZLx3ltNc9XHwuy1zI3Z2fFBkDM6zSpHolNCSjsaBrYmBdHpqJ5KkqScgftH+eLmm4PpmuGgMNCLVTfXLhNY8rmSfKeCBg1kUY39XMZKexwxcs8hWOANPl7H48bk/9qQFWWFa4MTDS8ysg6NrkT6uIJSbSOX8kHoAyjSf1cYoc8o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.5] (185.231.240.5) by
 DB6PR0801MB1336.eurprd08.prod.outlook.com (2603:10a6:4:b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 08:43:29 +0000
Subject: Re: [PATCH v9 00/17] Improve shrink_slab() scalability (old
 complexity was O(n^2), new is O(n))
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <d7fd6feb-4269-1d04-3ec5-ae4487b59d65@virtuozzo.com>
Date:   Mon, 9 Jul 2018 11:43:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR0101CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::32) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e908837-05cd-458d-5827-08d5e5780cd0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:TB4oeMVYIwmZ1EZZaTv1F0vpzdxNNsKckHQav4w4qSHTJ0AbhZbTgZ6zbGxK+XmH76LehCAc2TfC9hdikTACmtN5UPowZaLWQMPDto5rIG9wszuU7iD6gEVC/9vVK/Pix4++0DC7x6vHbZD23Lm8qT41yjZpJ/+Mfhs0vDhFDgLMDBNgNnvHYHTZtacL2UDhCHEMqCiB7ti0+wt3mo6HuIMg6IZeE2q1ei71+4X+VlNWukEU6778D8A6WlJ1aeU8;25:1M7h8aC7ZilVdHS8ahJOKfgPtNBKYBMyZS5cSFCe9yCuk8naquWco1BcoKmUa9hZIrgXEqGV/zi4G+qpoEIQc/bgTa4fOw8w+l8YMrsWUwGD04pq1ZyzN5Ygrz/sUwGsWrjhcoPxJMURbk+N01ueciqs/I/aO3rw+Y/aD953LPgUVv5ki+WG27uzjEztKQsu4zKlN1OC+SIqkTNM8WFEU4TfVjOlI8VXnfx0mZZTv4MdhUFTgbaqaHeqZG4HO1KpleiFLtsJY5ZKflXP4P6DlkbC8slew9zWyILZsoRVPDIqIZ7AoBXd5poUXpWoFQBfzMnyJwEkP42986AN5byDEg==;31:zXws9rK5++/boSq4nROR1PkKHsLH1lEyeVrTkgJ8Iw7VAtqmqeqZA1Uw93WVNO/GJgPrOv7wzRNW+q6QW8LYbw63XESMnO68ZVnndcR+1fX3M6CbYExGXNtJdJbQbC4gEM/s03WoZ3wmI9iEtMs6Qk3if/ghQPAtTbv2trPMKl2a/W8pnSNkmUrmHEsTII6NZik9zTmwSa9fSIhHpFUq3Oow8b4AKmOXNtPebK7/4+A=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:VZA51y3nUE45HE6Ske+jA3yXj/YsWmzDJ+ba7wwCQ+cOAipPiUARVxcn+Uk6vzpWLeYzJr+AjTDUxtRWTXIUG+UNdaxbS93nJdHNN678S0+EtlAfGM1fgT8fMHwynFMHmaLZtAawTcXlykVFiNTgwYbtsA/oDD/G02MYhK0VRV4IYXD48SF26UhVblS5cf0TuduU6CfEf1tqhzmL8kTZQhb+wztJ2V56FaL+3g7xIbKTwTJX8jV6RM2IeYBePza2R5qGnxERhL2vfMYdzuk+TecrPvm8OGU+/RGm+ymPu3dvNuJ2tvfdPXRdIoJr/uE7r0NX+JAC0zgJG8LE/+rnIFX8jcZ62LRCAlSYDJDnwwLB42NhVavDaN2fKOZq2cKxZZNqeTJLfEUXGf9JM/okXxePus3Csu4DytmlIWuS2b8BEZmf/fVNXZgBobIxTluGHwq3J5vGEbR+tc9RSyiIwJJJZo4uwINlOYQaLDLaffR9whLGb0oLc237aLE7geuW;4:DcQmNzKjnX0+MxXjPsdyu6YdAbF8AcSVRM3kIb5x0/qBvqEm9xXeWgg5d1SFQYF9XD1R6qHIjqnPGJANBlvrBoMok+MbbogG0YBkyHAFkmKEVMuepE10f1IuLn8vPckZPzc7d/gQtQQBZ7HWNq7v1xE6x/iaxXazYkMKIGPoloK7Oggkrxa1Lrl+UeqCL5nZKqCbb2pUpR10SaPaU6w+34d6Nea0YCWJrIHXtlalXXRjCorHpUFjly+p/XhTg/DjB7Qskxjjr670vZODSKxTpC4tI3VBfOoN7TWGh6HQ2rAwrkdf0lsoTQPNwnFA8EmiHdX8ntshog3C/fUoL4fMYqs/A4ScrRr61uYay1LK8muzwVN2oDmXxVtcA3LIPBQeEffu8kbT75w+tx8JD+0wEC+3clojPJeVhDm0jIgFv+0=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13363F56AC9277F2363F1ACBCD440@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(136003)(366004)(376002)(346002)(39850400004)(189003)(199004)(31686004)(3846002)(58126008)(81156014)(81166006)(16576012)(6116002)(105586002)(316002)(5660300001)(230700001)(65956001)(65806001)(65826007)(66066001)(8676002)(47776003)(106356001)(50466002)(6246003)(14444005)(7416002)(8936002)(478600001)(31696002)(39060400002)(64126003)(86362001)(53936002)(25786009)(2906002)(305945005)(36756003)(11346002)(97736004)(186003)(446003)(7736002)(77096007)(26005)(386003)(6486002)(68736007)(486006)(52116002)(476003)(53546011)(229853002)(2616005)(956004)(23676004)(16526019)(76176011)(2486003)(52146003)(921003)(81973001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6MTJIZkJzb3V5M3JPeEpmcEdvRDBIL3pN?=
 =?utf-8?B?TWRCUjVvVmFtcDdZNW1wUGR4YWVjOC81VEdFam1GM0ptdWFsbGhCNHhZRmx2?=
 =?utf-8?B?S0tHY2VNbFBuVFl2WWpvUEVlL0pIYk1aMHhZZkw3YTB1dERKUkRhbUpJSDBu?=
 =?utf-8?B?U29mbU9XdFo3ZzRuQWJheHNmaDUyNHl1aEdiN3ZTSjA2cTc3aWtLK2JJZHR2?=
 =?utf-8?B?ZWFndENIOHJZR25LdnkwT1BIZHkwLy9URzU5Y3dxNXpCOW5lYTNFam5tMXRS?=
 =?utf-8?B?SXU3WjNwc3JjMm91VXduSkNCK3pXdVUrd1c5YlZvUll0RURVVU1xS1ZkWTh2?=
 =?utf-8?B?YnlZSU1rQlNHNEFDTUo1cWVzTW5qYmMraGd1eEdVU2YyRGVzSDYwYU9nR3pO?=
 =?utf-8?B?TENSTGhmRC9ZbWFUVDZsK3NGeGxqOUxFZG5rTmVlRXFpTHNLQ2owTnQ1MEI1?=
 =?utf-8?B?Z3JPcEhRRVRkK1pjVCtENWU4ZU9jYmpldVF3MFU0c2oxQXNXazVXcE5ta2NS?=
 =?utf-8?B?RzlHTGQzdzJhYmw5UENQSWlKK2VlOG9IZmxKRjdxdVJyZ1h5S21RcllrdStr?=
 =?utf-8?B?TGpkVU5nTFZtQnJPSW82UkFVUFlCVEdYdUowbXRMaitSSjA5ZDYwaElsRVN2?=
 =?utf-8?B?b0w5ZGppODlvcDdOcksrdEt4MkkwelhZdFJWUlFxRmxoNzBSdUQvZXRXeTJk?=
 =?utf-8?B?NXQyalpwZXdXcGVabmZ5MVBJYlR6bDBudTRPVXA0T0VrYzJmWWZPWUxzSVRJ?=
 =?utf-8?B?Mm9qdDU1VXdsbEVHMkplUG1BUHhqSVg2cDJPejVSL2R1OTI3QzNoSlJSVDFk?=
 =?utf-8?B?aWdzRHI0LzJ4bW1jQ3RYejlwaUFSYXA1b280UlRLR0loQ2tMU0k5S0gyYjlC?=
 =?utf-8?B?ZEpoYjdhS0h1b0pkaHhFcUU5bmlwc3R6V2FPcjdBdmEzYlpsRlpldmw2YUZT?=
 =?utf-8?B?NktaMWxFMENzaC9DTlczSGJoQ2Z6eXdib2ZtOHZvOGxLaEFxRUsyN1N5L0Zu?=
 =?utf-8?B?dUZiMFYrRk4ya2ljenRsMXdWazkwa3YvdU03N21DWVpJM2gvUzYwaGR0alcr?=
 =?utf-8?B?TGhTbVRJTlZiTk9tMERVTXM1MUdwcmRuS2w3bkJPYlg3dXR0WWNTWTFkaTZp?=
 =?utf-8?B?RnFZN1dpUWxlbXRwcGZLRThNVktkNUExSEhJclB2R25RNzFpd3FsaUtDcVdl?=
 =?utf-8?B?T2dsZXdlTnJVQ3g4NjBkOWJyYk9VbWZSazFvc2YwbEo5bklWb2Z2WS9qRWt1?=
 =?utf-8?B?bkhlL3ZyUGpPak1YQ0VUVm9ZYnQvQVJJN0JOeXY0c3llWHBpOUxhS2hkVkZC?=
 =?utf-8?B?WVQvMWVNbkdqSGkzbkdWMjFMUE0xcEVwMVl5QjU2ZHFmUjJqKytTcTQ3RVF1?=
 =?utf-8?B?eTN6OTRxRFVqNFBOc1NjK1RNbmtYMTlCK1JiNHdlUmNvVkxFQXlXVW5aRmg0?=
 =?utf-8?B?WkZoT1JpUWcwVzdwUDlXQTNibmpBN3UzT1lxajJpL1R0VkIvamVma1U4TSsr?=
 =?utf-8?B?eGlTTFJRbXlWdUs4aVBJUDQvaWFhb1BzbWxiRTJiNnkzQ3dYYmh1VWsvVWJ5?=
 =?utf-8?B?bG56L1hPeXZMU2tGejBxdFhuS2hNd0RJa0dmZFJKbnpIRzVHUVN0a2hONS94?=
 =?utf-8?B?QnB1MHR2TGs0RHUydWpNZkN2TU5ZcTFNTDZ2Nk9aOWtpdS91NzIyQTN1OGtw?=
 =?utf-8?B?cFlsNHhFbkQraHhRRkgzV3krZEpmSURYbWw2alp2bVVneGZGdVJZbERtSTVS?=
 =?utf-8?B?NzlGSUtSTHZxNEdNeE1WTXB0bG9TSXFLa1J2SnNTQk41Wm5vZVR6dDVvbTl6?=
 =?utf-8?B?NXNlR2x0NzRJV2ZCWHplb0RPL0p1R2hKaVl0ZzNHeit3NFZLaUk1WWUzUFMx?=
 =?utf-8?B?SVlLaitXVmY3YXhpbWV4K0FiZ0pVTks4TFprY0M1U3BnaFVpN2thdndjOGxo?=
 =?utf-8?B?RHh3YnNEQ1BrUDBWSmtKRVA2c090ZGxxWWdtY0huZ0l0OXh4Zi9UeTB5REhY?=
 =?utf-8?Q?NBcIR+x3?=
X-Microsoft-Antispam-Message-Info: pu6INmLvBzwsrELrP9UHKexLoiHocj7cYu+XnhAXRq59QcV4BCA1JTu2xLc77TNqmKcnn8V9w4HMpqUoCp/QqJsNFz1IV03qiaVUuqvksPTjnpDw5LPH94pVRhevFKTVj7l1YBNTFfjPYSyW3yqrla++A2+kwog+oc/61p6nX03fFyVh9dH4HJNGAbSoD8G7FWnviag4qw/DXQA+ojdGlCAQF78GsqSoUXsK5ZiiVWYJiU7YFSci81KAIF/Q2sI/uS9/pWjDjb11h6+UJdAq/KPM+cI3c2geajXiXkjH9AjWy0gLZRiJRZ0HLJdEpvNhtEwUX0Hd2Kt4QYM4auBC4oUNTgBlvbV8PN9ZDXDHF/4=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:XZ1kAFKOoSGHPa+9wkiqF0u/DEtKIeoqJunQyVCJlcasGPOjm/+EbORZZ7c+zvWTRAwsxd4YBoJTh56rOufNuzaqPySaOm3hqDtuTHRnLquUHpqtzv57SNFTCDu7iYywQZaq3kMIA6JVsBHnX/EMrcQp46dWmWa2l7bJTiGtBm2ba5V4n/tT980sw5UJo7oYlR9ty4qLL9FDyTFetiydrKxwTqhswnWntbabx3JIyh2er5CWjR3gTTzKO3Kuqphkj1WFsDw5WGGeAoR86bDPem6liwY+J2ceTqLWXBhpBbjWMia1SvdSz2AAKbeKT2s6L0NvPIstacPn/JdJgCfBGRTBFnSbCu9JPYIMRiy4PjZGSqfs0Y6e05hQnE1t/QJFiFdh0fkP3jo6BbhuSMwHNQ8ner/KHphN8qOd9T+XM7SrwFhv452z2xU1W/DUxivB1VS3i565WF8hxb4ffL94AA==;5:YRFwRc2McNof5CrrSGao3o1J6Hhn/Q2IwdL/mrVcSw6VnAviYz6bNG6GZwbV2CS/DcrmXW2DKtTXwZsdreuf8RSdnseBP8VhFgJJqNfcNcB97Bh2oP7hEMX6/MpZ8mdVMIPPJL6wZ4IaryilJe2maXRmmY0O/nR5g8H134LElFk=;24:xB2GAQ4EEySglmbklfX/4VHw8GGO/C7nPN6DnEMXGE7E92W4RBPeW8t6QT2w8YnsiqO6FkXuFsJWd7YWSyCv+PqTy4sBSno6SRSHPl0Iu4g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:YndybsL2BZYQf8UrcCCrT6XwEcnuP3TwSiMV6/Va/e4HD8RUljZ0mPbKmH9J5kohDPx48gHqVZWjxQ1gLpz4NnWN9Dr5tQJXQ/H0oc/APgRZyFZoB8EPdrniKfFgQ39D9PR08bcnAfZOBgzyBZBhgZEwYVZpwLxuZIPi3Gt8rVpGZliJPOYZ03PJiGZdeWZescfbPFn+bVxg9wME+vw2VzSRbvbtfO3NJ0VpUz83bTMNIfNjai+03SXEeL5rI81/;20:aUNnNi1wrNxVq3UfcqyX5p+fsDlXIjB0EXssJxYO36r447CwZ9UPXO4FZGJ/K3cqNRV2MlbvIlgxONQLXPGRgi5Ohd+mKbV4E/zQifAfqF2TFfrlGUuuvKsJeHP6Nu+Se1WXYplLrVHup9mGX4KQbLpAj0px9P7ZLHp2sG0Di+k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:43:29.7703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e908837-05cd-458d-5827-08d5e5780cd0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.07.2018 11:37, Kirill Tkhai wrote:
> [ Vladimir, Shakeel, I didn't removed your signs since changes ]
> [ are not signigicant. Please, say if they should not be here. ]
> 
> Hi,
> 
> this patches solves the problem with slow shrink_slab() occuring
> on the machines having many shrinkers and memory cgroups (i.e.,
> with many containers). The problem is complexity of shrink_slab()
> is O(n^2) and it grows too fast with the growth of containers
> numbers.
> 
> Let we have 200 containers, and every container has 10 mounts
> and 10 cgroups. All container tasks are isolated, and they don't
> touch foreign containers mounts.
> 
> In case of global reclaim, a task has to iterate all over the memcgs
> and to call all the memcg-aware shrinkers for all of them. This means,
> the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
> and since there are 2000 memcgs, the total calls of do_shrink_slab()
> are 2000 * 2000 = 4000000.
> 
> 4 million calls are not a number operations, which can takes 1 cpu cycle.
> E.g., super_cache_count() accesses at least two lists, and makes arifmetical
> calculations. Even, if there are no charged objects, we do these calculations,
> and replaces cpu caches by read memory. I observed nodes spending almost 100%
> time in kernel, in case of intensive writing and global reclaim. The writer
> consumes pages fast, but it's need to shrink_slab() before the reclaimer
> reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
> there is no writing, the iterations just waste the time, and slows reclaim down.
> 
> Let's see the small test below:
> 
> $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
> $mkdir /sys/fs/cgroup/memory/ct
> $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
> $for i in `seq 0 4000`;
>         do mkdir /sys/fs/cgroup/memory/ct/$i;
>         echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
>         mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
> done
> 
> Then, let's see drop caches time (5 sequential calls):
> $time echo 3 > /proc/sys/vm/drop_caches
> 
> 0.00user 13.78system 0:13.78elapsed 99%CPU
> 0.00user 5.59system 0:05.60elapsed 99%CPU
> 0.00user 5.48system 0:05.48elapsed 99%CPU
> 0.00user 8.35system 0:08.35elapsed 99%CPU
> 0.00user 8.34system 0:08.35elapsed 99%CPU
> 
> Last four calls don't actually shrink something. So, the iterations
> over slab shrinkers take 5.48 seconds. Not so good for scalability.
> 
> The patchset solves the problem by making shrink_slab() of O(n)
> complexity. There are following functional actions:
> 
> 1)Assign id to every registered memcg-aware shrinker.
> 2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
>   and set a shrinker-related bit after the first element
>   is added to lru list (also, when removed child memcg
>   elements are reparanted).
> 3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
>   and call a shrinker if its bit is set in memcg's shrinker
>   bitmap.
>   (Also, there is a functionality to clear the bit, after
>   last element is shrinked).
> 
> This gives signify performance increase. The result after patchset is applied:
> 
> $time echo 3 > /proc/sys/vm/drop_caches
> 
> 0.00user 1.10system 0:01.10elapsed 99%CPU
> 0.00user 0.00system 0:00.01elapsed 64%CPU
> 0.00user 0.01system 0:00.01elapsed 82%CPU
> 0.00user 0.00system 0:00.01elapsed 64%CPU
> 0.00user 0.01system 0:00.01elapsed 82%CPU
> 
> The results show the performance increases at least in 548 times.
> 
> So, the patchset makes shrink_slab() of less complexity and improves
> the performance in such types of load I pointed. This will give a profit
> in case of !global reclaim case, since there also will be less
> do_shrink_slab() calls.
> 
> v9: Uninline memcg_set_shrinker_bit().
>     Add comment to prealloc_memcg_shrinker().
>     Make memcg_expand_shrinker_maps() be called only
>     in case of id >= shrinker_max.
>     Allocate maps unsigned long aligned as found by KASAN.
>     Reorder two hunks in prealloc_shrinker() and two hunks
>     in free_prealloced_shrinker(), which may be related
>     to KASAN-found use-after-free.

Also, remove BUG_ONs nearly map dereference in shrink_slab_memcg().

> v8: REBASED on akpm tree of 20180703
> 
> v7: Refactorings and readability improvements.
>     REBASED on 4.18-rc1
> 
> v6: Added missed rcu_dereference() to memcg_set_shrinker_bit().
>     Use different functions for allocation and expanding map.
>     Use new memcg_shrinker_map_size variable in memcontrol.c.
>     Refactorings.
> 
> v5: Make the optimizing logic under CONFIG_MEMCG_SHRINKER instead of MEMCG && !SLOB
> 
> v4: Do not use memcg mem_cgroup_idr for iteration over mem cgroups
> 
> v3: Many changes requested in commentaries to v2:
> 
> 1)rebase on prealloc_shrinker() code base
> 2)root_mem_cgroup is made out of memcg maps
> 3)rwsem replaced with shrinkers_nr_max_mutex
> 4)changes around assignment of shrinker id to list lru
> 5)everything renamed
> 
> v2: Many changes requested in commentaries to v1:
> 
> 1)the code mostly moved to mm/memcontrol.c;
> 2)using IDR instead of array of shrinkers;
> 3)added a possibility to assign list_lru shrinker id
>   at the time of shrinker registering;
> 4)reorginized locking and renamed functions and variables.
> 
> ---
> 
> Kirill Tkhai (16):
>       list_lru: Combine code under the same define
>       mm: Introduce CONFIG_MEMCG_KMEM as combination of CONFIG_MEMCG && !CONFIG_SLOB
>       mm: Assign id to every memcg-aware shrinker
>       memcg: Move up for_each_mem_cgroup{,_tree} defines
>       mm: Assign memcg-aware shrinkers bitmap to memcg
>       mm: Refactoring in workingset_init()
>       fs: Refactoring in alloc_super()
>       From: Kirill Tkhai <ktkhai@virtuozzo.com>
>       list_lru: Add memcg argument to list_lru_from_kmem()
>       From: Kirill Tkhai <ktkhai@virtuozzo.com>
>       list_lru: Pass lru argument to memcg_drain_list_lru_node()
>       mm: Export mem_cgroup_is_root()
>       mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
>       mm: Iterate only over charged shrinkers during memcg shrink_slab()
>       From: Kirill Tkhai <ktkhai@virtuozzo.com>
>       mm: Clear shrinker bit if there are no objects related to memcg
> 
> Vladimir Davydov (1):
>       mm: Generalize shrink_slab() calls in shrink_node()
> 
> 
>  fs/super.c                 |   11 ++
>  include/linux/list_lru.h   |   18 ++--
>  include/linux/memcontrol.h |   34 +++++++
>  include/linux/sched.h      |    2 
>  include/linux/shrinker.h   |   11 ++
>  include/linux/slab.h       |    2 
>  init/Kconfig               |    5 +
>  mm/list_lru.c              |   90 ++++++++++++++-----
>  mm/memcontrol.c            |  187 ++++++++++++++++++++++++++++++++++------
>  mm/slab.h                  |    6 +
>  mm/slab_common.c           |    8 +-
>  mm/vmscan.c                |  204 +++++++++++++++++++++++++++++++++++++++-----
>  mm/workingset.c            |   11 ++
>  13 files changed, 480 insertions(+), 109 deletions(-)
> 
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> Tested-by: Shakeel Butt <shakeelb@google.com>
> 
