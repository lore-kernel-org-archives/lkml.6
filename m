Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbeDNMQn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 08:16:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:57229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeDNMQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 08:16:42 -0400
From: Chengguang Xu <cgxu519@gmx.com>
To: jack@suse.cz, dhowells@redhat.com, elfring@users.sourceforge.net,
        viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] isofs: fix potential memory leak in mount option parsing
Date: Sat, 14 Apr 2018 20:16:06 +0800
Message-Id: <1523708166-32728-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:DLsM4FB0H9W2y+LkOpeVnZMr/ZFZxlCBOU1rKg5ESTGqRu4/gAh
 MEM4ATSfmoV5XS/51IuiduVZYBHI+So5w9jTAVbcIwSPfz0oJuyhTCqk7gt0Lr/b16XqJzi
 +ZlPXqNcaTHJ7q4M3kBg582SHrFeOjCA+v5InC4FxWWa1Aa7/lmJfGod1vJO9RN62310/t7
 umrbukjGyCnibObAjRDTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KFbOoVnCpLs=:XpWycA5as1/BTmAuOHsOJd
 V0aXEfZvK3pd/aO2tQiAQHMEJOEvWO3jJCgYxhXGUx+8mlDUvWhOLm61EwOV+hC6Huf4PXnsV
 JOnqSK9ymBEIeGYqfw0zDtUnAelkM5Rd6BJHKQ6M/iyk2zpoA89tvdITx42p6ItOmQYyLhsoq
 rT5+HNYw+TJtlNuQU05Omytza3MhG7b6EH4fnSFxHU08FKLSR92VNSUeGawt6Aay0BXxxhTqW
 TxDm778NNYrxxi4/p6TGguVTrbIIm8dVih0Ra5CwH/XINJN4FqKG2rc45rK2VkslpFYhYzr/E
 wRzHksEGtq7KiiwJdfE3GanAYF6a4e+ZV8EBBxHReDSFAWfKPlVA2DLEP/wAHgpOZiJy0wmuL
 ARx6zibX+yfq/NEFEnR6ty/2K55qHUVqZ1AZW3jRPR45KxliCepYe+9F3r4geDQ+L1aUCX99V
 09MAw2EVFxwgf5zw694lGDL7fOso6x2msYXlQqowFPfAaPVlPFWNTlexJZ7akPSrMasIF1eiz
 tjmQsibTlYzCzZn0UYKu8NuUNZ7AhSxE0duFmUqRKrHBgAmFbfsjs+I3GgoQJKio9vljTnTNy
 K657BMwKLT11+SbE9goUnI7HtfcGkM7T3+s3AhzAay/GYfMuZFnRYXotc7KyECd3fYb3iGi6v
 mg4M2WrNWCkK28jbTNZvGVIiqg+hmnkh2NVz9Lig7oifHBjRqMnVyfZYxfdRT594LzesCy/0k
 EztZEXEllapYUDKOnEnDXUZSQHL+o37Uf2SK6MjpzR3xWQHVJgw2mHBIUAm5sbzhV1j3huo3s
 zzzeF+FNLIs5A8FJl3oACLdWSgxiQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When specifying string type mount option (e.g., iocharset)
several times in a mount, current option parsing may
cause memory leak. Hence, call kfree for previous one
in this case. Meanwhile, check memory allocation result
for it.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/isofs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index bc258a4..ec3fba7 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -394,7 +394,10 @@ static int parse_options(char *options, struct iso9660_options *popt)
 			break;
 #ifdef CONFIG_JOLIET
 		case Opt_iocharset:
+			kfree(popt->iocharset);
 			popt->iocharset = match_strdup(&args[0]);
+			if (!popt->iocharset)
+				return 0;
 			break;
 #endif
 		case Opt_map_a:
-- 
1.8.3.1
