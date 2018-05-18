Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqumw5SCE389QpB6TPD/IRtD3xEIEDwaOn6m9MrcglPJ2hUVw/q02Mx6RD8CzzjJ5erWnLj
ARC-Seal: i=1; a=rsa-sha256; t=1526633011; cv=none;
        d=google.com; s=arc-20160816;
        b=QCiGFs5GfyL+k0JhMlq/0cb5jvzLRkT4Z/WJm6Ypky69AaW3srETH6GqIoYGzOM0wi
         tDc09QT1Fonx+iTI3mVd7pd/jAWisB8JEB6dCt0I1b3J8TItt3cijEI0sKhP6Cs2r0qW
         ehODfnQ7NR13uFxENDYdnfq5INWKp6isjR1RklnzOpS03g84fHFo0Nar7XYFyW3z7eaq
         d3KCmuGkVUNmjU25OO312f99UUzJX516p0pIweNxIEt6HQeKgNwglYSIxppBgyZDcvU9
         C2nG3QEOZg4JtMe177hfTXPLp4ZA5s4LT+P/d/a/lVq+/jWkkxX6Rc5NujX4gTIcr6Yc
         7U8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=mZSBW92NTFr6zgidDNXqdeAn5QOK5K70jxrUNd5DnmQ=;
        b=Mc+rpKdks3iWsmYjuoOti8Q4dvGrmZz5Tja9vWhqPICCNnuQxTM1KwuRpNp0BwKuZF
         oum0/RhWJjt4j2mJTCwQaTuJIaXQYXew8YsT9uQ5LKKmhnupIqv8MrdQ3lPGTzNLgUHR
         aAFamc03bi3tB19WjVHIb4xCZ78YevQxC0XwP9tCzXXwUM/dPPaGcn0ExehNxWezHGfd
         Wbam5dgLyOEYYnNGkQ3DM4T1+mVD6AxMseNpQdltVKxi3ScqMCQBbQwZTHYNXW9SkGl4
         zotpAl0KfmS6xaCtNvm7kIJYoMsg7lcAOyFvzdGY7GCoZOQ/dAzE1AIi10iUjabslhmL
         H4fA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PcA0P673;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.102 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PcA0P673;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.102 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 10/17] list_lru: Pass dst_memcg argument to
 memcg_drain_list_lru_node()
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
Date: Fri, 18 May 2018 11:43:24 +0300
Message-ID: <152663300433.5308.6557129799307735921.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0001.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::11) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:sgdIzz05rzvi4KUoHoTTt8v53H1/DavOP8DIh62q/hHmuzeBEJUPkdqUJlAXjCuwj03NZX7yalamALPL4C93dg40qlzV7Dql72Xjri2peFPO1vW8DYt49+wHaRo958nTHLDcxlknOuiB+4WV82xEVKxg1Hzz4Rln5QEEruzefju2CkzmI9epMBeMBW8IjVvlnjNfElzB9hoCwVnrDp7ufi+OXnTVsmgKq2DeY5h7czlkeH9X89Z+qSg+jTZ75m7u;25:uF+4NNIq3cuxgiqLl6thzJSQdQch4AtSkPCKUCrcppFSzoQfW4l7NjTQGp99OK5kKxIJlPthuRsMrDRADk/jJ2yngk7nOenP+RHcTafcqgh0tIlxT8uJe/ORQoOHnV+2GSRkYYEtcRJfcQehChl4jbk9gYLNnBRYHlAZ2svCZobTO+D5D3UALXSUQcaSr70AibiVSdVbrlwpaNgxipKPQs5QDQtvdml7KItmFEMzfwIE5gPQ+TZ/z6WhNcpF2iMASaf7pzB4jhvpzCYK6m6OkZMK0a2TaczEhteSMuBvA9PCjtLYdlk7CUkIhYXqyagsPJug1kcHK5Vc8atDScGDKA==;31:beLovhHZKXpoDe7evrcB9TYHB7hzw9+dWkhYOM0bkMisAFXAfdYQzOC+70bRw2jewT62k/Xud6TmgSLjSm6weo/1x+JG1S22srBN0I5EUVgScQFV1BK+JNcKZIIr+JYWd8Fy4gV1R9DDP6+LFUUzMh7SazxVFU30L72tDxmHaM8/3VJa9ZrGO89GHoHG5UciuFP+ybs7hD4InftnY/jeQUdrAa342tmXbSZSQwXfJ2E=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:u4v/Axz5MEX8HzrbZQZ8iQTMgqpv5rSe8DVSG0m7yTRGgDH0P1vsyHnrhPCmA3QnFS+WLEADApbBE0GCIb9nVSBC7sfo2BCT3M/8e+eHSsq/k8RgsQ6vEDvLIu5cp6KGIzxPkDaekJeub7kHxlUp9QuiQ5oJ1CM3vPRiEZh1n3p+S9TEwn4W/psA63cboYqijpT7jNT6DL0KxmKrqjexAu+bMRi/DUZm0NplSzdUKsy2cxn1nG37Q0JlUGviRRD1fUgRuJ1S0eh8nxmRR562EC5eP2N3L2X1IEiuifXgPeccp/U6+ZqguPsTBVT8Rfjbc7YODyPmQ1M2ilXfnuPAAoc08DDWbsQ1172NOlWraoPCkzgsiPKEOS4JK3B+8NgsibdQWXRZOn5/l8iZl/Omkrp2yoz9ci9TRojZLrP8SeEnNMvaEliLhbho1W7LjZ4YPVc+xb6G2i69KIW9LFnz9SDiVRaXfyEWVOsUPTHoyXFDCLkWyFm17Z4DvUe2HIMq;4:gQpEXFK84gJKDnQZjq1+M356YHt2UIAbgKPWMje2k50V2VPusJMVINY8rbCpPUjl4SNlGRqz+a3shhFEoccNIyjb8sgO5D1CK4/F09QGjXSYDKK1T02BZWw9tK9Vy2pdqOvJC4P4Cuvwh0PteluydOk5jvjBGiINm+exUvLEUVbUoPYEyn2nJq1AVKfd9XRtFbV0PbaiA7rfCnQY7hCMTFI18YOQU949BW9VtfM4bnTHjtOUzA+bV+xbVvuF/gFrGd2HUaze1HNbXSSnVMJURQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13364FFFF6CE3C462AA96421CD900@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(39850400004)(39380400002)(346002)(376002)(189003)(199004)(316002)(25786009)(58126008)(6666003)(6636002)(6116002)(39060400002)(3846002)(53936002)(9686003)(105586002)(106356001)(230700001)(97736004)(55016002)(50466002)(11346002)(23676004)(2486003)(52116002)(7696005)(7736002)(8676002)(81156014)(486006)(81166006)(305945005)(476003)(47776003)(8936002)(956004)(26005)(68736007)(16526019)(186003)(7416002)(76176011)(33896004)(86362001)(2906002)(386003)(59450400001)(478600001)(61506002)(446003)(103116003)(55236004)(6506007)(66066001)(5660300001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6eURZaWovVnpCWWhYdlNBTld4TWh2WFFy?=
 =?utf-8?B?U0tyeDR6ZVJqUUIxdVBvNzVSWVhhcTZpd1h2RXoxU0NVTVdHcER3V1RVS055?=
 =?utf-8?B?bjJNeGdoMHYwbkRValhkd05ITDZxUTRJUlJreHpNdjBDYXNJd1BBVUFZWDBS?=
 =?utf-8?B?dHFXMVFqQ1JHL2hSUTBDUTgrd0d0T1grdE1zaTZBYi9Xd0YwVTdBT0JDNkd0?=
 =?utf-8?B?b1pMY2w1Y1NzRGlOTDlBT2J3L3VOYTNma0lINit1WUVCTXFhbDFVWStqUHNX?=
 =?utf-8?B?dkVRNVJzSk45b2lUdU9JNHhkMnZPb01kdGZFbVlNdTVuSm1JSldVZmFsZU1w?=
 =?utf-8?B?ODhNSUZUQTFXREprQktPQ0VOeFk1K1c3WDYyY3FpTUJSQzd5anluL1BWaHFv?=
 =?utf-8?B?UTJoNW96bHpCQXRzWkZ2WGtXRnZLYlRVOTJtYzJUOTRYdkhRU3NsdWwvZHJt?=
 =?utf-8?B?SzZHRW9pWFMxRWhLZkdRSElSVDlOY1RPREpSTnJwenMvQmpuSFRGT0RSUnhM?=
 =?utf-8?B?Mk55ZDFHSFV4cGs5dGRQRFJxZWJBb0M4THZsKzRQM1ltWHMwZ1BlZW1rWVVD?=
 =?utf-8?B?dmNoV1hxY0NNQ1V6aVpSK2hXcW1OMnNiNkg1cE1meHVFLzJtZk5hOG8zSkJE?=
 =?utf-8?B?YUxHeDZwWmRjMHhHVm1aVzFNMkUzM3Btc21kUkVoSVVyQnBKSXdQOGdiWVVE?=
 =?utf-8?B?YTdKU0taRUIvek9LVU5BSTJSY1E3OXpWRVN5ak1qam5wM3plVzVWMU5PaUZD?=
 =?utf-8?B?OG5LQmFhL1ljUFpyK3hLUmtoREpqSXdxY3J0NWMvbFluVGNLTUJFYldaRGVv?=
 =?utf-8?B?NUJiS2JNNnBSKzNhTktZbElrT2MyQUYzK0dOL081eDFydndxQ1o5WkRaczQz?=
 =?utf-8?B?RGd4NENURVkzWXllYjV5VjdiSUhONm9BNUZDSndEUjVZVVovUGVqNG1CZ2NQ?=
 =?utf-8?B?d0QrVXNkdXVCQVhzcHQ1Yml3eG1qa1pEbmlHUlJRMExROE1LenBvK05jdktD?=
 =?utf-8?B?NEp3RU5ObE9zZjhURDVDNUZ4N0xrYS9IbzY5dzFXSE0zYkJtNDdYZi9VZ0RB?=
 =?utf-8?B?b3h0UW5vS0pHbGJ6VXhLSVZXUEtBb1YydVIxUlkzODAyYi8vcUhxM0J0ZTNu?=
 =?utf-8?B?bnFTOVl6S1JCZlVmOTIzV2E2UlN3SitkSkhZR2NJc2x1TzZjY0dleU9lbGdr?=
 =?utf-8?B?OU1zd1ppZDQ5ZXRtOWZhU0FpdFAxUHJFMnhuMGtadWFLL3l3SWhYamJlWS9y?=
 =?utf-8?B?SEdXU0JlOXhFNGQwNVoyR3hLZXJKUTdPQVcvQktMcWxIUVpaZmpEOTQ0T2R3?=
 =?utf-8?B?V2UvK2F4Y2xZZTluY2NZTVd0TUJqdkw3ejFhd0xyT1lkMUt6T3duQW9XMXgz?=
 =?utf-8?B?S1V5d0F1WEd3NlpIc3VHcEVFclltTUVJUk9HY0UwYmxKbndqUmNBK1RJUzNL?=
 =?utf-8?B?cHNSUHFFb254MnFQVkxKSWRlUWxIMlpVOUVFUzNsN0lwcldaV1loZzRtcEFl?=
 =?utf-8?B?SEpaNmRHYktvVjM4MnI1b0ZJVHlkbVBrSzVkbWtOUFNETUZ0eHY0aGNRRHUw?=
 =?utf-8?B?cHZpUEhSTFRWVUNZYy9sSkgyRUUxb0JFL05FNFZ4UFZkZ0VpL25wZjBoOW5j?=
 =?utf-8?B?Y3Vhekl2L2Fqdk9RUVp4TFZsRXIwWFdERmhQU3VjbTQ3QmF2Ky9QR0xITFJ3?=
 =?utf-8?B?dWNWb0p3RFM1d2NDdzFuR0l0NTZLa0Rvdy80QXdmeWIxT09LT1FEN3RFZ3cw?=
 =?utf-8?B?bDJIUzN1b2VRUG43Y0phaDg1MFBKYURqY1J0RUlFbTU1S3kyQkFwZnhXakNU?=
 =?utf-8?B?NmVIc1NkM2ZsVk5jK1Zoa1ZNUnpuS1ZEdkJ5aEpTYlc5cERyZz09?=
X-Microsoft-Antispam-Message-Info: guL2rIWnoG/w5zi0LBj7aaWdPcIruAERM+obOpxhf9PcFzCtql24EMDPDOFfFfDL72VFhRHAZAfSfIBh2rdgBSZWlSbduspH8cU1y3vlGU2IA/+w/QmrfjTy8P/kFWRtFTMd5LyeVnZrP1fvR42CWOCLerpZvq7JLZs1err5IF3Q2Ayoow237gWRXpnmxV6P
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:viByuJSldvnK97JSmzUB4Z8wEmVZ3Ss9zZ74qX/6hXsW4/MVJiB1NTnpLUZXqs2M84Fh1PiTMRPsmHg3VUq+FN9V4oX+Y1kyviFehm7n0YEcz0NLqraRmquHbFHDK3lKNVrEBu+7+b4PGH4IIDbyzgt+8tlGOnYWLti49YCwldVvsmO/8m+v5s0pvJQb2Csnn11hNnh4ufcnphULyNHzvSUmPj4r1BZXze62jHnbPN+CHJrBOQhXeNUqh8sRI1TmTIE2Mz76SSWlSCVrfJyxoMRLPyrWnt8OMSBo0f3acAovdn7BnoLG18+I/EynuyDiEVElR6fxhfeqwCnKqHzIRviBnEdVSkHL25mudp+HPpOi2TIAmtFLo/r4o2Ptcs3hFfKvj9VmsR9y8z5LigGG0u0XCrHQAzwlZX5UNaBCayIFOQn7t9D8KaMLiBwZBK7VOp0Wt1JcqDfM3KhwC5aCZg==;5:tiEs55ZcFjQv4GTOnzuf580YJ/ajzlI4I/EvWRrdA3CpD4pzPXkgE5nA2AgGdlj6KIg6rg+dmqTLJhIhCwf0MkjUWy0CC3jk/tY/Htedq8WNP+7fUbFbMnEO3KH3eR3psVMjjzXgQy92wN9cY+UvxMnKua27A7z/imeYRHLgvgk=;24:jYSxYUfQqVja+H+eKosO0nK9lvaj7xzD2MZkADF8UmV1gkS7s84u228sXamX8/z8FDBEeU9gRWYiGYFfsZb8n/ok2IDF+/IG/Loj6NWXMRk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:Ej9JtHlzDLOh2txBM6hAHwP6pVo0izWDZ5mrHSFEGaU6eCO/v1bddtC1N0Gh4gwHAwokLcxK1zjE9AjodIpUcPSM3FDXVswSb0/InrEw6sBZhktKELCsec6FrS7atxM0rhUbPMtA6xiBBKwIQ6b/optomLTO/yytzpaaXBzAV3yX1/F6gsyCjInsr9PVGvDbpV/FXr9tlegVFE2VlJvo6VjdTyk1FGV/KBoHfboS4rtrfi94GqyayVSpFyyiwz3j;20:f6CTOJ3TEvaV4fmKZIyJMs56KI8dAD0Sv2HKEWR6SNU9H7kxk5a7V7nJ6kRPIx8gMz4K1ddCREJ7bks7VxQvminRDp9qL2g7nxNEL0jt+Hz31x8Y0luPEZeer4mj1tfuYDkBF1c6sA7twcUJ35zPeIJaxVXTCLBOjcHGTNXcpGk=
X-MS-Office365-Filtering-Correlation-Id: 7b6c141e-1a63-4e2f-b7e9-08d5bc9b6def
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:43:27.2547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6c141e-1a63-4e2f-b7e9-08d5bc9b6def
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790737343985176?=
X-GMAIL-MSGID: =?utf-8?q?1600790737343985176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
dst_memcg pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/list_lru.h |    2 +-
 mm/list_lru.c            |   11 ++++++-----
 mm/memcontrol.c          |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 9e75bb33766b..d9c16f2f2f00 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -69,7 +69,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 151fa77eb7c9..43cbec52a48a 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -515,8 +515,9 @@ int memcg_update_all_list_lrus(int new_size)
 }
 
 static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
-				      int src_idx, int dst_idx)
+				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
 	/*
@@ -536,7 +537,7 @@ static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
 }
 
 static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, int dst_idx)
+				 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
@@ -544,16 +545,16 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_idx);
+		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
 }
 
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx)
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru *lru;
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_idx);
+		memcg_drain_list_lru(lru, src_idx, dst_memcg);
 	mutex_unlock(&list_lrus_mutex);
 }
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 317a72137b95..8afabac77b86 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3187,7 +3187,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	}
 	rcu_read_unlock();
 
-	memcg_drain_all_list_lrus(kmemcg_id, parent->kmemcg_id);
+	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
