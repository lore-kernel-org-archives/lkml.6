Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZpS4X2RovHySCMmF/sSNIHpkRHcqfYgsR8uoX4e+ZGV2tdfKuMKkG5Y4SnSM7szg90w86fG
ARC-Seal: i=1; a=rsa-sha256; t=1525069730; cv=none;
        d=google.com; s=arc-20160816;
        b=jtCD8bz3B+IIlx7PKtXAi7RJN51GcDKe5IZB2DgfsQYnzVKlyJ8fiu8BnZ0j1XO9Di
         tV3Uqip+dllLbhCC7l/dlkg24oucvQ/OBf09c6x+sYzxFw4+osqu5Z5N14szBHJb9Nba
         qBSRBJJQDn9oCqrVYFyNw6WALSX2lrpmfkYXHwxZFjQU1KeOKhkoU0VQG0/NXYav74mR
         wtkCV2vSdJMm91rQ8JaFJCYgaSjd9zSNzQugnbBL1Th8LZbPj+HlYPueoFjvnXBJ+Wnw
         njjrw7XIRkRA0SgvJrW4hNlvj/TM++LETAz93fohMeIs1flaA30OzAyCkkFcrIAIVKFW
         Avpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=1+yxw6S/vp1VSFuGYRtrGi5r7mrmL3b9MhCxyfdDNnA=;
        b=p03a0ek7J4HGlC0bhmySykBNGFJttepbRGq70EuJPXLVbgRO2goksRB8RIs/A66219
         XX98StKUV6kOEWTz0z1tV1U874nhirLQJRjKu4ctPH3RZ8WXB1bMT2+GYL9rVIMw0vN7
         iBtBoJw+WMRY6Po75zy2GTaReLhzp79A29Jxtf0tbbHfLC/ZiHPCQhK/z54B1sbcQ2p4
         uIIN+cGFpyE4hFLr3svsnd0jXwsusvxAEoViygUkdnldWJcH0qDLp9zyYFsWeq6hfuWb
         NuhsxBKI3IIvXXxdlx2FIJyqU2nq8efYOhqyFNDaRJWuDIOkHXKGXd2YrBK0dH2PZVVU
         OUiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=L2SADwCE;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.56 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=L2SADwCE;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.56 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	will.deacon@arm.com,
	robh+dt@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org
