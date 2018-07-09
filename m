Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B50C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943D720875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ct7MtOHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943D720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754707AbeGIIjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:39:47 -0400
Received: from mail-eopbgr30123.outbound.protection.outlook.com ([40.107.3.123]:7782
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754011AbeGIIjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CICRSzF2GCe9mPZHynBVFS1tpCEK4vd85KsEr3JL4ME=;
 b=Ct7MtOHIibwm1A2RDP7PQYBfo4cNJtdi0dHnkkk5ruZhQWYoZqW8GjxbCDAzqHRzNePBBblo8B2rZMiYTwdSq8ee/emx8PpMMalpUwtSSp1fzGPAvHvQBO0uE4VNMxKtaDnVD9Bq6BQEji8FpcI9C7mypNyNnhTlgDs32b+BEAo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Mon, 9 Jul 2018 08:39:37 +0000
Subject: [PATCH v9 13/17] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
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
Date:   Mon, 09 Jul 2018 11:39:35 +0300
Message-ID: <153112557572.4097.17315791419810749985.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0701CA0015.eurprd07.prod.outlook.com
 (2603:10a6:203:51::25) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ec5293-31a2-406d-3d65-08d5e577829c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:HTgXxt4Fwc2sZWJ000hFOKFLOi3dA/SlyaT+z3Cik2bL1X/5hwqk3C07ZVX/Peo1Ej0Avj/v3wPb50o1Bt9PGToYdZByQTQxwbL4DzM90gohQ8x+Yewgs6My2lmysTcvAvN/kYbdpxcj3YbEP5gBLsWxwmnzwbUK07nmkEdHRu54Icjv615CJ6GGI6Y/UhyZroIGvpMjnsVKkvv3UhKJ7+2yQ7LVGib4y+PWpd3lCGuKbWe16PtHfhs4l46KxLSo;25:CJEVgaIHezohVy5r8EaUv3TQL4Ib6JWDq5lWCpK0oCQa34KQFgxNr4T4E7V+9LlZesp/UsSRe8GJZPNhEbo221A7QPqnsN8HqWxNnC5QU6EohP+cgijWc2+gFIzvf/9xc67kSoWE4AyueoGdOI1wn+Z4MycfJIFiqj4jjctPONB2FSpHUViJXXV6IrJmx2g7Bv5XGrV2N8/NlbkeZjXSFkye2G0ELHvNRJjCc/DQYP/dMK7l43hHoESF86Kzqn5pnH6Vkj+On1zaqzKRLV/cf6BQ392jPFKH6YOQ3oo49aFvFZwUqFvz+KEfjvAhuBJuEx+3R/DuDisx5rkuFZ9paA==;31:pYB5+GXVD9bgREb36zwfSi6d7ft0wj54V3Vi+Ypmf+SwTW07mUA0u2spevh95uZALFbNMGU5Kq1RXqSzNXds6PbGPk401KdQNnBwvsLt7M4k0urdKlHwjL2yfF+aSi8Oiuu8hrNgO4mclS1dpsY1HVBs2b1+vnsINaCm2AGFwlLUHKc6Yi6ScIOyZ4wmmhquU7Q53ic+aSXX556SWPQU1bfbBhKt+7qUhnbrRFkD5H0=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:6lBuabB+I/QbwgFy2dkGXcqP7Ji0FJ5rOOliia7LhanzXSnNjp+tt5l0QiQd5uGlCTWZ0Wc4UFY5Vk6EzLPMInHngdOZ71flF1EK1P5x/8IJ1xdYR/mg2fMG8N8Yn7aCiYv+BlU52MJhLSp4WvPo7J474ZSQqX97F7y9oVeAAi8w5SXQSFFiiv9xCP9jD8tIB2WGQiPEO3BLjehj0mDp+/BEo+U1Bo9mBhrdQG8UzTsToYjDYquyXFqUJyF0o2nSk/EEJZu8XxLV4Re48AW3y7YBmzJ8B8XkI18SIAZDXSq8c0enJjJ9+3KeZHctVGCUE6xfyNCYr+gg4hw1DhV/37GU8CxLfL2fT6J+x77vtW30jBoP2dViXCzvo/wCdtEHTPy8jCZdNMFR46XO381lP6oPzMM9DDpoO46xH6NsvYk3tjopcFPDHUD4QCZFyn4Bl8/SQfWsfdpgwXuE6RdfG9mEIqudJfIAe8OHKzYKcRqB/+mNKYEr/ZaxmJ1Lc1wt;4:e4/G8IA2JM+TdfTXa+0ztidsI3NMBgk2fR9v6EmjPiSu3nitaNxmzHlhpQY2N10/hZ1uX7ff8dzuJIubC6YdOoraEZAc+zP2g1JQQIPxouChirtpQEviZc08TA14xzosLTdLe1Cb9fmilw9GoPJneeyA16Qa6EINLOfaCSz5htjIVO0iH9KeLSvDEoBMVFc/1NWRdi/iPkSSmnHbQ3R/dDbna+uwVm4Epvya0f1G3SbOUAYQRjl1XhD8+EKqB1GFW792qi7lD4JWnbxzsmzl0ixcNonfh3Ri8RjuEBzrMlqhxpU39OHuzphwt6911yTXCsuWczKdrBTWF28rQJl9ALEdQDYsmbYqJM/RMxqTOs3//cLr8094lG2YhIF1EL4d
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133857B3CC644E9DD23ED37BCD440@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(136003)(376002)(346002)(366004)(39850400004)(199004)(189003)(23676004)(103116003)(478600001)(26005)(9686003)(76176011)(50466002)(106356001)(3846002)(105586002)(6116002)(14444005)(6506007)(66066001)(53936002)(186003)(33896004)(55016002)(47776003)(68736007)(7696005)(2486003)(52116002)(316002)(39060400002)(61506002)(386003)(230700001)(97736004)(16526019)(8676002)(7416002)(5660300001)(2906002)(81166006)(86362001)(575784001)(8936002)(81156014)(305945005)(7736002)(486006)(58126008)(11346002)(956004)(446003)(25786009)(476003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6NkRYYUowWTByU1h0bkpCcm41Mk42UHFj?=
 =?utf-8?B?bklGWDlKY1lSZlpXRWJNYjZxcDA0dlhEaEd4dlNKRFI1MzR6RmwvWFVkOTdp?=
 =?utf-8?B?SGtxd3pDRWQwWTdvTStiN3h1QkI1Y24vV3lZL1NHdEFZb1FMTW9obW1sY01a?=
 =?utf-8?B?c1Y0MDc3eUZCU2JJeS9hclI3R3BySG5pRXV5L0U3UHd0V1gzMUY0VGl1ckdr?=
 =?utf-8?B?VnlhZlFUbThsamtNaUJ0MnFNUkQ3dWd6c0xrL1lKanJiZlM3clFNZisySVQv?=
 =?utf-8?B?aFdabGpKM29yOWlFN2hTNFIrWkVJS1lpL3BQMU1tVWdLSW5RSjM0UkY2T2RE?=
 =?utf-8?B?dFJYdDNHb2h0MTloVXM3SU4vM21pWFliTzFkZXhvS3R2ODBWaUl0KzdrWGpT?=
 =?utf-8?B?WWgyZUpiVEFuMWRWaU91UC9iK1dhVC9BZVRvR21NZ09OUnExd2xBK0U4U2dt?=
 =?utf-8?B?bmNTMnVSejBoVVdWUXFFek9xdThyWTBDd0UrNHR2YTc1S2ZWZW1xcXhjQVFD?=
 =?utf-8?B?TVBsYklFWmdxLzhvbkgxaFVMcUlPS1ZPWThaVjZPcDFCa1A5VnA0RnBNTmRw?=
 =?utf-8?B?NzNwMVZOZVJOVlliNkswckVhQ200VTFSODlycG5ReUNpalk5S2dETld2ZTlL?=
 =?utf-8?B?OEM3V0JiOG9DNGk4bDN4RGtNTXd1SEViUTU0MjNGNGVicjdUWDl3SU13MjZl?=
 =?utf-8?B?bitRQnNaaXVpQTBJYzNpTWl5Z2VLbkZrYnlhQkhKZURNdEJpOGhJc0JORlds?=
 =?utf-8?B?K1pwTHpkSCtMSFZxUzdOVnVMeHdQTlZ5SThwYVBjc29ZRUhRdklzRjRVNERm?=
 =?utf-8?B?U0pTMkJDNklzVU1veEh1VURaR3NTNUpqdVo0dVJ4MVlxbDhJditIcFRnRVIy?=
 =?utf-8?B?OVNYbElQMnQwK0NjMDdlSjV4N0NjZ3JoVVVkQjhOcE1SRjZ1bFQzZzZ4ZFVj?=
 =?utf-8?B?aG9NbVh6TllkemtuVGg2Rkx2MlFVUnNpYjZucXlPZVMxaGtIa1hlOGhNR2lJ?=
 =?utf-8?B?L1FHOTBMUU9aL0svQ1F1cGFiQTArbUpDVUJyMVNRY01jUlZtZ3p5aXduNFg2?=
 =?utf-8?B?cEw5TmlhWGFGcDZobUt3REY3SEpmazU1VG1IUHBycDh1T2YxeVhzcS8yelMr?=
 =?utf-8?B?QVZmT1QrMEc1cks5SFIranFLTzVUenhlZXp0am1YY3VoQVF1TWJWVlVGNWNH?=
 =?utf-8?B?UDFtSlZmSExhMHBvc2dSdmM0T093U0hlNDRkRnhJYnhrZG53dUV3bXJwSDcw?=
 =?utf-8?B?ZStDQzZrc3dGOEN1aEJ2WVA4dk9xaXd3TlMzK2NkempGYXB5WnhTMzVNUUxL?=
 =?utf-8?B?bVBNdDVyQ01ZYS9HTEZSYUJxY3hSK2htdjhja0QyNmdVNEVQYXA0M1BpWVRi?=
 =?utf-8?B?MjBnYm85bEplejhSZG85cm9VMEx4c0JDYU8vU0ZuYUtONWJGQ1V5ZDFiVURw?=
 =?utf-8?B?WFQ0WGtyamtBOTc2ZXdJc1E4ek0vZVN1NmtYZkRKTEIzVzNub01ZQUh1UVZo?=
 =?utf-8?B?OGt4Uk8vL2JhN296OUh1YlM1RGxaV2x1Y24rQjMzRkh6U0YzUkJpL1EyNVlO?=
 =?utf-8?B?bXFQQXFXWWtNRWs0bUMwdkJoVlpaZlJVb3JQZ2Ftek5DcUMvenJVQmtwd25N?=
 =?utf-8?B?aFBtZmJXcFJjbXJkd21NUjBTdmlIQ1VqbGEzTWJhc0FVZzJmeUhDMHV2VDlV?=
 =?utf-8?B?RzF3dTNVZ0VqM1MvaDRvR3J0V3F0TXM4cmFpZ3NJUFdPRXIrQ2xnYlY2M3p6?=
 =?utf-8?B?eUFCRjBjQkU1aTdtc0h4aERRPT0=?=
X-Microsoft-Antispam-Message-Info: JirrKwOcfv9+68iizg5j8WPSn0/X1W4KPpPkDxdy3x/7CtgmDchf6pmZZ6MwDZ7m5lrC8yDyZqpLnssIevq3WdtyU+va9bdoU0Gny32ZMyf0YB+dRI9p7/3c1/Ol08DJ3hRAFczl93TxhGQ33zrHel/VdQPxjfVJuTXRD1usA6g2u5m3cHickeOZB+mopVm3vuDirDKdSu+KzLC7MOCDOO75i6m/Haplgbf8AM1KNCfjmKXB4mpikyTWsNdynRBCPrR29MHvZCRX0/hMCFSmBotIX/1blFQxZ9bJsvd87Kk5grS/2JuNHZ2/MEhSIbOqwdJWA7HMpo3KGuBSIkWEYWj2QfFYxyMbm24X0s2wYsc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:ymr/crLqS05JXDELNNAP+xFjV8IkVyEFI+iOgLycRr5fSElY/bgGaf4yeY1d7fcAWNz5HVsAk3IeZJaMvYpxz2+8KMjtBpmaGOI+EfF0zRhl+1peewX9LZzbQ7ivX34CY/9oQ9Sh4Z7/vqOb4IjnsOUllpKzL+r9zOpTJ6HIMElF+F9FJoQlS2rQ4fnoXo60grEGD2c/UaANHB96ZOM9y8kYePGyL6xwBGSazm6RgMyp/MeA312skg5ngNKbbaFoffDz08nwIOtFa916dbzw4DW/6AB1x2kjZLx1Wgl14KTbY7TQe/GlWxEOcE5siReiZ4gWhy+Pi9b13eH52kbCjqsbLDBUk4/xtTCUjzcKIdN2RshVT/pHMbKSwMickQcsgRuxlnrmmOaSYRTnMNHzpakb9h/DYFFZlOja0G4LWN6VqxhfiVCV8axnhtOBLj3G7Fq79m0rEw0vqbjvcWWIeA==;5:uxNel3WYqSMzdjTMi49ffoKAyvd613X8iGPquARAtzNv5DVeDNaO6Qxd8FfhwHxHydGz/FwZ59XYfl76KmarxCL+gSd5HIJ24Qh0vRPHxK/SwSe/gDkYCxO9Io8paydI/rmQzfGpA+yh6wosivhqL0XLaaci815DryQp+txSewM=;24:LH/x1Wt0h0rqJzy4Of995j3Xn47fjwU8oNcRYj9VUct6V6Li3EQcwHjCiyU7CtBMncEan333txG5Su9xSprgZw6D8rupGwnJS0ZlhceEPRY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:9yqkxzie561KIcnqzl1RRStX7UTZYQGe8r3zb81GFSQ+ZLWro1K6/1Rkx4WMhhFRiDB2ZpXT6OKrZnk7k0zfTUrmq9LRUqvmOqjbJYVQy6ZQBL7sAxv4XNbP3ZUU3vi7AIStXsyv0nvix7giUqgC5OIWLQ+GnMqMRQS1PcDJ0oorn9x09uv51FTbGeVOJSqxzbNsqvGRc1NUS6fN7hivxmL9o1mU6fFRb9YFy9lwATVjmpueeHBEf4BNZOmHI2gN;20:yX8DjnoGzWVwnYxALjgVKqV1fP8h2kTdOCE15VQqkU5KuOtBZ5kqtx85iA0mj5JmZ4wDCROKgOVDQ+8iogC3XpcofMBdvjlDeo41VXyKCwZCn74W9DQAfevFJJy2bQmcTMYJYbsCkskovUb1aPi2b23FLIMeVtIy+YpTeFZS+Xg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:39:37.5981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ec5293-31a2-406d-3d65-08d5e577829c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce set_shrinker_bit() function to set shrinker-related
bit in memcg shrinker bitmap, and set the bit after the first
item is added and in case of reparenting destroyed memcg's items.

This will allow next patch to make shrinkers be called only,
in case of they have charged objects at the moment, and
to improve shrink_slab() performance.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |    4 ++++
 mm/list_lru.c              |   22 ++++++++++++++++++++--
 mm/memcontrol.c            |   13 +++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e931cb4a7bb9..1da0c3c57a83 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1249,6 +1249,8 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 
 extern int memcg_expand_shrinker_maps(int new_id);
 
+extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+				   int nid, int shrinker_id);
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
@@ -1271,6 +1273,8 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int nid, int shrinker_id) { }
 #endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/list_lru.c b/mm/list_lru.c
