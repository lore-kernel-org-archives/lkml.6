Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeERVwG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:52:06 -0400
Received: from mail-by2nam01on0079.outbound.protection.outlook.com ([104.47.34.79]:32096
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751009AbeERVwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:52:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH] iommu/amd - Optimize PPR log handling
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Fri, 18 May 2018 16:51:56 -0500
Message-ID: <152668031618.108078.8188026193559324640.stgit@wsp141332wss.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0701CA0024.namprd07.prod.outlook.com
 (2603:10b6:803:28::34) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1449;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;3:4VXMbbzLkaemfbanVo+l0SfUMcvfEdKUYUOefDsOk0sja4STdQPmN7QtYTyXnGg+Sc9ZlKt+j6Vyn8x3LjQq+j3IR6Zin4XxAs7qBQ5KTkF63T/1uAaapS5QwelSyjOH2+NIpxOIUkgh3hBl38+k9k3MVHaKmSqI6TP5nj0VuQUGgcl2eDzrTCpZ/poDJfQmAdBsxpecLpXXf0FnqcObv9JHj+ipckgtx5MwnOGh6PZtXH4jGGxNtnXUEHhP2lcI;25:L5bZ/fdumW2PAqMEkVy1ZCWN7z1Ad1gTa0C+fPcKKZjNzdN+CYVdFlJWs/UpYXhI9jEC5gV77Ak1JSOD8iMBK7KtCK2H4C316hh0UDvWeujBdS+qj4axu4EHmOHhoe/8eAlngR6H5A3JBcQ1Fr0217DR3ZxHBPRQGBAoIZaqIZTpNXRg4uZora53p1BOLUuPI6vq4T7QdjEhPQLleLENASGa4AK01yQVqnmNDsYHAXhhFNmrfEyvVwARB9DTiBxUkq5WPUkIbEl3kizT4vo28BbZjpMYoT5/oWikxdVK+yHMZvH5L1FHKK/9RywVagctf/e7eREt37Jy9MOFXTxQBQ==;31:z+AFCxgP+hZDZtbf5aCvHZZz02N3sDJ8KJupSD4BNEPPrjJhSIlcc8qCJrN2o2TDvVFL0uXTZEexFbDAqPJEo4jiTaT3JmfE2vMk2Nj61Mdtvlozf8cI8YB3CwiGkNvFcunZ20mleWYD3YnFNuBauv4I11LeaZZArTbGZkYO7oRN3WrhVMHY/uqpXGpxihiXxwC0dzR8bTVLUCzLMEybcJIXndixbJ9VRL62SMQeec4=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;20:Hzb84kYmKB05bnFjAirlZyYqJJcVYa8PlPY+07I5qSx+3+2LtN07tTNrA6zGnTpABXwQx3sWxOCCnmoOh4mRElg4Cd07Xh1u3pvsrxERAS52VoHKvgmxXzu3DRScMtUu6SZZbA7T/j8h0nEmmw/PTyj2s+1JsEP/JT1Hvf2Mz3HqC0gV7OJ2Qgtdg6s/46jlm/dPpOAqKG/apH06I43F3eVJbFz0tHKHTz1byGZUMl3tG93AkYPu2NFY/mbEHT2GyptRPXQIGUNuWHyjnXoBgs/qFFqIXz31tOWF5k5woJhuht1A+3hxYuMXBdXl1C7cTEJ982QO2qmXjGlFCzlMNiuPGtcYbEWhYuPyvVF099BwnWda8wvnCSWsDFbNgwN4yjG21+pdcwqPDi33hbGaGnicavezFXoXWuq0y+V5PyuhicgiKWPUhNiDTmDWUwbe/cjQuOgzI5+9YACJsanLhnlnv5gCK6ZmB2IL/n2K0F/YNSRwazDomyMgj2RgMWQv;4:wmQCUb+BgiH8cu7x/hKmV6/Z3dpyHmkZoBoe3Gndjty/Js2PBNbmneeVdzEeNpKFLsUyCjvGYy6zABZtxU0Z6rrvpcQ/QdQU6kG24NbZPEW0t6meP8Ku+YPSbT7xncUnJygXQZULLGIWr9u5JnXGGH53BsKxbX9C2zHTJY6RFRuol32TA11Lz+FRD0jrV0lO8QKTHNRD5WpGt3h8K3A5qihlQRRegb9LRvZY31Hv7g49/3/zDXkQWIrCd14VmrIUa9WlRB1tD8BS3EXtumPB8O4Vdi+c6o1ZOjpNogs3Wf5RYzNqHvrO0uk/m0FenGK+
