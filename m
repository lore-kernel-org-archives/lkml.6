Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrvkbs/rJqM7uTf6ABoGtHBHEvrchGp1VPZ7tnJX+KgZ7qi/x7lj4uW/2qFbUWQ4WwMe1L/
ARC-Seal: i=1; a=rsa-sha256; t=1526632973; cv=none;
        d=google.com; s=arc-20160816;
        b=KWLU8b+1iVAbROSjxHuYHSs4ZsRXrXVKX3WG6FSM6L0l2EpNnxDdQRnmcif+7s/Nl1
         2KcapZbbaYgpP6YpFUNMco5WFQUqkWCMg+hdt36/ENFCRUhROgwgGcHyg6Z40bSD10wS
         7fjZFaIjiDa1MBzqWrtC4raN2MlB/0rIqPXpMA0F80mqAcu2DmBLGNk9wlndFdfzQLxm
         e2/njOg969aCO4aU/ipmQPSjay4IsQVKbEZWFgQmVthV3l9UQpzRKgG46y0bedqomQCQ
         f4V9sxxrp6sZjU3PyKzyWCnFzHvoVu2Zqn3DU6kXJbjTDjfeq7WJzu1b/nugsR4PYFsA
         gG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=6Lv+JfRhmpiB11xmNRi/HUFuAWVUELXj+iX52Hpqp+Q=;
        b=zk4yKUZFkNZZgIZgyoVNYqUCPDFFgMOfdv/IaoVnvHhdpQNV74I0HP9s/NMeEHr6wl
         ZcBGfvYtYepwNZdgZmUXpbXgRankNzRVMKGBEM3bPRiz4KQuAY+1acV/I/aJuXHcl2ac
         jUAn56ipGjDXRroTLqxel+RgCzf0ge32em2trE8vpfYCDLbOiloTAVuKCq8lt63TTGjo
         yCoxlHr7uGiBC0KrvKahjH7f7BSk1FCHq5rxdUuSiZCxowbZ2XMT9AUGYMz9QUgtv3rR
         O27QtgMQS3Dr7t/MnW57jK+tnbalrbDLfYbBDYt05R9CI04CZbgds32JfjbMcmOsnWaT
         tlvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=AI5oKwOA;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.117 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=AI5oKwOA;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.117 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v6 06/17] mm: Refactoring in workingset_init()
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
Date: Fri, 18 May 2018 11:42:47 +0300
Message-ID: <152663296742.5308.2135909277633884465.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0239.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::15) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:I71gx8C0SUyS8xnCBBh49Aoku+Aql+/GDPNWBjN6L82A4M1yeI9ImmYWm0P8+pEQvaOpSNie0b2NeQWUxHJE8+QjTs4fmMxDV+WChvRbcWbXKsvl+dGV4/BJ38FsnAYmwm3vWHzbYj6hYRwurdFCAbQZ4eiccbFOFxp7rf0XrJB5YG6H2ysIKmw0OtZ+J+PzzSI62okCCGySXvs880Yo4Np0dqmAzm90M3ipPO2SBZRn7c+GS5wppQMBylLwLlDh;25:YMD46cV+N3vJph8spnzogxAqF5NVb/lIzxAayhm6ynhNv2OZN9esDMOn9NbasfgnMQcbJDz0n7GCRCfKAxbwkR2r8e5AWDz3IyZJnNPa6ylxfvMmL5ugxyNHCov0AnwhbkE7Lrr0vyKMzNwCDNP7uyH4Q05VuBR9dzbwj3zCDL/sCxh6mDwRR7CtVjDWUR8rmm6fNZv2Nl38u69udEGaCwK/L8kmoh/rfWlzOdDnItwQ1Ivu70GaAu/Ao/5qx6LKuQmyISzkRI92DtuzbG6F1wgAW1+5SmHj+FTTIoLotx6OLcbW2jfNgCw9UzOds41jk9QJARMZGG5N6HWOV7PohA==;31:ecgsmX/J5HziBJ8rPxqeRxLCBal4gSqoKnQsHYbMmkqbNB0FFe3xAsLA5G8Inq84XD9N/3xjITGc4k5Fwkznn6jrOtqKyK9LxN7By+gpD9MGy3nP5xlPQJGjFJ9pIWAf6rysZ7CHSBk+JNxB8WndyEFdcROgkhQG4BIuyBheXllhLqNaGhzo9OHRXeGqp4cTJnlixb/io5sjsUtStoKFxaWI7zi0NU5qegnr9RZsmYM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:YiL4cve9Fbqlc4oD3MhGzwq81f/4WVtPdh53PQGzKpvXF4WNS4Surn24s9cqTKaL+FecGU2tubM9Y6+8/kUO7I+Ll967pHsNcRnu4i1MVOZPZAG3qtOLxwB/DfJruRWX8e6nondPSri+xr98vI9YmnkNnW7nhFI/lLV0AXsvioc2x/DEqJ9JNzDMjGtxfppZmpVXHYJuECleMz+E5Sgyt5x7ndcF7VddlC/TOofGz7gPoOwkFYR9rKMcAugO+QDBo3GvFooPjG0Em84iYDXA5MfuecI7ew40ykd3iLLGtbZe/xYIfXLd/kZ5DDvHiEVX9WCsaeDL7UnCi6yj0Hgn6Fq9Phz7iKUBvmV7qxs0Z05h7CkwmgiZVpZPQjojIYcQyFy+K8yY+XjmS1mpDbnTrJIikuUjrtn/4i17A4ndFWeYqBFkRRNZaEehoc+QPsEKvIev8V3hbQuiZbkT2gFQKWvtX08IHHPXhCJwtA9FydVCqSDHjO98BV3jeMzALcSF;4:N6obrZQ3ANi9JxtvSxUw/YcAA09NNqMFqMXx3us8kJqBu9v47u+HRa3/jLwu1G02t88TlvSUXMx/TYLiKa+LrtbfpcWsQSvB0tUb+PgB30Lbjz13IyxDVTWfWrWtoOh77PcDgI2mbJEy0CHfH4Kwh68ulIg5P3DMgPWhfoCuxBuWe+TaVmmSbpU+5u+ZzpBgjcIqJMNu97M42T7kbcu3n2JjEADd6TkjOmAQI13hwDnfeYrJxPbLTa4N+rGZInav1QKVRovY8nWB+MnBKcvJag==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1339C9D75EC65B99AFA47914CD900@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(39850400004)(396003)(39380400002)(189003)(199004)(230700001)(97736004)(386003)(6636002)(6506007)(316002)(58126008)(16526019)(103116003)(7416002)(5660300001)(186003)(105586002)(106356001)(52116002)(7696005)(2906002)(55236004)(8676002)(81166006)(81156014)(68736007)(47776003)(53936002)(8936002)(86362001)(76176011)(59450400001)(39060400002)(25786009)(23676004)(33896004)(7736002)(26005)(478600001)(66066001)(2486003)(956004)(446003)(476003)(50466002)(486006)(55016002)(305945005)(61506002)(3846002)(6116002)(9686003)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6R1E1bnZCSUpkcmNHNElzV1cxQWR1Uy9H?=
 =?utf-8?B?SVFJMXRUdm10ZytzOG1FSDd1Nkc1eGplWDJFWlgwSWxYKy85ZjYxbkp4SEor?=
 =?utf-8?B?SjMrWnhpRnFrWXNHM0tndGc3S240L2VLZVRqOU9Ua0dtMms4am1zRmVHdy9O?=
 =?utf-8?B?c1hJTEM0eS83Q1FYMTlWaVpQcGwzS1NzL2dORGhTbFM2dkgwbG5nUEFZY1cv?=
 =?utf-8?B?RTZxeG9ZUHUvTzlCdEV6SGdIRE1tZDdvL25RVUZyeWozTWtCZ3B2bzlmZ0Vi?=
 =?utf-8?B?UVNSTHE3dzQ1RmtuOUFEOTZhMTFnbnhSSHp2bzlmYXg0Si9iOFpndTZBSXBV?=
 =?utf-8?B?Rld1L1BPTEhucGlYWVBKdy9nVUxWem9SRHprTkx2K2dnMHBvVlRKcE1vejdL?=
 =?utf-8?B?cDJITjJpdm9VUmhZdDhFbklmNm93c3o2Z1cvaGZERzNkNXVDUDBSN2NFc2Q5?=
 =?utf-8?B?WDJabll5UjZONlIyeFE4MEZ4aGZtdTdrb29QcjkwOGowYzZlaWZXK3kzTHgy?=
 =?utf-8?B?R2VZVjZkSmxzcFY0azhjNEdTL29qYWttTWJZVjV6ZEo3a0dSR3A0ZjFVM1Q0?=
 =?utf-8?B?Tk9Dd1VXY0djNnNLZnZnWWo0elBsVUFKOFFmZHl3TXRKbjFHZWNtWWtQTEZL?=
 =?utf-8?B?TjVTTHF1RUt3YlZSTlFFYTFQT2Y2UTFoU2J1VDBobjAyYjBCR0ttY251d3hu?=
 =?utf-8?B?NTR5c0tHZlNhRWdmSkt3SDMvK081WGJaNU1NOUpPVDFNbm9tVnVuU1NZYnpN?=
 =?utf-8?B?bTM5L0JUdEFGQjErYzd1Y2JwdXpibmxuWXlsYTV4dW5icXJucENRalFLQlFs?=
 =?utf-8?B?WSsxR0pnUFdxUkZJS2g4SDVjd05qbk5iYk5yZ1hLU3dOMUllaXV0YjNsOHBx?=
 =?utf-8?B?ckhKOGZNUXFTNEtxQnkwbk9GdTJrOWJlSVpNS285c0NFazZZM0h6MnZKVTcz?=
 =?utf-8?B?YUtaa1dTN3JkeW9lTnA0UGxkUUh4dnpnbTl0TUc3OEUyTVd0YWdTcm85eG5X?=
 =?utf-8?B?YVhCTHhTR2t6ekMrQXQwc2hIdElrZU4rL3FUOWJZVUFiYndnT0t6akp3NURR?=
 =?utf-8?B?dXY3U2lkMjJtTWtJVkdEYm40SWVvSGY0WmRaM0J1UzBVTzJnV0ZBZ3pqUmNP?=
 =?utf-8?B?VzhLYUVGRXNRZW81ZGFIZEEzTUt0RVp4NHdMVnBEWXYxdkdRYkIwQ0w1dm9v?=
 =?utf-8?B?WDNRdTB4cjdlbjNLa1VuTmFDV2dITk1RQTVMazdwbHVNc1NMK2RUV2tjOTN1?=
 =?utf-8?B?Y291MVI5MnE2MlNZVW94QzdpajE4UzBKTXRmQnVJUXoySzU1eXZ5dE9lbFFG?=
 =?utf-8?B?UFcyS25TVWdseW5xbzJpTWw3MEs0VWgyaFhQZmJ3UzNHZ0R4WGFrdDBLOGg5?=
 =?utf-8?B?aEJCVm05ZFh1aXBEMDhtY1NGWG5RcWhTNGhWRGNQYnY1L2hzMzJRa2dsclQy?=
 =?utf-8?B?U1M1VG5HbU9rRzBzd2R4SzNEdWQ4d2U1WXVxK3VVWFRmVXJXRnFEN3IyYWJm?=
 =?utf-8?B?WGUyZkR1MkRLSVZkTnNST1hMbjVNM0dSaFBneUI5UDRWaEhlUDVYSkEvOUl6?=
 =?utf-8?B?dTNLamI0TXFwdzBNYnV6QS90Q05EdVlITUphdUFZSDVBQlR5TXN0dnExLzBt?=
 =?utf-8?B?eGJnWjNPekFMa1hBWTZQRmF3VDcwTndiazFaVk1FVXpEVzNmdlFLZFVIM1JJ?=
 =?utf-8?B?a2RYWjVaK09VTjBzUXY2R2ZYMzB4dVUwTzlPYlc2SVlsNzhCdHBRRVBpYWZv?=
 =?utf-8?B?QlQ5VTg5YjBTM2NiZ1E5QXlkTWM3YnRJajJtUk5LRWhKdU9iODV5NE9sSEZV?=
 =?utf-8?Q?3QXsDwNewmP9T/Y?=
