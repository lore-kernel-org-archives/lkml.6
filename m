Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeC3MAf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:00:35 -0400
Received: from mail-sn1nam02on0083.outbound.protection.outlook.com ([104.47.36.83]:41728
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751204AbeC3MA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:00:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, ynorov@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v2 3/7] net: thunderx: add multicast filter management support
Date: Fri, 30 Mar 2018 04:59:49 -0700
Message-Id: <20180330115953.17154-4-Vadim.Lomovtsev@caviumnetworks.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0faaf57-b5c8-447f-0b27-08d59635d321
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2997;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;3:k2BuprhIQ2opLTHPVQBseIvRd3XpcOmpadBfxDarLmi6femMilDDcKDIrmhpgVWdNwzeuFN7gA95IvVSVAR27lFXymdkrK8kdSLgJLpROzs6ME8IhodUthd8c1N+kE0ym/AoBqIGkTmOgX3IB+KeFpXVvhgK+BuxhY2x4wWx9Jom3HClZOwVsZu9D+oNkI4xdEqxjxuoiGiEwRAWqtttJWyaQ6dgRxT4USnb0KAv8BEG+v41584e1ZILszMjKxCn;25:JqgGTsAKJSMvq7HXc5B+EFWOqrnTIRiKIxMO1wAUukSwx8FYHpkBq2MaYjBUBLzO/MbMhoJxBkr1FqqcvlReSvCa5ShDvEM4FfBtJ+WB0j6rkAbuDuyFDe2Q06mSIZCHsVzOmNtDLaWxV98233ZPWaK02LYbZApjOGeKUGdLTniYndrKJebDggIlgkl8WqovnN0vFp37JlAQS+HsyfetktL8EkCFFicksjpyDeokE3wbVug+XqpzYtjyLZbR4vcMEzyZFLmGcHXFemmnhqimmSldo/NZSTyTbNouDC6malwYPoChGSJiJoI0FabcECQJx6qWEbzBl+555awA7VWLmg==;31:x8u54wH26qbW95NZlpEWjJePCqR2bIlPpfrBkYQXj4w/1lu2Krl2qoVUqUkMPmAhfHQMA3KdNYF6jBneK2z7B/35rKPv2LSMpaioxp99/mXI7IM61v1O9wtS4WCEUL1MQkjyg7KcxqLlO+aKGd6bDN/lHEj4EkP3EEgYP0zFjojA0pvA+Ek3rY1DCVHREljCKaGt5lDaYIpW/a/tvC/YNCysWU9K6Qs5sklBP9BeqSo=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2997:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;20:i9YcRoXOT1UiGyNDnmnxMiGHMdE2s3hdIhq/qAWHpfl5R2xvydivMYwJ1nU4SBP9ijnM8yqhZqlF1248Gk/+H9W/957JQ7FD22vhGEef5qmcy5J+aZrlh84rBU7nhoqxryCAy4aD2G1I8jLcbn2X7MX0DUjUVZGRDq4txyk3ckcQ9iy6NcRekPeb49Fm7L25adU5J2jCkOyWBeO/yTbRZnrTVnnQA3pgmPHbirCAbJMGf5mNgUx0Z/0PgOkAB8xLjhCYav6aHIbqDue3+oj8p++MArQj66HrcJ9R/jbbi0mcEvxOGCM41hpyrNwtjFWbXeZJqjxg5Muvh/AJ0TRm/Pmdi452Exl3Wd0Evxnxc9pgb9ZAT7yUOAvq06FbvkQxsicUOSqQHXksCz6r5wdqrujytYd6aXeQ3hAE9S4h9qJBQm5kSDmXIe+Y4mKvxpb2Fq35sCBP96wmGo/zj8i8vmKYcl7jILkP//pvNHJOEo2o2qJZJM+azAcKbpZdO/wlHRQjK5sGu9IifZgHqLFbkMNkqWT/m9dUb8ABt1Rfn7euSdiNQsDFSmBP590Mp78Tq/w4Jjcrf2+KRtFTAM07KysyH+DDRz411X4oDKKxk4s=;4:ESpxPgrOOpbQj0FQxK4gEGlYgR6Zaebxby3pN1G8cCuVVlv1wmbhajZKkIRt123jjqRZ29BCKHYo1mnFwdcvC4K4YZh+u6TcjzRFjgGhNmKwU/3L/ZOaaSHeQmc3VHAb1kv3xjbrgm3svhrd5GZibcCpa8oxxV19W2xyzcDC2XCwiGWvUnsHK+NDUSM8i6YA+xrQ+lwUL4HkZV2Xo1Ystk4thAa7mzlqBEtAzBzDQXjynJuNIjWjYANGvBjgKLrA/Y9VRUeuZPJxlDmEuvn6mA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB29973DC2BF371CD557CA1ECA8AA10@CY4PR07MB2997.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2997;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2997;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39380400002)(346002)(366004)(39850400004)(189003)(199004)(3846002)(6116002)(1076002)(105586002)(81156014)(81166006)(8676002)(48376002)(50466002)(53416004)(5660300001)(52116002)(97736004)(51416003)(6506007)(8936002)(59450400001)(76176011)(386003)(69596002)(2906002)(6486002)(6512007)(72206003)(39060400002)(6666003)(47776003)(316002)(7736002)(16586007)(106356001)(486005)(486005)(476003)(107886003)(446003)(305945005)(53936002)(11346002)(2616005)(66066001)(16526019)(956004)(478600001)(68736007)(36756003)(50226002)(26005)(4326008)(42882007)(5890100001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2997;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2997;23:FcbF3ATpGdn8MEHheZXhgaGmb7PjqDsIaH4BImYi3?=
 =?us-ascii?Q?O3HygO4i9pIraTJdj+qWOOpMHHY3N2Fp0DcANARNVdKtD/Q9wGS5WfPJ6842?=
 =?us-ascii?Q?nsISWOPDgAbq1jsXvsLGg/sfWIbqSdIiNiJ1tXFzcK5/8evhJl2dohnn4Ewt?=
 =?us-ascii?Q?KWLIxsXKBw4ecaWs5MXMgf+mNT88zGc9cX6QmbaucW3n4zU/cP88z0VHCXLA?=
 =?us-ascii?Q?fdoYmcyS04X6Df4tJXkRSZ/OV99tC2Y2d+xcZqk1TEeHzO9RGSfchDgRDG1k?=
 =?us-ascii?Q?/CSOsWegievtv1fVnfh2/JOi+pPMWlSce9V2T9M6BjkPr7hIf0HOaaGQK3b+?=
 =?us-ascii?Q?Jkb/OgVS6x7P62LgWnK1EwLchOZmhVTjPhkMPA7QRSEIUf6518KGih8ku3je?=
 =?us-ascii?Q?eueoB6Ror66rHmIyNc4z2lQ5nuIXEG0U7jMKgW50AI3uP/7vIbjzm+VKzBvt?=
 =?us-ascii?Q?OVlQsKLQt72YivZ9LzEKWFM43AS2Th0o/RH8CaxJ0sc7uG/jvcz/Yf6au664?=
 =?us-ascii?Q?VopIcx3lzBdrbVIHF760WW2SSfwzSZ/1ue9Ya5Ph+yE0bSl3+pUgRy3wZlaR?=
 =?us-ascii?Q?DvAiwCozwHD4oG0sPeCyP3mv/RIAbKNrtflv+QA5LPqW3wraxQERmsXCAWdY?=
 =?us-ascii?Q?AEWZgnt4QRIKuQ7Zmmeo0ySk/E2R8CgdDHHS1PAH3c57Vra5YPnGVfaiRusd?=
 =?us-ascii?Q?YAg2DZ0UsAqxOmTq5wUSi0/VM87ULd7bIXXIs+aw7PyhwLx+AyZp/GW9XqbO?=
 =?us-ascii?Q?DvpZUbZdW7aqwMlukqmt+Cca3/NfE6rIoeGFFxYSwO7rWQxC9w52AQTbNmal?=
 =?us-ascii?Q?Azjk8XaQmV+qoe4rHy99F8d7VioixLc+fMli7MakiKREgc/BTLmxfnFR7E8n?=
 =?us-ascii?Q?BxTCxlxTHBvqsdwfFB8pearUv9q1p3xkWi+Ho+Ev8PHbqlhlT0fkm05fNSVB?=
 =?us-ascii?Q?mshaGj71M387u0xHcHy8eorvj78N4W1L2GUlE0DdMkYvSz5h7/lmCfSIvY56?=
 =?us-ascii?Q?HaXfpCy/w9xBFG+7VjxQ/QKJV1crRmj4BCgrYQc70zGiwZjMHY866zND6xx2?=
 =?us-ascii?Q?sSwKcXG5ANBzkgAHIz4kodHxN4iulUqIAkCCFiAWAH/ZodWAQqdGqRwBuBPS?=
 =?us-ascii?Q?BR2BMaKH6T2yxBJ+jbMrMG8nD6mTCe6EMPAT7dhlnYzctddXzfmHIEPfmOfm?=
 =?us-ascii?Q?zVn592yp7yDHfrwHHktl3qpQyBYDhtlTG2IDvKJShgbc6tj5fRK3ZqD4PjbJ?=
 =?us-ascii?Q?3S8hN4x9o1hay8U1VMsPLhtHdxEcmOqiXnjpd9WQlgVQQt8z8NPfFjaUAiG8?=
 =?us-ascii?Q?OCS9MwQxM9uK7vulVe4PADlMBnYRy+ZJllyuFMSM5AHl79Nq81qd7YMqFSgW?=
 =?us-ascii?Q?p8jOw=3D=3D?=
