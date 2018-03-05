Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELvWL7RhdhPvUHDqhQHVBsEif646czRg2vVON+BCtBaE0DvJdROHWSFnOtqO+VDdpawY+YJp
ARC-Seal: i=1; a=rsa-sha256; t=1520260215; cv=none;
        d=google.com; s=arc-20160816;
        b=eAb7pXYhqvnY9tz45qgIvWoNtY7lApDjIbcZndEhW+doQ2ubj0DUc7rWwOSO3zA0jZ
         K+hg0/z5BJV/mu9WHt7MPihF2GrbVHiYxlLdkHZl57TkNpRozFLdGneP/3qUzF3zCbWa
         VMwZOttVo6Zq4/F+WpNeZbXWbTpbQ8aJWcA2kcWPe4TlfpiB08LD1AF2QORBqcu0ipXF
         xKhoq0ldJxkMPjG8Uu64uMsLeOlSqoYMK812Wg8jwH5h0jXT3cKR70t1L/Ah5zK3NIHW
         tMS/dbfO1LGw40OGQcIpcY+/J0PYcmonWR498lrfrDwF9KgtDpg/OMUewIsMZoJ7scyk
         JyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=2OAFNmw3S+B7MHLyhnt1RghRAGcSByzwigwtSX6virk=;
        b=h5G88qYp52GdrWSTNqnQbjjnUJjTat/nX9WdqG6rc93KeSSdrIstMJTIC50f2OC85X
         IhNuw2CKdcbM/PW5ICs7ZiGvgSjOBh7psM8GSzqozsrtpvq35PDfkJv+QbVpLP0AP/O3
         v8TQnUuZl5C7+XuWI/UkDs8lhfM9rbwwrEGXAlkdgnWs/1NtDbtZ0hm8/9fpYALE+xEk
         anF0NEyem6vZv6XMfMyMbIfnbjg2xSTyqwt38gDIirg9n6fweqS7XG016bZ5t7dGq4bV
         poipCItyNbB1eu9vMO4wBK9QSug27gn+MYUZZ6rRy20O8cZg7d64ayiiciXPGhcj39eh
         Z4Gg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=OT37E+HH;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.49 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=OT37E+HH;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.49 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: will.deacon@arm.com,
	robin.murphy@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org,
	robh+dt@kernel.org,
	hch@lst.de,
	m.szyprowski@samsung.com,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	leoyang.li@nxp.com,
	shawnguo@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 2/6] iommu: support iommu configuration for fsl-mc devices
