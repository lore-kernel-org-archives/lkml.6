Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeC3Kge (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:36:34 -0400
Received: from mail-sn1nam02on0074.outbound.protection.outlook.com ([104.47.36.74]:11200
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750971AbeC3Kga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:36:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 30 Mar 2018 18:36:15 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: David Miller <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] net: mvneta: improve suspend/resume
Message-ID: <20180330183615.6b34d153@xhacker.debian>
In-Reply-To: <20180330183332.3e180a1a@xhacker.debian>
References: <20180330183332.3e180a1a@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSBPR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:603:1e::27) To DM5PR03MB2635.namprd03.prod.outlook.com
 (2603:10b6:3:43::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d971722c-22d8-494a-4f1c-08d5962a1889
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2635;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;3:AkZ/aDevHwZjEQyxsobs4DbwQltKlaPA/0P32QJyKid9FtLOMQJUE5pei9pc+wR8/Fvcp0wtmlsZv7A52DUAAmf6iBPMUq5mVW0BcHYS9oXi5XFXy5uLH4JHVVJYjzBaM00yPJY18LnBHFGj4MrpsTV3CWkd8Uk4pf7Prt6VYLZc5dTkisgU1BVY53HECF7eUlREwAlvgy9u0I8LQ8imBlJyEPLsZfj8g0cOBJTbAEOqGUFbWl4Ihqq2T5FaFKw2;25:YVE6Q3FrjWZ+rEeOf3WIj3rESeFmtVTH4+R3JwQ0VVRB2G0wmXGEY2Pb4H2wHY8I3HHbnin0W6cRNLOwKmSbfZUxZVPEbif/A29b+7vdOc9+uOSeyPJt1wUwnw+LmDfKizh0SAMvARJCn/1ELwZn0MHJishIGCv3ORso71H4XUcJIzd0i9oFqFuKebXJOH6WJAvCbXuKirkwGQw7YNSts3B71Mq48K6lIdWUJJ1NgovYRT+D7j/m8WJ0pb36gly34stLIfFZ644irq2n/aOQ6xLb0R/1RrfwDceJRv1otevqFjqcZ++vDuyY5i07LuioiRKsJ/YpFANoYaTgDrgLsQ==;31:ePMnW4CBkhzBRY4AspbgX6ZquabIkQL0n8Y+kIyD5OH+ujKIdND5hnakFcRrSMbvS0vZA8X7qqEeJ866YtvCsGupsWNJudIL3V+ZzK2+qzA9pcL31RQbg40ZdmotomeBO4dFyLrp38+UDDrcilIr4GcP1aHb0xXTvsNRlIPq/cqboAmjRvBJVmcg4WrSSMHi9cI/A+sDDGKDSD8YPl/EjdKIVSAVRglRVNfAcV4+bSk=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2635:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;20:/3FB3wrbEKITUTJQWyNLnJbax0Hdbx3vXUGOQ+6MKGJ56CJXBo8Q+68jG+Ui3PeRSdZZJW+te5tLnBC+4+KP/9UrpGjDSTus6HSdSdE2siIxUSyoC3iJHkMV6wbBEabZxKziUjZvAZIMWzrvqbFgxjPh1UaA7OMMHqpoPYsAunRaNWD40sv14dpTsgnAh640/bTIae1hzp11a6Ch8r2FPOalP5zadeJhOULEqY637BT1rnms90OYEO2b/z6Z4o4tWhbtzvNBUmnVQWe0hRv9Jt+odFa2GI3No6DykxhLv5IYkZa2dg5yp0eM3Pd5+/CGZUVQnA8Qd+UdDperqqtnw/lkAruQDmQEIfFKDRxWUwumQt+UwDzuQZLv8CrhNI9DD7+LPNyJFIMbI9v41iOa64xngkaEuc4v4W4tCLSdCkftxXwf9mclf64vzAKzJKzAzfGx3sXS0DUBAQtIC9pEp7X1IFNHllVluRksKz/rZMi48NpZ6vLZf20MLHwCtekZ;4:4mBRZg5ZhRbvi+htJLNF0BvgwDwWrLTVp7gN2BBT4d4Siya/YP57y6iNbKhpwonl8BZUPXnRCwItpU4P1f98Zypz1qjcNBBWG/P/fQ43nTgkyFvnAwmVqAEF7B95ohEiw52sTcF5sFWkGwQez0vVWMdMFm86e3cqLyBVAl2sDdS+LFW8p1zcI3VgSf+E7Qp6RmaJJLqgKBRqDMT1J22q8gJ2J88qo0YFueD+gCIa+VUrTsGKphuuVKw7Xe0cti0KdDzGv3IXnQd9vy8pf4JYCQ==
X-Microsoft-Antispam-PRVS: <DM5PR03MB2635E26735830A201328724AEDA10@DM5PR03MB2635.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR03MB2635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2635;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(53936002)(15650500001)(26005)(4326008)(50226002)(86362001)(81156014)(8936002)(8676002)(25786009)(316002)(81166006)(16526019)(2906002)(230700001)(1076002)(106356001)(446003)(956004)(5890100001)(486005)(486005)(476003)(11346002)(186003)(47776003)(9686003)(55016002)(105586002)(6116002)(3846002)(66066001)(7696005)(52116002)(54906003)(59450400001)(386003)(6506007)(50466002)(33896004)(76176011)(97736004)(23726003)(305945005)(6666003)(7736002)(5660300001)(478600001)(110136005)(68736007)(72206003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2635;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2635;23:vJDPwb6B5uYX2Yjy4455dXU47P8VL4E+jC0ss8Mn8?=
 =?us-ascii?Q?oIJ0wt8f7jhCDxuCp2TNJKN76qdDuWJiiucxdvBlZFhWxH+AxpzYv/vUUmlV?=
 =?us-ascii?Q?Hr+qubQPL6RZ04f9sbK5zKJIIyl13t1kxk1o6b3AnMr4HM2ikBC+Trm6aiQG?=
 =?us-ascii?Q?0TZMDCItTP2EQYDJd3YJo4MhcOP73EV0yunp3X2S2n09iCaI6YFG1DjapOUc?=
 =?us-ascii?Q?RBkIkMY6slubHtZO0j6nLvwr4th3yOiaQni7LWIf0rrQ+usWIHEFM+LvnxNl?=
 =?us-ascii?Q?ZcGsRcWVLuG7lB/0EpZtGEIGkLhTgVWYE+bUvhnIWH38UvFy78wKfFVtub1o?=
 =?us-ascii?Q?f9WAInk9NLrqjHTsJzrraIYWh9xdIZDF88n58QRc01I18IFN0I/Ccxnc0gCy?=
 =?us-ascii?Q?p3jHDxe1R+Mv6YBc3kCNMTMm8QUUuKuAQjrxfD6fdm4rmN5tu4dRz8NzEnTL?=
 =?us-ascii?Q?UFrrx+/k7Om33W5oBg27iWCtQsWWy6/Ik3dxrjE36dH/bmegp/v5g2IFTTAF?=
 =?us-ascii?Q?X5vIIutRXFDjPubEmOLoxwtBbCrLJKHX1SSbMCD0+NxMkaQvQr7+x+BDBxR+?=
 =?us-ascii?Q?1gG494/7zZa+t8X/l/4b4N8Zba5vFEAc6SYVnI/VnzUbMmKR1KGd3V4ZudTa?=
 =?us-ascii?Q?c6rZlx7dZJ+lK/mhbFY7kIu6y0sv8sEpz6H9H4/FnXZwennkrQjG9zL16FIE?=
 =?us-ascii?Q?NJahv/cLa0pWzqUgiQdvMy0SiXokB9kaWRdrAkiovUTxm0aQCK8f1gEeHe14?=
 =?us-ascii?Q?Gck/Rn6CUjTmqK4YUnyL+0f5Gl0MPKS9NE1omxzmd3yaKiDD4BXj8wy4WL2S?=
 =?us-ascii?Q?us5PQTz5m6Yr1LuuaM4cLtgxzTyizMlaADPkUAIjceWg0ETOcLUadrLRQxoh?=
 =?us-ascii?Q?RZN5ZeqAM32mkSA1oJ7gnM3EQ+9TJjF5nfsRROQiqMON3h86M4Myj3olvM92?=
 =?us-ascii?Q?T4AT+Q29nlI5PR4Js9A3L9Q7NxwgyVVgJJkstjSm7kedHacJfMEmUGiwWt8r?=
 =?us-ascii?Q?MHgNLTyoP+X+ol+rZYyeueRP3Kpi3+NfyHS5sqv6bu5rNs28wgp1DHx+JASl?=
 =?us-ascii?Q?Fzx7qEu5t1g2mM5AkAeEewSaWavn9GFfMUR9ekX0WAwu7Mnm53rWr3sDN13V?=
 =?us-ascii?Q?5KygAepYvac3lWP2JtYaQ0u+KQvwSP/6ZhC1q6Od8acockMRdAxK5jh9IWYg?=
 =?us-ascii?Q?0mCYi4bZGEj5ZevRYt9c1Sp5P32pwml6IFDcitqrWT7aWcoMWEZSgrkurSsE?=
 =?us-ascii?Q?qwtJ7DHUn4jMuPN9fMs9QeSRRGqXcWGtiU7pyPq539LIfdfHTYK7inwa1o//?=
 =?us-ascii?Q?Zz/1xvDxnAd0/Q47KABIzftEcIF9B3uymiketP+QNzg+yepkehhKeZbltPuD?=
 =?us-ascii?Q?eLj8Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: Oi/d94hdYPUir2wCfrEzlHZHO+beuJ5sf8kkJ6dALZD/nCMzsHUqEAxaI7UWPyGcijxenuoI49lC8p6sT1piVm7i9LAwpxq+EnXNTL9CdYOzpUuPy2LgG9XOWK9fbl7rkmOfXXKqEnWp1Ku391wWNyLa4Fwce13H51fQ6Os+1OUWYitmo6BvYWq9tCCJUiZW
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;6:4oKoEqQ5aIrkZHYJg9ROacWdDuon+adODsSLVA1VjGBUBlL5iNLqDwPOPAeYxoZTQWyJ/ebpnZefMWkLAw5o8okPY3xxddWZV9vw2er5ZlWwZWIcd1u6t4iwhI1Nwsd4y1ly2UajIaOWvaHLUab9QM/9xMnqTjw5gYPNHp7M44LqkYWqlQsfs4v6SxvfCiLrUe2x87gHUYlU2CVjVX/kotUSmhJuXZdBUWtkQYLldjwSji7bRm4jJJ5Dq6PoOa7txMc2LqqqjXArUvxQsgF4oni5jIXdW1mAMZ4fK2B9vtcC4UzpalteaEWNc/6HXXiIIqwUmCNiRTnDBP19JiBS+g6xxycT3dKuDKGW+YO5SduWIRDnDxjYsVKcBoCeQEnM5Ip6t4CSS+rY2NBKHub2uo4hI5d4Vue5ybkInRP5TACgyOqLv8MqkSjkdpt/qqFkq8k8pwMcxoDUgoJ0At6WIw==;5:dXMfTFudkCK1AxblysacTM4a6fuUhupFNzvDifr6WOvFsXNJaWOFPEUaTYwTRcUMohdLhc29RAD52KqS76RpY9qM5EOnJN6PgT4IgwqfD56FVKYdupv62WqzGMgd3EAJl2zHwV0M3UeWs9bcYRYtZr/jhrfVKy21vhXxc1tXROI=;24:m+ZnVKRH6PhQFFijyWjjU3P5RtCn46KCJaj5Bjv2VMU+4VOYEBqU3Iaw9Cc+5f0T0d7ZocgTRFagKJTh6epSUYhDF++8QKP0JFGb7F4Gj8o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;7:XK+ny3Cd9eRdx8CqvroEcEcju9gGrPhiksbLt1JIf9YZXTmoPUi5BiJbV1I6h+013BQEwqgArxNSpvZGCNgJKFdTVX+DNQKTnKRuQB1rXBZVKBNbjWhTNOaDbMMzsBT2eOTeRFfZmdxAEZUVvxuYZzVCHod6pMfh7de3mlX4y1g5IUReREUSC/CKOZv6D6QFgV/9Hl2NPkilZx8aw/7x1PN6sa/h7IWm0H7vaxhbDmxrfvEgvNjjDuCIiufXfQRs
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 10:36:27.1925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d971722c-22d8-494a-4f1c-08d5962a1889
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2635
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current suspend/resume implementation reuses the mvneta_open() and
mvneta_close(), but it could be optimized to take only necessary
actions during suspend/resume.

One obvious problem of current implementation is: after hundreds of
system suspend/resume cycles, the resume of mvneta could fail due to
fragmented dma coherent memory. After this patch, the non-necessary
memory alloc/free is optimized out.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 71 ++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index f96815853108..cb7fce99ed6d 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4586,16 +4586,43 @@ static int mvneta_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int mvneta_suspend(struct device *device)
 {
+	int queue;
 	struct net_device *dev = dev_get_drvdata(device);
 	struct mvneta_port *pp = netdev_priv(dev);
 
-	rtnl_lock();
-	if (netif_running(dev))
-		mvneta_stop(dev);
-	rtnl_unlock();
+	if (!netif_running(dev))
+		goto clean_exit;
+
+	if (!pp->neta_armada3700) {
+		spin_lock(&pp->lock);
+		pp->is_stopped = true;
+		spin_unlock(&pp->lock);
+
+		cpuhp_state_remove_instance_nocalls(online_hpstate,
+						    &pp->node_online);
+		cpuhp_state_remove_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
+						    &pp->node_dead);
+	}
+
+	mvneta_stop_dev(pp);
+
+	for (queue = 0; queue < rxq_number; queue++) {
+		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
+
+		mvneta_rxq_drop_pkts(pp, rxq);
+	}
+
+	for (queue = 0; queue < txq_number; queue++) {
+		struct mvneta_tx_queue *txq = &pp->txqs[queue];
+
+		mvneta_txq_hw_deinit(pp, txq);
+	}
+
+clean_exit:
 	netif_device_detach(dev);
 	clk_disable_unprepare(pp->clk_bus);
 	clk_disable_unprepare(pp->clk);
+
 	return 0;
 }
 
@@ -4604,7 +4631,7 @@ static int mvneta_resume(struct device *device)
 	struct platform_device *pdev = to_platform_device(device);
 	struct net_device *dev = dev_get_drvdata(device);
 	struct mvneta_port *pp = netdev_priv(dev);
-	int err;
+	int err, queue;
 
 	clk_prepare_enable(pp->clk);
 	if (!IS_ERR(pp->clk_bus))
@@ -4626,12 +4653,36 @@ static int mvneta_resume(struct device *device)
 	}
 
 	netif_device_attach(dev);
-	rtnl_lock();
-	if (netif_running(dev)) {
-		mvneta_open(dev);
-		mvneta_set_rx_mode(dev);
+
+	if (!netif_running(dev))
+		return 0;
+
+	for (queue = 0; queue < rxq_number; queue++) {
+		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
+
+		rxq->next_desc_to_proc = 0;
+		mvneta_rxq_hw_init(pp, rxq);
 	}
-	rtnl_unlock();
+
+	for (queue = 0; queue < txq_number; queue++) {
+		struct mvneta_tx_queue *txq = &pp->txqs[queue];
+
+		txq->next_desc_to_proc = 0;
+		mvneta_txq_hw_init(pp, txq);
+	}
+
+	if (!pp->neta_armada3700) {
+		spin_lock(&pp->lock);
+		pp->is_stopped = false;
+		spin_unlock(&pp->lock);
+		cpuhp_state_add_instance_nocalls(online_hpstate,
+						 &pp->node_online);
+		cpuhp_state_add_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
+						 &pp->node_dead);
+	}
+
+	mvneta_start_dev(pp);
+	mvneta_set_rx_mode(dev);
 
 	return 0;
 }
-- 
2.16.3
