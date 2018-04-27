Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZrEnzJCt7LgnnzZ/RLN/p+9Nd9pN6dBo4iL43P5gbAHdcVCmviZFg5pmfEvkFqcMz+xC49j
ARC-Seal: i=1; a=rsa-sha256; t=1524824892; cv=none;
        d=google.com; s=arc-20160816;
        b=LHmZbODxa5KcjX/B9agkJIrQ2Myt9t8iud8PXFPRSEzl1tcydCp7UZwtjZs68UkXTe
         u/7tmdyR+c9YeSMkTfqd/XXwtW/R5JzWmZIzgaUO143CvjyVMqt4VAZzaGUe0nWfxlOX
         BOwWAdAMMgJsxs4osb0EuvnapluD8d+7mhvNZl0aa1jMXC9N/yI4KMVud9yjndt/zarV
         XcDUf3XRqGJ5CbaTEhIhKQ/qF0PgCzLpbfedfSRJRK4Dthy3BAXBlmFYQ0/AuMF2cRps
         ApjUd/g8gkvKygiEY+TfGWM/cs+iuuEUzxyCd5O7Z/gZxKTTttu4DIC6y+ShGn9QNGxx
         TscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=1+yxw6S/vp1VSFuGYRtrGi5r7mrmL3b9MhCxyfdDNnA=;
        b=OqteHqQUvVEUlB3kNZPCqUHpZyZKAjFB+Ww3hDJzrlVAEc/7JocuauCYejfY5i25vg
         lYS88YUfDVQXB2/4UimSkWntiFP+e4kzsFCvV+qjlWJYOIs7JjuP4+iOo1kBLYwvqhTt
         bBeG5sSg/Ipc0DAbppu/8j9uOJ0Q3NSL3z8Yth9lLqMtkj+9JUnCq8A0pIAKg2szu/Ve
         RC1qMqdf5AbZb9BI9a6rO7Gi/XBoDEH4TEdcsc3BXDeeNCHhrHFwnMR51RFCNJaV1fQI
         63RkKDjM5tfIOXfuL8DHA6nJTSKOALOcEx44sjOP5hOX9xLAtJfMeAupfKGww7J6KExq
         KSMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=bvRFTbgG;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.64 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=bvRFTbgG;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.64 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices on fsl-mc bus
