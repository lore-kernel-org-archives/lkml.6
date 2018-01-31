Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeAaBss (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:48:48 -0500
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:50952
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752561AbeAaBsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:48:41 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, jroedel@suse.de, alex.williamson@redhat.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/2] vfio/type1: Add iommu_unmap error check when vfio_unmap_unpin
Date: Tue, 30 Jan 2018 20:48:05 -0500
Message-Id: <1517363285-89304-3-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: SG2PR06CA0102.apcprd06.prod.outlook.com (10.170.138.28) To
 MWHPR12MB1742.namprd12.prod.outlook.com (10.175.55.13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0411ab5-6004-40c2-cde9-08d5684cc0b5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1742;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;3:ml7x1cGmXEBV08vinS2nT2mhcqohiPQ0zZBTcGhSQkwVVBYbEGy2sdQKvo+/jtjWu50btvELNLswbduAEAk2+Xuj3WlICcz/lewgvHeAsasnm7S3hpoeKMumAwBiAiW4Qgt+xIU4UlVbXKP/n4QJi6y8ZR0ULw+JG8Lug8UnIfW8T6rGO05RYlgFdClJeFYKeqsE2W/HlB5/HYXGAUXJMEnXtdYrcRGV/2E1HY3DCgtFAzacy5GnZHFaT6FdvqUk;25:CbV9lvzoLDMR2kdVeRwdfcNv7cDpyaicUf4A7ZPbnUdDtWOKSTiG0wCFTC0YjO+906ncTmKRFAsdm7G6x0E264u0w9xO/I7b7uLS/ZMOumnQCRq/qMv6UTuXb6d7QlTSdJsIqNYiveHFogataNzoKLxhIYzaEgFpjyCoxqVKkE+B+f1QYbgbOiGiw8Q8IxRvR7dBXEOnYr1qNah6Kzy9CUWi06x+yneOAPpQX4zaWh1Pk0oAqXNGX3kWrFAYz9gfxzruEWRlPF/OrCillTYXDyhdvFPtZg1MxO0NSKpROiilBbqm6tbZ8c4ar8GH5IDe2gypMQqi6/ikclN2Bh8IFg==;31:Nr7yucYxiMvVtYXdfVCUUhp82t4ZasgQmZgyY+4DMEmZxKGMO0/q66ChiXJ1Rc7qRaIfEEwJi1di4Vb7L7dE+mpVAhSv8OW/1B8qqVtiyM14AahyDeKAH+TiQLmiWYHpmjTNk+Drh7RBKnPOgfro6KeqQAR123TWNKmF1xHWfY3MlQOFxegO1sc0sc6kkXejAUCX15w8EVU1fpoPN2b7UPOiObA5+j6BwnPIwLNZZhU=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1742:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;20:lNLcxHh5Yid1te0bt7pWp6DA7UOzzv375zG+BN+4C/doFPsq+wP7fmMYOM57+l9vQOSjhl4o9EwZ1AAphkIZNWtp8zTxcSjyUdFfpdDwJpYXLU3yTcEZiVQBwnSw9m959HYiO4woo6g93N936/m8BUs5XQfvy4pXaIBvITcRNlGCru4pcTBA9LiqPCztnh4fZcpSObpbleLEb9P84S4yqBnxZGe49XBQL8WCL06BHPShY4+4uJqtARHLO8ekznk7WuU1kPO75SWW/bLhTokIoYm9wlduIs8GD+kRV+IWjMW8eQLysBrd/XtFWyQD9jM0VeWz0AQdnzgSBjWmKsvxU/C4oUHq1Hgl/DhBk8u3ygp9AEjVwwEPzkNuYx2xecc2X/bx7hU5w3QNPmV4pxCpTOvQQq3UwT3c+Q982X/XZjjQUPsdqeli4GBLAH5yPWFtSCZPeHgEZIuwdqxJFeWRrFPVXl4w3soQq2LrVxwcSKBzJX1ILU8Vc5hZDDTpHywc;4:P71LCkqKg3X3VykZZ01t4hPsudVX/o7JNe8CJUGp4NRmuaigzb0o25D+q1Ho2bI5lG40/ieIZhV9Rp7NziXExmEyv2RHZZk54Y4pl3DorcXZUhsjU7f9FBlswJcldTnQwWa/7/RUT/wR/pzWWuLk/GGWlKya8T149iV1JrODZP+MCalg9DCi9I95NzVuCU/esWYxEHpv6Z3WZiEVZRyGQvQMWcE7opZAQDJQb3hNsM3E2XmPK1ZYSjsBfXqIYSaNMEvDieCF/8VOFVPuAK7lvQ6digUreceKHT2T9VKFhhsHfuErY8rqQRCmYp7zIkRj
X-Microsoft-Antispam-PRVS: <MWHPR12MB1742BFEE487E6D45D9559EFBF3FB0@MWHPR12MB1742.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1742;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1742;
X-Forefront-PRVS: 056929CBB8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(39380400002)(366004)(189003)(199004)(106356001)(53936002)(6666003)(86362001)(2950100002)(4326008)(25786009)(66066001)(2906002)(68736007)(4720700003)(26005)(52116002)(6506007)(316002)(59450400001)(47776003)(386003)(6486002)(3846002)(48376002)(305945005)(478600001)(36756003)(50226002)(97736004)(105586002)(76176011)(51416003)(50466002)(72206003)(186003)(7736002)(16586007)(5660300001)(8676002)(16526019)(6116002)(6512007)(8936002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1742;H:ssuthiku-rhel74.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1742;23:Aj4odPvBMqNV6cLB8u1BS93jLj7qav6fPgL7ety/u?=
 =?us-ascii?Q?EmnToT0NNKMOL+L8g9PB6hfAxNmtcZ4jOjuNAeH9PzVI7bo7EUOr2Rx9bGy+?=
 =?us-ascii?Q?lE1kAr5onf/YLPYdK3uh/5zL+58CpE3fk0E7d/ii6BgS9Lt08thGt0hbq1yw?=
 =?us-ascii?Q?hBjOMM4CaS8VIO44MIYEUHKZjvCli36/fN/EU2EDxhxpxNAKiVi9MVUXQ/f7?=
 =?us-ascii?Q?FO7/I6k91DFaSq+6DJ3Bzg21KZBbaE+uNwF/LU6gIbINewNY1Xe6D2iseCAl?=
 =?us-ascii?Q?Bh3CqUs3Y2EEf2PAqBsoBRIsKdrR0LVRKpt3vPRfKW5Baes1iNX5FKIT109X?=
 =?us-ascii?Q?1qmfrGrLaYzkkKVbQCWJGi6nn5KN7Eyz8p4EsOw3oeoRJHmF98OiIHig+1Yd?=
 =?us-ascii?Q?qsyzsO3LFIem0wxXm1pUVql/w1cDkxIWsKBEABMBnN1tYSn1XnNpJPnLexHj?=
 =?us-ascii?Q?2YQX6i1OemI9N/WglEgPXRitcPEh3WlyJKzPSOJ2FYAyFrTS8i7Wv+b401Wr?=
 =?us-ascii?Q?ETXu1WKXCxO+fdZyd+PQTt1z1CP7uKA9AvDDtdxGqyHir4rlRdJB5KISBGga?=
 =?us-ascii?Q?/A0fCyGBbrvNBqd5ylw469MvfZ2ljWcgd5SW0nC1AvkjkrwXv0la5Qbn1CBc?=
 =?us-ascii?Q?g9RvKwBlrNYbU7ght8IWwzee+hcKN178+m1lhhgcVTcoMnMcDZGOc9dwb0P1?=
 =?us-ascii?Q?DVFL6CIKWcEI9S/70uKVI9duMizQMn/9eK5kBSyw4M84mkFYIPMqQfbHu4Ej?=
 =?us-ascii?Q?sWi4v5wojvkMyrbkg6zP/6eCgfesThMNvsJmidSPP3ahFRrdOTYkbh5sc+AG?=
 =?us-ascii?Q?4LHwzs7aFo0nbGQdKSlog+QnfGv5Rx4RGDAY9uKrtXF3Vnywj802i9AnOw/i?=
 =?us-ascii?Q?fjhGidCIDCTjcrDahwnfxt5wRTjk4JGii2efz4Rn+bucj9yQyRDNadWpnsm9?=
 =?us-ascii?Q?zFAr5S/nDMV923N9H4wyRoIjwckEtvsjsOqxfK2/ZUg+6J3yTZH8VglrpCpz?=
 =?us-ascii?Q?8J6CzMkWKEqPtbI3UOzUYoIi8/bHFQck6bSPYtew9+rS/9c/8eukUWYqGdfR?=
 =?us-ascii?Q?trYRS5+sjwJQERy24BVXL+n/T1U3eTjRNDRGP/b3RJqId45YBWW84Tm16O+/?=
 =?us-ascii?Q?1KjMOpgxAIIsQB+QoRR7m2x/f34I/7BA15Wj6UXtv1DYMVOmgsnWg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;6:fl+c7x+pOnc6spjeyjcP3vOMG3SNJzcKb2LpMT+0tXWultHx2e47Hlh4q1ivmlEiHRR9AEOG5INoUU/QeMo0UGQqbw+vwZjT7F7mIo6HBqUxUxuFugdNoKByZkkWsb2IvQUmFc3Hdeh3Kx+UHSjyCvR58013jVXjkbDhKLlviZa33XX/5h5qP1ptxVKNeohdwNMESi2Jl706EJJ0ejF8JuEZBm0pxux4ziE/nAV5E3MSZqA24nu1C2pqpHtDAJu0SdKT4VYmq++RUHvBZv9w6uHVshboXUUFfdpoFvFqfiCibWvMN77Xhk7Jc37UJe+XQuZ7PKRN007y8f/ESyAer1kSBsMKVycqVCM+o7lp/Zw=;5:AtV3Be1RUsl+mlDsI1VFznE/lKnB31M1ZrfM/i9Sp1TAmWuGg/qNXUVaaAednQLwE4eaMCfdoSRcjB1vvNUVOgiMFT4SpGsFgcN1p7ssSFSWVXsDZRBhirKnCPRwF9+hUNxmF0NJblVk4GmO/X78VG/p3uoS2g6kVFBtQw1dzag=;24:Va8y4KmWiIDrMihWnHqLBrOZtYeVRT1avnUEqH9pLUYsFtT3IlvxcYrW5Fe0LL9pW+uoIEl8m45HIR2hTkwN65e8SV6owSKwBHGZYQrhR+w=;7:TP/SY1OxeFaWDBpQMCsvRukhvR+i8Ty4vKM+dTfgcScY24BQ5SrNd2kbAlH+SyIdXVjvsJ56zVbShod2phc6ng3g0dNE1rtQ9q3R+VhjpMv6CrleORpc65WIRLXNymnRFxajdJO743i50vrbxqG8zJqlZEwhG3BKZIwb0OSy8fr0bNsSL4zs9P4fc0Ib5uR2yDgKnttSKssG+bv9yi9YVnmSXkU4v5UAsS3Li+nTtDV9Oxo8If0GpQUjODh7jm1O
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;20:85tDZr43A6zyVjZK0bFxv75o7szPDCEzy5qIg+/bH8bG1nriAc/oBj9oSlHZLNe7eSvmk7uprXOXzxEoBijOUHBaQKKFbd1EEBHs/WiCA8t7ahAA0b9hKmZOSMIauQKuTuApNa/NVJ6uy+EgTlT5CH7P4pceMGjXq3qnTiDjftnuvJZ2H7+nNTmYz2QKlhEYTIgBLjaR9Kpr1EbSQ8ppK/gQl9XqTzHb8uMHDC0G8c2DMb3z2hZ3wjClnMkWmWBh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 01:48:38.2111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0411ab5-6004-40c2-cde9-08d5684cc0b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1742
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides zero check the number of unmapped page, also check
and handle iommu_unmap errors.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/vfio/vfio_iommu_type1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e30e29a..c580518 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -677,7 +677,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 	}
 
 	while (iova < end) {
-		size_t unmapped, len;
+		ssize_t unmapped;
+		size_t len;
 		phys_addr_t phys, next;
 
 		phys = iommu_iova_to_phys(domain->domain, iova);
@@ -699,7 +700,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 		}
 
 		unmapped = iommu_unmap(domain->domain, iova, len);
-		if (WARN_ON(!unmapped))
+		if (WARN_ON(unmapped <= 0))
 			break;
 
 		unlocked += vfio_unpin_pages_remote(dma, iova,
-- 
1.8.3.1
