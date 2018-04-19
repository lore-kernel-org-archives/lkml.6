Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeDSRNX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:13:23 -0400
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:4800
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753041AbeDSRNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:13:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com;
From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To: joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Cc: tomasz.nowicki@cavium.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: [PATCH] iommu/iova: Update cached node pointer when current node fails to get any free IOVA
Date: Thu, 19 Apr 2018 22:42:34 +0530
Message-Id: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: MWHPR22CA0046.namprd22.prod.outlook.com
 (2603:10b6:300:69::32) To CO2PR0701MB744.namprd07.prod.outlook.com
 (2a01:111:e400:142f::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB744;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;3:eTQjkcljkiPt4A37OBLJZhCEPLEWZgqI0TDCsUnD52mPc5Tx3IHkVlBsAJCJzzOtiOrIQbVgRZgJTSr8jzZ+aRtZlzXWA8htxddEvV2ggd842zPK/nLK98rFdSH0aJv71wr84v6bqk67XgslieWFKLHy/buBsl/4wFCA96NehIHubx85XSNpyGdfhEzoo8R55zS5nqShiUzpKP+sSHCtxvTf+yKYk+uMJf98299uShq9ncAo9iwiywnEbpWlcRZo;25:BqaZk3Qp3ur/GrSRkAA6TkXvtGn+XWJFpay+or/RwySGWFHpXjWtXI1zOIhCaBNuCSP8nQS0wsfVge12lXz7nTa7yz9bi6LWBVyG+2Vn/CsGz0qmF6P38K3pEqvW6epIyIi1WUhGQx67Nka7ADqc5IGFIArJeU+DH/hfFLrGpL1XnZKGO5DlPUBbwo/RQqfiiBZ/MHNJj3HdL7GteM/U2hZNs4jHylyO0HUnoN981EDhHEXyL3j/HO/PhwgvuQ9R5oRUi4uAXzR1gpWHChMQgJuXTgtYklA5NQkrFwHrKQ7tvOwLKXp6FtEqEo6PJkHkre4aOVmMhDxY5kHEz0AUpg==;31:bFaoO9i7aNVApJB8NR2Xp1gtQS5is9G3OYtpsbkHSoNpgdnODVux/FIt2ZqvpFAeJGWXi93vNz1EDEAhe/kozk2EEb53WIJ2Ao48UhjqbU9ZeFnpkHz7OpFCJC53gykJMyUe+AffZZm3ORRR+v4Km/kjqMA36spdZtE1071e+8D7wv3eSyMWDGZ4EqYZEGb+QYr2PFAkKvEvchrmwNrxxLlVqnDCXcDDCXWxL8qVnB0=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB744:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;20:17tBkHgZ4q4aQkwc8yZQsxFjo4oFyLOW5EcZo2pGnkZkdvbxYV2kS72Pv1YbSZkL276glcAaMRgM9TbBRgbrkxE8dP1oCMU3HIdLDRHCsyBnt4OGzlfctiJDxsijw1eHRgdgvxYtaps47fNMeYF2QpzceyzepCKAb4GHsxfJjdHM4+h/bhkjDNnV7c59T08dklBjWu6HXWXByAyHrKhluTso1it++idn5ZN5cPKaXRIpwSBCI5r1sly3/FjfHV3IWCptGieCLFljhBubjZPVwfaC1ZV5k/7Jy7V2af+SvZDSoqPlcaQv1MCI+LkxjbmKkqd8drQKgYUcQRYzHHlTLeotmu7U3lvc7n8ZXVZYuhRtlD44dG2Ty+oBEQM3wK69MLRpgfcLXWV6bYnHP/S8UR+lbw80m7ZQgdPNLppz5XyyfLI2jb7qomiId7gQvXj6rztcpbfm5gK0dXt9SksFa+o++2NfWi8Qu06UEsWYclMDztgmmdg4LBea/ErRG4hB;4:iKfUdBnJ2rDqk4tEzUR6dCuyVT0QTLIZZnmmWnF6kPU7Tk6ZIq7oQkmZFWmfJ5aGWn59zSQ24ydZ4Va4ES1wUw+4Dw91i7GSDkYagxYd8DLu/4D1JqlTGmKeSYA6aABSXB5vtOh7szR0KrfjXGYVD54vOCEsbWhi6W9LId11qkuLbvy/tdVm2XC1PgmBieEQI5TcKo8EN32hLyBtlFypSEFQ3JetIX9OhXi1w8vMR1Ax8qNR3r41DSXgLVezRgw9gFQQV0AExZb2/TjQrTtC/g==
X-Microsoft-Antispam-PRVS: <CO2PR0701MB7444F88FA64D2D6E53BB90883B50@CO2PR0701MB744.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231232)(944501383)(52105095)(10201501046)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CO2PR0701MB744;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB744;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39380400002)(39860400002)(366004)(86362001)(44832011)(39060400002)(476003)(1857600001)(186003)(16526019)(6116002)(3846002)(15650500001)(36756003)(1076002)(53936002)(2906002)(2616005)(956004)(16586007)(6666003)(316002)(51416003)(6512007)(7696005)(52116002)(6506007)(386003)(50466002)(59450400001)(48376002)(25786009)(478600001)(72206003)(6486002)(5660300001)(26005)(4326008)(305945005)(5009440100003)(47776003)(8936002)(50226002)(81166006)(8676002)(66066001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB744;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB744;23:b0FoGV9Z1mxys2xP0wWNTAMrAvV6KUSHiOXkb2il?=
 =?us-ascii?Q?30y9sS+Sy/0GPOYo28BKvA0Zn7ST0qEqe+qWFFuhMEWJXdZivqlKMd88Tej3?=
 =?us-ascii?Q?QIaw5NJvqbbFiSfFpk2/Br6vUSCodRj2XBczttna7jnuu+BaaDQVB/SQ9aEX?=
 =?us-ascii?Q?aJwkKq2J6rqnXFew0j3imF9ya6LYVAIj7+8/zr55BwZO7JPB/o5qNJnzHr79?=
 =?us-ascii?Q?7Zpi1w4EZDkLYuZfzyEhNahKtdv+28r2xS+QjrvBbLkbwGbtVwdvUYcdgxnV?=
 =?us-ascii?Q?mOjnYiN2cbQj0uL7i7WaX6HAq9RxdsgfI4IvNbC2AxWBpBsBy3luw3ExRFL5?=
 =?us-ascii?Q?U0SnKFBtzuVUThhBcYKI4q+DLM3htiLz7a7kIlP9VSGjixRCeaF4OE0lBt2z?=
 =?us-ascii?Q?KUDcMkUHd81sRNLgYWeRQPUuExlJLaMe/jMyik69US33T7sMyDbehliQZMDK?=
 =?us-ascii?Q?utGVAUsrz2PJoifdqd+9BIXT53VOoWqyPShIhADrthwxWCVC9ybERjKJ6q6z?=
 =?us-ascii?Q?emPZZwzer3wqUPX1pe4fg6xSzP//x4ZXrhAyflOnXdM6tSufqvViS5H6GVQE?=
 =?us-ascii?Q?YzdrUd4L9Hknwz5cgvFBGV5UPLnMz08ddacVI3GHCdT4fhDLEAsOPktblj06?=
 =?us-ascii?Q?96SGLOUGwXzpMfyQFZSXtSuVn+bH85TMtnaj5CVpN0xK76+2qboTHJQiQ0ev?=
 =?us-ascii?Q?TeQTxBCxNuMlm6LR/MrLob6WPjm0jtAaJx+Y8u0KPZv4o85uZcBs2i/yXajl?=
 =?us-ascii?Q?p8j4OYVmAi32r+eg423JLF8OsOwEB8+CLowfLHxz1aLyFIIyy2v/E592qAj+?=
 =?us-ascii?Q?+zdfjAtDnhxTQ33rm2Lvs/yQXAZmvO4ZZt2PCIhbZAJ//9I9Vz6jnMmFujiw?=
 =?us-ascii?Q?MVJMoTKZXILDQSbkz/e8TZN7rssto7yd+I07nE6YFETDwHt25pTGSrlcE880?=
 =?us-ascii?Q?Bhz8Oz3wNAbsG1/tAC0eEDYhx225qLGKsihs81GDHEAUwnS+Do9leBTr7AzU?=
 =?us-ascii?Q?XdBpC9sATphiOT4E51CsGX9FniA5UJ3yZnakidQwk8WDAWGz88EiZ4YgcMsI?=
 =?us-ascii?Q?EVJlXonBVUW9u2lpCB1rJW36z9+RyOK2Swqeh/EQ0ihZ7bEwK8MYUaWuGDdx?=
 =?us-ascii?Q?5KFWhauU5NRt7t/Y/PNwh9bLnS19U97Cy+scBs43c+PX6W4iwf9NeQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: XAqXDoDM1aLsP8vKVTaLlHFCHxjtEN6KlNtRFd1PRKSbnEMYWabdsP1BV/KcUKi07IyHYi/dqg9RbKH9M0JfdLK/zPDkUuGGUHSkI1qCqOX6xFmgmAby96onVWqcSI4hkJ/mAemTCHFD4cuE9k+/OmS6L4oK0xhexRE1u++9JU4yix0QVIov1vXw4BOZcpJc
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;6:ApYAPENgapEDwi7RlhtnVGlfGqXL5niGlw7J6LrRm0gm2yEeFtqV9WAMtsZz81NtuF4hntu0vDJkAPjlIi9IULNc8+0F5RYogI4NEAIR39H7/Hy/VS0DuXplKOkNEvB/oYTz+zlGF+ASTQ3ztUSz04sRXN09Wjaq59y+XUxij1Insb+Gw82or7SeK014XGI8YbJAL724C/nAwMnwvjXwqI/I1GnsjWooCm2Z7pZKr+06HbaVnUQDSf3qxzd6pXOjY7GsCj03oYgMm8itPRKSZkpSAYBc4eCDxHhWjvvMBFMxxUfiskOrjDFJU4K54QcsMKdMzGMzrAgxI2P5uhAdJ78YIIR14lnymPE2lf8S7RGecA4U7FNGNCGp7yEiNfelztDFQyCRHZ/pZhwQV1Phbn44UwtUQ34izpyoUgz1mIvNcNw/B7xRSXROtVjq2AJz99T+Q5AthP4TgrBgzKLOTw==;5:lXoqgKmPiIbcIjyJ7ovvZlQIqX0J+MaIk7VEhtiXW5CcwtL4r64u7tAThiaKyKfKcj3ka6maY+H+jIMFGsN+DFhYNvBN/GDhktkC9iBN0otfUbIZBWCcaS+3WooM50v/QnPnL3sbfwAFBu5ESLuNp+fm2F4Yef6I27sMLztHpRM=;24:hX5pnHCtS4c/SrDUPWmW9rq7KkNl1JRDM1XeMj2G4g4gmo05MEML/MeTMzJgb/FHqojRDmtvUjQ32T+9HeLyWJkk4I2uf933cT7Asq1l/D8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;7:lFEVRP/KPMGHNRIKoeRmr0xBCQxPNY9jG1DFQ19rjLWGd2+qy0l/z5kzmdzal2Uj4Y5Is0vm6G3wHox+MaluPU0uJckB0PyXnpYsFUoXQcFkmTkDmupnHEbqQy3xw6FgFe8atzc7dMjLe0vLKK9iDhYIZAGiHz2osLD7MH3uKfKPEamUtn4wWSxbpd13BUZ1zv2eW1UOrH7gbD+HGhlTgJZeahpbFdX061U0zvPrWQ8yHlbiqNKkN3jhtQR5tXmt
X-MS-Office365-Filtering-Correlation-Id: 8682b398-62d9-42b4-02e0-08d5a618d7c6
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 17:13:14.6203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8682b398-62d9-42b4-02e0-08d5a618d7c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB744
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The performance drop is observed with long hours iperf testing using 40G
cards. This is mainly due to long iterations in finding the free iova
range in 32bit address space.

In current implementation for 64bit PCI devices, there is always first
attempt to allocate iova from 32bit(SAC preferred over DAC) address
range. Once we run out 32bit range, there is allocation from higher range,
however due to cached32_node optimization it does not suppose to be
painful. cached32_node always points to recently allocated 32-bit node.
When address range is full, it will be pointing to last allocated node
(leaf node), so walking rbtree to find the available range is not
expensive affair. However this optimization does not behave well when
one of the middle node is freed. In that case cached32_node is updated
to point to next iova range. The next iova allocation will consume free
range and again update cached32_node to itself. From now on, walking
over 32-bit range is more expensive.

This patch adds fix to update cached node to leaf node when there are no
iova free range left, which avoids unnecessary long iterations.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 drivers/iommu/iova.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 83fe262..e6ee2ea 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -201,6 +201,12 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	} while (curr && new_pfn <= curr_iova->pfn_hi);
 
 	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+		/* No more cached node points to free hole, update to leaf node.
+		 */
+		struct iova *prev_iova;
+
+		prev_iova = rb_entry(prev, struct iova, node);
+		__cached_rbnode_insert_update(iovad, prev_iova);
 		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 		return -ENOMEM;
 	}
-- 
2.9.4
