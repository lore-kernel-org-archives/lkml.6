Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB7AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124F42081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124F42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeKCAn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:43:56 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKCAn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:43:56 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLyvH-1g1DCE27Pd-00Hxa0; Fri, 02 Nov 2018 16:36:03 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLyvH-1g1DCE27Pd-00Hxa0; Fri, 02 Nov 2018 16:36:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Vasyl Gomonovych <gomonovych@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: fix remoteport access
Date:   Fri,  2 Nov 2018 16:35:48 +0100
Message-Id: <20181102153601.1599945-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:MQRaELqsp5ENIDgNMPWwHMaVnT4QRa1GYKgTmcb0eqtBsOv2R48
 u3LCMRl2p4e4e7ji9gfunn3yWzYz45bfjI2eG9Jt8NE739He/ZtrzhYhqC3av05pBG9GHbH
 TTZhONwF3YA6gjFbZoHqQPfWmM9ijo4RRcZLgeu82VY8tCpFnnjyBn7vAm27MNIvCmSfsYb
 6S5uA8ScpZCU9kLe2d9sA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C7XGLKoSRDw=:U2FMBNTkUKfFHTD+w/HJEO
 HWbAQHJUh+OB6TiU+nrWd9AiapVmnYk1fABSRhlfJO1EYs052ozAtSvk87WNQnSZHCqr7sJi9
 2vDxsiY60lFYjgP4VngIRmDmUaI1pyJ7/030fBHszqp3DLuplOSEUWtTknylERq86YP8CNLeA
 H28uUPTpZv8LZvajGwJnwqov6wmtj8J5m/vOQCICYSmAsHxMzZ9fZIcZTAUQFgE3w5Ie8qNIY
 iBHsbCbs9iLVXUOyX7AfmYH15e0maMEKjk8OgJ3pj2ZH16JHFH54mdjQ6d/CUo9pXP/ivP3fX
 P3FaZPqv5M619CNgrGHxFu/yIZjd5VJiCTqUGDuqUtbCWYgxsh50HVsJJ4fIi9ejT0JJjcpnI
 0WHVgOL0r69oHue6pGDe7a4G1hfFCrraXyj9cUYt86CgCGgrhylKRc3jUhPE0UkMFf08CotlM
 plBxMYfsQTMgcldjAkCwOqy4qCl1dDKuMuZBlJcjbAr8XkCdePedQKpaEvFF5kmSgGhDcQICP
 Nr8tP6LUcQOed6WjITeelpJ/OoasvRvZR0qCVAJmO37INImVzi4aAzZnjxhIsJA8TfAqU60BC
 CW+Ga4LAbRlPpaXxHjMRq2ct6qtxAyJ+1EU+AL3DTQm/nxApf7U7kgsX3g7SX1vDHAJ5QPBUs
 eDqgyDkRspDz1zs017fVHk3jaV10UyrrZJYpA0wQICJb5uN9G9wzcpEa7zCao9XNC/vA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of a spinlock in lpfc_debugfs_nodelist_data() introduced
a bug that lets us not skip NULL pointers correctly, as noticed by
gcc-8:

drivers/scsi/lpfc/lpfc_debugfs.c: In function 'lpfc_debugfs_nodelist_data.constprop':
drivers/scsi/lpfc/lpfc_debugfs.c:728:13: error: 'nrport' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   if (nrport->port_role & FC_PORT_ROLE_NVME_INITIATOR)

This changes the logic back to what it was, while keeping the added
spinlock.

Fixes: 9e210178267b ("scsi: lpfc: Synchronize access to remoteport via rport")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 0c8005bb0f53..34d311a7dbef 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -698,6 +698,8 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
 		rport = lpfc_ndlp_get_nrport(ndlp);
 		if (rport)
 			nrport = rport->remoteport;
+		else
+			nrport = NULL;
 		spin_unlock(&phba->hbalock);
 		if (!nrport)
 			continue;
-- 
2.18.0