X-Microsoft-Antispam-PRVS: <DM5PR12MB144919632BBBDD21C89CD3BCFD900@DM5PR12MB1449.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1449;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1449;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(39380400002)(189003)(199004)(81166006)(6512007)(1857600001)(6116002)(53936002)(72206003)(3846002)(8936002)(478600001)(8676002)(81156014)(25786009)(956004)(5660300001)(4326008)(86362001)(476003)(2906002)(486006)(575784001)(105586002)(186003)(16526019)(68736007)(6916009)(50466002)(6666003)(106356001)(47776003)(53416004)(59450400001)(2361001)(316002)(26005)(58126008)(66066001)(2351001)(230700001)(7736002)(6486002)(52116002)(386003)(103116003)(2486003)(23676004)(305945005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1449;H:sosgrh1.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDQ5OzIzOlloR3ZaRFhiTDVMWmEwRnFPbkFkY3FYNlY3?=
 =?utf-8?B?eFhTb01HY1hWWXlvRGFnanJjd3hTNW1uMlVLek0vM0NmN1pDWWxRa3hRRjJC?=
 =?utf-8?B?VUdIYXg2NUVsVnRpOHFzejRDY3Vhc0JoaUtkVGxRWlJMWGcwYmNEK2k5by93?=
 =?utf-8?B?MmNEMG1iVkJLdDkvRUtkN0daTlAxSVl2MnBqZHpmamMvUjg4S1c4VVBkTDZS?=
 =?utf-8?B?UFZIMGFCbk81NmRPMy83Z1hrQW5WSUhVK251Rkt6aUNwTzhRZmtKa0tGcG9F?=
 =?utf-8?B?OE1SdUx3UmRMRjFvUXpKNzY0emxmbXIvSDlRRktPYWU4M3ZmMFZnV0YvSWpP?=
 =?utf-8?B?bDV6cDMwd2NvN09rK2FhMUxDZ0tKNHgveWxmU25MajJEZGErRFppaDE2cC9y?=
 =?utf-8?B?dU52NWxWTUVTcHdBbjhaSGpjVEV4U2ExZnhWbi8xSWZsb29tMkp5dTQvS3kv?=
 =?utf-8?B?VnJ6c0NVZWFwMlZNdzNwazJveVlpdDh4eDJLSVdKdThqcVU5Nkt0ZEJJbVlu?=
 =?utf-8?B?OGlhTldvVTZnNUNna3h6Ujg3OENOd1dVTlI0ekpaVmRpZU5yU2dPTHNic3Fk?=
 =?utf-8?B?UUp0WTU3aW1XVkFFS2MrM3ErT3pJSHo4NjJDbUwxNDNxVDAwYnlFTnhaYU5D?=
 =?utf-8?B?dW5KVElzM0F4b044OHRmcWUrNW9sQmEzQ2g0Wm50WGp3Qm5OZzFwenpKanVh?=
 =?utf-8?B?NkVQWm9kUnVwRjVtNzgyK3pIdTNkTUtEM1NWWE8vY2IyNyt6S0poTTl1S2tP?=
 =?utf-8?B?Ung0OFpPdVcvOXFBeWRBZ0IyYWszZ2dCOUxpbUV3UXhlZ2pKSWNYL2RXQmRp?=
 =?utf-8?B?RzB6aTNKcjR6RUxBSzMzOFFOQTZLczU0SDJ0eW5PLy9oaFlnaXpReE5CTTlC?=
 =?utf-8?B?eFhucDFIZmI3VVY2UWhPWXB6SmtLNmk3bjdyeG9GRDBnVXVVQWx6R2Q5TWNt?=
 =?utf-8?B?cmFWejI1c3FxdnhqdEpKZXJ6K3RQNkRWeWVqc3lESVV0TEhMOGRtWW1UWHNW?=
 =?utf-8?B?dzJFUExiQkJHTHZYNU5US3VBSUtuUzE5Rk5ReTlLQzBSOWJmWFhPNXVDWU1n?=
 =?utf-8?B?VndvR2JIczU4cldSb1VSTmdScnNxZGdZeTVlQU5KT2MvTmJMeXVaSjUvU0o2?=
 =?utf-8?B?MUxwNzhOUlhjWEZrdVZmaytEYklYTllHWVNkWFVzamsrTWFkRlJDU1BvbUVC?=
 =?utf-8?B?SGlMamNSZ01LNGNUd2lhYTZTZzA4anB6Uyt0eEdGOFAwZWhYUmxHMzNjdVFP?=
 =?utf-8?B?UlJ5VndLTEVyR1lmWVl3V2VNYWNpUEo4bjRZKy8yU0xla3VSME1DTG5kUE1R?=
 =?utf-8?B?UjN5Zk0zSVpTRGNHOTdKNFhENzNoNXhSOVRXdVdiZ0NGek9DYVFXVlFFRHkr?=
 =?utf-8?B?Vld6NDJDcWRCZFlxdkZqdmJzSTJSM3o5Q21aVkRUTUtkSmtXRlYxbURnRzRu?=
 =?utf-8?B?aG5rVUtKZ1lNVUpVemg3bnJiWlowM29ZbXIwb3lOMk1JdERIZ2hndmpSa0la?=
 =?utf-8?B?Qk9zWk9Scm9kUjZtN0lLb2V5bGNIOUU5aldXU2NPelZYbVlyMWFjaENRaGMz?=
 =?utf-8?B?NGpKK2lua1hMWjZMNTB1a3htMElnTWdWLzB3WkRSdy9rR0N5RU1VQmhWUjdk?=
 =?utf-8?B?K1h0a0h4Z0ZyOEt5eFBhR0lsUVI4TXpQdjNweGNWQi9Kb1JaMUw2TitPQksw?=
 =?utf-8?Q?F2XWbfe74kcAWgokxM=3D?=
X-Microsoft-Antispam-Message-Info: /P48qDeeADVDO2cxykWRPg+0pP5p0jXwkL2pWoK9AjHZgluvkD6MALy11Au45ZUrRRDHwkoMxy9gztQt20+4AffxQbsDHBe+4Sxj7szSr3HB/VP4ThYvIQF01CrpU434LAy/GFbc5fnb8FCwxLnUxvhipp5KqXOeqXBkIVhaJ/gzkcmWQkQX3vDpvLAWF/pD
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;6:G9XqgniJ1OSmr+XXTRsiEhCdi+o/lNCVNPuTXQUAuse16PSSHM67wtkYU1eA991Nn+BPabhwuOC404xzZLZbr/qpx4rPCdt0fNzPpuCPqufzUSG/ITDgHQCCxHbOuwXaH8OMCq6/Iq3B89VKHvcApKQ4jGcHpfecr0Pyy2TuiaJxka+jPwnsoEcOJ+cYqqQTEOi8U6Ng9/vfH5H6HGrJpX6Omh5xGCK5hZInDEZ4s82gUWOzRTEAxs7y8WCLEFQS1mV4hCzMejrH7wDqwbMOoPCouq3yuDsz7K1ntcC7/yZ9hwEKlTVOBIxvIoqmnhd06LYdDcYtS1HV+itz95fvzTjyvIuW8spUGvXjqiNKXh6GIsh/dQwkCTExDFg/UY3jxl01YmRINCKFPL+Vjfi5AYwwO+3V+tIjtWuJL+9ovbamhRiFq8ySOkDNAlZXgnQhTMLbVG04j/cp8AiqVhYj8A==;5:kiyAVdjXXQNNW65x6tlA4iBGc7DLGmYSL2607Z3MaX77OMcXsbUOw1PX6oYNKFuV7I30ltB/Shb7nXcB5NAS5ZXR/B1a1u9DCWO+cOOtqgcGXQo0Pp5T+6WZXEzuCKWwL6LiaQ2YHqeHhuP8rMHO3Wx/pq2tApaQlbnT1y/TDgI=;24:B0CHR1dchPaeYLb653dCABUdf/DL9DaORfD6fOWGrSkqBWbK0VgI5XmmZhng9NJmvswb2xsA2hVzGe9N0i1FkDJgchApU/el/h3y2lpRqXU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;7:ARNmg1knXcZIgV1u+IZP9wBRyhcsm5p7Tqc/+rH4Otz4wMyGRX9qWpprlTM8+67ws/IhxAsC7SX4v+DK0yEKwpNHEwQSe8KexxCUZMYNJmTMPMCcViUNDlVUWlBjWxP7diHBtzPAoxuwYd0b1ytUu05QmzAncgVOCp8CRnYw50+jdTyN081g3Uq+8MwsZnn8rpKfJggkOBT+5oSsN5OVNySDU+Zda/yOTMhAM4lVbHO3TsAHnK65EaaK2UC4U8sM;20:/90n4FtZFV1MUhwArs4bVY5C8kXtx0YV9YdIvgHcatW3YqP9SpaFtL7X3++FpGjllKNYs34+hvQhCF47JxLMLMM3E8yykakwnRMohwJ5KKndQDZTF44C7PDX0Gfnxu5BHlWYzVG09vY18d2lFYLgzCupt2fU1YKhX4nTcj95pWTEzSrwLXVN7yO3Y+sxs1KiC48Du/fjkPLqjTqgCu/rrKoRviQFozzegCABLFZAozMOA7MsrHIFrt3ZxztrtBwb
X-MS-Office365-Filtering-Correlation-Id: 1abc9049-c0db-4ed3-6cc5-08d5bd0995ef
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 21:52:00.7602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abc9049-c0db-4ed3-6cc5-08d5bd0995ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the performance of the PPR log polling function (i.e. the
task of emptying the log) by minimizing MMIO operations and more
efficiently processing groups of log entries. Cache the head
pointer, as there's never a reason to read it. Ensure the head
pointer register is updated every so often, to inform the IOMMU
that space is available in the log.

Finally, since a single pass may leave logged events unread, use
an outer loop to repeat until head has caught up to tail.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu.c       |   69 +++++++++++++++++++++------------------
 drivers/iommu/amd_iommu_init.c  |    1 +
 drivers/iommu/amd_iommu_types.h |    1 +
 3 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 77c056ae082c..13a550fb7d47 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -660,51 +660,56 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 
 static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
-	u32 head, tail;
+	u32 tail;
 
 	if (iommu->ppr_log == NULL)
 		return;
 
-	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 
-	while (head != tail) {
-		volatile u64 *raw;
-		u64 entry[2];
-		int i;
+	while (iommu->ppr_log_head != tail) {
+		uint count = PPR_LOG_ENTRIES / 8;
+
+		while (iommu->ppr_log_head != tail && count--) {
+			volatile u64 *raw;
+			u64 entry[2];
+			int i;
+
+			raw = (u64 *)(iommu->ppr_log + iommu->ppr_log_head);
+
+			/*
+			 * Hardware bug: Interrupt may arrive before the
+			 * entry is written to memory. If this happens we
+			 * need to wait for the entry to arrive.
+			 */
+			for (i = 0; i < LOOP_TIMEOUT; ++i) {
+				if (PPR_REQ_TYPE(raw[0]) != 0)
+					break;
+				udelay(1);
+			}
 
-		raw = (u64 *)(iommu->ppr_log + head);
+			/* Avoid memcpy function-call overhead */
+			entry[0] = raw[0];
+			entry[1] = raw[1];
 
-		/*
-		 * Hardware bug: Interrupt may arrive before the entry is
-		 * written to memory. If this happens we need to wait for the
-		 * entry to arrive.
-		 */
-		for (i = 0; i < LOOP_TIMEOUT; ++i) {
-			if (PPR_REQ_TYPE(raw[0]) != 0)
-				break;
-			udelay(1);
-		}
+			/*
+			 * To detect the hardware bug we need to clear the
+			 * entry back to zero.
+			 */
+			raw[0] = raw[1] = 0UL;
 
-		/* Avoid memcpy function-call overhead */
-		entry[0] = raw[0];
-		entry[1] = raw[1];
+			/* Handle PPR entry */
+			iommu_handle_ppr_entry(iommu, entry);
 
-		/*
-		 * To detect the hardware bug we need to clear the entry
-		 * back to zero.
-		 */
-		raw[0] = raw[1] = 0UL;
+			iommu->ppr_log_head += PPR_ENTRY_SIZE;
+			iommu->ppr_log_head %= PPR_LOG_SIZE;
+		}
 
 		/* Update head pointer of hardware ring-buffer */
-		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
-		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-
-		/* Handle PPR entry */
-		iommu_handle_ppr_entry(iommu, entry);
+		writel(iommu->ppr_log_head,
+		       iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
-		/* Refresh ring-buffer information */
-		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+		/* Get the current value of tail */
 		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 	}
 }
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575d1677..227a9887feb1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -721,6 +721,7 @@ static void iommu_enable_ppr_log(struct amd_iommu *iommu)
 	/* set head and tail to zero manually */
 	writel(0x00, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 	writel(0x00, iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+	iommu->ppr_log_head = 0;
 
 	iommu_feature_enable(iommu, CONTROL_PPFLOG_EN);
 	iommu_feature_enable(iommu, CONTROL_PPR_EN);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 986cbe0cc189..31afcc54434c 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -548,6 +548,7 @@ struct amd_iommu {
 
 	/* Base of the PPR log, if present */
 	u8 *ppr_log;
+	u32 ppr_log_head;
 
 	/* Base of the GA log, if present */
 	u8 *ga_log;
