Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB7DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBE5214DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FwenEaP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBE5214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeHBMvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:51:38 -0400
Received: from mail-eopbgr30138.outbound.protection.outlook.com ([40.107.3.138]:47390
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732068AbeHBMvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsa3mc8nIpk1RdGleSi1MytsXSRlVCYosZgTPur4RkU=;
 b=FwenEaP0KgVN7XLZCFfdBmjQ64RXdId3N3htjNbucQcKDF+JPrUYeXHxd+MYmB8D/lAHnTCVzg94a0b5vCHv0hgXE4VmyncmBuFxPRZu8xQR7RuJHxV+6O5Mfd47Nx60/o9NU+AhjoWEgD4kwQNl3uAOG5WeRmrw6z6Bg4G5H4I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB2030.eurprd08.prod.outlook.com (2603:10a6:800:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Thu, 2 Aug
 2018 11:00:54 +0000
Subject: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to do_shrink_slab()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, ktkhai@virtuozzo.com,
        vdavydov.dev@gmail.com, mhocko@suse.com, aryabinin@virtuozzo.com,
        ying.huang@intel.com, penguin-kernel@I-love.SAKURA.ne.jp,
        willy@infradead.org, shakeelb@google.com, jbacik@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Aug 2018 14:00:52 +0300
Message-ID: <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR08CA0069.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::40) To VI1PR0801MB2030.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ee7c690-a0ee-4e67-2deb-08d5f86738a4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2030;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;3:Oo8tZVifQhkPCAgwAOhG15jymaM5cHeuQ0/ostnrXVFaQnTA73+NLokNuQfcMa/WnspjFlmcG+eGTdpK7vIxLeHJA5qcdsaJkgPaZwNIQZBdXoQjJrm/oycUmTAZVUPivo1I1h+Vfmc1Den+WFu+SQ4pD3iAfXVou7BaK+caTmcrFD0kc8420OGnyeLp9EY/nmJA98dqIz+9mSUh526iW1wPB/nhJlvIW/d1fXOPlqFhoLkFZQL/PH6GGEoIShPz;25:hNX8QfFGbzAUILpLXMWqVSjVBzLIY4gyEOqqGaCNTR+Ks4sjMxI075DdhqITABGP9YedSxed2OBsK6DA5SC1EDi0fTOe2Stx5dVjpIkhFfkz/1Cc3Y3BTUBKfar0UrsXajqJ6B5a/Py4+mXb4nLFBvD828qntDBYhl6NjPVVp6mdEB+3xX1+CcRMNEE8m4ow2Vij7dlUV53PCjFphnXo51IFTflTgcX7V2Cz/SQZ8M9wLoTYfp/U/kvVJh2GXYoxyL3mfZqr7bMwY6lPN7EKELq49izJt50W1Ekr2CmbYdm+GnLwmU9IxCmYNntll+vCqVvSHjIGisHecqnqwWgNhg==;31:OehHIcpYHMlqdKdIP05jVgfUFLoGqCK0Bmc6EJ16MQvdlrPzkKSd8RnoBRAMe8Tdom+S6qZJxnIifik4CinqVkAbLGvmqmt+zD/BJFFVuFx0g/uIv3K9hjyEsrS+CS0EHah3vH9qDZX6XKhe8CEvR/11IGDHryXKxDuw1TMM07TbD1RQ06tpdmifpoqm+cpRW7OTWiR6rPnwhGIDbeDiwEXB5IzKJq0KNZHVrWHC3p0=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2030:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;20:niEacxHDlaNlHhKfEOWEFmcRtEo0aT/Oxj+3UCaotCTBg5tBWvbhlZ5cAC4al0duVtHLQ9u/hJz8aPNxabF6MNGHjdh255eYcfgl4aSdw/wXnGIET4XjA2QKEfe8jNFWazkJl4WlqBU9Rrz1IXpYNPdzmpBZDC/85tBy7YEg3HEG2BfvJG0XwTFdzokPcAZjOeDfUiUHBG9urZ3xpmeWjJDUxRDBEcc7A+xBRCPdIB9tcyWHxFsfmBnpKtYHIIOb4ZO3hEWacUzW/d8O+yJGJENx+xWhISmPObC4zeksJlgZQ5kt22sLX5kCfV8yPCsA7kEFIfSwFcTWvPo9r3n4eElbqgqpMNxSsLFKIsdKAhtkn1hVLkmqiRu9huZI/oXioJElzUQ9dQscIFj72LVRJY7AXWgJQGmvj5xrFs+Aetw483VH63FIBZs448yMBrQ9UGiMsnk4kMnE+8cNK0iNublTTHkZLoQCGKCVlbXDoxSuswMs1YNYmSEU3rdLZCMv;4:YVDb/TsN46y0P/QURcHsYR/2XLH47U6kA2Z14ZRJOjgu0LQ+RQoO5FR8ECC3RMnEShy521l1pH7jqPqOmyB8/5U9I915u3HZwCSikaOJOx0TqUQc18QvpznQla5tbna+MfMbXsL0km6t2vdM2vTYtRVp7HwYR02ff8yr0YEN0yqGxxP8GhOU+2NX2yWQ/KRunQNBTsl3jtE02LysPfA6xswNKwlZK5ouKuPhY/wI2hM771E1KodbOxPwk6yKcp4QI8sGQj7F09br3qtrMKN6wg==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2030A0659C0F1465D76ED22ECD2C0@VI1PR0801MB2030.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2030;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2030;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(396003)(376002)(136003)(39850400004)(366004)(189003)(199004)(16526019)(186003)(26005)(6506007)(386003)(66066001)(33896004)(47776003)(5660300001)(55016002)(14444005)(8936002)(81156014)(81166006)(8676002)(305945005)(6116002)(230700001)(3846002)(7736002)(103116003)(50466002)(2486003)(7696005)(23676004)(52116002)(9686003)(97736004)(478600001)(86362001)(575784001)(2906002)(53936002)(1857600001)(316002)(58126008)(106356001)(476003)(105586002)(486006)(25786009)(956004)(68736007)(7416002)(39060400002)(61506002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2030;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzA7MjM6RXcwR1pZMlJyd2F5eHQ5ZEJWc2g2b3Jt?=
 =?utf-8?B?NVA1aU9kNU14M09YUG4rYmo3YldjejVRdlB6UDg0SnZLRzZwdG9mZVpSZEVF?=
 =?utf-8?B?VWRTeEw1aDZ0Wk9welpGaE02bHJ4YUNkM1JaeEZ2SmdiTE0vK0Fickg2YlEv?=
 =?utf-8?B?NXhCZ0NNS2RhYWlHLzRyMVVVQTZTMTFOSmozQ1dOMVdaK1R0bnFlM2x5U3R6?=
 =?utf-8?B?TnJDZDMwajU1UXF4QVV0NHphditjejQ2a3NOL3ZFdHhhWmRtWW5pdkVyU1RK?=
 =?utf-8?B?aVJZdzBUT2JmdGlKcW5LNi9hV2RPTkVQbDhITVN3RGtvN3J3VS9Ic2dDWFBa?=
 =?utf-8?B?NkF5SS9sU2JzdXpxWXA1OU0zOHBReFErT0FleDlFcm5XZzNJSEtXSSs5Tnk3?=
 =?utf-8?B?djl0VC9JNUdqOFF2ei9RSm9OQzhycjIycldtY3JkTDNZV1hzWDllemM1RlFj?=
 =?utf-8?B?UkQrUGVyRnZuN0EraTh0V2VzMmx6NXVoUnpFaTczaURJSTArdEVNRXZuN1da?=
 =?utf-8?B?bWUwVEo5a2dES0RJa0daeERPYUN2M1krQUg5WktLajdXOUM0bldtUmtEbUJp?=
 =?utf-8?B?SUZFWFNqeU1Ja0lsYytiNkpRb1hMODVlSGRjWlRXSm9EamNqdWVsbFZ2ZytU?=
 =?utf-8?B?bkRLT0MwbGJGM0tPc2VBRCtyK2lZM1U0OU5ZMThNSjA4cUhEZVNoM2gydHNu?=
 =?utf-8?B?UG81RzI4bU1tVFM2d1Z5OFVBUGh1UWhFclY2K2NnNHJqTmd1U09aOUJMZk9q?=
 =?utf-8?B?OVJjZUVsVERDOURkaHU0dVRBczg0ODNmSTVhQUlVcElld1VFNVNyYkJIWTJS?=
 =?utf-8?B?MnVOOVgzbng1RUVpNDJIY1BDTHVxVWc2a3QvYzlwM0U0aVIyUGorY2E5dXhS?=
 =?utf-8?B?Sys2dkg2bC9HN3BsS0p3aTc4ZjY5VVBZY29yM2g0dmF0cjhnOVUzekpoQmZ0?=
 =?utf-8?B?OVRhWXlJcVZKWUhlbkxvTUYwaWlsQW1OUW1CejIyaVdSM3RCSk5iQklhRksw?=
 =?utf-8?B?Y3JPNUJVR3REK2NWUEs2UHpOd1A3b2E0dU43cHZRYndvRWIrbGROVGRDMTYv?=
 =?utf-8?B?QnVLNU9zUWVmSDFGcjlqRXhCZmJ4anR6cTVrZldBTHhVb2t2Z0pZempJcng1?=
 =?utf-8?B?RG9TNTNYYWdKZ1AvWDBPQ25SQkRRU3BRalZ0SFRpS3VqTE5NbFFQb0wySDk2?=
 =?utf-8?B?SHN1YUtvTzlTVzJobm5GSzA3MkNwaXk4WFJPZ1hVYko5YXJsaXZWZFoxcDV2?=
 =?utf-8?B?N1E2ek51MTZPdDNQVDZXVWg0RTkrSDFyYlJnVVVRNWgvT3c0dG5sTXRwdEhz?=
 =?utf-8?B?aUF0YlZUODBhUDl5NzQxVkszc1lkK2lYSm4rK3Q2TVNxYVpyczNLbVNVclpU?=
 =?utf-8?B?NEljU0p5WnhneFQ2N3U1UkU4aFJ4bWN0dE5wR0ovMFdOdTRjcTZiTjFLTmdQ?=
 =?utf-8?B?SWJ0OU9DcEFTaS9YQXM4cFY4YWlETEFmTlFteGhCOWM0L3E4TlNLeS9rSGlr?=
 =?utf-8?B?c3BCQWtJcStvSW4xZitnbWJwUG1sMlZXUmR5bmMreGxWUU43bTZTVENWSlF4?=
 =?utf-8?B?Y1lHZm1GVEFPU3hSa0lEbi91K05NSklkOEpSaERpSkJnUDh1UG94ZGlLaS9G?=
 =?utf-8?B?YVp5ZmFnZ0Z3c1NzQ29Sa3ZjY0dCbGVpMVBuVGVLb09HcnRVYmNjamdpamps?=
 =?utf-8?Q?PtoG4jXkg1ayfDoZIfP0z/LSdfwKdJmxaUg+gtq6r?=
X-Microsoft-Antispam-Message-Info: SuNoYCoQgbucHc+5SWoyiiP36764Kh5hKNvAcqb/GJ3UuUdH9GyV5p/acX/btt+N9WHPFTtESueUMsm6tq8FnTFXugZz6n/0d49EL71EPnt10MLkrf/FqdcXtMHHqmcE8//GaCllRkhFsALXzJJc9OloJ6oWfw8z0lYc0FuSZ2jTbS9XibVYT4TUT59UM4Mq9oWE2Qu45+AXziXbTjTgH2RFk1F5oaZUjGoErPMFlyKDmCCBEFkIW4E2/MJg9va4kezwKUuKUpIa3XAW06tAXR+dvkSayjzbNY2GFN8ftSmkeRZ69wep4WEdxQTLlw6mMiXOliIDB9RXtPhBX/6VVYxh9yTeZnM+YqZFXYM2mLk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;6:UHxpUmh3iMpDqjnOH/j0CuNykkJXIs8/h+JHM6t0EzViow7+teSCuTzz/zFPGbfrYWTVASWCVqnGT+zYyHDjwzJ9vOaeeAHjBUuKVtou8Vq9t1HsZmMKo2IxjNLUaezXtncoQK32ydM2iYve4TVZBpBekpzDL8CQdSs4xjhJkGM4a8vP7kMOcitKzp4KQ8zVfkCGa7zEDX1j/Zzfa+oaq2kU3ALFnSYnEv9JRIC7DT+vdT0rzPK64Tn15vPG0KNQ4G9274Q1Ur6zXpXZpkBFbWLrGhpEdmP9Ys5WfJ2ul4taTSH8JgWXAmaieBgRY/CQK4hCCylyDAfQbo1Bn7AJZPLrveYbiKoPdpxGsD7+LfSaWf8wPGysSTvijANi8d9smQN05lGOrdDlbKA110tihK7D4+ceWfUxOq2hItFnGNh/paZrjYHSGRwM2qQx6M/yr4VJ5VNz0RfeE6l4rvacFg==;5:RxVkV+MzztzThhq8oT/Juumt65eRqFS9AhXzNI2gDP/xVHAB3+6/6rrPo9NupJyRo9xO+uADHCA7UnIe52BRx+Zaf9ddb+90bjPhUrDq1UzG6nysmiuGOuYG3dCpRORzzQPHcpYUxKYv2+pvGlpnXkecC6XHC+A/B2jZhMCpjvw=;7:4iHJGOKo6Ug4BSACQQzJ2dl0afhAVbnUmlqTnoB63U3RW8JHvUMy6oCviHoyYxN8IwbjQN0tBgkGJBvAkbyc4KTyuaCZOJxx60v98oSRYvGgevbgZwa9KpU+vh/gXo0g6GKB4MznAwInEs5UjRXBDWUol2sFLVZ2iDLXdJOTBTLIOzeKusTZLQI6bXgr4mMN56zgCXcL2cxsOV4Swc1aA4SjvcVoLdPhGIPPlraFkF+E4og0L17SayOvb7u4ZAgV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;20:GIGkPbJaw3gL5ivqw7jVBy+666POEiuhsATdR3Rk0pVapdRV3Y4GkEniF1Y9voJXPyNS3BLwJuvX1Sunoq3jwPIZuPWjzRYUPLg9y+BMgLruOo7Kc197+Nxzwsd+++Y2FPT6n8Yg/qBjmZ0vusjG/P0fw0Az/I2vGAeEbBlr7uM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 11:00:54.6197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee7c690-a0ee-4e67-2deb-08d5f86738a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of shrink_slab_memcg() we do not zero nid, when shrinker
is not numa-aware. This is not a real problem, since currently
all memcg-aware shrinkers are numa-aware too (we have two:
super_block shrinker and workingset shrinker), but something may
change in the future.

(Andrew, this may be merged to mm-iterate-only-over-charged-shrinkers-during-memcg-shrink_slab)

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ea0a46166e8e..0d980e801b8a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -455,6 +455,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 					  : SHRINK_BATCH;
 	long scanned = 0, next_deferred;
 
+	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+		nid = 0;
+
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
 	if (freeable == 0 || freeable == SHRINK_EMPTY)
 		return freeable;
@@ -680,9 +683,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
-			sc.nid = 0;
-
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY)
 			ret = 0;

