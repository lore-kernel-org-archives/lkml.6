Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeDNUzS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 16:55:18 -0400
Received: from mail-sn1nam01on0080.outbound.protection.outlook.com ([104.47.32.80]:15255
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751614AbeDNUzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 16:55:16 -0400
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=fail action=none header.from=cadence.com;
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
From: Rafal Ozieblo <rafalo@cadence.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Rafal Ozieblo <rafalo@cadence.com>
Subject: [PATCH 3/3] net: macb: Receive Side Coalescing (RSC) feature added.
Date: Sat, 14 Apr 2018 21:55:04 +0100
Message-ID: <1523739304-25390-1-git-send-email-rafalo@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
References: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39830400003)(39380400002)(396003)(346002)(2980300002)(199004)(189003)(36092001)(4326008)(5660300001)(105596002)(476003)(107886003)(8936002)(8676002)(246002)(478600001)(87636003)(26826003)(50226002)(50466002)(47776003)(106466001)(48376002)(305945005)(7636002)(6666003)(2906002)(2201001)(51416003)(76176011)(486006)(2616005)(126002)(356003)(316002)(426003)(336012)(86362001)(42186006)(36756003)(186003)(110136005)(446003)(11346002)(16586007)(26005)(59450400001)(2101003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB3905;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT045;1:Y2Jey2s7eIqxqapfl7I0jz0Ain5kazCNhtY642QC/p0XGpTCW61zReoYnFZmdqtiufPXAdOgwhN1ad7PxUl2vNNG1BVtqJcsPHSaMSnFFHAI6FErY19SS45NFNcxxfsz
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BL0PR07MB3905;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3905;3:gANfp1TE6F1DviHqZ7fXbOUq9/OitamuFWAClXdhDvtgOcIwgZNyjy/QG4NFRuw3OtUa32RQWEJz0VU5G5gI5PihzE+7rgoUQOxNZAblSYzNWrt0dVjNA9brBcZANmUStR4QQ37YTNXL3LT5psmGJPdlZ904S/YU6ZHSWqgSQDmfGnWIIOOdhEdDKCnFgqqktPY7Yfb85L3UZdJpIwy5YReDdaRF7qQJHoaoSGQAMwUnemqL7xrVOtwrov/VYHPvBezu4LZGzTy2uL84sBJVwj39i+FMNxKTAud+low8hWjyUqFGqnLCN0xIlhhddIP8lS1WqwnZBFgvP9/Qa+nQpSZCAd0RjybCPdIsJ3CCoEk=;25:bvIEJZBdHB4uvO18KmNXBOwMO2daf0UzCWOplGVuvByvEc8T4/oq7hAX3OcEw9wvb04KBem/GOqjpMz26TzxddqeDca7165LeJgzg343PioVl2XjvAXZvXTVInkmkseY5LeTlFvHWNefd4qf5rBKMqSGbiPUwQKmtH2aSDJXylCThqloDCG3xchf29dThwT8LVk10KX1uspx0iAZMbqThGE1NJonZBgYAFffOj/1UBtPXUPMGZDbP6b9chC3MaMT2eR83qmxnooT3zgV+DhH44gmTgBQiSNzYxOM4kYkbCxWDGSs8x0NS2Bl/vsEwaK/GA1s4FbsMrAlDMUm7xt/YQ==
X-MS-TrafficTypeDiagnostic: BL0PR07MB3905:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3905;31:jw5NHZOHi7m/jJAQJ4S2Kz3dGTAA0HLO5gqZkflU6HuLmJmivtyo7SJR3yc8OOz+xu5dj8awP03qns8EVr5Np0ZNPgi4hDjb3R/v92b0oSfA21SsI7PKZjhmlihGxHMDjGB/69GQvUnrVx/eyDO23tTLkMMRulgiz+8fvDPqXvMCrKWoxvAJmkzPH1opPmpuXKkQ6ZmC1ORpIMJFNjwWFlwT//JKNYUfNdhmIBa1C8o=;20:5hYfktgyqdW9CflLt115erMyVKGxj6Eq2tNTixlh8NdHPjJrrQ6I2qAhPgiT9zjQmcP2i6hsH/KGNpmCsvTaZz9dJ/j6hrRvMcQ3B8e50Q7EJlfFhjdV6yjBZlEGvo891jOpI0mmq/LqyxRG/QLjS6zf5Ai6jaBqCjfM9ViPK32JKkc1CG5fvdqVOc0JJYQSjwLloSvAysCtBtbz0Dbwxq1h56lxRc3CRFdtgR7Jdaac/ddXeG2ZnANfq+xgjS6CjvV2YsPfWzdVjYT1WnCVWd4GUxsBJRtmu72K/0jUfKwc9jXPZ+jdmaSMmn/wgLlx+qggA4dUCufxDbnZLpgqRWIURodIw+vqVPg6aDsTk4E4kK768qmF8qp1hU9ZSCaBgG7Y6K8y9yjh+gLFSfSD/28Mxm0MN5THCw+36R5IhnOAwmSFGYjUBtoMljqpwEVhDRnVbatp8Cke13ZEC2uoKz7ZjoLBkLQCjtZllaqpOVew52G3EKquceew2pcRlq5a
X-Microsoft-Antispam-PRVS: <BL0PR07MB3905ECC439DFF7F7B0A4CAFAC9B20@BL0PR07MB3905.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93003095)(3231232)(944501327)(52105095)(10201501046)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR07MB3905;BCL:0;PCL:0;RULEID:;SRVR:BL0PR07MB3905;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3905;4:Vl+DII1gkUy4SPwc4OkCllLf8k9lPX/XQky62yZmb5SAGfoDNIvvzHR+7ZSKJGswd2zpVN1YTSbIBZYPdDOEL5Mnwd6HGcsCicwdpOJt+It3xzDE38jA6pEblFpKGTih79GSQPFvgSXNKYOz1TZkRF01QN2SSSECAiKniCnf9t3p/osHD4GeUvGGogSrxdjbulAjBIiOZGe6KmOyo5XfSm/T9fQ/UF6W3CHRz8tsuLiMPLec1lMJMxwvBYL0PzWJ2Gi5L/+Fn5UCtfK1Xm90goYpxxp6hXiP8vMNMkzmSfwlim9fAyopVmhnCEN5mxO+
X-Forefront-PRVS: 0642A5E7BA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR07MB3905;23:lAIAp1zWusgH/GIj65FNnB/l91DXbKBilEQHasbXN?=
 =?us-ascii?Q?zmTNuky+V4fTEh37ixdnMQvTygpWr1OM3cuEaqrNRaom3IUm3ABBbHikD4CG?=
 =?us-ascii?Q?Ao+x9aYFinee1U30KFjLjxWyYpq6viKO+ju8OCevb+k+CbboftyWJzlR5U8m?=
 =?us-ascii?Q?MNLsuGnKZxw4AvD8zm2VIQmQHWMRc2Pq65xaeKA6Cn6ytWrxTcGtoAUe8tmk?=
 =?us-ascii?Q?8MzBHPwWdRxzH2tRQXPJEVNQIdE6dPF1FMhVYPYG0ZdwcCgP/AKVqx//XLY/?=
 =?us-ascii?Q?LMJ6ppjWxPa+EEY+LT9VmBn3HTRMuN6v7byOWSLSCdav2lmhJvBvrtqg5BU7?=
 =?us-ascii?Q?Wk2++nOaYB/gwsxjsd0djBcd3g7bUuQg8iNkImkEZzyZR/TJBcnYPnQpEhIw?=
 =?us-ascii?Q?fuB88izRxna8VYOSl8KaPQXLrm4lxtunoIngzvip8/B4KeEYuuC3zSQ3I8jw?=
 =?us-ascii?Q?GoVFByT4IwZiae608iHmubXrdvueL+c47DXP2nJwevvsvTczSm87TpXYNkN4?=
 =?us-ascii?Q?NXLYyyD4wSBt16FgQBAYWTC6cQtVXi/Q370BEbdY9YyC7wKK1LXSN8CCj4ne?=
 =?us-ascii?Q?a1S6SaB00pjJy9R3RbHDQXEwBueT+ZHbh8qzatZDELTiNUWbPs+CedLaLk6a?=
 =?us-ascii?Q?ps1teXgBMYpOELrARAkYnxoZul2bGQb67h5BiQK0qinvDUDnXXhM5jUrg/oV?=
 =?us-ascii?Q?RXZQDYjs3mO+l6kGqx336dgdLx4d3jX7SzSFOrK5xoxxanNnZAlrt+Azz+Tn?=
 =?us-ascii?Q?eBJucPHuo5WWGLJQeyjh6eYX2VqXHydO1NNreC4gTnc/+A6QlnfMgEh3LHj5?=
 =?us-ascii?Q?7jFluUmln+B7OSm42i/8yyatyZ9tYyGsFbuRsBnadHP1FW2Npvs8OBW7K0k2?=
 =?us-ascii?Q?w7VZ+WFHs4qONtVNfRANfi5H0D7t/kpieIoGaAdWVg0ATpg9LU+UYwmaHFhj?=
 =?us-ascii?Q?IjoILQtfbAuvivVlTD+KxMSa91TMB44szNl+hR2T1GyifdgCifzeXEYwjUjQ?=
 =?us-ascii?Q?P4JVDfU6BlBxI3A/HQRSC3uPq8c4i8eyDkA4kfsESF06GhcI6ZKC4YBKEsIY?=
 =?us-ascii?Q?jNSchxqE2MrbxQZ5r4ym2OtH0CoS6y486rNiBrTluyZXZqOiB5RIzQrlal+j?=
 =?us-ascii?Q?aTwQB/hxlizlVuGJA5dBRRtD6wCe2Rx?=
