Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeCNLv5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:51:57 -0400
Received: from mail-ve1eur01on0125.outbound.protection.outlook.com ([104.47.1.125]:49332
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751353AbeCNLvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:51:55 -0400
Subject: [PATCH] percpu: Allow to kill tasks doing pcpu_alloc() and waiting
 for pcpu_balance_workfn()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2018 14:51:48 +0300
Message-ID: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:4:29::31) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0215dda9-a927-493e-6ead-08d589a1fa55
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:t1IOgEWnpLkj7eFt90kmCYNiZRr7wxZ4LDz6nZ6paL/lvdku8gFgO2WFug1N+8v+bJC18PIlVDQtB9VSIjm5PRN+XqJEC6apuakdUD+G813NAbgnp7Gv6cQ1wzqrxhd3pYZrzYMSvAV5nxtZkFUVxoo7LH4KYmhgsEhw0Dqc6EACFuo9Hjt/mxQr5OmGpxr5/JExwZC7aNTs8gLCpFeLBWQiTxUmOJfJom3OxRfgWsWWW+mwebASPMKCbSexiHwt;25:P41mZduphXkgxcuv8AvV/9p6wxhzzgzQGdHLVqfXjodIhGWd/I9fZ5s21bH7kZA58SKLjzpqAvex4BZcNxToklDRkx0ZIuJqxL9pEwc3bH+Nq4NMfY9cylRGLVW4hQjxW5nSiolbjwHpmjGDj+HyB4db2Y0n9AiH4ueliEA/gJ2JmbrlI8I1YdgcvB7rwRX+DVLDpAZ1gdt/ODYfAafMBI7YESmz+K1VdVLpkYRV6HndRznnxVG5dRRyZRBV5i8AmnUA1NL2YvE+mP8pW49NA2SVvVaqsMmsmoEPEqB6zs4ZHt6GPswyA9vdLgU9crd32jU/jVhza5jBJb2GeGFUTQ==;31:ekLA7SVPFQ2zWlpq9zduDO9iMNqnix26PyHdSqs8sn2A8i94NNZMsIu5BmbWZEUN/AA8f512/hXE/gDjqtl6qm5JljDh5yDN3uIdzfHtSRtQ6fIeO0e1GGuvpkXEObdXcfGCKIWVCYhwkt9E2hjpx9UMJ2wZnmz5OZSBz02U/HXXOVhQC3AE6r3mSUYGzP9zpZnP7V9KMoJIY9yUpvZ8bC8zaIo8Adqg0tj0VvG7Ksw=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:ars3fjOpqZ1dDZ5N45YGzlxoEajq9mPkzsPcB2HFGHnLN9NintMSmrph0yMPt/Ns9CNXiYzFFfd9BqAJ6sjO+YfwTrE+EkW8Ir/Fy77xf36pqqDC+PRspU4NHRG4IUhxkz//KFb1+D2P+/s0eSIuV63H6k7niJ7F6iRksHRyRabWDvlNFSdVq4dcWdwyDkPONHOlphW/qmzaf2RRlEC/8cwj6Tm+oK7T/7DBP86HFmiiD9GYCtJvTnBqc80JDTQW6K3fw2acYQaaktUrogl5b584pOHNgydmSHyUjGeF8ZCkZCy34KNRRp0fNX/gpsHOB54aqCNsSuTe72mcOiGMvR/dM96h4ZbvfAjAnI9j9fj99bO9Uxe1GFu/EDqXSJ/BjMMg3DzLTxIxVUpUy5Accw3pcfVgUZ98HAmMNrUFhK+lGIsIe9KmtT71L3PsXcZ1oxvVHZ+Hd5PDYQrNlz2J3khsT5O0A+1HyDmnPHsYAPU1HP83WW/8hk7g3LP/Y6l9;4:IkqTUZ2qXpMLmJtfaPOSlPd6nD5uQ/euQoAvnfx7oYgTfczSq91RurYeWnZgZ8exsizIIgjuJ0yct8H0zlxtkz/LvnAhTyChNuM2jmLDCvXLTQyUWtatH7ubAtKTSHo5KNj/O1quOLM6X/IG6ky9d1c0CHupgkcel7cjO95Dhvb4qukPx9F/OJfK+99MIWD1fqZQCF+MrutqHtRCZgtgTF0I6lxUghybwFoxicwvTuiq5rmyBZIdGK6eSYv5I0TLxL0QxZbfGzGkI1mdXGsCyA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13391BB3CFCFDFB57A8CC3D8CDD10@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(39850400004)(366004)(39380400002)(396003)(346002)(199004)(189003)(478600001)(52116002)(230700001)(316002)(86362001)(105586002)(61506002)(33896004)(53936002)(58126008)(7696005)(1857600001)(55016002)(9686003)(23676004)(2486003)(26005)(106356001)(97736004)(103116003)(6666003)(16526019)(68736007)(186003)(25786009)(6116002)(3846002)(59450400001)(6506007)(386003)(5660300001)(7736002)(305945005)(55236004)(47776003)(66066001)(2906002)(50466002)(8936002)(81166006)(81156014)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6SnpyZTFreHdkVzRNNWtZZHlVU3k4cFJB?=
 =?utf-8?B?MWoyQ0ZYZm54ak0yV3ZkU0RFUHJTWmlnMTYrV2dzallKWjVsQXV2QjliWFBR?=
 =?utf-8?B?cEpGcHlqMS9wSS9XUzdHZmJ4cTJoTE43SnRlUEdSWE52ZTdhbXE0aklHSDBl?=
 =?utf-8?B?ejgyTlEzZHI3K1VkR2VESDYxSFV1Q3VsbmMzR2ZBTG93NDN4K1k2allxVEdt?=
 =?utf-8?B?d0FHTFcrU1dCakF6ZGtCbGhjOXpxWFF5Y2NGb2VkbGNOcGJYRlJoVW5rZ0pp?=
 =?utf-8?B?QTVCN3k2aGp2cjB0WmhtWlFQcjVqaDZWb3VUOGFya1g5NGFDbEx0NS9vb3lv?=
 =?utf-8?B?amdWZFVYN3lPZyt5enVKRm9QSEFqR2FjMUNNWnpZUThJbkZIV0pZT25PQVpv?=
 =?utf-8?B?dEJwWmNjUmUreXo1NFVmNjRrM1VONVB0L2QxelNjbUFhN2V4eW9aY0xVQlc5?=
 =?utf-8?B?NVkzZkg0ZUNDancvWXByeWVQV3hlNHdHSmliMVhqUkNScG9XTEhIY0NJanhv?=
 =?utf-8?B?VE9JVHBycXk0VThXaU5JWncvQXZXcW91Qm1hL0xpWTZMbE5zZWErRW5oVm1E?=
 =?utf-8?B?TlpJK1JmN2lvNE92eWtNTzhUOFg0dndveE9jWHV0QjB4TGdOdGVPQnV0N1Rt?=
 =?utf-8?B?NVIrVzJ2bGNaVFVUVFVKZ0hUN0RQZ0lYQ0wvMk9QN2E0TEVESmFuMVM0U2NB?=
 =?utf-8?B?ZFFMV2dadzh5cVl5Y2R1RVBicE12dXVUUjdsRHZtWWRsOGJabHVuVWNrUWJH?=
 =?utf-8?B?ckhqLy91bHBwRHFQSFNsUVdSN3c1S2FXMkJDb2Q3ZFppdmJpdTY5YisvQmdr?=
 =?utf-8?B?RkF6WFN6RnRvY0xYZ3RKZkRYV09MVzBTYlp2bkFvV3VROXZEeGdQVHhONFMx?=
 =?utf-8?B?d1MvREFZTGVSbHVYckcyYWdWeFpUVkJIYVdqc2ZNRENNdExzOTJTc2tJQmJZ?=
 =?utf-8?B?T1QvY2RVSUpBTEI4UDZIeUozQk14TldwejRVbWlSRStSUFN0NHArYmJOUFV6?=
 =?utf-8?B?cjhYNGQxbjZKNGpFOVVteEYwSWNYaTJNai9hSDA2NEROcEMyWmpLcWdzN1ZF?=
 =?utf-8?B?MWp6OVJRMjZGdTJUV3RsVm9MNVBEcXM3RlFJdVRPbWJBMU5MR1BNeko1cUY1?=
 =?utf-8?B?OXVpWmk1VHRmVjhMN1k2YzIwMWdhVStGYk5rS0x3eTZBUU5MZWtySWtKdW1O?=
 =?utf-8?B?YmM4Rytuc3ZvaHRKRmdPVnBwcmlaS2MrTmlNUTA1Z2xKZEE2RVk2VjBJWmFt?=
 =?utf-8?B?Rm1tWFdZTUd0TWltVjUwYWkwRERDM2YvWWdNaFduM1dHc2s2TTBTZDA5MmZF?=
 =?utf-8?B?T2JSelpFKzZjY0MwMllVVTVuRGpUUnBQN3k0YXlhSUpodzUzTnF6akEweG1T?=
 =?utf-8?B?Y3BRNlhaY0prVDNWQ3Z3aGhCN2ZRV2wvblhScnhab3lKa0dMM1F1NVh6WkJt?=
 =?utf-8?B?SG9qUUgvaXVoVW1XV1hMbTR6cXJGU2RFekdTYmJrL3ZBbUQ5QlkyVk1yU2Mr?=
 =?utf-8?B?Umd4MlNjWTNoRkJYVW5DVWVidHVIWXBudFp6Umx6MThqTW82MkV6MkRVUUdx?=
 =?utf-8?B?cU9MYk10VVo2SFpVdUlVQUNEeW1PbFExdz09?=
