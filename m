Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeCNNil (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:38:41 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:55200
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751408AbeCNNie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:38:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] dpaa_eth: increment the RX dropped counter when needed
Date: Wed, 14 Mar 2018 08:37:31 -0500
Message-Id: <20180314133732.24068-5-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: SN4PR0601CA0024.namprd06.prod.outlook.com
 (2603:10b6:803:2f::34) To AM5PR04MB3267.eurprd04.prod.outlook.com
 (2603:10a6:206:d::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ad45f65-6e3e-47d3-9d69-08d589b0e115
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3267;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;3:HEa7S1M/mD3vtDEqPUfjLqPvtZYpKiR0HvW3XR5M4MyxyCpaFGvlqs5eei4cU3OGjCc8SWy/XrLB8pZ2uhBmh6VEeh8FRECxyJFk4fDze6+pPklZrx8a8nLQnBlzF/L/KxsbEn/q60EJH/5pIvR5F8IdYs7FyAQ64jYhQcSjK5w4zaMNZoE3xvTSc3hmGwoxtk7HLHXlo5kYa6cDS/7OwrqGzY8oIq8WHpExEIQS3mi56xUdhffuMDSldRLTzgGj;25:CiEed0iimulTM3J2/5ZLKDgxH5eoiH8Y93NyAxfQTiOGCR+C5jlYVSs1SdrMJVX3VgI+GReUzQUkTd+5UGBL6aq/BipEOSS9y5FHTM+bUT4HhzDP3iy8Tecd2c1rfM21tqfbTTIVv5M+B4HAsT7E0fVOo41EVaqnn+8lMsT+gBlAcc6o+iGRFW3Hs/C6UA7lF1CH0Uh2UlBZkPEXj2kQH14Dvd6WZRbYj/Y6rQK5o7Gi7hUzNEH30ta5OZSHFjhNnqo/fd5XawUuNtxxVpQRCpZnCbxkSawTiEaZJtZttgndV5ITeUYaDiLTnxpOZNXm9oXQ8dqpFqcDZtvbFv5ZJg==;31:u8QHKjZXvGrzuKwuqOekHEg29HkwxqjbEQs14QuzlHiycwMy8zQq+X1WOZTQzWBM/ijy7zSs8czVoa8xQeb2X+evxeQmUflF+oftm1xsWcLZPpJ5QuOlgkcmOlZX2xppoRFGqTlqmxuALOaYbj5YycxAosxhcBgtSpaSrEO+0hiEMLg4DNGnWpHr9AG+pRsArYYjiBRzbDMjBJV7o3aj++6HpZSYP7FOHZhnYRtM7bc=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3267:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;20:ioRxFy/v/Sscho/uqghP779cddC05FY+gUImDf2yZBLpJ1JMO9FgSxxaMv3x9ePRBJa1zo76Jw22ewsUU1ZIklvSOKgdD7V/ki0u6nCMIfMp5c4EtM1V0eQRfe2Qag2qxQhNF6eIYvPfTGs2G8kn8STms79kxcvXXE42Z+renG4jw7iIdNqk/aDwlkf9NhOeHYsOyxJlB6PUEy5pdNLRQ6q4AlPmh6cWQ7sMD4LfrOPx1YOH+xr6RYfY4HEMQx5GuqjGYqAGxl5dSvF3EkMMfsxuFo6bvKiGQnXwIF2AsA3xrHoP2eTy9aG0ERgGsMSCDSe2Kf7i2sB2SuM5/SQNAtsLGs+laX0eGw+S9kDPogsVQXDXS/+JsKnfuRRQfDg9/fMvZDXPFkEEoLjSpCWjUdmg+feSffeqRT6uUwX/ySw+wFypVeffgC6pCdL06PE9WQSMgi7pae27NYZvB9XdNONPWNukkQ2QjgFU2qiZvgCyKkHBM76rQ8tL7crZxtFM;4:/ByurpKfYJlVx5guZ87Ey3zJCxPY3e459XJxD9ToMji1XS8rMlTgTPSho/3IIlQp4n0ms1BhoMuI3s37wWbPYgO5wQiFWVn3ViQcMmzieojaEpVud6ZBayG1C6/BjJ3AIqns9vwcU35xuqnykvg0upp6Bs+XytUZ+yLVSup3UtjqYOtJ3suw9s+6lpC74AC969T+An3E95y/ugg+tH+jK+4RwuMMjX8MqNld7+fkVV5sKdwnbSxoAihEC2j2eSfUeuYUNdgK8f3gr1E8hqQjKQqFbVpck7jX+DySLforBwrpWcsekhRYaT/ktzoHAMRG
X-Microsoft-Antispam-PRVS: <AM5PR04MB32672B230F3428A23A4C5164ECD10@AM5PR04MB3267.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR04MB3267;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3267;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(39380400002)(346002)(376002)(366004)(396003)(199004)(189003)(1076002)(68736007)(7736002)(6916009)(47776003)(4326008)(8676002)(2950100002)(316002)(50466002)(81156014)(25786009)(81166006)(66066001)(50226002)(305945005)(3846002)(8936002)(53936002)(6116002)(36756003)(48376002)(2906002)(16526019)(26005)(3450700001)(2361001)(86362001)(186003)(59450400001)(478600001)(51416003)(76176011)(106356001)(52116002)(16586007)(43066004)(6512007)(2351001)(6486002)(97736004)(5660300001)(386003)(105586002)(6506007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3267;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3267;23:gFsVgJgypZ451Gazh1x1SyBi0vvQ5zBdWdIP84KLF?=
 =?us-ascii?Q?oHp0eC3hOVin/ThGqszkwiC6pDuVxJv/dDlksVjQFD2UA63edFkIGFKcXmzs?=
 =?us-ascii?Q?eSJiLUVNN5JzJgndd/sdIeCo9KAdLU0knumCiR+92UERugvAaZTQ+cmiXoDv?=
 =?us-ascii?Q?9x9HYTdNmf/PGZ7ILmKsDH7M/CvIAsFEXv381TWxf3ZXRn9g2Kx3WhzaKTn/?=
 =?us-ascii?Q?iQh5eq4TbOaJGjXds9d0Eb91L/+m3VfMyiqGZLcTlHqr1l6jCpiJPE2lK6C6?=
 =?us-ascii?Q?CrVC6jFKQwVlpuj3mGcqQsDK+q08iSM1651Ny5xsOEy2+e4ng9TzShFRww0M?=
 =?us-ascii?Q?xlcWEX0UP5UUZfLNmgNCGrAcJKku+BeB7JHEDSdEGU/m/kbdJNdSfcSOwA/u?=
 =?us-ascii?Q?yCejDlGVXtbQTrivD8hs1iodz9rc5tIB9PRiWd3pZ4UArkbv1JCxg01+Vi43?=
 =?us-ascii?Q?aV8NfHCkfXZW81It9jVjmUrPlf7vPKvt1w5vt5VFcIDtbqEnej6x9rR4P2s7?=
 =?us-ascii?Q?SoGr/S5J0t9MJx0XMEXtvSR1Bc/dJU7w9SZntQaEMhBqFVTHXtd0mlDY/itS?=
 =?us-ascii?Q?99fDqOd9f1AbRwo/IW0blUcA+b80AMMbg9hGXsUTaDZuRgzVelziF9wqgBav?=
 =?us-ascii?Q?4peH90pwZBTToOSoMNK7w5wtLc7xvVQqaohToQCKVTNVnsgfVrgI6wV1j6sK?=
 =?us-ascii?Q?1usSc7hISxNO9Kn50hwCkeaRe4z5eJwBLbki/CmVWnVlx1MSq/nrRMSwRO2V?=
 =?us-ascii?Q?C6bXgmhebSCuzsKK9+zFWd2jMTpPGrVZX/Eoq6W9mReAlC2ZFPv35mA0GUVs?=
 =?us-ascii?Q?1pQAmpF/w1yJSqyXkSeOc7L3taSZKwnqvr9hOkPgt2fI2a/p3TNcUSXCqZ34?=
 =?us-ascii?Q?6wmXQ/lA5aVO4tYECSnYtrIzZ/rmhgMS/zO+03gOZ+ExhaNChhEMXRTe6cgt?=
 =?us-ascii?Q?mrGGyPvMdugg6pJg+rymaolqiTPX11tsyge0wdp/I6t5LdXbWTGfnT+igaOi?=
 =?us-ascii?Q?DxgNPRUAd9VVPec4pQQQ7llKnM60OiBTqJjEnfmo6nxeykP+xMW1YlvDmONo?=
 =?us-ascii?Q?p/owIKyiYUqsZZEJfL8IP3676q0xiluwoj//aeiVhb4f+p8fOPs/e3o6GnaX?=
 =?us-ascii?Q?X5OixQKVphHyCfe8xDpnhEunSFmlKbxY80lSFJwei09HQRRRLhM5hnCfH373?=
 =?us-ascii?Q?4aML1X0T6zHQs8xb17tLhTEOT8GI0sG1F5z7GXP6IFbY7Dlx+5Gk19wxx4Jr?=
 =?us-ascii?Q?nRrPpHmhunQHNWJmbPri1uwtClcD9oM+UAfIXIqamZb0Zz+Kcv+oReGkzBgs?=
 =?us-ascii?Q?8rO5LoopvmoFQ0q78Hv9iQ=3D?=
X-Microsoft-Antispam-Message-Info: oH2+M5ZQFG4VcyC5xfMAtYpDwdM955vjUUYh3SlpnaoegfkGSBeBEFWAg7PZgUVqnIxBROp8iOTc4QO8lJSvhsHYiyG+4p71SSaaBjlIioB5Z/I9zJETxUtHs7XYAjGwL3/dWb4e/u3aTWNaWEjg8Goajw+s5ol33B+DMyFJgPLhqRp5dxcDoRxEjezH0OLw
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;6:rP+jbuMtzrLnq8+yGsFmWjLm/Vozu7bZDYmFETjA0phucKMcP9bC6N63O5ECj+/Eey4a1pAX/jFOcr/ULpzaoy78t3FfEDJrCbOQzNeq/RX9Nn1LcRvfJ/72lTfmFUXYS3kw1UhrW3292cMYyXhQJ7+XCKm/nNASfs7yZdUpGoKZ9+OocQf2jNmWku3/1QOF/cdzSmP3DaHlXIk16rx4l1/2pTxFYqSgqG7b+hiOC9teFERkaCBSY++nAlb7htqaLxakZGDB54mIpr5PgFHVM7TRPO+eQDe+pxYPfInCDRh2IMTdjsQQbqdHmpbpZxcUSVTBX6V7wdHql2Uc5/3G/S5rWtv1HmD8fO6OGElIDX4=;5:3lbRA661zt2dpyDH3YNCIBcswU4LkvrAmz/IBSwvhgV4iLfVkxwlNd6uEA5+W1i6JD9egxpXM9zxwod00Zv1HY3bqVLp7qAvtqBUCyKX3WmYY4iF9Iga+tKoWTbwCsEX9rbbzBOEUDQ0ehUmXEtOGiuwrWXi/N+v/qlhRs/bq7w=;24:chcTL0iADVJfslDeIMo2Dd7gvV2jYz7PRQYxerQMz6NDaI7kQ27QKrPxAb5heot/qn7S/3Egd0olOCIqTII5ekA1LBL1semnNiTBv8SSvOI=;7:thM9uD3755s0nzgY1AmOtNFjvFyD9jnRcwj8zwaveJQhT0Njr5wR/igrczGP4FoOaRLWv21tdKcIILkJZz9gE33f0N3smxhr1i8EF2WYWMs9/T5Y9qgpRf/MVjF5nBxZOvtgn97UpkObXfeBAbNWUOMgA7eboqxlRX8l9l8WglcJV+AI0g2iT1o8hrG9iDdN6BbN69KSvd5EQT0sNPs4Yn50c4LVFdNOO1F0dpMOvLhZAraY+n78BWTlli2SkiMG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 13:38:31.1801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad45f65-6e3e-47d3-9d69-08d589b0e115
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camelia Groza <camelia.groza@nxp.com>

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 3e83d79..76b3c9e 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2321,8 +2321,10 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 
 	skb_len = skb->len;
 
-	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP))
+	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP)) {
+		percpu_stats->rx_dropped++;
 		return qman_cb_dqrr_consume;
+	}
 
 	percpu_stats->rx_packets++;
 	percpu_stats->rx_bytes += skb_len;
-- 
2.1.0