X-Microsoft-Antispam-Message-Info: dXK8Frum9rNYY/5pdHSkJB0HCHrynHcXHNMnhqhkP1Aq8IZLNl2tc72IJF+sxin8U+rZQLo3AVWmjwWju3hsZ+ODcXm/MvIAJXNraipStKVVKH2Ms64rEBAif7Af3QNCWm4bn9d2B4Neymcr261TLsTuCWHakhTDjgCC892Tr354KEREdC3qRuc5H1rbD06K
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;6:uFYY8ViWA0aWTVT1RnUEjPUWxNf2Brr8RQmfZ5uCPZl1bvSvlKy1XgZpwe61kuUyjMtzZvsDN8ivbhTmoW4eDsA7OQW6YGkHEbG8GEbphYRnf8h8ETXaV/XHmp741USRjLC3WzhllFoqddB5TDZrgcWH7UFP7P+rjhccHb60MUNw9ySm6Zk/UtD/pt+W/ZxduNQ2IndMB7rkcsi+AJHXQjLRBvn5cG7oeD+S3PKvMftQthP0lbC+Onw5/LB3/r671FiwWMKWENKKcRsprri79RZL6Fs2MnutCgljbzs3YJO6IHd6JDLE9QR0YgxO0EI0AI13DTzwbk6P2EfqlPlxFWG9xaTEFwbPjFPYBWgMfIr7TuQC2kD6UjIxBBCJxpTwpYIBNEEvcd3Y9zmRDi5f0PxYQXGg55zpmy4vsR1B+RpshKfiu846XOZZFkSXDQoHnJAFCX2GC33Zl86bYNNu4Q==;5:89EDHJix2baTxHfwqpw45hLiAvJNC+8dwWH9cgZHoJe23J9nt23BuX+4lXBKkyv1lxTWuSP7hLxgNBfhORFMqrswLYbzwznw/w+GvRFqS9wnPdvRlEjky7Hxijn6hSCfNcen9AFJXFdDN440OfwCd7OoI/g2Gpva9JMuYS7v+gg=;24:USjW79koFnNk07E5tWU/sEucPgOFz2+X6dD47huqp9OtOIeYPZyl9TtbEQeAvj35iUFC+4tFoTccvYIYEsUrP/NNOnkMHhZTo1eSShiKnqA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;7:9i2A01NVGGhwcpMtWFTp3c9lYgHYdD43Fy8GcFwTE3Z0eORKqlab9boiqfFnKi6C28hvYoMtWShN0ww2n76m5bTG7UixDsEdc2Qe8W0UP1vYsFdascpr3Y1Y1fUUmxtO4lPf0fcRR5FYmfAKMu7gvzW9IcM7wzRntcNoI2xJSiMmlQwQyzOgmniEzgByesCrlTnYmM0mxLG3dQ8w28uVxRhBO0Yz3ybJYq5qWHoso49ZP+Wk70VFSs4UGdUZAXf5
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 12:00:25.6603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0faaf57-b5c8-447f-0b27-08d59635d321
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2997
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The ThunderX NIC could be partitioned to up to 128 VFs and thus
represented to system. Each VF is mapped to pair BGX:LMAC, and each of VF
is configured by kernel individually. Eventually the bunch of VFs could be
mapped onto same pair BGX:LMAC and thus could cause several multicast
filtering configuration requests to LMAC with the same MAC addresses.

