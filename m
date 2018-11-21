Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4676FC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE322145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="I6k5d6Fj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE322145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeKUU0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:26:19 -0500
Received: from mail-eopbgr690052.outbound.protection.outlook.com ([40.107.69.52]:62592
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbeKUU0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2xbZHWD2hKPpVHWRggHgI+AqSI9gjNJrkakWEA32sI=;
 b=I6k5d6Fjwfr1G10VoxKVZlpFt6E/MZg86dIT/3la4hWLPZ1WcxJXw4u+HeuN5cQTrc3/Zfl9HehJ00j5bwWNKXRWhqS3IckpA3rGXELJhXhUI7vh2LjINGouHsh7yCBqlv+t9iD2xYwuvTSEdwei9kbUcuhYMB/iwv1eYgXqKB8=
Received: from BYAPR07MB4614.namprd07.prod.outlook.com (52.135.204.32) by
 BYAPR07MB5381.namprd07.prod.outlook.com (20.177.125.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 09:52:24 +0000
Received: from BYAPR07MB4614.namprd07.prod.outlook.com
 ([fe80::44d3:6a55:3fd4:9c12]) by BYAPR07MB4614.namprd07.prod.outlook.com
 ([fe80::44d3:6a55:3fd4:9c12%3]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 09:52:24 +0000
From:   "Srikanth, Jampala" <Jampala.Srikanth@cavium.com>
To:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Srikanth, Jampala" <Jampala.Srikanth@cavium.com>
Subject: [PATCH 1/1] crypto: cavium/nitrox - Enable interrups for PF in SR-IOV
 mode.
Thread-Topic: [PATCH 1/1] crypto: cavium/nitrox - Enable interrups for PF in
 SR-IOV mode.
Thread-Index: AQHUgX/nYkhEuEGCSUK2yo/iTfcgRQ==
Date:   Wed, 21 Nov 2018 09:52:24 +0000
Message-ID: <20181121095200.6036-1-Jampala.Srikanth@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::16) To BYAPR07MB4614.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [115.113.156.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5381;6:uJl+pJGXzvdwyT3aW6Vsc8llAEa1+qMMZDudsaN2+QNVXa1Hxjf/3VxHtgcqpFrlWMydv8o7oCjLYDqFK7jJK5utFc5jg//yFlE2JjVUlSSep6JdepUeqcLRygFghbInF7Ctvy+o6EKyex9dgl9QbqH3RJFER42EfyBQn8mzFoSnA4o3u4B+V+goW3udYbHKoQTqE47f+TJC+rMNrEDFhmBtQ0UQywKieHZkYsueUhmnFwPVArjZW9sZXgdGEJ9FZtg9mGtPXjT3KP/rzCSnKg6FvO04Y3P1XNItvWmH7Rk/KtmXsFfEuZzchHQLY++uv6HAuYZoTEyRfvFNJ5Iqav4mOEIO/FxZ7lpp9w7mlICRKVNT9DEBExHccsU/Iicaidx8b2TSjXn1wryPuQTBeOXRpGY5VmyJwg4BKQhvq3r2BQK0lt4Fax/QMx3znxKyEXreTu8F4bfTUTzDwiiutQ==;5:2TFzabKwFdQ77ZyrzS4eKJCyoiMTj45F4tsUIN4I9+lkiONJ/r4qwrHbus+me3T1JiSBtBDbYfw294gtSinnU/wEUnCZhQKlELOeN4/OCA2mDbmHKqDBg6WrNV/Qgqr7hTG2nEFPl4A01wxZncQH9Kpl/xlI3NgkCdBr4HGVEfQ=;7:Ev4narVhL+p4E6t/2U0AOeW0sEduE3170HetmAO7R93XQr5Ryeau+dT3rSbOXYBpTsGgLrbyxyvrYh5MD3LeMZ+crkmxNF9NbSS+kC3JXOAfRWXO4FLfkjjZjpPx47vnwhzqOXggglGWYVpbSGjX1g==
x-ms-office365-filtering-correlation-id: c835a65e-36d8-4750-ca93-08d64f9709a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5381;
x-ms-traffictypediagnostic: BYAPR07MB5381:
x-microsoft-antispam-prvs: <BYAPR07MB538108490829FE95C224D453F4DA0@BYAPR07MB5381.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5381;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5381;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(316002)(6486002)(1076002)(478600001)(3846002)(72206003)(6116002)(81166006)(105586002)(106356001)(8676002)(81156014)(6436002)(107886003)(4326008)(8936002)(6512007)(14454004)(53936002)(66066001)(26005)(25786009)(2900100001)(68736007)(2501003)(97736004)(256004)(575784001)(14444005)(486006)(86362001)(55236004)(99286004)(52116002)(186003)(305945005)(386003)(71190400001)(36756003)(2906002)(110136005)(476003)(7736002)(5660300001)(2616005)(54906003)(71200400001)(102836004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5381;H:BYAPR07MB4614.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DbjsJULWMBPjN2a92jTjSVJ/D2PEF8WG5jtxqYSr8jEwVLse0ARBKSB5pFTRGja9/HekLqgJRlPIythaDHK4ZdC0uKab7ehCmyHnRiGCrdE677HNEdvyHDMbocVJDuOtviOWub/i6b8t8L3mqjmcP4s7qlJhmkB1lUY7UY7EBZ6kJ5IcfDlt7+xNHpK+FCCrCxnxgNafc9DZZ0b5b/Nil9+nUbnVGYdBhrBlJN8JMrV+dmGkFQGu08iHlJnZAYr0GPdSJxg4LifS6qHs6LqAcDYVM0S7ZtzXJSg96Qh/pB5N5H4wVfZkXgPzfsP3vXOIfJQGi3c+QHHFS8owT/UdMUVL3RxFXiB61NTkF0EXySM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c835a65e-36d8-4750-ca93-08d64f9709a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 09:52:24.2611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the available interrupt vectors for PF in SR-IOV Mode.
Only single vector entry 192 is valid of PF. This is used to
notify any hardware errors and mailbox messages from VF(s).

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
---
 drivers/crypto/cavium/nitrox/nitrox_dev.h   | 15 +++-
 drivers/crypto/cavium/nitrox/nitrox_isr.c   | 84 ++++++++++++++++++++-
 drivers/crypto/cavium/nitrox/nitrox_isr.h   |  2 +
 drivers/crypto/cavium/nitrox/nitrox_sriov.c | 51 +++++++++++--
 4 files changed, 142 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/cav=
ium/nitrox/nitrox_dev.h
index 283e252385fb..247df32f687c 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
@@ -103,6 +103,16 @@ struct nitrox_q_vector {
 	};
 };
=20
+/**
+ * struct nitrox_iov - SR-IOV information
+ * @num_vfs: number of VF(s) enabled
+ * @msix: MSI-X for PF in SR-IOV case
+ */
+struct nitrox_iov {
+	int num_vfs;
+	struct msix_entry msix;
+};
+
 /*
  * NITROX Device states
  */
@@ -150,6 +160,9 @@ enum vf_mode {
  * @ctx_pool: DMA pool for crypto context
  * @pkt_inq: Packet input rings
  * @qvec: MSI-X queue vectors information
+ * @iov: SR-IOV informatin
+ * @num_vecs: number of MSI-X vectors
+ * @stats: request statistics
  * @hw: hardware information
  * @debugfs_dir: debugfs directory
  */
@@ -168,13 +181,13 @@ struct nitrox_device {
 	int node;
 	u16 qlen;
 	u16 nr_queues;
-	int num_vfs;
 	enum vf_mode mode;
=20
 	struct dma_pool *ctx_pool;
 	struct nitrox_cmdq *pkt_inq;
=20
 	struct nitrox_q_vector *qvec;
+	struct nitrox_iov iov;
 	int num_vecs;
=20
 	struct nitrox_stats stats;
diff --git a/drivers/crypto/cavium/nitrox/nitrox_isr.c b/drivers/crypto/cav=
ium/nitrox/nitrox_isr.c
index 88a77b8fb3fb..c5b797808680 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_isr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_isr.c
@@ -13,6 +13,7 @@
  *  - NPS packet ring, AQMQ ring and ZQMQ ring
  */
 #define NR_RING_VECTORS 3
+#define NR_NON_RING_VECTORS 1
 /* base entry for packet ring/port */
 #define PKT_RING_MSIX_BASE 0
 #define NON_RING_MSIX_BASE 192
@@ -275,6 +276,7 @@ void nitrox_unregister_interrupts(struct nitrox_device =
*ndev)
 		qvec->valid =3D false;
 	}
 	kfree(ndev->qvec);
+	ndev->qvec =3D NULL;
 	pci_free_irq_vectors(pdev);
 }
=20
@@ -321,6 +323,7 @@ int nitrox_register_interrupts(struct nitrox_device *nd=
ev)
 		if (qvec->ring >=3D ndev->nr_queues)
 			break;
=20
+		qvec->cmdq =3D &ndev->pkt_inq[qvec->ring];
 		snprintf(qvec->name, IRQ_NAMESZ, "nitrox-pkt%d", qvec->ring);
 		/* get the vector number */
 		vec =3D pci_irq_vector(pdev, i);
@@ -335,13 +338,13 @@ int nitrox_register_interrupts(struct nitrox_device *=
ndev)
=20
 		tasklet_init(&qvec->resp_tasklet, pkt_slc_resp_tasklet,
 			     (unsigned long)qvec);
-		qvec->cmdq =3D &ndev->pkt_inq[qvec->ring];
 		qvec->valid =3D true;
 	}
=20
 	/* request irqs for non ring vectors */
 	i =3D NON_RING_MSIX_BASE;
 	qvec =3D &ndev->qvec[i];
+	qvec->ndev =3D ndev;
=20
 	snprintf(qvec->name, IRQ_NAMESZ, "nitrox-core-int%d", i);
 	/* get the vector number */
@@ -356,7 +359,6 @@ int nitrox_register_interrupts(struct nitrox_device *nd=
ev)
=20
 	tasklet_init(&qvec->resp_tasklet, nps_core_int_tasklet,
 		     (unsigned long)qvec);
-	qvec->ndev =3D ndev;
 	qvec->valid =3D true;
=20
 	return 0;
@@ -365,3 +367,81 @@ int nitrox_register_interrupts(struct nitrox_device *n=
dev)
 	nitrox_unregister_interrupts(ndev);
 	return ret;
 }
+
+void nitrox_sriov_unregister_interrupts(struct nitrox_device *ndev)
+{
+	struct pci_dev *pdev =3D ndev->pdev;
+	int i;
+
+	for (i =3D 0; i < ndev->num_vecs; i++) {
+		struct nitrox_q_vector *qvec;
+		int vec;
+
+		qvec =3D ndev->qvec + i;
+		if (!qvec->valid)
+			continue;
+
+		vec =3D ndev->iov.msix.vector;
+		irq_set_affinity_hint(vec, NULL);
+		free_irq(vec, qvec);
+
+		tasklet_disable(&qvec->resp_tasklet);
+		tasklet_kill(&qvec->resp_tasklet);
+		qvec->valid =3D false;
+	}
+	kfree(ndev->qvec);
+	ndev->qvec =3D NULL;
+	pci_disable_msix(pdev);
+}
+
+int nitrox_sriov_register_interupts(struct nitrox_device *ndev)
+{
+	struct pci_dev *pdev =3D ndev->pdev;
+	struct nitrox_q_vector *qvec;
+	int vec, cpu;
+	int ret;
+
+	/**
+	 * only non ring vectors i.e Entry 192 is available
+	 * for PF in SR-IOV mode.
+	 */
+	ndev->iov.msix.entry =3D NON_RING_MSIX_BASE;
+	ret =3D pci_enable_msix_exact(pdev, &ndev->iov.msix, NR_NON_RING_VECTORS)=
;
+	if (ret) {
+		dev_err(DEV(ndev), "failed to allocate nps-core-int%d\n",
+			NON_RING_MSIX_BASE);
+		return ret;
+	}
+
+	qvec =3D kcalloc(NR_NON_RING_VECTORS, sizeof(*qvec), GFP_KERNEL);
+	if (!qvec) {
+		pci_disable_msix(pdev);
+		return -ENOMEM;
+	}
+	qvec->ndev =3D ndev;
+
+	ndev->qvec =3D qvec;
+	ndev->num_vecs =3D NR_NON_RING_VECTORS;
+	snprintf(qvec->name, IRQ_NAMESZ, "nitrox-core-int%d",
+		 NON_RING_MSIX_BASE);
+
+	vec =3D ndev->iov.msix.vector;
+	ret =3D request_irq(vec, nps_core_int_isr, 0, qvec->name, qvec);
+	if (ret) {
+		dev_err(DEV(ndev), "irq failed for nitrox-core-int%d\n",
+			NON_RING_MSIX_BASE);
+		goto iov_irq_fail;
+	}
+	cpu =3D num_online_cpus();
+	irq_set_affinity_hint(vec, get_cpu_mask(cpu));
+
+	tasklet_init(&qvec->resp_tasklet, nps_core_int_tasklet,
+		     (unsigned long)qvec);
+	qvec->valid =3D true;
+
+	return 0;
+
+iov_irq_fail:
+	nitrox_sriov_unregister_interrupts(ndev);
+	return ret;
+}
diff --git a/drivers/crypto/cavium/nitrox/nitrox_isr.h b/drivers/crypto/cav=
ium/nitrox/nitrox_isr.h
index 63418a6cc52c..1062c9336c1f 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_isr.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_isr.h
@@ -6,5 +6,7 @@
=20
 int nitrox_register_interrupts(struct nitrox_device *ndev);
 void nitrox_unregister_interrupts(struct nitrox_device *ndev);
+int nitrox_sriov_register_interupts(struct nitrox_device *ndev);
+void nitrox_sriov_unregister_interrupts(struct nitrox_device *ndev);
=20
 #endif /* __NITROX_ISR_H */
diff --git a/drivers/crypto/cavium/nitrox/nitrox_sriov.c b/drivers/crypto/c=
avium/nitrox/nitrox_sriov.c
index 30c0aa874583..7ba0cc5d6d02 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_sriov.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_sriov.c
@@ -7,6 +7,10 @@
 #include "nitrox_common.h"
 #include "nitrox_isr.h"
=20
+/**
+ * num_vfs_valid - validate VF count
+ * @num_vfs: number of VF(s)
+ */
 static inline bool num_vfs_valid(int num_vfs)
 {
 	bool valid =3D false;
@@ -48,7 +52,7 @@ static inline enum vf_mode num_vfs_to_mode(int num_vfs)
 	return mode;
 }
=20
-static void pf_sriov_cleanup(struct nitrox_device *ndev)
+static void nitrox_pf_cleanup(struct nitrox_device *ndev)
 {
 	 /* PF has no queues in SR-IOV mode */
 	atomic_set(&ndev->state, __NDEV_NOT_READY);
@@ -60,7 +64,11 @@ static void pf_sriov_cleanup(struct nitrox_device *ndev)
 	nitrox_common_sw_cleanup(ndev);
 }
=20
-static int pf_sriov_init(struct nitrox_device *ndev)
+/**
+ * nitrox_pf_reinit - re-initialize PF resources once SR-IOV is disabled
+ * @ndev: NITROX device
+ */
+static int nitrox_pf_reinit(struct nitrox_device *ndev)
 {
 	int err;
=20
@@ -86,6 +94,18 @@ static int pf_sriov_init(struct nitrox_device *ndev)
 	return nitrox_crypto_register();
 }
=20
+static int nitrox_sriov_init(struct nitrox_device *ndev)
+{
+	/* register interrupts for PF in SR-IOV */
+	return nitrox_sriov_register_interupts(ndev);
+}
+
+static void nitrox_sriov_cleanup(struct nitrox_device *ndev)
+{
+	/* unregister interrupts for PF in SR-IOV */
+	nitrox_sriov_unregister_interrupts(ndev);
+}
+
 static int nitrox_sriov_enable(struct pci_dev *pdev, int num_vfs)
 {
 	struct nitrox_device *ndev =3D pci_get_drvdata(pdev);
@@ -106,17 +126,31 @@ static int nitrox_sriov_enable(struct pci_dev *pdev, =
int num_vfs)
 	}
 	dev_info(DEV(ndev), "Enabled VF(s) %d\n", num_vfs);
=20
-	ndev->num_vfs =3D num_vfs;
+	ndev->iov.num_vfs =3D num_vfs;
 	ndev->mode =3D num_vfs_to_mode(num_vfs);
 	/* set bit in flags */
 	set_bit(__NDEV_SRIOV_BIT, &ndev->flags);
=20
 	/* cleanup PF resources */
-	pf_sriov_cleanup(ndev);
+	nitrox_pf_cleanup(ndev);
=20
-	config_nps_core_vfcfg_mode(ndev, ndev->mode);
+	/* PF SR-IOV mode initialization */
+	err =3D nitrox_sriov_init(ndev);
+	if (err)
+		goto iov_fail;
=20
+	config_nps_core_vfcfg_mode(ndev, ndev->mode);
 	return num_vfs;
+
+iov_fail:
+	pci_disable_sriov(pdev);
+	/* clear bit in flags */
+	clear_bit(__NDEV_SRIOV_BIT, &ndev->flags);
+	ndev->iov.num_vfs =3D 0;
+	ndev->mode =3D __NDEV_MODE_PF;
+	/* reset back to working mode in PF */
+	nitrox_pf_reinit(ndev);
+	return err;
 }
=20
 static int nitrox_sriov_disable(struct pci_dev *pdev)
@@ -134,12 +168,15 @@ static int nitrox_sriov_disable(struct pci_dev *pdev)
 	/* clear bit in flags */
 	clear_bit(__NDEV_SRIOV_BIT, &ndev->flags);
=20
-	ndev->num_vfs =3D 0;
+	ndev->iov.num_vfs =3D 0;
 	ndev->mode =3D __NDEV_MODE_PF;
=20
+	/* cleanup PF SR-IOV resources */
+	nitrox_sriov_cleanup(ndev);
+
 	config_nps_core_vfcfg_mode(ndev, ndev->mode);
=20
-	return pf_sriov_init(ndev);
+	return nitrox_pf_reinit(ndev);
 }
=20
 int nitrox_sriov_configure(struct pci_dev *pdev, int num_vfs)
--=20
2.17.1

