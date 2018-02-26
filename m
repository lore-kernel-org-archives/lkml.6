Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeBZJpn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:45:43 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:35771 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeBZJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:45:41 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: QLogic-Storage-Upstream@cavium.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Manish Rangankar <Manish.Rangankar@cavium.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qedi: fix build regression
Date: Mon, 26 Feb 2018 10:44:14 +0100
Message-Id: <20180226094422.2607574-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:b1jgyXb9DbYtRiz8IYzzU+2QncMAeyKL3KwsZ8Y6DoYJ9vH2cWt
 PKF4m/daNq/Ltt8qgQKyQB7VhBiB0sWbnZbv0nwqGjdB8XEOMocq8oh33SaYCSSqiNJbFqq
 byZjdQIwotn0r9vQc4YusqWPSSeFcpm6gUM+azHOHM9mg4E9wUL5rSIZClglcNwM6RcGqYs
 wc+nz12KpqK5co99/XuYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eLnzaOQf4dU=:bzsoGlJJh4p9dxZ0kjVGT7
 vdlnD4tU4ywLoJIt9oCHVdAKKBgdfJArmK0UVQrGSSmyJS3MT1abwu8+M2pIyDzkzaUCKsEOx
 V/aXWdhgXrbz/YlzRCEDFPdHs/Sd0S8sxNNFMct/SXW0nLXxsy9lok3fxhax771SmdHdJy7k8
 zQo/syOkAjEuAoA8jqb/2Zr/Jljht3CUBt3jLIYZLFXvRRPOLegLDFE7O5Bec8NTjGO8lDerK
 PX9xU9lomRXY3eU+o7OkBjiiFKpVQBWMYJRrBpADhD2HGJuIx/d6yrKUmmfLAwixrl3VU3zTv
 2C/leOMyNMVVOw/PJqR28uXtVQNuE8YoMM6rj0mgzViHB2LU63ubdAl0Q/UQNwyY9cbv7NQ8r
 ADEyJ3kLJ81VyheIaWAItbgbtlEtv/V1xpMkm29bfL7Ie8QSN1M84wsYA3tWvkYp6K7lcRiJo
 D4qU4ZkObAY9NKTmpapgt7NaR/GzGYgdYZgO10DTqpmT2+HCi4ON8tYitUwGwjHVBR5uh4DN6
 NxSK5p0hHsJ8Nk/erEGOZfRPEWkM/i4ko97HL1q9EBid51EsbdCOXfFrOezLPvPUs10upmwg6
 O9oMo4fGSQaS7SBy10eYc/Qbp1B0UPmgL+H6mbi9dM66P/ckg0/GYp+LbkJoICtICM64ybE2N
 z30p99tpDhpYtAosYTiOO/XHVsemAJayYMq1WLSa3LgVU2ddWCaxWLY6YZiEYFFwN9OIjbnca
 UJjkRN2dfLvgzDltoX3iJpuLQDRT7U25/3CNZA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bugfix I did caused a build regression in some other randconfig
builds in a rare combination of options:

In file included from drivers/scsi/qedi/qedi_fw.c:16:
drivers/scsi/qedi/qedi_gbl.h:26:38: error: array type has incomplete element type 'struct qedi_debugfs_ops'
 extern const struct qedi_debugfs_ops qedi_debugfs_ops[];
                                      ^~~~~~~~~~~~~~~~

This removes the useless #ifdef around the declarations in qedi_dbg.h
to make it always build.

Fixes: 779936faf4f1 ("scsi: qedi: fix building with LTO")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/qedi/qedi_dbg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_dbg.h b/drivers/scsi/qedi/qedi_dbg.h
index 358f40567849..0bc9c31d5a4f 100644
--- a/drivers/scsi/qedi/qedi_dbg.h
+++ b/drivers/scsi/qedi/qedi_dbg.h
@@ -103,7 +103,6 @@ int qedi_create_sysfs_attr(struct Scsi_Host *shost,
 void qedi_remove_sysfs_attr(struct Scsi_Host *shost,
 			    struct sysfs_bin_attrs *iter);
 
-#ifdef CONFIG_DEBUG_FS
 /* DebugFS related code */
 struct qedi_list_of_funcs {
 	char *oper_str;
@@ -139,6 +138,5 @@ void qedi_dbg_host_init(struct qedi_dbg_ctx *qedi,
 void qedi_dbg_host_exit(struct qedi_dbg_ctx *qedi);
 void qedi_dbg_init(char *drv_name);
 void qedi_dbg_exit(void);
-#endif /* CONFIG_DEBUG_FS */
 
 #endif /* _QEDI_DBG_H_ */
-- 
2.9.0
