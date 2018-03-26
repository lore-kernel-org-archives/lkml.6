Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeCZRFL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:05:11 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:57120
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752665AbeCZRDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:03:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH 5/8] drm/arm/malidp: Enable/disable interrupts in runtime pm
Date: Mon, 26 Mar 2018 18:03:17 +0100
Message-Id: <1522083800-30100-6-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:803:1::31) To AM6PR08MB3032.eurprd08.prod.outlook.com
 (2603:10a6:209:45::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f23c491c-9e86-47ee-58ba-08d5933b8944
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3032;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;3:fEdi1tRcrdPMbDP4UCrb4iQbmGqlYqV8PxcT7YJ2fpA4GNeMH82N/EHglFio98pN0W9Qw3doB7T3V6de+CdZFoFSlVZoJQC4KdqyyZFtp6s8IMZoKuvvFb2ptm//NcboSh0A46LPq8pQJ8R2isH1YoOrW1RRrn4Gpo8guNiRNpwMtD755B0CL0uxXrH5A4RzLJCRcNedWjtZCF5coZm/xrzIi28RqFQX4Bo3RG7h8kgaJgtK5KgQNqCBpfmS7cUv;25:3qfX4GF6A+lNuhjxoJ8v8Ef7eRcv9g0+dK90mAZKYeV/JBY9/Bzz5oSY/sYXJDXAqLjgjspiErH50pP0WfOkaFGd7waWkU4eETyP+UjV2QszH9SLpc7CJS0JEibzEuHlo54Qm0KM5fI5Y8OdL4ur56SeCDNBuoZzKFMPHNRWpdjaWRhxxHbbAz9sAsOX5ujZ3idRf4L3rP67p/tZWH8UNQYOZBV/9o0nNtUTpQjjM+KX285LBdXCquCgPS3R/8LN1EZKqne9J+U2XM3ubnEIAXqHNiwx8gIdvDwk/RoSZCAidgp1xPcqFTHUS2q03sKpbnzvcr7ZYH/26+MnzYs66w==;31:vPkx8ThWbGrZGU7fuKoMEnTzdRZ9GYf9Ww3sZSCNZ6KHJFpwelu0z+qoxyVcun2RznvQ6a6bCNV+B/dMV5RZRWLKnVzJo85piGq0ERcJSJ/ViRQlXOj8Zdr3uxeaKjVqOBcc8XI57dndkX0btBRB6PurfaUxeb326Lfg5g5+FfYyi+stB/AlY4hPm1Ep0k1ocFniEhW2+HYZV4CELjHgo89MSedNdtDxejJxqhrR0SA=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;20:Ud0ZNcZ8CpfnYCkDtiRH9mKfeM/I0GqE4jGUx9bi0c3c0MMVTxuCOQokEcLCh5XGJpPr2mRNRiaviIgH5cC5KTvUJf+h39oS6sSGMknJ+j2yKGHtte4+7YyGFmU1305R0GfIh+TaYjBDzDSAgCwVDU8Pgg3rZyiX1EpQUDGm/DI=;4:ZJx1e+MLxEDslmgRjmqY6sLe5kNVQktZwLphWSpNUHIRfEpSr4wvTsv+2ffOiB65JT9sVaVozFdGaAK7nz0kYsKzPrJ37jnwhJTI7Q36KgUlXZ4NpBU7MA5qx5BJiOZZq1vlIiCAxzX+zxQ3Z+g/vexD4feFdEONNd/RTeemmvI1cP+VFL9SYRNKI2jqmOApjpBnTG3NrDJMzBpq9dyr2SKM/ctzgLHNrZS+wxb1IWLzEHsmfXMxs2LzLrnHKIa8RIPHjQtqAn94+u3krJGGfb0yRs+u7cYvZ0Xv0bMsXP+7DO4vsxxxbL7k5Jz7PSK3
X-Microsoft-Antispam-PRVS: <AM6PR08MB30325E0CEB370790C5E972FBE4AD0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM6PR08MB3032;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3032;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(23433003)(199004)(189003)(76176011)(305945005)(26005)(8936002)(446003)(86362001)(478600001)(11346002)(6486002)(16526019)(51416003)(72206003)(7696005)(7736002)(53936002)(4326008)(486005)(486005)(25786009)(105586002)(47776003)(66066001)(68736007)(97736004)(316002)(6666003)(2906002)(106356001)(16586007)(2616005)(3846002)(52116002)(6116002)(5660300001)(8676002)(36756003)(50226002)(81166006)(50466002)(956004)(59450400001)(81156014)(48376002)(386003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3032;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3032;23:Q1JwyZxkXKh3F2zb/apW8lRX03mgduCFjenr09YUe?=
 =?us-ascii?Q?Y/b9BpPcDdEZPt1RRHFrgT9U5z05CNPxY9gD8jIT9jaLL+V7WYG6IWA0QBxU?=
 =?us-ascii?Q?P+ytkjibt98Bo8Xi9FYK2B2Pi0a2+M7LCF6hKSeAHIN/oSiWCIBZejvfcxdh?=
 =?us-ascii?Q?5qL46TMCDX3aPOPEzsLRMeyQhsnRKz8i27f7MWLahXvMr5GiBCNgywE0Wre/?=
 =?us-ascii?Q?+UkmOLaG6+IzOpithxqyKWUvnxV2GTcMLII1+C7I02Usp7nYdR3WSEvuODnc?=
 =?us-ascii?Q?k+V0anvKNlOVU1NFfn0dodzUNSQaRu4wR44DPYo38cP2EZqBX2LnWRgCy2Mk?=
 =?us-ascii?Q?XSWlN85xeVaFhEKsmo57Rg63pA9ZlYEGqmX29I4qe2sanpViQtwFWA7bxyU7?=
 =?us-ascii?Q?9tjs75lILvCodcAVii1xuLfmzOistw7udWiyYYtm76uXn1DuubzQxkvTLBdW?=
 =?us-ascii?Q?bdFieC/xsz1BpbKmLSMYUcNUO9kYt9FNNayjCU5eIP+T52P05JPzN3fS9Ri2?=
 =?us-ascii?Q?mA0IapMqrYkG/UTVX5kjaVO6mlbfSl4W8GU2J23EZLF1TiCl8Detxn5ebB/Z?=
 =?us-ascii?Q?i+jv0FEoxhAZNohVHZ9nft/i+O4rJAljFvlojXVM3i2UGipGD7WBZYe3Nhg+?=
 =?us-ascii?Q?LyQdEEkdE4RheNBXt3niGRpvwyatkc1lPgJNv0Tc0awES00fBAURrAkzjeTT?=
 =?us-ascii?Q?ivTwSyHGUZSql//8FnrYolRRc9B2YUI4lgD6KkXxu7WrATQxt05uizxq0eL4?=
 =?us-ascii?Q?nUqi6+FZ9PucLaN3YhK/R+lBQ4mNLsZXFVbGcewwhcHKW+0VF8NqON4dYAQW?=
 =?us-ascii?Q?I33hNWvS0ME7OUJQBQbKMTIBQDx6nrHwlgXNOoYECfeTaojRA9GIcXVcNa5R?=
 =?us-ascii?Q?qSProKs9hFMN5xUDr96fQNG3zHBcbH9AHAUSsEUHyv5CqIbGqBbxUFzG6eIc?=
 =?us-ascii?Q?Gqrqq1ffIiC94JVC1Ma2tluaDWpDsD+S3ZIDKNU4HANNm/jUAetKxtD++wgS?=
 =?us-ascii?Q?MViH0KsnI2yL3nHe77xFrBFXvPgFmGj8UsUxVkNaYtrNrF4EauWfVWXc4k8P?=
 =?us-ascii?Q?8We3w5I0G8WAelokyUcQlbIFv4/iIdyeqatnPPSpbyYUZYEHxOU746MijYR0?=
 =?us-ascii?Q?QcgPAbwmTsFDEiB3ocCFDsSdle8sG/eglh6t06oKRXD6cr0kfIU5pne5jLKY?=
 =?us-ascii?Q?1Y2y+y2oVjLv1Mvl+u2tEgGhUfk0LaPaYKT?=
X-Microsoft-Antispam-Message-Info: NGPlmSRFpGkjvGbyOmeYdgWmXWfook4sQCd6ZdZbQkBpt/AG84nwm701Ldy2W/X0VLs+dR0fWfdqa14yI1lPRrJCXYaU38B+4WpLwL7u5/DkQLmMrQ5Ju3gQFY6AOT6fbEOglQC0uVgkoh200cqvQjtJWs6gHXG8MOunnMBTQd8Ntju6CRGhJ21Wpu8LyO5i
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;6:hw0fmmneSHmkeuQ1eWLLwDIEb68joT1rNOl20EdntZ/XpT5d5HGs61Pyi9cWwpWY3rsdVZlKYSXFQUeDrmtuPvmQRJQXzD8flc/2ivxjEUgP1yAb3QXSEh2A6C6UPziS5jx4WTo2hzxuyboccRI5wqd3NywuOjBlkDiLrQiNkxvxf1I5tMRGsFlNXaydt2P66Agmrji45vd8A6M8WhUOpcZpyeN7RVRdU0QXhujj86OS7kc40cBgtWuT7/XWNAyJ/yXoKzIRexSADYrGbeWbJBvnhbwveZrjxhhpBR/baLkrptupur7yHtfqLfdRWyg5BAoMWIxr9tvp2uai/YY19BCthFD9ecmutE7cnqJeHZqCAEE3qTp/9XjxlA0YjeWe4MZKGrsozdk2HoVf/vkhlqHWrLUtOn3mFfGVLBclUmDP50aPU9738xG8Q9SRyElhpPzqraQsO50w30uKcSixwA==;5:wrloxkJmJPbgB0ZqxqY1PxoMwtOeKmNxzw+pe1EEiiwUjVs07ntn1s1SVrkZGrexZilTxMu35QLjyoMi6lrtEdyhjdaEjFyxh4lAPohCipDECc7hbJlLq8fg5H3yQzG+jYO2QlesrZArxoxHAnq/+4YUKvtJIWCBXDEla8VhWIc=;24:hynWdcr/CmqgwvNCQOcR5OsrLRc04E3rjc/f1WmEywoqenKW82+fvNIxJIaTwCA9AGteQAL0qXmdN406jXhb0ULjx54r68XIDSFUebnSJu8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;7:jxSoF8YBODFicLJpB7HTe0WuoI7DF7rMuMpy0ut4aLqfTKMS6MOyDp3zEX3b03YU58i1zL0rC9I3FuB8ALYvZeeb7MYFJaDJ3gQJybJpDVPq+d0fTeUuadPuqPeiNi+ZmmZCtjGK8col1X+lSuk+0rB+towzoAlWsOIfdPimFBNWdbZAbUEw+9Ulhc0gdCwav57B6OjXbKZpJhca+0rehTSdFgxsvjRXNAjVa/4UKn3/9HwDE4hkkiAMuYtQYe/A
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:03:45.1541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f23c491c-9e86-47ee-58ba-08d5933b8944
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display engine and core interrupts need to be disabled when the
system invokes malidp_runtime_pm_suspend. Consequently, they
need to be enabled in malidp_runtime_pm_resume.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
Change-Id: Ib8e5e8319fdd768f8a97d9b5960fcfa8ba90eba3
---
 drivers/gpu/drm/arm/malidp_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index f7a8beb..e5a1fa0 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -470,6 +470,7 @@ static int malidp_runtime_pm_suspend(struct device *dev)
 	/* we can only suspend if the hardware is in config mode */
 	WARN_ON(!hwdev->hw->in_config_mode(hwdev));
 
+	malidp_de_irq_fini(hwdev);
 	hwdev->pm_suspended = true;
 	clk_disable_unprepare(hwdev->mclk);
 	clk_disable_unprepare(hwdev->aclk);
@@ -488,6 +489,7 @@ static int malidp_runtime_pm_resume(struct device *dev)
 	clk_prepare_enable(hwdev->aclk);
 	clk_prepare_enable(hwdev->mclk);
 	hwdev->pm_suspended = false;
+	malidp_de_irq_hw_init(hwdev);
 
 	return 0;
 }
-- 
2.7.4
