Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932889AbeCSPcX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:32:23 -0400
Received: from mail-eopbgr10105.outbound.protection.outlook.com ([40.107.1.105]:54240
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755478AbeCSPcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:32:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v2] mm: Allow to kill tasks doing pcpu_alloc() and waiting for
 pcpu_balance_workfn()
To: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
 <20180319151447.GL2943022@devbig577.frc2.facebook.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <4e8ca27a-9c92-8f1e-fb72-88758a266cb6@virtuozzo.com>
Date: Mon, 19 Mar 2018 18:32:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319151447.GL2943022@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0015.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::25) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30f2822d-6059-4242-080e-08d58dae9760
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:r+BzOr9CgN5Cn7L0jbHReE2u9L4OUf59rjcVBNgBTiO8iURpDCKv9pef4YVxxlVgLKV9nHRFVyTjYOSg6otFx9Ci3713Gc/m+trYcNriEgm4D9Fc9X4AJ4MF34m1PUn9/4c0dorDZaD4AnpYLPQW1DDsLrs78eBa+jNysDkYmaVv2GoWdjvfeL3pALOERXDwiY2nlsxMvgmTPKZArweYpF3nj64i3m3lvlynhAJN4+ujJ4sqULow41mBuhuOzbIh;25:2OKYxGb4GtbbnfzHJuA+12AQtMGIT0UVzQzU6Q7IgE36JTITlrETmGhM4zr12YQsaku0mjY4Btw2BMcVm1XL3rA9Kwtidr1L3ep+6mNlGCjw3x0LKjy4OC7XtGaVUFNydQ/4DRBLlylEb5hCQybySsvB1kL7MFs8uxyvxkJoeAOuLiOonHBRJS2QbfL6VwpvBGzB7lufsRdNChySmfK0lNDdG5ZGYCbbONjxZzw84lIKNvLyzQZduVlf4AUrNXRi8rz9qJMT0OEdG5tYkTvhyEAT6gFCtYoxeVQ0eU/Hdp3F5iOH56/nP1rREGJUA/gffJ0KbZ+AQqoNditieEbrAQ==;31:iRyUhB3h8k9Q4a/uePTAPFyOVcbxG23oLyFEVaweblBOLuvdSNav28vbVvoijTMXPkO+AJQRiMMi+onJ+U1amMg1ZuUcp7qPVMqJ8YmOnxgKdkQRtIixllwdpZx51G/K8rAmqkGHPwinsuodFgYEtDdKwoZF4xyVMJCvyThEg5z/zFxgFvcQtiOUdJNJZaoI7M56gVixS8Q6sWKLkgS60SAmd85TbsGG1zcbzW/tMoc=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:Bmj6RryI1KadloQzYt0yiq+7JEzz68GO20iE7K2lYdsxLaqE+NRHalPyE8UMwTOXTVZhuzkQMiiUAO/+UDy+ZolOfPjzZavHF8XM8IpzjTiff+EQYv7OSVFhvt7dq8eJRhBHFXgPex/FxOBT9XoQzPV4QOgBiMhpG6yZaaj5SVAroWv+Cikbog9yKdrZwHm0I/DEaiBq8fs3lYoYfgQjSnFR2Z9M1Ak6uoBuSf0mva45aiI/N6GOTcJw9FhVi61RKSb9/heTzEynTOv2Vb2AcRmaiNi9hrMG4mgDkco1xjON0nNwMSe+vho3/s/D1QpdK0usB2x9tZfYQigK/29uBjqu/bJnGn9yqRVhbjh8ujN1yKrCviI123lDVuGmNQrX2r3TpF6C+5f/VQRny86+uGUWHpSykSZOnEU5fwfWpOkG/G5t+6IbP0c92zF7QtnsrGA4EUZXmqIXpClv0e4hxVJUeQQ0V9ZhJG0N4xijO+0qqbs+RcjPVM56xnJpBNv1;4:25bM/Zk/a+8t3wrVPSc6L/MFR1KuxYugnUEud5pwLanFPPs3IC5VjWJTXiIUmKPQvHuSiZ76Y03Axw3wzZHBEdq29hN1xq+ACMK/3c1wrpqzLR8kogSx59snSKSIwqZ3rBw+eEKO9bjRqd/LASLphQF1uKFDGiSKK0uFj2Li6ZUgaK62hu62dUukvT1MF7wJwRTZR3i1+NoqJrzNnbYx+xZDs1BWSyGo4Nt/TTH8D6IqQbumFvAo22Sv8/8rBVlZ9JVT6qqNkGCcr8eIWMN3tw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13299DB040A97CB2DD885826CDD40@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501244)(52105095)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(39380400002)(396003)(39850400004)(376002)(189003)(199004)(4326008)(65826007)(97736004)(2906002)(53936002)(106356001)(31686004)(31696002)(16526019)(386003)(2486003)(76176011)(7736002)(50466002)(26005)(186003)(64126003)(77096007)(23676004)(8936002)(55236004)(25786009)(478600001)(81166006)(8676002)(305945005)(16576012)(52146003)(6666003)(86362001)(6486002)(3846002)(6116002)(2950100002)(59450400001)(5660300001)(66066001)(65956001)(58126008)(65806001)(110136005)(105586002)(316002)(52116002)(81156014)(230700001)(68736007)(36756003)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6VmwzYUhJbllKT0FiY2lOT1Vud05JR2xV?=
 =?utf-8?B?ODcwc0lJVzZvT1YzNUh0UDdSY3h2dDJtT25lSGdMWGZ2cFRtUWYxMzlsOHF1?=
 =?utf-8?B?SmN1dXhLaEhrYThEdGxTS0NkL1BibjF1ZWVHNFJXVUFpK1ByYXhSNnRmaTFz?=
 =?utf-8?B?Y0U1aWlFR0Rna3ZvN0U0NDljOUk1SlNPYktVNnl5ZndRVmtyUWpDNjNablFX?=
 =?utf-8?B?c2dubEV6K05NbVdVWkcrclQ0WGFqQWVvbHdaRThEYVpPTHZYT1MwRnByMUkw?=
 =?utf-8?B?QmowVEpPZ1crNFJoY3c4M2p4MlJROHloR0h1L1lWbWxlcWI2bFhSVDR0YzVP?=
 =?utf-8?B?amUwY0lEUmNBK2R2MzRvZDdEYThtY2RMMDlnb1NaQ3NUVG9jS0o2Sk51OGRH?=
 =?utf-8?B?eUpnZWsxNFRDaWlueDBSODFoTHVzcTZ1ZWRrVmhBNlU3OUVqVlJ6NFErbGwr?=
 =?utf-8?B?Z2RBRkVSL09UMDRWNlp0bnpBeHZITDZrRlFORDU0R0xqWUl3R0lRQVdLdlRu?=
 =?utf-8?B?azBhNy9iTEN0WXFqQ3VhclVWTnNpWE5KTHVOWGpoVVhDVkl1UE5kcE9uY2U5?=
 =?utf-8?B?U28yOER2OXZKREZBSHYwNTlYR3FtU1hNSk1ZQ09zK3lpWStveGJKRnY4YTcr?=
 =?utf-8?B?L2gyWWFPU2xsTlBkOFVNUWNIQndHd3hHNEpFWjY2aS9xWUZHSDlYZjhGcGVz?=
 =?utf-8?B?VXFUZjBNY2lGY25nUWtSd0R2UklYRDJsajUraTlTT25CVHdnTHc5bVNONFg1?=
 =?utf-8?B?dzBCdUpaejZFcWNOek8raDVpYjF6Q0FiM2lWbDhUL0lMWm9wKzRyYnQ3bHI5?=
 =?utf-8?B?Z0hvTzFvSzhQVGR4dGplZEFSMUVURnc4UFVWWFBROENPcWcyVFdUdVF5S0Ev?=
 =?utf-8?B?eDc2ZWNjVnFtd1RxVnVpQjAvVmpnbDR1RjJlYktlL3FuV3hETGVxYkN5REZr?=
 =?utf-8?B?TUNNNUJuTGNkYm9mMXcvbFlkQlVJU1daVm12R1lmUkhkdFlpNWZRaGZrRzli?=
 =?utf-8?B?ODRhWGRXNy9GOURrMjVyNFNqS3JCckZZM1FtcnB1WjBZVjUyZHVOUkt5aHFL?=
 =?utf-8?B?ajJJS3FveHVNc3FXbUFGMHBIS0tycW1reE1weS9RS3RwMTFOV1VRZm9rb1Zv?=
 =?utf-8?B?WDlXaHdpZncvZDF4QnBqR25WZFZxZVlGQy9iRitwSS9Nc0tQbzVEV1gva0ZS?=
 =?utf-8?B?bTZPZmplTlZIMFNLMVp5UjlUaTQ4Z3hiRU1pNVYwdXJjQjRFS3EzT0RTTEtt?=
 =?utf-8?B?b1dvMldmbFg5YXMyV0N6NmtKYjU3engrYWl6OGI0OVZLRzdJcXB2Q2JQUVBP?=
 =?utf-8?B?NVN3b2Fxai9FU0M4K1Z6aXp2dEVsRkYreGoraGNUTXltQ0Nhb1JMZ001dDZ3?=
 =?utf-8?B?SVpmSWRZd2NFSTNhVUNjWnNwUC9SUDFnTk5ETkFUQnNhb01UUU5CQUI3OHBV?=
 =?utf-8?B?NEROazZNR3NjaGp3dnBSYTFIWmNFWkxWTE5maUY5QUF4RmlkRHhHNkFkVlp0?=
 =?utf-8?B?RGE4QXMxR2l5a1JmSDNua3I3OTV3V2cyT1pBNi9rTTZrYTdIRHNHWWorM0pH?=
 =?utf-8?B?Kzg4TE9iRGh5UllXaWc0SHJENGFiU2hraU8ydDM3SHhRUTYvbG1TeERlR2Y1?=
 =?utf-8?B?K0JmOEh2eE4wV1Rheit6dVllV2pNYlp4aG9hZ3pKa3ZPb3dlTnc1TnhnbFNV?=
 =?utf-8?B?ZmNQRWRPREpNcVhZb3BUU1NmSDQrRklYVFJBRWJJTWIwRzJUbGhxUFdVWXVM?=
 =?utf-8?Q?U7Z8yK3SLmShTdsBkKmIkcH/Vg0RZ1bjHyVPt+M=3D?=
