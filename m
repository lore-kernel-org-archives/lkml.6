Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFDEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76693208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AA8Qmpit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76693208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755247AbeFRJpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:45:02 -0400
Received: from mail-db5eur01on0108.outbound.protection.outlook.com ([104.47.2.108]:56672
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755056AbeFRJo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/0BUjG/rEHgg8vicfH8dNeGsbwEHebcZtbPNm1Xr1o=;
 b=AA8Qmpit1PWliugxQyuMOuoPz7gAKgSTE77+r4ip5SsrxuGLQhusHAW3H6Qoxw+N7YGDVveiaSh7mrfqaWKxQnbz78gp38YwqXSGsLu9O7RZokYl8qfXQKik0E8+35SY0QEKUX8Q6p8reUdX2oR6fhaQmbvRuaDeo1qu+JkoyAg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Mon, 18 Jun 2018 09:44:49 +0000
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
Date:   Mon, 18 Jun 2018 12:44:44 +0300
Message-ID: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::22) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a6cdb58-c39e-4d86-4e5c-08d5d500229d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:Q5Oc9/80+lebDL1claXAgV7NjbX41aQg9Y3NjFwKvH5BZIsOneZDLj7l8xjvV6KHxVJSCE4pFwPqGIkU9/SAaF8eNhzj0D/EsKyA6LA98Vomis1OhgfIuJdui9GtswPWgrpoLTqKM9+1nqL2YHvsb08iWgzqs6SIRmozYYayC9AeGnimCa97ci2FS1xpGgEpRRy4v0+Wa8StHxV1MiOepK8gACejDYZkEugsJ7/2iwxRKvjGMVz6RUGgzpZHctUZ;25:HDZ85bDGS+hdd4APEuwcGL/rrdHj6iyR2XX4nXJgVHzgppx7sRnPan4RG+JfSBAuPFl2fngdffspszLDEATynzGu5CdNmGUhtstMAJZIr7iZiE//2of5W9jL1fm0OiE5JIWDKvZTb/meLsL52i3uYCiAxFKExtYE2urusmq5X42YAOqDUlbpqEdH+TSIzPWUDkOiwaF8vY91o+G0yOa3F7RC3wCIVjsFAtcrY05Oohm0O0jOEpdXm4Qd/PXgsL2dyK0jzCrTS7yeIAWH73vSfEYBzrFz2ckS/p98h9MlWQxfj1+FaGm9KO1whzNz3sHal1ZR7Y7IlpnH+41aBwSwXw==;31:jW7fKhGwMbxEQkR7OIww2DNzmgI50WdHEQaIKzQqjoeWo2FiZL3lCbpULXAteyz6C1SPiFUx1MtiiyWdTIw7Vm1hNlJihEnJgLso8iwUJpHcKPWu1yoNYSo2bRB3j9w9XydSv102juJVU5/qnw093yfCIqOyWe0WmkOegYkNylr9SQs5ZgXb82hpFEfaNul59Eg0VevE3xLW2quBZ53PBp9LmoTYHA0CsFcTDkIc/EA=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:wyhnJEKBgStUn3BM0l+L1EVMwU+kJWxayhrOsy+UGWjF30mi8Ki1l5zVnWMlkWq2vZD2Axe7/2ej6DheVFVLKQdvVm+m3u0hK6rcRey9XMr+QpEA/gbO8+MK1tenCfYxHDwSOc1OFicj2YMq7MhdKjLFpvD+sbUzG4cNbzgga+Vl7saDxHTTFIzEWakTsRJd7gJSWGOBzmMVqb0ubHsmc1DIN0yusSoIYmIrjUu6C6/kv8d8a46VRLXyqrPxBSimG4ljTUR4sLhPuPxQGXixb+2BiOBeR/VB9Z1vCyyoFALPMc1/HbiZoIptAJlSOdmt+My7W6qD2DQD0jHqm/hFuHdI3b86HHd5LsGUAJFCcGZ34RwOZMJqQMO3dazYFOGNxCTFiXc/ey9BMpKr9bDPuE2OKDEQji6q2iB90Xrn5BDjy6iAiJfP347oBto3lP2jAmw8dpYSn0yw+a0TQn/gbvJxmQjhxmcgl5ZOSYAwaaFWiPZbnNI1th4SzTqSbjIY;4:UR3n2zS4fSniYAp83CjF6XG+CxpS0uj3gWxp/HRPyAUcOEInBhkaO9WMmngTrbzTlLRUPklAWqsUAUr1lPN87DCYtwN5zmFF24mEcxwXrdZjt/AJ+4M0AFvcp9My446lr3RcXE3slIzMVkP0sdx7inpj8KFCcZX3cLf7fZDyFcClU+5yCF9Hj0e61LDTY23LpRHxaBaxNap0d+XV8ah2OGteTzU0i57eHVuNBHhnwfnN4qg0CxupI3aZdhbDS15QTTe2v82ZiOhMmEiTzjLcUF6VKOmlFOUUHCFladNIt76urjK62sQiL/8qkA7YQCIbR4RgotfxheFL8Q57ymqJn4WX1NCKakBo8m+tGf5pLsYX1lOrlfBxbUHGjzC5TUn5aAc0DzLJFB4IdK5ws2VEozefe8QYebkSGur5+5Nu81w=
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338C2A90B0FEE4F649546EECD710@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(39380400002)(346002)(396003)(376002)(366004)(189003)(199004)(39060400002)(25786009)(476003)(9686003)(86362001)(5660300001)(50466002)(16526019)(186003)(956004)(97736004)(6116002)(486006)(3846002)(305945005)(6636002)(26005)(6666003)(106356001)(52116002)(2906002)(23676004)(230700001)(2486003)(105586002)(7696005)(58126008)(8936002)(68736007)(53936002)(8676002)(81166006)(81156014)(61506002)(386003)(6506007)(7736002)(316002)(103116003)(55236004)(59450400001)(55016002)(66066001)(478600001)(47776003)(33896004)(7416002)(921003)(81973001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6eW55c0ZTTCtFdGs0cXR2QzlEU2swR3JR?=
 =?utf-8?B?d1lwTW9nNmtseTcyOUsxS0F1TEtHTlhsOVM1Q3dzckdPeGlvRlQyRXVvQnIw?=
 =?utf-8?B?QWpLbDU1d3BGQ2x2amRiNXA4ZU1SemZyVk13SzRDVFErRUh2WjlnSThNOFA5?=
 =?utf-8?B?d3hXUUxYalcvaUloR3dSM242SFc1MHNnMjltbmQ3Wm9uRlVDVjB2M2xsaVNI?=
 =?utf-8?B?c3hmVG5lYVBzYWtseXhEWkIxQWZqd2NxMDZsS05aZ3A5M2pJNzhFTHJ3OUdr?=
 =?utf-8?B?RVFJQ0ExU0FwWXhOWjF4bk1BUnE3ZHlST01tcS93ekgvejhDR3A3QTBZci8y?=
 =?utf-8?B?L25QWGErWEtXcFFlUEZoWXRqdE1JWlN1bGpkaWIyN3VZWDByWTdWVDFZTDlx?=
 =?utf-8?B?eEdjMXVVMm1Wc1p1SG8zd2E2L2VpQW1iR2hCRnFlK3JDcTNXY3dldElSQW1V?=
 =?utf-8?B?eHNkbXNJN3lRN3d3d1R2TERHc1hMNDNZSHFhbHlGWXFkTHg3TTJPeFptN2lz?=
 =?utf-8?B?ODI0dksrdjdZcEZnSUdhUXJNN295TVRneGRuMXpjZ3M2SWRhclE2UmdQWUpn?=
 =?utf-8?B?RlNiRElsdW1sQjZZSTNZVjMxWXdDekVGUWNyazFXa0dNZlZOZys1WjhEd1Nl?=
 =?utf-8?B?SUZITks2VnFYSGFBaXRENVkwMWhTekhzODgyNkRrbFdRbm5iNmZjRTJubjNo?=
 =?utf-8?B?QmN4R1VDZGRLejZHMVUrM0tzV3FGRElpV1Q5RHdBZ2l1NTFUdXhzYUI5dmlN?=
 =?utf-8?B?eTNKN3gvSHNubENIZHF3U2ZkWXNiUjllamdjNXE3cXR4K3k4RElRTWFIVkhU?=
 =?utf-8?B?amcxMklKRUErKzVyVDBIa29ENjVqZ0VDTEcxdkNCOGR3ZiswbWJqRGF1WURF?=
 =?utf-8?B?cm93MWgwaVdXSUFqQW9JSitZdTRrMmg3QnFIMmVBVDJQQkRNWlU3aGJKTWNI?=
 =?utf-8?B?b3JUMnVUeUltTUwxem9LTXZtdk1OY25uQzRpcDRMUFE4TEo1bHlRM1VESTBv?=
 =?utf-8?B?cnJWcnVqYUtRQXhiV29PTXdCUkRYNnExQVI0TjUzZGprU0lqL2hwMkxZMy83?=
 =?utf-8?B?QTlGcWtqN29CZkh2UDN0U1hZNDdvUXNUdzhSaXNvNzkwUDhmOVloeFQ2eTFi?=
 =?utf-8?B?ZTNFL1hJaUl0OE1aV1luZ3ptWFRLKzBETjdOTFNOSlBZYlBwWUtCemd1QnBW?=
 =?utf-8?B?SFJwdmZOVldNOHRGMlZwUFFzejZvMGxjbU5RUUpQQ1VKaXFaWGxwbWJIYVNU?=
 =?utf-8?B?U0dQczNLRVRlenZ4SXp1T2NPbWtsa0Q2clVqQUcyRnplb2pzN1Z6eVJJTXlm?=
 =?utf-8?B?STVmdVczRFJZeU54bGphNk1RaFErbUl2QUI3NSt6cG8xM1VneTZLSnpoY0Uw?=
 =?utf-8?B?WXdHRGVuaUV3UHpmUm5WWGhWdU1sUmlKcWUyOGVwUVB6cVBTd2VXQzdEeXlS?=
 =?utf-8?B?cUpiN1B5SUUxNDhEc0YxZ3pud2MvMURhT2wrdnJzaHF4Y0puZ2NrK0tjS2pM?=
 =?utf-8?B?cjdkTExmb0NpUjVOVFZyRnlabzhyZ3JTY0lVWkswZ0lpU2lpajNkUEsvcUEw?=
 =?utf-8?B?UWRmWWRGcHk0OFI1eW5JY09YNUdsRUdoQnZHeUhXVnJLdWhteWZnOEJna2tm?=
 =?utf-8?B?NjUvd01nSlN5SVk0OExNZDBxWmREcVZja01wRzk5WnZLVGV6VmQrZUdiNTBs?=
 =?utf-8?B?eC95SnJqRCtaSTRkbUY4Q0NGVGF2Ylh4S0krK2F2WHR0YnVaalh5Q3JPbWd5?=
 =?utf-8?Q?LY6Uoh5qiiLomyPHMacYRQEUccRwyvOJPngGuJU=3D?=
X-Microsoft-Antispam-Message-Info: kxyhyNzFf0A/1BqJt2aprinhjBGgWH+GxM64pz1yBHlGjwUR5DBsSpjHyYYz/fh3DqpixzOVZIkhCVO5cx37STMz5o7vb0yxgA/viJBRBzOKvr6ejMa9IVu+B7S/VCgcBI1Nvt1aNiZY8f5Yth9y5FskzX86a/5quY61MxmtkLy8FzVnu++BnWflD3H9uC7h
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:OH/6VEjPc7qEFZhc9qqBoolNBGyz347h3nVNNJNp1tfIc6MyD9CrCctSazQNXfOCUHrDy8c/f538W6ceMlhBneC+0Qf6e+9/JXE5F4hweSM5vf5Tw9ttOg0jkeImOWUlz5yJNTNVof908KbezxUpuLpuxAXGaCpF76jqrUFVN14IDgU3qRH/MViZ89wYh78OOgoyMh5yHFgeE7E+yIkyiAZSfza9Vkf8XkficDZ6GTXHZTeXm7XRpJyJiD/PneQz+LLA4Xt85PXyFlkz8MzMAG81WKtPOaZUjJnZUXhYAddT4XzQISryrf38+8v5/ArTo7VtdPuYx+yLc85waNh3u3EybB6Aa5Min89iq4EunarNyCRxgA/zDtK7NRR2ZPQwCTP6N8MLokb4jXN+we9sKG2TEVJwCvLIkC2gzdtcRvi6urKYyEHpwvmmefR8xlhfa4gYMDYr7nCCVvGGwM6sjA==;5:NHD03aQWwQBLnajrbQTLTPZkXmc0q31kZO8hqD2EN71dhyf7tNkU3IoEG60Evq354Lg5+fZQ0EBmUR2lC+YnBxGTqSq1tygXDjwFyKK/07UWt9i+1LafABg97hI47hi7Zi5fLFKD3pJWHpCbCDhxXa/uCr3b3mtZr2Ll7yYnp3U=;24:mn3bl1hnHIO3QLXtqej5A+xUvZP2T2mrVHNP5bJM5hjP2ybKI8PpcS2fBXy76SfpWy4y8mYzkDcXHJ6zfETklrlIjn0klQOw4CQ8Lo9tx7M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:iuWeZ9mHR3/HD9/yfu5yGSDd4QnBprQbU7lnVKHCSQtBlH0d0t52FNuHyo1zxxkniAFxoa3ZqK3lCmpv6YeApFLUIHxx8e7AsgzIehQeswWLICSSH1D8ZWUXbhVKC5yttt1gG0Y3DP+Eoi/75nxqkRX0djUBGo5IKQeT9PllDm2yGiU36GE0eHkh3kf/WLP9uupykA3Ki3QrgU6GtIhh1zEn/tktm1xj0kwPguk94KmC73sbZ9F2BGrQUvcs1C+3;20:Hyk+ASgDKdE92RbFgLL97YIYB/GLePzKrS90m0hhu1c+EYvdqVSyzBycLJq0j4KZrZYZuWEICmcO78HagLlRGVqg2eKNM3s9l8WVdk4Lt73lW7WjkmXfyM2vg1ZUk89QqhUDDQCvV3aS4s02HVakT7o4ZImd4ot83CUkrcSzbM0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:44:49.2387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6cdb58-c39e-4d86-4e5c-08d5d500229d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
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
