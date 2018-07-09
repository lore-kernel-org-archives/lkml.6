Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE280C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9386820864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fgpTUO7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9386820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeGIIiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:38:01 -0400
Received: from mail-db5eur01on0108.outbound.protection.outlook.com ([104.47.2.108]:38208
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932466AbeGIIh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mfdH0iH0DaLkrWSziKCI0u112NKWqMjP+WeVBtnVk0=;
 b=fgpTUO7w7xsVrAB3tMxRcBXvRInqa3gk5X8/xubv2w3wS5KKhmvIaw4BF739ZFHTQUDtjz+3fNu27qOL6vwz1npQD/3mpF28WOfpQXLUG8EDq9I8LEnc3Daha6c0wbMYzaktyFKd9PN6VPzNQ0XW5itrdQ8TeZlPIxgYcPN/XOc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB1337.eurprd08.prod.outlook.com (2603:10a6:3:39::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 08:37:52 +0000
Subject: [PATCH v9 03/17] mm: Assign id to every memcg-aware shrinker
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Mon, 09 Jul 2018 11:37:44 +0300
Message-ID: <153112546435.4097.10607140323811756557.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0301CA0002.eurprd03.prod.outlook.com
 (2603:10a6:3:76::12) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4836d9b1-73f9-414b-b3c7-08d5e57743bb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:iFqpcSc6h9awBSoNRhSB6E9YVLf2BZ8aa4+KrF+a+ZNC2N2qJfs3VgqLto+hM6Y0BC6kULmj/pkxkhvF8wRFgF2duzaNx6dOMU0awEub8vPWwUzypzVzZGAkPVnMuDbW7WlCo45if2bQwkrLzqZIJHFOaozvXAxzJ1RyamRkDeQe3dAMI+fRlVN1g5AA8cbcZKzNrQs7qB5ciCbCAJKmmqN3sQADh5zgKUoowtdFqP4BEMft/pEwtoXOngW/lTEk;25:tQT2g9zQT2Hw7KoevP3ntK5agyaAu8HoD0mJvTV68KbsE0G8xe3AkqoiXcvGP5r/sksvNYAUV2goP1K4g4fGeBA/SLZ3f9Z8UHoJPjSL0N1RQg/rBYYmadLUK2ZMw15ni+NP3wjqUxXB77zDxkFVKKwYWLJFTeTSwSqzhEnAXykjVwNp8NPGt85OEqbXyOUUkAuwkODIe7Y0qVeTEDeLPxymQqn5+36SOjd0BkxGDigBSPUcpcRU6BpgwAV/1DuVEv+ZgmbNB4+t5X83lZW5kBiCI530VA1cZuJJclmp9QA0tkdweYHYdWEBzWmFhw4v92BJ+56ckLpSdTZIconTyA==;31:oudXY0ANF0KIUEsDkP+aWjDxZs8Op87V9OwP29VvopRuvYQG5rxWRyJwJ88+G1oa03Mx5dy4l0MFNQXtTHpnIHICj1Zd0MvYWp/WwxSd0Ivb/+hLIe4bJ9TyAgR9tPqi8IoKuBON0vbtT6xjg5Qi676ySO7e38/3yqDjD4zmIualocaluZEKpwaUvjMVGFaCXd6msl203JHYZmlq1oWBQb4L7vUpeZp+qm/jQnK3lE4=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:PhQK8jm8lDn3NLlu+N6OB3EzaWCC+FyoU+IqssaExhcS92/1hx2Nf1vLnod3Q1lGclhuHPny1w5DcYY2lNF1VJbv1ScYWe/Jhuz8AAm37H/iydYStxdyVdwgDXq5sRP0d6q6Q2u5rO+wGv21caaaCKBFNM5rVO7wNve97OBTOVCREQ39C7e0UDotbff9XTmSuOqbSZWCPWfYDpigP2wZYjDwV6H0+megu5vT8hXgDuNzwNZksvAUxhnQ5fKouA1anvbE8dKkfRcurddqf8diRzmPQemOkhDERF2uKRzA0/EdQmkuZglsqZxUcsQVnUVS87AVBZ6UwKQ/9WnPRzk6KnEqUDuyp7x6OXy+UEypUC8OK+1jk9wFt0rpgdcM0E3XGoJkkoTGHEU7//7ae3oADDop6isb0Ntt0gZij/eRUvBqIxi5JEUSVoNuur/PUItMGzn3+Cxe3+nzpPQFLBU9hipKooNva6eaAdfmxABCD8OdzZHqGI9yeZNWOfuPCJze;4:0y5Yi5X/1wP1h+kta1Oc6XGdspuiP1WFs3iPIjs6Uwc4xPINeaEVDIEfDSzfJxSbLgi2lwarWtuTTyFOJmvvGnhHdQDrymxHqZSsU1kKSFNNUnP4GHRSkJBbAH3bC62ifDe8ob9mT13uEH090wtchQGg6eLVy6GAKmDzdjxeQyumSX2BCki81Zd+0Uz+I0wZxGZLiin7c4FEkTbQwRGHCRkL2JsM3o55TFGkPyjIChp3MIMrauZrZ4KBeibjsJkR3Y4UpbdRUSVTW0x6wgJW+4nd/JwifjbsGoZt8TyLbpY71KCocWZ7I3OQ2KkwJ4aUJqHPcA3efOq4wQO4bVGTo9yI31Zj6HF9MyGF7s9RlBY0fPoXGNjscAYWS+9oeM04
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337C7A0B9E46F44C74616C8CD440@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(366004)(39840400004)(376002)(136003)(396003)(189003)(199004)(105586002)(50466002)(106356001)(52116002)(478600001)(97736004)(86362001)(16526019)(76176011)(316002)(7696005)(33896004)(186003)(6666003)(26005)(7416002)(103116003)(25786009)(5660300001)(39060400002)(8936002)(53936002)(14444005)(61506002)(68736007)(9686003)(476003)(956004)(11346002)(230700001)(446003)(2486003)(7736002)(3846002)(305945005)(6116002)(58126008)(23676004)(386003)(8676002)(6506007)(47776003)(55016002)(2906002)(81166006)(81156014)(66066001)(486006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6SWhsM3UrZFBnMEdJVUZYMHpBYVE5WS9w?=
 =?utf-8?B?RDFKVXVBL1creEd3YzJCcCs2eXNPY3dacWZkWGpTVWdwdGdJaEQ0cGdtWGZ5?=
 =?utf-8?B?YVR3V05wMDUvQTRwa3ArSnZGcUJHNS9GeEFacVlVaDV1WUpPSHhvMDQzS3Mr?=
 =?utf-8?B?dC9MR3B1ckdzUldUTC9QVmU0MDhyMDBzalBoa0NvMjA0MHRjUW1tNzlhZ21Y?=
 =?utf-8?B?aE5LdTE5QWQ0WDVYNERacjlRc0ZITEFLbHFOTEcwK0RiSGdra3ppTVBLSUlJ?=
 =?utf-8?B?UEd0dHZ1ZkZ3cEZzcER0YlE2TTlyVXRCd1liV2dFVXU5emgza1JNR3NDVWpZ?=
 =?utf-8?B?dnRXaVlvUUdsM09OUzNKditQbXByZzBPcWNCQTkwcTdTTm9YS2hDMXNtQ2tH?=
 =?utf-8?B?SkkvZHNWVDF2MDVrcEtpWkUrUjdYbS8vbmFmTnprRUUxSW9tWUs1b0M3THkr?=
 =?utf-8?B?TEFmTzB6U2VMcEZjeUdSbkFybjY1aTZLRUR0bjZlbXdZWUlFMkl5TVR2N1Jo?=
 =?utf-8?B?Z2lHWFkrYzZ0QTV3YStBSDdtUW5LdkdPSXRwSmdVVUtZYzVDVWYvOGdEd1hp?=
 =?utf-8?B?b1pmMWQzcWttaDZkZjBlRG04b2Q2aFhUNTNCcCs0dVI3OHR4WUNkTHhmbGVN?=
 =?utf-8?B?YmlQUUJiSmhiTnN2Nm95RlBUckVvL0VUZ3FuS1NtWjV4YzNSS3oyWXVacWJo?=
 =?utf-8?B?M042bWFQeFhJc2NwQ1BiRVcxMUEwam1uUGNRb2pCd3VzZGZVNjBxR1Z5aUp1?=
 =?utf-8?B?M1Q0MElSc1hzZGpFQS94SWZrQjA2SG8xVE1TQjdEK3J6QndwY1hZbStJSzZ3?=
 =?utf-8?B?NFpKTzE4bFBaMnVkQ25wdTdtMEgzNjVLM21hTWJ0bE9GUkdpZ0s5Z1E5Mm9o?=
 =?utf-8?B?anlCN0JVWVBuNkJuVVNvU2RhbVpvQUwvVTNYL3BaRloya0ErK2JES09RK1NS?=
 =?utf-8?B?Q0hKbzRrZVJIbFRDekxGVlVoUGVSTjZtUkVZelV0QjJQTHlnZ2dsQVpyZjgy?=
 =?utf-8?B?bW5hMWpEd09iOUNVZUJ6Q0JjY1phYlBsNXdnSnF4V0dpWVBDcVQ5R3dGeCts?=
 =?utf-8?B?a1JUcEdBelRWTnlqejNRdzhTeWFvOXY5anlxcXV5eGFRRkRLVzVaa3prQmND?=
 =?utf-8?B?NUVTbDFONitERXM0UnhsTmppNTZGT3cxTmM3bnVrVzQ3cU94dWt5R0RHY1k4?=
 =?utf-8?B?dEpqNTVxZlhkZC83M1liNVJENUNwWnIyVzkxekUyNHUrRUFGelEySjNRcjhs?=
 =?utf-8?B?VTI2MEhWWENtUTVvdC9TemdSOG9MTFQzVEpMdzFlOHFxbmxJQWNNejc0L0Jl?=
 =?utf-8?B?MU1lUmRYemlDS2JlYkMzZ2E1UDJDS0lXNC95V0o3OGJ4dUpsQWQ2T0pTbGdv?=
 =?utf-8?B?YjM2clQySHIyRHNDa2VrVUdWN0YyRitpMzA3d0Y2azBZOTFFUGlvQzVNT3FV?=
 =?utf-8?B?eDBoNXUvMHZkR0ZxNmFqWWlBVS90SWkvbGZVRnpXa2ttU2tDY1JkVGlkWjdn?=
 =?utf-8?B?YTJMeEQwR3VKcHBERHB5a21mL1p3Z2o1ZURmNU0waU1LbGk2ZktpYlJoRFAv?=
 =?utf-8?B?REVUME12VENUNzB3T3dSUkpIUy9mdjhZL0M0RkVXMzdmeWk4WjUyVDFqamtN?=
 =?utf-8?B?RnhXS09XVGpUWTdwdy9XL3hySFlQbkVRUGZKb1FRTUhpUmtpa21sK2tBMEdw?=
 =?utf-8?B?cDRjTDdoM3A4UU95STFMaFVTNUVzM3ZYSEprNnQ5cHdRS2p5OEdWYi9DWWxJ?=
 =?utf-8?B?bjZkN21WbWh6L2JSS3N0eTB3PT0=?=
X-Microsoft-Antispam-Message-Info: b+2dq4mfjz2yAu0EGK26MeA2H5i5UXR3+rX83FHrHFdebl4h9jnbZ9R/JIHL1Hdt5wNeV0RvCciNe7G9WCJlbO4im35RUn34Y7a/QSymbxZbubd5yaXRZFZ5oBgizvZ7OotQzQwpYfpjitmjHoT+2s5uYVrw9CqGl6bmwH8UeKFbZoYs3Gb6afVRVvaxRkD/jLVcOcoUC0fv9pVKJyiilVQGciKAa9qTfBbryEjqx7qYCgRc4HUHLyx57I7UwcTCg6iaBGrcdWqpQ/pucEaaCGAJpnfuPjogQ0zeVgUU3vOR93EkTs2j/fe2wqwz9K5mDLFLM+KUpjsMJN4nMe0CuTdVeoUu8a8mkn44NiKsAfU=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:pTPfM0CT7k2CsDXeFajCH2Bmn9ptFkGrz6dAjrXsyHJtIk51aZbp9U9CIAk2s43IizIxuSw9TUzeW1YvtRGIXn+0ZEYZtKdAYVah5blLjZZ7UP3F35Z00tf22CHDnW4D8cC+IgUdhlNbnJzh/g24Bb/eXC3O2Y/NiKlAt5eCjo3dcgsvfhs4yrzaFGVKiuyreRjbQ8u01LYb4RuDtk/laUiq9FOeNHN9Irx3CgsdeFh/6EDb8xWuYHnRQ7zjvF3U0d++CVBgpvtbE2zdCpu96mtDri0xouPdwjHkJkYZuw75RkKqPUqus2XELgyRszleLg4aSa1uLBPDALymahJMp7gvYDcF08GzcGyCqteiODoXhV01rqxeyU6P2pFdJsgqejCcSp6/6G6o1XJlf5HBreKS2mxBhXZM0n3ME9rpiexNZjBvV0ep5uueij+msnHGAL1zWAIlcx+HZgWmyrRAww==;5:WJLC0fm8g92dFNitoCSORFZkwDdRcrKfAHQMc48rTFz99JpAoBLqtDWTM++e8/ZY0EDSJv6wUf79ypandToofb8VU+OSkNQ1dXKccvh09N6yMlN2JgSVoeuqAYHnKQp8HDdoW4ZZtLFcbvYoPoCjqlJJ6zbBmWmLz75I/NXEfj8=;24:lVypnAaKwO017V0Z/TZSkkhLnvED1DroPJ5jP5l3XBaBgOnzJ+zPY8FTzj4g1Kb5vdFdg8ruON7w0QOawl+3P/5tiEOVBmy/oXfss3nJykY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:f6ynvM7X+E+S+jIg5AdK/LQ2reEylR/DbGFWMUMSo788BhJ39BpObG+D6M+r5GHaJBrQPASyAzl1A/nlT0Xylp1HB4AX5Fm0aYCND60NGmtmW7mZbN0ThNnySBVAT24Jd3TeTghGWLao0OZIUJkTO2qkpGQ6Z7B09L/0QOSkolMwVvvr7tYSEU0+uovFx8BVQo0Qpa/hGk6e48bFOgaUR1kN8hOh7GAS1kQ48teFZub3oIlXSdUPNZ3xGF6VGHgV;20:2HgVs5eOuF6A7AI42dnvYMzE8ZmjiQshefJ5A9dwvedHD6dF6mpeKMErcVfO7RPFDEayHHcqWDF0sj+Xn+PSANbxDFhIFSB26vSHUSm/p5qkghiVAphi6XdqqOcW3F6Czk9tTSE6lQx45/JK6885KSV9FCLAHfBEk/cVgpO/PpY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:37:52.8817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4836d9b1-73f9-414b-b3c7-08d5e57743bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch introduces shrinker::id number, which is used to enumerate
memcg-aware shrinkers. The number start from 0, and the code tries
to maintain it as small as possible.

This will be used as to represent a memcg-aware shrinkers in memcg
shrinkers map.

Since all memcg-aware shrinkers are based on list_lru, which is per-memcg
in case of !CONFIG_MEMCG_KMEM only, the new functionality will be under
this config option.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/shrinker.h |    4 +++
 mm/vmscan.c              |   63 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 6794490f25b2..7ca9c18cf130 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -66,6 +66,10 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
+#ifdef CONFIG_MEMCG_KMEM
+	/* ID in shrinker_idr */
+	int id;
+#endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a00d94530e57..5cb4f779ea4a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -169,6 +169,50 @@ unsigned long vm_total_pages;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+#ifdef CONFIG_MEMCG_KMEM
+static DEFINE_IDR(shrinker_idr);
+static int shrinker_nr_max;
+
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id, ret = -ENOMEM;
+
+	down_write(&shrinker_rwsem);
+	/* This may call shrinker, so it must use down_read_trylock() */
+	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		goto unlock;
+
+	if (id >= shrinker_nr_max)
+		shrinker_nr_max = id + 1;
+	shrinker->id = id;
+	ret = 0;
+unlock:
+	up_write(&shrinker_rwsem);
+	return ret;
+}
+
+static void unregister_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id = shrinker->id;
+
+	BUG_ON(id < 0);
+
+	down_write(&shrinker_rwsem);
+	idr_remove(&shrinker_idr, id);
+	up_write(&shrinker_rwsem);
+}
+#else /* CONFIG_MEMCG_KMEM */
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	return 0;
+}
+
+static void unregister_memcg_shrinker(struct shrinker *shrinker)
+{
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 #ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
 {
@@ -313,11 +357,28 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		if (prealloc_memcg_shrinker(shrinker))
+			goto free_deferred;
+	}
+
 	return 0;
+
+free_deferred:
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
+	if (!shrinker->nr_deferred)
+		return;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -347,6 +408,8 @@ void unregister_shrinker(struct shrinker *shrinker)
 {
 	if (!shrinker->nr_deferred)
 		return;
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);

