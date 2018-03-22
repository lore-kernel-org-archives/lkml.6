Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755088AbeCVPXC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:23:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39564 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbeCVPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:22:56 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/10] iommu/amd: return proper error code in irq_remapping_alloc()
Date: Thu, 22 Mar 2018 16:22:42 +0100
Message-Id: <20180322152242.12705-11-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180322152242.12705-1-bigeasy@linutronix.de>
References: <20180322152242.12705-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the unlikely case when alloc_irq_table() is not able to return a
remap table then "ret" will be assigned with an error code. Later, the
code checks `index' and if it is negative (which it is because it is
initialized with `-1') and then then function properly aborts but
returns `-1' instead `-ENOMEM' what was intended.
In order to correct this, I assign -ENOMEM to index.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 23e26a4b708e..6107e24bed8a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4124,7 +4124,7 @@ static int irq_remapping_alloc(struct irq_domain *dom=
ain, unsigned int virq,
 	struct amd_ir_data *data =3D NULL;
 	struct irq_cfg *cfg;
 	int i, ret, devid;
-	int index =3D -1;
+	int index;
=20
 	if (!info)
 		return -EINVAL;
@@ -4166,7 +4166,7 @@ static int irq_remapping_alloc(struct irq_domain *dom=
ain, unsigned int virq,
 			WARN_ON(table->min_index !=3D 32);
 			index =3D info->ioapic_pin;
 		} else {
-			ret =3D -ENOMEM;
+			index =3D -ENOMEM;
 		}
 	} else {
 		bool align =3D (info->type =3D=3D X86_IRQ_ALLOC_TYPE_MSI);
--=20
2.16.2
