Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757404AbeD0AVr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 20:21:47 -0400
Received: from mail-he1eur01on0118.outbound.protection.outlook.com ([104.47.0.118]:43968
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754672AbeD0AVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 20:21:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
From: Jane Wan <Jane.Wan@nokia.com>
To: dwmw2@infradead.org, computersforpeace@gmail.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ties.bos@nokia.com, Jane Wan <Jane.Wan@nokia.com>
Subject: [PATCH 1/2] Fix FSL NAND driver to read all ONFI parameter pages
Date: Thu, 26 Apr 2018 17:19:55 -0700
Message-Id: <1524788396-32380-2-git-send-email-Jane.Wan@nokia.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1524788396-32380-1-git-send-email-Jane.Wan@nokia.com>
References: <1524788396-32380-1-git-send-email-Jane.Wan@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.160]
X-ClientProxiedBy: HE1PR09CA0086.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::30) To DB5PR07MB1608.eurprd07.prod.outlook.com
 (2603:10a6:0:11::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DB5PR07MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;3:E/PfZiFnv66IlmplueOAIw1aDUUUPqYNmRafM9Xw2z5CmfgjlAnL98EzdS9Uj9h5SqUNvR2JNbmYJ7vLN2G2YMQvZd2gH6CDPPqtQPzBvteFB263+bLv/jYdUWrLEtKGV8npntPeoLLxTfioObFf+6xQB4KYPwOlQiCVMUHUlv126tAj8h9Ybiverku/aFSGfJGaMRIMQoaho4gD66uYqv5T9XEVstd2VRWq+7ikvl84ao/11JdwDN7ThZCuwB+/;25:9QnjkIBXxvK4xS5mZrpS6rqA97JQ7ck5+27JfBc+qvTgOpiMn62h+E7L2SQb6PmSA9ZyQhBJaY+p/IQGqkKBV1PlqirHpxBaV4UA1nJVptsArrMk3eThQD9L08nUnYxBGm6N7GJJw+AzIUvZkt1IXe/cv8ke2K6ygNXdlSBpEH22oQMqo5ZV67NJ65tPu2iBWE58xq2nxhiI9npLx3ChkcfZWE/RcZw8G5sbdoRwDncbFZtpngsQ5l10JHkODZv6aWeIH0Xj1Mn5a+8hjUPiUAoGdU2rnjoni13VbrG5d27QaNPOrMLn+ooIaZM6kI5OeJhxvc7A7Wl3x/RwoTrPGg==;31:4jkUijODe28dyfK18NsmFDFbEgbEkt4yvClEpE27wRJ/VOjs0VbWtgsUwdECnV20sLy3x91WvCpgpxnzK50dxUjUF3rjoEn+aB/Y9y/XgF2tXEkhD6aewm5cBa5L56Ke5ibPwy+Q6QrmUbZZEWFdwO+VhCFN7Du/T+NIYbCMgGcbXzKCGzNujQotsqdcenU1Z8uTgREYNQeuUU3WgOdjsH/GhxMHtQHYhZpBNiCrDdM=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;20:OjxwDAppz+z7V7Km7R6szsn5PXkkU8RNuxe+JkK6C8GQGftc9EYcuQDCo0clqrGZLtD89htzXP85jZKU+S9yN801Xls5FRIfRm3U5CSNh/soMezIa4st24qUf/v8lLw0Si4vIcq2xfEZUiIPUJUSaPT6IKOb2LCh0zBwimOSeh0FU60QXCH0UF7xcDikrSPcKrX2lkXl9GzJFRnuA1/N+ggHSTAnHnVM1D/AVf2Ays93g7vmwWVFpMp+qxSDo1hUbfU0tKYI7Glxh7l0humTzi101rQJZefcwWbiZgXsoOsFijVnXJzYNADcXGrMsgkWexbm/AUjds0ZIgAbBA+Abj2L32zhix1t+jOm8YrFhV2XZXtIJcY+Att2S1Uj63Rs+/SXNhChaMCkUxQpNi+fG+cRo7QUHCm86EiiXkakXgHzMWYuInPObaF+N12l7Tgm7kEGZCXxsXPofl36J8+Hsh3HabLxXFKxa+PJAev5fQWVV65cs2kFdbFAgEkWDC7F;4:YFKwooQPyJmfQSRt6uj3UcMOgvTfrmPMDSf0r1aQ4SvfVwoPkS1ovxWEjLS/OLPDQ+9U8pOqd7Tgx06pa4gwzzsbBqHLdeA0TEQO1XUNIjrrzA7bk459oN0vATB1pak7vbLWfJb1tK3yjyZIYyAzrV/b6SfDTODPcjeSsCDV0KwWm1PonjOC1Yah00XozptvAl6nScIGejWtPYoRtYAbp9eQCaFGfvKFdLPrr2jsj1ojueTX3YdjByYo2/2+zSm//ik9iSYoJcH1SOY1Ln9O/If+D6TOlsXpJCWZmUfuMXlbxCyUcdb0GDTqhfvk6zaH
X-Microsoft-Antispam-PRVS: <DB5PR07MB160874A235FC7896ED5C5896818D0@DB5PR07MB1608.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(11241501184)(806099)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR07MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1608;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(39380400002)(39860400002)(199004)(189003)(8936002)(316002)(446003)(16586007)(956004)(6512007)(476003)(106356001)(105586002)(2616005)(48376002)(50466002)(39060400002)(107886003)(16526019)(6506007)(86362001)(11346002)(26005)(186003)(486006)(52116002)(51416003)(5660300001)(478600001)(25786009)(386003)(68736007)(81166006)(8676002)(66066001)(47776003)(7736002)(4326008)(81156014)(97736004)(305945005)(76176011)(2906002)(50226002)(36756003)(6666003)(6116002)(6486002)(3846002)(4720700003)(53936002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1608;H:cobuntu-jwan.gainspeed.nsn-rdnet.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1608;23:UeuwulM01Cpq1gm/5bmCxZpHaNWTx3CzsjzL8bT77?=
 =?us-ascii?Q?MM+kw5YhNw6WS1kxToa8uUyO1tGTQaNCzC0zO6FNPOHdx8BiAo5Cz6waawpI?=
 =?us-ascii?Q?OfD5+W5W3H4I8ypG2rYNeBb9Wbllm30fLdpeiPPP3NIFlqOU5P/QeY3NzAVR?=
 =?us-ascii?Q?F8/qjnrYVDZCFl6QSsO2F1NhRD1JjS0wKCJi63E4EuvzH7vSnTZCWWjxkz9m?=
 =?us-ascii?Q?5p3g7ZXniRK3DGDoxkS3+Owol2/hOOC1iKN8Tzi9EsSuYRlyhH3R14YZe0df?=
 =?us-ascii?Q?Y1kcOvnPra/hGL35w0sjCehU2oLTOyJAhbFjfdFScGTxWqb+4uHcaa8xZTRW?=
 =?us-ascii?Q?2dDh5vbqPqUqE2oqTOIqA1Auj9cV5/aQwRAzGmuyvfiDshZyVQLrXWoGYGef?=
 =?us-ascii?Q?k5qgDVcPHPzaRoHHnsT8vcXyy7VYj5gHjQApVm764KaeUgS9xAepFAwDa2UO?=
 =?us-ascii?Q?s3dCocRDlv+iqWn/dwPdSva2w+TITILzKdRQqmiDZChsoMTwzpCYgziWuc8P?=
 =?us-ascii?Q?UuVuuFmC9T8cDi//Pok8HKtA1PX4TcVkhO3QhaWc8y1VhwD9D0ljCG2cXBUY?=
 =?us-ascii?Q?94pcMDMQeZ9p4Sfn508IBPkfHfE+3ImosIcuzg3gcf1FYzvOule0EKYGz1cw?=
 =?us-ascii?Q?lt4hrELIuo1tWrpGu/uazEyEtIMvrK6ZyKm7FuCaCzkfT03iv2I8sLMEtJu7?=
 =?us-ascii?Q?L2Ts7OJCfFHXRlAnVUigg0pYWSTVrc68ZUksJfXJm0IfO6NwzauyEdKq2bxT?=
 =?us-ascii?Q?CddUp0LwyfwaioDLdlojXSXZH8HxBmH24HbcsaXeCTYuLMKIpNC76WGQ2cnG?=
 =?us-ascii?Q?XnLLqlf+/iAYnXNLMWxmOVNw2ZyqTZOPIQ34kANcvkDSHHgpzOBAEcmig9FL?=
 =?us-ascii?Q?ayuuAQemh+zs5CztIOFTPxJCw5CFNN1UGDPJ9axjs0qEqs705qXb1LiBDMkb?=
 =?us-ascii?Q?BOM+DbZCuufYgy1ajIpaaM8zui2pJJJTrhkonwRbFF1zo4I5xorXg3VKjl/w?=
 =?us-ascii?Q?M+gWm7yXgZZ+BHGkYIr1pAUGmx20w43C+MlX23qJXomqybzmD41k4jSsgRfQ?=
 =?us-ascii?Q?i3402ISwvvR0qRZeaVCTPOHdLh+KJXsOi5v7DeGfBj9oiapZYTMISkdLZlYg?=
 =?us-ascii?Q?F1gz2CQxBfisBd6v/9O4PrYvWpKgIVSXUDCNQUCrFnLo1hG9rHf2oiMmNEpB?=
 =?us-ascii?Q?sWXQzNnUm0HMuEJk3Q45r7jshBHDZtbQTthWIrODwHtf5LMgumHYLofZPG0z?=
 =?us-ascii?Q?OltjfZ5bpvGesRUgsg=3D?=
X-Microsoft-Antispam-Message-Info: /ZSkTGUUiwY3m/WwkcsShLNBJqBRZSzn54jav6dm3yNMB2iqvHyO/lHZxtuTPAfmPOk0X1+prh7ZRbdhJT9LrJDOZC7A4TUV8SvZguIRoIlAD9eBpAqBwhdZLWccix3Gh4T6xfbiUokByY81k7vol9j1bKIM4YwHluxm/gaULeZv4zKRj5UB+Uj9e8jUG1IjpUY9T9ghXviWKD1E3de+DmG6jx4rZ4+R+3EFpZftW6A=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;6:3uQJFYEElHZlwubJtHQs6hZIrWXFfrcXE6pzAkqQHo3b3+G1jQb8KmWvwfDiS4uXNBGCSWohAhhBnlL6n7uxlhxRe1hphJtOdvwiir/CwkmQ9vEFsoxYzzBz4Pqnt1Uq2G77DtsIH6gn4HKFs0zbMRw8cwpuqwF213tuiBs717tmgak6U0O77bf5qn5xJBqpeCKe6+sktzJ4kCQxUtHWcsEStRft8o9a/gSqHzmO5hkEUIb4/n00XVLQJ7mYKZ9pqweqRzxfVLYvqK8S+hO7L0kWd660/cbBuz7E7vHPIvC+iNl1EzOpf3fmGsEL0h9NTmM+UyOsTwR/36335BI76bqJ47gzeQoPbKzJw8fsAuzJp9u5FnaMelOyGVk7IGwIfOyYJA1JraZkPeWKPoE92Kw0iI1jQDfipPJStkFholIccp18gu8Z8ctHXP+zShy+szyFwsO0FhABKrAZvcFIuA==;5:s94qae/1ou5vTaWiJnRGfybRwf8OhwqTRGYm0rOJBmHO+T2jjYjekIv+Gnp5KkFzVp1KA9iewd/YQnOM1yxqZFtope1s8PexQyMaoF6s4vdanHnF0g3M+e+3zf/P1oFpDz1PiP9YunwFHtKikf4bobHHtcyGP2DQa3Pwl0nk2EQ=;24:0ayozi5rvcusbSZSTOvNbe5iJ6I6vk5jvh9x2YXMzG98l64qN9avdID4et8hao2u5ekcMWzqqcPuWsAf4+/uqylYEiJuJQ1SRYQ51rTWAx4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;7:mdGtN5sQmrhTbSi3bxUzZY6fI0zX5nDyvOp458ToTZ7JaLR8PrVTsZifMj06V55qqPrwSvtFwHQAKIWw1pcX/vrccY2er5khT0mNNXeQPjBffQ78c5K5HtCQI4+O183L6culVBFgDR6uP7wWnnw0C/rKqmNEZlEI9rPCD5NwVJxq6m5aw6majJ0vFY9NLxdVOJnXv49PsCwXpGiIZVvIWpV47+cNd3e+OEfKE8TnWCw9CCvAxMv+BZvN4SijEta/
X-MS-Office365-Filtering-Correlation-Id: 3ae4694d-2c5a-47f1-9636-08d5abd4da02
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 00:21:40.2592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae4694d-2c5a-47f1-9636-08d5abd4da02
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1608
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
---
 drivers/mtd/nand/fsl_ifc_nand.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index ca36b35..a3cf6ca 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -413,6 +413,7 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 	struct fsl_ifc_mtd *priv = chip->priv;
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_runtime __iomem *ifc = ctrl->rregs;
+	int len;
 
 	/* clear the read buffer */
 	ifc_nand_ctrl->read_bytes = 0;
@@ -462,11 +463,12 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		ifc_out32(column, &ifc->ifc_nand.row3);
 
 		/*
-		 * although currently it's 8 bytes for READID, we always read
-		 * the maximum 256 bytes(for PARAM)
+		 * For READID, read 8 bytes that are currently used.
+		 * For PARAM, read all 3 copies of 256-bytes pages.
 		 */
-		ifc_out32(256, &ifc->ifc_nand.nand_fbcr);
-		ifc_nand_ctrl->read_bytes = 256;
+		len = (command == NAND_CMD_PARAM) ? (3 * 256) : 8;
+		ifc_out32(len, &ifc->ifc_nand.nand_fbcr);
+		ifc_nand_ctrl->read_bytes = len;
 
 		set_addr(mtd, 0, 0, 0);
 		fsl_ifc_run_command(mtd);
-- 
1.7.9.5
