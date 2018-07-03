Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D4CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B7B21A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aEV+JvWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B7B21A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeGCPJU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:09:20 -0400
Received: from mail-ve1eur01on0103.outbound.protection.outlook.com ([104.47.1.103]:6673
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932648AbeGCPJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6twuSk8r54M+02pUaRUjI0X54DIwFiSuG+9u4VtMQs4=;
 b=aEV+JvWFtdFMUSD1pfPdbsphtEyJlQiS+UzSO14TzG7wbCd/PdbNOlhV5Bj3zhb7dEdWZy9wIz8SQfdYr0jYLetyd5fEm3fY+C+5srbIYjqtyZH6PCw2ntQkafdE33262GmM6zrRg/whyAF6SWTpWfMAfcgSEFNKjIPOH/N+7Nc=
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB1340.eurprd08.prod.outlook.com (2603:10a6:3:3a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 15:09:09 +0000
Subject: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
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
Date:   Tue, 03 Jul 2018 18:09:05 +0300
Message-ID: <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0701CA0066.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::34) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaa1c4bf-fc40-40a5-b486-08d5e0f6ee9b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:kbHC/V07Hj218VMtq0+TEjRA2ecWAmoR/iRbu5IjwqzG/9gMK2bMmd6GnP+naaLQxpnaiz8t2WtPUrIg31N3fjmLg/uSgnVvyMOMwid8wKDo1klxQhPVUhuc8fYYp97yPVZI4uGBJV09II1BWjoRZvW9Uz5mHfJoE31IJdIs5vzEhfSn3L0BzEQZfthZqdyFR8R+TJwUKpyuJl3+91LmeWigaRuYMdLecmppNKawp6K8KYZAmUA0X/l9sCRTkmDa;25:Nhf9fvYbI3YTIDNt01zRa62SiUsvb8ocfF9ElCFwPGctR9Epo2cg1Qhy07rDT635pOaubMJLBlEkDF+1Ey5vwZfAYZn/xrFMTgqx1phg4CEJbWxzQ6E3OGqZM046i+AeE1E/Dt7yok65fOrp8+cpsTk13Jrcz7TtL9Uclq+eHSNg0DYKf6Bsiugmf59J4vmJyXyDsKvPgVGgQiSvIF8eTZ642sIjq1e+YFxvlG5201/OgBuvxL8kzUV4ACTuHaXkJLO2qoKCoOHjz+2WscDwZcaGk2C2BihcspfPWn4MFqKJdTsP5x6o/dkjGOJH3nEnB+FYPkubUfSWa4ae7mRRvw==;31:pR7n35X77UzpBPYJSrPjANsfj5YQ7z93eHKGv41A+xh4pjuwKBs1g1Mjq4c2HV2Tq4vZFxfkjPKqAG7AXyf6C+ck6/dAIaEYSphg4MAe406neEnYM4hNEKXh78oq/S4QRGYOkhhPqOjR/R/91pWK5ezf2T+DbQwMpCJl6pj+ZPtt2db6HVd/PKgFucRa7LSPwClhxBgBBgMsV+ruCGtxzugkicq2JUQpM1dvNokrPZI=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:zVvTilWeO+GYWwbRPx4FVE7SD/0ETfr8uh6/Lvvecfts0oWeShvJwyT/a7aiHxRtHJiGyKsuv9shtmPTMuKT+rTtAFMy50te26w39h39WJwy/+f2AMfa1Xjp4EHUEXsxO5GyFRqAjWEyw9OZ69cBQC+4sPEmEXRdiX5j6OdBqBtZaLfX0R9TxledjVsVvSwAO1eMdZZtvVJ3VUA2HrlfCcYTc7We1rl1i3os3HJ7HnY11d/3sio1usaubGW2fPptuJsjovXr1Pzj4i8wWdyQlgK0FUQu5KRlMfS9k/oN1lhzGEUwD3/unJTLbYbmhDViN+1srgKg1qOyBGw1YzU00i97ExMrPH5f0ntwv7d3IIJEG1+o0OqPNOFSGTAKGKeOYK1o9T0LKJd8vPPP87S9C022WYgtWHEuDMGFFRNYlSyICuGHBuDEdlDhiu7xxTwM7bnEsZsyNo0MfdLGDpAigK/C04JX9I06WM99hrynDG0RCuHF/H9fSZtO1sEjMPAf;4:krJTLUkOOgX5kSjTIYIKFkXzvM69g/oguGaSLkaHRUImJGfBqWl1T6A6OE4SYjnSAnkKAwkUnH0gPMsbPROklr9F8cF5bqRqpwL874tQTwAGi/TpdpkDXK/y3fZVryDDHuuI/98H2STsT5R5J84i71YGJdtdeJeBC/XAzF1KRjoXr8IfWYiZs7tipxAKtMqzAG9fguTJF2Lvdv16cYdIrQbXYeRY0aZVqRL4WOiBYRhflrh+t15P85laweJq1vw7ZH4jq2WDYiwKr8voyr5pvER0TCM5UI+hhB77OKw8/RgEjv9o5pS37U9W2XHkgZJL2EQjusl5DWlElp+qCRY3gSFMM5zwG4AZaDMpxiglapvxvPtCt+V3x1DRnC4Hr3uk
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1340E8CA18F926BDC9CC90A9CD420@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(103116003)(6506007)(50466002)(956004)(5660300001)(486006)(105586002)(61506002)(14444005)(11346002)(3846002)(6116002)(53936002)(68736007)(55016002)(26005)(9686003)(476003)(386003)(7416002)(16526019)(446003)(7736002)(2486003)(58126008)(52116002)(316002)(23676004)(25786009)(97736004)(81156014)(8676002)(81166006)(186003)(2906002)(106356001)(76176011)(66066001)(47776003)(6666003)(230700001)(33896004)(8936002)(7696005)(39060400002)(478600001)(86362001)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6RDZrV1ZiWnhDOHdwaUdZQXBaeFd0dGll?=
 =?utf-8?B?SE5sVUtrRnBweFc3c01OKzdwN1FpVjhvYTJxY0VWOFVOcVZlYm01VlljWGhV?=
 =?utf-8?B?eXEvUWpiMmxRZG55YmxrcDNMcHdLL0c3aG5TS3FGM1grSHluKzZPbTVIeFJr?=
 =?utf-8?B?WjNCTWxBcWo0UnNYWXkvSksrMHUwNktTbzNCRi8zNlZ6UnhsdERMTzc0ZE9G?=
 =?utf-8?B?enhDYlZ0VThqVHFDNEo4dlMwQS9FOVU1TXNSOEd2UmJIbjh3TU1ud0VoZVVQ?=
 =?utf-8?B?UWFXUFVScFBEdFMxWmhYeUhNOHRVRGtUZyswM0o3MVhjcVREQlhNUE5sNjA0?=
 =?utf-8?B?SWhTblpnQ25hZy9vVG0wS28xSUd0d3BKZU9nTDBTOGR2bGYwVEZoMnZPWjNz?=
 =?utf-8?B?NnN4NXJkVmhjMjZ1ZVl5UjF3ZStkMWxQREdYM2ErTFhSVXVEWEozOEVwdytr?=
 =?utf-8?B?R096eERjaTg1TnNiUkxpTUxWRUhCb3dRclBHN25EN1B5RXZSL3BkbWRhZk5V?=
 =?utf-8?B?c1dCdXFqd0tMTkN1TnRZZmRTOTNjcG5iU0FUa1JFRmdZTWFreVNMM0o1NStQ?=
 =?utf-8?B?Ym1mZndYakYxNnBFTHpFNCtVeVNoMTM3enBIYllqSWhqU05rTkxvcUJTOHZ4?=
 =?utf-8?B?U3pjVS9MOGZ1bVR5aFFDR25NY3JuU0FJVTNaWS9YcTJJdmVhanFjVTZlaElO?=
 =?utf-8?B?T3VFRWF2TU5rWkxzcHB4ZzNQYmFMTkFmQXpaWHFVckVXR3M2SnpISHdrMzFN?=
 =?utf-8?B?b0ZxaEVXS1lxdmhESFlKdmd5RW1LdFpBSlUwSC9JMXNQckNDcTlXam1kL0JN?=
 =?utf-8?B?Yk5ZZVRKL1prVEszUFNBQ2lzc1QvWkhtRWhBWlFLWmw4Z01wcnArTUYxVnlh?=
 =?utf-8?B?YVVpZUs4UWJheldlVjcwWlJVTm9ITW8rRjBEV3V2K1djcVFZQ1QrcUc5R0g3?=
 =?utf-8?B?a2ZOMkd0cGg0SXBKQXZNMDA1MEJUdExDU0VRUno1Q1NIVXVZN2lQbUJLRGd0?=
 =?utf-8?B?UkNteFRVelh2WUdldDFLL00vNEphOFFDempsUlppRTAwZzE4RlRkRWtFckt4?=
 =?utf-8?B?aXNla2xpNVZOQmtvMlhYc3BDWHIzQk1WSjNTdVpJcHlvM254WEJTQ2NTcExY?=
 =?utf-8?B?dXB3R3dYTkNldnRWb1l2YmZQdStWQWlMdTV3RU1KVWVzbTJrSUZzYzlqU2xZ?=
 =?utf-8?B?S0FTVEMvNHczeHp2QXFKOURaaTkybXUwVm5FRnRzWC9UMlhxRXVwdENNVVYy?=
 =?utf-8?B?YUxTcS9lWGp4WUVxKytudTBmai8wcVVBTUc3aFJoK29xc1oyUWhjc0ljV0Np?=
 =?utf-8?B?T2FvaituSldyaGg4Mm1RZW83QnZWZ3VkTFo3aUxUR0pNbGFUaHd2WmdWeW41?=
 =?utf-8?B?TmtqNTZkYkYzck9SaU9Mb1RiKytJa0l4U205ejVURi9Qa0s1cFlSNEd5bmxQ?=
 =?utf-8?B?bEMzMXNEU2ZhNWNteVFadlVHZzRWeE5aSTlUaHZBWU9jdUNkUGd0akJKZk9O?=
 =?utf-8?B?Q2FtUEFCMFFNa3lncWk4b3psS3lYTjVDeit2SVpaUTJzaWE0SjRhUkhDMmhY?=
 =?utf-8?B?SUZZbzZCWnlleUxZSVdRUG1sZHc1bytNR2w4ZkhTRXRuRmRvVDRXeWh1Z0Vv?=
 =?utf-8?B?NlNIUURIOHZ5bXNzUXFCcHY2QlFSTHpmMzJhZTZHb0s4dTNBQ1BLRWVuVU5I?=
 =?utf-8?B?c3IzSUlEUXZDSm5NaWtDdHh0aXlCLzRBdmd5d1hlVFhncGZDUlRvRnVFdGwz?=
 =?utf-8?B?RVVOeWZFNjhYajJXMnozRnhnPT0=?=
X-Microsoft-Antispam-Message-Info: r4XwHq+TdRW6hA6PCj8C4K5hCviPGtRufCZaxH62iZQ6hzfg1G6jga2TSL/my7d2Fj9OdMz1wNGu8pSdGwLXpLCKMUtM1OqcyLzsV7OPH1+fTmfMR8XerGMRVWlBBBBX2N9TJ+6/E2oIsXZiJOHZqmM3YYhpXv8/63CAAGm4YHrYSX7KFVYt7/Ph5271WdGoQNwNTDldQ5ONtboKId6UcvNP4hEK/OVVEvdGm40ugHxt74SA190OKNk9bKTIDKPMblH7tU1hUrDYYpFRDO3Yb/jux2dIKr+MaFRcoylqspyQusfpkiBRH4x4ylWe07TNM0M39Gt1lVDdyiL08Cb2DyCxNG+fQ5zyBRPa2josxP0=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:gNsZiP1Yi0sDtxd26p+8uJKsgJo8K7fYcrpgMGvSunJAr1bnwRpapsEpOCINzDKosY/gBfjH4vk4KJdhiSOsbygAYqoeWJ06pqUkH7Prd2R7SBD1YnLG6QeV/kcG3Dgw2dXRxxue2CBjDKT1QyrUpo330nRih4L7b1t4LYBSLSIXPyrx3jviiaOcPM0F6gCGyENPuokvxoJmyXXiXSl36qspCI+AKxAJPML01KzicQ58GES1RDhq2+vs8Jvj7BXcVejhBDjSPzB/oRONgXoFL2QS5Lga9hTdGEjDLK8aEGqsPmoNvgfJx2rFb87uaAobVxMYcYqoHv+JlGdYJ+pAJ5FkHyW+jwm6R8hQMzfjtzwhB4arCZeaAZqoS1RVf5TOGMrx7/mjPlYul8ts8xhnjIB9QwVwzz788gLYJAHvSRM/BUjzts5CKpuRkmHilTJQ4JdwkUnbI9EmYgggBQekSQ==;5:doJp25AU/7ytveZwk8PDZETzwEwnTnrhjsMlUa2UMzBiMBWOHtGuNOQNOazqMVQd8jywUp7wzipxU9ZgCvlRWh30SEBysH8UcoR6RvfjORF/l9pmNCc2p9T5pHDytfsy35FyDv4WsArvg0gSga10mIanEl8oZJO4u7nKZa9Akwg=;24:yBylMoWJSDgRWtDXOdQ6Mqyhg+Q6CTPyS+SK6koiGjmxMsz/+cwXlxDcySXUwtUmyuO1e+kzCVIdwrAmFACFAj03ap50Wxw0UFzDFVJUwqY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:qaGKmnYarOR/wokuwVWYyo8wz2in6sVFR2HoIn67OWhNGMzE7BRgeVsfFX1nWUnP8OzkjzIEnTaXHK51K5Va2Ont52GrDG/OhXgvTpvk+08nHVrbvPBR1XdWjcidqJfJpVoGoFMa5xvhANGHyFBpEnKnwPx0W/Um+Y01s44Ly5vAAKGOBHo5aiLBnZowkeUNBzJT9LN0OFeQdF9KjGNGE6HEB2TVMIiOIImHAdeMiIhhUjh95Sv+Yzjb9xc+8/jH;20:sMt5z3Cx3zIn70wsBIOg2njWA06h9Z/TELM9JuUXeQL4IGgfSMrPX7TrqdYpr/M0FD4JXgTwHKO/JNOQgEgrDGyJXnVScitkK5hVna/MZ/yPsvO/Djp9nTHuhSa/ij5dSn6xc8SwAY/lysi3fSuF/mc5T3QvjTigqTXKTKlUtcc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:09:09.8300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa1c4bf-fc40-40a5-b486-08d5e0f6ee9b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
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
 mm/vmscan.c              |   62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

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
index 8d2ffae4db28..f9ca6b57d72f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -169,6 +169,49 @@ unsigned long vm_total_pages;
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
@@ -313,13 +356,30 @@ int prealloc_shrinker(struct shrinker *shrinker)
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
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 }
 
 void register_shrinker_prepared(struct shrinker *shrinker)
@@ -347,6 +407,8 @@ void unregister_shrinker(struct shrinker *shrinker)
 {
 	if (!shrinker->nr_deferred)
 		return;
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);

