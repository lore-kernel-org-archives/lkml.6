Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7238FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CB3208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IYV010+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CB3208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935964AbeFRJjo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:39:44 -0400
Received: from mail-eopbgr40133.outbound.protection.outlook.com ([40.107.4.133]:31968
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935810AbeFRJjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/0BUjG/rEHgg8vicfH8dNeGsbwEHebcZtbPNm1Xr1o=;
 b=IYV010+pgz+muo2ltbO9HGXKg2WbIkatYMjCghkqdjFbYGsK8DLvrrUzuWaAL3kfGuyj22ChS5dKH2wec7EEbDMclYTczkA+HKJLvGocG4bDcYP3HdGg+Yur+p8410PIJxkKB+leuzmyCZe/dxJbFD8V31pydn+dO0UJCj5H8z4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 09:39:34 +0000
Subject: [PATCH v7 REBASED 00/17] Improve shrink_slab() scalability (old
 complexity was O(n^2), new is O(n))
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
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:39:32 +0300
Message-ID: <152931465724.27697.12828290733260370115.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::47) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16ff2fb5-6443-4eb5-86bd-08d5d4ff6720
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:MAzCLHd+ncJF22ggah0CaTPHSUN3KXyTqEKMyWTIR7lRVGsGtqeEJX0PXUdzbRygbt82zal14zbWr9Y6i/12E62ZdarH25KRtms5xvzOqAunqsCJ00KtXRxzefuMYr66nQHgPoMz6nVUJNEaVl+YsxPr9wZWik4hxbM64HD2L8V/0z6wJsS186XYLKty/NKAUbKp99iFt4Y6cbTjwExLk+lwWR2pzCdbVT6z1rSbCzh72MNQzNrCMHfs6Tf6EiVW;25:2rDRIPiybQzqHqh7076V5ly5eI7xkiLVAKnYHH7e75hnd3mxKdhCu2BfR1zov5D6XpkB0LO3C15L4MVFJeQBFadwSvWwLeLhKKtuVvs5qZkZwBypzeX7eQUfNq8FMifswIhQClUQsSvsbrI9b8VrpEzF6Zr+ZYMEXuyk+91EphK9cxquKj7eOKk6dF78ex4gbZAFgFH9EU6xnIzxUc14dVW/4mDj5maZBJmj7YP8i8FAAnuNwY+WFTvj96oWrB4WF00ukg4ksGrOtCfZFDopJMka1g3Fp3pKjq9qT2ygsfRADN1EP0zPzJnq4kfsqiqUfUAltAtolSeKRDFxWRA13g==;31:WePMlrabwOgWjoNiInoB4hHP+QHm3aaOug2cRybHqLYqRxENxwHV6jBKe1xxRMN0yjU3OKNQFJMpBKjfvRM82sS9EzxLAucU+tLSAXhnOKlpvg0dP01JFtZvMxuvJflfnF7bPuEtA1/7GYYTMg0PQEUdVfO4Xyw4rnEM5l5odUGkpq48rvUVXCzT2BVIja/jdGJzrR9ufh+/yZrJG8Rh/sJWh3DmOmkvjuPblFMRLlo=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:P87l4w3XNZrFZUx8wWmwK4G0L/YmgGee87LniP4s610t0znqV9nM6hJk2g13KR2036/vBBXKlqi1NBwMAOVKzeQZbqr2DlR8TPJdyeJkrAiCIgcE9e4J6QlfBKOc7p2mrwYVkg8RUWkbuHBU9SSYxZOktD1CisRdI4KI1Shb8Mwr3PJ6IUALNY81FUW4c+R9CZkQ0mMpeQK0fMLZRnh2iNBidKjYkBP0BHGlAeOLBz+tKul+pV2eLfKv69mZ4Ejswi0gSheT8FkGaQX84gH22PFk6qvPITxY+JVHthaE+6LnTM29fMLMxxw6EvI1nSM2OrHqaIGrH6bqzy6rQXHRAZ4/9+WYw13rPfyJQhSRqiZqZcxhHIsjYrdvRMu9w/LVHMjVucfwfp+YW4eE+I87o/TWVDR43no0fhHv71TtY3xC2ho707tFbItk69VpJ7YsWGDG6McmhfPbwC6nWJg4/ckf2+dj9Cf9I/Zi2/fvSg+/6DGM+7yr72X6wrMFvJrl;4:Ecu74CG5Nn2yCqhFBCR03T+EBAM+pC0ozizNUTE1tnhbfe93IzuSXjgK3T6C4tCwr6v+2IbdzpfqKOL5cDa1hPVWuiF9MQzZxPGh1fH4UDuEcz+EMAiCMqPN1UISPvBSs264A4NZSje9cOHI9QKPQGtjJ752q3UX+NPhbPfOHmZBkaAfsBkZJcho1pYWF8sfNVT9dEm0oXR8ZXn1HbOtgsSIowoCywUIduSuGBhYSCahSEe28h7aosxTugskR+K0Sc+ds/pyUPsrQ0t1J0X2XY59CY6C82iK/QKh+ulG2S0Tpt7sRN7TACbr3CfMUt9BmGsOvb04lygt8m6IfD25/rC2N71g8GR5cbnCL2oJ8A3BI+F3zh1UO2vmuS1jwiA+vxWPxERpcc84qUpFRvmpgy21ghy2S0stkY3OyUH7RP4=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1331AAE1AC83B495C8855C6CCD710@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39380400002)(376002)(39840400004)(396003)(346002)(199004)(189003)(2486003)(23676004)(7696005)(66066001)(7416002)(47776003)(52116002)(68736007)(97736004)(33896004)(59450400001)(6636002)(7736002)(305945005)(61506002)(105586002)(316002)(86362001)(55016002)(5660300001)(58126008)(50466002)(81166006)(39060400002)(956004)(476003)(6116002)(6506007)(386003)(3846002)(16526019)(53936002)(186003)(230700001)(486006)(55236004)(8676002)(8936002)(81156014)(103116003)(2906002)(9686003)(26005)(25786009)(478600001)(106356001)(81973001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6emo3Z1hHQmJEdStxWmpHR3dlRmttdUlt?=
 =?utf-8?B?eHNpbUowZU8vczFCM3RnSlBWS2M3M2pQZkhWdVFRUmJWNVZqR0doV2ZZSmZv?=
 =?utf-8?B?UjBxRXpvS0hsTjAyWlZJa3B0VFQwbWIxQjVVSlAxeW1nWGJoeCtndytXYWhh?=
 =?utf-8?B?ZzhQWnljTTFTY1lPK0JrQmQ2NzZSVmR2ZHVKZkdQcG9KaWVITkNoeG1rNUp0?=
 =?utf-8?B?ZHlDU2o2ZkVZRmRDUVg3M2c1SFIxMXhxVXFNWnIzWnJpbTNKdVVrd0o3cmF4?=
 =?utf-8?B?cVV6bXNEeDdIMHpqaTFERU50NzNGM2x4Vm1ic0JYVU1oNGc2d1Q1VHJRRzJI?=
 =?utf-8?B?RTVjaWdLNkt0MCtQTFpQY0V1ZzJXYzJYck0xbHhPclAwTXZEZVBKR2VZOXov?=
 =?utf-8?B?aGd4U1dtQ203RjdMQnNUVENyZzljSmV2ckJwU0g2QWd3U056RS93NDdzTmtl?=
 =?utf-8?B?ck9KZmw4ODdTbjJhZmVXTjlobW9YTHlzemcyTXNrVGpJc1laQmt3Sm5KUlZF?=
 =?utf-8?B?UGNFOXZGWS8ybjJYOGRnbkZ1cFJ5OXAvRWpaaXVraDBhR3FCRGxnbDhqcTlX?=
 =?utf-8?B?OTFHRTRuZUh2SkNIWXhyeStzUXQ2a2tacEpRYVBPWVQ3R1I3dTgwRlFYOW4v?=
 =?utf-8?B?d1RDZmFpTW1sQ1VxQ1JwcmMrK3pnQXNMOWR4ZmJ0ZWpQblV4TmJobXFWcUhq?=
 =?utf-8?B?S1BoSzVDUy9vNXU1NHdUeFFtSm1RQmdrTkpjamk3UWV2ODVmOE1iYUY5bUE1?=
 =?utf-8?B?UE1hdDkzcWVzWndXaWdINC9xa21IWmxnMlpPSU1kRFRjNHhQdmYySTV0VDlr?=
 =?utf-8?B?bzdCcmo5QTZrcER5RTVQNXlSZG1DOHFXMDdEaFBvV3dldVVJYXhnUytvUnVs?=
 =?utf-8?B?aE1qOWZTTWVVN0lxek5HOC9nd2s0RXI0QmZpVGxzZTNhYklMU2NTQVpMK0Iw?=
 =?utf-8?B?ZUk0aFZnRHltVGlaUE0rdDFaUHZzR1pTcnJHV1A2TUMzNjhsOUJZZXpTWFE1?=
 =?utf-8?B?MjN1R3l1MUFQZmhZc0JBMEVidUkvNGdEdXI5aU1PV1VzNnZrRzJRcjlJNWVS?=
 =?utf-8?B?VldLTGYvQ2JmYzc3Q3pmQS9NZDBQU1c2NUt3dEdnNTJmeXlPMW8zM0laR3FM?=
 =?utf-8?B?WSt3Q1NOaWkyekkzSWRJSGRvL2xJWlVZWlpQNFJtbTRSSGlkRTNIVGNoeTMr?=
 =?utf-8?B?a3ppSEFRQU90bkNxUEJEc3JJZzhPRFBLWWJENEljbDNVbzV3MVdBb3ZjbG9G?=
 =?utf-8?B?dVlPWVhpdmRRWmZDT1lZNnNVS2V0T1ZXdGw4aUQ2TG50ejF3SUJlVS9OdVc3?=
 =?utf-8?B?cGpNWjNkSmdSTmpTQnNGTlBPWHJnOTRMMXJ0bFdaVXhJa3k4ZlpOQTdFZUxQ?=
 =?utf-8?B?cm9tUDhvN0JEL250cGlvOEdGZUZxL3A0enIvMnNGb245Rjl1OWgyQm9oWSs4?=
 =?utf-8?B?K3RDTWFoZHZNUGcwNHJCVFVNRW9kakZVUlRqUWVBN0o3VDdBbEd1ejdxSU5T?=
 =?utf-8?B?V0dmeExpOFhyeDFQcWptcWYwaTJkQWRPMWdsb3Y3a3pXQTJSNnFaQmdDRHJP?=
 =?utf-8?B?RzhXd0tKcE5vQTduVmhzNU1RZHFZMGt3QWQyRy9NbE1wZmdKdlljODNMMzlz?=
 =?utf-8?B?OENldlBsNERTc3doMmdWU2EwSGNQakZjZFU3RGlURmxEQkNUclcwQXlHdjhl?=
 =?utf-8?B?eHJvM2dWa0pkaElIOWFZTndrUmJzT0FYb21RMG15Nm1TMy9MU3RaV1BGczhN?=
 =?utf-8?B?eG5aWlgwQUFFeEdGc2ZjQjRnPT0=?=
X-Microsoft-Antispam-Message-Info: lMCAABJj9Pb/JblsAT8ZDSaM1klxijALdMlfZkfLqiucztzHipR87tZW071Wgd0gVzsZAxAjxSF0+p1NrkZHcP1eLb3c/40KNqwkjyFuHcDlYmVehqD9K+W8WLuqbImfg0Mr6ppvjAbtf+CMquBIxY80HS/EzMdI2tD59c0ZRx+Gpay16z/aFWdyUNHlsy7o
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:7JtN7Ft+k8esO62YDMOtVnOrW0pEFC149/1QG3lLlNNvhktD8OVaBEoT1Z2g1j22ZmfV/ZrjbryGk+W2abtC2SzMPk80zRlhUMqGYZNQehj2Ei8Fr+xipjkBkIkMdz6T2Yb97sGV5OHj9/XjtUlAzeXsxt8IPe57wwvw/pbLiUwkGTTcaT+6QrAlbdObkcj6UdrcRofqvuRryZXNzdLpcb1eCftDv08SGvR146OhYFogMMqdQ1psLmyyOTC3s9gC9UTbrCeohcC84YoW6hgNwyHqCViwf+LnXbRQ8IRR8LciN9LSPkX4gKZ0YTwlORjP7qZ7QN1eXfhoSBPuSPKQGh36hhkeHoVHCSIcwwOb1n1QX3sDsqFhgegPqrAsfPAb8ExmBNK/GY0ty+5Lvw5T18Ys2pE9crp40CbsopzxF5gT+7NwIHoDMaRtvQqhD0rW4UBVt/a67mGuyEcI3UQWQA==;5:Gu9qMp6LMvoUS9rCMC9ZhydVypYsxThLgiHkLisIUq8VoFl8OQSLOf2pqJG4v6ykNq9O7z382/5u9eWH6+VxCvrfJFrmOFC9WAR23nMmIbCxpBO4aedoGHkYYEvU+zqdqJoPNTc6ob3HOlEX75vX6P6/34er1+8n1eIvCAzlJ0c=;24:A9JPL/9zJW1EcYAUFc7KHt90GAQjfOzB0HM41sZPoxl5aW1vaxWP08e0oC4Hi1GJMcmmJw2XOdR0236GJvMolbAoL4xV5Hr2IhRKfmVGir0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:jw2QEYlwRyaaHpHG6zZCR54iQVsdgBcBIhxo2RcRMMKCkKadVFPEZX5EunRytwF0T4M7EHsT99smz5GdAha6Cdmx6H6aqiDUIJu44Gbn8H3v5rqMNveCAPu33DvXt7+6/tNf0FfjI6hriZ/uIl2DYHCUYUkSNvMRu68d/kDSwsn2LWJly2KYHxcgvbKuDlU3zjUEpJ2pMOaP34tPPqMubtWcAX8cK1Z5/wGg/RUwMtVWZR0xtOPww/RgTPbYBrJj;20:NQ7AXZ3IX46lbhuA0P03Nt0tHmv9YbLN+iJVZ+O87yG6stO8MMANFFTcNDttPt71k7CFIGGrSw3toWbv6s4+5Luj8lqBQeE0ruohQSxqxcoiuFVDGSaIHG7UuDpSvGzkEsdQ1F3eS2TxFX+pptbshViTajLciNijyUP3RzHWdwM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:39:34.2757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ff2fb5-6443-4eb5-86bd-08d5d4ff6720
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patches solves the problem with slow shrink_slab() occuring
on the machines having many shrinkers and memory cgroups (i.e.,
with many containers). The problem is complexity of shrink_slab()
is O(n^2) and it grows too fast with the growth of containers
numbers.

Let we have 200 containers, and every container has 10 mounts
and 10 cgroups. All container tasks are isolated, and they don't
touch foreign containers mounts.

In case of global reclaim, a task has to iterate all over the memcgs
and to call all the memcg-aware shrinkers for all of them. This means,
the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
and since there are 2000 memcgs, the total calls of do_shrink_slab()
are 2000 * 2000 = 4000000.

4 million calls are not a number operations, which can takes 1 cpu cycle.
E.g., super_cache_count() accesses at least two lists, and makes arifmetical
calculations. Even, if there are no charged objects, we do these calculations,
and replaces cpu caches by read memory. I observed nodes spending almost 100%
time in kernel, in case of intensive writing and global reclaim. The writer
consumes pages fast, but it's need to shrink_slab() before the reclaimer
reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
there is no writing, the iterations just waste the time, and slows reclaim down.

Let's see the small test below:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
$for i in `seq 0 4000`;
	do mkdir /sys/fs/cgroup/memory/ct/$i;
	echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
	mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
done

Then, let's see drop caches time (5 sequential calls):
$time echo 3 > /proc/sys/vm/drop_caches

0.00user 13.78system 0:13.78elapsed 99%CPU
0.00user 5.59system 0:05.60elapsed 99%CPU
0.00user 5.48system 0:05.48elapsed 99%CPU
0.00user 8.35system 0:08.35elapsed 99%CPU
0.00user 8.34system 0:08.35elapsed 99%CPU


Last four calls don't actually shrink something. So, the iterations
over slab shrinkers take 5.48 seconds. Not so good for scalability.

The patchset solves the problem by making shrink_slab() of O(n)
complexity. There are following functional actions:

1)Assign id to every registered memcg-aware shrinker.
2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
  and set a shrinker-related bit after the first element
  is added to lru list (also, when removed child memcg
  elements are reparanted).