X-Microsoft-Antispam-Message-Info: vQ0wkrBjJZJZfovGxqMRjhuos0SMsF1VB3gB+TAI1LN9p7zhQNvA/Zinch7Aw0xvwBtc1AjlA3gU1qQayIB1hIA+xecwrEMi+KY+BQEX7yX7bPDE/DG2y0XFX+G5DsPRa9ZmATJ+qVk5C7w1PF8d9Qja8fVjAKgk/UOFnVd7V5D0AtijhEtaqFH3SkPV7KeW
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:VaFV3msyLL8fxQbaP0r1EAaL4Nr1tXs11cRTAEcLR6TymKKOlShmEnwUuZFrbU516f6/9k9kT3EYG1sGfhdn+GX8GTbXIoauv0t2JgzrPqoAc/e3DQRRFvdtKUcbYALnVNgOySwqWfmkxOjo69vrd383ljX/MpoFwUw3+UUho7jV3zC+iJQ755Nc2cw889uj+yONI5qe0qE+cA7aCi4P+3AFWcPOo5kZt45Ypm66H8XRzHnex/dVuNu9XcVVTJE7k5awD1rqLxE2Q7xDb1tY79lss7b2qDbysmP+g3/QtnHjY+TJxKdwiCKZ7bndAcInFryG0W2nn81g4VEonnK6kloI3olYMdNbkLZr3KfxSfs=;5:KEcEXEw6VLD2KtVXW5M955ZAhsHpzCNAlzDQyYw14o6NkF5g88ii6I3UsHAkmFdOvJ8VhefD5jGYKg6GIUYtUkXMow2kANTPeAKnoQ08qP7d/JqoL2OaYb151mGK4xGoxxLW+SJ4Fp3JbjWDnCvXJ4hJEYUQEd2AXON/vU/VM88=;24:MsxQlGqPcR7XbqaQePwsJbJE1SRGv7Tbih8+8QPJ2OrCzP33XiUYYhTH+JxJe+//We7QsOJ+aVxfLWdftfLWn8Wt9ZQNxo8Z5AK3G6ofDB0=;7:GQCdvd+dtz0JvRvWHpp5bcyNnmsMgvIcN9lfKorVdvHqxlHVil3PAp2EoHWWFG0z+r2CNlSZ9RKL7MHQ3c6vyI95WffTDTH+siaXSK4Vm/pSoB2/k4V6s605HpSeqASrMBVu6fKR2XK0Mk5oSccBgLDZqEgPyUCsikwoYbQ6l4PlnDAM/txWKhRm12tcux/hRalHEHQ40sQpocqZnj27Yngv2xYoYKGuG3wvTSfLJzxBPrE4QwmuHQXTiu2jLVi4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:OOA3kIjQUhUMVA657/RFM6D0yOo3sHoN/ksj8LXt9FayF+6UeuT2Gg5D0wEsAXDA8v/0swMsCnLje2FRauru7yIFgQyj/g6k61hVYmnk6kezxCXAZfkFOk2q2v2AINVvBlxh3jJboF1qRZ6gTdQ3ZeEZ5oe63KlilN90eYbfK20=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 11:51:51.8092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0215dda9-a927-493e-6ead-08d589a1fa55
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of memory deficit and low percpu memory pages,
pcpu_balance_workfn() takes pcpu_alloc_mutex for a long
time (as it makes memory allocations itself and waits
for memory reclaim). If tasks doing pcpu_alloc() are
choosen by OOM killer, they can't exit, because they
are waiting for the mutex.

The patch makes pcpu_alloc() to care about killing signal
and use mutex_lock_killable(), when it's allowed by GFP
flags. This guarantees, a task does not miss SIGKILL
from OOM killer.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/percpu.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 50e7fdf84055..212b4988926c 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1369,8 +1369,12 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 		return NULL;
 	}
 
-	if (!is_atomic)
-		mutex_lock(&pcpu_alloc_mutex);
+	if (!is_atomic) {
+		if (gfp & __GFP_NOFAIL)
+			mutex_lock(&pcpu_alloc_mutex);
+		else if (mutex_lock_killable(&pcpu_alloc_mutex))
+			return NULL;
+	}
 
 	spin_lock_irqsave(&pcpu_lock, flags);
 
