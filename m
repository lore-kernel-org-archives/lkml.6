Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeDINZG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:25:06 -0400
Received: from mail-cys01nam02on0082.outbound.protection.outlook.com ([104.47.37.82]:7276
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751367AbeDINZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:25:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, robin.murphy@arm.com, hch@infradead.org,
        gustavo@embeddedor.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v5] net: thunderx: rework mac addresses list to u64 array
Date: Mon,  9 Apr 2018 06:24:48 -0700
Message-Id: <20180409132448.22278-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CY4PR19CA0031.namprd19.prod.outlook.com
 (2603:10b6:903:103::17) To BN6PR07MB2996.namprd07.prod.outlook.com
 (2603:10b6:404:a7::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1385f4cd-a3a5-46f6-193a-08d59e1d4ca7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2996;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2996;3:YYP1BLRd18cO9MlzB1XRXKiSStrN7rQMY8X5NWy00ifgQvFzIzp++ZQsNPVYQQuwuaIXd3xuKjRa+rFhL+iXBQHJ707CxO3iobUkDQMiwBhAhJelLf+q8OwoUDr7bU1ijjCGT+kD8fXE74K68/jCKkdQUTU2SWMaAD4j4pB5XgY59fnvRHn+7NgkOlBT/JGBnsoaMWZILVMb+1rJ18OXyE8sdEcbbzGuH3sir6+lt7N+VyIF6/i1PQ+N6C0WwyxG;25:odUVjCu2krAahfjlflP/iyKI3q6BVxbip2a209h1UDXiGX/Fi7xbXbq8akR/IctQCw2SXJKjTBJa9IFadvNuselyNsveo4cbDn7ssip5Vk63Kw+2CttRXYMQBdJwRvh6UB1K6dAvw+zhIoVRaAtMn3glzl8yuOAlLm4S3v9/kvWsF7zPZI+pGUJiKtpfK5Bh75S4XeGmbQRIJrI+S+2HIBL4+7OfWc6I2QAtUDDWRXpoVP3GSTgnga8ArC0Ch6MttUUFp6icoVSPgBo8UALX6u+WcWwJ0/YKS6p45k3yAO+hbzX+v4gEaBl8jc6Qy06ZBSLtp/SUOnL63E+KtoivUA==;31:yjhifPSK8w5LtCygPjEY68Rza3/rMJnsLvA5aZ/Y2D6hXmgwjwsVfmjWOJMwFSyR+dRtKF5luW2GFXLg6RjTGFuz9pw6KfANyhaNrbacwzuqSAMh3fQfdE6zoHojj+NF5iNXv2+SC957XjJnGu5X6pNmuF8lp4RWQjLsVm7dTZyf/feNKxnIiAMR9XXd3ar+xwySGI32SqbB6eH5Z06zb7yK3cpkZpi3xN4TpnNU/Y4=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2996:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2996;20:OYCa0kYFg1cPWdy03ltu0OtjevZVf+lG4bAFEr1Ysc/gEIxVeKTIj5X21e3+ULZHogSg9BYnoreGWn2eKJsJrA/zE/KSYmzOx27ZI5PxQKMdSv9mErb8bj2fLXlmIDInJgpdkTalWLy/4cz56VkfZ0JfdCsgvPmX7nnCmxvE35dnAt3wCs6kFBqjABcln39ZGeU34fkqBmYoi/PNIrbtP50flTO8KwxxeXU5IW2y0lZTsPuMQyYpnlXtJiNJVXzlv1hR3FXaUU2fM5F4yDLEtyQh6SeTVIE0vIz+YXmUaPKI4CkOSY1Pl/lfIhrNw9PESBKstZz4cgF/PzP8oyRE+8Te/bzhlqAb/kzqa6OcpxExjot3GiqRMmC4bwlO/zQBuW+SVT8FWCMCjD07MHiDuf6AQhEp8H3+T2MOXxZTUqNru5Bgvbt9hTLi1fGPFQphnOrfE/IORKJUvEiQpxG+9FjAO0pc2b1lSFVzQ8C3WOz7lpL6JTiX/G0iJMvn5jpd5WjBaPQEh6cnL4+dulyMQq7Ia1DrV/qRvnCcp6iZo9fU4yD7F08zBKqSAlLnTU5mWFKPUYGjdk+eHA6xFjzm93b7cJ1Ts+2U/wCLp97ocs4=
X-Microsoft-Antispam-PRVS: <BN6PR07MB2996B82B106278BF9C11CD698ABF0@BN6PR07MB2996.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR07MB2996;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2996;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2996;4:KKD+LcB8XLN65/lQm1QRr+DGBf4C7sz6S9qKM1t58emMh5GlwU426bOBivCpx2CVBCyzOYsHDh+4zywAPqSuhqF2Ax7IT4IZDOTBr0Gjx41e0ZTOVSTuQyKN9frdnJ0a5gctye6dpNEyEgm89DkMUIniu7WcIwVPEkdCC+Er7hM4l3RFoNuzFVHIK+mAlgMXGFbxUMaYJP1EEQz5ZnIuIoPnmEDyRDMs7MzOrJREL07aTpOm8aq7JD3+vT0SMDKGpLm87i55YkdSD0vgs1kl82x0MSXzZlA0Mb3topd7BApzWd+8c4RI14tx7fdqCJQUFdGZ7NPqIJa8pg969SHQKYSmw5L3gJkxc9XhIbWzkYI=
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(396003)(39380400002)(346002)(376002)(39850400004)(189003)(199004)(52116002)(97736004)(16586007)(6116002)(3846002)(39060400002)(81166006)(8936002)(25786009)(50226002)(76176011)(81156014)(4326008)(8676002)(6512007)(53416004)(51416003)(47776003)(6666003)(105586002)(66066001)(6486002)(26005)(107886003)(1076002)(53936002)(316002)(42882007)(36756003)(16526019)(68736007)(478600001)(476003)(386003)(6506007)(59450400001)(5660300001)(69596002)(956004)(2616005)(446003)(72206003)(11346002)(50466002)(7736002)(48376002)(486006)(2906002)(7416002)(106356001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2996;H:localhost.localdomain.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2996;23:iPE+ucAC/9byclglJUIAJwTOZl3vBpDpdgtt1ykW6?=
 =?us-ascii?Q?kROHJ0GUj1grj9jn69p7HMQtCXrIBIUzKPPfFtNAmKdmuM6R3vutSYDogQV5?=
 =?us-ascii?Q?QfPvxh9fdcyE2eXk+eEt9IO447hm4QZMFTjJlI43On66KMfkrcdaXSYumqNr?=
 =?us-ascii?Q?6ryCyl6K14RAv8NuCahy+eXC8RvWeOT3p5AnDyTgdXgxeNYDcgm2yThRAQFu?=
 =?us-ascii?Q?Msw1YPqqetGBxebsGKJLbAn6RYufkxBrBQbaV80wGbPAFJw2yCmlc5Xojh2u?=
 =?us-ascii?Q?36IIhK+1IjWk5/nxzICO7SKW9gVLlkM0dMb+yHFYwTWdqBTBq9cyZXeCXwOY?=
 =?us-ascii?Q?QCwCIKS40Q4AIaIy3UVi1sH9hfi9bJe+GPpV32Kl2L7bg3HhhB10Gy5+1Oq0?=
 =?us-ascii?Q?qsvgt9GTH8E3eLfq/ZabKurNghoBt4P3LKtFo/prmTclC6NoLRAXoA0Sr3Fc?=
 =?us-ascii?Q?C72VweJXv9TejQTwIB6bZ7yefyHxDN5rsWwHUcaMU5vEb40WMs7OBTIHUkJx?=
 =?us-ascii?Q?jH76S//W3n82VsY7tfWyO/pAbTevuaR0r4xPMVZclRWqhd+dEiIzaUZOgR6T?=
 =?us-ascii?Q?+Q4OOWXSsD3brRP8kZDufOlTy7fGAXeHZgYaBNPK5TXfIZ36m1N6NoaYrrvh?=
 =?us-ascii?Q?a01fuHCXuV+DiLdHqXu95gaXvAxq5Mtq6bc8npch0qBNVhI6AMhwm/fepiBX?=
 =?us-ascii?Q?moAtC1a+5vlqK6ccq44HZ5IgQqBZREDxeGkcqKVdkQmXJ4L0XYelJeiMEEtu?=
 =?us-ascii?Q?lNhmBQD2/+/l86UEaRyybH5skaa2/gIsE3X7gGBlq/Ohz3P3SyEwFQJmJVN2?=
 =?us-ascii?Q?WfH/HhzkasIccPVGnAUlvNeHebrYQl3hacV1/M6T36ed/Qnm0IYGs4bBwqE7?=
 =?us-ascii?Q?moQriDHQjDv+XjF+auWZ+YD6PGNwQ5egiV11gWj01wM+mvy75PyOG6uXyMrb?=
 =?us-ascii?Q?eNm3T4zAuf4wCtIKZO+g0XY32YxvBfxB9dSbaeyoLoLrVvqBRl8q2XH+FJA8?=
 =?us-ascii?Q?ZolaAyMs/j5Dzjd+D5vcXLVWlCYjyzsFibwsALwgY5B3V24oojpiYjE7hZ+v?=
 =?us-ascii?Q?sw7gWg4c6UKOSvnR14h6+nLBhhS+6ABt1Rs/Jj9QA/EewrFHXk1wDsXxF5dR?=
 =?us-ascii?Q?kBc4WbcRFGgyUI/MoTG+zXfH/wAYdIi2lhC5AjBf4vRRnsqEtBeal7/sLcWY?=
 =?us-ascii?Q?9Bp0vLuJgVxRN+6F50RC+TN2tS/qTi1tJ30umh85FNxrawGzrWmkmCo3J62n?=
 =?us-ascii?Q?hEVABEKQbqKQOpQwKxVK1ILmzdDJ0EwyBLJ6koVkBsFaj+ECMAXwRBfsKAH6?=
 =?us-ascii?Q?NoiussdbvlAEvoKIW88kaFC9tVIND4frF9WzDjrNGxE?=
X-Microsoft-Antispam-Message-Info: cF166jloJsniHNmZtCY70zaSFFmUnBfdBXd1PtRg8+XFEeUgFDCwWFobzyjDzQUoScxclYySn+6/aiZ7FeUOlvNPZ+vdeQKdclCfuBPHKOmzhyWHWmWDef/cpmBuI8JMnrlvahvJq5KLNlFwQR0qsQFHHMktUD4Q3hF8P9w2b32m0Y9PLeSIs1Ug1rqzzxa6
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2996;6:TtW9LLFzTWcyKhVQCx1kWkBt3A5fmonlHn6EpoqZOV+6NUiNXM+w/9c2R2TRdMVtw4aq8xw/WrefGwwCtTmHD1p3wSLl2lz8b721cr+qOR+MhYwLMrNpWuBx2jEZDQdutjFCV53ueER34kwggaLzigcT4eW/sCsuX8gtzJnozJ0LhqBF6mI4vSf65AGtFl6U4ZRVaF8ONNjkhwpIqu6tQ0nVqpnp8VlpcqPL6uic0JVJQE3bWovcInbkPTJeFHr9BcekZVY5PzMp1q10a4K+VKK7vT7LY1nnWG1c3owmhpEOhQPDcyT3+yuB7NKA4mpM3PQ85m+Ndfvgjy44pX/RVtVfW627mDNCvXEw9eCJQ84xiijEffsU82gaPbtk386M2F1lxeookIzmsqMchAqBjChfPmhhINyTyk6n78luBazC03lzv2Jnk4dt3m6EuncKM1z0cp0fWgMBbCQBTw2KQw==;5:UNnPAdqYectu1JO50EofFOPnoZLV6J+eViepVSnmBiQuKygWpl7l64T6rFpYIVhMHHKeHnqgxAIykBUQ3gOdXLQbWga9O1lzF225M4tRYAbAd2HhHVR3vIPmVKMdqGKM8xMmV499b6n2cL13bODkxUA/2fsNQ4zOoCUHfDo/TA8=;24:WFGQrxTqxNuu5iAu5iO7A7oPsQ9h6TZ8aWiNZ26KJ7/CUGrnMSBwjn4zudzi4rgDH68UupRBtp7LR89cecRorChaAlI3DoN31vSoyStr3KI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2996;7:24o/LCZnnJ6AgKyxDxmTqyuFWbH8Ofewt2ey9if4JtMFPyUxo/H1sCYuOEtr8IYzs2QOH417qFhiru66wpoRYokV7nZEgBcqYwADOyEOig3g0On2kV/ytdN7IT0TdkEF9JY/zorDCoDNd5Z51nEhmkvZMLqUo/+bAQ5EdXdVWQ8g31pw4XcyySXe3zIOab/NOYeebrPY2f/30xnixIv4hFUq4RpmMW8E/81ghwZ4bv4kxdQT5Rcy+VsbcuQNJfZ/
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 13:25:00.8802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1385f4cd-a3a5-46f6-193a-08d59e1d4ca7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2996
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
Changes from v4 to v5:
 - remove explicit initialization of 'idx' variable as per review comment;
---
 drivers/net/ethernet/cavium/thunder/nic.h        |  7 +-----
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 28 +++++++++---------------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 5fc46c5a4f36..448d1fafc827 100644
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
index 1e9a31fef729..707db3304396 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
 						  work.work);
 	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
 	union nic_mbx mbx = {};
-	struct xcast_addr *xaddr, *next;
+	int idx;
 
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
2.14.3
