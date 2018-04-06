Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDFTyL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:54:11 -0400
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:57504
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751367AbeDFTyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:54:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, robin.murphy@arm.com, hch@infradead.org,
        gustavo@embeddedor.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v4] net: thunderx: rework mac addresses list to u64 array
Date: Fri,  6 Apr 2018 12:53:54 -0700
Message-Id: <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180406140443.15181-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180406140443.15181-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: MWHPR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:301:15::17) To DM5PR07MB3002.namprd07.prod.outlook.com
 (2603:10b6:3:e3::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27bd79bd-3978-4281-eb60-08d59bf826f1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3002;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;3:oFmVqah8WvmpUohRmx1wLVhGlIYVXJQPbs2/UDH/x/4DaiWC73YSPvWJ4pKUKqtHCMbfJPBn9hvhgY7ptKTzCYufnMNFISRR4MZ49imqgFgQM/QYtiCCk2hPzONZxyGs1I7YN8o/d1+22Muc7P448zCpxG9xSsb7JrnLYBj8eBSwE7RzNnl8pD/nrqqsIEwxazXqmg5D/czDPrWWzbpqrqAhrzcD1Sb4+8HJB5KMoMre9zCe45/EmbxEA+trzJdu;25:STgkdVoU6GGa/NlUX4ajyPB4ltNMQ22vVKpWeXmu+1dqPSErKj0coLvIhlPStUWYjDS+FlqG0n7vz90Bqg/Q1OzL41RiDauPAUgR1TRs8VHzZGNHkjA/GYEuVuy6yXSZ0JHEgCVhhrpmHOw0CsToS9NhEAtfmrWF0Pp+P3oM2XRd5S+guTQ+tAqAugfOi09i2Fztf5rKgwbFBcUf0kNN9HBkoV5p9FIS+mWdnBdugoFT9rDT7RpF22zHXdgtU+8OFKVMwBh20ccyhAQadPEEgw77ftR9+N9YWryeopweosbz1msTh6lgQ177klpdgVCyrLe5tSCoVxAu2WuzU6JhGg==;31:umIEJxe6UwF40VRguf/RUaDMR9f+cszIdBuhxF36XSM8V5DCka9XeasM8pl94ACdotiuGq362cwaUCHO3PngiI5g6HQ0EcXEfVCUYP0IvLjubiKRfghfK2hIv386Mp1sUSX53MqsY/OgyOHc6LMlGnrTj/FHKKSoo8d8EPwNnY++JIDkqHCm0ju2k5Z9M4aqwuBlGHxjauegvzcmJeXwlJT3cgGljqexPRLO/7GytlI=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3002:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;20:Dsz3S66csg69PS/UXMbkOnmyOPVTN34KLAigJ1I8OXLT27xFgS8Pdj7XrdEB1khxt8Xb2B0xGIh4xSzTGH/3B5wz4hLYmclfpjWgtcrFUnCvq1RzunPUjNUtl54Sf6xTHQ2fuPOeZPO4CF6UR63OKY/gyQ/12PyYl/W3ClBRHvPWEIabgVWH7eWRaLqko9uXaLIm9tY1G0/kY1J4l2t8xU61ZOl+Rha01ADU/dNdD1u+O9ESOU8pQTQiXI5kq4qyW4i2PPzEk2oVkoI5iUxS6CLjmkoQ85ExOcDrbYTwog8fNWagcxdETo3YK3B5bEGXFRqBxk2GDHFUu0ESgPaRPioCy0GMrBAq7N8anRTeBuV6lDYYTWfEtZaMvq890fYYlUuP1zaQZuDWBM37XnAuax1DOeiMhQLWbZAlXWYlOyhNysSfLs040OC8r3a0ovUI1IUVEHqAU1wqcnJi6TaP/nrbfa61kiybJNjdoGCTCUlDhr/MLLlkzyRTr7oTRgSsI5GVcKPK9SDBLyboUuMkWm3S7STKMyQBwdEFpIThkkAdFdoOiNXuozkUAdZuzCzvRi9x1ZnaCyqzzdMzvUesYWw2OhO0qaVbRMoJUhSGB30=
X-Microsoft-Antispam-PRVS: <DM5PR07MB30024A596C870DFA69DCDEA28ABA0@DM5PR07MB3002.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR07MB3002;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3002;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;4:ID6bGnmKrDO/GOVfFidsX1/f5F0QGcc00iX+keRSOmCpag0sw6xZsRda9WR27It78k7KGOmScyb9+AGinR+z4mzTKvh9j/0VwUP7xyurqhLQfD1BmIsHIIyIcSJ2PrGApH/hZTZdo44btMdtIDxQ/e4USZuPxy1V6qXcL2xYx3NjRDdFGzoyj9KVf87uKJLZWRQVkPKZ2HVfSty2K9GNN18R9IXKZzDYG+sRlLaCJYqfgUpmxe/nE5IMytQ5CcgauUoJ6EQSA7rc07bKyLkqnPxVoUfqAKlqExlUz0uS8uYCFjy+RLJnFk89Ff1khd075uiOWcA51ZmEgzpdAFJg2v79iRg31v7MyUbINU10+nY=
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(66066001)(6506007)(478600001)(39060400002)(305945005)(107886003)(4326008)(50226002)(59450400001)(72206003)(8676002)(105586002)(81156014)(106356001)(7736002)(81166006)(76176011)(52116002)(51416003)(7416002)(47776003)(97736004)(8936002)(53416004)(386003)(3846002)(6116002)(69596002)(6666003)(11346002)(446003)(50466002)(48376002)(36756003)(2616005)(956004)(2906002)(476003)(486006)(26005)(16526019)(1076002)(42882007)(16586007)(6486002)(53936002)(5660300001)(6512007)(68736007)(25786009)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3002;H:localhost.localdomain.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3002;23:cKqsBMDshZ3lu1lR53kseQBEHk+xZ+0uSXX/gHQmg?=
 =?us-ascii?Q?P9UQ2vtBaNFwT5LdS1bIpxmMn0kQ7BuWaUZyxjND7h7RlypHj9+6EDL+3lrL?=
 =?us-ascii?Q?EppZme8ck7QDGhyF1p3gcA/0Dh3fMdfZ99VVXVbSZ4zK6kWqNLKL4yhQmM5T?=
 =?us-ascii?Q?fLGO1TCiA3S9bdDETvvwnegMr644y04DCqg3uFm43Y03okNByzBLfLKRg1Og?=
 =?us-ascii?Q?yzC1qAeYuFE9E14wUQyY/yvhzqUbf5VsZRKeXG/vsGL36VNuzIMD4Pxi0aYp?=
 =?us-ascii?Q?rpooXmssq/L/s1R/wnBA9pvo2u2y1Ao/0HcJ6003xM5nqkTwdsARqBsKY9VS?=
 =?us-ascii?Q?URt6HvdTNXcREJE0W6/u8sK4lK2KgZYSD9icL3z6n1VNLIbfy0jcqMqp9Zgs?=
 =?us-ascii?Q?wnNIqKDwbIJ0830lust3PJd1nKLMfCfI2G/nyaEWBScMEi0j0KNKXOz0MF3R?=
 =?us-ascii?Q?k8BRGk1HrCwlxxmsJbDTz9LU3Mu0cCkednRCbEe5VYsu+JwgrBViI99W1vlk?=
 =?us-ascii?Q?xW7LjeiOi2gk/J7NRhbN2AHH5uKPa11bA8NB2yBVqOdMZI6Fnss4SQ1ftaiQ?=
 =?us-ascii?Q?GkkhxC+79X02YX9bamdRi4v9vNuyQ+SFZaF16KAJae+tRTgOd+8V4JPv/lSe?=
 =?us-ascii?Q?YtIBFX5fLtZs77nB20eHirkLaGyg8vWI7PaLyJH2z15BaOfhSXCCtPMpdwRu?=
 =?us-ascii?Q?GT9fVhf+XdcSG9dl1sdQOOhJtQWHtZGivBUp9he6wHd7HKtKUTUH2/6rX5GZ?=
 =?us-ascii?Q?fIdhVyiuLHa/yKxdOLO7XUr7nGLqSeLQpa48Pzday6GB7obrAe/28DPeMlhh?=
 =?us-ascii?Q?gzsHqjOzcO3JQLrFIDEeN4TFfsFR3W92GnhbuasNEowpBzRpkj8S0lL+7r0R?=
 =?us-ascii?Q?ZeZRRm/brEF1stDtPZPkF93jiOFg0NO4m/5xE1R2PKuws7xlr8v5T87+cl3z?=
 =?us-ascii?Q?DkQpYWub8PQqonEdCH9MCviyPPCYqdbOfaT2ozxDgQCwEeDjOjSJNfTRbh+1?=
 =?us-ascii?Q?gFW0gLGlWVm2TZmaGF4n4SoUycl9zesmuII56nqp4Sbs9PQd+3p+ZzXwfGLR?=
 =?us-ascii?Q?LcXNsM9ERQXUT4oqc5hMkxc6WcJsW4yfrheH7fcIllFUE2IkVnnpI53FbFzt?=
 =?us-ascii?Q?fouCz1EICfz1GzSsVR6LjXx8MTNpsV8OXd0bGBSL6U4xRqNI4feoSwpzTvB7?=
 =?us-ascii?Q?A2rjK6B7sWm51010YRcHjsP/TLIXAXTcxzYONTXErThqQrdRpOHUX1Wrz7+7?=
 =?us-ascii?Q?LgvVvlDZIy/htg+max6id2a+e2FP2nt6AiSKIFoRYvanlYgnMYjGfe1vw+gs?=
 =?us-ascii?Q?J+wIILc1LugTWQiXJS2nUkItW83Sz2945SKKJSMQ5ec?=
X-Microsoft-Antispam-Message-Info: FvhJGLGveyEv4QatspFaH5aZnYzrBWfJ0M6balQlDlYj6Dw0F/Wac43I1pDYErDlm26Dew8u24f+Om2g6KOZlEaIwOa4jSF4YV5+9H9DQRRmO3QS5eq8nyAHHqZnhDF8bNE1ef/aPYZCAZ8mqRs3lnVIvo7ubC6/hpD1sVyKaoO6KLYVII07mtcRD6orM2EF
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;6:fk+0b0swryCpOAsHp5hzvElHdB0Ec/FWo886ZhdRetA5G1cLGKl648byaV5SZFm/u7un86ZaDCWIZ/G7glt8tAvPBbNnMqgp+CEyCg32SzYdz+wq1eoKlOJIhAiNojsWvPI6VvIcELH7JRjfGIIf0VbvIZlEN6hQq4dIPzaoJSfRaVBA+eJs0CdBMu9IbnJhtESlH1x3iqT3MAWhCC9U33tQXaIDhU8GrtbVKzYFA+PEk+7spZk+vfJHYDWtb9T8ee8Hy6y+dzZxrWfOWqEpf/tjLC9ZqdFUH/oef4pZofoCZC4598uzm/rW+y9bgKIA4a/uFw3AeKKzuOv3YcIIQx4dBLg7jOUrFiJnd22/Q2t1rseyEp08WESXW6BHdnLodCa7/OFHKFsoYrSXIxr0pA8Sg40bn7+azkCXZS7+zbwuJLZhU4IPsYwHHwROL+VtU/EXqRSp6J0b0Zt3HjHVUQ==;5:O5Jt5jS7lGAHOAFdPTbdo4JxsQ9BWCD4oWrEMIsk8aCXkO5hQYygW/Gc0hFOi1KB2BDbpXVyWJZEyseSyTGmA3ESgCUsl1ZC+TCVsTt2psncO3K5FpRZ9HIPK1WhRAcTt0+tsWbuS4dBIVmDBRDwddqL0s+T2CJ9rX1nMCymO/A=;24:9zBqb7Sqej3phPCQiGa9nEIEIPw/Qb7YE1qZVhMzBCvaDkSIhNxhOCM8aJUuapsUECWxYQoBd1WtwhD8XmGScewq58PSfcak6rbrdVqG4Xw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;7:1/+SFPOGuFcsqTpJnW4dXnFS0zWP5FjkrcUTFlnlyz0HQ3t2vcO19+qMNO0D243F+NEjWEMYSdHPlbE7VGV8d7Q58IAmzXb7JEy35AVqbC3nAU2bC9Or9JX3bSuJ6uAe5T1r66ta8v+7BbLiQjp3fc5ACfXfopuPm2riynk6i5dMN+G3qgGwlnC5gWNkS8+WfWgTL+JQlXPJXUKrK68rdpcuuCmLRqVa9nZJprjj8znppkDgBkgEHnMOSZllTuzk
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 19:54:03.9595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bd79bd-3978-4281-eb60-08d59bf826f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

It is too expensive to pass u64 values via linked list, instead
allocate array for them by overall number of mac addresses from netdev.

This eventually removes multiple kmalloc() calls, aviod memory
fragmentation and allow to put single null check on kmalloc
return value in order to prevent a potential null pointer dereference.

Addresses-Coverity-ID: 1467429 ("Dereference null return value")
Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
Changes from v1 to v2:
 - C99 syntax: update xcast_addr_list struct field mc[0] -> mc[];
Changes from v2 to v3:
 - update commit description with 'Reported-by: Dan Carpenter';
 - update size calculations for mc list to offsetof() call
   instead of explicit arithmetic;
Changes from v3 to v4:
 - change loop control variable type from u8 to int, accordingly
   to mc_count size;
---
 drivers/net/ethernet/cavium/thunder/nic.h        |  7 +-----
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 28 +++++++++---------------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 5fc46c5..448d1fa 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -265,14 +265,9 @@ struct nicvf_drv_stats {
 
 struct cavium_ptp;
 
-struct xcast_addr {
-	struct list_head list;
-	u64              addr;
-};
-
 struct xcast_addr_list {
-	struct list_head list;
 	int              count;
+	u64              mc[];
 };
 
 struct nicvf_work {
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 1e9a31f..6bd5658 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
 						  work.work);
 	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
 	union nic_mbx mbx = {};
-	struct xcast_addr *xaddr, *next;
+	int idx = 0;
 
 	if (!vf_work)
 		return;
@@ -1956,16 +1956,10 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
 	/* check if we have any specific MACs to be added to PF DMAC filter */
 	if (vf_work->mc) {
 		/* now go through kernel list of MACs and add them one by one */
-		list_for_each_entry_safe(xaddr, next,
-					 &vf_work->mc->list, list) {
+		for (idx = 0; idx < vf_work->mc->count; idx++) {
 			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
-			mbx.xcast.data.mac = xaddr->addr;
+			mbx.xcast.data.mac = vf_work->mc->mc[idx];
 			nicvf_send_msg_to_pf(nic, &mbx);
-
-			/* after receiving ACK from PF release memory */
-			list_del(&xaddr->list);
-			kfree(xaddr);
-			vf_work->mc->count--;
 		}
 		kfree(vf_work->mc);
 	}
@@ -1996,17 +1990,15 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
 			mode |= BGX_XCAST_MCAST_FILTER;
 			/* here we need to copy mc addrs */
 			if (netdev_mc_count(netdev)) {
-				struct xcast_addr *xaddr;
-
-				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
-				INIT_LIST_HEAD(&mc_list->list);
+				mc_list = kmalloc(offsetof(typeof(*mc_list),
+							   mc[netdev_mc_count(netdev)]),
+						  GFP_ATOMIC);
+				if (unlikely(!mc_list))
+					return;
+				mc_list->count = 0;
 				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
-					xaddr = kmalloc(sizeof(*xaddr),
-							GFP_ATOMIC);
-					xaddr->addr =
+					mc_list->mc[mc_list->count] =
 						ether_addr_to_u64(ha->addr);
-					list_add_tail(&xaddr->list,
-						      &mc_list->list);
 					mc_list->count++;
 				}
 			}
-- 
1.8.3.1