X-Microsoft-Antispam-Message-Info: buRLOCFRTHsGGY47xCuvsV1r+kwGDI04gdhOeZoGD6WraL0x9VfNMn3YpUnL5lb1yQGCnpJNShbFxTvBY0XtrIBHgNvp3wzGVGWEVwpmMGQUpuGpCnxEtO3YhE8vkD8GzJevXL1pbVQV0CQJ8Apob2QzvrXT1+1jd+8DBjTIX8cTStx64Pxv8pvE6rbkc/xg7/+UI6gxpJdbxmF9CYJG+hRpbXHdzBPdjDISYb4PzC6AQuY4mer7jOpyiJxWhZgsG6R6nSl8dbtjh/d2GKeVKfW6nM1P8aWmERJe0j/rKAZH+J05z2P8VqMicjprxDdWPdz4cllUbfPM1wBddt+X8ULv9CMu4luCv5MIAwr0k8QMoZtLBtZiXcxASqZmUts+Z72tY+21F7+juCbUuC8l1vW+enHHjEYrR/1iZGEwy9I=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3905;6:whFfGNeM1PinLR+m4/Ws/gK2ofjmFguc+G12lsZGKMU+CDBH5JunwHIn1ezGYYwY7B4Bt4+aFB1C6+BoKnzUpQruIXm9SgMHqf7qZdjiL6xyJWVgDBS7gtAIPxPr6tpPWijOIiyHqSAfiCT+4Ssu6SJw2JbcpbgJGqc1/YO0FWZk0U5ZSUvYpVcxZN1fo6Iv7S0hi4DDo+48aoJRX3zOVLnbCStlKhaZJnhAVmWAQWQcdEW+i+3ktu/iUnUlZTcHl4Fi1aZVJ49UBDbO0BEiXwnGKdD3D1s2FscZ8EV3jnaVhfU7CyCt2t1Dsrf0QN9XMqXx+uOChl6uOvkNzwHqO6Ixz4UJ3Ivn2j6vMZKOGQhc0MPycGcwL1Kn2S+u4t+dGnZsU3aQCv39DSbxTGUSb1fEyRHa9AXI7/vzb+1d7iuS+C0xQaF9B3bNr4TX+EfeWNdLnYz+e4BRzpcBq6q+Bsc2C8PDJFn6y1iqQbureCk4w/g5RadKb1JX7kVaINaC;5:qfg1bui7ZacNfYPu7HIzKH68lfc7O83xwDorkDWFxBCTO0dZnVw0KVE/AbQkoeNtmL6g8AYq6ws5xqMRn1RO0q/1QraWd+CV5Rd8DqS1m25s+NWL2H4idsfS90qjMmU5xE7HzfoHrLxs7EqCjVsnc8pzG/7e5M0oEbhYfXkftMs=;24:/KFhw262T7xg/Ef7EAXYgiYws8B077GeL1Q4hYIpIcMfEnhtJD2ntFi/inNeSEIocjcGZyOmYCJEdZKld6J7/9B/QSs//7iTbtzm2RBfJd8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3905;7:jb5ZcM1UY/6CET1oA8ym5NktoJMN+j8BBHhKzXuFhZPaoiisL/0HZc9weACMKyEIRexn8iTsMMDUAeYgiHLeBFroX0xNUUFx7BloSBTjX0OtkTXJnAOTAsvouAnA4FzbHeY0iurk536b7vtZnUi5zPpJH+KwDBoZ2hBEHW2ghyQhdXeryi2mnVZ24xZiAoqn6tulvHU4GG7UfEq8DCyozGQXw+J6GXkZ3NM9Xvj7N8UgFpe/OCW56xxpYX6tTzWg;20:bnMKgQXkC7pJ0nBoTgPSon223Dz+d3TDeG7OR+byDx4BIR+AJ30UI5XSGvoeiExLol/ag7PbI2+3Pok8IylcUw7krKBdwMXGbVUbr9yXHq4Px+E+BgKpKQu6UwYhwGp13lVPAlB6jdoclgWaWNSB/NU++Q2SCkyMXUok9PabqMAJTykl1ArpQIqQ1QAJpzp3hmck/3yBsTe2ZO6A8/SN5Jj2Z8ts8vr8/JC9fc5BNXZiJ/wZoLaZKeTC4UAjffOn
X-MS-Office365-Filtering-Correlation-Id: e43c85cb-6c2f-4119-334f-08d5a24a042b
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2018 20:55:12.3387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43c85cb-6c2f-4119-334f-08d5a24a042b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB3905
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically the same as Large Receive Offload (LRO)
in Linux framework.