3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
  and call a shrinker if its bit is set in memcg's shrinker
  bitmap.
  (Also, there is a functionality to clear the bit, after
  last element is shrinked).

This gives signify performance increase. The result after patchset is applied:

$time echo 3 > /proc/sys/vm/drop_caches

0.00user 1.10system 0:01.10elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU

The results show the performance increases at least in 548 times.

So, the patchset makes shrink_slab() of less complexity and improves
the performance in such types of load I pointed. This will give a profit
in case of !global reclaim case, since there also will be less
do_shrink_slab() calls.

v7: Refactorings and readability improvements.
    REBASED on 4.18-rc1

v6: Added missed rcu_dereference() to memcg_set_shrinker_bit().
    Use different functions for allocation and expanding map.
    Use new memcg_shrinker_map_size variable in memcontrol.c.
    Refactorings.

v5: Make the optimizing logic under CONFIG_MEMCG_SHRINKER instead of MEMCG && !SLOB

v4: Do not use memcg mem_cgroup_idr for iteration over mem cgroups

v3: Many changes requested in commentaries to v2:

1)rebase on prealloc_shrinker() code base
2)root_mem_cgroup is made out of memcg maps
3)rwsem replaced with shrinkers_nr_max_mutex
4)changes around assignment of shrinker id to list lru
5)everything renamed

