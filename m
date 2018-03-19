Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933171AbeCSLBC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:01:02 -0400
Received: from mail-hk2apc01on0114.outbound.protection.outlook.com ([104.47.124.114]:42954
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932493AbeCSLA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:00:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=shunki-fujita@cybozu.co.jp;
From: shunki-fujita <shunki-fujita@cybozu.co.jp>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, shunki-fujita@cybozu.co.jp
Subject: [PATCH v2] fs: don't flush pagecache when expanding block device
Date: Mon, 19 Mar 2018 20:00:40 +0900
Message-Id: <1521457240-153390-1-git-send-email-shunki-fujita@cybozu.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521183353-144817-1-git-send-email-shunki-fujita@cybozu.co.jp>
References: <1521183353-144817-1-git-send-email-shunki-fujita@cybozu.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [103.79.12.129]
X-ClientProxiedBy: TY2PR01CA0020.jpnprd01.prod.outlook.com
 (2603:1096:404:a::32) To PS1PR0301MB2076.apcprd03.prod.outlook.com
 (2a01:111:e400:c6ce::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b78f7030-4a54-403a-c1e9-08d58d88af1f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:PS1PR0301MB2076;
X-Microsoft-Exchange-Diagnostics: 1;PS1PR0301MB2076;3:7TX0VkAdiXXFxjl8v7+sXUIw9i0l6N7fHMrSmIg6kzdvs8Xky2oOS+vQwdHYjXtWBbXjdURPzc+TPmrxeiQY6Qvzt283643rBF1ptS7URnNuf9j57ceFNNGbLL3MmWM8CbhDqyXjmr5+BxBNpu16uZo5BeOnnX8nAn1HcWolQd5srIMmExQArzg7x9L+9L4nc4mz6rP9x5XfkwTPYvLMBF0mOAZWrVfXLQ0Fd5aqGeGubIb/+H6Lsmz5NhN3P70o;25:QHTR5IwPxCeCYpAuTbPwZ8eb6ED9Rvq33jg+BMc7oebjQQtqmNo/Ljd7ULzI9Sp9kO2S8nXAzt3ZUpzXlUZ21JFl71PhnrA+w62uurHJChIYXFsXpuD94WFYnTbD7K968QdQzXYIXUqXMcbGZ4dBWrIL5eHyO3ZzbP4MjYxyHrRBH1U3qWGBBPkqChhLpZ1taChaCmlywNLtSeWQx8B9p3lGVmvCRqqtlPF5OmDxWQVmaGluAO7OMD8VfIiGZnOh4rauhhzvkdMjJM0jxMAml+XaF9jkuFnp1UH7QhDNty7mP9serE/ICflDjTf9fo/qfLD77RoEOXx1ZeM5akJweg==;31:DYYZiY9UziKETFz68Cc/YyhFutjpt37oIpu0d9In67rSU8fdWcXN1La+FjXLYfmRNqvMmIV/KXRbBBlqHIOzKueQnS+ZGFDnLou5iYP1TPXLpjPM88Fn3+SvtEyLwX+5ZMemjGPSmxn/1nCHsnpeTKWFlhGJ5BkQ3JYKgUn8XpAxWphG9AmYfmVIMtjYmsGMVOgUGhnfnjmzSHQsEgdXnBkyxYOMW+2TMfDpCysnzqs=
X-MS-TrafficTypeDiagnostic: PS1PR0301MB2076:
X-Microsoft-Exchange-Diagnostics: 1;PS1PR0301MB2076;20:g1YhKdSbEW8GiBhINCikRBmNWi+e+Ls7KA33SIgkoT7f3Od4NMivkTHLGo2t/v3L3PfBxRm5wcexcUlKO8SH+il67mbBOm2vEVHD8NUk0RJAgaoSx5q1TzlCfU6Iri4aluk9erqJvVasl2DxUi0Hy6Oq5VEuMpwyjPDH009aOBzT9vjDZcP9mQkA0rNxl7IJR61KQSvIsyFFu6h1snMxRvJ9hswOEsXlZIFhrqReuTtAlOHH+fq0ZeznlIL2/p4MbimMRNvQph5ikUY/+BtxTqmXT9asvPtUqd91Hhfb7BwwMP84WBAHeiHGyWe+hK474G0eo+BDT2iTK+L0LeYPBxHmOQL+wbJ7onObXjey9QmdOISDzHXt7aU2xQ0haVWT3o/wpCN8tTJedj+EuqRMgJt6B2F9/2dz/GUwNDfMp0IFqmKMCVfet/UqwCChXHAUuvcFrxIYvYpy1O43Is20WF2mgGUaTK1JgWtNb8YFmvJ8qDILXnAe9ebF+8gXL5py;4:YhTaDOMQyZOinxn9e4M6wAiq1kBj92qrwSrJ507EXyMTtfHHWAYxiphB7xrV9DhrBMHumFMi2MXG0kROSA9DpeRPTJeGgehDFWB+hX2YMr9n1ofy4Na83oxfobihXHSPZAQZO4NU9q/q8qRKQ53tmV499FQY2SKa1Is3rGrQTV6tNziI73hZNDxfUtpOFbBvTzVZhFSiveiA8y4MnNYWpS9L3kPUIQxgdO/K22DcvDg1zer0VGL0+aEZcqCkAKniRSwuolJ/SDDqqTASRvpl+mum+alkhcsVwDB9Eal7c/ueG5Dr1hallbme9I8J9MQZ
X-Microsoft-Antispam-PRVS: <PS1PR0301MB2076EA1E0EBC2F39A31F08B3DED40@PS1PR0301MB2076.apcprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:PS1PR0301MB2076;BCL:0;PCL:0;RULEID:;SRVR:PS1PR0301MB2076;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39380400002)(39860400002)(346002)(376002)(396003)(189003)(199004)(6116002)(26005)(36756003)(68736007)(6486002)(2906002)(105586002)(74482002)(6916009)(6506007)(386003)(6666003)(6306002)(2950100002)(966005)(186003)(107886003)(106356001)(53936002)(7736002)(66066001)(8676002)(6512007)(305945005)(16586007)(97736004)(47776003)(16526019)(2351001)(25786009)(316002)(76176011)(4326008)(52116002)(81156014)(8936002)(50226002)(48376002)(50466002)(81166006)(478600001)(86362001)(3846002)(5660300001)(51416003)(2361001);DIR:OUT;SFP:1102;SCL:1;SRVR:PS1PR0301MB2076;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;PS1PR0301MB2076;23:qR1ieHYskjnnRJUEfGoxvInzXnj4rRJGpwx1cti?=
 =?us-ascii?Q?zCJDxBCi+xKr5DFDwXff9XNkOd7P6mTmr6JWHZ98xgdVLP+4wfL/2PHjIv1x?=
 =?us-ascii?Q?McuXVY97m6tcdzpT+PzzzZEph2yKOHTWnyCpEh19GApDyMShcx2isR0/Kgqz?=
 =?us-ascii?Q?8d91yUtlr3CAj0ebZ7M1k9Q8REiX6j4aoOWwAeKL3aXbgEdxxE8CbMvGxSWA?=
 =?us-ascii?Q?3rnOB/rvgIzRligc3Th4pASADycUdrO6aFuFioM5ulHlg5ivKKQEiyrPWF2+?=
 =?us-ascii?Q?h2/aZi2nrz08eJl9lXcXWFL3zOu2k3RxtXUzpUF/HBKUM2XFoNlDHKkcEuAG?=
 =?us-ascii?Q?E+z/XrFMujZ52WZO6jh5CKFMv2nWHeXXEnn70yT6SasHbWp3Q2feo8NYl6Nl?=
 =?us-ascii?Q?7rHcnBsvzmRNATf9qBkgU4NlJRRKH1qlwbW/DVI9wk+i10dyfNyDIr/Yl39Y?=
 =?us-ascii?Q?1dYoikaxSuUJGbTJ0zuBAY+ty92v1RJblxqXS9IQbufJDy0RY/OKbArDW2UP?=
 =?us-ascii?Q?Pf42QvIUTwoKYb6vS6RQn8hF0xsoImu+UpM8JDavd+YLAdgCmUzvMX5efdqX?=
 =?us-ascii?Q?CHJ6oaYZbsd5qtNUNT2SKvKECvUN7ULTuFGZPmRzxnvEhls98ixA9SwYH9nC?=
 =?us-ascii?Q?dSpU7A+y4px9a2siDBP0edbxfm9HF8H+oJOgg3tx0dHXE6Nme/B6znuh6esW?=
 =?us-ascii?Q?sGjTa/xq7acYASCO+EqX1KHMwm3B+k6i2N+TyFR3DDbuHbwe1gyLozd9Hwpa?=
 =?us-ascii?Q?F0pPiydXpCle7040kgHRcG9YHSgXnrV9etnZfd76YrvNmZEym03GPn6Vdqr5?=
 =?us-ascii?Q?/Z0DQKw3hFmoAfssvTbbFk8Xbh0TCGfUuHzT93JZ1DIIgJAXDqV85DxbtOuW?=
 =?us-ascii?Q?Jfx7EM2J2X44odhZW+Fnpcx6Fj8MlEOPXQbcjpLFK/nSjLqUX3/CpPR0Qxf/?=
 =?us-ascii?Q?uPsRpp7b1vMhZK69F7UxpxiHRSwro1bXEYoe11WcSfiDFiKp1lhjOWwphFxm?=
 =?us-ascii?Q?sRB2FPjJtSvJsv6TJR2BOrK9JNXm+VJuOxFfkOhUjFSSyTGg3yBP2vI7r0YD?=
 =?us-ascii?Q?jXE/VQUooNlNcE8wip2GeK/Xxqg7FnaH8j1XSJsyDpWsGZFC/nmn8cctJibD?=
 =?us-ascii?Q?90SAv7w0rhlQcYwoCXQ4uCORpGZipNnkglRZb1UOIw1S2k3bzUNkezAU/2Vv?=
 =?us-ascii?Q?hAyyaxNTo8SrRmG1HdQkon2dUNWx1copcXQnXWVG01WHrZPXdST4hXBIvQg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: NtmWrWl801ZmvO8x2qQFtq/smIB5IRalftzqP8f0Pto2PDuvC9o82wfeMVW1jYJuj+0/fo+1OOJJyUi8J7n3njx53S9+xDKWxyzjGkty6UJEkrvFe6ha9qje6V8nkhHXOeA2rEgIG2hgrQtRyAmKN6wOSCvAcWkSZU6DmnxWXbd3LLRgpSiRTfY63c6gV87S
X-Microsoft-Exchange-Diagnostics: 1;PS1PR0301MB2076;6:sCuTeewbm3hPQDxRzvnGdMwnCNk1Hk3/ILsy0UP9+lKFPBfoP5T54HxdQ60npydfMpnhmDvSLj90QaF33+odpwj/plUd7/wPJ6t0jKNJNL4yRYnSadd8/K8diuJr2lSLa+F5moI5tXj3GCmB7i/o1GRBvvhQTGylMvcKOfhl2CDThTdut7RIdoE0M/ATHtGdakyaoGPph/BCipjClW4Ye/6uLkZCWIurSYNjyq1MFmAACCW1qDjDcZeNI3Z++BhYK1hGJ56wlLuPxmwgo9ML6K8pqerPjA3gcT8eyM51h8TD9jYN5JrHhz1ABsb0Jz/42a3MX75pxKLqe3ILKXYddWIWlu1jrhcdpjgSDVw8A2VLXlgJiEtu93bCXtQHYynl726+PVbVXk8+GUKQwTIaMowveXrQaXHr+snwkM7RgzLO8OnC8qHDdLj2+DM2bUeHbrEWH+uiI/C0u61LYMU3LA==;5:sMKvdrtlASdZhlXgDIRq0n1lZTCFD5tuRsO+VDLdLh/1b7b7dlOZ0zSsHHVaDLNL+04Q8BKcwrGfZB/YGwE6V7B5xHoMSCmX3k2nNiMY6HFlsAkm2z/Sz9UGam2IrP8eLXQ94sLdezl7oMK5nfA5EgkoE/xGD5Ly9wgibAf7y4U=;24:D3j6oPcMtlrpkMLu9ppZiEATweaPeEhn7sUckWwwlmEtIKoENbLATt73e+bw29wKcodlFkarTzQbdYr1TWM7iEuSUlTDkbtx/ILUWOCUv20=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;PS1PR0301MB2076;7:deHzaZ0gHPEZFlp6qXtFfDk8QH26ruPejEntZTemMr9eHM9+In59+zaj+uOeNpB7fT4jxqISLOK4FEdKVAD5tRrQrMSV070T+MSB14zAcM0OnTOtvwvo2iRuhUw4bNThC/OndMM7jsHW+xmP4WMUVhNlUVPjkRLhw0LkbBHPHNFehBlNyIhhHTew/9gMpx+MQkfNNhLKnDQdu9mMrXqREZNxqUHVQUEBl4/3v2g6A3gq8HJiCp10ct4z0XhXaRaj
X-OriginatorOrg: cybozu.co.jp
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 11:00:53.2362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78f7030-4a54-403a-c1e9-08d58d88af1f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3761f390-05f7-4386-9a0b-b6806c13b841
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0301MB2076
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing the size of a block device, its all caches are freed.
It's necessary on shrinking to prevent spurious I/Os to the disappeared region.
However, on expanding, such kind of I/Os doesn't happen.

Similar things can be considered for btrfs filesystem resize and resize2fs,
but they are designed not to cache drops when expanding.
Therefore this patch removes unnecessary cache drop.

Signed-off-by: Shunki Fujita <shunki-fujita@cybozu.co.jp>
---
Changes in v2:
   - Remove unnecessary changes (Since bdev-> bd_invalidated always 0 after check_disk_size_change ()[1])
   - Add document of check_disk_size_change ()

   [1] https://github.com/torvalds/linux/blob/master/fs/block_dev.c#L1365-L1366

 fs/block_dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index fe09ef9..63f1269 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1324,7 +1324,8 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
  * @bdev: struct bdev to adjust.
  *
  * This routine checks to see if the bdev size does not match the disk size
- * and adjusts it if it differs.
+ * and adjusts it if it differs. When shrinking the bdev size, its all caches 
+ * are freed.
  */
 void check_disk_size_change(struct gendisk *disk, struct block_device *bdev)
 {
@@ -1337,7 +1338,8 @@ void check_disk_size_change(struct gendisk *disk, struct block_device *bdev)
 		       "%s: detected capacity change from %lld to %lld\n",
 		       disk->disk_name, bdev_size, disk_size);
 		i_size_write(bdev->bd_inode, disk_size);
-		flush_disk(bdev, false);
+		if (bdev_size > disk_size)
+			flush_disk(bdev, false);
 	}
 }
 EXPORT_SYMBOL(check_disk_size_change);
-- 
2.7.4