Signed-off-by: Rafal Ozieblo <rafalo@cadence.com>
---
 drivers/net/ethernet/cadence/macb.h      |  6 +++
 drivers/net/ethernet/cadence/macb_main.c | 70 +++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index a2cb805..9ebdde7 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -83,6 +83,7 @@
 #define GEM_USRIO		0x000c /* User IO */
 #define GEM_DMACFG		0x0010 /* DMA Configuration */
 #define GEM_JML			0x0048 /* Jumbo Max Length */
+#define GEM_RSC			0x0058 /* RSC Control */
 #define GEM_HRB			0x0080 /* Hash Bottom */
 #define GEM_HRT			0x0084 /* Hash Top */
 #define GEM_SA1B		0x0088 /* Specific1 Bottom */
@@ -318,6 +319,11 @@
 #define GEM_ADDR64_OFFSET	30 /* Address bus width - 64b or 32b */
 #define GEM_ADDR64_SIZE		1
 
+/* Bitfields in RSC control */
+#define GEM_RSCCTRL_OFFSET	1 /* RSC control */
+#define GEM_RSCCTRL_SIZE	15
+#define GEM_CLRMSK_OFFSET	16 /* RSC clear mask */
+#define GEM_CLRMSK_SIZE		1
 
 /* Bitfields in NSR */
 #define MACB_NSR_LINK_OFFSET	0 /* pcs_link_state */
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 27c406c..92bdcf1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2377,6 +2377,8 @@ static int macb_open(struct net_device *dev)
 
 	if (!(bp->dev->hw_features & NETIF_F_LRO))
 		bufsz += NET_IP_ALIGN;
