Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeCPUVb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:21:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57115 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752730AbeCPUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:18:45 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 01/10] iommu/amd: take into account that alloc_dev_data() may return NULL
Date: Fri, 16 Mar 2018 21:18:27 +0100
Message-Id: <20180316201836.7864-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316201836.7864-1-bigeasy@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_dev_data() does not check whether the return value alloc_dev_data()
is NULL. This was okay once because the pointer was returned once as-is.
Since commit df3f7a6e8e85 ("iommu/amd: Use is_attach_deferred
call-back") the pointer may be used within find_dev_data() so a NULL
check is required.

Cc: Baoquan He <bhe@redhat.com>
Fixes: df3f7a6e8e85 ("iommu/amd: Use is_attach_deferred call-back")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 05f55903dbf6..b50dcb17c68f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -310,6 +310,8 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
=20
 	if (dev_data =3D=3D NULL) {
 		dev_data =3D alloc_dev_data(devid);
+		if (!dev_data)
+			return NULL;
=20
 		if (translation_pre_enabled(iommu))
 			dev_data->defer_attach =3D true;
--=20
2.16.2
