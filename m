Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755796AbeDWOwR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:52:17 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:26568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755443AbeDWOvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:51:22 -0400
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v2 6/8] drm/arm/malidp: Enable/disable the scaling engine interrupts with memory writeback
Date: Mon, 23 Apr 2018 15:50:49 +0100
Message-Id: <1524495051-3891-7-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
References: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0701CA0055.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::17) To VI1PR08MB3039.eurprd08.prod.outlook.com
 (2603:10a6:803:45::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3039;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;3:yA0eLf64wxM91GYlk5j6hE5ggJox/IC90EbNimmUOnBNOvwUT/Smir2chWEz6Iq0Qs52HJjnIXW1jqTZczZ7gz7DJga6xGh4Aads22W0/u/402uhCpJUB4KG/sM0by7iW2JRJ7KaEo6o6auFpUChOr+rpv73yMhymMijrypajaEt5Gp26wqjITCoaUZQ6ehZm0v9AFmHCdZGTUNKidIEfn3u20JamxIGACiLgf8xR8nd4XWT1TMgqCwcRzt4+l7F;25:RxKj16Q8vZ+qN5FvL/aatungq6PCeugAbZak5Ieuj6lhSo2J1ApBVS3ENggd7EurNIU2EQYMbTBxAGVtq8ki99xFuE6/iJ2Bo17dp53kSmCWEfmZvHdxz/S8T5SmiVlRcfM+DnkJe+yOc87ghRadDU0LA7/6buQ3vI2WM8RCNdIY84axzFYVMq36KQ9zOZdYgQ9WwFq42ayjQgyBTpnQszJSDLDjToU21qMuNNR8ZYr4XFO23xR7qUOAhnvuLSDgnDMY6eMDbKad8P/eUBsLVWUHCVuCEUFj9Zlav2dl+Q2a/NNM4ARDWtuKBbw/6tFkeD1Z2ncFeeG5hpaa1isDDg==;31:q5NV6I9FRolRhmdrVZ3ndUSAR0HGHUo012i11oXZL6iOsL1cqTYe+DzbcjEwu7e8H1lubldYyF6xFO6fq7Mdyf+4iCCiTrpNFWE6iBbGY4wEn8VYXqHSyOmmkvjLxFYRX7xFUOsxWzQyyIixGj0huVJMZnjqRNfJZ9ODdynrjwSuOj2HlQ96qOudwDREpjQv4XcLYliBtXjp+GjZAHXrkoGKjgM+5GJ8rURsfRKRikQ=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3039:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;20:XGom+4IUjjh88jUndfOKclAJnGDOQUrk9fztQFIg4e4QZ7JETPy1wOGrnkMkxxBxzE5SiPt2hw1bF2XTZhe+7oVBNEMbZq2wc0hpAFGO/WaLA6sjauju+F7onVOLnaO9NDQABtoSHy+Slo+wnCz64TJUgaaxi5gANGOZtZMeiac7NZf64fw8uK4t2ionnVzbTyXBhtRkmS3a7LaZBev3eqVa97Ks4xcp08GCRyMdjWiYOMftuI+lMm8GhGjVUp+0;4:+d8dxQ5ZwVYag1VxWLpSUSrQMHy+CzPtB6feNP5dbrZcyNkixum0NXoBcGNcbs3sLZ2oHKKPUoNDY/hNp9wyAOhHtFvhRM81egeauoVYpuvM+V5NkBZgg09d1II+VmT3P3z+oWmzS1966inibnnyKco6gUpKqX+dif+YtzDgV+dNxJ1gwQmbVOabcPsVIh7s32iVGAnV6UUKsUnzG0z9yFabY/O9bga/+HFLKTH9w8o24Q6WK0/+o9lzHi8to7nZddPSRbL0gvoyUul5LCpvMxOct3zoQYBAulAUQAv63fkQY4Xpl4vTB0s2Huq8v/t4
X-Microsoft-Antispam-PRVS: <VI1PR08MB303912426038A82BF904B534E4890@VI1PR08MB3039.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3039;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3039;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(366004)(36756003)(47776003)(50466002)(6116002)(26005)(81166006)(3846002)(8676002)(48376002)(5660300001)(7736002)(66066001)(305945005)(16526019)(446003)(478600001)(2616005)(956004)(476003)(16586007)(52116002)(76176011)(59450400001)(316002)(4326008)(386003)(25786009)(72206003)(6306002)(86362001)(6666003)(7696005)(11346002)(6486002)(2906002)(8936002)(50226002)(966005)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3039;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3039;23:X8vekrW94BdnnLeIUR3xaqoy5O5daC/zsF9A0JJsc?=
 =?us-ascii?Q?qSnUbnSt7YgmT54Jibxy4ncC/zIZYdpresvRg+x47avtvJBQethtBx1kG0Oj?=
 =?us-ascii?Q?E97XowGOW+8gxUSQL7F2Gzks3O0uoKaXGOZem7kHJB5ti3jB5oPnyqNw2OmO?=
 =?us-ascii?Q?ZO53prG3Y6crNzmk74flQl1revVHOF813JLebaVSbRwnm84JbQwXXfmmVk1V?=
 =?us-ascii?Q?XVqOFKq7HROD8abN6JM1ub8R8UpLglOGDsWLTNm9MfuZLcuEgyKSAeIv3YbV?=
 =?us-ascii?Q?+HxXmWyWTAnD/NzqeWXsysduAXg4qU3Fh4t/zdIZVk7ubYTaQ0/AHB/3XuUk?=
 =?us-ascii?Q?oB5N5uotEb1C5Qy+bvqa8o4V71fB3SHlKcF41RqLG5LXWVlJG6LfSFGQKhoJ?=
 =?us-ascii?Q?r+q1BAgWCWwKC+yQXQu09+XRlEqYFUaqLKCrwmsJCA2G8AjPC5yhDFshinAj?=
 =?us-ascii?Q?pRnQnEoYYMnCKGqRoQu1Z9pqxxNi2YWjnHrU3f+sJhk+YV+kHdQNAPnEJlNW?=
 =?us-ascii?Q?8DBO35Rtux6OxfcYRpC/57uFqQSE10atody22PloZv5iROQJVZEXYoWlvNMU?=
 =?us-ascii?Q?Adw6Fy9qHYARsAaaE98CD6W/5OhopodN320jNz4U29T7IA6nVIF5DH6WniTW?=
 =?us-ascii?Q?/omFpNSl4g84c2NGmtTjsYCqGet08Efcqhuk5HtrmleGg31uibo/wwo6l9cx?=
 =?us-ascii?Q?yya70qXQFIm+a3aSTaP6Pmpjt+MjA+iGsUMH6RxfyDtwldEQ2Fqq5ZbYqbgt?=
 =?us-ascii?Q?TF/A1WRjSWOiBUMJFseyDFGduByP7crf1dBAvgn497b/9huGgqb/pbBVwXul?=
 =?us-ascii?Q?UXqNvmrcbGr0yQFgmm66nn2g6JAkDwer5CbHSoNIcttWSCLasuJQmAPxL6Uw?=
 =?us-ascii?Q?Z+S3ksxarrQUfOUBkljkKMPOVurJTDWFdpToGhHIUwxwzENvRwDFA43Vch16?=
 =?us-ascii?Q?vRWZOYPgZR33JB/rZSwWWHHqzrsonYq0ADaSj09eOoDTYqUbr4jGmf0A+jAS?=
 =?us-ascii?Q?JEXxKDFqr49GA2kWVPe6SAU9707x4wsoM794tbBX4orNg=3D=3D?=
X-Microsoft-Antispam-Message-Info: UqrszmdVCHG8zZNj2SfsNEXpWwQ3d5bpyjI8jHjKrEeJ72ojPTu+WCfeCjOcslVKncoVvSoCyr9rYj/a5LikIMhW03j+4tCWUX+A895gFYSvG/m7x4+DIFbp+SVcFj7qiGJug7h1TN/L7gtpzG6q9lhfDL5tYCRfdMwiIoYKC6vtuLIgEPniZZcKEx1Zo1Ut
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;6:znj5T7Bo7W5iUSUzoPUUntWXMMVeOSSa4014OtidD7Brpc3kxzG8Iqi4M/TOtECogj3/3fuEFQemxSw9prqUdSlCGk49wIBqPPaNheqZJPhi0YHfz3y8L1XsCuULmKkE0py/OF2tU9Dka1yjQs/6VA988At7fyH80ctkHHGEarcrUJXK3QeWvCJCnn+l97hgT5YjRHXZzbiukLahqMxVzsdVVQHJjvEApPQ9Md2XYjGUjs/aj8jqYpk9j0ZMuhPa9amDiDtWJT1XlIaIDvTPa/aAe8C5FPAtoAr1yTPlkhhrnSh2VBmCse4tiPSeFt2UMCMyLJrzVRqr/40uscwgke4rCOSEf3S1fPaKdp4867j4ayw7fwPZ0PXoSk5VTrLsRtWXauaAnEX50Ri+7xjgGDAplgVHuxhdzbp4fuwTHQJHOHx03RJmXt0YaQt2zvZfW/pQC2CS48330scKBk9Ovw==;5:qyx5kbOrhvrWriGG6T2u62CAngOlKlIqf/ms1XCb401v/WCM1dJeOVISmfcSGG++qGk1VusNwZLCDSVvBvS6Nt4rsJyAl3PPMUkDN2vJRYWd8CY6kpjN0aOxifTOiPY/qvC9fpboKbXdDeGTXjhM9mHNzYL5CPU909HYlIiDCso=;24:BB/0v1tgOMlXBTmM5P21eKFAgjY7dzHzNNzP4UbkYzCtWsjPArQqda2SqtvYSDE/Y40Yb/1H7VxqvzDPLwWCdXndzjTmp3Nw+JkxkVdTFtg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;7:0JawdeviG9WvO83+MR7tOP//cEpTgKSd3NokvvBYVZT3CxGY0p2nk/PNxRm0rMDL7XA/0Ju15JceRUiOhtLzyhF42V/zC2DrAiIl0eVZIWholPAqD7qhTBfMEf/8yX+GJiixbczB1YkjP+BDcC8LO+a7UxrMZ4vBIozQn+TAObCzE0b60qgF/u5UBQk5Ty1BYHrWFgTvpwnsZn2OQFVjBAeda1UyidKEu8K1uAhuLYDyjC9iw9834pdw4pFyctdy
X-MS-Office365-Filtering-Correlation-Id: 404a38ec-1c87-44b0-c81d-08d5a929a6bd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:51:09.5564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 404a38ec-1c87-44b0-c81d-08d5a929a6bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scaling engine interrupts need to be enabled/disabled as and when memwrite
is enabled and disabled. The reason being scaling engine interrupts are
used only by the memory writeout layer.

This patch depends on:
https://lkml.org/lkml/2017/5/15/695

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v2:-
- Removed the change id and modified the commit message
---
 drivers/gpu/drm/arm/malidp_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index f5633bc..90d76e4 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -621,12 +621,14 @@ static int malidp550_enable_memwrite(struct malidp_hw_device *hwdev,
 	malidp_hw_setbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
 			  MALIDP550_SE_CONTROL);
 
+	malidp_se_irq_hw_init(hwdev);
 	return 0;
 }
 
 static void malidp550_disable_memwrite(struct malidp_hw_device *hwdev)
 {
 	u32 base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
+	malidp_se_irq_fini(hwdev);
 	malidp_hw_clearbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
 			    MALIDP550_SE_CONTROL);
 	malidp_hw_clearbits(hwdev, MALIDP_SCALE_ENGINE_EN, base + MALIDP_DE_DISPLAY_FUNC);
-- 
2.7.4
