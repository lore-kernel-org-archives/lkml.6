Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeBBPte (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:49:34 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:59760 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbeBBPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:49:24 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Steve French <sfrench@samba.org>
Cc: Martin Sebor <msebor@gcc.gnu.org>, Arnd Bergmann <arnd@arndb.de>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Aurelien Aptel <aaptel@suse.com>, Long Li <longli@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>, Sachin Prabhu <sprabhu@redhat.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: silence compiler warnings showing up with gcc-8.0.0
Date: Fri,  2 Feb 2018 16:48:47 +0100
Message-Id: <20180202154902.1626750-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:AOn6yadvnaxLgNkAzUbHoHDgSHf92Iw5pRyEGwtckoOsr49K/lQ
 FGOd1WOCBVBU/QHYS1RUqZQdsP80xJKYmQdYaHwlFCcuOveTo+mIeKlbnslAWZL3Y8WYcD3
 HxgJK7aoO0Z8Rm8mEFBr34Cg8tNWZVPZ3jmzEfVev1c509axCxxOvpG57vHHFxiq7n/eZlW
 45mkYFmsqTeQY+MKGMWew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WujVtP8/yzM=:QELPEsIW+VydDgAvBxtEVS
 kfW+LfZLbKT3P4upgAgIPQacCLwqXThon/EXAlhihFiXB79qBWMRol7kRo/PA/4ND7TAHDDh3
 tX73S0eHmSDq9sHiiwO3QCW/4YDt70abA5YiD1FqhMaKf89yEDOMDe1aCVhCeS1zgMRLaRA5z
 gVr5FgMSJlyzxL9mzzPDaB8d2dib8j5wJ4i7auUv8VjWPUO9kRJCkPmXjWAqonXqmG1yiZ0S8
 fBj6axasbXZRE/gLcfKkTaSkFHwUoFQEtEtTMA/93xirUKENAkmBWcBzYcrbnwsK13i5JExCu
 YM9Qi6Pc6F8FkeYYOV314viT6+T5zj9e6l+ctKPDCfFtQYYgAVGuqg+UVpX4Jet10oDq0JMi6
 k4xC3szO46f+VZB7dwZEM0+bQbwYJoArC/lzx9AT3EkPhwSfVIWZ1Yoak5cQ9sfxs7UERGrQj
 zk+Uu5vGDcx1X06gHcgjhnyrF5vVeYcByrkKYkiXe7rBrmJ/5ZoeKEOShEmT9kVV+Gh65qhnB
 o+Pyb4dW84iUZZdp0pFxpvcw6y39v+J/XN8L1OyYSU0oCBY8CkH6SypIqLICT34nIWUqazwc4
 6akhVIv2Lc24nftHA9K4vJW4aQz9Eltba2IB3UHFQAwZicm5ZIIo4iod7qDnn/MsK9OGDZNg+
 RQ1gk6j1SKk1Sp6Rgp1iDKLVmCzOVfLbFk/lOxvgIJilDVpJHHjBNlkFTbMecYawpseNNPpts
 t0yT94EhR9o+5m+VHIqnv8Chqzq+BkHeqBl7XQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug was fixed before, but came up again with the latest
compiler in another function:

fs/cifs/cifssmb.c: In function 'CIFSSMBSetEA':
fs/cifs/cifssmb.c:6362:3: error: 'strncpy' offset 8 is out of the bounds [0, 4] [-Werror=array-bounds]
   strncpy(parm_data->list[0].name, ea_name, name_len);

Let's apply the same fix that was used for the other instances.

Fixes: b2a3ad9ca502 ("cifs: silence compiler warnings showing up with gcc-4.7.0")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/cifs/cifssmb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 72d71703f1e8..78bc86c315ec 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -6343,9 +6343,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->InformationLevel =
 		cpu_to_le16(SMB_SET_FILE_EA);
 
-	parm_data =
-		(struct fealist *) (((char *) &pSMB->hdr.Protocol) +
-				       offset);
+	parm_data = (void *)pSMB + offsetof(struct smb_hdr, Protocol) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 	pSMB->DataOffset = cpu_to_le16(offset);
 	pSMB->SetupCount = 1;
-- 
2.9.0
