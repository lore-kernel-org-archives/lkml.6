Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9CAB2C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB42208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O4AX0M2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB42208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754670AbeFNGEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:04:45 -0400
Received: from mail-ve1eur01on0049.outbound.protection.outlook.com ([104.47.1.49]:11685
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754618AbeFNGEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOjMt2i7sVvqqMD3dlnxcHUfBZt/L/3tFos3iUUovyc=;
 b=O4AX0M2RmLqzHUOUU36qxhhu4wunIBLbJAcS2uxioUnuXCeJdImcHl6bw3/NMIw11VSY4k+EKpYjBI9MTIP4+1yiOkwphI27SppjVQyqmHZRnBfja4SzbsUr4+DyzVh4kmrfxjz/CoeHQiidMN1S6g8JB/tYMClpIEwbTNQmCCQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3219.eurprd04.prod.outlook.com (2603:10a6:206:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 14 Jun 2018 06:04:32 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v4 7/7] tty: serial: imx: split all dma setup operations out of 'port.lock' protector
Date:   Thu, 14 Jun 2018 22:03:02 +0800
Message-Id: <1528984982-5074-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
References: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:203:2e::26) To AM5PR04MB3219.eurprd04.prod.outlook.com
 (2603:10a6:206:7::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c42b5ad4-a36c-4ada-9e0c-08d5d1bcb4aa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3219;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;3:YPLNQrurlATJ8CdgVV7GSyd9S60T+C/hO1oPuygiMoMJJIJfD+q+ihvP7vzD2m6TAYj/FnnWWUZff7hM/5ywMCB01U8UYjHUotxsgBxUsHf78lFVMLbQk4/L/4GfZ5IIeBpz5O9IT3rvbfqqp84GKfhVBnAhbRQ2VrweE109ynL3mJqpaNP8RZYTtB6nXGlQhhXflKnLO+FvFhWgTrDkwOzGxbm4GKOa9iOoyj+TD+cS/93R8gbLL61zca9ni/1f;25:GW7Yt9qeQfrIeTlWGR4uHIHcREjy3LXAVXS2rHgw7e2ENK/KlXDnydt+PmqSdysz+odvWnjXrYN+tTrOVm5l2dk7s/1JNJgTWkq/b2YamugjkPoabT3xKTV7E0XpnsrVQPP3l3OXgV9KVA33rZeOQpzUjRBlMysPndo6b8og97YAVduK3TmEL6QG62fJDHuCwMcs3pCo+r/TldZe4vJu/ng3QPWQ5bskoD68Jk39YMC2pDyqmHYfWJ+icxDVhTZjeQdCJWnhuogywQiak9LYAXZKeAKRLn0wgbJ8T+JMDx4aYXO5d0pIRmhtdHNUcUOCQHbxuFawMbTQzAZwwOLXvA==;31:y1EH1Umj0KzwGNTdHFVNE1c1UxleEevLrQ2rs30Dj0WUCgI83xNLROURElhI3EJqqFoNPoRKzd+Rya0q2TX6/8dU3KyOnxZYaz0obHNeS01zSwmQIQo1fiFW+WTobSifuH0aK7dZF65GiK7uoHObmyUG1ZWLePVcb8LEunCwD1K0wzXnhJlq0Q2yntWZXidsjy4QKkzqDqE8Rdyc63GS3bHHRegy9pOvsc1sJE7Q42Y=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3219:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;20:HToVsaLscYGVwQ2PuUgH86ha4MvZxc3a/yEbEc8zd9P938U/hNVLcDmd0BC9j5b9VP7uOBT54k0oU9fU/L/RbYFWZtu+kt2TradcJmet950twoVc8OKa8hKyc+3NrIyYIlCu0YBfif7aViQHt/myp8+mzVT8vxU6zaWjaIDpm9EvvHtFUHLwasqcGxkjXdJkbPyw2RHe2wmVKztTwqqpNm1opgjzoll6heNqezc9zl7Ej2qVcttLtnn5+vV26Jc1PSDruUjS2lMkPthKsjIFiWyYGvpsMR9MPe9DFACFFdDiQtdJ6kWh3MrnnmH3x2DjeiHipEfb0ITi3w/YQI8nVLJ1LQ8aLgDgYdQxT2AsYC/ydfF1lQ2/GNRTGuSrWPYDWHOiEvrzDNlKZZnXsNLojPTvmdWC/fhakKcj1+4gfSiWp/vRwxElvy/KiD4FaWuVFN98SMSyoSaPy5pQ+ef04QRNbsG31xjnPGec+KqNMsMMScsE300FOuiAPlB/LtGv;4:2eOnxm/vxwvqRVSUmPNp1GUFZhvzcZul6rLMKj7fk1nFCHF/24RtzdQ1RrREQpfbhqjt9mGKIp7f+O87ZKSRlELm9FhoL3dRFlPWMOzRdCZsRr+6Ei6O0F31+cjjjWgYUjyiPgatwhyxLMd4rkMK+KmgCQo0Ddd9r8DwxYU/GoXqKsIiSoBb8KNdNNtJmy0I9s4nlJV67O8G9UEPhjSv2pyd7L7mFbQ39K1CmqAYfnQ8nTDsTJjpNN8M8uqiMl21FeNhW1+i/4sETCU7IaIzhsYocPsTLnHXDKsZl8cuAmkV+d3DrA2PMmKmqYJ7qUej
X-Microsoft-Antispam-PRVS: <AM5PR04MB3219E9C63924FC76D58591EA897D0@AM5PR04MB3219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3219;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3219;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39380400002)(39860400002)(199004)(189003)(68736007)(59450400001)(478600001)(7736002)(8936002)(305945005)(66066001)(50226002)(7416002)(86362001)(6512007)(3846002)(6116002)(47776003)(316002)(16586007)(8676002)(81166006)(16526019)(26005)(186003)(81156014)(386003)(6506007)(2906002)(52116002)(76176011)(51416003)(36756003)(6486002)(5660300001)(4326008)(50466002)(106356001)(25786009)(48376002)(105586002)(97736004)(6666003)(446003)(486006)(476003)(53936002)(2616005)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3219;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3219;23:Ar8cDL4v7zkZkML38FXopdLlglbwXKjVjPUoozFFK?=
 =?us-ascii?Q?FrROnSleeh3r2XK+uaorXnLfwswgtq0j8taMmF/6o2en+Bi2W9RKALaEHNes?=
 =?us-ascii?Q?gZKLumkbA+zLjfbjV/ZKlnX/qRrZSxg2zB0Qag0pg0EgnQsPDfGxqleK2K4g?=
 =?us-ascii?Q?gMpWv1TBLYTlQlH3kBM0CVKBvC5PkxZrJIOri2vUciOjkinzEBZ2rjwa2FIv?=
 =?us-ascii?Q?shxty7Lv5hojM4oe/d1RnNuN+vwGe7xtuS9UNz/JCodjRGpvFpIJ48qwhM29?=
 =?us-ascii?Q?IldBLVWfKIMA+LXnC+UTuOWzR2zL8nIzUmKXwh850L/anjA6Lbgg6Om86OeT?=
 =?us-ascii?Q?e8QkAgnU6icM47f7hpPrBPNBioBKqLZDgfsEOe+NXvaxElweoPHAutc0vQja?=
 =?us-ascii?Q?AU0f6CdQFuzcTXmMUCFCNusz1e1c9aqqBriuCElPSVh5oyWjMlGJzyEyB7+E?=
 =?us-ascii?Q?gtn12ddiweqW8IAfO3/SoLdKasHhBtTT/TSZr2UgOWl7isbesPoSglQut5hn?=
 =?us-ascii?Q?s2VbM41+6pUtb+DCpmdMF/p8A2dBmNZcLj8oFHM5x6gOJZyxingn5RlC2P5I?=
 =?us-ascii?Q?JdDky4pCJ4mLo15en7rIu1dmIob4AjFKrtVD1y/3Lai8Ac4+0U7x3f9aDgvg?=
 =?us-ascii?Q?zcMTXy8RGMjr5Q/r9SOVpI1AiJgDtWWlXimHPCVPnupEQEThG6PNS0V/Nh+G?=
 =?us-ascii?Q?T4jF9cawRo8ilgP6KrPAfXigOS0fypIrN9R6SC5zzxtaOVf9QKFNFEVo8jsw?=
 =?us-ascii?Q?EQEebxnLH60KJ3ClB4M4OK0tbzvVosLDO3NBHeUUfuMV2M3jjDIndW0ocuJH?=
 =?us-ascii?Q?5U/3xZmizftbM7L8La5RtR38ofA8Bwb+dGUWJBHdYJKnqJz5gPsOUPHQyyNt?=
 =?us-ascii?Q?B+IUoHYVPWrU3bz7aRS2nWWkCt5R/imQdv6H4E+KKm3CtLpZ2+DtUCQl8W7l?=
 =?us-ascii?Q?f9xIeaK1VHFvnRffSygCHA3qfzr0xiEg3JIDxKG2e0yPZ9NmBaXtWifyD5S/?=
 =?us-ascii?Q?ux9LECGXY2vBS1x+xVrcMrzE5nCAl6xCte3E/OLFOYmVBDPb7axXJzZLC9fw?=
 =?us-ascii?Q?XH+jBwfUikn7h0QONWZmmTASQAPSBGfY4+9VssT/zxb3nCh4u4eUq/Dec4q+?=
 =?us-ascii?Q?Cy3PLdAzNprAkuJhKO5o4HExDf1Og48iFXZc/lZk4LRIYlHLpngjEaXodAGv?=
 =?us-ascii?Q?xhZ3oyAwgR2cWZbBoX0ksR+1KJBAtok13AR?=
