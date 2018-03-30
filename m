Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeC3MBB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:01:01 -0400
Received: from mail-by2nam01on0068.outbound.protection.outlook.com ([104.47.34.68]:46592
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752592AbeC3MAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:00:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, ynorov@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v2 7/7] net: thunderx: add ndo_set_rx_mode callback implementation for VF
Date: Fri, 30 Mar 2018 04:59:53 -0700
Message-Id: <20180330115953.17154-8-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:102:1::16) To CY4PR07MB2997.namprd07.prod.outlook.com
 (2603:10b6:903:d0::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffa88d47-0306-4569-6591-08d59635d94b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2997;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;3:WKwilrz0xmzOwVbxlGJS3nhhjieK1wjlfRJtxg+nOZhPGaCaEiRZCNlfANVvDlltAWu2ZkOMvbWTAfO86I+zbx3alMKLwKBYVhUU8Hpzsexpg52IQpNeM1tnRCAcUQB8IQAS/TjHG6lmNu4N0G6qzH2jJrrePBxSc1h5D48DY+eGMqCuDvbewYvJfBazkOY3UchAmf1TMdmBTUG60hShBNIkfrfJje8RL6cSF+bTMqi+2OiItXgirhXJ8K/kKIo5;25:Iu2PVclYQF3c21loUDAx5r5MsbZNrsng5RugkHfdVGF3h6eNY+RL4ofj4zutTLic1pJuqj1riLjSvKTpiVENQzKFNI6zMssy7uDcJ8L2iqNJtYpRQaLgCq1zD+W4+OcC9bkmsBKHR/guIRTktaiHE9bm9H9+uIG+Vie9lrAzG0tydhhJtot+2hrFGWqyiriCIOEcXSm0Bxhh/gkAZhkn4caTgrAbqn+PjJwV8Z81pdWlH623GbeF0YXk8eJRK6P4PacczYCGBAwUu7Tuhmr9RaXS/gBqraFhvdtndjzdC2rU0doMhpnLItBn0OrW/g9NJe0L/ug+YLanx6UMO1b0vA==;31:zZE2dBMDmXjk1e9y1rykgb9Pif78E0YQ7FSgEdbkUQnwzFbFNS+XrqZrrRzrhTUEkl7K9G63wAy3ch1Z8o/JzOr+lXMOD2Za9qwcLtbZZyLRMsSZl9f3JbFhOjjXe4/XAk9sZLqecmZ73soBx8ju0HQMeDnDLZrv0fGKvEi0D3y41nVdagem36apuW6Dd4ylADmXGiveRxNq/DJ00aGChQXIoOiqpUG869auYjezU6U=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2997:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;20:5J1DL720F618xZKMZ26SHBqVJQLJ5d0hv9Y41zbubLporGU80mOd3v9il4tE6z0Nc0GT7k9AVwP410+R9SFlyI5QTKoqjvCHefur94brYyzIkwV2IHvIDQwQp755ALp4gDgRW0//3S1LbBYil2+7qANucFjmqyV2Esey6vkiz9aIrG8zQ01UC0Ldn6ERXwRucjssV/oMeqBVs2A1WNQppYJnYmk4110F5+yjnCyUkLRlHNczDm8DsSuSwVPBhigT16u0d0mUpapMJmqCqnC/f/0bSVzPbBI3BHLqYHtqEtH0oruGNvLlvJRxOMluhqIshvGyDoXVpF2+SYJW/yq4kMAV5gIVDmrVE3NuhKe1xYdjZJGBNcSIgoc8mifdiobUAnDv178Dkb0oQh+9ca/b1XkUvsHvxA9ReZuYA/FKcIlC7zMSWOs6sWe2FVowmm1nmG29kLEMgq9WY3SRdUb11bFtIA4n7hvsUGgegushwFkw7ErdimgXQsAsVjWS/G5z+MvenXKQeeB3hfYsp+WBivuRISvehqkyKe7TdL90+mZmOOeP+/h6a9bRuxn74hPmKMiLPUPW/pK8a78+tNaQdnQ8PYI0E6mn39EAYZKKfWU=
X-Microsoft-Antispam-PRVS: <CY4PR07MB299791CA56BCE76DCC8B7A198AA10@CY4PR07MB2997.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2997;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2997;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;4:YbN6+YcY8e7H8Xji+vHJqcLF23nms/C3JUk0imiNv1aGz+RlHeoAQG05Gml+3l8nB6NMHbFzPZcN8AS9a30CcXsVj2nbn15JUqnnceXrMzNehPRlgfn6NT/D1kpa14XJCBSKrgm4/yMVM0q6l7s/VIq+XhZ7qJep04ghCXtGBWGfH9qqY3SbnEFFVeEx9nTD5P0pOZaBXqq1alPnO6/zhz2aqRNOxNOCmJFZemKRdfRI4dKman3blmpZ9M/RO2EzwzPHcqTPwQPxElwsj9eQXf4CeVU4svW4oWk9O7U5rs1JHZCqaTvk99M4n0n7yaB2VfSgmOpNQ8Ar4gMVNGA4Fn5VvIBuOkhCxXnbI0ejryY=
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39380400002)(346002)(366004)(39850400004)(189003)(199004)(3846002)(6116002)(1076002)(105586002)(81156014)(81166006)(8676002)(48376002)(50466002)(53416004)(5660300001)(52116002)(97736004)(51416003)(6506007)(8936002)(59450400001)(76176011)(386003)(69596002)(2906002)(6486002)(6512007)(72206003)(39060400002)(6666003)(47776003)(316002)(7736002)(16586007)(106356001)(486005)(486005)(476003)(107886003)(446003)(305945005)(53936002)(11346002)(2616005)(66066001)(16526019)(956004)(478600001)(68736007)(36756003)(50226002)(26005)(4326008)(42882007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2997;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2997;23:YYbiuxCqBAYSuN3z++l8TJk1rDgC8HUCc+e4uWGG8?=
 =?us-ascii?Q?jBohDtxKHPJHXvgh+vK34nnqbPwH6qTrD0GONJmZFylXbL7KmyQQ014NaiWA?=
 =?us-ascii?Q?gJXGN9PmOk2DbTp2jMOIxqPfpftsmoMO7ntGPBHAXmRroghHwNKI2TLR5Hjv?=
 =?us-ascii?Q?tQQsdCNwZFjOgG4bwJ25acHTWVqm2mpkYN3lVeFiCQc6pBAW9wpINkwFtrfs?=
 =?us-ascii?Q?fpzk9JaWD+Gc6A7idoncg4jsEXt5sUvYnY1dDRU+haripMWqSPdFMVWGj8m0?=
 =?us-ascii?Q?Nf3/fKKvPHVdxsktp3+avrsr031dyBQxfzna7zhlr621im2nt04ZwwiAMoxR?=
 =?us-ascii?Q?7ASfjYrc939wReBzsGexWM7ku3w/axIKVlLHbKGwQrgErL8UME9ahncEqPod?=
 =?us-ascii?Q?Tdo1sFJzcR52c///LNfI2xTv+5Om7VAo/MQDjx9hIXbn8vTyh7/I5BCKETkb?=
 =?us-ascii?Q?0E/aRuN7DxMqPMzV97BeWVq0QmB/FXfHqBQ05zDf9hXEK9KSLlMVicJNbrkX?=
 =?us-ascii?Q?/R6/bl9bk3Y1ME9IWbWee6MRVRVsdTFVmIOHW3eFrhWBwXsKE2KtxD0uxFp5?=
 =?us-ascii?Q?oDM0vGG02zHQbe394WaI0KSguzuTffN7po7+BIF3XHcS/LwwfY5TEI7ZUBqm?=
 =?us-ascii?Q?E+MsP3xGI8gRkxOU7MpoRq0DJh9rGu7tc2+KSgjVKHAYmlpttyubKwBvAplY?=
 =?us-ascii?Q?QvwcDZFK3Ni2dGhmhsC6fXXAgQXcCI4fkJ8jD+C6firG4tPN6q3kmIZbeLlV?=
 =?us-ascii?Q?xnDgrDlOc4piRKPlJlvHxiBXFo29mw0sby6c03ceLWCDLH9TzEBdbJuuCjbT?=
 =?us-ascii?Q?NtfJVUDVq/Ijl3KZekduNkzrIJLys5pMpYJWXc72dZSz9J3cSS4m/oMemsRV?=
 =?us-ascii?Q?8CYJwIaERhxiHR1dtxTIwJXrHmSUOp8GhK3AMyb9MX+mo3ybEtOjdZ4lSx1g?=
 =?us-ascii?Q?I/d1ojmSVraViUfOx16utNyHpfUBj6JF6O70Rtc4n3atz0O/byZXq+efJcIB?=
 =?us-ascii?Q?SQRShLofflpWSvT/3nQ8D3dDYiBkhunQdFuRgnl6dAX8elB8RrZmDXSpoF+J?=
 =?us-ascii?Q?O/47bBt84zMYAhYwSB6v0+j6Tm7bv/QGsLCp9+LOKNTC9hjFpyctxWi9gotI?=
 =?us-ascii?Q?/ENjcG0dkgEiQphzna3gNoK5I3ENrkA4MDFc5STFZdApipjLkflwO6an3o+0?=
 =?us-ascii?Q?TEtOUxvxtyMRGsRw53Ur3K4UgFqZL9+sz/P6vxinQtVNbQrxkvTXBDH+GvkP?=
 =?us-ascii?Q?k9hsYaUh+Q8UxS/eSzhkPN1Q/WlnkVCS4JDTLR9fmdUWJtp5mo+B6SMgndO5?=
 =?us-ascii?Q?UcmzBOIm6D/ZM6QCzX2JxjhFZUfwJ5Shfa1taDTA1sm?=
X-Microsoft-Antispam-Message-Info: wBNkVIpasoks387CgTAyfl83tLNAvoLYO1WfGGMAjVSGvDgYcbhbs9IDrukRcFeHhPQzYDuFAP7WQRKG9Y3a7bMs0WwzwQhyVGSkpDuAMsAAXKHS7G8sMbUf3NAmvkKakuZ3XeM7bcvlBxr1XeCfQxJi1J8NoeGXddBS4FJJ7p+BUbRzGso0ED75o2l0sEzo
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;6:jIwbeOEPBCk/NFyqDIRQi95t+rY+HICPQAsZyYXuQTr11/SUee6YmnXM8v7TNyuw2Abbt2mkdswaMm7XDiKFuXQRCiqkKpaUHlCkb+0drv42+OOPBAJ/OobMNxdiiyRABxWrl/LHRolvnUQ7qjpFgiUyRFk6Z7oER7bwqO4Hq9Fk2PVP48Rz+Xzw2vroYXnhcvf4VYWvdVhKzytSuKaJjTmfhO59aC3rOUR8y+c7e61NNEIyO6gczn+44Hngs6RQLkqyz2ADCJtjF8MbH3fbuw4aTU6Mv3Jmrqn4dYPRZgT9tkZlIWQG4RPub2bHajl3jArD3lvG59UKqKbD0J0nkE9gLoBR/H08bzlIB3OsBrjeDz+pCN1IRhjZR0xucpwlCBn/6m1KNb+kYCyXQbmMrjOo8BaSf1EBiS4GVF+1/zlO5ybM0xgQtDHIMziWWMm7j4CZcbV4RsRQACBcb8TcnA==;5:UdAHxKsSSy/IE0axu8AN6hkrzZX15V+xqmsQQiEu+0QLMhKmoO/NDr1l1woD9N2hWqY2wtXWzbYiBofzilBA6gHS9I2SFU06t6hDGXgg4EmHqzc4LcctsuSau0xbdIVf2ClkqDIJDTSVLGl99GF+HOxWWXOBsj5t6xQ9UeO3UWI=;24:EKsNKEEEBsaLc5A+JixiJgB7TRDXwR5JgmMs/ZSYayBGwMZTqDvx88OjSA+htRJUM8ITlvg91Bwo/D8ra+LFcWDYTUcQoLiezvLPNJUrzAM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;7:dYxng7MoOi38hrYxQukDDYGo/1WSzS9n9ig30XOs0feKlINK44W/3NZTeGrAjJsEGs6mzmr2iE857fQYLKwbjbJqtOTWne/esz8WeMN6biz9Q9eA4DaQDgZ5DwCqKYZlIoT8gIO+MEJIy6hyo3QBCpEO1c0ZWl/0j4jEd2jlYVBIGPhqtB+DzQhkpGgjBiFeg2zqrEn8LKms/RXUNJu/Rl5PrxvzlejInNfswbM3vOTLiF98Ak6nxZb69RdpCWRs
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 12:00:36.0198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa88d47-0306-4569-6591-08d59635d94b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2997
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The ndo_set_rx_mode() is called from atomic context which causes
messages response timeouts while VF to PF communication via MSIx.
To get rid of that we're copy passed mc list, parse flags and queue
handling of kernel request to ordered workqueue.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 110 ++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 7d9c5ffbd041..c8a8faaf17e9 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -21,6 +21,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/filter.h>
 #include <linux/net_tstamp.h>
+#include <linux/workqueue.h>
 
 #include "nic_reg.h"
 #include "nic.h"
@@ -67,6 +68,9 @@ module_param(cpi_alg, int, S_IRUGO);
 MODULE_PARM_DESC(cpi_alg,
 		 "PFC algorithm (0=none, 1=VLAN, 2=VLAN16, 3=IP Diffserv)");
 
+/* workqueue for handling kernel ndo_set_rx_mode() calls */
+static struct workqueue_struct *nicvf_rx_mode_wq;
+
 static inline u8 nicvf_netdev_qidx(struct nicvf *nic, u8 qidx)
 {
 	if (nic->sqs_mode)
@@ -1919,6 +1923,100 @@ static int nicvf_ioctl(struct net_device *netdev, struct ifreq *req, int cmd)
 	}
 }
 
