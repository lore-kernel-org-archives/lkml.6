Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeDJW0u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 18:26:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43355 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeDJW0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:26:47 -0400
X-Google-Smtp-Source: AIpwx4+CXeqvhiRMQfcxi96I9rR2NYhYTRS4SP3GF9dHUe3dDNt75kJuF1J7Ay1R8YEPNiNVEAJ45g==
Date: Tue, 10 Apr 2018 15:26:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Cc: John Allen <jallen@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Daniel Micay <danielmicay@gmail.com>
Subject: [PATCH] ibmvnic: Define vnic_login_client_data name field as unsized
 array
Message-ID: <20180410222643.GA29473@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "name" field of struct vnic_login_client_data is a char array of
undefined length. This should be written as "char name[]" so the compiler
can make better decisions about the field (for example, not assuming
it's a single character). This was noticed while trying to tighten the
CONFIG_FORTIFY_SOURCE checking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index aad5658d79d5..35fbb41cd2d4 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3170,7 +3170,7 @@ static int send_version_xchg(struct ibmvnic_adapter *adapter)
 struct vnic_login_client_data {
 	u8	type;
 	__be16	len;
-	char	name;
+	char	name[];
 } __packed;
 
 static int vnic_client_data_len(struct ibmvnic_adapter *adapter)
@@ -3199,21 +3199,21 @@ static void vnic_add_client_data(struct ibmvnic_adapter *adapter,
 	vlcd->type = 1;
 	len = strlen(os_name) + 1;
 	vlcd->len = cpu_to_be16(len);
-	strncpy(&vlcd->name, os_name, len);
-	vlcd = (struct vnic_login_client_data *)((char *)&vlcd->name + len);
+	strncpy(vlcd->name, os_name, len);
+	vlcd = (struct vnic_login_client_data *)(vlcd->name + len);
 
 	/* Type 2 - LPAR name */
 	vlcd->type = 2;
 	len = strlen(utsname()->nodename) + 1;
 	vlcd->len = cpu_to_be16(len);
-	strncpy(&vlcd->name, utsname()->nodename, len);
-	vlcd = (struct vnic_login_client_data *)((char *)&vlcd->name + len);
+	strncpy(vlcd->name, utsname()->nodename, len);
+	vlcd = (struct vnic_login_client_data *)(vlcd->name + len);
 
 	/* Type 3 - device name */
 	vlcd->type = 3;
 	len = strlen(adapter->netdev->name) + 1;
 	vlcd->len = cpu_to_be16(len);
-	strncpy(&vlcd->name, adapter->netdev->name, len);
+	strncpy(vlcd->name, adapter->netdev->name, len);
 }
 
 static int send_login(struct ibmvnic_adapter *adapter)
-- 
2.7.4


-- 
Kees Cook
Pixel Security
