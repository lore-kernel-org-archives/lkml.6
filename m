Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D0EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B64F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B64F20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=xiaomi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJ3QrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:47:20 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.126]:52637 "EHLO
        outboundhk.mxmail.xiaomi.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbeJ3QrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:47:20 -0400
X-AuditID: 0a3808ce-4afff70000012663-85-5bd80ddce9e1
Received: from xiaomi.com (cnbox2.mioffice.cn [10.237.8.142])
        by outboundhk.mxmail.xiaomi.com (xiaomi.com) with SMTP id D7.77.09827.CDD08DB5; Tue, 30 Oct 2018 15:53:00 +0800 (HKT)
Received: from localhost (10.237.91.193) by cnbox2.mioffice.cn (10.237.8.142)
 with Microsoft SMTP Server (TLS) id 15.0.1365.1; Tue, 30 Oct 2018 15:52:59
 +0800
From:   Peng Wang <wangpeng15@xiaomi.com>
To:     <keescook@chromium.org>, <anton@enomsg.org>, <ccross@android.com>,
        <tony.luck@intel.com>, <joel@joelfernandes.org>
CC:     <linux-kernel@vger.kernel.org>, <vipwangerxiao@gmail.com>,
        Peng Wang <wangpeng15@xiaomi.com>
Subject: [PATCH v4] pstore: Avoid duplicate call of persistent_ram_zap()
Date:   Tue, 30 Oct 2018 15:52:34 +0800
Message-ID: <20181030075234.21137-1-wangpeng15@xiaomi.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.237.91.193]
X-ClientProxiedBy: CNCAS1.mioffice.cn (10.237.8.131) To cnbox2.mioffice.cn
 (10.237.8.142)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZajT/cO741og9uv1C0ObtW02L7xG6vF
        sgZVizPduRaXd81hs3hz4R6Lxcmfy1kd2D227d7G6jG74SKLx4T+T4weO2fdZfdYvOclk8fC
        T19ZPT5vkgtgj+KySUnNySxLLdK3S+DK2Ln/N2vBZaGKd3ffMTUwdvF3MXJySAiYSFy4eIm9
        i5GLQ0hgK6PEh4mbWCCcRYwS805fYQepYhNQl+je3gVmiwhUSFzdf4kNxGYWSJK48ekCmC0s
        4CGx9NxJVhCbRUBV4sq3v2A2r4CVxL2JL9ggtslLNOzazA4RF5Q4OfMJC8QceYnmrbOZIWwJ
        iYMvXoDZQgJKEhuutwP1cgD1Kkr8+h8LMSZa4sHvGWwTGAVmIZk0C8mkWUgmLWBkXsUomZGf
        l54NxMUFibmGermZ+Wlpmcmpesl5mxhBoW/BcW4H44R3qYcYBTgYlXh4G/SuRwuxJpYVV+Ye
        YpTgYFYS4Q3muhEtxJuSWFmVWpQfX1Sak1p8iFGag0VJnNeg8UC0kEB6YklqdmpqQWoRTJaJ
        g1OqgdFhTvvWYtG5KWF3nFaUymStUPp2tzI3bfnC0P8Tf1peSpvuZKZz93qwi0/wtGWVb42K
        zySqh/hGdk9z14pjcr70RfT2VWFjGxbRYo3pS6LkLPzuPHitt4RJ9u42ToOjL7i4T/24MDuv
        dkN9z6U/MXsX7WC5XD7TzeZd1dUVe5y2fnbZfGnHx2QlluKMREMt5qLiRADSMDL6eQIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initialing prz with invalid data in buffer(no PERSISTENT_RAM_SIG),
function call path is like this:

ramoops_init_prz ->
|
|-> persistent_ram_new -> persistent_ram_post_init -> persistent_ram_zap
|
|-> persistent_ram_zap

As we can see, persistent_ram_zap() is called twice.
We can avoid this by adding an option to persistent_ram_new(), and
only call persistent_ram_zap() when it is needed.

Signed-off-by: Peng Wang <wangpeng15@xiaomi.com>
---
 fs/pstore/ram.c            | 4 +---
 fs/pstore/ram_core.c       | 5 +++--
 include/linux/pstore_ram.h | 1 +
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ffcff6516e89..b51901f97dc2 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -640,7 +640,7 @@ static int ramoops_init_prz(const char *name,
 
 	label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
 	*prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
-				  cxt->memtype, 0, label);
+				  cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
 	if (IS_ERR(*prz)) {
 		int err = PTR_ERR(*prz);
 
@@ -649,8 +649,6 @@ static int ramoops_init_prz(const char *name,
 		return err;
 	}
 
-	persistent_ram_zap(*prz);
-
 	*paddr += sz;
 
 	return 0;
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 12e21f789194..2ededd1ea1c2 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -505,15 +505,16 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 			pr_debug("found existing buffer, size %zu, start %zu\n",
 				 buffer_size(prz), buffer_start(prz));
 			persistent_ram_save_old(prz);
-			return 0;
+			if (!(prz->flags & PRZ_FLAG_ZAP_OLD))
+				return 0;
 		}
 	} else {
 		pr_debug("no valid data in buffer (sig = 0x%08x)\n",
 			 prz->buffer->sig);
+		prz->buffer->sig = sig;
 	}
 
 	/* Rewind missing or invalid memory area. */
-	prz->buffer->sig = sig;
 	persistent_ram_zap(prz);
 
 	return 0;
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 602d64725222..6e94980357d2 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -30,6 +30,7 @@
  * PRZ_FLAG_NO_LOCK is used. For all other cases, locking is required.
  */
 #define PRZ_FLAG_NO_LOCK	BIT(0)
+#define PRZ_FLAG_ZAP_OLD	BIT(1)
 
 struct persistent_ram_buffer;
 struct rs_control;
-- 
2.19.1

