Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeBEWcp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:32:45 -0500
Received: from mail-eopbgr670093.outbound.protection.outlook.com ([40.107.67.93]:45247
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750796AbeBEWch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:32:37 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
From: sbates@raithlin.com
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>
Subject: [PATCH] nvme-pci: Fix incorrect use of CMB size to calculate q_depth
Date: Mon,  5 Feb 2018 15:32:23 -0700
Message-Id: <1517869943-3655-1-git-send-email-sbates@raithlin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [70.65.224.121]
X-ClientProxiedBy: MWHPR08CA0037.namprd08.prod.outlook.com
 (2603:10b6:300:c0::11) To YTXPR0101MB2048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:10::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98cec918-4c14-4195-2167-08d56ce85b02
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB2048;
X-Microsoft-Exchange-Diagnostics: 1;YTXPR0101MB2048;3:IyRW/TcHpi85AwUx9mBKFHzzB+amGUEBQYFB4buI9gfmW/H8CLCe24KNcqAe0EJUsUZKvPf2Dtt5GjOzGsUFNX9n7LyQpsGxT58ySbGWhWpkGH0sIhZQeyWGe4OfG6WRXT3UpYJAQD2h0eXpoMkVMAxFHd3exCrj0ibKRpPRHTpFkobCNRoaAzJPC0T5K5jHn5sEwgmqhopwt96z0C5sLYwZUKgc3A3AhKZ5CDfCIy4yq+s7tdWLtUnD8DoyJ02F;25:2yeK9PgJK7LJWYN3f/OMEp92pq9iPQ1F4XxhCLvxMafzh8UwHkL+xAoj8kznPDhByv79GtF3zoCziuVOxVptywPvYELI2V8qZXJj+2DUb6bOgaxmKtf1yo8uE7/yMcD6bxvwLXU908He48lUCs58ogTE1ZEa9d/kW2TOTNaFzB5FAvq90BvWrwtGV1RntnDR5/c2oL4tm3GWxne1r6OHNI7J7nIXQMZjUoSoqnPwHSeroniXecg7Dpem1yTVdqoFMQXnmJRfZtBmZflEfJVKFDQ6AHjbayzQwIQNW5L336r4/2xGEOL1oAxnL42QZc1kMeU0rnTNajd4+27OLhGhWA==;31:YBQulb24UIJM1yoFwY5UKrxOInLT/AIB2BPu/QoVHrNeECX1NWJW67w3B9fSPbPnMf9K31WSwYY/7SBDHkZ8NcyUk5ju+9yXiC1yDJ8yLHYk2s3fzNUy98780iTivdTsZX9LNLhQDKk2nU+hg4XTgWj5a3xXMSj70qtWdjjh4ENjoLm7XL3gXsQrI4QOZ6Y/7H9SW6hHm5YeEN6OxohSjO/yfwBxUSOx/A0edtraaGE=
X-MS-TrafficTypeDiagnostic: YTXPR0101MB2048:
X-Microsoft-Antispam-PRVS: <YTXPR0101MB204832E45BADA44B248DA134AAFE0@YTXPR0101MB2048.CANPRD01.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231101)(2400082)(944501161)(6041288)(2016111802025)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB2048;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB2048;
X-Microsoft-Exchange-Diagnostics: 1;YTXPR0101MB2048;4:RSDhfA0rSsP3sYOKUvR5IBJ9epcZi9t9LqQOw5aTl5jw/c9GoPF9aGFcewrNGKSoKrg/W0J2UJLH7zx6obkrqt9WMTgYJcgHeA3HDkxkG1N4sgZmtZvylK18AKlupY6hL9jl1yvP9AEdBF60G7lhZRzJRmTH0N/vtHaUEZL8Yuj9jpxrUIYPftuHlEzO1HRkFd1df6KXVPcMZY2gIakOLsFEn8WejkxfRdTaKjLp7xOCu2q3ip6bJJ8drVXiITzYeJ6W+SuVvlkZ2erNzKVCyw==
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(39830400003)(396003)(376002)(199004)(189003)(305945005)(97736004)(81166006)(8936002)(8676002)(86362001)(81156014)(50226002)(68736007)(66066001)(47776003)(33896004)(59450400001)(25786009)(4326008)(106356001)(386003)(105586002)(6506007)(5660300001)(107886003)(51416003)(52116002)(7736002)(48376002)(6486002)(186003)(6512007)(9686003)(36756003)(26005)(478600001)(6666003)(1857600001)(316002)(50466002)(16526019)(16586007)(53936002)(3846002)(85782001)(6116002)(2906002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB2048;H:ubuntu64-batesste.cn.shawcable.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;YTXPR0101MB2048;23:oSMqRtdoicmx4XikYd5WiDnn0ONiUQ0wxQ3z5or?=
 =?us-ascii?Q?KWai2tqneiS9JUh3Dh/ZdNjVbNTqd/H4MsvGEk0LJeclE5Smn//RBArStTk5?=
 =?us-ascii?Q?7tQXTbEwKiwWSMGoiTnIFBAwy4/HrRjKp8ttP7OUWZHv2IPjRsUoT/5YVIUA?=
 =?us-ascii?Q?58LJi5N/xksaya2VhzoJm4mI9GVPefki81iTP5b7z6oHOC+cUVZvgEq16hJY?=
 =?us-ascii?Q?+rjim1DEiH7Mq99am1MOnSWvP9PU1Kvcc7U/EAUqUO9j5ICatQL3RY5PSdpV?=
 =?us-ascii?Q?f8avKR4keBNzjK44YnwKJQc/OKubmANWDu0OMTUhvfvziJlhiTABVw6/Z0cw?=
 =?us-ascii?Q?1emtFijR9Mn+6iheATu6GbAzLrQj2vMvvDD43hPelsm9cArPR/w37Hg2v6TW?=
 =?us-ascii?Q?Vl7gqL3xtZtwiRWfNzjO7nlSpVhO36X6JNI6Gbnhlbg7kaionsdn18cJQ/ou?=
 =?us-ascii?Q?QSXtFgVi2CjTVtuGaZsxEwfZym4JwAOc0ma+lDCSZDJ+Q16wqh5lBOGsH8+y?=
 =?us-ascii?Q?Fd31718tNV5I2JhPXjRfyUE8MHydoNt2+3MF32eCNFtkJeVJcgQDZp5ZDcqk?=
 =?us-ascii?Q?poee1qy+SugUylIoglt35FO3zrTOr2QeF+JMmKXgG+mFXKOElL7szL7ShYpn?=
 =?us-ascii?Q?DFQ3ulmWMY+siGDOfKw0uWrKHuu2tpswMxqcjbwJ7J8QQSiBvQDljAVw6WIg?=
 =?us-ascii?Q?i8YRY/RpljsWrB716AS8rL/IsSKLXBqP2g6TcCKqWc1d3XcbCJkYBWp9B9e7?=
 =?us-ascii?Q?xEblQPBBpdK0XFzgzTUtUZGYluUgMGAk1yzAA0rLanCDx3aI1/yCI8NgzgdX?=
 =?us-ascii?Q?02I4ljaUEVsQVVBDj3y4EcEW6HvzXlwvIAJ1L1Lwx1B8rJehkMhykoLxntAQ?=
 =?us-ascii?Q?80V0VO8aAbUrnxMRMWyb49CfrXXuU6C7qwI8UwT7u7IaMqOh5gbQPeAor+If?=
 =?us-ascii?Q?5eDoKJj8n6sTmNfo/uHiZ9f6lopBwO2KpAIMGWY5sYzRykeks0iMPj/N9ezY?=
 =?us-ascii?Q?73rncq5QUxVJQXyKUuOYLWIlubKWW8o3+a7UWUQqyvzbR0QwBrtnYkvXpBjx?=
 =?us-ascii?Q?iT11RJyU/CLtx0Syv4EuC6LvlPvSp1IjpYYyBBgLf/KCMjBxJSMN61cOY5SY?=
 =?us-ascii?Q?NJm3rSNDfY3I6geA+bgW1q8RpLItz3H3D9wxcGb283H9n+NLbYR2nxI22Gqx?=
 =?us-ascii?Q?Lmh5+bwUCPb3DNIE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;YTXPR0101MB2048;6:+u9Cp7LsUTofOUPSOwIPPjrQilBU9o657yzSNuGYTO18X04X2xpkb46nQO9+b56bnvdOdZD64fQWlf/5fynO4AbU6S1NO6zox1DvNIaJqkLHI2d8chw2ZJ3foJ9g/LRrYfFHEsclDV5m87i/l8OczRvdCgJShr3jOgfHM3Tr6wJykfYCGyFOmnEYBFT0Fq0HFbTA2xhAmz6ZhF8C/Q9/AvTK2bW731k+l0j6Mg0XgWncmn95O8BOtUn0g1XIzTcYtZLboLKDIZ5bwuVL0I7lznpTxmQtv+hxDVPKr796uiouZm5Zq/fUGm19Lgy9V5k1MdMgCr4SF9mzkCVOizfJ/PvBBU+LUU36xfNF4WLZTPA=;5:FRXLyha6IvCURfQcCyUy2Ton8QRM9ZcUKUW/6gD9eCKRS8bSRoL38eDPnBC+VieylTTuzBG3H5LI8H52Sfwqo7NXgJGX53vh3mEhgFJGmLUNbOXbSheDMGN5Qu6jANuIcxZA9aRSIV1w/IqkU7CfiNMlZN0t4N/7gzrecfLpbOk=;24:3No5BVFVqAwQRy+/FWxpuBMbcFyzLYpQzBAKHvPAkrh8AKKLo95qLYML3W2jHmbWrRrn8sla5Tzlx67baoAhQPzyAoycBhaTU1nGsnWMN7A=;7:gxGKnN78WdXKb9ZQLeKHDVSXglDqCcXtUGx4QL6xOYhF2MvN5qWLsDmp9VLruY1GNyjZW0pfUllh4VBLcqURtACf4HBHQxD8FyCs3DaLB9L6znYtF1p6DEb7pXpsv4mYhxWk6JD82QvPpaLCh+FPh6/ukITqnpolikshkiStH93ImhweWN0D4NqA5B9/X62vBgBbPAE/iMHWn86x60MKuw8uV2BrUxxCWw0aFW4Yb8A/X9FZoavSzjlb0ej/2bMY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 22:32:34.4747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cec918-4c14-4195-2167-08d56ce85b02
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2048
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Bates <sbates@raithlin.com>

We should not be using the CMB to determine the permissable q_depth
when we don't plan to place any queues in the CMB. In the case of a
small CMB or large numbers of queues this could lead to shallow queues
when they don't need to be.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0bc6a9e..0d099e9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1913,7 +1913,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (nr_io_queues == 0)
 		return 0;
 
-	if (dev->cmb && (dev->cmbsz & NVME_CMBSZ_SQS)) {
+	if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
 				sizeof(struct nvme_command));
 		if (result > 0)
-- 
2.7.4
