Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDFLOr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:14:47 -0400
Received: from mail-dm3nam03on0073.outbound.protection.outlook.com ([104.47.41.73]:14691
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751492AbeDFLOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:14:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, gustavo@embeddedor.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v2] net: thunderx: rework mac addresses list to u64 array
Date: Fri,  6 Apr 2018 04:14:25 -0700
Message-Id: <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR12CA0051.namprd12.prod.outlook.com
 (2603:10b6:3:103::13) To MWHPR07MB3007.namprd07.prod.outlook.com
 (2603:10b6:300:e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 142dba20-9080-415e-c157-08d59baf97fb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB3007;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3007;3:PvlzpwEred24np54GMBAJQiArgmY75BnbEvoEYI/dY+RGtOuBNNJ1FkM0hZ7LGwh88NdAhyc/aMU7nwZocPA5xCZlWtTAazZp8P+tZeojZwj4X1WbNPKyoDn0/gfGMFCp287m2ny/4S5yoGjSRq4Fy86ifHE+FLWGdTNpX7/3qWizLXTstaQCOC0m5NyZHQUJvRIRHWkM6fNWU5pQbScFyRg2qLFlp7c72+UDAXuTMyUU6gkXXfOOhbnkm8FN1hZ;25:DdMZWkX6iBc+NeqUQNGBuN4CIpS8OKCnDHALbY6P6MZHNc1s05ownRUx6M9+ZkuVK8jCPGQyeEKKfjHlhVIhRXGo/OoxI5kVckiFutal4ToTJPzIPaN0iFv2Y3myF8P9P4+JQer+Ovf4ca+qszxh+MrVEFppRShbg6QV0utoYMar26RTuByYhbXFI/mlvPtn+9QkmMppzJiHjh0HV5U2ONiQehF3L4dia3Zuv4nZGkHkIYMKBQXa8iFdBT79ykKiuFjCgg5zyxXXaTNB3tm31LHWNmqzUV0Ot74YKk1IOOCrnROHX4mX4rd3MrIkgCMAM/I73jqPtkSqf2bXCD43bQ==;31:kbGWKRXx8EXcAshTiH9Ng58MaMt9DCVy6UqItuJRakHHyaCUqvp5KbKfW3GX+PSJxAzc0o2yFyDxvmksH4CAjPFCg+Bh8/bPBtpA9/oghqTrOB36WLevYhXDvsQOR7kRV1HzwyGXndIcN2Udmk0oYrkEmbR41imqd1MUDWMVBao/BN/3r3tk8K9qwpZamUWN5IgmXjfxyNR68mQ/IXaC9c5ddlJFRSckiQYcwiuyl9g=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3007:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3007;20:/S0jB2m+WJ7OUEfyPci+AFogkjKf1MaG3zWcLFEoMbJ5AZDbGpt4h++HFVhKTTkJgtfGDuZs3CttVnBW5qDbjKAfbkHzzsrNYubXvHf6CoCeixJnv70raBBs7ax5E/fjo1QIg1uAXojD03dDYdAGZ8mETONfTB/HQWkenjrHp2X3nitAOJZ+48uMKWSeA5rlZOkLPt6QMIuOamFmi3W90aQLluZhHs/kcnzrQfVsMlvcJ9JCMuR1xMSEop2OP4XfPVYyZZoEBMmJq3qCETJZ8vxzF+Llls5OzoTASP4G74Hti4FLGW/o++DNei0PZP5vH7WrkHlV/OwLTWKv3Mk7B9DcWwX3uIEEpxMNTEGogb9N96ouemg3eY0Jk9f41MPNkb0IUlCwRztHtrqCRcm4/1D8/XRh/lesrsJvGsZEeSQaqHBE6ZJHeGGYxyaY7UCN9AjsqIrM4C/DVRfg4K/HtCKZZNdNp+7q/NvBawMzQK1hqINT7Mhmus+EkgWuDanxtjf7Q/j19s/bm6S2F6xjaOgq8Jb+lTDzJVh+2gdxowLm5m1q2TL8Dik/kpbNkJc56d3RsSVlaz1NzwcG7Gw709PFhy1kJMXCpgqvxyFu4Hc=;4:hP26PQtA/HN2tAZgOVddZjCnYLVViGL9S6uMrJ0rE1WCYbyGzbWJD24GrXGIw1uFfEMI64arbTObW9jqAQnYbvpv0FleF1iufWkUGiw9snOnPcpyvT6nIBLdZfonys2gSPVpG28hlaCWgMfoVbubucOW0P8Jl7X/9+GjVnX5gVXSyRtiT9JzWvynWnPkIxenEvjIKPYIDuEJjID2ONriAANxoy2AIf7DGWP31GM3JyP/dsTUbzyin+N/BjGJ3yxBh+4jQPFTIi0GiVki63kBAlpRKPPzo2G/I6P91P75iPk6J0cKRzV5UO+251ZNbCpn
X-Microsoft-Antispam-PRVS: <MWHPR07MB3007D59E83F20B31AAF99C428ABA0@MWHPR07MB3007.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR07MB3007;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3007;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(50226002)(386003)(42882007)(97736004)(7736002)(1076002)(107886003)(76176011)(25786009)(26005)(16526019)(72206003)(11346002)(486006)(36756003)(476003)(6486002)(6506007)(956004)(316002)(59450400001)(50466002)(16586007)(446003)(52116002)(51416003)(68736007)(81156014)(48376002)(2616005)(6512007)(5660300001)(8936002)(105586002)(106356001)(53936002)(478600001)(53416004)(81166006)(8676002)(305945005)(39060400002)(69596002)(4326008)(6666003)(47776003)(66066001)(6116002)(3846002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3007;H:localhost.localdomain.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3007;23:d0QmEKcRbaFqKFSKjbEHBaeiJIHSnbg0LVke3gUe5?=
 =?us-ascii?Q?TVZA9pQEiLmhJC69zJGm8q9/0g47O38MZrXHYEI2y6bVkJRCGJFrqqChWvwr?=
 =?us-ascii?Q?3bGyORhAqFn1UQKX/0xX4Ds7KiPLQ9MWqLX2PP/4A7SQbr3ndI6wfQ6vt4+j?=
 =?us-ascii?Q?Pi/l6ct7E4Smta/lvxkr6RGXnjMy3vhhgFJ5Xd3n7t56tYhL122LYUJ0O74P?=
 =?us-ascii?Q?Q3BUmaEA5j/rqswkGVxV/fUP3ccowYaO+Bo20KJgqEHSpu/FwB7imHF5d1cY?=
 =?us-ascii?Q?aN/NJ3UQesdhLVqKlz/Ev7+u1vwPPzC9vDYmQXWvsZeRD9cBZDEsuPi11Zay?=
 =?us-ascii?Q?us1f/egG3fckpJxFo7m9Q9iTFkkKrG2ShiMRxNKZLtsJdKs5mH4canXqUU2z?=
 =?us-ascii?Q?fBjCT/z9yhwr6mb+jQHjIlcSxm7UnTl45HrccNqu9axbnBf3Ijf1+J+4TsY0?=
 =?us-ascii?Q?Qzffy3gQkLo++cqCeeBR3MYff8pq9E+SvaaKGphu+RWMYExTSE2belxJ/leK?=
 =?us-ascii?Q?zwjtME4V7DqmZN2PbtjCYdM9CdCy0y5RE7rqigyHAxvnSwpfYqbG3QPMQ/lc?=
 =?us-ascii?Q?vSh1AlbCiH85kgDL4lMO8nC32KRaAWHhQ1EQd9LCE29H5XnqMftGb4KqECzY?=
 =?us-ascii?Q?uJkKLHo2vWpPpm6XkJtYuyX64taB2oLbo8BkwzxDt7MxNRIyqxtCaWLezvfm?=
 =?us-ascii?Q?33lJgRIOUwN21aQUHr/u3xDgenSqxco4IPehk0SpF7+w7frd1hFXtRVft5r5?=
 =?us-ascii?Q?+U45tILrGvrLXdtHgViyCEedn0UZ15HsbJmDZcMr8i+LJANWTARueB3WPBYG?=
 =?us-ascii?Q?VCHSTgLexMBBSQmxSjIdpiadniF+AMDYiI8g+6ndMwIvOPfKVlMxsAiCN4I2?=
 =?us-ascii?Q?GG8ZLuT/wJKUe5HBSTVlZHNmKdB6HnnYrp/RfurryvbsTkESZbRClXhzRCmQ?=
 =?us-ascii?Q?OEjBZ1Vi2d9tzHECZbcvC6Ej1Jlnnj4z9gCN9zNa0iEYsbRY+Xz84KZ7hZEK?=
 =?us-ascii?Q?D5sUh4vOwggKX7ZPajmsJPifT69MP8BNBaO82hizfcyPP0uk+GBaIBO950os?=
 =?us-ascii?Q?AL4RqQdo8BjqgxZeAeqiUDhooADfyZi9eKG8YFSCYEk/I3uEg7q5Rp6bnJ4S?=
 =?us-ascii?Q?BkgiN914ROOWZPFyCr06LReVAVGt3KT8ef7krSt6ngy5qob7ycIW4VXpPSeU?=
 =?us-ascii?Q?Ie31TgDJUukOS8ErDBT8D6sD2ff1Lek+bG8NgAGsiR+fGdDgOtCQLeGZi099?=
 =?us-ascii?Q?PjT++AhJ52629Nkrw18vk5pJSLDL8vlvutJsngeFl0qQWiCQDxiuoO0Ie39T?=
 =?us-ascii?Q?KKe+ogXLEoYZy+SjJluw+Y=3D?=
X-Microsoft-Antispam-Message-Info: tE/JbKevasr4xQzGQUO2abUDdsVlNG4TLN0WvOqrYngBljlZeUpoojPjjnY+YyrGphXA/BqSFFhatpFoVn+XWaavIueblhVSKDyQSogZ4yca9lT5smeTEeJ5SsuxtTsxyobQZNgr2OjEMj2b2iPCW23pekdHf97yqHJmxEUNCKLl6sbb+jwBH5ITh2NWPDub
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3007;6:j3WvHJY9EAZz5gvf2Khx46l1qLPIIGxFyoq9f4H2H/YABBnVI/rzAMwBLN3kXzAij+yOfk3TyMJCsOTf4kal6Xcu9r8qngVb7bOeeOJHAjkJ2bZhCVqbGm1lDeSuckTMfwEIfyW1Yb1j4pKj7aZBwbGHU9p+W8BpKK5WHvxVNKhHO39dwHogfx2ppozKGR76PScTjOE8oOFF+xebZgufUVX80t8O9JLVWZbeOcGsyDQVG3vYnOswLBa0zaypUPIOaGw9F5dIwBhd8C9lXtwUgV96ZUT8rRoZVHvPo8SUMSRsgJUWsg4G6c/t5mA1zUNl1NJDxEk7ujDrK/ui1x9x5TUpnBtusUGoOcX2qvEfTAJuH7FRdFWGZpBs/2wiRdyFF5WSQGskN23h1fzBQD2E6cXa7z9R8vdOODS9NZvdsOKcTr2ON00qJxyLpteVnSknXbBka/vLAqiJ5dhzD6doJA==;5:v8QegRIeivZ1Rni6lnJBBczOpCe6lNQmdytjcybqq/4v7QcOj+f5POIz9vc/YIqamqPQvHKUxiU1JD0q/IZnhg6SpVSKh+5MgcfHxTOkt+AEVxVSh8V3v7dfX2zIOgWAmlniBOi4K+w1nbJuomm0gzQVx7uC0qEtB5GFijOoUXY=;24:1i2l7orjid6k205SHrYOO9o/2IjKu45ulv/STkxA8EmeqLiZD/xYgPhtTYUjPHewfcchMDR/ZAfsTJaAG+MhTpWMhvtW9qNLGwNR1y2vwmk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3007;7:VnGJT2mtklkHM9dL+TjLdvFZEbrEUA/5vuqj7OCZhhN7M+QTnUuDlGXuzKcwpjJToHxrstv16dVFWbxCVTwpQxhfqRBjotOMhFyobAuchZFitv2vAmZj0BKffBp88/pqyxfonVJ7gEqGE3W6YMRntXd4Gl/hP511vQFnbrlimp6B6MYFQkZl1j5Y/mtecwDDdtH42AU/olQ9ODOaOMRWiCp5vqG/HguALnVAA1SEMlBJoOdcH2q49VMUrC7vYN0i
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 11:14:40.4233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 142dba20-9080-415e-c157-08d59baf97fb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3007
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
Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
Changes from v1 to v2:
 - C99 syntax: update xcast_addr_list struct field mc[0] -> mc[];

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
index 1e9a31fef729..a26d8bc92e01 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
 						  work.work);
 	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
 	union nic_mbx mbx = {};
-	struct xcast_addr *xaddr, *next;
+	u8 idx = 0;
 
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
+				mc_list = kmalloc(sizeof(*mc_list) +
+						  sizeof(u64) * netdev_mc_count(netdev),
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