Date: Fri, 27 Apr 2018 15:57:05 +0530
Message-Id: <1524824826-29473-6-git-send-email-nipun.gupta@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;3:PxWKvmoQoXfrcaETRVcAC2ImioxohkwB6bZFXY1MmyGkcUoTX+rADihjIW3CGe4/NWIseUyX/Q3LIcYcrqyGWqt+bo1MGCJyHRNYVCWNeXUelLj0RsWP8XcNCPvkRk/KQhRaX59tz6H5dCH/tOcL6cHE6NuIC3XlyFspDS2/ZeQfUs75srlfCyymjqph37fGNwdpIE5vvZfyuvIZaX2HhBMkYqXnqLtb7zT8AmLyYYMBEddy0IZmBpY7y+osz69a;25:xeYFH0fG87YLn/wjmL3DveYSEnaZjzSotas0gYJzRHCqboFramoh9jck/jGVQYg/0INnML+0TtQR6OeXd2Tjglndl7WNfB7wyqFUppjkQT/or1uTVLjTystfUnMcpgrhGZzlpsASc+misgPVNXhv7JrYu13Ej/WNswR6of3LUE1wsq9C0eVm8M1EdM1sy8dYCyj5dtdUHYhKPPtG06mhme1ivyhkgTL5pnhVeTv8pMgafSH54VQSvU1HoVzB70hNJVsAXcS2Gwdz9O71lnRYVXLuxVY9rQAEPZI4NFC/t14J1LvImIHv+y2Zy/yLrSiGBHJ+VFjI40XwO7RPYbE8Zg==;31:/BxpvvUoVBPrbEpbYarf8OuYOqmnzOZqEbsreMEzE8yKRvKj/yFd/XUAQ0VcLedFQHFdywLXhGxKaz/8b7fQmxndUoUaQtKNVW+Djc57+y4k+VRY4acLcGZ72IXPICEtg54ltYYSHm3RjIB75KNt/heh1ZRQojbMZkFUPyQa+GkTwj+e/QjNfcGyeCHhYIKaWrmnnptUtinrLf11hH91PCQm2OBhOgvlYOSs/U9hv+k=
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2422:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;20:CoG2fSrSTt87yAqvYyQyVXN5i8tfvJbtGMKBfjEJeEbWC9PuPzxxxQ+tmN+xS/aMHDC3CsRyfe6nr+o/pFfQhlWxwuFOg9mRs6bXMEEBoNDG+zP+v86iRM7k0I6BHCqtmMxGbcOwDO2S0Q7w2+woKF1TT7WspSvMR0B2LFmxBY1ZHLKcbLBLmZZ0ViZAUGPItKEplagQtvoraudmFZh2eceduvxWZJBHwaM62hnwMrBwcjsLLLTYBMVzhbTMIpdK/h3LUO2Ay9GCzRFTU6fZvuVArdfgTIXBpaBq4lXBy6k9/YIPglXvKRfdwtM17leG+E4+dSZtJJYj7aYEY2nVR8P0ueJ+ido0fVBJD8BNzeKkrMzG4os0xLzUJxG27UZLVZg5opS1wodbgY9bBoTuwmjdL9JEdF0GTBlofNJyLJAXUtrHaeWEOH3VW6Tf/S/HGO10NqA5kWgIrLVKtmmW7ynQLfalb58yWQVp+x9ngTYW3u6kK6ZtV/vFsuKbyGz1;4:irGkasZctZptfOg6mNI9B5WjYzPd14uPDl920lBNIzXtF7MxC+JegAUZgRJLzsiWYJC/IcfkUBKyE/GU0BLeGVzA70I1BVQgDDNQ0luTBVj/StIzePdFz0u0EHW69XhdiztESavNkL3xxNnLwzfSi6dkGTNHWudOYbBsGw8LlxUcbIYlcjrajbHyx1BIm6IckLiSbemmdOiLKevXMDaVwuXjjnDMuvMb4Uo5d2h4tewr5ul1T4ysqTO39ZpMJreh5LR+4gHncgQHlwmUnsG5Q/WaW9rVp1iU8fmkTqztT7S23zJtlybVV4Iz12laU7Qq
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2422E2387EE770B430842A08E68D0@DB6PR0401MB2422.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0401MB2422;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2422;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(2906002)(86362001)(8936002)(6116002)(3846002)(53936002)(25786009)(5009440100003)(305945005)(48376002)(6512007)(6486002)(4326008)(39060400002)(16526019)(186003)(478600001)(76176011)(52116002)(7416002)(44832011)(26005)(105586002)(2616005)(36756003)(8676002)(81156014)(16586007)(486006)(66066001)(11346002)(50466002)(51416003)(446003)(956004)(97736004)(106356001)(386003)(68736007)(81166006)(5660300001)(47776003)(55236004)(476003)(50226002)(6506007)(7736002)(316002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2422;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0401MB2422;23:Js81Vpk/MeEJXiTUnd2Unmikak+qYIr1I9+bJJP?=
 =?us-ascii?Q?iNLL7C6y8JKgOVneYyh1dKxYQDjsC1UqjGiDtCoTB55+7yCWAjiHj9utvGaA?=
 =?us-ascii?Q?i5jSN5f+slUjbVjn9ydx/2OYKNRqHlF6pCWWEZmKSRXbJuel2WSrGxTK20OU?=
 =?us-ascii?Q?z4u6lZKNuh4VYlD02XG5EBIy6DLBpJZmgxIFy3DqcqPE9YEwQ8KKd1dbAHZI?=
 =?us-ascii?Q?6aa+MaCDyideJkfXz6H0Hx+uhHG/DFmW4qHLP/juOAHZyR5nmsQMHQocHz9R?=
 =?us-ascii?Q?mDZ0Ai8lfwaMTaV1iEM6NmoBN8YenhwaeRAvyy3tAosKz7In9FgGk5vFeo2X?=
 =?us-ascii?Q?avhfIFuYiOZ/kp1Eksyj3XIIm9+N9y70bIDqE8YhpCf9zQmmucjuSQ7B963m?=
 =?us-ascii?Q?O2Wrmt9zU+HM6VCWmWrt+4s7lBY2/Dq2OZL9WcltpPml5doZnnWVDgkISCF/?=
 =?us-ascii?Q?RQ+5A+/Ky/DV4guXidSAwYmjHqR1iVZKfLEoWrb5kLKNELWxiwt8WARB64YS?=
 =?us-ascii?Q?GLw9PgRb/K0aqx94qFLEwV+F53ZEHwCw7DIicOgdnUNZk3T0U8l4RJfl6+xn?=
 =?us-ascii?Q?VkIVj4wlTP+QMsEUoXPRIuiu9e9KkDUo3V6W5Q4no2Gx/rt9tTI62i+OCL5K?=
 =?us-ascii?Q?HAOKGynKvPkdiCDAxKie9Bny528Zhb8+gds7cE75FLLRyqexexnv7u5WVea2?=
 =?us-ascii?Q?LZrQ/75siYY77Jp5LeNWqsfk2Kqp2jz13lATv3qWiuPvhpSFHRAroCoHm2p+?=
 =?us-ascii?Q?eVVUIH6UUhOTgra9xs8tWizjpX1bar5Pw7O6TOXwX+5xnfgODEvy8nR6X/Uo?=
 =?us-ascii?Q?az+IExckemVm+QscRR47tgBJK4GHl+eVgpZ7c8H1lxT08P+QEMAUsmL82NYj?=
 =?us-ascii?Q?hwUoYMTWcfFcxy+S0bzhPGgxE33/y/gbvWFNhsT2H78DB/kw2bGRo7oEtVq5?=
 =?us-ascii?Q?4Fx+0KB/LBQQ0hygk40FGkIioIDTuF88Twa3dy5rC6wxm7XSvQAjwNh3PRKU?=
 =?us-ascii?Q?jANGQYDlSmcUWVNgBftdD1RivTyVZ+Yjs21/jwqoJzZcAI3/gzRFbEhUFgAp?=
 =?us-ascii?Q?JjtvJ5AQqFOqJJeBzS0Sbar+xl5mMqHXU9Nm2rciSjbElrXf7pHBepqWOy3P?=
 =?us-ascii?Q?lRrEXF+Nn33cdp5YlHA3+XTZoJpN7Bqw0fMBgOBEh+kblSn2H9ijeC18mq/l?=
 =?us-ascii?Q?+YkDAQ8iS+QxUk2LiPqNNeljCuer1qmGx6Q7D87igDtBh1qAGskOASDySVLf?=
 =?us-ascii?Q?h1j9ZC9ff+TxO2TMEcpADiIWxU+w9npsPTea0ihHid+bdpD3RN/Oq3ZlWFIJ?=
 =?us-ascii?Q?pBw=3D=3D?=
X-Microsoft-Antispam-Message-Info: j3d8FwpXKB2yjRjQzTcTAabguUEYgCgMvmOsehWoHHvV2xlDSZZB01Faur0gwCTFMjnZ1el/kZWK69EgsJvKWjb8alNoG+zjmLQ+j8t6fkaBdhOXQ29ksiMm5inKPM6td+VNJXJiGSke7+pz0ESWJPMlW6k11yrODUGEiDBkIkm9O8FacNH+l/bFkGPcOmL4
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;6:23L/kjYNGIq4TcThioh6vctPpkrGnqsGLVA8F5f9ptPdq9J75MCRJAheI/7lhSziILJexBXXYycwVsvvsENt/XpR1ZDFX3uPnnXVal6VB6SdvUnnQbyCZzy1IsydQmsTmns20fAV5B62WIH+a2+DDFEEWsT7DVI6oN2J1y/x42T+UlORR83d2TG/xKBv3pIvztz7qCjsJKTlBPV0svD0x49a98fnKt7ghrvZDWQW/hgCFvr9ibc/msUluZ5AsbdTDIHfq0gbCgOpYYwcgDy3FCazvSsMS1rdY4sWT+qsYEREGWTaFMj7f27762RJep29Kc4RIHiUgWo4Br2idPpCIEk+2gZRLgG5951nADqQw4ZYlbLjG3NyJV/P8uEpwV5CN82QlTmO+Xas3xtNrQbxTdPI6L537lEY6PsDsMyp1J0+vbv3v5S+et+LF0Wq2rRysWsUpHwwFbwTjaRfg/3i6g==;5:Av3w9atSjC+iM7XqeV9Xc/UUaSriOZ9U/Ra1VgFy40/OuaklaEflAIzRYsHRFzeNXN+so2ZTPkcQ/BlfxwD6Py96twukw8MAzNXGiAMR4+CilTtNp0Dw0G1pPUq/eKPjNc8KZJedPMpOQJV+fuiGEPZXildyu0DeaLH4POjq7B0=;24:PwKCnW8X+QpG1+qZIElY6aYYiANlmLE+4u+8B+yPjHo5lQKimj6WgvQfhmhpKKLvw8CBkOBZJD+VOz6dd61SdupF8UZ1SIvADXkYuv3h4ws=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;7:j3lMNVaDZhjIAYNtr47XqUo3SyTAOkTp9qyAMwbDHtsjDt4RShZx2ChWb4Uo5hozuTAEub3oAGvFEclbVr5gVPLL1c0FdOj9Wlu2hYiKPFtv5+K1H7Qt4jUi5MLO7nPwIIQmcXjcQdCcy5F7Mx+uI6Seaoi0PkCObyjjQUjjIYomhl6LQ10kbLI8KqYskG7Fu11fxyCklvHzSOTMp+QEFL5YSD80hPWBBQN7UxepI4ihajDD55cdSCbEjqpz0xbL
X-MS-Office365-Filtering-Correlation-Id: f4536c8b-8425-41f1-c19c-08d5ac2991c0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 10:28:04.4102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4536c8b-8425-41f1-c19c-08d5ac2991c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2422
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894785673525346?=
X-GMAIL-MSGID: =?utf-8?q?1598894785673525346?=
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
