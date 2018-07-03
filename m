Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFE0C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A930C21A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S1Ouj2hH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A930C21A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbeGCPLj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:11:39 -0400
Received: from mail-ve1eur01on0106.outbound.protection.outlook.com ([104.47.1.106]:28789
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932759AbeGCPLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TlS+UDlFKPPD4s+Yg3oUBGPb8YA+sXrmXf4fIjF4eA=;
 b=S1Ouj2hHujfSBATexagheOmqO2kzJ3162XrETLMLCjkZ60A5RgIzZW8BRDhc3Pro9zKWq38+FcoI327jbC4Flmd4QgmvheAQd0XHh0LnjEzkid878qTsAy2VEOOze4hwVqYCJvYGE+XjXC6nbVPCmLfsaVB/hhQoI61TyahsaYk=
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB1340.eurprd08.prod.outlook.com (2603:10a6:3:3a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 15:11:26 +0000
Subject: [PATCH v8 15/17] mm: Generalize shrink_slab() calls in shrink_node()
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
Date:   Tue, 03 Jul 2018 18:11:23 +0300
Message-ID: <153063068338.1818.11496084754797453962.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6PR07CA0006.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::16) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0423b188-d798-4a37-0242-08d5e0f7417d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:+eW54pZ9aaXQX8E7hRIKuINRGsOfBWA73muyLvskirBAUyo0nLP6Yglo3MWgJLqjJ+OS8F/GVJYKuKqza8/8SpUU8HJrbHXma83i9ienp+1ML/qQrzjOdNnY0NltEeJRyp1jkR1s46Lt1qHYVChtJ7hXE+Ip/n41StbnPvOndaObrY8a+EJJaGcHCJ/jfSb/C7c6dXLmHDBEtJAtA0X5o2RvRRVpAzHAgrWdQyNpGI+z78xpuOkWic/FNOlp5tra;25:mldvV9mZGWj90D87Kk7rA1HiQMyJj4MVJXdcRyMu49El7sEfa2OU1uEVJGFeu9W6fqOVVfYOfFuNDNo6jCwlc0xg4HIStpZhPWTH34CN7dKLZ+y0WnkR7YUo3BVsNaxhwgDOoezhISbz08k92X33dffotu8eHDgjehtKuSMghruGQB54AQOLC0HTXD0UsKwGMCwWxjR3MXGn2WM7fcmyiAT5l2WPghzpJb1bOpPtEFgZHicxkSogvK8bMQvcxDhfiJfjiDi1yu+Kr16EuSutcBFNqfCzKSq3MKdSOyIwPEDThJgEW/lRbI7PF9mhyCadM0fYypkH8AqmlOdFx3ViEw==;31:BkO7eelUGEBzs4KDgjCZUSyL8vnhBp22aGy99XHBQegXDFTKqHmv8pPIFffBOAVkiHvZV/5L8s3VWwVCs299hfTqI+x/67+89Z75OkbeUfTvFXBxpoQ1FoR2TzpriuFOJj+ImchaCiVdYujnubRqypWhxQF5AP64B2kENzO/yq/L2/SKzQgl3UvN8l3G7UyTbZugrfpJdsNs+vI6fBx446DjEcqk14gCxMKrCQ9meLQ=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:LtBn9r9muy25D+nudxxGq7fbZRsJTyrjSRJ67RNDQO3/7nKkUclhXuFHSMkWsU7riUpXPT9EuYq5A9y01GvR6EYx6cLTS9ENWLdR9yriMgXmniGaVdRzNd3E6ef801AVJpFRin7kSy7Jf9aH4wL373S1Ztkha7YyAI6rkyT1gIBqZ6ZrGHfhFEjfJsRQQidWNNHKtdW97CudUVyc2Ef6kl1Nv9BZXJR3N3YiZPSF0UMG+6YW/h9hoOQFhZIor4vAmM4MPUl+qdhnZmC9lNE/eReMefNN6GPThX83etI7QaLlFVNR3hDlSHhzt8sjyKk6KJkEi+mUq1hOiOq4Ojy3Bd8SBruBXaIzBHosPt8uGItRuuumX2vkhUA2TJw5j8Muvz8vHh9kN0ITX2jo0TH9EhZV08S7z3/Fq+FdXTVDDmurF5YdhmCB0BljcveLxg9bQd40T4oqyojo9yXwVPjgcSIHGjC51X7ic+H55Uen8f+Cyof9EP5WZZUsgBNkjC+v;4:CXac3reXvtiA7Qah8faUKeTodEfSdZ78Z/XYc1Ztc5igL4LR4gbsYeLJlIonYvrTIVjkv2smXB1eZ9m14BCU6qRYB+nVmthppSvKYKjI6Ydr9BweRUGdcJvq1NYFtL8iJ1YvZiGmnDAUYxBqyOtzfx+Qp3egzQozDNGCFhJqfpuD8ljgQNva7712HTgGxi6EJ3yLP9/CoE1p+kB/sNFbz9R80I68jGSeYLLXWsHp5jczSQASWpT3pdibzfx402M6Ta60pwJY4xYWpQH0cDiCWHDehv80YY8Sat/OMZDUEiSVdEj4c1MUj8Wvu6PN/hPARIdl8BRlV5MpaY+qwth6vIn7U+CZpF+YN/QBLFSogcCM7xyNdBBLxaU5lgGwxPkI
X-Microsoft-Antispam-PRVS: <HE1PR0801MB134069252F0A2C1583B993C6CD420@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(103116003)(6506007)(50466002)(956004)(5660300001)(486006)(105586002)(61506002)(14444005)(11346002)(3846002)(6116002)(53936002)(68736007)(55016002)(26005)(9686003)(476003)(386003)(7416002)(16526019)(446003)(7736002)(2486003)(58126008)(52116002)(316002)(23676004)(25786009)(97736004)(81156014)(8676002)(81166006)(186003)(2906002)(106356001)(76176011)(66066001)(47776003)(6666003)(230700001)(33896004)(8936002)(7696005)(39060400002)(575784001)(478600001)(86362001)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6TWF0ZGIxc1BabVlxYTY2SXdxMVRqZjNQ?=
 =?utf-8?B?MFdHUU5vZTJXRXVpZjBPZUQ3UUh3cTErR1UrQUNhdk9LdHNPSkVSbEtEOFVN?=
 =?utf-8?B?R0FETHdIWnhOWjFzUE5OY29kYit2UWVET3kxUHpUUjJYSDhUc3U3WmJzSHVw?=
 =?utf-8?B?ek5LTCtUKzFab1pIZ0RES3Z1bGlPSVJSamUweVA4cDlUU1lBZTFCV2lUakJJ?=
 =?utf-8?B?ZS9lMkNxUTYyQWlJQWJrT2dHREsvTHA5NzU0cHkrMSsvTElkQnA2TXZxV2p5?=
 =?utf-8?B?SnJrQzg0YkQxMkZnbXc3dzJGSmQwakE1cGJOOGpWMmpGU3hDdyt3L1ZrSVNB?=
 =?utf-8?B?NHJ5NjJ3eVBNZzZXemJ3aEFoSVBsU2lvU2JPVWF4Y0tVeUxuNzV6NFBYemhI?=
 =?utf-8?B?UFZNM3dwQ0hQNnBsTEt4eHJJRnpVdnAzWmVFbEdXcVpaazVYNUtucFdRTVJn?=
 =?utf-8?B?c3dlby9jUUt1ZVduRWlwcHNPV3lsSDg5U3NBTlFZTTRKUEVBY1lsblFleGo5?=
 =?utf-8?B?VWRWUEFFZmJtckVQbUY4VGdJYnBNTUtKZmRzNE9zTklBblhsRWxNbW8rZnAr?=
 =?utf-8?B?R3ZmeVF0RFU2UkJvWDZJK0VYeDdKZ0RySDRJOWl6SXR2Zm1YZnJMQ1BuTHUz?=
 =?utf-8?B?L1JjNGtJcm1uaFc2NXdZa1lrMnZkUXVBTUF2RENPckpSRVdqNDYyUklsMlpu?=
 =?utf-8?B?VTkvTC8rRnp0aVErQ1hjVkYycmlERUp2eEFzL1B3UUNMNklNay9wRWlvL3lp?=
 =?utf-8?B?RTVsVm9vMDVtOFRhRjhPOWpUWHVEUEt3Qk9CSGx6ekF2bVF2akMzd3pETXht?=
 =?utf-8?B?UHpBeWZibjAwQktHeWNxckRON3V2MjFodWc5MTB1VU14ZXpENGZJSTJaS3Fn?=
 =?utf-8?B?UEtiYmlWeHBlekNSeDl1emNhSWUzOEo4bDEyS0xyQUk2TTlKbktGM2kyVnEz?=
 =?utf-8?B?bk9WWUJnZkNzdnRsWFVONnd4OEU4bTEwOG5wZHdIT0doOEkvWEJ6REZWVUVs?=
 =?utf-8?B?ZTB3ZkJDNDRmS2Zsb0lYQlNPSVEyeVVQdFZTVnNPTnNiVSs0dk1VMytKdjlZ?=
 =?utf-8?B?Qjc0d0xVZ1FTb3pRaWt2ZFppK1dGeExRMkgzTnJyeUg1djVkbHI5SWlUV3dS?=
 =?utf-8?B?WEd0MVJRQ3p6V1htZjAzdUJmYmRUTWxkditwWjFnS3gzT1BrNlNZWTlKVUxH?=
 =?utf-8?B?SVF2dy9uLzJVMEpCeG9NUFQzUFZJYmNDbjhUeHl2SSthVVo2OTg1SXcrQnpN?=
 =?utf-8?B?UjdWLzZtdE05NHY2b0NFUUVEdGtjMEZkVGl4MFhaSEI0a01hZGhmSWhueno4?=
 =?utf-8?B?ZHUwUGlDZXBDUFZLTEd5Y1hIaGxESnZicjBQMGcwMnZYbEF6a0hMd2VldVQz?=
 =?utf-8?B?SFFrdFRhRVlJM2toWXZCcnBKZ3ZPd3l3ZmpRdDd0L0E4WFlwSnVBV0l1emE1?=
 =?utf-8?B?S0x6MUM2c214a0w5MndvQjRQdnQySnU1VzU1K1kvNGZpTDlzU2FWYXV5S1Vq?=
 =?utf-8?B?QmRZczZmODRtTUdCakkvOEdVNWp4NG1BMlhwVlQyMkVDV201eGZQSm5nbVlG?=
 =?utf-8?B?NEJIU1JhUHNERk11aVpSUEJaQWFxTlJBV00vOFI1U2dEOHpjMGt4SXhDTytu?=
 =?utf-8?B?Z0RUN1grU2ozc3hEMUI0S2dmSDNSSXVsbzdESEM3NkhQVlBaL0U1d3d6d0VM?=
 =?utf-8?B?cWRKenVoZUU5d25iK3VORVlIUUpmR0dxSmhOQVJRbGlyblZwT3lQZXNPYlhD?=
 =?utf-8?Q?PJfgy4t3xuJ0sronBxzd68J/wZ8EV0Y5HhJiaS0=3D?=
X-Microsoft-Antispam-Message-Info: 38bdrhtdPIebCWG/OCSN2H/gj/V26LQI6N7Pomd7iN6wACfIj3kvynrHsfwqcu3hEayO5dfjd8fWm3T5Kx370vFScJCMKyuSMnGif/+ruUe62W8fNP+Zuc2jUOjY7aT4w/WD/Omzu2BvhlZPmDB5m4ntBZJXNLuCYThE785AoNF5+lSV1IjqfhvpX/uB/osnzVebmYQX4/k4uexeuAlnbZSgzEGHve55174nPl3YzC6UBTTOX1lvy+5FnEssvGbGFEjGzWcZXFjaKy+D/BebfS5G0d1F2LlvDvbf6EKw0yV/39GDJiOYUaOQnZe8YguXj/+eBxOiUAYvDAJFaW1Jvx//ziSHMpb5dplrBjMfCfs=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:yl2RLCyjha54nexyIkQjEymN0l6IMiIWkmGU2Y7feoFI3TV2RsOby7573pMMSwvG8tkPSxuLXcJcx0bBwf1R22Oc2rW1Dyex50ms8Pe0XErSJTuqbgKAaIY4Vx6ugc+54CP+zA/igqU79gwP2oCyw9u8VKJeObQdoTNGU+Z/cidtnEdcp/QDAJzyRW43uA/SZhfdiycLVbiuycI3LGjx8blv9SsGFAr8EgEC8vsdwJWEjmUR/wFNPtMuW9EpRPwcSCJ2/8H8dU47tlC67Yt9VWKG7sWxCS3ZAL8QngEkrOZ4fVGfvooN2a0BngMEGSHDYYRcyuLBgVrtocEUsNrZzcq0MVsv65PhuUiFmToVnP6LEu0Ag45+dSLYU0frDDulZ8YtEqQOhasiN8UaDcNjzAB2Qel7724oX8QQrTSWL22YLAAQBcHlWTVcA0KCernmPkIxxdB3YJwMfP2dIxfwYA==;5:mFuc4nr1Q61R+qqWV2F4SGipNeRNX7SUXEJA457882f/XV4fT7iAR0++kyfUscs2fvLtnr1GRCVzM4M4rrL5dArnKVpSMd5lWwA0zIP8uEFDme86/pBrpzHPsEIahp7HNCe21Q0W6vI44diqYsOh1sRMgGe4zqTZTilil3nROlI=;24:iyacC9krg10u5rQVii1SmhE0+9Pw3+9SAR2iwAyUe/o3xzQ5jfD1T99J0OFq0cuahp7C2MmG/g2ABvmuaUmBBSqId5KsOVUGRs+iHQB0twE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:Pxer+ejntS9RZSJS0rn+iE/n2TIiqjl+i8mQW5jBj+POWKuf1lKAbZh8lEkGtxSSGTOKn+WSNZ0RHcwcgt8G42UAk8x25RkDnB7vlm7KzYmdHwBIRjAAMPDYNQvga+Liu+3X7qodxk9nYufQ3MwAEA8eqmO5fc/Zy44E1zVEb6a3Zt2VouPhSYGNOfmKHubEZMEAUhEhd74hqPkmS3SvhJfWDxVv4/QLFlzR34/AAxL6KXdbUxOC2+TAFKpkl/K/;20:JF1zjgDb1H72NKNMKHWdk17s8f/6JAXBV5/mjZOGFK04e/h952LodjtMzeZJyJHYDJGwAosTKj+grfDloDoP6B236+LOnGNa8cxs/hB4O1C/40BQzhVySr5yht9d9O2eXqGK5SbPJGpit5hMeClLzF+0sum2cpS3sAi1u0iHM9A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:11:26.5898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0423b188-d798-4a37-0242-08d5e0f7417d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Davydov <vdavydov.dev@gmail.com>

The patch makes shrink_slab() be called for root_mem_cgroup
in the same way as it's called for the rest of cgroups.
This simplifies the logic and improves the readability.

Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
ktkhai: Description written.
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d4c40ed9ec5d..39f0ba75f7f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -628,10 +628,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
  * @nid is passed along to shrinkers with SHRINKER_NUMA_AWARE set,
  * unaware shrinkers will receive a node id of 0 instead.
  *
- * @memcg specifies the memory cgroup to target. If it is not NULL,
- * only shrinkers with SHRINKER_MEMCG_AWARE set will be called to scan
- * objects from the memory cgroup specified. Otherwise, only unaware
- * shrinkers are called.
+ * @memcg specifies the memory cgroup to target. Unaware shrinkers
+ * are called only if it is the root cgroup.
  *
  * @priority is sc->priority, we take the number of objects and >> by priority
  * in order to get the scan target.
@@ -645,7 +643,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && !mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
@@ -658,9 +656,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
-			continue;
-
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
@@ -690,6 +685,7 @@ void drop_slab_node(int nid)
 		struct mem_cgroup *memcg = NULL;
 
 		freed = 0;
+		memcg = mem_cgroup_iter(NULL, NULL, NULL);
 		do {
 			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
 		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
@@ -2709,9 +2705,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			shrink_node_memcg(pgdat, memcg, sc, &lru_pages);
 			node_lru_pages += lru_pages;
 
-			if (memcg)
-				shrink_slab(sc->gfp_mask, pgdat->node_id,
-					    memcg, sc->priority);
+			shrink_slab(sc->gfp_mask, pgdat->node_id,
+				    memcg, sc->priority);
 
 			/* Record the group's reclaim efficiency */
 			vmpressure(sc->gfp_mask, memcg, false,
@@ -2735,10 +2730,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			}
 		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
 
-		if (global_reclaim(sc))
-			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
-				    sc->priority);
-
 		if (reclaim_state) {
 			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;

