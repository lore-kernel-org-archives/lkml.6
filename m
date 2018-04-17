Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/dpn/RRFUVQebAX/dbd2uJ+ftICEbJfWONrWtw+WCbr6vDjxpO2O7J5MAS1oZg/Muyqdpq
ARC-Seal: i=1; a=rsa-sha256; t=1523980395; cv=none;
        d=google.com; s=arc-20160816;
        b=G6quZzTKeNLHB8BxCg12388j1yxNhZIDiOioQa+0p//juoLjbok8JqxZAWQeh3dkCs
         8GUR5VgaXgUCtsvfIHRjpWPQUdqTyiFk8uuu2zz2xOgBA78CC2s5LOulMILJ5wre4KG1
         eWpRuBrxDcTPBWG2CLS+tRngokxJS4DWGW2lnV6LSVEdxA4rLzRNXbDgV61zumaxB9ei
         SbwotVug5//rkCA3n0K8B9x7TGPNjpxpX1gnZcRiWH7IBOhpL91srBrmSMAJLTtMcds1
         e+Ephcb8OpKDDeftR4yu4HLreP1BX1IQ3Vt3BJlmJs84iszJPpD2k3Hqu92Yi6FTjpn4
         dJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=F0s+zLtSSHKeHGq0lrl3Y8ms1sjMhHkEZNj3JtB8k8A=;
        b=yR/iKnVJ/tUTuHK86EdlFJOAyshS5oDXUETmbJf3UqXWVo1O8aDbrrKIZ2Lta7WadG
         7eQln1Y46Uie2H7EvBv/K4WNNd7ypTXRMB8S2SsHj46lQY9gsneSf6j9mmwESyyxT4cT
         iUZ903kHAg+kRro7yO/Ar/5lbUXh6SEt+jPWC/58CJlf2ybZV6T8IrGJYDZUCS5m0/Oa
         +PTtoDPYirZh7Ps2KQ+M05LHMA1gWMMhwyF/zO4OqTkgx928q9A34L+tLMG8UfM4dFQO
         wMbKvf0U3Q6qTS0uy6arfX/PRwN42W1Oql/OGonQpgO/V69wnvKZroFZB3+qvSB3jbIz
         5uZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=flTp3kG9;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.124 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=flTp3kG9;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.124 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v2 01/12] mm: Assign id to every memcg-aware shrinker
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
 aryabinin@virtuozzo.com
