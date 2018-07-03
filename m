Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0C1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF9621A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RZ9Cvns4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF9621A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933684AbeGCPJu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:09:50 -0400
Received: from mail-he1eur01on0102.outbound.protection.outlook.com ([104.47.0.102]:56576
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933039AbeGCPJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9vprsgEPssImHu7QVcEt0KWuFtdZ6jjZZbWT/iqBnU=;
 b=RZ9Cvns4xSCJP3xJ9zxm0xWUW2wjjke6eKfF1Xo014OPGSVTJ1JPerrNr7sVn0blX3BV05CYtUAQTiKmqdoiDY+bhgv0KX70w0bK13cwE5R9UYw2VJ6uL4CqusdQ3gW7RSTacAw+TUYCevmUCYj7BKm4p/gYoe9cmo4dDcdWnZU=
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB1332.eurprd08.prod.outlook.com (2603:10a6:203:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 15:09:39 +0000
Subject: [PATCH v8 06/17] mm: Refactoring in workingset_init()
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
Date:   Tue, 03 Jul 2018 18:09:36 +0300
Message-ID: <153063057666.1818.17625951186610808734.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0035.eurprd05.prod.outlook.com
 (2603:10a6:800:60::21) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 096b1af2-e2de-4d6a-d11a-08d5e0f700d0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:nRYtqHqeub/OMlDErB9EK1Fxfj+l4xzu3N16VEp9Kcndg5J2QDeeYtlgacJs8iT7HtTF1xbDmOXFYnpaL13ru015MChDlDVOPsmWNWlJn6IrpdvCE+CM2Qe6ENP6Js+FxpV6suFXXoeIYhYJZekVbvRsWpIn9e4fBp0q9doXTw3vWWpXefmYlN2B4oLcFRS2CvOamblAiVcVDNTm/UmcfPOpYKR4yBeDDbi5+e0bJaw/heACsmEO1wE6R8c6AVgZ;25:f+tMXdOoFXIpyfayhFlwu+P5jyIk2f6Hwk4M6Rb3svPdJiwrwCTiZrgPUkmOIhqfzuPHa7Fkces6JHRWXfd5WULVCwGjUwRKeKLywTvMQKpiDPv1dr5ZK9B9tCpkxI1qVBqYGdSRXN71X0Hu/5mH7oFyZMH7N+uD6WN2HK4IirPkZempFDVYWNruhxP9MEtNj9UZ8KM9RVuFg1z9AlVVpCruq4XqZLNRH9GOAFO6y5z+TK7ClepA6Maw10YlsQPtXmpstmbrUpZExDtM93bz8Y15fPjJMefM28p2iiaGpHbUMqRUHh0i06nudocWXA6me2MK7zkXCy7/ZJqFtlB5Jw==;31:kTmzCKrgYFD17JZvxJUsw1VlYfqxTbkYZMGxZ41hbM01kjxQrfR44NPyvkVFdb/TSSu+V3vD2TEVoPSebQk1WNHGGcVrK6dy//kQp3IDWkSwazGuXj+P7oMlqboC4ghCqgFHXVwu4Fqn/to32u50eIBgg0FHRyO+QEMunevxTSPcOmWZ3niuwKqGm7obwhcxXxA75BX8u2zad5qGbkYSnCH8fIk+GkeZa2PRhWGIPrM=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:Y/xpCpLEKbLiuwx8iDbejd/mjwb4J363XG0cOWLPvwd/Rd3krzMZLOvvodqNsCWqSIuF78h5RQmTEpA7WBJzXcv08KIV/yNNq9rdIsukgRw0WYfgNEjYO18EzGtAyb0TX/gsWHcc7yuuzA9EachIinFa4NUw9du20rg6DdpZFcXz4ScoPoj+OJwBpu0k1nAl2CoWqZ1elDxvQ2cDej6XmVhC8KtjIuqQeYkj7e58UVlG0upBzVM29+GxyBDuPdP9EbtX892eaK2Dl2Aql7oLUEkK1wdA7p2JYD2k/W/jQUlavc00JTp4gtu3s5JZT/jlvIcgZrz7xFg5zzLQuBge72C77whmXBuMEE2K8uT8IOVdbF5/f7VoKB9m4J3fdvZHdKEg2DGlub720Q+Qe55bGPAHtj8dP4iggYWOWQ4LXH0BIOhA5pTeJstMjPxIzP0x0zeZfT2ohfZJZi0VllOIEbgaTEDWkO0sX9OarD4NVJb3BswToMLfs8Le3USwkuLf;4:XLew34DSzVVA30DHFOfomYBNVhgw+DV3WDG4s9qLaM2+hfjIofhq09xHhgpdVp8TFnKqJxkQSC8el2XAIkNtTe9ipJf9PImZVPixMQiRkeoeu2INMK3u+TyaGuapqu07/lowzAqEgqug/gKIZCTeDSCjrQkUCwd9juzjcuGCb4aZJhAPa3pwhyXNGsBG6plfayBvnMY6Lze1LXl3wPBVPmOEFFxkuXZ5/Xzx7BmT+LXsIlXQQ6FzYi5raO7iSTFU1bZiqGk2I8yjbwCGQ33RYwvM7Nxme2bh1aZCcTYzPvDRqW0Yd8cZnAWM+yRiJgKiSrGlnE661F+9kDAgfhlZFwzoySeY0rnziW1JOKEzuodQfuXh2xMIDtMA8QT3IlHsUqlC/QqeFZLpsnxZz/iE87FxcXz2u9AHjkOCzEUWyl0=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1332D055C2DC64F1328AE2B3CD420@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(136003)(376002)(39850400004)(366004)(346002)(199004)(189003)(97736004)(478600001)(8936002)(305945005)(2906002)(8676002)(81166006)(81156014)(50466002)(7416002)(7736002)(25786009)(39060400002)(103116003)(53936002)(23676004)(11346002)(52116002)(47776003)(58126008)(33896004)(316002)(186003)(476003)(446003)(956004)(6506007)(105586002)(106356001)(14444005)(86362001)(5660300001)(3846002)(386003)(230700001)(6116002)(68736007)(6666003)(2486003)(7696005)(61506002)(55016002)(9686003)(486006)(16526019)(76176011)(66066001)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6TkFrdVR3Zzd6U3hpK0Ivek5ESFJsT0FF?=
 =?utf-8?B?MGVJVTJsTXB2MlJ1dWZ2VTBzRjFrN0xGUWh1YUQ5MU1hREU2S1JCNFlZOVdX?=
 =?utf-8?B?eDhSQmtoZVFDdE9QcE45RzBxbjcvaHFkeHFvRDdUOHJiNWVBeDl5bGZhdG02?=
 =?utf-8?B?Ulh5RzJxSEN6OFN6ZElsaW5PZXhDM1hjdXFKcXhlaFg1K0Y0REg1M3V6bXJV?=
 =?utf-8?B?ZE5tUi83UDA0OGdZUjZtSGdSVG5GVUo2alVQSitqZ3loL09lSEpzendZUDh5?=
 =?utf-8?B?aVNOMDEwaDNtN3pPWDB3aWx5MEp3U2lTdng1YzM5QVVENy9tUUwzVzArWkEy?=
 =?utf-8?B?MzJ5ZkhXWmpWMzZMb0hYMGt1SFA2ZkhwNUlHdEk2MzNmaTg4Q0p3M3dCMU16?=
 =?utf-8?B?N2lRZlBHUkc3Yk1kQzBtOFJGSGhyMmIyaCtLV0NmN3NsNnE2SkF3UUd3YXRF?=
 =?utf-8?B?ZGNUZ0dnYUhyS08rd2gyd29YanhEUWxIaWZWa3VFWDkrRkZyR3JmZS82MlhM?=
 =?utf-8?B?a3RWY3k0UTNtN0gza3JrREhFanpXQWo3VUNsUmd3NFYwM3U0OEpPUGlvMWxs?=
 =?utf-8?B?aHA5TWV4YkdydFFqQ2VqVXM0UzNGNWZHaTNhc3J1MTVBUlNtaU1hZTZXYmp2?=
 =?utf-8?B?YUllazV6VVF2cTBOVlYyVXczcHBBaS9QUXNHUUFSNC9HK2JXK1ZDem1wUTkw?=
 =?utf-8?B?bStzcDd4a1dMSXlXWFlERXB1SVZjenNIbEd4VTh6eFFWU2Qyd09hY01JYlVi?=
 =?utf-8?B?Z1NnLzMrd05mN1E1cFF6OXFOU3FhM0FTTjJ3ZC8zVTRXKzhrSGhTekl6dkdq?=
 =?utf-8?B?dmQrNzcyR0Z1cm9RTHA0WXRKd0VMTldjei9UQjE5eDdDT2QwZkR1eGV1aVdM?=
 =?utf-8?B?b2dIVU5lT1AwRDdWbERkbHVmS0RFWmdQeFdkeTdrQmVNVkd5TXJmQWdmYklH?=
 =?utf-8?B?Z0lJbmw3dGYrNHgwUm5RdUlRNzgvT29JODBCVTlwVWFIOGpLdkZFbnE2NEJv?=
 =?utf-8?B?OWYvYURlMVBOQ1NUYmd2aU1IL3UrZW8zckowL0ZUVnM3SHcrR0t5LzMzbC9X?=
 =?utf-8?B?aVNEN0plTFZlRGNkYmJ6Y0NMaTUwMWlyVGhIODVIL1lJQmdsbTZrYnFxZldl?=
 =?utf-8?B?OVdtbzEzb2NoWXExSC9RUDJmd0o1MFJPZ3AvVExZNnRKMGVGeDh6MVg0OEhR?=
 =?utf-8?B?NG5tUVRYc1E1VE01UmFyMDR6SDNXTVhubHQrSFVyN0NrMjJ4eDNvLzF4alY4?=
 =?utf-8?B?Tm0zWDRTNmxEa2cxZFNmUS9QdUJpYlhWK1RMei9nbXVyUTVkYVVRL0hBRkNU?=
 =?utf-8?B?dGVMY0gxcU04MFoxL3p2SDlCdFlneEpTWjlodHI5UnVzNDRQTHZtZG1YbmVx?=
 =?utf-8?B?M1l0bnJwc08rQUdKKzNSRDB4aWxvZ2VtRVZ0Wmx2YnNpcExpaC8vZ0MzclNC?=
 =?utf-8?B?TkZhd3c0NFordmNhTGxSOUZwQU84VjNIeEgwVCsveHJWdTRxQWNxWTdNbHRh?=
 =?utf-8?B?aDFBcW92MnFNQTlUam8zVjRWTFhrWndhbThvd3g1VXBQY2RwUlJuZGtWdk1a?=
 =?utf-8?B?K0lodnNDRGhvdVk5djhxQjF1SVQ4WXNNVEtvcnhTbHo3N3A3bHNFL095R0Mv?=
 =?utf-8?B?cmNGVGZ3N2ZYcERMc0NraW1OdENKcFRoU2pPbDJvVkQ5RVNyZE1EMktHdnk0?=
 =?utf-8?B?Vmk0VXdEK01XeUg2VzY2eXFlMngrczZCYUxUc2p1N3JwQ2JEL05sK1VDT1Zz?=
 =?utf-8?B?aDFTRE1iYmVmQ2oxa3BBMWtRPT0=?=
X-Microsoft-Antispam-Message-Info: XXavQpr8OKZ/vmEBNYMmL6TtPDcSGA2AIJornJkHhZy6wrKaZEkBDqiF6MT2S4ASJHBiSVUnVJHVoiKXkXyRK2GJa5KsCfKAchhMv91JFXnW6j0JGuLkH+C7wYWU0ttPaX7XXG3UWonk3POrQiMec3n9L1FVPJfYPkRivwPqhtDLp0i0nmh0TeN+JFL0/3lP38vp6ZuU78s3UcySHETl2+sOAyIuX4LaBzCqlmtid+9kr8eABUUcVMb4aGJmVqHkvBCuUy75pCO7YJXUo6YnQTB+tNtXEfV42TJqMnY8cJvZT78x4YnWMSst/XrLATqZRmVYnbfsKC/5JcsmsMzA4OPp4BaNX/AwsP1KLjEk82o=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:d3EKhfFt1MK1G6j1B5tSwuCN6pGMazmOr+uO45xksbPcrp6icQfYjVkEyTgU4ZqMEKdholLJEjvvApRJXaBJCZdYyKAoV5gEiG2YhMiPMQbkiA9BR7emkNehl7NZiPtcGLdeYEkTSrBeVQNXnGRsKC8jXbHGuh9sm4+wtbnVtiTLbTIadEg/eEkKpUpEH8BPJaACfVlFsr/srbSzMp1JiFrdiibYVU1Fx15fEnWk80BFr/DlMcP2qCO93crrnbqjGFernrqyFh5EdVPF6ssYtJn5yn/ilO4PlQVdrUtyx0eAw9LK9oTLjcHDuI55NqMt3lpPeLF48/T3qVMI7cRMDPkgZctEcLpkPiLHjO7VneTfoystSgjZg3f5IlOlKnaZMcH1QTRcgGy/yJZZT6WGG7QLs4rgkOCGJjQ9zakmUSgf5EGiqy7V10ZAeFl7a+0+56nL4clrXMMWFRnDDBOipA==;5:IGE3Br0bk6dCKEyTB9cycsC9b4KwogUGiIR+OH/cbtZRtHtykse6ExnnOzkn17yLEM8JOuO/yvHGyu65ufEnoiNWwBzB/rDY1X1fbpf7wW6FVK+ng1NEPojd78A3T04RXiRU8/OIyjw0wLm4gIcMQyzjbDuiC9R5reL9FYOnyiM=;24:Iu2lIZDq/nnlkJwDeFb/nyozfxXz+CuarucRCK2s9dMjP27bNuVAH9vO4PA+pcCNDdBOP52lMwwR+RKXgsD6KDsIaI7QhOWangNVYzW81es=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:N3jMO2+Iy1OeAsQiL5XW+R6b8aMuLtafJoJPEN/KcV3e+yc0A9we8lqi6/4oa4B4YypZRGeDZkAOZPCE8CBw0mOum8cedCW2J2I1G71d5tXfZ7bYiLDUUwErmDn8BWLNoSr85qQ4MYhM7JnoW7aMoob4PcxsaZaW0t0v1G5Bet9hIjq5Ewggzp+4shLlXH9lnz9KlXP/XocRDGYP8Osx2slyQqOEk6hoIxAIcnD1nQbCdv4cBwggKDOHuozUJKNt;20:wH4MNFN/I7RAiqfY4pNqkWXq1O12ul9vyH2qHkJe6+J8sFxl8VgVzOvQSawMtKI1fHuF/8vZKqX4XrLi3aQ9OyBiDHlkQbwguVJcjlL7RxQ/RvOVfNNIfi4HS7ddV0LdyCc3Zon2rdieOqrXvUOFFgGdzCL8sUoc5JmhaXjDGVw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:09:39.5071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096b1af2-e2de-4d6a-d11a-08d5e0f700d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use prealloc_shrinker()/register_shrinker_prepared()
instead of register_shrinker(). This will be used
in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/workingset.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index a466e731231d..b16489c60471 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -507,16 +507,17 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	/* list_lru lock nests inside the IRQ-safe i_pages lock */
-	ret = __list_lru_init(&shadow_nodes, true, true, &shadow_nodes_key);
+	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = register_shrinker(&workingset_shadow_shrinker);
+	/* list_lru lock nests inside the IRQ-safe i_pages lock */
+	ret = __list_lru_init(&shadow_nodes, true, true, &shadow_nodes_key);
 	if (ret)
 		goto err_list_lru;
+	register_shrinker_prepared(&workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	list_lru_destroy(&shadow_nodes);
+	free_prealloced_shrinker(&workingset_shadow_shrinker);
 err:
 	return ret;
 }

