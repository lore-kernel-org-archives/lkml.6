Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeCPG4r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:56:47 -0400
Received: from mail-sg2apc01on0110.outbound.protection.outlook.com ([104.47.125.110]:20256
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeCPG4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:56:44 -0400
From: shunki-fujita <shunki-fujita@cybozu.co.jp>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        shunki-fujita@cybozu.co.jp
Subject: [PATCH] fs: don't flush pagecache when expanding block device
Date: Fri, 16 Mar 2018 15:55:53 +0900
Message-Id: <1521183353-144817-1-git-send-email-shunki-fujita@cybozu.co.jp>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [103.79.12.129]
X-ClientProxiedBy: TY1PR01CA0176.jpnprd01.prod.outlook.com (2603:1096:402::28)
 To KL1PR0301MB2069.apcprd03.prod.outlook.com (2603:1096:800:f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efe05915-592f-4234-1f7c-08d58b0b1184
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:KL1PR0301MB2069;
X-Microsoft-Exchange-Diagnostics: 1;KL1PR0301MB2069;3:AjSJo6kqElsjwYqOYTLNRfxN9udxH/RoIJP7vGpi+A1YIrDZNbNIAgawJIrGvoHc/jaJvnqQNDFt5IBVBpPk62X8lHux+mfihh+u/JZ9PEkDdVvwaRhwIaxEqVIBQR9sObVrTncmwG4oQkW3f61qK7WkCVc4BDhx0jRDTH3fEsfAXUk8AtJNNn81iyLtPO/4Aq+E7B4zEkjpvdTrTBBmyWyThNs6OOtd/JJDer1Y7WbtJ4iKeiMx0zj/PCcJx60t;25:64rawVs2xorlQ/IuegdodAJg1/03gxtzXU5cqKXlpXHkBBdL/kAOuEuO0JkKeF6Y80VO0AbQ+ojLiD/he77FvEdlsFIJ1RNkiCfJu/sSCi0qnBhbZIYHVCTs89bMF+Ozv3kLnyvu9E8eJfWs3c9VFcSK7waE+UcdcdKtZeHbOFil92cwsORM3Hau4d3U/EIpaWRISR+LWBXQyvMAIsl07Rxtb/vB+iE8rEFg8BWdfaAyIwXMPegWR/vGOseWUpqdTSLJNwjZbKV6PejVa2ikTypOexaKjICjlDxvgVaCYmPqHdpgILfVSbe+nFDRzr4oofM6Vtcj3uz5W8fmlQ1ZzA==;31:XI+9M1aJ+OGPWK1G2o6xhWrl1qN87jIqGeDRGww1zrWcAMjmubOIZSzeJ2lVghl2SicVEuNfSzsEf8Bff6yxtepz3Bea1sZ0wmChAo1apWj/25p5GW2gW6tpTs5aE3wCR6VP/XfUImwcEuQvPQG9zIyZZOBUq1aEPhatJjUV3ahNo/fLcjBX948diX02hdBkwIoMh8NZ5bFKL1Fx/b/HXmyHHu0fqP/bbAVvdc56hws=
X-MS-TrafficTypeDiagnostic: KL1PR0301MB2069:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=shunki-fujita@cybozu.co.jp;
X-Microsoft-Exchange-Diagnostics: 1;KL1PR0301MB2069;20:jPcXulRSRvW9WEQRqDqa+DRq3SarGVqy7IRvsZ8k7W4slosYpWe/wWXJrmLIS58WiLztQoNSPGk+UYhqXb2uAQGrWG0MSqf26y5DhqEMaSMAYIsLQCfWxy6sHVEaI4kxJJVOgnHU0cg+8Qvu9zckyTnmZeVwFb93qQ49q09wkR6ivp2skd5/+Sr82V4b5SvGNK0Ajucf+EeLAEbqOtGwr49GQnO80yoGgzWg+EbtjmomgwaY9NO2TUhzEJ8zzZklZqBbyOQGvj6rxCNugcHb4aAw8xg01qkJVqRT+JEJJWgLCEugWLCS/7n/wxFO9a1J0efR7hfnkOeYHj+PWoE47ijlJP3RxRo52u3mx1v1PejM4CMHp9ooMX9bG8ggBUzq1Ua9eL5BFmT+tlSt7vh+PMKtHScNgYgI9/7VjcVWJCtIur/tuGia9U1HrdoOgEitTBssYM9+OHuUBNc3myxcSqMe6tgXqlvRrZ9ij9tWdsRh5D1ZzJMQ6Ncdie+4K4za;4:6USICPgiD7BIPODAK6IWN7ngZZE0/iMPHYunJEnCIxCgvDrA+xyoCTCnte0Y+XmiQL2DBOKlgPBq1Y8B+ux/hAzM0v32BW9sno7AZMR6cLpbltl3d/AAjIxlrh6bxbvBqKlEM4Xjf2fBOn6dTey7ih1cCCgNkxInDd6+6nTx9AzwI2ODIhbZuT72Ta4KG9OnwWxAz7YuAJkS+y3KyqQF64SrDsN9r01tLGTBxNmQ8W18JGvOMTplxKmGK2BZ/JZF4FeaaFNp4ycgBaT1J6KMkA==
X-Microsoft-Antispam-PRVS: <KL1PR0301MB2069FC34ACC8FF9A2BF35B4FDED70@KL1PR0301MB2069.apcprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501281)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:KL1PR0301MB2069;BCL:0;PCL:0;RULEID:;SRVR:KL1PR0301MB2069;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39860400002)(376002)(39380400002)(396003)(366004)(346002)(199004)(189003)(386003)(81156014)(8676002)(105586002)(6506007)(53936002)(107886003)(6512007)(478600001)(5660300001)(305945005)(68736007)(25786009)(6116002)(50466002)(16526019)(186003)(7736002)(48376002)(2906002)(3846002)(6666003)(1857600001)(316002)(8936002)(4326008)(97736004)(74482002)(81166006)(16586007)(86362001)(36756003)(52116002)(50226002)(51416003)(59450400001)(47776003)(6486002)(106356001)(26005)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1PR0301MB2069;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;KL1PR0301MB2069;23:1669ezTzshnw3jBP8o40F/plZAi9Pk867bL2aBR?=
 =?us-ascii?Q?cSZCXDBCxWSd/OdZFlXkrJ6x558kgURoiPwn1GHFuqRQX5FDoy8JKeT17MXK?=
 =?us-ascii?Q?atRTxS8k7e/EVTP11+0w+SJuRP9chxboHwhkUbh4eBkiN8/Lbw2GbEBnliuw?=
 =?us-ascii?Q?8VPVIxRGT4WxJ06lI8AoiYmwvNxUL5Dm8+HHbO2QmgCaTE2oTb+J1qBPtWPF?=
 =?us-ascii?Q?7gUMDa2I1XI+BR3QeFtFm07C6XXPN2gG+6NuGwfIY2DT2bOWKZVYz48ZNxEg?=
 =?us-ascii?Q?5Q5S5ZyX0jnw5y1NMxrs8biE9YKuhGXF/6lwcE7CIeDX9zEf3sy+MVb2b9Ra?=
 =?us-ascii?Q?3oeMAbUv9ca2QfS6N9q+QpPZrBQQwazzqsxz2jj/uoB/gl1SPkNVAudwFfDz?=
 =?us-ascii?Q?siQ28RguJG4nrEh3iBZcAQdRlOLkAdMgpVX9PtMgcUjBI37mBIhfdzYjfQ7s?=
 =?us-ascii?Q?ysbP3Bx1gjjiKIVHZrkMyRegpPM6rYS0EtPhUn2ztsILXbAVZcn7cqQXYNxT?=
 =?us-ascii?Q?sfCREz/QEUO/COepUFlvW6IidRRfOpvOV6G4JuvUUDrR4GAsukkX7NrhEhYv?=
 =?us-ascii?Q?oPJNcejPI8c+qAnQ1pKzLzgbKDpHIb9TWzGgGwqrdDTZ0W1HNB1nw27GqZpM?=
 =?us-ascii?Q?O+Fvk2/Ze481WCQw7N91hldXLEGvJ+w3SbuGEza4uQcUh9gO8EbneYMYdinI?=
 =?us-ascii?Q?A7Iu3q1dmvMKzzVs0VwRtxQP+33dAudShznJmtQgcXvkJdRweyQejPgthwdb?=
 =?us-ascii?Q?hW8yed6REz/+pGmxUNpeVLNZjIHY/O5Pf69BuIAfh375GQegPhJhltyp+wtl?=
 =?us-ascii?Q?wlQwfywy5nnVMkf+oNU6q4ZjCDBpqvrlygakgrMRvfsJVSeh46cGw37VevR4?=
 =?us-ascii?Q?CcUo42Uv9h1iYHD4BhQnp2theG5Y81Dizzpg3iSSY2kMdH8bC7nPB3kVCjoG?=
 =?us-ascii?Q?27f2ALiJSx0tabUEhiN3R5xGvEHNKRB31nWfqlinfNFWjnZH0yq7I/ikaI3k?=
 =?us-ascii?Q?OFlEo/0Fo4ekra7wkEx/fMfjI5SKFWVRofewxSxwMA/yzTwzei4/coHJttrf?=
 =?us-ascii?Q?Sd81MI2kj/BpVtVmKjxJepJ9vVMAAxTQ9n5qv+uJ7tUKoCuEtnGBYWaOYDY7?=
 =?us-ascii?Q?MOfwUkKU08Pw5zr1K0ZjmQ7oQvleVAWjo?=