X-Microsoft-Antispam-Message-Info: s5+ReeeGxD8cBFjRqPWkrCU61gM6otLvuYlF5fwYLdniEJl67M0CnubO4n2dt6TeKRCUAUSAjNpW4J49lZm0dJDkiczsVFIt98Gp0/r3WqExXhaJ7WNmBZ7uYvJ3+ubQQAS8VXzUBqS/azqPXj9reqyWGw3qzNm1no42eUPCq2A1sgxwUbSUbl/F2OwavNVe
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;6:QOVxT96DP7GgfAUORWqRPpYG46SxHprujy5v8P6j/6CxUeeR0EbpmO4SYzRMxklvPrnnC03GCdFWi3tFsoEkuZ0RdRNGXpsyg47FcXuy6w6lOYLW39H0RdE8YNNllWeQgcxsgdbBhh13KyOXZHrzbVczzvzHG6NmsZ1ulEbSqGXO6YeChLJEVbR7m7TNqUHAIg3GoRzDj03n/tVuAZQBmPyPst2t0y/1VAA/jZYkAlkWYDRwypjBYQ1WCXwQR6vfyxZzwkgJ4RlGpMBTPClDhfvrHOdNPvqZCv/IG95GhNa0TVCUIWCZ6INgUzTTsoW2p25AYPP1EIGT7PRhFLcwV5R5hd0xTHfAqOuzUAwz0IYkcjsONsveF70A2d1ivQ1L4TXYd/VQBaw1TLpfj7bdST5cUo029Y5uva9Oonu0TX0JB4qinW/OE4yHcXn+L+nydGuT/p9TH75HhGspvG+rIg==;5:vPo6FLfOk+WszVvfag6czcmA2m3Ytpf+VbW2U0A+dLlM0smWQ366OdHVPrK80J800USpkWHVSbP37gtwr58W3c8usyuC/u5SAc9WbdCGGBmuJ2zHr33UfrDr8+25bUmLsovjS3EoDwbcnLe1hlsFewixOwy2FSQKIOxsY23SNG8=;24:5VaDliWX3FWagHw3Xm6mUyAiddXTyuYu1QjTne5r7yfgX7ikz2uM9dbOD54LDjjyTBAwAp4C/lxItZgdqHOs2Iu6+Sd+1SPrNen5cpWazpM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;7:ZO0XaOoudu2498Gb3xM4uj/ylu1Tg9yTTG8NfDAOIewCaD1vbfwUXwXFt1PBNl2q3b4NSAWmW/VBHXUNaQbvmaqC8tZQddmKnMZw8lbkZo7cgh40aDci9zZKfik4TkYDJZ9OdhQVJ8ZmT0K2royNk96NnRn7yL30EZVToObs2KAaJmE5qNka32sRf3GqKe+DZ8x8Zxlelw7jIA2eBOp2uEtrUyxCLhjBcghSdVGcD//USDR5A9jTANtZHmMgkXK9
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 06:04:32.5097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c42b5ad4-a36c-4ada-9e0c-08d5d1bcb4aa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3219
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