index c6131925ec76..c9bdde9c03d1 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -30,6 +30,11 @@ static void list_lru_unregister(struct list_lru *lru)
 	mutex_unlock(&list_lrus_mutex);
 }
 
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return lru->shrinker_id;
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	/*
@@ -93,6 +98,11 @@ static void list_lru_unregister(struct list_lru *lru)
 {
 }
 
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return -1;
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	return false;
@@ -118,13 +128,17 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
+	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(nlru, item, &memcg);
 		list_add_tail(item, &l->list);
-		l->nr_items++;
+		/* Set shrinker bit if the first element was added */
+		if (!l->nr_items++)
+			memcg_set_shrinker_bit(memcg, nid,
+					       lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -507,6 +521,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -518,7 +533,10 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
+	set = (!dst->nr_items && src->nr_items);
 	dst->nr_items += src->nr_items;
+	if (set)
+		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 	src->nr_items = 0;
 
 	spin_unlock_irq(&nlru->lock);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5a39fada3562..70881f04775d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -422,6 +422,19 @@ int memcg_expand_shrinker_maps(int new_id)
 	mutex_unlock(&memcg_shrinker_map_mutex);
 	return ret;
 }
+
+void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
+{
+	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
+		struct memcg_shrinker_map *map;
+
+		rcu_read_lock();
+		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		set_bit(shrinker_id, map->map);
+		rcu_read_unlock();
+	}
+}
+
 #else /* CONFIG_MEMCG_KMEM */
 static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 {