X-Microsoft-Antispam-Message-Info: yMo7zNF5EguRKdTwI/uZHPqfWw+K9+ruigx34m+yQy9Hikc60Rf6o/wyDgwp+DITO3y/jYgd7bj9a7Db++9iOo23Ap4VHWlRRQmW6gsJxIT9oX0+qcYvtS1229z9TXFxrjeVEKQ6G+ALFSm8cqxjc8JBak6XwR0LbIW03EZT+aGPqfCkq8vAPobO6q1w6gkB
X-Microsoft-Exchange-Diagnostics: 1;KL1PR0301MB2069;6:t2oirQUx7xb6fytf3CPIUtWlkJUxL1DrVKaG340MOkaIoPhLQBnDanXzb/J5WistXLQ2DimCS4uhDprK0ltOPIYTfNELhwnqoZT1viPU6lQHnoykWSnKBC+YJvmZKZv4ij2/s60IqbQJIdfl8JZgg+XmPiRED9LobwpB9d0zBK33xEnKxKj7deRktmHZvwaUH6OdPGfqLD0pTutxt+1BJvclUYIWUVgI6qXAu60jDa4h1SKKs5/bfO2j+2KifBLPJaT4idhAydwUZgcibzv/TwlRogGKCiYK3Ubwp910kAZG1dn9+GyR2oxtvAufuWyYe5XWCEo83P72FFqZe3BofR0qixmZCbzKLYNa1/8AdKw=;5:Lse9RaCT9u+1kQa/IFsyUS88fjHsQJo7JaSJy9PdQcl7nR3f6ZW7j8ClcDPMUObU+liuGNbuQP/4ynPZ4axT5y08Nc4UGbprBFAew1qpGcbxd/norysCHsV36zc86sJbPdgxKSOFViXEF4rkHHoPqRN9Pg5WsYj6PqNMi1ICF7o=;24:0227Q/mRBV/8L8shmuv5N8a8faqWiTY5WDzuvwNKeXCK1E8cvvvZt6O/H1j7kPWQ0FqUEX0yd/LoRUNUJSakmikLWWQPBFw84xZo5tc0c8w=;7:P1f5FCgsqpiwIw6xbbV6gzFzy2pyiHgEfL9/d1NEVdFbW3e3oA7NRT1+NSkoBCCvxfUIZXvFGzzO46y+ef0iQtMSc7IDQXVNZxvccb108GaXvtM0PAom/YV0ObD99QxGTfKQfK6A5T/R/uWlpMLI6qx20/zwkp/frfbAICxh+WXkLJ554SX74sVs9epPWRiLsuTqiujb3LhTu78SIfPV78tAByNUtbZFhSJwMxMtE8WbAMWYta5plTJfFWvp0xeT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cybozu.co.jp
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 06:56:39.1900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efe05915-592f-4234-1f7c-08d58b0b1184
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3761f390-05f7-4386-9a0b-b6806c13b841
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0301MB2069
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
 fs/block_dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index fe09ef9..243f4002 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1337,7 +1337,14 @@ void check_disk_size_change(struct gendisk *disk, struct block_device *bdev)
 		       "%s: detected capacity change from %lld to %lld\n",
 		       disk->disk_name, bdev_size, disk_size);
 		i_size_write(bdev->bd_inode, disk_size);
-		flush_disk(bdev, false);
+		if (bdev_size > disk_size) {
+			flush_disk(bdev, false);
+		} else {
+			if (!bdev->bd_disk)
+				return;
+			if (disk_part_scan_enabled(bdev->bd_disk))
+				bdev->bd_invalidated = 1;
+		}
 	}
 }
 EXPORT_SYMBOL(check_disk_size_change);
-- 
2.7.4
