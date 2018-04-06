Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeDFRYd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:24:33 -0400
Received: from mail-eopbgr00128.outbound.protection.outlook.com ([40.107.0.128]:46974
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751384AbeDFRYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:24:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v2 3/4] mm/vmscan: Don't change pgdat state on base of a
 single LRU list state.
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20180323152029.11084-1-aryabinin@virtuozzo.com>
 <20180323152029.11084-4-aryabinin@virtuozzo.com>
 <20180406162835.GD20806@cmpxchg.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <312906df-80c4-aaaf-3d0f-caaeeceb9f39@virtuozzo.com>
Date: Fri, 6 Apr 2018 20:25:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406162835.GD20806@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0102CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::39) To DB7PR08MB3260.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25b5ca18-8432-4c91-73b0-08d59be33f79
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3260;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;3:qAg7JJdWVANT+q1E0ABked+TZMRAK664EtwUndS4zUOcgjBMd6+knRIfsbNxENGHVppEhJjDPIu2ddv9D/MGpOpk3N0Unnjz/GOkdCarYKQfuy2nDlq70LbpbQoXeMbpldlDllEeBjkuU3BtTM1pwcE5jocyelBk2CaffHX9zI9qEB4qBHYXdCrvXAoPPkhyRHmyQ621vLzAjnyw+7DQD8xYt6u3NvCSwrnjSNfDYh517QJIzkbSxhOaFY3B6CFS;25:QvI3vk6J1Z5cphOnoRoXEGEROZM/yd8ClUf5Kx0bhGTEwTj+vukNrdO520oYOCeuUHEfcgBQCVBi4/fWOV1Gg95gkO2AnS4LUYgjXF1/ZoWGvdRu1K8Pp8NV7JoUF7ogkdYysyJPNNRaoHOwAghby6cU18VkhJZTYRWwBEQWePfPZev6HW8whc0C1p4JY7vSVPfx6eVG2uXloWY/Wsc/YDeC33TrcD3BxD8ZDWffjh0/hN1F65BwUvIFDZXq1T68UgLmkF9rbK+okQAwCPEpO+pAlH9AwnqvT9R5zwmuym103VHK8ypJ5yZfrkhebj2rl9RCqpdsB9/NSHSZoPMv5w==;31:qyb9nXDGdAtH95UZbF9M+dYqCWtJyxVj99XplbIaU1L19uRTmTNDmevCIgANneZejT8Z7ExkiGFgLM2wEmPf6G458RAEoy+PXJf51vpkdOTYhNJ/AGhDoeBsj5oxFbKtLTf9EQ5dFUzrXHW462UD004IJ5tHelvY/T9JoULEpJE20HLCi+15EdjRiMezeInFRR4PTHrhTNSdLbzSgSZDkij+uwPfBmzdZVskQMhth8Q=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3260:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;20:+X4vucZm3kggaHRo5yFspTl+wf2ZzvRcBfmuPE3Ny/dJuo6FeIymxVap4UpruBOS704GiCQK/qbQT9ex8FU6wOvFdTNbCe/TU6LQlEqCdQNGdi5k0iZBF1wZE3a6gvGKMH3fe26e6YlVUeq7C71DvnW0Tk1+6ZPARB89eI0s5IXEvu/1LhkgiAiZPuLwTGoxZ0nU3OjWbQ/gukkMughqlp3PpQGdCEHoEMxcC7gPYt/mIFauSgYAJlLad+z6+PGwIpvhM7oBdZ2Dxe6VzBwtz/yhE13GYj9r+RKQCnOSybp/2ap8ub97g9HNrIwrxtE5KQy1b1/ouwNds6Do8Wmjy4beCm7YqQqijUz5/PnamBzAWOYhEQx/T9GCBV84vLi7n+3/BlSprrTP7HEbflg/D0SQtN1Ke6Omc/FjEHAQJYhATnBjL9SItcfJTfLZ5wzjN6sDgtLblbgr4WgkL9De1svbCtmUJ88ZYIwmb6ArswGPMqXSDKzUDnQszFnZk+w3;4:WSWNjA8GSq9A9pjW5fhl5CKfcO8WXclTIEonTAFJOFwzI8VMn8zWnSFfT6yB+ae+ZZoDc68mirZXsIuTyKuezttkSkeF9qLPDJQrMc8gr4Eievoj2xA2kScFsRi+FJ2HyJTlYf8eVoum/dAYTjkQ1nwi/h791wAPcIlg8eui13SzCnHj+yVcJrqiDXRfiyTTYSkXQvR87jUyWgwVjn6sTnfRobg+veDYHleEk2qm5I3Xzw/R06LhFvqmS3uED++P/K6Of2UnhV0GmIhCO7XU0w==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3260A1CEBDE5874A34DC3D7EB0BA0@DB7PR08MB3260.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB7PR08MB3260;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3260;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(396003)(376002)(39380400002)(39850400004)(199004)(189003)(81156014)(52116002)(8676002)(8936002)(4326008)(31686004)(446003)(7416002)(6916009)(54906003)(5660300001)(65826007)(3846002)(81166006)(305945005)(97736004)(316002)(6116002)(23676004)(956004)(31696002)(52146003)(77096007)(16526019)(16576012)(476003)(2616005)(76176011)(2486003)(11346002)(386003)(58126008)(86362001)(55236004)(6666003)(26005)(53546011)(65956001)(68736007)(47776003)(2906002)(106356001)(64126003)(229853002)(105586002)(65806001)(6486002)(36756003)(53936002)(59450400001)(186003)(6246003)(25786009)(66066001)(486006)(230700001)(7736002)(50466002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3260;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjYwOzIzOlpPVUdQczc5dHZkUDcvQndGcGttc3ZUR0lH?=
 =?utf-8?B?TVZXV1AxS25oVEtCOERTSTM2N3hnS09uVHM4RUJSaW1tbDl0ajBzbW8xenly?=
 =?utf-8?B?NTVMaTYwNTFBb01hK0pjUHJxOXBWYW1OL3d5UGVmNmV5UjFQRkw3WE1aZXoz?=
 =?utf-8?B?Q21PSWNFb0V2NE1LUTFaTVE1aEQ1RTZuZVBLM2wxSXRvTnYwNkEwVWZvU3FU?=
 =?utf-8?B?YTdqSFFnSEU3ZDExdEZWVHVPNXZmN1BVUW5rZ3htNklPY2x0MForMkpwOFRK?=
 =?utf-8?B?T1Fpa3B2YWI3OFUvWVFlcmtRK1htKytYQkNrZkJ4eDRBbzIzMzRXY09QTlVj?=
 =?utf-8?B?cnk4TjRkY1kvSHplNUsyRHQ3SEM4K1pIcDl5YjFYU3lRU0VId29OZDRYc1JF?=
 =?utf-8?B?QXc0cW9nOGdiWDFVeHZYY3RJaEdZSVBzYk1VeERGWHVVZmdvd0xOelJlc0FC?=
 =?utf-8?B?M2htS0xjanREOEUxbDE0R3pJSENRV1krSlBMK0d0RHlxb21mQUtrdUtYV0tR?=
 =?utf-8?B?WEhRZVJYM3J4Q0g0cHBpRGpNWmQ3RlNmSVFKYWpkWmFyVXdzR0xIS1E2NW4w?=
 =?utf-8?B?eWJXellDYkZJYlB3Tm5NK0pyZ2liL3NleHVPVlhCRWNSNW5hUnFVbnAyTi9N?=
 =?utf-8?B?WDVtWjZIcUhON3JkNHFhWjdwQlR6Ui9oNFY1dDFTR1VkdXdtSlBxZkhtV2Vq?=
 =?utf-8?B?U0ZkaWpCcStLK2hLaEQ4akJscUJBeEE1cmN3TW00M0paeExDWXlxWnF4OTlr?=
 =?utf-8?B?WU9QNU5WUVNuWStMWDBrQ2E4eGhPdXZIWXpPeTZ3MjJhOGNLZG5OelB2bkFV?=
 =?utf-8?B?Q2EyNlJIVWt3WDB2VFI3bVBwMU56V2NsRXFISE1BQXBiQWJ1bXRRTjVjckhM?=
 =?utf-8?B?anF2Ri84a21sQTcrNUR6Y1k3T3BKd05WTC9sMHJQWGhKZUVGQ09VbW5GMkNO?=
 =?utf-8?B?UzRmajVOQUJxL25MVWJqdlo1akE0V1JQVnBmb3J6SFdYdWNxTzVudTd3eWs4?=
 =?utf-8?B?d2swQ2xhcFNkRmN1TStnZStZNFZ2UnB1V296UzVKRkc5cHlUdk5xbDdxa3RY?=
 =?utf-8?B?aHIrS3c3NmdNczJHUFpyNDIyeExoNkVFQzdEeTZ6MVlsR1p4NWc1Z3d1eVZO?=
 =?utf-8?B?dnBNOXdydFFITnhuZUxkYlI0NE9odGFoK2JLb1FPWXkwaGpkSkNGZjJLSzQ2?=
 =?utf-8?B?VWxQTElXSVRZa2lSeTh6TzRCdGdibGdxMkVOMDMybS9OYjczMUl0cHg2azRT?=
 =?utf-8?B?NWJqam5EUkM4S1BKMHJJeVRNeURwZEVQeTBadzgxOUdIMlZsVkpTMldVQjJT?=
 =?utf-8?B?YW5vV21UcDg4QmdIcFNwNi90dGppeUpReVVKdlVtZXc3ZFdUT3RlaEFUSXNJ?=
 =?utf-8?B?YUZPS2Zzelh6Um54V2RtVmY4dHBnZ3ZuN0kzZWhhS1d5RDNJZlF1a1pMVTdJ?=
 =?utf-8?B?N0hQT0hFMHNFam42ajhSc3czTmJSU21Ea3hzSUd6aHlWVVJ4UGpkYXhQUFdH?=
 =?utf-8?B?MVBEamdRN2plR0oyZVZLY25SMGhGVCtvRTZqVVgvY2Y5OTFXQlluZDQ4cjJz?=
 =?utf-8?B?QlFQZGNPcmVZMnhFc2ZkK0ZwNjNuNEc2Y0szbG02bHVJLzduK3NyZVBSdnFj?=
 =?utf-8?B?eUtONUVmdjBlcFMySVE0d1lrWFc1QVVKQzB3TlE3RGNDcFFwVUNBRzJ1WHZh?=
 =?utf-8?B?c2xiYkpRVzBUZWRDWlVJQWVRMXVXa0g2RmM5UldmMWJjM0dQaThWdHRMbU4y?=
 =?utf-8?B?dFpYVnFsRzRoYy9KdDFMbjFnUU9JRmNmSGR6ekgzZWxXQmYySTdobWZpQVNH?=
 =?utf-8?B?dENxYVJOWUphUjZna1ZUYkdmeEY1Y1RTL2xTVGJobndzMERhNU4zVkxtV1Uy?=
 =?utf-8?B?ZFVtaVM0VnRhcFBacEwyQnl1OVYwNmM0VDJ3S3VqcjFNdkw4M0JidUltdGlU?=
 =?utf-8?B?TTY3bVJ3TU53bGRWUlZ1WWZYYUNkZkt0L1MzclIvVFJGVDFzNUNwV3UzTS9x?=
 =?utf-8?B?bVdJWThoU2sya2FXUjlreGIvWjhnNW1HMjg5YnZoOTlvRzZGbkU3blVxa0V6?=
 =?utf-8?Q?cv84=3D?=
X-Microsoft-Antispam-Message-Info: SaN23Y3Pr2PmkNuZGYBUIviKrK/J/K/t6Fhk6Xb6/bmLKWkDMz4PNGR7A37El0EKy3M5yn7Tx1wWE9kzL4Z88UZbR9aTkiSqePlSvDpeyx6ota76uTvCYz3wRWc5KD+NRMD96qzatvT4L+kjHJObvDdLwoHvQ6QHCDX2dDWVNkzmZd7FYglUZ8JDBAf2lKq4
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;6:o0ckqgG+cbUPzXbq8jF6E9L5gCdqhwiN8OHCBtqzw4l/57MtIaiYUzBWkaSXOwj14GJ22PiSPOfD1kRqnjbdaKPDLeTrdkI6c0SvIIDA5RGrmNU8fWZCK+GJ8M5a2F5RGD0hHNMxtpZJslWuH35NSfqDtgHqxKxcz4YGyx9Bu1eqFtfxUVWEU6UZARwEGotsXEgJcdpbizV2dUCcvmxYuy1fLtRJEtwSG8hNdSkAFqyB0Xj+PLy/UvajMZUU7qv1ePI6jdP8KTTsXdXun65jqgDIzA23udyg5ACl5U7/95V9jfIn+zCKc5KqVlDa+php2iidnxhnvhlEJpfxmNIgyhEyWV5f+4MqJy2srzsjehNym/HpSglDhGmCUu0xnU0Bu1hpQxpmjCmjmM//UBj3GzPh68rNGQdAS2kVQRVCoom7MCXBZLcIiu3zj++eH7yBNVh8TTE3hhQeMc8OsaAU2Q==;5:xDjIVbCbVSwQjIoipSil2ylpizqDDpZ9EO+jB3XNPfDxLp9g0/ePSbh1VQ6m9PdQC5rrG53M+aeJmP0kyhRcxi/dSjkNcrLLGWn4ryaTdSiwPDjYJvOWfkrM2K3uju5msiprb8JjnVJ9qrEzZ0PAfTXTwuNZqwaxCbwXv6PwqkE=;24:99Y9XYqnQbuPXljChbnj5KMA+DpZxYG4qtMpuMu2J/Uwdzug00v2CBluR0RR4GX8QXA/9/vRhCXu4ni6L1s2wNAIM5pOcvbLZx0aI1ZLG4A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;7:ogqVQxdR8hD9jQAntbLPsM3yqKFVGNTNqH1zshRsnLQrdts5s+a06yrjRdUsB99OHrz/EMfZn2odBELvP/so4Dy9IPlKk5WufwBah6Av2S+FPTxHzphs8mgES2VhEKt+oJRefbJAnQBX85Fj+EIILgi4XsX6ATuYABJHiY1J0upb4QXIdHUQ1DC6QNuN2cl/fYcmvEzNJRbnWFzWsJgrrdJHgyHCpuDbeHWPE5KwiSJ2TslU1eU9O0oz+aoIGY/Z;20:mapm1mn0AB3ZRDuXXEIzatVoZDXYhAKE4xe4+2Md7J5wj5kJEj9g77+mqrsV9rf9NBwaHiznpYcJNc45HYTiDIlU24EkTaHlV1cYTRqtq7oWfqK83oPyEK7zfs5dmPqljgYzT/CpdOvVLUX6YNDXbCYLrJqy3irVqsEc7WYvTxo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 17:24:25.8536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b5ca18-8432-4c91-73b0-08d59be33f79
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3260
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/2018 07:28 PM, Johannes Weiner wrote:
> 
> This isn't quite equivalent to what we have right now.
> 
> Yes, nr_dirty, nr_unqueued_dirty and nr_congested apply to file pages
> only. That part is about waking the flushers and avoiding writing
> files in 4k chunks from reclaim context. So those numbers do need to
> be compared against scanned *file* pages.
> 
> But nr_writeback and nr_immediate is about throttling reclaim when we
> hit too many pages under writeout, and that applies to both file and
> anonymous/swap pages. We do want to throttle on swapout, too.
> 
> So nr_writeback needs to check against all nr_taken, not just file.
> 

Agreed, the fix bellow. It causes conflict in the next 4/4 patch,
so I'll just send v3 with all fixes folded.

---
 mm/vmscan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4d848b8df01f..c45497475e84 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -124,6 +124,7 @@ struct scan_control {
 		unsigned int writeback;
 		unsigned int immediate;
 		unsigned int file_taken;
+		unsigned int taken;
 	} nr;
 };
 
@@ -1771,6 +1772,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
 	sc->nr.writeback += stat.nr_writeback;
 	sc->nr.immediate += stat.nr_immediate;
+	sc->nr.taken += nr_taken;
 	if (file)
 		sc->nr.file_taken += nr_taken;
 
@@ -2553,7 +2555,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 * number of pages under pages flagged for immediate reclaim and
 		 * stall if any are encountered in the nr_immediate check below.
 		 */
-		if (sc->nr.writeback && sc->nr.writeback == sc->nr.file_taken)
+		if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
 			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
 		/*
-- 
2.16.1