X-Microsoft-Antispam-Message-Info: 7QuGZY0BPavd+e8IWvYAHHs+0F8olC8CY+jx6G+oten0ZqGg2ecpwS0GXazNrAF/T/5AuWeXZIc9fo+1JuVovsa8ibTKV+UoEStkgv3V1sZAkrOwfzc1mxdFmeYktVtLd/kUbL3rcmBK32n7TE/ZsH65GcsWGhgH6lJ9vaIcu8GF62DW3wXg6yFvjNqoBqF+
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:eaQp2ZqnJOEQBJgE5Z7fMTLcI+DNUCPb7MIJDXNyAgiKfkfFcPHeiVX/OuRbrBv6f++0mkH2iDHvoko4K4I0jMDFESBP6Jlxv3yjERurmGvjgY1p0DBKTdj8fUfqZRF8ApNFZxAcjYPWdslDA9Jg+KYQ7mkD/i55TIw1pspseW9HLtJF+R+qWkK8yiDxJ3em9wMckcCc+5Pa5Cr3qvQnStX/wicwtfSts2lgyzZoIiKeSx2hOkJWDPdpNb86Q0Y325TVP5qCKiD4Ox09pntLy1Jeocc4R/puRXXPkBf+2DKIZ22F44u8UTwpP2GtFLybHBGIvn6rzXrfME0J1SDg8EjL1T4MD+pr9yIQ5yRjfP2DJR4Z7qLQHUPnp+oVR0E44FIYP8ljopTHlY8uOSGDAju73NBAxn0kTLoSYX7zav6y5uer7GHBuR3BA03fsxiQC8SYfN/96PlleMZDoMEW0A==;5:Okfx1VODLcXuvQYpCfztTtuGBchLaDq8Q4STt/JZZJxFptkoeN4h7EIauAdXz9F/CGb6K9dpPBfHyxvWwKzmNmEWCBw/oVgiLk/yI4V2vvmPhjUrY1kxUbU+A+eb8wtV9c88Tusb3xq7ihM6o7J8UB3xvI8xOTEcM4T+/pUMudo=;24:nB2egnPLmKRE+ObtvN7QKFChCH4JjAX3Ih6GbrDLCER4eRHZDLi++ffBlZkv0yipMfEzyDkgUCH7OV0d+m1Xgijg/oCNjtL4uvRJQQBoAWE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:TU6oZiFzNN5Pfay9qsD7FzXBdGIi1MOuzbAe80MDJyYfRjHZ/bkNgEzRrZyMSNWuXZJ7Zj55BgEifMz4KErJ4AxIq65XhqI/Cka0AXjbyskL9NcB+649X4D4Vi0j9HlDGe1pHaKE/Lc1GY9XiSrfR7LBeMDgyrmxSbyJ2BDCgeWiMsabvsFjDP/a2BncVeKMc+h4JTDnVRALXTfspmqOTjEQI52bMJbS7ABmHXvnhakLpjpGy6oVs5RCyYnIAYHO;20:dFFGR2u6+btCJf7TYUe/ancoz8vPFhkWpQbJf6lErJzEn78GZywBzhVGhwDgGLGKFn/35SnafHq6gvhHuGIKGnCDf2ysowLRmGiTnEi6kR0h2UiawskBra1YtCsYeVWKV358WOf0s0GkBqcLSIepk/qX8MJXrhvefYol5HnJvNM=
X-MS-Office365-Filtering-Correlation-Id: 17afc771-eaa4-42d7-eb06-08d5bc9b56cc
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:42:49.6578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17afc771-eaa4-42d7-eb06-08d5bc9b56cc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790696266310280?=
X-GMAIL-MSGID: =?utf-8?q?1600790696266310280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use prealloc_shrinker()/register_shrinker_prepared()
instead of register_shrinker(). This will be used
in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/workingset.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 40ee02c83978..c3a4fe145bb7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -528,15 +528,16 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
+	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = register_shrinker(&workingset_shadow_shrinker);
+	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
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