+static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
+{
+	struct nicvf_work *vf_work = container_of(work_arg, struct nicvf_work,
+						  work.work);
+	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
+	union nic_mbx mbx = {};
+	struct xcast_addr *xaddr, *next;
+
+	if (!vf_work)
+		return;
+
+	/* From the inside of VM code flow we have only 128 bits memory
+	 * available to send message to host's PF, so send all mc addrs
+	 * one by one, starting from flush command in case if kernel
+	 * requests to configure specific MAC filtering
+	 */
+
+	/* flush DMAC filters and reset RX mode */
+	mbx.xcast.msg = NIC_MBOX_MSG_RESET_XCAST;
+	nicvf_send_msg_to_pf(nic, &mbx);
+
+	if (vf_work->mode & BGX_XCAST_MCAST_FILTER) {
+		/* once enabling filtering, we need to signal to PF to add
+		 * its' own LMAC to the filter to accept packets for it.
+		 */
+		mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
+		mbx.xcast.data.mac = 0;
+		nicvf_send_msg_to_pf(nic, &mbx);
+	}
+
+	/* check if we have any specific MACs to be added to PF DMAC filter */
+	if (vf_work->mc) {
+		/* now go through kernel list of MACs and add them one by one */
+		list_for_each_entry_safe(xaddr, next,
+					 &vf_work->mc->list, list) {
+			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
+			mbx.xcast.data.mac = xaddr->addr;
+			nicvf_send_msg_to_pf(nic, &mbx);
+
+			/* after receiving ACK from PF release memory */
+			list_del(&xaddr->list);
+			kfree(xaddr);
+			vf_work->mc->count--;
+		}
+		kfree(vf_work->mc);
+	}
+
+	/* and finally set rx mode for PF accordingly */
+	mbx.xcast.msg = NIC_MBOX_MSG_SET_XCAST;
+	mbx.xcast.data.mode = vf_work->mode;
+
+	nicvf_send_msg_to_pf(nic, &mbx);
+}
+
+static void nicvf_set_rx_mode(struct net_device *netdev)
+{
+	struct nicvf *nic = netdev_priv(netdev);
+	struct netdev_hw_addr *ha;
+	struct xcast_addr_list *mc_list = NULL;
+	u8 mode = 0;
+
+	if (netdev->flags & IFF_PROMISC) {
+		mode = BGX_XCAST_BCAST_ACCEPT | BGX_XCAST_MCAST_ACCEPT;
+	} else {
+		if (netdev->flags & IFF_BROADCAST)
+			mode |= BGX_XCAST_BCAST_ACCEPT;
+
+		if (netdev->flags & IFF_ALLMULTI) {
+			mode |= BGX_XCAST_MCAST_ACCEPT;
+		} else if (netdev->flags & IFF_MULTICAST) {
+			mode |= BGX_XCAST_MCAST_FILTER;
+			/* here we need to copy mc addrs */
+			if (netdev_mc_count(netdev)) {
+				struct xcast_addr *xaddr;
+
+				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
+				INIT_LIST_HEAD(&mc_list->list);
+				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
+					xaddr = kmalloc(sizeof(*xaddr),
+							GFP_ATOMIC);
+					xaddr->addr =
+						ether_addr_to_u64(ha->addr);
+					list_add_tail(&xaddr->list,
+						      &mc_list->list);
+					mc_list->count++;
+				}
+			}
+		}
+	}
+	nic->rx_mode_work.mc = mc_list;
+	nic->rx_mode_work.mode = mode;
+	queue_delayed_work(nicvf_rx_mode_wq, &nic->rx_mode_work.work, 2 * HZ);
+}
+
 static const struct net_device_ops nicvf_netdev_ops = {
 	.ndo_open		= nicvf_open,
 	.ndo_stop		= nicvf_stop,
@@ -1931,6 +2029,7 @@ static const struct net_device_ops nicvf_netdev_ops = {
 	.ndo_set_features       = nicvf_set_features,
 	.ndo_bpf		= nicvf_xdp,
 	.ndo_do_ioctl           = nicvf_ioctl,
+	.ndo_set_rx_mode        = nicvf_set_rx_mode,
 };
 
 static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -2071,6 +2170,8 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&nic->reset_task, nicvf_reset_task);
 