Date: Mon,  5 Mar 2018 19:59:22 +0530
Message-Id: <1520260166-29387-3-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To HE1PR0401MB2425.eurprd04.prod.outlook.com
 (2603:10a6:3:25::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 161ea126-d1f4-400e-0b7c-08d582a59ae2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0401MB2425;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;3:s9Q9tIRZave9pQqiQql5XMjb8gUT4v6Mr/QHg9Wnq/PlIxJnO3zyGem3KaMA8lKpAvxSJjL/i5wuZAPAS7zKPQF3cLBzuQiM1NIjo0xHoRcnevbQ9H2voWsqxN3pk3nwsV3rKkteMgn//Yt6Cz4qMgpCTbIxasIbFC4tDnO2QX4+BoWuE9J7/r1NRVE++K+VMGoDrThlWmUQx0W6S43luHtFu67C5hf8131I0vtmKIqagu1XqtVMqgUp+OTZa6xn;25:Pcrwll4ARp43F21hJSnc99IXcD20Oywtf6cFnzwSUg7zlDz8P2pWJkV/mDtCU7NKKcgbygMPJIW3hSOKcntc0hwSeoDCKIOmGfrIZLMd9dCyckqjULfD+wWx0PrIxPMpg5qDh55cbVZsTsFZqqnvenecaNFXKV3aeNp15Vb2HVmdp5l+ATnazuPxgCeCJtaIfVyxOkUJDM/WkchSIEynitbBMwqImvPBfLz7OsxxY2tYJEL6ksT1VwvNuqwa6aKozOzyW4FeUyxqHW8vDd4FUzaKUT9GOq5o8vQ/zN9uf2LmUNhTR3537D0JHzt6HIFaBb0IEqlTVzWWLETFknpRSA==;31:XmJ1UQ/JGUW9htngpKgdQ9rdEeA7rgnTK/pHUl3jpyldbF2MJPSOyVhvWUXSLOObp61bzcvAi12LssV39AIkiiD+sBf0E2cu2lndFL/2Lq68NN74Wyy+5nfpDEuS9tYtdea9AXbVaMZOg6DV0f65giKq+HJDOs8YOG4Gtui0yfPE112Gb/8JYBCHmO7k+g3sfi0qL45Pe2Os6Fqgl0Otjm42N4av8NFDZgxKlCoGAhs=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2425:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;20:NNrzG2p0kdZx5aiep0DKg9re82ui3H3aXwVNQs065IFm5NYzr+ydbJqh3DMs6j+gYTD8Fv+LOcRN+i9JiQPu/OogU5w/oYtuHx59+ScAWcofhO/JwkwwXZg98hYv8Krnk6HnUVzd+vBROP0/cqDsP4rxv/7HaXmMfQirVDiDkHMbVWK3qOSTnWtqy3aWkhhS2n47Xaf4oz6dn+nkDxXEyBtQzLrlztl/zsCl082b2hLFMH/Pe7+NL1586sMC7vJK9cvfSvCjAvczF3hS7hVdHdYaT/LmzFCxwghjQAZWU4Un9pmLxax81y2eLJUA/dQvSTUhft8jFfl5kv6hCSZhL7M8nb43PwEZStqm9ipfYUwvDSph351utt5Kq6ioKxWwyNszNHFnYk1LtNy6AVK2N99Tz7/8JxHo8HMpysBM1QJ7BOF3lZVy0vGlMO2zkLak5x87Rmfv0J1CgZkvINAP2qoL6kj4bp7/DR0ZbnFzlRne5ldyfw1nFKK9ji79JXyj;4:HOFSXS3Qul+O5CO0xieZcF9UJ/cobMfETmnBbunCrPc9+ZbuY8G4jibNk1FeSEDvBknTw3pCugqgxyZstNReeNRZAbcvcsPF80rMdDeoE8gmkJneGCJka4ijfEAF6viZxT9ivY6wR3/Or0IjT6NvDgynmvt7HVWK1uS/uBKKLARJwIBzWx/itGMlvVF7xBHTN8T/H+/tRMpj+GOSwwpzMEVx4jiFXe/pZziZJ3mDjVTy9KYh51o5cm9zzKp0+8qwfjcGCGAt3CZY+uImOlIpzHrtjHxTsL1Q9zXyW4ocqm3aNm6xjwg9X14sEQelq2Eg
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2425261DFDF888D43DFE90B1E6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0401MB2425;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2425;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(39380400002)(189003)(199004)(2906002)(47776003)(106356001)(6486002)(3846002)(4326008)(316002)(39060400002)(25786009)(5660300001)(6116002)(6512007)(53936002)(2950100002)(6666003)(97736004)(8676002)(81166006)(50226002)(76176011)(8936002)(81156014)(5009440100003)(386003)(51416003)(6506007)(26005)(16586007)(48376002)(52116002)(478600001)(86362001)(50466002)(66066001)(7416002)(16526019)(36756003)(55236004)(186003)(7736002)(305945005)(105586002)(68736007)(110426004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2425;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2425;23:ilgeN0jAz67fJAWCN6E7BFsAC/rn1CIslmvb2D8?=
 =?us-ascii?Q?f1LGuUfGl2nCFt4SzbOnh5p7++QZpIn8M8Ybj4WtmhT77rLiijDb3FOIaNpJ?=
 =?us-ascii?Q?ypdSqae/k9VCe21YQjXp2ChNmKkwFvjIK/7j1qje8j+Jaf5QS6HT5xVJNq/K?=
 =?us-ascii?Q?srubOwVsAp37aQRNz+yoTbK65ra7+tuDVL86s/QZ1FGNmGNWQSsFO3WelK1V?=
 =?us-ascii?Q?THU8zP1dK24h+wNc+A5ssXLHVNc18gPNeGmUl9+13ezMMqUng7RcK5nHbO78?=
 =?us-ascii?Q?qYQaqEgFn2K4ONU8yYKG5udiP62syiRGSd99hpS4wuvD6MxQZRGtaV2T+uoh?=
 =?us-ascii?Q?XyzdFJB0VGNvaXY1AhKB5sjguQDMKsX1qA5YkYDuHlLvn8O6lEkxr9pj7As7?=
 =?us-ascii?Q?mnPv3Wi0Y5pkGMRWeZ96jyKv/Zd+5ELA7AVPKFQy2ck5NkeWl+X/G3lqTPFX?=
 =?us-ascii?Q?AjSjmt/7MWt9Y1YKtcXrqDnatAQbxZTA/3DnnEgp4oc7E/wCwZBnaTwIEIpu?=
 =?us-ascii?Q?L3pzqIMlRGgesARApCISOVd0jNnyGfgbIsWo7entkrYnMdGAzbB+6NL+0lYw?=
 =?us-ascii?Q?IrtXp2kAGzNF3ynSE5YH9yZlKU/2Fahjc3Lb1khNA8YW5bxJA0fRUwf+h3xh?=
 =?us-ascii?Q?AX8M/Emd25S2syS2ufJFUBgyKl8AwjNbYUgxHQ2Nn0CPHLdsYvWSa/MRw0oN?=
 =?us-ascii?Q?ofvwxbpK9y1oHG7ryyFHbVodXcqPXx3cpGeqNyj8j7UBWsZy/T51cUhbn/fh?=
 =?us-ascii?Q?G8DuiLeX720GXGYKexL0gc6+W9My98UxVQrPsSpvP005idxc1K0rBhDbx9YA?=
 =?us-ascii?Q?TM2vLmb2oRihtDGBTYgu2qVXE+mYeQ/G+egb69jfnpCcfcdb066MsQ2B0uD3?=
 =?us-ascii?Q?lRc9VgVpt5lagGtqfgZy4kuOX+UHddSGA+ykmrvBL6L9C81KnCHe3lIJBu8k?=
 =?us-ascii?Q?1BUm3Xr6z8BsjzRXg5Js+OX8GJpekDp9HXGKARyKzpd+KMeacH2N6s68f9sM?=
 =?us-ascii?Q?2TZhX6LTjgmFtjETTyT0W5epeuw9vaZP0z9DUYMxb5SY+j++5PooYBXFjC/7?=
 =?us-ascii?Q?BGqOEVGbRmZh7KyjjdpQemfh+cVIcec2HJr+Cgf0nWKupTAdkMdgeMBjXYFk?=
 =?us-ascii?Q?WvNhNKDcMq45kaoEz0obMKV1E+5rEe4zDRI5ErwoRvsqK+yJoX1mPLBwoZvP?=
 =?us-ascii?Q?gWs2o/v4Ra0WgXatvSp/KZ18BTRxaFKxSVCEE?=
X-Microsoft-Antispam-Message-Info: rsHWsBI6R+fC5fSgDsNDWEPAHreVl4OdS5GvaeGH3YNHJcfXX3KXSjqEnmpwOpPvW1BQtU3imUd4pquGu+/hBOi2WhKBJtMMIKUnA8gn+MwmLAftPJ6PrHwgtphJMJqz+3ktGgKha+jKFfIavZfECyAgkPL7tER3kcpgBv/3SFzY7kdAqtUF1ykl85SxWZ0P
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;6:G0r81B3fS+cR4pTqfyMfxx5nKHdegQI1egaAk3ijBAEKJr/gJKUZpx3N65q1LZzQkNdSm7pT0MxM9eYNnQSu+lkXtDYEh0U4Tu6fSjUKlAcpnUQGU7jWgYMUU1Pm8vxlXg8nHzboZMmPpvuh+K4v6NVaf4z3fjN48nV6f4J6tJv0XE6DoI2cAxVprCT3ELLsccSG3YRpeWrEX4RpJU4aRpLNZbxg5el+SEbhfm9FJ8yv9WnUZdncyCivFY6gYogglZevoDMuhy04vVudUXXoLzOt0S2zAZOQe2iCl2yk+ySNIwnbDP/awp8/smUSsApqGJAMpxIYAJrj5CTqC6QTtyQrgtrD9UK/vI2bepAKGAE=;5:ZvmnRnsHIZNbqQxdf0j+t+sHvn8ySsObjxd2y2ctSq2xskhY9ulgcKgNFiEmDnU0/NPel+RjF7ciY1X0eeHUYyiNRo/v1zhJwqIVZB+iR0JmEWuOd+TnC4K/iw0xl5jZsB79pDrF9vzSs2vf2nHrRMyo6G1AJl5BAZGACVKmt2M=;24:GIXyooHHkMEitJXaltBUH9LUSLTC8bXtc1zP7DYlx66cGRe2OC846vT8TebDv16pgDLbTyhDk2QFY3q1n4bHJweGhfEY2Gj/ov/nL1ZQAOY=;7:4O+psvPpBnXxCh9o+eu+WCdMYcY/HDubLYAydt+OjupZhr3Yj8qWTPqfO9U95+6pgZd6IRytRg3TYH6SRoRt89IyOEUKH+IkgMd6bKqFHDFgOIjGcHxYusD/ah7x0ou3NpAvSB2Sm487r7OnpGREr2PbTHH1eryEZsAEGM5XDNhOYbFfllvB3K3JY6oa0BvCgFWRTLeL+sgcGPFbkJGr4U1pvaMpocGPJHYSWQ9s7WsRb3KxX/25ndQ3YKyrOqYJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 14:30:08.6263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 161ea126-d1f4-400e-0b7c-08d582a59ae2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2425
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108376505725447?=
X-GMAIL-MSGID: =?utf-8?q?1594108376505725447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/of_iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b..cc2fb9c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -24,6 +24,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
+#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -160,6 +161,26 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return err;
 }
 
+static int
+of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
+		      struct device_node *master_np)
+{
+	struct of_phandle_args iommu_spec;
+	int err;
+
+	iommu_spec.np = of_parse_phandle(master_np, "iommu-parent", 0);
+	if (!iommu_spec.np)
+		return NO_IOMMU;
+
+	iommu_spec.args[0] = mc_dev->icid;
+	iommu_spec.args_count = 1;
+
+	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
+	of_node_put(iommu_spec.np);
+
+	return err;
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -191,6 +212,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+	} else if (dev_is_fsl_mc(dev)) {
+		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
1.9.1
