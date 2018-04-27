Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZqqstZEiJV3yXLv2iM0KzgrNhFImg1Ky2YFMzJy14+yUVwu09i08c2mkTNT8jiI1nVTanx6
ARC-Seal: i=1; a=rsa-sha256; t=1524824882; cv=none;
        d=google.com; s=arc-20160816;
        b=VlVF/Zt7d5ulA/XvOAnc7LgBhILgDr8tJPWoiAppYJ2mr64/V7jEuxIjJAYrzmNxeI
         mrpP2ffr/7aTC5FDzXmcgAGJY9O/0EAaPcx+m95JLpW7rj6QloUOeA8QLLwlAjvVmn37
         M1KJwNhXoCm//G/ifAYlRqzq90+9/mubUSdL6jrYswj5NBfoWoVi51CYs7o4exGGJiZF
         Iy1aaPZe8Jfnspk2iLzbz+MAuMmT0VN2+CdwFct/1USVlhmWcczEkc9kOCOSPK3i+qDQ
         KaE+4Ay3qzADd/lkc2opjI1qHTVOg6F6iQ2h7CBvC1U+WqCxuimN5E4TwMdLl4J6ENIP
         ufTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=vyhaqY+Sk1z77HT3LMDiRsi309OonR1fbf2wgiIq7t4=;
        b=mI9oNvhkmP3aRa/8EPrTxBbcAV8Gk0P5sP+UX1H2CT6hkXy4yESAAfnmCRPvAFLAMH
         m/78b2pKT2g0ak4YbUJ6qUTMhnhytFcIw6uHHBAlP8HBwG+lW8upBNvmU6NkZ6mda724
         RoqEslaT348NK2EMQSdHSCtEPNCZ6b2WhpKZ49wKZVROjz1L2yvBVE3hKqCr7oKi2tfh
         JR0mJb57u21vUo3dxu2BIDKbeeio5U6Vf61lJdoUmpfdqnhiRHCiIQyvWLbEBR1gZ29d
         /kZp2zvLCs4fCHJIqJdb8ohpBJz5xCOIFaUp2T5zDdPKzmKR+5x0ma1CNbRL+4M9CmmI
         eFww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=gB82GRwY;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.54 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=gB82GRwY;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.54 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: hch@lst.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	robh+dt@kernel.org,
	m.szyprowski@samsung.com,
	shawnguo@kernel.org,
	frowand.list@gmail.com,
	bhelgaas@google.com,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 3/6 v3] iommu: support iommu configuration for fsl-mc devices
