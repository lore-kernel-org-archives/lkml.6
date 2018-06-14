Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1589CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E383208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ph7jK019"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E383208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbeFNFhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:37:10 -0400
Received: from mail-he1eur01on0043.outbound.protection.outlook.com ([104.47.0.43]:27360
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752919AbeFNFhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOjMt2i7sVvqqMD3dlnxcHUfBZt/L/3tFos3iUUovyc=;
 b=Ph7jK019685GhRclZdkKHbeUs8clkUbjbXd4NzChbrIPvX/GPyada+RX3F4nNwgQxRVTNgZP226uw/iLG6noo24QGSwfHTh6kd1fMfjeF1VNllUW0jCbYlaHBZv7oKlt2rKqVB6nWnykRtjUvnLFV90J+1gcHPhovYYIbR2UhFI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3222.eurprd04.prod.outlook.com (2603:10a6:6:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 14 Jun 2018 05:36:55 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v4 7/7] tty: serial: imx: split all dma setup operations out of 'port.lock' protector
Date:   Thu, 14 Jun 2018 21:35:37 +0800
Message-Id: <1528983337-2726-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
References: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To DB6PR04MB3222.eurprd04.prod.outlook.com
 (2603:10a6:6:6::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a00de87d-32b0-4cd9-4c72-08d5d1b8d8a8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3222;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;3:2mjsilTQ0Cxr9OKUMRmiE4DkIBz8xhPJjq/tq5yISDDHbnBLAZJiCS1gTo3vaKA/C2k38LTvaY16pE8qdbsoff0Hp5C3GXvENYLngWAfWP7/ASM1MFKPDtrMmogqZJ7M/0P84nUNZ87ZnObR9axaFSsZbDuGWtN851UycFeW19+EkV00kID+/N0Jlh2uwfFkBqYICncCDt8qYxzM/KkJoji+95bkuj5hgvFF8q1nBSJp6dq/gP7l39ux9HEKngy9;25:QqTK/6lsXByCld+Lz7d8qew6/JRSzKaXKn8d2O3iYUJigt30HON7/p4RK4CfpTlDReEP0mq+qUvoiEvtzKvUBF9ZJcuZFf1cgDsmhi2IlgzYGiRXG/rnabuRhz2zy0SImp2RwRxM3dla1U7DY5Emg+CANxXc13pWyCv9h95yjo2Stx5xd61hzz0guSpIkrGVq6AEERTvPKgmyOOAFIg5J/8ffgAHKh2E54FsQNhJOTqve7N4PFurObUt1b8PV0r112du+QhT+7CExV3vcehloDN8ZZu60AypKKX5KsIExqs4WfUAAGlwfOz9Z4PoCQ7fgA4OYuUHcGv0PucG4QHhBA==;31:Gw8haXv6/Tatdz/vB7hoZDDtNm/KV9JQI6FfYKuahuE/G+wZT9hvM4YkH364dNqlSZMMSg0Q8GxpYxgDieb+552mnzlIFPi3/5Y0Vu7zskKttaIxJTFnPAeFDeXPsthvOdoaYRWrQus0kEPhu2hTUYs1G/Ca/pcAfdQFTk0MDW1PWvjud89Wi9ta7F7WFiv/pQ6CjmXisvrt5uY0bXKSr3tCU0Fn3qegAxYamr53uKY=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3222:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;20:ltj5V4Gp1ewdfX/Ou2WWxkM2hSuvJmYvDL0fEljMD1o10Q1ewkeJBGBgV4nKTTGaYTELMPrqMd0x/cyO67iJmfE0tQE5E/rQ09TqvqoFacp6HRXxF19VnXdDkV6jeQzOYAlA0DTjkdxBGFJKb07ZqwZMulUR4W+06KCaDKHj9dPcQWBuhrZ4iX/lQyjLNU0A+0EQ0YLzI2MVoB0y5B5p5LiJkkaYZNk22ZvWNj0DwrRLP5UiJxzlbOz+A6y/5X1Ay1gHjxv8RH2OOjuFflcy4U+zYwoMHFBvET9Wk5zh/WmWuVu+b7dgra2uRuXV65aue8l1klvMC7AwQCyB4FPJSUivaIlqLDPTZQir9IV6Wa5ZDl1h9JcgL32A1RNLe74rqmNbgcgw1wQVyNRJOTKj18OU8mr4eqVbk+UMjOmyAT/Cr/YqRPwxMuJarBh1UQ7M9BvbJh/mEoJKFqBMmezi/i8zhoFXJTGvbNjZmbnN1w76Ja7Su30uN8hkLaqvxK8j;4:S6Mq7MlMyqaX7RJLuwWRqHX9ZXGdI21Lc3NT2lmazl2NHgQXQCLWxl1bHKvxaQgiQKC0LWXaYLjT6Yg4x/rA0/4YFoHoBGgJp5btGiUUePMzNDf/V5/+IT4iKKNmhYXTgJhpV4TMEORNDeBa8c4uZ7KnuIMwMiW0+jxZVFeA8OZc02Qb490+xGj6VtabvNL1KkGtaXMOent/yEvpjQBq3uSn86+NnbAs7XFAkVWu5NUm5McAAmLWalI/Dab5CinAUiPy4iSl3ZZnTh7gQTGxf1O3ky83+Ekdqtyl6ajVjBVE4uPzP57gqnels2rRwwwM
X-Microsoft-Antispam-PRVS: <DB6PR04MB3222A669440A1DB12034F246897D0@DB6PR04MB3222.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3222;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3222;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(476003)(6486002)(11346002)(86362001)(16586007)(6666003)(50466002)(48376002)(446003)(25786009)(66066001)(305945005)(956004)(47776003)(97736004)(2616005)(59450400001)(52116002)(51416003)(76176011)(6506007)(386003)(16526019)(486006)(186003)(105586002)(106356001)(36756003)(81156014)(68736007)(3846002)(6116002)(478600001)(53936002)(26005)(6512007)(81166006)(8936002)(2906002)(316002)(8676002)(5660300001)(4326008)(7736002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3222;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3222;23:YJ6ih/pYznYrU62Ej43NEekw3cg7L2nR5kyp3zi4N?=
 =?us-ascii?Q?3rYv+tOT7TuQnojpVx6xa+heDtkVwkMKDhRikB1K1ac34ohm6iCU2/PAj1Qm?=
 =?us-ascii?Q?ML4xNnR4ZJVUGB3382NRrH774Ka/aEEsBJJkoW1op62V+SnBLO4HzBQVnfra?=
 =?us-ascii?Q?yf7LQNLiwyv4/HA4PS3N42W6sK22iGmbjf2fqJVqJKHRl2f6m4bu1lRzkd8t?=
 =?us-ascii?Q?6UONeyF1M0z7q/mEBpDXiEH4JDCv3qPifPkxcxTmrZlHW03WtVqnWlHrKz8c?=
 =?us-ascii?Q?HcIo+3cnw9gLnugWkLVRA8rHTzbAfIp41kqjWOWUSu6slfn7G0GAk67gKVCL?=
 =?us-ascii?Q?X+8uj4+XL1tWOaYlPb7VnYQ4QHFxq8jL62BTqWdewE9J8Xjn6stlKRe55iH/?=
 =?us-ascii?Q?i7IY2VBewap2A/Zmn5mcEoxspmVQbiTLD6Lv4F8D6OwZImCaaFoJp9wCmIIL?=
 =?us-ascii?Q?PpSiyqWOK1/UO4vbtKJ6WxLxRfdqe79HiV0/NiJbhcNQqkCkD1hoVrAfVUmV?=
 =?us-ascii?Q?OteTwAdWv72ycDuatFl+742yGL7l8FrWKXRPV91ELpaHEACOPcEPkixilKUa?=
 =?us-ascii?Q?H40u3g0MwFCaeusW8hq062J6acZhEPHmipMhHYt7i4QJ/UAbr4dmpJmkxhHp?=
 =?us-ascii?Q?k8rx1rEJtOK4dvlf7GePUEMh5ah8LPPmMG4nRQTlUizJGSrXjSFtfJp9Ge+E?=
 =?us-ascii?Q?zgms/LL8Tjvc8EEOk4OPFVE9AXonMNWx0oshvT8wFQrwbYxzs77HKnPsX8RF?=
 =?us-ascii?Q?75iKhqrZ9qkzKXvhG5sUhPI3DSJkH+bPMcLu+9Jnv2lvLC9lSu1qnX4CUFbr?=
 =?us-ascii?Q?4Xi6/BCgDCByIb2N1dLpgioZPoh07O/sg8FCbK164v+58fz3haGdXoLUFV30?=
 =?us-ascii?Q?vzCmXyMd8jPnvff/hUjp+B/WniA5h1gVfCX0FY9d1w6lAZdPOgjktpT9ofZ/?=
 =?us-ascii?Q?oDHuQXAB/IyVtPc8JFqhJyZhn/F3dVsk5QYimZXy9+pQbJAX/xklMXXVwXNS?=
 =?us-ascii?Q?EWg4T6i1dFNLAObrKtyDLGGwe2r5fMB+kEkFCBvht8tRVUsJBMUzMPDS1kDc?=
 =?us-ascii?Q?/WVvZMQ2nXK/CZCWTvv+OjtCiBjftfgo1CVHsKDcpKBdUyTL0SmtcZsukAy9?=
 =?us-ascii?Q?KfF27v0QJCvTWZxnfer1CwuWqKgDPiWtw6gmnrwhtZq3KtRvc/4h1ByeyvE6?=
 =?us-ascii?Q?Mf0FyroVb2Cf4c=3D?=
X-Microsoft-Antispam-Message-Info: yhUPlA67IuH8HacB3QDOuOubQNPaqfwKe+WJJC3v+7sUb7Tm/ze3dW0DJqQnxgj3S4uu4bHCMqbb3LosZ1vyjU/9pdhQuCHodxdCMdDc6k87W3Ilrt9roX4j3G1NJ7uZl2OeHjzq2vUfY+AuQ7RNTWYjbTrpFphUxzuEPmKyom9mVcLD2oXBM0W7W8ymDoeT
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;6:Lmh+52g+dzGlvCkVyKWBSWeXY5D1L7OeHZKbecwdyYCrlGgMo+sUpAY0i8B3d6Obtd/gNb+uMc5h0iG/opDU9RVkGJdueqHKNKqz3C9DP9IEsWxaVAMifK6ejat3MQA65gD6GsxYJm7KOEPQTjd0jnD6Vuu4qtlNJyu1O9rjgFUsD5siFqWWrJvAP7SUTs4zH+Iq8QFOSgWtj1yw+vXQ29kztweiMtiyU5Pg+Zd8hE7U3S73Kf/2iI1UTybAGIS+kkyxvJpV3YjjKCIQCfUUz3H8N6swzbBvkBqhpVhVi2yhkn5tjvfkgZtGwhVxKPSf6IAPqxhO7d3acYR15fgc+I/3xi9d2dvpEbI7v8Q+KbggjFOBL9i7wZeZIPN0sp9nyovcOq2CDtk6kxujzcJ42nLng0eIhvGRg+TMQ1hLUKhi5pr5cKr/6mxAiMBN1GfvE1A1oF86mhCTLPqqwjakwQ==;5:HktPm2a6bVrAFDVZUzChblb5Nhvvqt64goF867k94K7I5UqQM98Diy0GZYC/yybiRcRuHebr099CESHZ/MY8oTAQNknYlUWHSeSr3SUHFWpRB5ImQLKQ5BVoonF8OZZJSaqXGzDFE2VF3QZ68l8O/o5MHI+V4pvJVjnsJHWa1/k=;24:QNThNnjIVU0yTQ5S6gwcP61ZblmbT4oicGmngCzpSZtg6laLSFSK9YZ6a+vprpyiO2u1wEFkHAp6aP8XnTyf3eUWIdVifTlKzJ5jDio12Ks=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;7:WA+Npv4g0E5j3BV5zt+hcbazXnrYz2lIJS+GK4ZZ9Mf5ntbfyw7meLdMd9j6IjjMDnNTvXnkxbRoVxQCO6hdhsM+LgQFj99IM95pdLznWojYDAzpjWRTfPKRwFlXmU+6iZdwWg7WLBXOqabhMNxFOZTwMveUtCX2CIX6nMSy8q66KDC6ZeYYhab2zmMXmUpqYgNY/dDOCa4wKmINyq1xcpwJt/pC8pejk16N9Im1C4iPA/8X9ZpJ+wlJbgUnOplg
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 05:36:55.0951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00de87d-32b0-4cd9-4c72-08d5d1b8d8a8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After sdma driver change to virt-dma, all bds will be allocated
dynamically with 'port.lock' acquired instead of statically allocated
before. That means the lock sequence is 'port.lock' -> 'fs_reclaim_acquire'
.But in case uart rx/tx dma callback coming after other kernel code which
have already acquired 'fs_reclaim_acquire' lock, which means the above lock
sequence reverted as 'fs_reclaim_acquire' -> 'port.lock'(acquired in uart
dma callback), thus, lockdep warning comes as beow. Actually don't need to
spinlock all DMA operations in UART driver with 'port.lock', because dma
driver can wipe off race condition by commone virt-dma lock . Split all dma
operations out of the code areas which protected by 'port.lock'.

[   46.155406] =====================================================
[   46.161503] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[   46.168122] 4.17.0-rc6-00008-g7caafa3-dirty #48 Not tainted
[   46.173696] -----------------------------------------------------
[   46.179795] mxc_uart_stress/419 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[   46.186934] fa7c1440 (fs_reclaim){+.+.}, at: fs_reclaim_acquire.part.3+0x0/0x48
[   46.194270]
[   46.194270] and this task is already holding:
[   46.200106] 09a17fda (&port_lock_key){-.-.}, at: uart_write+0x84/0x190
[   46.206658] which would create a new lock dependency:
[   46.211710]  (&port_lock_key){-.-.} -> (fs_reclaim){+.+.}
[   46.217132]
[   46.217132] but this new dependency connects a HARDIRQ-irq-safe lock:
[   46.225051]  (&port_lock_key){-.-.}
[   46.225062]
[   46.225062] ... which became HARDIRQ-irq-safe at:
[   46.234740]   lock_acquire+0x70/0x90
[   46.238326]   _raw_spin_lock_irqsave+0x40/0x54
[   46.242777]   imx_uart_console_write+0x1bc/0x1e0
[   46.247402]   console_unlock+0x320/0x5f0
[   46.251329]   vprintk_emit+0x22c/0x3fc
[   46.255082]   vprintk_default+0x28/0x30
[   46.258923]   vprintk_func+0x78/0xcc
[   46.262503]   printk+0x34/0x54
[   46.265566]   crng_fast_load+0xf8/0x138
[   46.269407]   add_interrupt_randomness+0x21c/0x24c
[   46.274204]   handle_irq_event_percpu+0x40/0x84
[   46.278739]   handle_irq_event+0x40/0x64
[   46.282667]   handle_fasteoi_irq+0xbc/0x178
[   46.286854]   generic_handle_irq+0x28/0x3c
[   46.290954]   __handle_domain_irq+0x6c/0xe8
[   46.295148]   gic_handle_irq+0x64/0xc4
[   46.298904]   __irq_svc+0x70/0x98
[   46.302225]   _raw_spin_unlock_irq+0x30/0x34
[   46.306505]   finish_task_switch+0xc0/0x27c
[   46.310693]   __schedule+0x2c0/0x79c
[   46.314272]   schedule_idle+0x40/0x84
[   46.317941]   do_idle+0x178/0x2b4
[   46.321259]   cpu_startup_entry+0x20/0x24
[   46.325278]   rest_init+0x214/0x264
[   46.328775]   start_kernel+0x39c/0x424
[   46.332527]     (null)
[   46.334891]
[   46.334891] to a HARDIRQ-irq-unsafe lock:
[   46.340379]  (fs_reclaim){+.+.}
[   46.340391]
[   46.340391] ... which became HARDIRQ-irq-unsafe at:
[   46.349885] ...
[   46.349895]   lock_acquire+0x70/0x90
[   46.355225]   fs_reclaim_acquire.part.3+0x38/0x48
[   46.359933]   fs_reclaim_acquire+0x1c/0x20
[   46.364036]   kmem_cache_alloc+0x2c/0x174
[   46.368051]   alloc_worker.constprop.10+0x1c/0x58
[   46.372759]   init_rescuer.part.4+0x18/0xa4
[   46.376952]   workqueue_init+0xc0/0x210
[   46.380793]   kernel_init_freeable+0x58/0x1d8
[   46.385156]   kernel_init+0x10/0x11c
[   46.388736]   ret_from_fork+0x14/0x20
[   46.392399]     (null)
[   46.394762]
[   46.394762] other info that might help us debug this:
[   46.394762]
[   46.402769]  Possible interrupt unsafe locking scenario:
[   46.402769]
[   46.409560]        CPU0                    CPU1
[   46.414092]        ----                    ----
[   46.418622]   lock(fs_reclaim);
[   46.421772]                                local_irq_disable();
[   46.427693]                                lock(&port_lock_key);
[   46.433707]                                lock(fs_reclaim);
[   46.439372]   <Interrupt>
[   46.441993]     lock(&port_lock_key);
[   46.445661]
[   46.445661]  *** DEADLOCK ***
[   46.445661]

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/tty/serial/imx.c | 97 ++++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b83bc2c..f2a2966 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -223,6 +223,7 @@ struct imx_port {
 	dma_cookie_t		rx_cookie;
 	unsigned int		tx_bytes;
 	unsigned int		dma_tx_nents;
+	struct work_struct	tsk_dma_tx;
 	unsigned int            saved_reg[10];
 	bool			context_saved;
 };
@@ -491,8 +492,6 @@ static void imx_uart_enable_ms(struct uart_port *port)
 	mctrl_gpio_enable_ms(sport->gpios);
 }
 
-static void imx_uart_dma_tx(struct imx_port *sport);
-
 /* called with port.lock taken and irqs off */
 static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 {
@@ -524,7 +523,7 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 			imx_uart_writel(sport, ucr1, UCR1);
 		} else {
 			imx_uart_writel(sport, ucr1, UCR1);
-			imx_uart_dma_tx(sport);
+			schedule_work(&sport->tsk_dma_tx);
 		}
 
 		return;
@@ -574,7 +573,7 @@ static void imx_uart_dma_tx_callback(void *data)
 		uart_write_wakeup(&sport->port);
 
 	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&sport->port))
