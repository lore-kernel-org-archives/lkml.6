Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FD2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D192083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D192083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbeH2SEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:04:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2SEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:04:04 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MHaGK-1fw7382N7E-003NSY; Wed, 29 Aug 2018 16:06:42 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     paulus@samba.org, linux-ppp@vger.kernel.org, netdev@vger.kernel.org
Cc:     mitch@sfgoth.com, mostrows@earthlink.net, jchapman@katalix.com,
        xeb@mail.ru, davem@davemloft.net, viro@zeniv.linux.org.uk,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Karsten Keil <isdn@linux-pingi.de>, linux-doc@vger.kernel.org
Subject: [PATCH net-next 5/5] ppp: handle PPPIOCGIDLE for 64-bit time_t
Date:   Wed, 29 Aug 2018 16:03:30 +0200
Message-Id: <20180829140409.833488-5-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829140409.833488-1-arnd@arndb.de>
References: <20180829140409.833488-1-arnd@arndb.de>
X-Provags-ID: V03:K1:3yMaMaJHSuseUT6R33oqChcHfXJoiJUPAlJHq/gnpUWn+lQyNN7
 +12GeGXkelORL9hdX83nsixFhDxIKt7tkfhNLD/+iXVs72f53iEUqplcsgbqVnLrc6GGxkr
 9Gu0Rqs5DUGFXmj1/wVQfBTgsZ4fESR3iJ2oAq7XDWCZltQUKyRl0i25RpTUEakTDFGODWz
 fe7A3m4eXGELQBVNnP1SQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f1/vr8aNrHI=:9xETSTbvhbVOHUiuqeJHP5
 YIMD2fB6VECthOeeNEJ+Ga8ElEg7gm37dXt6PdQ9dJOwq16ujCC6XzoFWGCDBrvBdeed/pB5b
 +9nRzSQiUPRbgtml9i1u06gLRs/v6rRWdRJ88b6wY0e4363nK/oUx2Lx51ue26zEUJ931eRBq
 zPe+XLUVNpbAVFTlpzHqq2zDgB8fBvm6LmqAMh7HvlZ+98+TT9+hXZt465fXtZBHfWcs3wIgV
 k+lBPvd1cUUeQJcjqGXjIOQl4uIbT/ItMie1KaOmLKDoZz5FPRG9haqatKRoobvf0fnTdjc29
 5+KZkqNA5uPshS8LJVUM4IWqtPX9bqadmO5ii8SsILKswm+MmeCXQtzYSWun4+xGhPl4vsrQ9
 yZDuTZ//x47FwAh9krHyYC+fsx/pXX7dtew6CCiVky5sxF1AjSJnItOKWnKG3S17s0U3bagH5
 pl0Ml/efYlAfUI6wnpZMgN0xO/ilarFHjximm/yLDY6PS7shhTnQi+X8jgDB/DQMs6MUun62C
 uUefUdtEdBSH3Xk93vEYiLM5Eg82v7JjBrsKDxZ9TgDcEp1DSdOfrF7W/ad3dkO+0OhxswvlU
 KH9nbhJf8w5PILyiaoccapiA814AT3KBvwvXV3mC9ZGCfmpfdXihSOjL6j/hP1BbEbOY5ajZt
 pQetOjNvEmtvqaRHvk/05wm9z8izQ6qyats+4xnLLVyQtNrGHwHh+9qzqQI6mmgtj7aA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ppp_idle structure is defined in terms of __kernel_time_t, which is
defined as 'long' on all architectures, and this usage is not affected
by the y2038 problem since it transports a time interval rather than an
absolute time.

However, the ppp user space defines the same structure as time_t, which
may be 64-bit wide on new libc versions even on 32-bit architectures.

It's easy enough to just handle both possible structure layouts on
all architectures, to deal with the possibility that a user space ppp
implementation comes with its own ppp_idle structure definition, as well
as to document the fact that the driver is y2038-safe.