X-Microsoft-Antispam-Message-Info: t9evvAwtcKRp8TVy1jJ5z/QcZqgKFOJU+JNVVb6fHi5BQqgNx0lhkx5WFPoXE0PvMZdRCldO5q9fg/sYOT7c/21N3SwHJY/QihVm9iK9odDlE8zMZjTJSsACt6I7Of/X21k7JocEZiWpJlCvJb9GjJcPGhcI6nanarvUjvLaqkcWcKDT72iiRC8Yyzlxi8mH
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:3KQZoylEtSbHwVwgJLhl2M9uwYGH5sEvv81tzcMbJu/iks47xg3jT5l5DIdlbZOH4PsV0qy0f5xOO86fs0/bn9a3RzITCh7A0QRVFioqDP7w+QRnivJD2t/321xH5ny4n8TRuxymW0ra51Zp/6fXyTwFh2qNe6wqfY5YwklJet2QXsXeAWbpj2rD1T4kUQ+bujdUHDoSMZtROXG6tBXRdbAPaYHLPiQ5Yy4khFH5XkhObtqBvzxIZNeCrwgqyLIzWG2S6/nQgDj5fVi7Xn+WhGZwLg1jmBo6yS0ew1MHlGrcDJKZQtMpQPfumsGbRE1Z6gXjK3ZeWxKKoJwAV/WzR0jvvxFQ6H8V4g/tYmd9/Ts=;5:XmoiJLleo23SqNxfwzaC4u1J4+9NepYUE8yZwtXgs95BUpfbp1+5b3vw7twFx+Gxvaf0EHIA8fsLFhyaoq88X9paXz0S1ILaBs7ouMF7MwHQNo8OD6eJI0yfdKDDwUnJbfty6/efpL4k5tmww7N0DSM5junn5v6hbUILZWuRU4k=;24:kVFnYbXUotqVBh8xo72jDU7U6E5nqFMD2ck92To376hd41JcQunWj34iSkeQVU845tlXDDi2GtEW8bfArwZAjY644RUAHtYN8fJZVFp8K+8=;7:Lv+6VIOT9tDSTTB/BusjzQ7atCEqe2mU6AA2oFwhAUt7r3jCHAC4+EIKxW6hdPIu9hBmkJt/+I2RLd/Dkv/UhSUQciuvpAn7a7z6vj9sW08sTNsqQ2M62oStfxkvtnKmfVYKkFXeKJZWXcFOMjlLBGylEpth09ivtrG9908S1rKuejld+9qq4Eu/aomZw8PPvS/zpUy2Rw66t0xgDsfv0GD1pi3rBSYuG0axrd8MQHRK6/ilc1K2e1fFtHckHq+k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:xase68v5bnMoBdpu2LezwfAdD0wrnfvwxWIS+9NEdJkkEpB1wqd5zXhUmWsO377MJEaTcth5vSk5+lhhaJxM5SvnfZty4MkOwtoYAgK8v6kAskifSAoHiPtepir6Z5TChWVOupvrJoW62hFYcj9ilOdS+oFuhWFx9V96xq+wIdE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 15:32:14.1948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f2822d-6059-4242-080e-08d58dae9760
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

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
v2: Added explaining comment
 mm/percpu.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 50e7fdf84055..605e3228baa6 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1369,8 +1369,17 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 		return NULL;
 	}
 
-	if (!is_atomic)
-		mutex_lock(&pcpu_alloc_mutex);
+	if (!is_atomic) {
+		/*
+		 * pcpu_balance_workfn() allocates memory under this mutex,
+		 * and it may wait for memory reclaim. Allow current task
+		 * to become OOM victim, in case of memory pressure.
+		 */
+		if (gfp & __GFP_NOFAIL)
+			mutex_lock(&pcpu_alloc_mutex);
+		else if (mutex_lock_killable(&pcpu_alloc_mutex))
+			return NULL;
+	}
 
 	spin_lock_irqsave(&pcpu_lock, flags);
 