-		imx_uart_dma_tx(sport);
+		schedule_work(&sport->tsk_dma_tx);
 	else if (sport->port.rs485.flags & SER_RS485_ENABLED) {
 		u32 ucr4 = imx_uart_readl(sport, UCR4);
 		ucr4 |= UCR4_TCEN;
@@ -584,19 +583,21 @@ static void imx_uart_dma_tx_callback(void *data)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
-/* called with port.lock taken and irqs off */
-static void imx_uart_dma_tx(struct imx_port *sport)
+static void dma_tx_work(struct work_struct *w)
 {
+	struct imx_port *sport = container_of(w, struct imx_port, tsk_dma_tx);
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	struct scatterlist *sgl = sport->tx_sgl;
 	struct dma_async_tx_descriptor *desc;
 	struct dma_chan	*chan = sport->dma_chan_tx;
 	struct device *dev = sport->port.dev;
+	unsigned long flags;
 	u32 ucr1, ucr4;
 	int ret;
 
+	spin_lock_irqsave(&sport->port.lock, flags);
 	if (sport->dma_is_txing)
-		return;
+		goto work_out;
 
 	ucr4 = imx_uart_readl(sport, UCR4);
 	ucr4 &= ~UCR4_TCEN;
@@ -604,45 +605,51 @@ static void imx_uart_dma_tx(struct imx_port *sport)
 
 	sport->tx_bytes = uart_circ_chars_pending(xmit);
 
-	if (xmit->tail < xmit->head) {
-		sport->dma_tx_nents = 1;
-		sg_init_one(sgl, xmit->buf + xmit->tail, sport->tx_bytes);
-	} else {
-		sport->dma_tx_nents = 2;
-		sg_init_table(sgl, 2);
-		sg_set_buf(sgl, xmit->buf + xmit->tail,
-				UART_XMIT_SIZE - xmit->tail);
-		sg_set_buf(sgl + 1, xmit->buf, xmit->head);
-	}
+	if (sport->tx_bytes > 0) {
+		if (xmit->tail < xmit->head) {
+			sport->dma_tx_nents = 1;
+			sg_init_one(sgl, xmit->buf + xmit->tail,
+					sport->tx_bytes);
+		} else {
+			sport->dma_tx_nents = 2;
+			sg_init_table(sgl, 2);
+			sg_set_buf(sgl, xmit->buf + xmit->tail,
+					UART_XMIT_SIZE - xmit->tail);
+			sg_set_buf(sgl + 1, xmit->buf, xmit->head);
+		}
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	ret = dma_map_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
-	if (ret == 0) {
-		dev_err(dev, "DMA mapping error for TX.\n");
-		return;
-	}
-	desc = dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
+		ret = dma_map_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
+		if (ret == 0) {
+			dev_err(dev, "DMA mapping error for TX.\n");
+			return;
+		}
+		desc = dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
 					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
-	if (!desc) {
-		dma_unmap_sg(dev, sgl, sport->dma_tx_nents,
-			     DMA_TO_DEVICE);
-		dev_err(dev, "We cannot prepare for the TX slave dma!\n");
-		return;
-	}
-	desc->callback = imx_uart_dma_tx_callback;
-	desc->callback_param = sport;
+		if (!desc) {
+			dma_unmap_sg(dev, sgl, sport->dma_tx_nents,
+				     DMA_TO_DEVICE);
+			dev_err(dev, "We cannot prepare for the TX slave dma!\n");
+			return;
+		}
+		desc->callback = imx_uart_dma_tx_callback;
+		desc->callback_param = sport;
 
-	dev_dbg(dev, "TX: prepare to send %lu bytes by DMA.\n",
-			uart_circ_chars_pending(xmit));
+		dev_dbg(dev, "TX: prepare to send %lu bytes by DMA.\n",
+				uart_circ_chars_pending(xmit));
 
-	ucr1 = imx_uart_readl(sport, UCR1);
-	ucr1 |= UCR1_TXDMAEN;
-	imx_uart_writel(sport, ucr1, UCR1);
+		ucr1 = imx_uart_readl(sport, UCR1);
+		ucr1 |= UCR1_TXDMAEN;
+		imx_uart_writel(sport, ucr1, UCR1);
 
-	/* fire it */
-	sport->dma_is_txing = 1;
-	dmaengine_submit(desc);
-	dma_async_issue_pending(chan);
-	return;
+		/* fire it */
+		sport->dma_is_txing = 1;
+		dmaengine_submit(desc);
+		dma_async_issue_pending(chan);
+		return;
+	}
+work_out:
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 /* called with port.lock taken and irqs off */
@@ -696,7 +703,7 @@ static void imx_uart_start_tx(struct uart_port *port)
 
 		if (!uart_circ_empty(&port->state->xmit) &&
 		    !uart_tx_stopped(port))
-			imx_uart_dma_tx(sport);
+			schedule_work(&sport->tsk_dma_tx);
 		return;
 	}
 }
@@ -1405,7 +1412,9 @@ static int imx_uart_startup(struct uart_port *port)
 	 */
 	imx_uart_enable_ms(&sport->port);
 
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 	if (dma_is_inited) {
+		INIT_WORK(&sport->tsk_dma_tx, dma_tx_work);
 		imx_uart_enable_dma(sport);
 		imx_uart_start_rx_dma(sport);
 	} else {
@@ -1418,8 +1427,6 @@ static int imx_uart_startup(struct uart_port *port)
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
-
 	return 0;
 }
 
@@ -1435,6 +1442,8 @@ static void imx_uart_shutdown(struct uart_port *port)
 		dmaengine_terminate_sync(sport->dma_chan_tx);
 		dmaengine_terminate_sync(sport->dma_chan_rx);
 
+		cancel_work_sync(&sport->tsk_dma_tx);
+
 		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_uart_stop_tx(port);
 		imx_uart_stop_rx(port);
-- 
2.7.4