Cc: hch@lst.de,
	joro@8bytes.org,
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
Subject: [PATCH v4 5/6] bus: fsl-mc: supoprt dma configure for devices on fsl-mc bus
Date: Mon, 30 Apr 2018 11:57:20 +0530
Message-Id: <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::16) To AM4PR0401MB2418.eurprd04.prod.outlook.com
 (2603:10a6:200:51::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2418;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:pm4lXkYI8OL7YQ8QFHdgJ6ZqLSpv6JuMaa3TQDR680IXCy8D9HH0AAklIpB++bEz8+5jluZOgRH1Legjwie5SyLLIbdax4ArlAXvVCRL6F7q94p4BUSlnmlxCCBUiP3sL5if2KO3wPShO85ApnIK73u/b7C0AtLzx2CLORrbX+ZD1Z9Iy5YGKSLnC+lGtS9B0raJ+wbYrrtBEmU2mX2XcmTOp0CqR2HX1bEdKZiWvbGZbdqqmLXxK65v83qVIhEd;25:FHvGAqoerhuA5EVam96Xog6IvLNukbtSA4Y+xhW3CQY6qpVlyg3pUMdO1VunsogWQ0cT6Ltv37MS2NeTEY8Q7sBfnTMLF0E2j5IIcKgCpZ8YVSIujK9NoysyydiG9U/WirsNlm+piHWGU8WlzF803LxGp0/Ulq6mc+NYxJZ2wSvtL8YxyoM1KKX5gsVM+2LtS9Y22JeOXAaTpob/1lz1BDdY40UBOPhJqAoZc0N3W0Z9oo/xt/PlnksIit852d4NSKdhvInuSYXOuniXX+Vzf/8bhYYJ2lLbs/TAFl7nAw+x7vSTuaeqOua/cTR2o0pNd3LjTLgDsfwTU/wCnQZyMw==;31:VtebWMOSyZheRA5x5trJYNRU4fMnjh/qLt0Hh4QK6HqjEjLJOTo8hM1EnzW/btfLGGVdLxcF52VizJZYaG0Rno6i5FMGG0Bz6vPophoSMogKjkZBiIbQ6+4stuYY3dHd6JwxxjzESoKvXidRtRWm2/n3CAAyB6LT3UzBcB6XeG/xt1WTHOKaSTlN+J7kfMmKirlHrY0szVfozThr0HJ3vG+Wb+L74VwThVElgq2ug3c=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:SzbYAFN39gPXxFULs+4kwiYeZig6uiwILOuVXCvRkjDkBPka6mZ99n1JFDy+egrP4/w6f7o3kjGVG7qROYr+5VzpkHa2QY+P+QTlqSB2XDpGyirmQj0a6h6b1RTb+3owBpcePYCXlsfco5VPki9ch6zwGMmMEj229UgaHJccyExIEhDIQ4BCjibvZMhzAFkpOe7wMmijgD6x5ub2OajtvPP9M7GWev2ftpBYlapotq8w+FcFGHWOFZcNPjuVRz6+03Sfro+U2zl+Q5fkX8xI5d4psjYFbt8PjBwXOpztF5heyI15l1gjWGtGpenvtnFHPFEAoCezq3pneq2j5OAEpfmr4f8RSR81FQewr4FI+B0OR/bdIgrmmiIG0sr8f3VBu32dxrENpmOMnHxmYwmO16aGH7eDu0lTiKCzZYyULI26ofSMPkg/PcnS15n6RBz1h/0UUXmq414HUzvbcfHJdyTVTkHn9kyejkTipVelbOr6G9wurq4lp+6KIWkHvwnD;4:Uiz6U9CRHGFCojOmB21eIstC/QNwihzlWYXdxJdt1ScKphoeVYE5M2WuxlcsvTI/ZHCpLRlHh8pfqYsyZL6Tg4d/45VuHrfIHUK5wwfBpjNmxEIhIscinN1GfdDlZjoTNsqYFtPPVWu0JqErIOYQN7qPu9gYAS0jt24v9KTKqMtKlFAveXYKXIGJJzitVDsS1R26b9crHoOURrE0AwoSmiE5pCAMjM/DTeJuiG7ZRnf5aBxu85qQwS+Vo6F0tnp/MLRB+mvWTWlDKHk/xbth9p45WHslfqhzXvyef54w9PEDJamky5LfMMCCisnxj4ld
X-Microsoft-Antispam-PRVS: <AM4PR0401MB24182041D763801BACBD703CE6820@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(36756003)(7736002)(52116002)(5660300001)(105586002)(106356001)(486006)(48376002)(50466002)(316002)(2616005)(55236004)(956004)(11346002)(446003)(476003)(51416003)(16526019)(186003)(6486002)(76176011)(44832011)(47776003)(26005)(97736004)(5009440100003)(66066001)(86362001)(68736007)(81156014)(81166006)(53936002)(16586007)(50226002)(2906002)(7416002)(25786009)(6506007)(8676002)(8936002)(478600001)(39060400002)(6666003)(386003)(6116002)(6512007)(3846002)(305945005)(4326008)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:8iD9DrUdStHtfvpZxAqMOszidMBUpjMSZTofGcn?=
 =?us-ascii?Q?/8VyQCsQs3ZgBk+MBe7IZZzEDa9JiI07Nplq/EiXzS4TDgBOqqoczPq/Eleg?=
 =?us-ascii?Q?Ukk/mkOCA4eg/kBJLpZFE/PKFYOMOw6Ln4tj4sA++HMxwsmRDiQGtVK0kAmD?=
 =?us-ascii?Q?RtmFGC2+8DOKzeGyKLzBQnTNWQvVTDwRhmgUdJYBZa3Xi09KMB38Oox+/oKF?=
 =?us-ascii?Q?WIKcTwzlqYb6rx9/i8oGOHRTh8PxK/AccZRWqvBil7TCXDcrjIpMqwE8aDsf?=
 =?us-ascii?Q?l0QUHn1aaB/AcFOvfCiITtRDU+F2Ml3owFkBsiH/+IkJai+jHLNAjNwG0xDo?=
 =?us-ascii?Q?8p816npK1tijdwStgOyVu3mFhCt9Eb36i60qni1g3IaHvJqzH0Sm5v/BtPrU?=
 =?us-ascii?Q?ZKvIyLGXgUgkrM5R6WmKiip1QW1eRpZElZmvGF2m5/HOl0wKRvkGMKzADCI6?=
 =?us-ascii?Q?iNuCiFibd6S+5Cl9rtFrsEMcP3yBnSLQs6cwFNHAkkhpElkA5/FOAIycvYpD?=
 =?us-ascii?Q?A6bYoApSKMXzN5hyiTtSDP7N5UDJyP4Cnkg1gaFw5CyqDc2hR1U04AD8BoY1?=
 =?us-ascii?Q?KQeTneWsAOO2NycIiEgeXRC7ol2n9Pbt4qJvmrGQZ6LNMa9BRTItEdKTQUMh?=
 =?us-ascii?Q?FIFbK2Y4zbmcA68RQdqQIbboeAn0j3A+aytLNOURVaE568mc2xeaU9UuYuFp?=
 =?us-ascii?Q?7EjlLBow7Zjq9jO4s7rquXa75ZMBzBQWO4Aj9w6D5oT2J4jkhYe/ozEx09qX?=
 =?us-ascii?Q?o7vnKnvg1OC9icCfkjh4VzLMB7sk+Q8+ClBnMrK3bUejVUD4UrxJD9dfKNmv?=
 =?us-ascii?Q?WHMj1oePndfMaD3PKRZL3D0TOKkePtr22i3wmy2F4M3eVELQiNBrSOanBQxd?=
 =?us-ascii?Q?uYMKp5kdbwwNNyNyYpUJ50oSlMfsnLqpYfqcDOUONGor5pYSa4Z1fAFiUzlB?=
 =?us-ascii?Q?fXr7YufVUCXOKo9E45CLMFDi4OfB3DvMXyd6NrHL64R8th6aHIEz56MDTMfh?=
 =?us-ascii?Q?c9Epi+iSUEfERwWIta+aHP6zF/DQb9T4FrkMwfkNH+vXYnZpXs8a/MaTG1np?=
 =?us-ascii?Q?mUDRzfDNaIPRe+kgeeu3rmzvmW0cPaxTXU5K8AO/ryepzOKalVW6wRyHF3/f?=
 =?us-ascii?Q?V0LKIL1qUsPV51aOdm35tXoViYUpEj8qJu7sRi539WGTV2hvFG+T9DcmzOTh?=
 =?us-ascii?Q?zaLwkPhKfmCmZP1Qn5K0b0e6u+8GNMYQ8PvsN6KtaStkODeuJ0BF++6uXI3w?=
 =?us-ascii?Q?6HcIwNkAv7pc553HQOKp8PO/BbrHm4MBiV6dmIDEP7/cw1W3rHUcUJGQ11OZ?=
 =?us-ascii?Q?3RgwMoDOamG7RO1+COaxf+ak=3D?=
X-Microsoft-Antispam-Message-Info: c61EvhIG3WLw9DjqdsuiiYjc3zuYLIhDQ5UYvxi81RtjgEOGZ5V83ni+CvJ4Iq3GCOrLbbxl6klOughF9sd/q/LnWHDRDPBJtc+f2jXUNLhBlMdL5EShDg1Cd67ABjA0kM3ldCIowgG0R2EK1uVAJwtlUjueJv7OKj5hYht6a/h/tS2fXFTuOFU538ugXq+9
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:mD5n6WRM/926ns1uFrrUxxpH5tPQPq30SqEkS8ztDFtFePjV/0alSmDBKM+1ozAFQhboo3Hq8x33NXzcNrJmIJMV+XTb5gFe+RhC8xOtTmOVYQza7v2gwFevz/h1S3/Yk93Hl4sFZTSHYz/uEQFg0b4qKDFldPZpquHv0LCJkLJC8qt51iCTXM277C7sImr6WMjQwv5ukwyvLZAd5nfgBn8pcmDaLSei+1CikvopTFyalKc18rMnfrVCQ82wqEv1gsKLVBpMZ9xC5JPHfjiMboYJT6INTMoPLu9+GjSpo1N6zF/vmXDTmVdkNYnJUnAdWnbrY2oEDXRZSQpSUzLMm/oVDTQUC2LeEUdeLksHoyO19BNglTU3Vb/ykvNK7sjjPScZht3fzEhJidLUupUh4S9tQ3UTykAftAnmpfpO6s0QCPJo5PXE4E6TD3ongE07dwEPMAgF2bkDfVIIXqXjKQ==;5:Lt35oXxq53fUTjv81qYU/zPnb666IIbJz81ULONPy8xBeZ0DCt4VcN3bPZxi2I+O1FxZzxa4Gvs340qVgInHbsSFBWXcxl+SwtZYvkvnYYd+5ST2e63cYsHEHrYWVjWiPr5b4K3PwT2EEmTLUzVcr5rdDs2e4RTwMJsLNEg2vSo=;24:HO8rN2HM1tw0bqhGRsftT8OWwiTLEx69VcQKrMt+YYBsnh69vG255Uvb+h+2JKy9H9JwUT0uJAM7SiBQH9jLvevdFRodU2zlL6XN4mtnIFs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:jnJCa/HmhJLJQi9ksDg6x4Ih/rxywORNi6tEzITbP125m24nirrOyZojsU09s3OVvsewrs7JgmEel8nNy+9dZ2m7t4jo7mk6QueijCNos/06noSV/bwQV+uaXNy158fEIyHGcU7jXLZRJFQnxC3vnSsMUV3JVWxG+4Cg3bH+33aCCZbayLcgDxA7T+1Jt/3zuxHvs6uXP4EqYlN3PREtbbMKHK+S7vpo+dwBGGI5qaRJsOKFL0DCZPnYYymZpCRj
X-MS-Office365-Filtering-Correlation-Id: 5b2e770a-f03e-4f7d-e4a1-08d5ae63a0b6
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 06:28:42.2284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2e770a-f03e-4f7d-e4a1-08d5ae63a0b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894785673525346?=
X-GMAIL-MSGID: =?utf-8?q?1599151517993003779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 5d8266c..624828b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static int fsl_mc_dma_configure(struct device *dev)
+{
+	struct device *dma_dev = dev;
+
+	while (dev_is_fsl_mc(dma_dev))
+		dma_dev = dma_dev->parent;
+
+	return of_dma_configure(dev, dma_dev->of_node, 0);
+}
+
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
 	.name = "fsl-mc",
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
+	.dma_configure  = fsl_mc_dma_configure,
 	.dev_groups = fsl_mc_dev_groups,
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
@@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		mc_dev->icid = parent_mc_dev->icid;
 		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
 		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
+		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
 		dev_set_msi_domain(&mc_dev->dev,
 				   dev_get_msi_domain(&parent_mc_dev->dev));
 	}
@@ -633,10 +645,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 			goto error_cleanup_dev;
 	}
 
-	/* Objects are coherent, unless 'no shareability' flag set. */
-	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
-		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
-
 	/*
 	 * The device-specific probe callback will get invoked by device_add()
 	 */
-- 
1.9.1
