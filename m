Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C792C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfBRVIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:08:50 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfBRVIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:08:00 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MlO9r-1hL1UD3zaP-00liHH; Mon, 18 Feb 2019 22:07:29 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
        arnd@arndb.de, linux-riscv@lists.infradead.org,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 6/8] checksyscalls: fix up mq_timedreceive and stat exceptions
Date:   Mon, 18 Feb 2019 22:07:10 +0100
Message-Id: <20190218210712.3503891-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UgT5qLzBRe8uGhCU9AyHn5Jt9cfHoQ+D0/iLF4gMTpdoEuzsO5q
 poQ3zyyety+N59s3VxhuXLURLB1ufFgiJP7cPrbxRJTMbWMQ7K0uKTGBFu/NpnSZWaFSdog
 T5gcp2hhQXO/x3YKwmnCZyKSdPjGDBSytrIMMHzUDbw9nXiaOEcLEtNWS47SPtFe0pvedzm
 Ahdkq9w/U6TCxmxQhHcnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FXDoJv4Bfvw=:6GGmsD/rmCT7ei5OeBL7DH
 t9coJHnvAkWeYWrmUafR5IWBjDhHbw2hVsAkjpwqjvj3M0jVTAtvr7aqtTJp3u2S6u2FYnMqW
 oespDKsgf17cgnskdeI7Sy/It7HDngnnl74fqB+LbOq6/d7fW09m7xuwmbqLX9HGP30okqkVC
 l7Rv7RBccaKtbAvSmZmfBLGqy4RvBP2v1u7W8bw0wCcDCNj/9OGlxnPdKoduPuCDMljPNKkFg
 JTtgWH8cJKfZZ2jO2wbH+O8AtgAx2NPL0R3zDybKPp0Dsvbr4choUvo5Ukzb/LYmpBH/5SqTj
 0eUWMq3UHbkVx8A/WLYPvrRLXGGufyIG3fJukEQka4tWA9POcGL7GbFZdx6cX1YBavQM6+ByU
 zU4K+JW1rJnKBnsQVgKCCms9O+DsmmG7AUmR4yF7tA00HB40Cy1HsgjbxYpo0aWBks6MLe+8E
 S7M6NSY9pyhl8HXrsGEtNZYBhlLUN0Cgw0vl8vgW3V9gq7fPe+GUbtgAxR7VsfN4YHZACoZ/p
 IzfbkPLQA2l7yP0ln+KZkpHc+jEUnWcCy6Leah+mx8/eM2RAQSXAVtrOZGtmgJWqm69jQKts1
 eeB3ScSFFC+r9IGdyNPr8m6apR0guzuUaE1Vw6q+1wIVfXRrJu6sT7SocYw82+e3UcDNhEurI
 7gyiHW/RS/RFQmAfCFQy82U8gb9TOHsW93BtxnO0Uva0vatR8Yfwov25b1QvqBmgsxezJ9Bpq
 o0d2GWfT3VWHoeSTt3tl9IAc2q/hmZNKR3+1xg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mq_timedreceive was spelled incorrectly, and we need exceptions
for new architectures that leave out newstat or stat64, implementing
only statx() now.

Fixes: 48166e6ea47d ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
Fixes: bf4b6a7d371e ("y2038: Remove stat64 family from default syscall set")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/checksyscalls.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index ffd635efbdca..a18b47695f55 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -30,13 +30,10 @@ cat << EOF
 #define __IGNORE_readlink	/* readlinkat */
 #define __IGNORE_symlink	/* symlinkat */
 #define __IGNORE_utimes		/* futimesat */
-#if BITS_PER_LONG == 64
 #define __IGNORE_stat		/* fstatat */
 #define __IGNORE_lstat		/* fstatat */
-#else
 #define __IGNORE_stat64		/* fstatat64 */
 #define __IGNORE_lstat64	/* fstatat64 */
-#endif
 
 #ifndef __ARCH_WANT_SET_GET_RLIMIT
 #define __IGNORE_getrlimit	/* getrlimit */
@@ -138,7 +135,7 @@ cat << EOF
 #define __IGNORE_io_pgetevents
 #define __IGNORE_recvmmsg
 #define __IGNORE_mq_timedsend
-#define __IGNORE_mq_timedreceiv
+#define __IGNORE_mq_timedreceive
 #define __IGNORE_semtimedop
 #define __IGNORE_rt_sigtimedwait
 #define __IGNORE_futex
-- 
2.20.0