Doing this also avoids the need for a special compat mode translation,
since 32-bit and 64-bit kernels now support the same interfaces.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/networking/ppp_generic.txt |  2 ++
 drivers/isdn/i4l/isdn_ppp.c              | 14 ++++++++---
 drivers/net/ppp/ppp_generic.c            | 18 ++++++++++----
 fs/compat_ioctl.c                        | 31 ------------------------
 include/uapi/linux/ppp-ioctl.h           |  2 ++
 include/uapi/linux/ppp_defs.h            | 14 +++++++++++
 6 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/Documentation/networking/ppp_generic.txt b/Documentation/networking/ppp_generic.txt
index 61daf4b39600..fd563aff5fc9 100644
--- a/Documentation/networking/ppp_generic.txt
+++ b/Documentation/networking/ppp_generic.txt
@@ -378,6 +378,8 @@ an interface unit are:
   CONFIG_PPP_FILTER option is enabled, the set of packets which reset
   the transmit and receive idle timers is restricted to those which
   pass the `active' packet filter.
+  Two versions of this command exist, to deal with user space
+  expecting times as either 32-bit or 64-bit time_t seconds.
 
 * PPPIOCSMAXCID sets the maximum connection-ID parameter (and thus the
   number of connection slots) for the TCP header compressor and
diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
index a7b275ea5de1..1f17126c5fa4 100644
--- a/drivers/isdn/i4l/isdn_ppp.c
+++ b/drivers/isdn/i4l/isdn_ppp.c
@@ -543,11 +543,19 @@ isdn_ppp_ioctl(int min, struct file *file, unsigned int cmd, unsigned long arg)
 		}
 		is->pppcfg = val;
 		break;
-	case PPPIOCGIDLE:	/* get idle time information */
+	case PPPIOCGIDLE32:	/* get idle time information */
 		if (lp) {
-			struct ppp_idle pidle;
+			struct ppp_idle32 pidle;
 			pidle.xmit_idle = pidle.recv_idle = lp->huptimer;
-			if ((r = set_arg(argp, &pidle, sizeof(struct ppp_idle))))
+			if ((r = set_arg(argp, &pidle, sizeof(struct ppp_idle32))))
+				return r;
+		}
+		break;
+	case PPPIOCGIDLE64:	/* get idle time information */
+		if (lp) {
+			struct ppp_idle64 pidle;
+			pidle.xmit_idle = pidle.recv_idle = lp->huptimer;
+			if ((r = set_arg(argp, &pidle, sizeof(struct ppp_idle64))))
 				return r;
 		}
 		break;
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 3a7aa2eed415..c8b8aa071140 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -619,7 +619,8 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct ppp_file *pf;
 	struct ppp *ppp;
 	int err = -EFAULT, val, val2, i;
-	struct ppp_idle idle;
+	struct ppp_idle32 idle32;
+	struct ppp_idle64 idle64;
 	struct npioctl npi;
 	int unit, cflags;
 	struct slcompress *vj;
@@ -743,10 +744,17 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		err = 0;
 		break;
 
-	case PPPIOCGIDLE:
-		idle.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
-		idle.recv_idle = (jiffies - ppp->last_recv) / HZ;
-		if (copy_to_user(argp, &idle, sizeof(idle)))
+	case PPPIOCGIDLE32:
+                idle32.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
+                idle32.recv_idle = (jiffies - ppp->last_recv) / HZ;
+                if (copy_to_user(argp, &idle32, sizeof(idle32)))
+		err = 0;
+		break;
+
+	case PPPIOCGIDLE64:
+		idle64.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
+		idle64.recv_idle = (jiffies - ppp->last_recv) / HZ;
+		if (copy_to_user(argp, &idle32, sizeof(idle32)))
 			break;
 		err = 0;
 		break;
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 258c6938e80a..208ff51f3ed9 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -377,36 +377,7 @@ static int sg_grt_trans(struct file *file,
 	}
 	return err;
 }
-#endif /* CONFIG_BLOCK */
-
-struct ppp_idle32 {
-	compat_time_t xmit_idle;
-	compat_time_t recv_idle;
-};
-#define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
-
-static int ppp_gidle(struct file *file, unsigned int cmd,
-		struct ppp_idle32 __user *idle32)
-{
-	struct ppp_idle __user *idle;
-	__kernel_time_t xmit, recv;
-	int err;
-
-	idle = compat_alloc_user_space(sizeof(*idle));
-
-	err = do_ioctl(file, PPPIOCGIDLE, (unsigned long) idle);
 
-	if (!err) {
-		if (get_user(xmit, &idle->xmit_idle) ||
-		    get_user(recv, &idle->recv_idle) ||
-		    put_user(xmit, &idle32->xmit_idle) ||
-		    put_user(recv, &idle32->recv_idle))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-#ifdef CONFIG_BLOCK
 struct mtget32 {
 	compat_long_t	mt_type;
 	compat_long_t	mt_resid;
@@ -1182,8 +1153,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	void __user *argp = compat_ptr(arg);
 
 	switch (cmd) {
-	case PPPIOCGIDLE32:
-		return ppp_gidle(file, cmd, argp);
 #ifdef CONFIG_BLOCK
 	case SG_IO:
 		return sg_ioctl_trans(file, cmd, argp);
diff --git a/include/uapi/linux/ppp-ioctl.h b/include/uapi/linux/ppp-ioctl.h
index 88b5f9990320..7bd2a5a75348 100644
--- a/include/uapi/linux/ppp-ioctl.h
+++ b/include/uapi/linux/ppp-ioctl.h
@@ -104,6 +104,8 @@ struct pppol2tp_ioc_stats {
 #define PPPIOCGDEBUG	_IOR('t', 65, int)	/* Read debug level */
 #define PPPIOCSDEBUG	_IOW('t', 64, int)	/* Set debug level */
 #define PPPIOCGIDLE	_IOR('t', 63, struct ppp_idle) /* get idle time */
+#define PPPIOCGIDLE32	_IOR('t', 63, struct ppp_idle32) /* 32-bit times */
+#define PPPIOCGIDLE64	_IOR('t', 63, struct ppp_idle64) /* 64-bit times */
 #define PPPIOCNEWUNIT	_IOWR('t', 62, int)	/* create new ppp unit */
 #define PPPIOCATTACH	_IOW('t', 61, int)	/* attach to ppp unit */
 #define PPPIOCDETACH	_IOW('t', 60, int)	/* obsolete, do not use */
diff --git a/include/uapi/linux/ppp_defs.h b/include/uapi/linux/ppp_defs.h
index fff51b91b409..0039fa39a358 100644
--- a/include/uapi/linux/ppp_defs.h
+++ b/include/uapi/linux/ppp_defs.h
@@ -142,10 +142,24 @@ struct ppp_comp_stats {
 /*
  * The following structure records the time in seconds since
  * the last NP packet was sent or received.
+ *
+ * Linux implements both 32-bit and 64-bit time_t versions
+ * for compatibility with user space that defines ppp_idle
+ * based on the libc time_t.
  */
 struct ppp_idle {
     __kernel_time_t xmit_idle;	/* time since last NP packet sent */
     __kernel_time_t recv_idle;	/* time since last NP packet received */
 };
 
+struct ppp_idle32 {
+    __s32 xmit_idle;		/* time since last NP packet sent */
+    __s32 recv_idle;		/* time since last NP packet received */
+};
+
+struct ppp_idle64 {
+    __s64 xmit_idle;		/* time since last NP packet sent */
+    __s64 recv_idle;		/* time since last NP packet received */
+};
+
 #endif /* _UAPI_PPP_DEFS_H_ */
-- 
2.18.0