+	INIT_DELAYED_WORK(&nic->rx_mode_work.work, nicvf_set_rx_mode_task);
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
@@ -2109,6 +2210,8 @@ static void nicvf_remove(struct pci_dev *pdev)
 	nic = netdev_priv(netdev);
 	pnetdev = nic->pnicvf->netdev;
 
+	cancel_delayed_work_sync(&nic->rx_mode_work.work);
+
 	/* Check if this Qset is assigned to different VF.
 	 * If yes, clean primary and all secondary Qsets.
 	 */
@@ -2140,12 +2243,17 @@ static struct pci_driver nicvf_driver = {
 static int __init nicvf_init_module(void)
 {
 	pr_info("%s, ver %s\n", DRV_NAME, DRV_VERSION);
-
+	nicvf_rx_mode_wq = alloc_ordered_workqueue("nicvf_generic",
+						   WQ_MEM_RECLAIM);
 	return pci_register_driver(&nicvf_driver);
 }
 
 static void __exit nicvf_cleanup_module(void)
 {
+	if (nicvf_rx_mode_wq) {
+		destroy_workqueue(nicvf_rx_mode_wq);
+		nicvf_rx_mode_wq = NULL;
+	}
 	pci_unregister_driver(&nicvf_driver);
 }
 
-- 
2.14.3
