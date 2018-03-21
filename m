Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELvZEQs0s6Na3YuiFXmn2NmmMWQMz43aasGFJhJN8QE/vxF5KNdbcNSWe0/cVt+1bcgzea3k
ARC-Seal: i=1; a=rsa-sha256; t=1521638487; cv=none;
        d=google.com; s=arc-20160816;
        b=DsPly2uGx024CARIOXGXXndZB+GntnS875+l29wW1ydP4LQogZwIxi+DnCDB5Gt7Pa
         W9yrb9VpsK/FMb5gHSmtcp9aciP26VBzN5uhquvTzjjyTNdyGydg7JVK6REaQlA1ER89
         YAIjeLu/N5Tej9VfclLyuIRM33oP+z2/9nDakHict3o4G4+Yz/BNIgKtH6opbldTa5EX
         sp4SCWZCbuLpnOuYTEffgg7lSWqxMbYXRFg0TvJSQLPg3brh9JxJ3kz5YtLE0HSgcdb0
         A6l2AC6zbHUJDrOAMB2W34o7P//5Vh1RtfRsxvB8/Y+vpkfIxM1HbsuYoJTjTKq6IZe0
         5ljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=cobVhDqCOW8PifQqTFxo7nQ9f+hE+wpV/7uv7sV20Lk=;
        b=H32EB2aD9MulIfd8NYhVK0K4j/3XcIqfnFRXkQgdhsWhDdMGfu8sCAg8Jg2L1l+YY6
         bDdODekKRK0RDizpMjUEOk+UzvqR+bT7dSWBPtANiL8/ToV1CJOqFvIA1BaVfRAURqqd
         DYwGN+beyT/YmxT6PNKVecQSkg52+vjz0C2OHAWvDX5PJpc5aYgTljshUcSpJAL6zpn8
         VQutdYrZyemep95U6Eafx02ndHxYSrZycOX4CrAT6T/C6uCaZ6YdZo3xiu3mDTXxT9Nb
         ivb0eLAK0iHXVc0eFTK9sI9p4AF5o0naJ8KO9FKSf9Y8wC/n+A8keuRNbxdAp6qrmzXJ
         NjbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=WTV1ol25;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=WTV1ol25;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 01/10] mm: Assign id to every memcg-aware shrinker
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com, ktkhai@virtuozzo.com, akpm@linux-foundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
 gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
 mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, shakeelb@google.com,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org
