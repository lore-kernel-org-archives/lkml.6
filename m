Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeBUMtB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:49:01 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeBUMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:48:58 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH 2/2] pci: endpoint: Fix kernel panic after put_device()
Date: Wed, 21 Feb 2018 13:47:07 +0100
Message-Id: <20180221124707.26308-3-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124707.26308-1-embedded24@evers-fischer.de>
References: <20180221124707.26308-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:JwJ/PfeHxSwfIMXtK4QFiis5MSUcVoLgvdEtHowPBz0oSiYNicF
 DE949BCZzIFC67BeYK41ZZBmnpoZfnLnTrG5krJ9t9Z4se1Txl0ITkMA7x9n9oV4Z1EfcZ+
 osujVQxYWwrkdZ6VsOC+iSlXASEFZgXg05nOWcOsVNaNOEzc2Np32rIeKeLiI/ctu+15Mkc
 750XwoosDRd4CBs5flAzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ohABFLfiUhc=:5K899OOLiScZ9SN2JzhLu6
 frtHJ7ywB2crpn61Ly3vudhkrYLDlO62E1+0Vu8wZzAHdo9yqHXy9hqq1wuq2RpLeps8JvCx/
 TlDZMsFgqF2n0iw9X6MkyE2+hOavDpDlD7Mi5TQ/sQq2mDaQ1m83DuUWq/AfArcKQXZr6zw3R
 MDZbeOdjZVN2/DtetJ6JJ4XYnwygmnvA2oKJsHdxKxD6GJU95At66b+zmEM9Pbal8WugKuZf+
 ToO1x185ZQBD0ryvyxpyXg+D9r832g9mY9jBxAcHpQvBFOMicvMyB+NFmdSc9hEp2yKmyDfaA
 ltO+GrmnZmrFDHK8dRmJrlWkaI8maLZ3BZHEpO69/C4eryriab9n0xEhxOlnWglpiNdvU1AHD
 6Q3D0+yGApBEtAzD0IRsidg+sOtVX4l3M7WNY4jrHc27U9UqrAE5RY5H0elA9E5w6Ar5Oj+Ah
 6cg+EBrDDfM+1G+OWxOfNFYDCAx/Y+5+cOEzgIEQJt5Y/Je2gWHi2AiXaMSk4I3/XZ8CwJcMI
 fX+uo6rtRa5obTUCWTkHvxxVL7ehJp4V+33jwY/DfzVI5zEyHWM7dwmCwOSHKra5PnR16jRXd
 QzT0VYSshV81bL8ZdtouFkw7UGCd1EnFkS52TmUu2CSoR5PwjAOwfc73II49EYidAS9X71HZE
 t1feHN2EO7/N0zkh6SLzvo5cgVOcXp4G/7J7Tp7W93PAXZouRUQjXvnh2gyP/4x/+eiFHi93x
 64Sna70fMGT6JfgmLZrxKOiDKR7GeratQ3JtkA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

'put_device()' calls the relase function 'pci_epf_dev_release()',
which already frees 'epf->name' and 'epf'.

Therefore we must not free them again after 'put_device()'.

Change-Id: I14ca19f96abfbbb489dd1f4d489e085329d7112e
Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
---
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 23d0e128d1a5..3718b4c5814a 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -243,7 +243,7 @@ struct pci_epf *pci_epf_create(const char *name)
 
 put_dev:
 	put_device(dev);
-	kfree(epf->name);
+	return ERR_PTR(ret);
 
 free_epf:
 	kfree(epf);
-- 
2.16.2