Date: Tue, 17 Apr 2018 21:53:02 +0300
Message-ID: <152399118252.3456.17590357803686895373.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:7:67::18) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:DDXfIUNEY2IcfgeD6nu//v73O6GXcbcDy6lAPpdRPgYFytATEsaZxhGaJOt1GJtNfh6j5vwMLnvrsB+x8KeW/SbxxMTHxhaan/EpU7U1do6Yt2Hq5o/hEMXyovKfy6q1lKH4xd+RXvf4oOJa52N7ETAXuvZGO0IZjZmJhLmnwgHDQbmOmNsjTdaTegwumtXJxWjHsHMr/B4IR0ZRqiXVT1ACLc8i42vE7sl6EXbZeNzSdUSgBJP01acM0slx9B2o;25:F90IOyjhNeQQAk1yHOaOvG1evrZ1fMrL17vxXjRh7E196ouD4y3yWLeBe+jJdtN8KFuIfckd+Q1oOpxzkJU74x3omiXSFGCRUOvBlSv4lJGterABLE9XtpRy+N5I4dNYqxdlt2Fn8WH2vxPHy8NE57jpZ/NtzRczXCSGBzcugqZZEnifank8SxQpUbVEoOZb9YBaUvhMQX5biR7qnyhRUWbWuiMpCmKO8LOjdQHWamUAb4An6XAxtcSacROp1Onm5Fbn3ANLDQuwrVzlQiXbtW4K91+CY26X8pqu1BZK3R8EpwqVI9s+WYkzUJbRt+7wJ4i+NGsGqg+o4r49Rox0Ww==;31:FRRLKg2BoiznfbeGBA8QV15YfRYjiQlv2MLqw6tgbWy6CMRjb7jutBS0sDuMqKR8m2y//ohl7Tp8alqVpXHnagN0l9Mk5u+PmqFKcAIqVIZigkIFCuPCxJXDWDo1ydxXa1a3RHkhJUxAX+uzdz+mmSJlDHR4DRbSfjsUnnng7zhe6dEk9AnA11lScFp1xoyQz1qSbVBjtuGV+OwPNSVemizYBqGhY/JSFWorP2HkM84=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:KzUCNKnDiBpWR+R/4j/tbB1bQxr2pjHAWMcXeFUFa1xDOAVwYwYe0s7qq58bS9Lsy9J5vxmfJqBTRm3xbwI0EgZIZIEWP2wpkFP4c0xNckpsGmmLIGJ06QBRx77SQywN45vXfJiOgXoUhD5fv9LzPK1jL3EfFKoPopslQIwRFh+wG49nEML5zrVMFFt9CoOLLDQg8g9SsewiuRiG5oYvllKEecgZYZqgiqnOL6sfP8aLjZ8YJpR5nvBKf8V0GuIlrbL5/VnnRYyxXLK47I0oVDwZ4RV35Fh4Jk9Quu489EmIs3wm2XhrJPgG/VHpJhT2mGYU695+ZvUHzaza+AVUAZtyhyQYxAYLsuA5Ttpj+aMA5l4Pu5tpVKZBQEGlwfmbki7mC9TdDV90siapePg6miwwuK+8Lk6u9zElkqS33IgwMR8giWipe8oO1w8X9MgZT1mTPhDb3iyQx9TMDCUs4R5q2ue5Ggrr84mEbn2PRMOahRuWkVA5iObfD3ewMjrq;4:ocq99RhlezZPN3jh6h2j3uC+H+65g0S209hep9Y5Ooiyp5Am8F7Jsof4ytNlzwaT8pICnx6DCgMtISLaHXtV6K+BzP6bUlk7U5ef00ptPQAHcjTF/v2n48d1pbCYHAEbg61FWJVcV8YeUg7+lm4JGZolKHjhAKxOoQj4G0p4CTiKT+HUJ2G/cPfqIJJgdBkYTM04LGCnJ032I7lxpPaP70l4x/AWBnUXcQkfU0E7xGQ7j+tgkFkISbZHxh7Wy3dHCEO3DHvzzoqP6np1xmP7eg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338DE7DEE818C99E88E11CDCDB70@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(396003)(346002)(39380400002)(39850400004)(199004)(189003)(47776003)(6636002)(7696005)(52116002)(23676004)(55236004)(7736002)(68736007)(7416002)(53936002)(2486003)(33896004)(76176011)(386003)(6666003)(59450400001)(6506007)(316002)(66066001)(305945005)(3846002)(478600001)(230700001)(86362001)(6116002)(25786009)(5660300001)(8676002)(55016002)(61506002)(16526019)(26005)(186003)(103116003)(97736004)(106356001)(105586002)(39060400002)(476003)(11346002)(58126008)(8936002)(486006)(9686003)(81156014)(2906002)(446003)(956004)(81166006)(50466002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6ODNWYVF6OTlPN2xpVFBFMXY3UEtSQkVT?=
 =?utf-8?B?NUV5aHh4NE9ZeisvK2R3NGZyMnRmQlFQM1Ezc2xETklIOXo1Y2NyN29TRW9r?=
 =?utf-8?B?bWZ6dkV1SXdBNlBZNUFWdnljTFBsd1dHMnNob2ZpSG5kaFpNMVdjWEtVRnIz?=
 =?utf-8?B?UFhDb3poZE5PUk9HekNvM1ViYXJucVpPTy83bTIzY0Vzak9RRTEzV2hYTlZq?=
 =?utf-8?B?d1dmc2s4aHczazEvaUM0QzBoUEE1R1Nma3RKZ1dmMVB2aTZrVFoyR3lScEF0?=
 =?utf-8?B?SUFtL01ldy9jNFhnNFljOHBoUE1uMStBVDgrUFpIYUhmM1dvMlYvQUVoazlB?=
 =?utf-8?B?dnByaGEyUXhCaGlEd240cENRaFJHWHVvRW5ZWG9ObFRSZVQzUExwcmZ5TDYr?=
 =?utf-8?B?dy9GbmcrZ2FvQ0UvdlhBMVh5OFJEaGhvZ2NLSDJBOGppdlc5WVhWYjJEcHZB?=
 =?utf-8?B?OG9LVThwT01OeDMyOGRIYVc1ckZqRDJRQzhxTlBqMGFIcEswZDlvSk9na1RS?=
 =?utf-8?B?dkVIRTZxZk1QWUYxUGVvL2drUjRWL2dnTHBjc3V0anVnR2plWkE0QkZ1bmkw?=
 =?utf-8?B?QVc5bUc1ZUpBV3A3VDRaazlZMGtQYmUwWW4vT1NJMmdVMG56aFZQRnB6dTg0?=
 =?utf-8?B?Y1hRbndQblBZNkkzSi9KVUUzazFiSTZCTmZEZkJON3owakhEZUNZd09zTG9Z?=
 =?utf-8?B?dWpwWjlCdVlKSFhxVE82Mkd0M21IN0ltdHVIblduTlRaMnNONExEOVdUSzNv?=
 =?utf-8?B?d1JCYndVbnJpZGRiRnNidERUSmc5Qk5UbkV3elV4QzhMNnJ4VmxLTUU2UG9V?=
 =?utf-8?B?cGpZcjcreitZak1FT2RxR1dCV3hDbDJsSGJzdTlFeEJKUllubnJSdXByNHhi?=
 =?utf-8?B?MnJMYUw3TXJNZGQyTGw5eWROeTRMZmxoZkh4YUlheDE4VHVwb3U2M3dSNkxM?=
 =?utf-8?B?Z1I2NnBPU3QxcStOOFFkM09yZXR0Y05jQ1EvUktWenpENmw1bUh4N21XWUNp?=
 =?utf-8?B?UUcvN1lIUDlYTXd3Q1pEMTZ5ZUFtbysrbDQxdnZ1ZlhNeWNEY1JyNHFnOXh1?=
 =?utf-8?B?ZmdoTGx2bjJERTF6K21OTmNsQytXSjFZNklKdktwUm1jcFJKVTBVcm0vSysy?=
 =?utf-8?B?c0ZhOW5wUjlsdGwzTlE0bW9sbXdUVkZvUGxvRTl4b3dla1c0bXc2YnA2WjVl?=
 =?utf-8?B?WlJUZUx5NDBrQWg4SGNaZjRUUHdrZ2g4ZHp5T1A4Y0hxOEc1c293SmhibzBm?=
 =?utf-8?B?YVdSSWVaelh5a0RBSW1iYzI2TnNFcW4ydDUyTnh4UmthaWMrUE5yaUxxeGVx?=
 =?utf-8?B?ZTJXWDJmUW5kWUI5NTgxYWV6R1dNVnppZ3dxNmFVa2NBZ0dMUXRIaitYYkV0?=
 =?utf-8?B?MVgwcTRwSHZQRjZpQU5rYUh4OVlOeUZBZURXTmtUNll4QlVBNHJ1dy84QS93?=
 =?utf-8?B?VDBZakI3Rmx0dWVLZ3pKOWF2UldsQUdpbGE1N1cyV3FNdmt5aUUyYmVmR2lh?=
 =?utf-8?B?REk3b0xVTW1lbERVSG95b2U1UTZwNFlJQWl5RklncGNteDM2WmJCSytEeG1U?=
 =?utf-8?B?cjluK1RmbjBnbDRRYjRDeVJSdkNXdHN6YU03R0I0RjBYa3NNelJYdWlBVXB6?=
 =?utf-8?B?NFhGZm1CbGV6cEpJQ0Fqc1VVZmxhQ0pLY0tzQmF1TTdiY1Q5Z0U4MWc2SUxZ?=
 =?utf-8?B?WHlFUTdmd0dMdGRlYTFwUDNnRW1OTWFyU00xTjVzYVdOUjFIQ29Wc0ZQSTVN?=
 =?utf-8?B?cXl4ak1SVjZRK1NOUmdHdGRUS1RQdXJmR0NYd2VSUUlsSTN3aisydXc1MEdP?=
 =?utf-8?B?UEl1bGtrZ253dmdTbkRKV0xSWTFyVnlicVNmQW52QnBucXViZz09?=