Date: Wed, 21 Mar 2018 16:21:17 +0300
Message-ID: <152163847740.21546.16821490541519326725.stgit@localhost.localdomain>
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6P193CA0004.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::14)
 To HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44fa8977-7609-476f-421f-08d58f2ea520
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:qHj4kNtmb7ZxLpnAGH6/nRhSyYl6kSnvTVTXDeT/qmn2A9V2RoGogFxrLQ3fKfSV6npLOdCWjb3XUv/UlFWxjcwjtXWXnO+qLoVADWAgJaLGlGpvPExhB3zFOCKEYMsspV6P8HI/yTQBnDHvtS+MsHLm8zWoORhgz0Ef4Gs5d1DkrvNPNbg0aMTTCgHKfEyQbdweYIbUQV9PrBbcS8MXu+TT/3/sqICyTwklL42B3zoWs9XtnnmKu0oZ1YB5G/cX;25:+zmDJ2HyKCtEj7vQCnHLXC0w+CKL2Ke41xz1Co4om/oGbQW66TbkLJJRx9xaIOkJ5+Npw3qyBWtxuq7FgxRlHL+W9R18WXLBq8iGPIzq8smeoHYOt2vzKXLDnjuJHGJkVlVoHNSNOeLqunA8Toc/9l7ElfJfoVJQ4QUWXNUMopW+kpcW74W/G9CeS5ahsyAxrVEalsAlzHndQG28nEz+b+oDb6MO76K4vT7cEvblLOcG8GKIhpVzhRW1LqjYT8bgHd/KmwuE3zETgFtjWPorXCBroLsh7byjwVTh9ty+B2gxf/efonW+Jx56yZzLVGtkuPwzXcd6arhiR1eobpHGSg==;31:SNeTHanShCQRgM76BnYRsx8hOqea416VNgF4Tim1pCSfvory+GRDHGde7Kti+dn1gR9tmaam3e6eIriW9nchMlTl82P+8cYsp18TwYjPWmV1cUQtc/9X3WNpz9D6CszrVDKV8g84K2UghUmosbGkENcek7AaMhBJ/ut/sqwfgxSRhCB+ADKZwzNl/VodsjVccMzNYYloaOqdBovALvNjTtWqwdPag9hCcfPe1lYxopE=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:QrphfvwCgGcBvsqBcamFgau/nXUOj+4vSfCeeZuPZW2+cSqOPaQkLvQLceo1eJyahxZPAh8xBnxtZEsGRJ5+1ZZxXVUAu+YKyiD1lLTmZvCqAwWA9+3NBH0RsIYTrdg53EXIHk4q9xHk/vj3BIJPdGoMJO8LW4pvIC23H2VkkC5YfmE4twbxKU15geVhnv4pwunfdMw3WBVfP2BOUdNJr0LImx9sNVSWlGlMOKTNPxHzJ/R+bpYbtORVfiziCg00WrOBc/yxrrhuCC5glJwAQf3yXpYTuBQfvMReaKxwJl+3Zrjog49Aoa/ohBivw3WU0F99C0Dir7uxTb0NxpSQpviSgY3k1iRygQLDStDLnfG2cSWIPuA0fPZpWg9wXZD11hiPpJ/kJ6Rs7NbCEQTyOTUj3tQBRRokmfGwYcLQ5rR6KzQ5wIiieDN2zrG53Ca0YPNxURSBnW8AiCwbWkUAEVWqaDR0QCda7mtSe1cAO9PunsBirB4qQkTh+q+pE3ID;4:cb05DlmVnNLKmY2Crq/q3LFRylGCG0vG1ZEFp8a2+xfkLASpmQS0XhttHNPiZGCzV75n0P7hKtjCtfE+RqQmm0Ze1mIFF6ZYKu6dPj19GhgcxCqfxoS9/nuwy1mJY2k1Mgk8GzPbJPgEKEK1JSii6PI54egj6E1WHSAaEg66Stujb+OE02yaKrnRb33SOyR0CLYGSjHnvgg4G06cqJIkDiXAbNF6KUH8RXv4q6XiT4CgaAn3EQdNkMo6L4+b93yEk3se8KM0JDRW0HeC4dLSuw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338BB9EECBA63FA7C740563CDAA0@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501323)(52105095)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39380400002)(346002)(39850400004)(376002)(366004)(199004)(189003)(58126008)(55236004)(86362001)(81156014)(8676002)(26005)(305945005)(6506007)(53936002)(8936002)(2950100002)(55016002)(6666003)(81166006)(186003)(9686003)(50466002)(7736002)(59450400001)(16526019)(316002)(103116003)(7416002)(7696005)(478600001)(25786009)(66066001)(39060400002)(47776003)(2906002)(33896004)(52116002)(61506002)(106356001)(5660300001)(97736004)(2486003)(23676004)(6116002)(76176011)(105586002)(230700001)(68736007)(3846002)(386003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6b1lCa2xDbEUrV2crdC9iVzl6Ym9VcXFm?=
 =?utf-8?B?a2hLazYxWU05RFdET1ljeWpqWjlxeGxCd204a1VHcmhnNDZtLzBWK2NGM2NI?=
 =?utf-8?B?OHZ4aHlrWWZrZDNHVjhFMS90R3lPQWtUeDlWeFRPNmQwUm4xOHBlcGZGR0E3?=
 =?utf-8?B?RnlHZTBqVXdTVFVkalMyNStPeUMrRU5zTnZaNUV2QWlWVkVyMnlLSENGWFU5?=
 =?utf-8?B?WWpvYVY2QUZySEtRais4UmJBaXF6V3lIMXU1UUVDTnRKaGV6d01vMldjb3Ew?=
 =?utf-8?B?MlQwV2l3ckhtR0FISDM3WWJkSnlUTGU1WlpUdkFDbWlWd3M5M3pWTzRlWFlt?=
 =?utf-8?B?MWZEZUhpcGEyYnFwbDBnN3NscS85MDB2RzJEalJ1aGRVOGN6Y3cyZ3VYcGt3?=
 =?utf-8?B?bDV0R2JsMjMvTmZBZEJwdXpYSm9makVKaGZrT0g2Z2NpNzg5bmpjd2UvblIy?=
 =?utf-8?B?SGpPNXcwT1NBZnAreEJZbi84UUIyV2ZYc3ErVlloT2xEdXEzRVdSd1NFMFpO?=
 =?utf-8?B?NnJEY21aNHpoMkRiaGF1aG1ESjVncFF0UEpDczRreTlYMW0zMjU5bVUxV2Nn?=
 =?utf-8?B?T2hzRjVOb0toUnFCbGFKeW1OZVIwM2RvVnpmV1dPSUZTV0tFUWlRMjNoYmEz?=
 =?utf-8?B?dWxxZWdqKzhzejlTOEMzREJqWlRyYnVNSVZaTnFZcnhzN1ZaOTR1Z1ZWRGZ6?=
 =?utf-8?B?WnkrSTd2QUlEY3FvSnVpUmFRVGhDU0ZreFI5cXVjSFlFaEwwSDN0NnhXNC9W?=
 =?utf-8?B?b1c1cTBoM09LMjYrVkNqa0ZVcHc4RHFmbnByN3k0WGpJVzR1VlQvUzUzYkJF?=
 =?utf-8?B?bGhvWHFiVktTcXZpZXVJOGQyVkNSS2RJc0hEa0FoNWJjamhXMHJsa1Q0VjR2?=
 =?utf-8?B?Q2MrRjVFZ0JnMS9lTDFXRFBQTXA2NklyY0V2T1ZtZ2c5c2JBYlJlMys4MWw0?=
 =?utf-8?B?NHZFREJkSUppS21WRnNXeWJNM1gzbXRrNFVQMzVNSDlpTWZVenp1bWEwUnhz?=
 =?utf-8?B?dGxMUUpQcDdTbGxKUVdqRWxXMFBLR3VNTndOV2lFUG5EKzVONlZ1a05ET0lO?=
 =?utf-8?B?UnU5eGhvV1dIYlkyL3hTRWhiby9NLzR2Q25jWkhwYWhyeERlbHJDTkhCMjNJ?=
 =?utf-8?B?bjhWY05sSVhzb3E1VytLWHpXd0s1QjNVclp4cHZqdjk5d2hObFBwclVLSExJ?=
 =?utf-8?B?UDh5eEtmVFIrSENDQ2RCM2RKMmhHemhYQ0RXd3ZUaHNBWEhudk96TFFhZWhV?=
 =?utf-8?B?LzdYTWNEZ0dZenRKNDhiRWltdUhEYjZkVkw3SGdWbVk2djVCOVFETDdoUmho?=
 =?utf-8?B?Q1hRaXN1MFRtcGI3TVhCeHBHZjdieG9nR1BCL3dFQ2JmZEFmSENxcG5ReDFh?=
 =?utf-8?B?K3BwTG90cmZXWXp4dnNIVE94NlRkcmhYWERGTGxMWXdTSU9PeGtVUUlycTFM?=
 =?utf-8?B?L3g1aVlwTnFnWklibk55OWZNNlpsT2xDSFc0M0s3ZE56K25la2xGYWNKaXpW?=
 =?utf-8?B?SzIvQXlTSUVSWk93T2VuWUJTZ0QyY2w1ZTBQbEFZTlFNMEIxRDhmb0Q2eWhm?=
 =?utf-8?B?MUhRU0EvVGdoUzUzZ1oycVJXL1FqaURyUEw2SmdBZmJ1ZzhWVXRPRkwyWkpT?=
 =?utf-8?B?MTVlYmVPWHdKNmdtam1EejhxOVNLMHJrR3E0ODY0TUlUcDg2allFWjVnZm9q?=
 =?utf-8?Q?vl7DYLjfF86NuD4uKUhzInird+/yQSqWqPFkFCWkm?=
X-Microsoft-Antispam-Message-Info: zc1aktqHWO5Q3op6THWV6p0vkHJjY5sPp6f9ysdck+SoDb7FAlbGqPLPUXW6mFsxojE70viQjrtCqsGyjP6QcZ4k+mpy3mYKte+ewhVc6V7Su5dsCnoqn+qoKu5XhzU/HiaHulqQsKdPBfWEZUBumMuIgAGKnBtgL559QA31BAZb+PMbRiyXNUQhudPAN/qK
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:ba+ZvTPJZ+52VTrGIHUNhdFCVZk0Nbmoge9+H991tXZ1Pne/Y4429Pr1ZI0MDyOjRh/8JxezWH1Jwx6Qd95DWoRY3UrRnVIeeuqtiH51MEWv5buox7gUUBnz6K6vw9JWQe6GNJcn/s7QHO3uPH51K/8kMFfatKWasemH1feT78DKmmhpSzlQC+0eiUdjf3gyKT1NijTy17320XqCLSlJF39HmccIWN3Z+SCphVfgc+VbVSzdXDH9ICQDwGdcStSsk4foAC5CmZbR4D8mC9aHE/6bxCcm9G8pChwyJcWqR2HIQtTIzFn8zYFJhO4uf+N/xG8q0uRYE3o6gJEzBBF9bJcCVgF+mu5IQQ+AW/tJTmQ=;5:xC+w4663vJznybaGrehshUlRjqhaVco7nb4QVIrbTT7CvtBenLzRxznW8TtkSAh5Rj+DexlJ/YHgkEMzEGhQXZoNqUQtDpzEO2pwIJmJgqY2O52D12lEQX70LVIT6iDW+d5bQaJxu17JnYvBRtU0XJSnL2k8Rx9dsb5TPm4WLEw=;24:3eg9navS1UBW8PrOOqapckCBnU9jRzZs4swbpd6RJ8b2XOpzqeyXZeZofbngMqQPbqrCwbMM4beLR4idhOlQoa6LbDjcnA7Ith5wk2CwCNQ=;7:BI/g7UTvmYKWRDQX1CO/lMdFXXCao2ZEbqineIkJpP6q/Va0UjL22VOputstFPHQ+hALwRcPfG5ni0TsrDv3I+Z+LWR/SX6d8+HViAqVRcfmTR5B9xtieV9Ty6vkWUKg1C4TW5f2GXBpuhlgF7bwPm3ybBFE7I+pKxZsW492VM6L7LGqWuSqxsULOOYCTM5b5IbmMxvznYk//lbgHJw2m7vT5rOIkzYnhAlLPwXetfENvcUvkdsKQ4Ha6s/N7bQC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:8mIG1XRkMVUqicTOFu+grnWVlP85kA82F5sbUrDPz+Ve5OPv2tljK1IshsDm22BsPJJiYTiE2VEpWESkkjmBSHz6beHQhFUUqS6m53cs4Q7jnqnirhmfA0Jj0n0HfZdoUGzJ/6uAMgw/UAXBuXjvQhZaQy913wZ+oJ1SDfusOtY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:21:21.4883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fa8977-7609-476f-421f-08d58f2ea520
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553598792007322?=
X-GMAIL-MSGID: =?utf-8?q?1595553598792007322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch introduces shrinker::id number, which is used to enumerate
memcg-aware shrinkers. The number start from 0, and the code tries
to maintain it as small as possible.

This will be used as to represent a memcg-aware shrinkers in memcg
shrinkers map.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/shrinker.h |    1 +
 mm/vmscan.c              |   59 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index a3894918a436..738de8ef5246 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -66,6 +66,7 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
+	int id;
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8fcd9f8d7390..91b5120b924f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -159,6 +159,56 @@ unsigned long vm_total_pages;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+static DEFINE_IDA(bitmap_id_ida);
+static DECLARE_RWSEM(bitmap_rwsem);
+static int bitmap_id_start;
+
+static int alloc_shrinker_id(struct shrinker *shrinker)
+{
+	int id, ret;
+
+	if (!(shrinker->flags & SHRINKER_MEMCG_AWARE))
+		return 0;
+retry:
+	ida_pre_get(&bitmap_id_ida, GFP_KERNEL);
+	down_write(&bitmap_rwsem);
+	ret = ida_get_new_above(&bitmap_id_ida, bitmap_id_start, &id);
+	if (!ret) {
+		shrinker->id = id;
+		bitmap_id_start = shrinker->id + 1;
+	}
+	up_write(&bitmap_rwsem);
+	if (ret == -EAGAIN)
+		goto retry;
+
+	return ret;
+}
+
+static void free_shrinker_id(struct shrinker *shrinker)
+{
+	int id = shrinker->id;
+
+	if (!(shrinker->flags & SHRINKER_MEMCG_AWARE))
+		return;
+
+	down_write(&bitmap_rwsem);
+	ida_remove(&bitmap_id_ida, id);
+	if (bitmap_id_start > id)
+		bitmap_id_start = id;
+	up_write(&bitmap_rwsem);
+}
+#else /* CONFIG_MEMCG && !CONFIG_SLOB */
+static int alloc_shrinker_id(struct shrinker *shrinker)
+{
+	return 0;
+}
+
+static void free_shrinker_id(struct shrinker *shrinker)
+{
+}
+#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+
 #ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
 {
@@ -269,10 +319,18 @@ int register_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
+	if (alloc_shrinker_id(shrinker))
+		goto free_deferred;
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
 
@@ -286,6 +344,7 @@ void unregister_shrinker(struct shrinker *shrinker)
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
+	free_shrinker_id(shrinker);
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
