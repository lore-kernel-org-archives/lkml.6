Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756555AbeDFOFH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:05:07 -0400
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:33687
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754509AbeDFOFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:05:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v3] net: thunderx: rework mac addresses list to u64 array
Date: Fri,  6 Apr 2018 07:04:43 -0700
Message-Id: <20180406140443.15181-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: MWHPR2201CA0035.namprd22.prod.outlook.com
 (2603:10b6:301:28::48) To MWHPR07MB3005.namprd07.prod.outlook.com
 (2603:10b6:300:e0::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a82f908-7ae7-48c5-d10d-08d59bc7631b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB3005;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3005;3:+OSevCAPf1v5aBBfcnJCaUsc1IP+obVgx8nX7tPZIJjH9wJcSEvAlH7YbHquiJARP4JtRPuCJpH922OfbW5RhzcVi5WMcx7fn8PR0zFPe/Lrj1nnLs3oKF2r7zCdl1Exx6IDwva+YsGlWqQ02feL4JUzva0QpRaAoj7Ess9vvyvmhCZNTXomQsC6k5ZKwtyrd65dOGk0rjACXePcbkSewr9Zdwkqu2Eui8tLj1LhtUV9SK0qX6OODA1XIxkT/RNG;25:wBSMRW4HJCuFjDF8UgyhnkjBChrVihjn68IKHaz/eUvB4Q5UpZxE4pDVRr2OMhSKHzSZj+RgmV00TxBAh6GPIbHgc2q0HPMIsZv0c1e0s9Kyb5Ka8G3O5Xyet0ufFNeg4Q3pM5Es1QD/dhqfuNwJgwzmaQX0N8bKNr/0J/h/XYchgrjbLC8rQmxFuTlkB3SMswSKbNOZnf1qBT1TLPx8uh5k53J1FoSbEpBw+mDM3K/3L/h1N5ZPubrrnYM5577gpXVtBbDN7lbboypad6EPfvyHUBi35oQkTHdxO+/c8112p747keoEnxh8W7RGkXblVfURMpXxZ+XwGGE6S7hIrg==;31:icjH2a9UQnglKWBNiI+qBWE2+td9wqiGHUoMvEavBnbOTRpGNwR+S2mzY67oD9eic/x2wT5gNcSFW1d37eRsEGVFL0yQTCtkmHVXnOgNOpTkU4b1oTAghzS/tvNzrcldt/ZifG5aMdp3NlWlwUZCr7ISxsHNCfZHTThRkhKDZUxCrFAm7KJZobHvBZ1kIFqUgMkBbOqcjXM/lN9q/KGY5mO4D5/cOvrRmUR5C5jMYLE=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3005:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3005;20:f0+Rqw6RhoYAlBKtue9HyCn4OGGpgZEM8Y4Ip7nmASwrEChAhKJ5wVoroG5b0tjgRThagZapwYazlTK0OAnxaSzAmdwUUMPwl3kGLzO7QHLGp6IIjM7okDZJx32OrTsHPCBTlKJRb1yRLX/BN0w4L5DutUpcWBy+rCL3wxKM0+KwV0MvTGyDg6PwpplcLE1FhV05buESsN6bc42/vzzDf6AT04iSLZHmK6qPrAyEAjOIX5gJhx72aXxIcMGJtBHmfcdfZuct+EvcXrVTIFuUoSGEECV/YR3jtGtYi3Jq6K09qQpQjr3QFbIcP2xJO8JGiWV4fqdVdrBHXPsOFyk5iQyeSdx2TXz0XTcAt1NUQuOC7FQ2yzbf6c1kT/DwqJH9Up7oViD6+rgMXYIp0jftYbDuq3X0S1f+p8I3t870AjO7G93dfzmXsc5acmkun9DymabvSLFUDrgrBS58AfV/nO3H6Hz/14JeB8rNBbW0cFcpPQk20ElmPkWjAxjaE0dusk3MK41NJvQJpXbCpmMJGI7SEbD3YEBl5Mx7EfaScczi0CB8iJyk3SqspiWKbeH+eo9hV0QELbw/h4xO/LSaiIj6t9usm5xMMbIh75qk410=
X-Microsoft-Antispam-PRVS: <MWHPR07MB3005A8A8BF90FB06848752B78ABA0@MWHPR07MB3005.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR07MB3005;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3005;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3005;4:S0hzEmSK8Z5494NmHhnl4A2bMOgvox/4C8tssECrl7cBj4GpdIRjutFfidGtKzHbtYBvwIJJf1/uyhUXSL9QI6BeuO9Nfj/VA4LlNUfu2HXMNcJbTsR6SySMOiQAkD7FG5IApDjQDz/jaAYIIxWnYpux2GKC5jjV87+10g3O1JtIBv0CoSJ9+hKW0xKJ0PkNo5sVzCwUpVSry2muaBPP793LsbFYg25k1N6wa6G54mkaBco6qcU7zHzbY4PShI94lboXF42AyBgQXHYeT0ejFPVr8KlaedvEkZ/l7LMR67cdNyCt7YGt/1zn/9lRVrBZgDih/jYjdZjnbSmqdSzgyJTC5WFNV1hKD8Qshk+ls7U=
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(39380400002)(39860400002)(346002)(396003)(199004)(189003)(53416004)(47776003)(5660300001)(66066001)(97736004)(305945005)(7736002)(105586002)(48376002)(476003)(50466002)(2906002)(106356001)(69596002)(2616005)(3846002)(11346002)(446003)(1076002)(72206003)(51416003)(4326008)(956004)(6116002)(6512007)(52116002)(42882007)(6486002)(50226002)(6666003)(25786009)(486006)(26005)(59450400001)(478600001)(76176011)(316002)(16586007)(81166006)(81156014)(8936002)(107886003)(8676002)(39060400002)(16526019)(6506007)(53936002)(386003)(36756003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3005;H:localhost.localdomain.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3005;23:IYdoEngAgjBhyBCj87ZkfspiRHmO4VzbHUOoLP34g?=
 =?us-ascii?Q?MnaMCjhwRwxISEisJpyT0RnkkvAD6vFSRkTR3M63quISoFuRWCNRh0dCoiVZ?=
 =?us-ascii?Q?SgkQxUaprRmvPfWGbdjc/wT4v9XVrahpKS/q0O2AyrLYCjHZtzn4lfhz5Q8J?=
 =?us-ascii?Q?d61uQY3RWEZgx+kgUk+TdZmiXbbuKnpSrgB8WSB5N4p0fySgakX4wo2uzMvy?=
 =?us-ascii?Q?tB/bjeYFsnhuJoihhHLfWvjpctvXMzED7FRNi6RpUxeZ7Hm/ikHuI3Og9WaZ?=
 =?us-ascii?Q?5H82ruB5jk6B4qC6s6s8CWmdG6cqbpkJ1kyKrIncvp1y2+aWBFDQpR1OiCkC?=
 =?us-ascii?Q?GeafFGhMw8thO5drGqqCV9EguFl8ENcIx+ZcaF7SC7HpLuxhYIR7m1iyG2kX?=
 =?us-ascii?Q?wGC3yQiC9eE5N1daNZfOaW9VtmZEu0mhK6fV0M+EXgTSuDWty8H+qwBTLQ3V?=
 =?us-ascii?Q?7WzxwoG2v5mafUEiX4Vukf6cM4gynXm24xi5YInlKmOZxDGuTQH85kgggdGO?=
 =?us-ascii?Q?uDBqjymHlgZbWmdvaA08yK9qsstugWy18MqU93i5tfOOCrLMafC1c5p83Qft?=
 =?us-ascii?Q?3CUnEXEChoKw6im/Goma5E9YtbMdNKfDvDADfPb3IpPdksnEHgGtxrQyDoIK?=
 =?us-ascii?Q?ca0l9ZdPY7NG1EMD5Er1tTO0RK2YMzDgYYpF6HNtJ8RaW6KXV8hgpV12wvWB?=
 =?us-ascii?Q?fET3lLeMyo6taJrxcu9t3HeM1HEB5ycFOuDNZkhUI8ninVYCBB9HTsAGNxqe?=
 =?us-ascii?Q?lqWKObQZp2Ri7VuUqfK45aMBxQq1DIc0sLHH7AVQRPVcEBZQPopxtutT9wX6?=
 =?us-ascii?Q?EeZwVI9n59oer1gMKoZrVP5upO8SoLXJlJmLPrnKgBq1KncdkyOVUB5BQVkq?=
 =?us-ascii?Q?AwdhpABDpHcG4w40TDyVJGmuG9wvefSf6Dg2QtG2Q+Lf5Gx2Z/jAsyDgEg/6?=
 =?us-ascii?Q?yq+tZblz8aRQv3laageUqc1Zl8XrAQRqEcBIHq54l0KXo3refLH8CKfYW0Ps?=
 =?us-ascii?Q?/5GCXRu88IrtLKvg6t3GcZPxAN9Dt1+wRQBLXqNMxfXRW3q8RYaUos4MoAUH?=
 =?us-ascii?Q?EqEEu30nK3C7XXp4pRs4LRrQrLWCgZmmdz4B0+BDM7Q3g7XlsrE6bYnyEgPZ?=
 =?us-ascii?Q?tp1akqZn+jEk54+jPXhAr+QUD0nLgZAmIn4A9SekRBoWLvmQKoNd5cor6KNn?=
 =?us-ascii?Q?RQ1Qt2CB0SvQe16nV8MzFnsFMu29YpO/sKAx5aIZjfsVKZnv62fimLHVbkRJ?=
 =?us-ascii?Q?THWT2Tz0lNADORQY5HK0mydh+WDbG0/lNTliwfRAbilPbgjnOu4RTzeGcI+y?=
 =?us-ascii?Q?uspZ8Vvy7ZczYZwVV+L1/8=3D?=
X-Microsoft-Antispam-Message-Info: LXz5Wujdd4byjGqPWb2bAqCBc9YGyngET9X3dIvIEKUkgEvQmo3AJCzJ7XGGmH48KDbgQZjkkYX2ULXKODV2988WgcCZHuWGAJil+OS8j6Cx39htHokh84sUHh9DB3oCSAatFTnWweOhBi+A9aTY2hx+fUzUWIY2Sq7IClp8D1e3xyhYaVQIp9xDRBYNIPhV
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3005;6:l8Pk2ltzXgKayYCYQMbcnavb0fV/9nFIynE0dJr44Q62N89FqlN9imJ41I3CnVwuMZ8Y07XQ0H+j2CbNT8C0Wyxzd6tdli/dyK2Dkq48Hp8+2wN8dAo03/DBwz3cNnfY2+eFSR2oRa9H86kOmWMWUXsEd0ip2XylLvMmLZWfvcwf00jHKl8tp/kUBTRVIJsBOoSn4T+sU+7o6EZ++LelbAj1OLCHprFzUd1iUROmUnvdyT5vmNVPEmU36v+fMYIn8ulJG96N2zr4LxDOze5eythpunipnSrqSEaHsOmg2DeIfx2ZgSo0pGkVMBkXREO1HD+m9XlOGdzskyAxHp9X9aHNGY3hpNkwCDWZu4D+mlFqa9Rc+7G7KX0dFv1mjCGjiZZDHmbNbHb63XKEw7Mhr41wIYWVRYtBZRKW0P4eGUbgErdJ7qz6/LQKCM1l3u9m2/mWX0Mj/7FNzQln8dFAKA==;5:8socvUTvkIYXY1jeyqQS3FyOJDAAgkOnbQDktBF0SURLrCKG5m5MtdZ/gDS9ioc6iz9FQdXKFQ8FQ1MGNNZALL/gZ4PL8qLNGAJJD9gCRP5p0J5XcTSGFjPpq9YlzbT8helNCrR4kqd+53jo4ju8jTnCjqELkg9hl70v5tOyugE=;24:yiOwJ5RV3VyMjeviZhjIzFns/G84aCpgbmMaERWJ1vVCxEqHgCT0mBAqCYKMgW3SR0pzp6QbaH03xFcO/Kcx1yiwsbqe0xUM4D+9pYZrjMg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3005;7:WJ3/JNpn+gDN+KYyPHc2DnIK4B1ElQzuLJ5anZV+RJJ+qNp4xewB4oPKPTM/7KsTbNRDneUz1V7pOYzEVri0UXhip+0FDebBDTiKUoEuyTnfo8g2EgtqzDJPyDOj+Z8Ezz/grRGekkZNYjfBU8S4en+uu1TTSas83I7hdak37Fvp6uT0DZnOkgQfAm2wBHpnIOcBCbSQ6GIA9chdAuc2iALJwitHpsyL7AfYK1PiFPy/EmeHtOxd8RxR5mHQ/cxm
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 14:05:00.3701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a82f908-7ae7-48c5-d10d-08d59bc7631b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3005
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
index 1e9a31fef729..7d9e58533a83 100644
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