X-Microsoft-Antispam-Message-Info: PyKNxQ3dbumQprwJT5XntRe0DCUR1RNXAWDLA8qMIT6J+hFpafHvtedHeEtzpnJIe9wp7ppmbNBHEMUrniHMKy5OUtLjqIgl9inBHBMJoseepZl3y3kBwqhgkaMG4cYoxUM0cgNQP+U8XjLvd/txDuHOXhHCWlwzd3IzOMZ1R2eSSh0ZaWAe4sUlr28Np7wZ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:NN1f6mZrN6UHHw3IhzwOsTH+Vy6UBVtE232dwBvOQxJRHRfU1ERYOyViuueCCCR5GvrEQTV0U1Y6UxGk08h1RNKKbZd5kcbE73cFKUdfcewbtu8GEn8YLN8BvbKk2yql/4HXA0qFkYKEBUlRReLy91NLZX6CijGgG5XUEb1pAJfbIiToBpNYGb7+l8Y4iHoC/G98CnXdboRRZZwZyW8Uc3LO/mT3/UvmvzAaDCoGy4PZlVakeIYGF89LnLS3P/244gwWlSkhVh1cwdCfrZPPet2vFDR+yz6xU0CN1hOHSEZN3IhjYufMCLWVKKBsKTULuOGNPZQpcnm9kXrMc/n/QDLRUsEornFe+7d8DfzWUQVBJwD42WzrWP3v+MiRUSKIxXKI3pkn2eAtx5VkBq4jTPBrwQRVA1jKl9sqF5fPEWoHmQBbZnzGusWbOtoJkK2fruSrtYlADrvdNAdZcfBmlw==;5:PBHgNwGy2ExWsh9HpeEpuho4CqP3DwMkbHaKZqMXdE0mqPvQdR91FLq0bHAfyRK+YD6B92JqoYAkKoipd/Zw0N4Hx/ND1wYwwzQQTt20yiIMGvQ1dYGVo6WfmFYteCVcTDXfKxH2HaDYyBJo8TofWJ8bkkTHOu4ulfr4PZkaoNI=;24:wGcpaa71gV2neb7oMbEp/nXCJY5zpYZevy/fyqsg9MGHpeTCTEK0o8MNbMOBvyvlx8p64R4HLc4t7KCKmk4XW9Wt3f3R4sbZUm/bXpjSFjA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:3aVvuP/lcs+x7tczEM4F77xUuD+gbJaDuN8Zf6DkVl46u0nt5swuQAzt5CFouLhK3C/fS5rbp/2o2heT6fs7XTeqaUpv/XbP/1HMNSWrqpXwLEyMj8UJHOhrdvoOXLd0h7VTnnUqvb6NpqM7h/rO9BZcTmdj6+WJorn6Vn/BeldXZTMHVAUW3QTydTWPKAlnCkPh7RyqjLjrHdnKNo9EV/cWlgzceB6wdwXO1jZ5H6QZJu2FvBHp3CCvrTbgA1Qh;20:IdK1O5Dx953rRDmcjZEwdi+8Y9mmKd9KHyKQV8NOty7cQvIVIypaiFBAzQ8AgcYvFXXTyilMhQq7dcueq8vtqcTKPKM8XA062WaJjTkCUEC4mZyZhvet2R7nLpT8+zFnqUTfOWDwitG5G71cefiCCXM8Los8TmWGj6qxqp32a6I=
X-MS-Office365-Filtering-Correlation-Id: 83adc6fb-d1c8-4b46-3eb3-08d5a47b52f0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:53:11.3139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83adc6fb-d1c8-4b46-3eb3-08d5a47b52f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009267479229519?=
X-GMAIL-MSGID: =?utf-8?q?1598009267479229519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch introduces shrinker::id number, which is used to enumerate
memcg-aware shrinkers. The number start from 0, and the code tries
to maintain it as small as possible.

This will be used as to represent a memcg-aware shrinkers in memcg
shrinkers map.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/shrinker.h |    2 ++
 mm/vmscan.c              |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index a3894918a436..86b651fa2846 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -66,6 +66,8 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
+	/* ID in shrinkers_id_idr */
+	int id;
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8b920ce3ae02..4f02fe83537e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -169,6 +169,43 @@ unsigned long vm_total_pages;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+static DEFINE_IDR(shrinkers_id_idr);
+
+static int add_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id, ret;
+
+	down_write(&shrinker_rwsem);
+	ret = id = idr_alloc(&shrinkers_id_idr, shrinker, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto unlock;
+	shrinker->id = id;
+	ret = 0;
+unlock:
+	up_write(&shrinker_rwsem);
+	return ret;
+}
+
+static void del_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id = shrinker->id;
+
+	down_write(&shrinker_rwsem);
+	idr_remove(&shrinkers_id_idr, id);
+	up_write(&shrinker_rwsem);
+}
+#else /* CONFIG_MEMCG && !CONFIG_SLOB */
+static int add_memcg_shrinker(struct shrinker *shrinker)
+{
+	return 0;
+}
+
+static void del_memcg_shrinker(struct shrinker *shrinker)
+{
+}
+#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+
 #ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
 {
@@ -306,6 +343,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
 int register_shrinker(struct shrinker *shrinker)
 {
 	size_t size = sizeof(*shrinker->nr_deferred);
+	int ret;
 
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
@@ -314,10 +352,21 @@ int register_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		ret = add_memcg_shrinker(shrinker);
+		if (ret)
+			goto free_deferred;
+	}
+
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
 	up_write(&shrinker_rwsem);
 	return 0;
+
+free_deferred:
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+	return -ENOMEM;
 }
 EXPORT_SYMBOL(register_shrinker);
 
@@ -328,6 +377,8 @@ void unregister_shrinker(struct shrinker *shrinker)
 {
 	if (!shrinker->nr_deferred)
 		return;
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		del_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
