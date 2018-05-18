Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrxSKOONo5CYadZsrZkFQLh7e3iO4pKAK3I5Btjoz0Yfn7bftE7O3oeqrsGzKd4lMRHWyq3
ARC-Seal: i=1; a=rsa-sha256; t=1526632965; cv=none;
        d=google.com; s=arc-20160816;
        b=VelTrtXhAfFyXOmjU0f5ayvbWTjiTa/mITYqf5gwsvuRJNLePBPq/nyD1yZiD7NEeO
         GA9Gp4jaUOrd4GCttCChR0fbsULj64leDL8rV4W1TmkY6Z3ZeV2yTcAzmK3JTeOlbjpX
         vfftGMvLWKHM/HRtGX13Z2Le7CvbQHL8A3+jKNN3RcG7dXGk6lWRq0KKcCs1t2Uo43Hr
         8MIghqHwIF94saZVl3Fw4+SKBgWCnG23cSRQTdfb4eMgvGEJrXLiGHWoKMbr7E25zCTF
         Gl1XMHhbuIr+GWzK2d9CoATqUa+wLI+89KbHy4tLrwbNa0yp+LoAVFQFqOTPNaA7bCfx
         McIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=WAev2mRvESnMpiOMdA6nMo3DX576lizRTUAOQJk2Ssc=;
        b=aw3fEldQG8H3a/4GHNEAiEvOATNtb7qqGlHcdAN1AL6V5flNG7s0emgijqwZzLzgBo
         gybAy4iQcJJf7OiN3nz+m1iJgsIl+q63jF0e+pvcSnvWNJgBBPrKf/IOFp1qa0WdX6n5
         2356uz1ssGypKo0/UGfB1D9hGaDOqtxToJmW0+ra+sNDBwlsR+AAwB52/BEDpyyPG1Km
         g55k19cVr4uA8GXyTISUSXNebHsrO3HKe34X77VXkfvmMJsnitZWXKtujYMNB0mynp57
         mSIKZajB3flAYmc5rbuBw9H6kwC+m8qKCEh7CmaxiiiHYanOgl83fAP7PKZtKmFejUJd
         YTPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=afetB9wk;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.131 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=afetB9wk;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.131 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 05/17] mm: Assign memcg-aware shrinkers bitmap to memcg
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Fri, 18 May 2018 11:42:37 +0300
Message-ID: <152663295709.5308.12103481076537943325.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0160.eurprd05.prod.outlook.com
 (2603:10a6:7:28::47) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:7UVe0R9RLPQuRIOWh5fbAjhdgApwKkxUlV5IkeVaY6FSLXc4yp8U2pd5/iQdZRFtyhIV6wMDfEZqneqYBTHX6EsiYJG2Ka3xsFGEPJtmeVL17x2kbg8gCtXnQgW1Fnbpn9U67yvXlP6/gJ7V5XmjR9hbpISVKuOWv2/Dk/OwtiVdsxkImJW8m+JT/JAMh1XL+qlaRcHpKcIzYmvCvO420fPjKQHxPhfryOCNKAApg8U83OOJtQZLxPqca/YndUwt;25:QlLNxA1eNLTxd0thV4UFtH5pc1Dhq01QunfsmaIPDTMo2pNnB4opJFFvplwbx7ri7gibDdJYtydrpoYYdLVW3gSeVnBzF10U76CYRzVr0XtOyzMa48ePt7ELlbd7oryZkbKQIDIafWJYw76QshboKMfLdDWQlumcqFlFtHm8H4/dt/U9owAlNVCR2aU33ttiO5Rx0L8bid4yOStltew4EBSJ8Pgq1jA5K536j7hnSdrxuh9OMh9riohCVaoDu+OrwcHS3TrF3wuzU8E1ndiZA8w89uV1ogE4XU/1cQpGHc9gaVPLOl6rpMdrfcSyC67KTnrWdogzE4vS0JrM2KH7vg==;31:BWWFygInPmFy8lEmxn0GGZn4J+fzcorbKaj8CbIUST8F3BOTWh+ltf2UKIJ/YQLPybKie0TawmudVNREjX9tz1MPlX59VFvOk1GBJ6MZX+t/NxVfCC9U73ata/Q9nBJO/dDWiIT+yOs2W734Jk6bQhnFeVCbolTRdQxHXb6FFA6cSA0wYbIuwjCfMbMoW99Jd0ouqVDEmKXjyFQ7o/oS0Jpo3ZN4GfYG49M3IK4iuyE=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:w5uqU8uv2F1CvOHi6POMEF/BWY8Y5570bVIMSaAcDjq6Z5bl80kbyTEtT+2KlVJyaJpeB2j66wT57RoCnmeU5hDb+gKa2j1UO+EANZAC6GTqJGPvonSkh58UMHGodx4BgwnE1KPsOD7Y+7SGz1WkbOJyGpJFLwtOVAd/v8KXCXbJsTzUXLFsZH5cT7LNKV8BYPsFRPoU1nbDNxIbwBEjn4u2CwHJYlPmFuGn0mFVYD5KUdNB7GGBVCsYBtW6qZfd2pTy27ir2JmCsSS4EC8AsN8m/8/gAQBpusu/QGwOj0qFB2yBmM1ANKVl4Y4upJIQolYWnrqdoz7vIXifJh4PYvwjX6xHmYwE0Po5dieorwFkkNsxAKVSqBy9vHnEklTY8Y2JJ+n6g/PdzXT5gYQIAGlafbN3lIw1cvdFryHFGmkyVKESHtygExov7pIxMadWlj9o239fRYxEcgi+MPMWAhYDhNkaUm/irqqTFBsTVCHCwp8eni8jL58Rk0Z/ys52;4:udYzS9hNPWffRnRJY4XgzlZ1gEoNdR02sHC/qs4+Pv+qbGPhr1YePRVtRes+r3LsBv2WigBgJ40CIiYEDSuzdy8OI74bau3OwVXv4poiY15+VwqvpcN7AZ9jEWZv9EsUEbDTijAO8UtteCVSjqZip7+mO57ydT0PxOaplSVjLpiM6X4tZjy5yrOkKoC0siIpRPQ/2+T9j+iYdeGXrpoDznQsR7BCjPYNQqJ5C6ZUwy2WR01XQYHq0ZVNyIiPb9cDf8YZ0Hst1fLrwBSNmXAYLtm7HYnD/wxvNZEn9n1SGK1xEBAuo20ZQ2BuoOQMzuj1uNjHuDJh+uTQVd2HqxIZyrHRl7sNRaBzLI9m/+A1ug4=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1336F9B68981B049ADDE9F81CD900@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(39850400004)(39380400002)(346002)(376002)(189003)(199004)(316002)(25786009)(58126008)(6636002)(6116002)(39060400002)(3846002)(53936002)(9686003)(105586002)(106356001)(230700001)(97736004)(55016002)(50466002)(11346002)(23676004)(2486003)(52116002)(7696005)(7736002)(8676002)(81156014)(486006)(81166006)(305945005)(476003)(47776003)(8936002)(956004)(26005)(68736007)(16526019)(186003)(7416002)(76176011)(33896004)(86362001)(2906002)(386003)(59450400001)(478600001)(61506002)(446003)(103116003)(55236004)(6506007)(66066001)(5660300001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6Uld0Wm5zaDAwRDI3cjhlTmRrWFRDR0Zu?=
 =?utf-8?B?SnBtR3J2V3VzemdTdHVJOThXYlFQL2ZQRGk1aFpLeGQzR2lrSjh0eCtwaUgx?=
 =?utf-8?B?TXduR1orc1E2Um4yODlPekpyM09rREVzQ1Nza2czZEhHbFErZGV0OWdUbHdU?=
 =?utf-8?B?SzZvcFNWVnF5NUV4R0dCWWJyMUZramQ3bFg5WHFDcXByL3JnTFBORXZkTGpx?=
 =?utf-8?B?T01VWGZQanU2ZjZJQTd6ZzdrQW1lQWhGcUlXcmNYUmN6eVM2SXk5VlQ1OGx2?=
 =?utf-8?B?ZXNPN0JjeUc4TlR6NTgvMnN6ZGxRcFJMZUR3dFVLUUR5MkhrQ0twK2pMbW13?=
 =?utf-8?B?N0VzU214TUhwL2tYTU9XVWRXZ2VSWERGZVdOa0R6S3lRdDRSR1FrU1l5WFN2?=
 =?utf-8?B?UDZGQXFwRWhZVlJtcnV0Sno0akVBWlBFZlhFQW5qempNN0EybzQ2aVpkTDhi?=
 =?utf-8?B?UFRNbzIxVkozbnBOSEMwcTAyYWRhSHFjLzNXeFhqYTZZNlVYNmpwQm5UL0lX?=
 =?utf-8?B?OEl0RUdUWmNoQnZNOUUyWnRrYmdSdjYzcC9WK2R5N1RUSElzZjc1YU1nT2hV?=
 =?utf-8?B?NkhRWExic2VFOEY1MG1qdlV4aytkL0hhK2pZam1xcG50MUlSRGs4c2Ewc2pr?=
 =?utf-8?B?WjVMeVVMdjd0TW5ERFAwQnpzSDVNeFEweWpzRlFxS3owZ3Y1L0kxS3ZHL0k5?=
 =?utf-8?B?QWE2Y21jYWtyNEovcjNXdDAxaEYvdFNYMFZtZGxkbTlJbEdudDBKQ2xOYWw3?=
 =?utf-8?B?cG9NWEVTNWNTejZrSno0WmdMeTFXV1VpRzBRR2NqVFBvWnFnUkJSQURKcjVj?=
 =?utf-8?B?SHlVMmdEMittK0txa0NTdE1mdWNJS05LZEdPK2FTUnJVbUJGYmRXMlZxVHAz?=
 =?utf-8?B?d2p0bG90S3BDaTBLUmEvNzhqQm9Kb2FpWVZMYTNKckF1dm5MWTMvSTFKY0Jw?=
 =?utf-8?B?OGJnVlF6UU81cW5TZGM4SjFJZlRwWTJaZHdnRmhtTWx4dU5pS0QrbTNHQTVY?=
 =?utf-8?B?VitIaml2WjR4K1lzUzNpRXhRbG1mTlFEU09oekZsVjBLSjZGTzRabXVpaWM4?=
 =?utf-8?B?YzRQWnAxcHZVZ3ltVWxHdUVZMlA4RHZ3YjR3UHFjRzZPaUt4U1M3VEFCTE81?=
 =?utf-8?B?SFJDaXpzSzEyM0JhUTI4Z1YyTC84U2hxSHVpSWlUYkxKcnc0alNVWjczQ1I4?=
 =?utf-8?B?aEpLd3RkUXZPM0xodVlaTEFuTmJTWGsva2kwMzAwdDlQYmFaY3V5WW1DdGps?=
 =?utf-8?B?dlFkZjQ1Y3lubkVtMmpZQ1o2U0FlS0xpNEllc1VaeHlHNkh4UVBiM1E5RFZ4?=
 =?utf-8?B?dHIyVUpDYlVxTjU5N1IwRFFQbGxRbHVmVHJ4NjMxM2xhR0RZQ0kyQkVUaE9k?=
 =?utf-8?B?Q3cvSTFSUWtFOEwwUDNONkxkb21hNUNOcTZrbnp4MXRRM09XRzZob0djeDhB?=
 =?utf-8?B?NW14bHlIRS9WMTVpNTZvUXpRNmZIQlVOU1dwUXhXOEZZc0xoT3pkVmlsMWRx?=
 =?utf-8?B?enVOT3hETDZkUk5zUUsrckJMeFN1SHZRdTRSWFg1akVCMWJNclRtaFJaUC9U?=
 =?utf-8?B?MUVCMHdLb01YNlNWSFAwM2hGWjh4cTlQd3hHck93c1UxSDFCbGswS3U1K2tj?=
 =?utf-8?B?cGluQUM1eWxoQ2ppZnE3TEYwQVlZNmNtUVFtTmRFSGtxVjI5bWZkNDNFREdj?=
 =?utf-8?B?Yno5K2ZDcXM4K1RzK0o3WHpjbityN1Q0T1NOS1krOUhVVGpjbEIxMnoxeTgx?=
 =?utf-8?B?SW1xRkRlMDd5Skt5akdWWndFWVFlUVVSM2doeXZGQmxhTVJxUWg3TURoL0hw?=
 =?utf-8?Q?a3jZGzHIOX4vXwJ?=
X-Microsoft-Antispam-Message-Info: eunsHif6556Z15WBHLcg3c20tPP0xU1KNwYpze7HuQ8luClxY4YA+Gfw8+sW4G/ILbgBK2DneEMR1M2tnPwaLCVfU+vUNH48CbldfbHj44CyDuJGyuOgi/n5giwF+KbGVzk7g/rrOXuflsG5SzgP+wsG/m5u+XSLq8mmpyDzSXwcmCS/5hshhXCjDTUdnxSm
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:C3W//2yD55mnwYWEG/bkzjrRN69fLlYxJgSVV9X5cTKhd2mjp1wkiPnMBC57mFHHU14J6oZ/OBcgpf62tSJjqX4810V0RvxdtNJbAmSdDziJ//2VRU66BS9qKPmrbASI0Ilsj7zMr+312+4mq7gyrUDuLAKhsL3btf/JmUD58WEjg2qhBTr1l8i50PvVEYKxL9ayoQj90CBCvS16OtBUneq6fgGnJDeJ2f+VqALf+3LdKRCnSzgeEKRI1begZt9hfkprlEFDP1qXW8u4Cq5tAVtLo1FPWxWJTr5zVLH2ndU7kxMYUvrmhw8fkkAehGKVPKH45BdaniLIRQWcosQz+2bATQghJtS/dAO6RezQMQcb7eJjV4OulafYb8msWX0Qq3Ygf+LG8eVQ4pYfLjIMhLn/m43rGHIBTbxJEjHu2VTcXgVETBQG1RaULXXOQ0cNheASTG+82jxBPHkJiT9wPw==;5:tGsKZ39sjG/A+tOvFjbXPIGMkyDYvX+3h4NcJdFTk3LtdWvW13IHs8cqQyv1O/t6q5VOn6HMHijcm1J5pduAVZr33Gahv1dLUIgqT5Oz7S72MQ30Oi1xjKvrMbNwaEGSyZFdwced7GnY1l3Sf0ES8+zIsjsguPUoQGre0HNrfv4=;24:L8cw4PrlhVK2tRfpbgIJ+QZP2gcb+JIQpC3SaCJ4fTdB77FRFUqX4lVnjnz/+BqK+TpVmSrXtIEqa6VYxCexkfEvij+huyd4I9T/cl6vG3E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:gPSjoNcWTJ5JyVodX+61UNURlrTCLyKlPYw0ixzmSr0abPK0IuXa0mjHjf0PmwyxXZwVZnpNjmJXtnJTBQfDiileWKJgOqKAIq9uatWEkVLqzih2FyYLSFdMCHjYJf2hclg/eLJxO/r9gLlX3U2ElXlas8ifMCBlydzCkuFK5qL0Yb0TeLn/1JyBb3GP3zf3o/4Fs1a2Thgwu92pDcvFJfBzzaejFsNaaEcqeHioW54Ekd3kg+P54vaK+qNvhdEj;20:xIyqOMsn4GHnsRq48i3alwcGEenmhSim0nGRAaNXEq1jPB7axYCQsbHHvkcVYM/bhUmJ06C8YrRToRFyL+Jh4rXB+CGdd94lg3QUcUHzPT5kK1gsewBkDJahdbv5V4oj2L7fIYBtk80srTN4xw939WkM/XW6uUBCR1L+r07En3s=
X-MS-Office365-Filtering-Correlation-Id: 4bc14661-dadf-4f49-f111-08d5bc9b51c0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:42:39.9545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc14661-dadf-4f49-f111-08d5bc9b51c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790688331269078?=
X-GMAIL-MSGID: =?utf-8?q?1600790688331269078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Imagine a big node with many cpus, memory cgroups and containers.
Let we have 200 containers, every container has 10 mounts,
and 10 cgroups. All container tasks don't touch foreign
containers mounts. If there is intensive pages write,
and global reclaim happens, a writing task has to iterate
over all memcgs to shrink slab, before it's able to go
to shrink_page_list().

Iteration over all the memcg slabs is very expensive:
the task has to visit 200 * 10 = 2000 shrinkers
for every memcg, and since there are 2000 memcgs,
the total calls are 2000 * 2000 = 4000000.

So, the shrinker makes 4 million do_shrink_slab() calls
just to try to isolate SWAP_CLUSTER_MAX pages in one
of the actively writing memcg via shrink_page_list().
I've observed a node spending almost 100% in kernel,
making useless iteration over already shrinked slab.

This patch adds bitmap of memcg-aware shrinkers to memcg.
The size of the bitmap depends on bitmap_nr_ids, and during
memcg life it's maintained to be enough to fit bitmap_nr_ids
shrinkers. Every bit in the map is related to corresponding
shrinker id.

Next patches will maintain set bit only for really charged
memcg. This will allow shrink_slab() to increase its
performance in significant way. See the last patch for
the numbers.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   14 +++++
 mm/memcontrol.c            |  120 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |   10 ++++
 3 files changed, 144 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 996469bc2b82..e51c6e953d7a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -112,6 +112,15 @@ struct lruvec_stat {
 	long count[NR_VM_NODE_STAT_ITEMS];
 };
 
+/*
+ * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
+ * which have elements charged to this memcg.
+ */
+struct memcg_shrinker_map {
+	struct rcu_head rcu;
+	unsigned long map[0];
+};
+
 /*
  * per-zone information in memory controller.
  */
@@ -125,6 +134,9 @@ struct mem_cgroup_per_node {
 
 	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
 
+#ifdef CONFIG_MEMCG_KMEM
+	struct memcg_shrinker_map __rcu	*shrinker_map;
+#endif
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
@@ -1261,6 +1273,8 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
+extern int memcg_expand_shrinker_maps(int new_id);
+
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 023a1e9c900e..317a72137b95 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -320,6 +320,120 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
 struct workqueue_struct *memcg_kmem_cache_wq;
 
+static int memcg_shrinker_map_size;
+static DEFINE_MUTEX(memcg_shrinker_map_mutex);
+
+static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+}
+
+static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
+					 int size, int old_size)
+{
+	struct memcg_shrinker_map *new, *old;
+	int nid;
+
+	lockdep_assert_held(&memcg_shrinker_map_mutex);
+
+	for_each_node(nid) {
+		old = rcu_dereference_protected(
+				memcg->nodeinfo[nid]->shrinker_map, true);
+		/* Not yet online memcg */
+		if (!old)
+			return 0;
+
+		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		/* Set all old bits, clear all new bits */
+		memset(new->map, (int)0xff, old_size);
+		memset((void *)new->map + old_size, 0, size - old_size);
+
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
+		if (old)
+			call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
+	}
+
+	return 0;
+}
+
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_per_node *pn;
+	struct memcg_shrinker_map *map;
+	int nid;
+
+	if (mem_cgroup_is_root(memcg))
+		return;
+
+	for_each_node(nid) {
+		pn = mem_cgroup_nodeinfo(memcg, nid);
+		map = rcu_dereference_protected(pn->shrinker_map, true);
+		if (map)
+			kvfree(map);
+		rcu_assign_pointer(pn->shrinker_map, NULL);
+	}
+}
+
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct memcg_shrinker_map *map;
+	int nid, size, ret = 0;
+
+	if (mem_cgroup_is_root(memcg))
+		return 0;
+
+	mutex_lock(&memcg_shrinker_map_mutex);
+	size = memcg_shrinker_map_size;
+	for_each_node(nid) {
+		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
+		if (!map) {
+			memcg_free_shrinker_maps(memcg);
+			ret = -ENOMEM;
+			break;
+		}
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
+	}
+	mutex_unlock(&memcg_shrinker_map_mutex);
+
+	return ret;
+}
+
+int memcg_expand_shrinker_maps(int nr)
+{
+	int size, old_size, ret = 0;
+	struct mem_cgroup *memcg;
+
+	size = DIV_ROUND_UP(nr, BITS_PER_BYTE);
+	old_size = memcg_shrinker_map_size;
+	if (size <= old_size)
+		return 0;
+
+	mutex_lock(&memcg_shrinker_map_mutex);
+	if (!root_mem_cgroup)
+		goto unlock;
+
+	for_each_mem_cgroup(memcg) {
+		if (mem_cgroup_is_root(memcg))
+			continue;
+		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
+		if (ret)
+			goto unlock;
+	}
+unlock:
+	if (!ret)
+		memcg_shrinker_map_size = size;
+	mutex_unlock(&memcg_shrinker_map_mutex);
+	return ret;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg) { }
 #endif /* CONFIG_MEMCG_KMEM */
 
 /**
@@ -4482,6 +4596,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (memcg_alloc_shrinker_maps(memcg)) {
+		mem_cgroup_id_remove(memcg);
+		return -ENOMEM;
+	}
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	atomic_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -4534,6 +4653,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
+	memcg_free_shrinker_maps(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3de12a9bdf85..f09ea20d7270 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -171,6 +171,7 @@ static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG_KMEM
 static DEFINE_IDR(shrinker_idr);
+static int memcg_shrinker_nr_max;
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
@@ -181,6 +182,15 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	ret = id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto unlock;
+
+	if (id >= memcg_shrinker_nr_max) {
+		if (memcg_expand_shrinker_maps(id + 1)) {
+			idr_remove(&shrinker_idr, id);
+			goto unlock;
+		}
+		memcg_shrinker_nr_max = id + 1;
+	}
+
 	shrinker->id = id;
 	ret = 0;
 unlock:
