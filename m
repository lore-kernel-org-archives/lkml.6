Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1AFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6219720658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6219720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeH2SBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:01:36 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbeH2SBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:01:35 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MOU8z-1fybRT3HKH-005rMt; Wed, 29 Aug 2018 16:04:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     paulus@samba.org, linux-ppp@vger.kernel.org, netdev@vger.kernel.org
Cc:     mitch@sfgoth.com, mostrows@earthlink.net, jchapman@katalix.com,
        xeb@mail.ru, davem@davemloft.net, viro@zeniv.linux.org.uk,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH net-next 1/5] pppoe: fix PPPOEIOCSFWD compat handling
Date:   Wed, 29 Aug 2018 16:03:26 +0200
Message-Id: <20180829140409.833488-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:eCWUv3xKZCjlKAHyE0BGb2XkCvHD0nAdvdpsYPnxBxdb+qUtKtN
 lAmu7WMSAlaORR0C2WX6XSQ6S52lGk3kcMFa4HOA9NM5E+TTblRQ9MDdVVim7jGvT9rxBJE
 PUC4J8xzSWirp/kAVFTBWZUtV1ntWlIbwtOP6Vx5zlbd5ObO59t8Rlnty5e/oC34I58OD2K
 lG40EkIQ4/FakbisefKag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DvU3N3eJ9JA=:eHVLnjtbaeg6dj9pYupjsn
 JIwuUgBii4bsyOTDFocOGAk5lWIkbQXpcpNZGImHUbxaNnZlQADKHxgL20zUzGD+5seFuuY86
 YahJxxHlgXt7aD+pyURovSEzp1q3wqekaB7ZU1PlzSaR6aYI3b/V0g+oelYqlYhHzGcoMzyJZ
 HEchu+PKNf/wYekMIfDZND4Yb2i7wsg7jqSuN9ixN9/F7313jsA7253QoUBMCe11Z3PQEjqCV
 tjjLESn5Zzz3eERZff2ZivpaHdxjbzvA0S8Cp+bINe4I3AKGmTAZ6SD3PY2rfKS84vEqljeFR
 4qdsAY+Crf45Wg7IGKgGeQT14+/QjAxZ/f5FSi9kWCh5GkMU/ktGhpv1lZBOwiLRTrzRyFAut
 g/lrkLpm0sTYTBTWvuW6x8r73p802sQ7nhRSsvX9YNd7iE+uNu78CZnMucOLe99x2OdDR/tO2
 5jI7RhQdXotbVwYwiaIk+Og3hgGEQBhLWjmaF49RZWk/o7vxOS1B/glmABGIYOXn9tqgE+Ddk
 Vqc7utV4MTiFN7kAvjc8eFUOY4osXvRArmNIsu505L9nB6AI+xsgzjX5JGx/5ViuJ0n8bqBYj
 U+ysziUAiAav5OxwipDXGW81XzaCTYxh160H8CzOMON+apW2nl6+M24eIxkxaymUia8oPpV14
 p9amIMsMYv4GEY8PjuQBJyrbri4pBEjybHcTKRUFWkTHtM8UBzmjfXFrSy6Ekrt0NU10=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for handling the PPPOEIOCSFWD ioctl in compat mode was added in
linux-2.5.69 along with hundreds of other commands, but was always broken
sincen only the structure is compatible, but the command number is not,
due to the size being sizeof(size_t), or at first sizeof(sizeof((struct
sockaddr_pppox)), which is different on 64-bit architectures.

Fix it by defining a separate command code that matches the 32-bit
version, and marking that one as compatible.

This should apply to all stable kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ppp/pppoe.c  | 4 ++++
 fs/compat_ioctl.c        | 2 +-
 include/linux/if_pppox.h | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index ce61231e96ea..d1c3f9292c54 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -57,6 +57,7 @@
  *
  */
 
+#include <linux/compat.h>
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -780,6 +781,9 @@ static int pppoe_ioctl(struct socket *sock, unsigned int cmd,
 		err = 0;
 		break;
 
+#ifdef CONFIG_COMPAT
+	case PPPOEIOCSFWD32:
+#endif
 	case PPPOEIOCSFWD:
 	{
 		struct pppox_sock *relay_po;
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a9b00942e87d..a8bb193fdfd5 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -895,7 +895,7 @@ COMPATIBLE_IOCTL(PPPIOCATTCHAN)
 COMPATIBLE_IOCTL(PPPIOCGCHAN)
 COMPATIBLE_IOCTL(PPPIOCGL2TPSTATS)
 /* PPPOX */
-COMPATIBLE_IOCTL(PPPOEIOCSFWD)
+COMPATIBLE_IOCTL(PPPOEIOCSFWD32)
 COMPATIBLE_IOCTL(PPPOEIOCDFWD)
 /* Big A */
 /* sparc only */
diff --git a/include/linux/if_pppox.h b/include/linux/if_pppox.h
index ba7a9b0c7c57..d221f1465f41 100644
--- a/include/linux/if_pppox.h
+++ b/include/linux/if_pppox.h
@@ -85,6 +85,8 @@ extern void unregister_pppox_proto(int proto_num);
 extern void pppox_unbind_sock(struct sock *sk);/* delete ppp-channel binding */
 extern int pppox_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 
+#define PPPOEIOCSFWD32    _IOW(0xB1 ,0, compat_size_t)
+
 /* PPPoX socket states */
 enum {
     PPPOX_NONE		= 0,  /* initial state */
-- 
2.18.0