v2: Many changes requested in commentaries to v1:

1)the code mostly moved to mm/memcontrol.c;
2)using IDR instead of array of shrinkers;
3)added a possibility to assign list_lru shrinker id
  at the time of shrinker registering;
4)reorginized locking and renamed functions and variables.

---

Kirill Tkhai (16):
      list_lru: Combine code under the same define
      mm: Introduce CONFIG_MEMCG_KMEM as combination of CONFIG_MEMCG && !CONFIG_SLOB
      mm: Assign id to every memcg-aware shrinker
      memcg: Move up for_each_mem_cgroup{,_tree} defines
      mm: Assign memcg-aware shrinkers bitmap to memcg
      mm: Refactoring in workingset_init()
      fs: Refactoring in alloc_super()
      fs: Propagate shrinker::id to list_lru
      list_lru: Add memcg argument to list_lru_from_kmem()
      list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
      list_lru: Pass lru argument to memcg_drain_list_lru_node()
      mm: Export mem_cgroup_is_root()
      mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
      mm: Iterate only over charged shrinkers during memcg shrink_slab()
      mm: Add SHRINK_EMPTY shrinker methods return value
      mm: Clear shrinker bit if there are no objects related to memcg

Vladimir Davydov (1):
      mm: Generalize shrink_slab() calls in shrink_node()


 fs/super.c                 |   11 ++
 include/linux/list_lru.h   |   18 ++--
 include/linux/memcontrol.h |   46 +++++++++-
 include/linux/sched.h      |    2 
 include/linux/shrinker.h   |   11 ++
 include/linux/slab.h       |    2 
 init/Kconfig               |    5 +
 mm/list_lru.c              |   90 ++++++++++++++-----
 mm/memcontrol.c            |  173 +++++++++++++++++++++++++++++++------
 mm/slab.h                  |    6 +
 mm/slab_common.c           |    8 +-
 mm/vmscan.c                |  204 +++++++++++++++++++++++++++++++++++++++-----
 mm/workingset.c            |   11 ++
 13 files changed, 478 insertions(+), 109 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