Date: Fri, 27 Apr 2018 15:57:03 +0530
Message-Id: <1524824826-29473-4-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::12)
 To DB6PR0401MB2422.eurprd04.prod.outlook.com (2603:10a6:4:4a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2422;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;3:WPlv4XJXz9eClpl5s+w24kzGADewnhDeBw/noimdxwtTvnxEmm1L6xykohnO9asYavyM2Bbqi33LtCjGTH+BGbOyPpb9jY9eBid8YhH+bDrauIH5ZNhjWxawlUoO0pNgPifsq90UHBchYdbaAOy2fB57n/buiG3GMyUhT1Xqgm9rWJ8V2Zrd6ZjURMtVfdyCQNc6EDar4ImqNTdkJWU7mrLnBfaB0huFCxJUxux8XiEZBbAMF1A4sJW5dE+4w0Sd;25:zh8kisBAGRJ6MLpVxJs/tlyE9CLe5aKrbjJQWrQDBLnWD+KGBXCBVk7VXaC1logJNBxAZTIKpzEVJYE6L/iPVtzUw1nTCtoUDbV2hr4SxdIRD6cewGLLviwRTmQTs6ff8Q4aRZmQq5xUqT4g8eI8ZetB+NhyzutsfTWRGblpRMO363SQUzp2o+9/MuBBj7aE5zs2h1d7GX/y8Th6IM2W5Cvx+6VWyEnvJ0ebCygZo4AzOOTWcxPlm34dxObJCQxRSinlTuyUMzueVucpUxSoQo49JRO6EB+weUTPhOvlzffVJ52XdRzgtTTJYvJD3QA9x1/R+zKTRsUqyxuBSRpjPg==;31:HRNbOX8ValqDEcykoVGWpdU7pApcg/IDnnEunffmWCNgf5A5xzG4HHgTFLrVV43Cf7DqOWRlRUKIO4FxDqmdSAJhUaHorkoaHh9gIVz60dfknT75dJBzObHcQw7CFUSGaX5xUc94LBBbV30FV3/zb/P3dIzMR8LxsixFVZB+uioaV5lW6wfpRvpGsSqqgm4YdQKnRFxtyU6C6pgQ4UDG2GGr+GGZ0dpz3f22+bCVmDo=
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2422:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;20:cb7CXJF1MIg5GkveV3T8ugLIWyv/Wqe0YuucARfzMCyGGMn0lz6ajbog1QXhN1zSANHkG3E/lLIg0f48503tMTpbtOm0ncVahLFi/+ICUQAorwb+jZuissuwrEvwO1NJzSlO35AGvXRSjirzvdst0h4QEudWS2CaEofB5mZchHZMu/J78F+2bXUvvIMnc9PYMgZwxGk1pf+muRB/ZKobpNtAnIh7Osv2iNT6na3l+CyykJdh3yQJgUc9HO0hfMBvk19vfbzcuf/WNLXYT27kH7ZXuStxgQz74SfgFgf0stU21yla/ofgMNY1hAZdcC4q8ipKtY06fBl+4jd2sAKQfRF3ZAOJ+p2bV+Yhs2m4y1ajcZob66BDUaMA5eQzSoTNsU9e8LdoFZOQeFMQzJD7DmSy0nFA+SC+uW9HOxkacGwKPdXBW0lYQMe/2ZKtlyPeDh/zBRTgtIvtnXVgFckQFINHk77PCmbBUeaz0GrgJyg5foyChTV3eaOQdCAcRNS0;4:ak2l04E9n4Iikmy/92hFaJEG57gLtYCnIOb/LKHv+TBdmEhFfQqc0n7SsGA5gyGCrYvk6Qnc14xaUUiYUAFsI3ZYdRXiTcfCORaZUQEaXHAds8uZe6vx58/1GqcQ4c3IKTGUT3l8SwVIcjKLBT8C5fvBeOKCxWT0DPxyJ/H9SNPhBH1YqCSuZ516YUZkkq2SM/xqXN/dCrcckOsIKYKVqELu8cxH8GgBK/3TMkEA+Cpa5RhppfA/Oplj5nbjY23CRzt5VNXrTSEAAYz/eXOOZ/iDXf6Ot7aySKgn5xCFWDmFRSoSYFecjz6kc9LQUdnX
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2422CE82BCA7F175C0B34E99E68D0@DB6PR0401MB2422.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0401MB2422;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2422;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(2906002)(86362001)(8936002)(6116002)(3846002)(53936002)(25786009)(5009440100003)(305945005)(48376002)(6512007)(6666003)(6486002)(4326008)(39060400002)(16526019)(186003)(478600001)(76176011)(52116002)(7416002)(44832011)(26005)(105586002)(2616005)(36756003)(8676002)(81156014)(16586007)(486006)(66066001)(11346002)(50466002)(51416003)(446003)(956004)(97736004)(106356001)(386003)(68736007)(81166006)(5660300001)(47776003)(55236004)(476003)(50226002)(6506007)(7736002)(316002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2422;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0401MB2422;23:JMCCFMx2Wtw3J9z9DIXgmjvQ/MMk6U1Nfr5cT4E?=
 =?us-ascii?Q?98DnuRhgGEDj/ZVxuLoqb4sCZySutTtHx7XmNBEsaY2W9NzZX7wV3okLlRJG?=
 =?us-ascii?Q?hIlDhcZhyCvx1P/pX9BWtcTfh1RMtXnPB11/EWw1LP4f2+hOtj9g7Y197CBb?=
 =?us-ascii?Q?8IA+BUBb/XnUHKZoUbXXvt5YUETlIBZ3WnRLLUxliu7PDOEbohuxtViZikEH?=
 =?us-ascii?Q?BbasKUFWWI9oY7XEG/1HZJs4YHvmcaLO4qw8gwPiZ2mBmG+GV4oRP7Ta86Ul?=
 =?us-ascii?Q?JhFtOtFguWl2DU9cBhmbmtYHEKLEcrlcH8XDLiAovaGnyrJW4OSAhDKFiti2?=
 =?us-ascii?Q?9phkmPbf3dccwTecnQl7YvrUTYTvystXJKiNGpSPYOYCUtVmS9iUrcvzDE+M?=
 =?us-ascii?Q?iBH/MIKxTko5NJoNIid6TpH6YnmQ8XZjrlaAFu7W1rbNJOJYSp5NmJmIn9iw?=
 =?us-ascii?Q?3w4tGDQceZZOaCQO7kCbQoHGB8MysILFmbVNECd51DjNTb2YJqESeDWJhXTO?=
 =?us-ascii?Q?Vn5QP+wMN7XuNtbGXBdslWk2cYOqOM/8cmvLSWKDsqRZ9wiOquu1omA5JPpY?=
 =?us-ascii?Q?Z3B3BxjiuXTkfnxZplAJVuaZxY+//+5afXQDuagunMEUQ4QG9ZK7HVBhSSH8?=
 =?us-ascii?Q?rF6cCSL8aGkVn4qGXFaTPAOtWMIsvVZ6OqzCOLsoRCTCvmsJinOPRIib0sh2?=
 =?us-ascii?Q?8S+A7FiUi3GG1giotx88Ol77mHVHvD58EfLSUafY+00I1TZB21k4XvAsNxot?=
 =?us-ascii?Q?aTK1VE9stikM7Mrhxnzo4YanV+dZJ/FvDuqHAHE2TSmedCUrEJbRsrwKWyPA?=
 =?us-ascii?Q?yRSsiGggz999EFJ8VOQCLcd5lSfef3N9AGvolRItKCKZoLt0KkJasr7XEf2P?=
 =?us-ascii?Q?sm09ZRsBygaDO/8TeffcBvfGnjp/HI3OWt9Z8EeA/RhoDqNKFCtMWXfnTlur?=
 =?us-ascii?Q?szHbmlSTmFiLKhCF8kwK78nsagtUiAMqSjBfGzkS8WXNm3wcOhGoS5WqRKKt?=
 =?us-ascii?Q?awNedUqWkkXdIuf2r+lCWGmwYpgQE+6I8+JXAVlzZ3xonSM/9P/9v/IB4I9K?=
 =?us-ascii?Q?0vvDE+hiTJ3zzcrdJE2Rd516R5YMn/hjjvkYebyHAzrwiwHFqXOqEJpQdLz+?=
 =?us-ascii?Q?AwTNzMs1kBz7fYgR7/f5oYDWcrcMjnN/TsowuHfiCbD1oSvrHlvRzbsRbccv?=
 =?us-ascii?Q?snCuhVRi0EVkM0lD1tjC+Yj6E4KLRclaHtKg0zscsObNvj+yzAUcIxrRtiwn?=
 =?us-ascii?Q?QrimVQ82cNGOMJxFCLGkuLnq2IagyfpjvLvAzZMOeKbImjvu8hkq6JzTD7Ka?=
 =?us-ascii?Q?ZlsvrqXtokg3KtyDPwg9xhkQ=3D?=
X-Microsoft-Antispam-Message-Info: YEmEm7XzVV/s3falaMQi0knVRH6KWF8+akFmKg3GT3hEiV8Q0dQB2u6nyfESD0bzfSoVulp/OtPK5GRC8PAkQWvtf/wCL/hguYmNotjkdvGi6bvtOfnSmxgyNUL+6Ugr7LJW5+GNkskttzN4pl9Zw57FY3R3fyfN3pFmPzuiJrk+Dbrr4DfXdbJiV+W4d6lQ
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;6:lpAYKr/OSvgR86IDvokhBwL0dlmjOtDybUYIRs+M/nlciKiJ8alQmHYoESfkhPgX5LRvmQFG8SecBVcG7spgbJUu3QLfkE/VSxTyGUkBV1BrPvheyHqA3go75Dqw15F6ETvnRw1N49H/txoX+HsfmRvjScyHntoiDTsqfKI6nAkCGhXosrsRcA2PxWHYriXU9/Athro0eyr1Ow4pGHYAfZkWc/iVC+QnTlhoWYU/tR2jTpRCXcyRYihGX9ACRKVlJEYXYLsUnnA2eZyw8XRExrzvLDpjY5sRUbIwWBRX+MPkrsrFaAd6T4Mj6GnjpYc2B2lwXZc0d11Vg7aXLcCyTFZ3fdSHNIaQO5quCwhscoSEZRN/D2vfXKvjLPo4yRofmxTnOcb4kfRw/qB9Tu7YhrO1zp6iBiKi6FeVMDYrZciM5ubQgT+twv0L9RhTLS+/bYIvPieXqjRhwhU7HI2n/A==;5:EvjITW41f1plwUXEiuN7A+p2JTJg7fb/iCFUJ0K5l0934v0a9S32vExXszBM6xe4P3Ub1NLMS4+7ggLHYM90XAhNpQqSCE8Twod6rQLtAio+SoMcHykBq5juoEYLGRyslTQhC0ff7o56dzbEcZgQmv2/JaPXiMmJUZ9nFDsj26U=;24:vFy9u8cRY8fX4ufAluMvY6g4e9JTAQuXFAAQgCAKxOp4emiEDaVk84dqCZ0A5XkTVy3cu1wPJpmgT4vFiwQiO7TLQE13hPPig8Tru+KmIrQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;7:ZV/vJvGbXH/1W1g/dYUm+hDYub2b7PfaQbdpvAJAhoZQACp+YvdhuNjC4pawu2dhyROLgJRP2iFr9TnXQP5S5uIGO7MHy0cyCKCzdnAJT3KfYcpc+WipcfVR7vQL54EOtWA5rtMdR7m5INzpTOLQtFr53i4mtT1CmCKBwcDBomRBH1e+WvMJlzl0Kgo6JChvCC2GPvY9i2RydwRT6VWfR8BZcXMExYS61bTcj7+3bXiq8UWdyZinOdJQOJ6XO3+/
X-MS-Office365-Filtering-Correlation-Id: 851df3a5-96ef-4760-51c4-08d5ac298bff
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 10:27:54.7851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851df3a5-96ef-4760-51c4-08d5ac298bff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2422
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894775327119081?=
X-GMAIL-MSGID: =?utf-8?q?1598894775327119081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/of_iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index ea9ecef..3687882 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -25,6 +25,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
+#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -160,6 +161,23 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return err;
 }
 
+static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
+				struct device_node *master_np)
+{
+	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	int err;
+
+	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
+			 "iommu-map-mask", &iommu_spec.np,
+			 iommu_spec.args);
+	if (err)
+		return err == -ENODEV ? NO_IOMMU : err;
+
+	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
+	of_node_put(iommu_spec.np);
+	return err;
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -191,6 +209,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+	} else if (dev_is_fsl_mc(dev)) {
+		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
1.9.1