+	else
+		bufsz = 0xFF * 64; // For RSC Buffer Sizes must be set to 16K.
 
 	/* RX buffers initialization */
 	macb_init_rx_buffer_size(bp, bufsz);
@@ -2801,6 +2803,62 @@ static int macb_get_ts_info(struct net_device *netdev,
 	return ethtool_op_get_ts_info(netdev, info);
 }
 
+static void gem_enable_hdr_data_split(struct macb *bp, bool enable)
+{
+	u32 dmacfg;
+
+	dmacfg = gem_readl(bp, DMACFG);
+	if (enable)
+		dmacfg |= GEM_BIT(HDRS);
+	else
+		dmacfg &= ~GEM_BIT(HDRS);
+	gem_writel(bp, DMACFG, dmacfg);
+}
+
+static void gem_update_rsc_state(struct macb *bp, netdev_features_t feature)
+{
+	u32 rsc_control, rsc_control_new, queue, rsc;
+	bool enable, jumbo, any_enabled = false;
+	struct ethtool_rx_fs_item *item;
+	unsigned long flags;
+	u32 ncfgr;
+
+	enable = (!!(feature & NETIF_F_NTUPLE) && !!(feature & NETIF_F_LRO));
+	rsc = gem_readl(bp, RSC);
+	rsc_control = GEM_BFEXT(RSCCTRL, rsc);
+	rsc_control_new = 0;
+	if (enable) {
+		list_for_each_entry(item, &bp->rx_fs_list.list, list) {
+			queue = item->fs.ring_cookie;
+			rsc_control_new |= (1 << (queue - 1));
+			any_enabled = true;
+			netdev_dbg(bp->dev, "RSC %sabled for queue %u\n",
+				   enable ? "en" : "dis", queue);
+		}
+	}
+	if (rsc_control_new != rsc_control) {
+		rsc = GEM_BFINS(RSCCTRL, rsc_control_new, rsc);
+		gem_writel(bp, RSC, rsc);
+	}
+	if (bp->caps & MACB_CAPS_JUMBO) {
+		/* Don't enable jumbo mode for RSC:
+		 * disable unless not RSC and large MTU
+		 */
+		ncfgr = gem_readl(bp, NCFGR);
+		enable = !any_enabled;
+		jumbo = !!MACB_BFEXT(JFRAME, ncfgr);
+		/* and don't touch if already in the state we want */
+		if ((jumbo && !enable) || (!jumbo && enable)) {
+			ncfgr = MACB_BFINS(JFRAME, enable, ncfgr);
+			spin_lock_irqsave(&bp->lock, flags);
+			gem_writel(bp, NCFGR, ncfgr);
+			spin_unlock_irqrestore(&bp->lock, flags);
+		}
+	}
+	/* Need to enable header-data splitting also */
+	gem_enable_hdr_data_split(bp, any_enabled);
+}
+
 static void gem_enable_flow_filters(struct macb *bp, bool enable)
 {
 	struct ethtool_rx_fs_item *item;
@@ -2969,6 +3027,8 @@ static int gem_add_flow_filter(struct net_device *netdev,
 	if (netdev->features & NETIF_F_NTUPLE)
 		gem_enable_flow_filters(bp, 1);
 
+	/* enable RSC if LRO & NTUPLE on */
+	gem_update_rsc_state(bp, netdev->features);
 	spin_unlock_irqrestore(&bp->rx_fs_lock, flags);
 	return 0;
 
@@ -3009,6 +3069,7 @@ static int gem_del_flow_filter(struct net_device *netdev,
 			return 0;
 		}
 	}
+	gem_update_rsc_state(bp, netdev->features);
 
 	spin_unlock_irqrestore(&bp->rx_fs_lock, flags);
 	return -EINVAL;
@@ -3191,7 +3252,12 @@ static int macb_set_features(struct net_device *netdev,
 		bool turn_on = features & NETIF_F_NTUPLE;
 
 		gem_enable_flow_filters(bp, turn_on);
+		gem_update_rsc_state(bp, features);
 	}
+
+	/* LRO (Large Receive Offload) aka RSC (Receive Side Coalescing) */
+	if ((changed & NETIF_F_LRO) && macb_is_gem(bp))
+		gem_update_rsc_state(bp, features);
 	return 0;
 }
 
@@ -3449,8 +3515,10 @@ static int macb_init(struct platform_device *pdev)
 		dev->hw_features |= MACB_NETIF_LSO;
 
 	/* Check RSC capability */
-	if (GEM_BFEXT(PBUF_RSC, gem_readl(bp, DCFG6)))
+	if (GEM_BFEXT(PBUF_RSC, gem_readl(bp, DCFG6))) {
 		dev->hw_features |= NETIF_F_LRO;
+		gem_writel(bp, RSC, GEM_BIT(CLRMSK));
+	}
 
 	/* Checksum offload is only available on gem with packet buffer */
 	if (macb_is_gem(bp) && !(bp->caps & MACB_CAPS_FIFO_MODE))
-- 
2.4.5