This commit is to add ThunderX NIC BGX filtering manipulation routines.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 144 ++++++++++++++++++++++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h |  10 +-
 2 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index de90e6aa5a4f..5d08d2aeb172 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -258,6 +258,150 @@ static void bgx_flush_dmac_cam_filter(struct bgx *bgx, int lmacid)
 			      sizeof(u64), 0);
 }
 
+static void bgx_lmac_remove_filters(struct lmac *lmac, u8 vf_id)
+{
+	int i = 0;
+
+	if (!lmac)
+		return;
+
+	/* We've got reset filters request from some of attached VF, while the
+	 * others might want to keep their configuration. So in this case lets
+	 * iterate over all of configured filters and decrease number of
+	 * referencies. if some addresses get zero refs remove them from list
+	 */
+	for (i = lmac->dmacs_cfg - 1; i >= 0; i--) {
+		lmac->dmacs[i].vf_map &= ~BIT_ULL(vf_id);
+		if (!lmac->dmacs[i].vf_map) {
+			lmac->dmacs_cfg--;
+			lmac->dmacs[i].dmac = 0;
+			lmac->dmacs[i].vf_map = 0;
+		}
+	}
+}
+
+static int bgx_lmac_save_filter(struct lmac *lmac, u64 dmac, u8 vf_id)
+{
+	u8 i = 0;
+
+	if (!lmac)
+		return -1;
+
+	/* At the same time we could have several VFs 'attached' to some
+	 * particular LMAC, and each VF is represented as network interface
+	 * for kernel. So from user perspective it should be possible to
+	 * manipulate with its' (VF) receive modes. However from PF
+	 * driver perspective we need to keep track of filter configurations
+	 * for different VFs to prevent filter values dupes
+	 */
+	for (i = 0; i < lmac->dmacs_cfg; i++) {
+		if (lmac->dmacs[i].dmac == dmac) {
+			lmac->dmacs[i].vf_map |= BIT_ULL(vf_id);
+			return -1;
+		}
+	}
+
+	if (!(lmac->dmacs_cfg < lmac->dmacs_count))
+		return -1;
+
+	/* keep it for further tracking */
+	lmac->dmacs[lmac->dmacs_cfg].dmac = dmac;
+	lmac->dmacs[lmac->dmacs_cfg].vf_map = BIT_ULL(vf_id);
+	lmac->dmacs_cfg++;
+	return 0;
+}
+
+static int bgx_set_dmac_cam_filter_mac(struct bgx *bgx, int lmacid,
+				       u64 cam_dmac, u8 idx)
+{
+	struct lmac *lmac = NULL;
+	u64 cfg = 0;
+
+	/* skip zero addresses as meaningless */
+	if (!cam_dmac || !bgx)
+		return -1;
+
+	lmac = &bgx->lmac[lmacid];
+
+	/* configure DCAM filtering for designated LMAC */
+	cfg = RX_DMACX_CAM_LMACID(lmacid & LMAC_ID_MASK) |
+		RX_DMACX_CAM_EN | cam_dmac;
+	bgx_reg_write(bgx, 0, BGX_CMR_RX_DMACX_CAM +
+		      ((lmacid * lmac->dmacs_count) + idx) * sizeof(u64), cfg);
+	return 0;
+}
+
+void bgx_set_dmac_cam_filter(int node, int bgx_idx, int lmacid,
+			     u64 cam_dmac, u8 vf_id)
+{
+	struct bgx *bgx = get_bgx(node, bgx_idx);
+	struct lmac *lmac = NULL;
+
+	if (!bgx)
+		return;
+
+	lmac = &bgx->lmac[lmacid];
+
+	if (!cam_dmac)
+		cam_dmac = ether_addr_to_u64(lmac->mac);
+
+	/* since we might have several VFs attached to particular LMAC
+	 * and kernel could call mcast config for each of them with the
+	 * same MAC, check if requested MAC is already in filtering list and
+	 * updare/prepare list of MACs to be applied later to HW filters
+	 */
+	bgx_lmac_save_filter(lmac, cam_dmac, vf_id);
+}
+EXPORT_SYMBOL(bgx_set_dmac_cam_filter);
+
+void bgx_set_xcast_mode(int node, int bgx_idx, int lmacid, u8 mode)
+{
+	struct bgx *bgx = get_bgx(node, bgx_idx);
+	struct lmac *lmac = NULL;
+	u64 cfg = 0;
+	u8 i = 0;
+
+	if (!bgx)
+		return;
+
+	lmac = &bgx->lmac[lmacid];
+
+	cfg = bgx_reg_read(bgx, lmacid, BGX_CMRX_RX_DMAC_CTL);
+	if (mode & BGX_XCAST_BCAST_ACCEPT)
+		cfg |= BCAST_ACCEPT;
+	else
+		cfg &= ~BCAST_ACCEPT;
+
+	/* disable all MCASTs and DMAC filtering */
+	cfg &= ~(CAM_ACCEPT | BGX_MCAST_MODE(MCAST_MODE_MASK));
+
+	/* check requested bits and set filtergin mode appropriately */
+	if (mode & (BGX_XCAST_MCAST_ACCEPT)) {
+		cfg |= (BGX_MCAST_MODE(MCAST_MODE_ACCEPT));
+	} else if (mode & BGX_XCAST_MCAST_FILTER) {
+		cfg |= (BGX_MCAST_MODE(MCAST_MODE_CAM_FILTER) | CAM_ACCEPT);
+		for (i = 0; i < lmac->dmacs_cfg; i++)
+			bgx_set_dmac_cam_filter_mac(bgx, lmacid,
+						    lmac->dmacs[i].dmac, i);
+	}
+	bgx_reg_write(bgx, lmacid, BGX_CMRX_RX_DMAC_CTL, cfg);
+}
+EXPORT_SYMBOL(bgx_set_xcast_mode);
+
+void bgx_reset_xcast_mode(int node, int bgx_idx, int lmacid, u8 vf_id)
+{
+	struct bgx *bgx = get_bgx(node, bgx_idx);
+
+	if (!bgx)
+		return;
+
+	bgx_lmac_remove_filters(&bgx->lmac[lmacid], vf_id);
+	bgx_flush_dmac_cam_filter(bgx, lmacid);
+	bgx_set_xcast_mode(node, bgx_idx, lmacid,
+			   (BGX_XCAST_BCAST_ACCEPT | BGX_XCAST_MCAST_ACCEPT));
+}
+EXPORT_SYMBOL(bgx_reset_xcast_mode);
+
 void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable)
 {
 	struct bgx *bgx = get_bgx(node, bgx_idx);
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
index 52439da62c97..cbdd20b9ee6f 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
@@ -30,6 +30,7 @@
 #define    DEFAULT_PAUSE_TIME			0xFFFF
 
 #define	   BGX_ID_MASK				0x3
+#define	   LMAC_ID_MASK				0x3
 
 #define    MAX_DMAC_PER_LMAC_TNS_BYPASS_MODE	2
 
@@ -57,7 +58,7 @@
 #define BGX_CMRX_RX_FIFO_LEN		0x108
 #define BGX_CMR_RX_DMACX_CAM		0x200
 #define  RX_DMACX_CAM_EN			BIT_ULL(48)
-#define  RX_DMACX_CAM_LMACID(x)			(x << 49)
+#define  RX_DMACX_CAM_LMACID(x)			(((u64)x) << 49)
 #define  RX_DMAC_COUNT				32
 #define BGX_CMR_RX_STREERING		0x300
 #define  RX_TRAFFIC_STEER_RULE_COUNT		8
@@ -205,6 +206,13 @@
 #define LMAC_INTR_LINK_UP	BIT(0)
 #define LMAC_INTR_LINK_DOWN	BIT(1)
 
+#define BGX_XCAST_BCAST_ACCEPT  BIT(0)
+#define BGX_XCAST_MCAST_ACCEPT  BIT(1)
+#define BGX_XCAST_MCAST_FILTER  BIT(2)
+
+void bgx_set_dmac_cam_filter(int node, int bgx_idx, int lmacid, u64 mac, u8 vf);
+void bgx_reset_xcast_mode(int node, int bgx_idx, int lmacid, u8 vf);
+void bgx_set_xcast_mode(int node, int bgx_idx, int lmacid, u8 mode);
 void octeon_mdiobus_force_mod_depencency(void);
 void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable);
 void bgx_add_dmac_addr(u64 dmac, int node, int bgx_idx, int lmac);
-- 
2.14.3
