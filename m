Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82342C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FD42075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FD42075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeIHBmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeIHBmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:42:15 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4B92087F;
        Fri,  7 Sep 2018 20:59:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fyNqm-0001sF-Qy; Fri, 07 Sep 2018 16:59:32 -0400
Message-Id: <20180907205932.723319792@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 16:59:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Mike Galbraith <efault@gmx.de>
Subject: [PATCH RT 18/24] crypto: scompress - serialize RT percpu scratch buffer access with a
 local lock
References: <20180907205857.262840394@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <efault@gmx.de>

[ Upstream commit 1a4eff3f8e743d149be26a414822710aef07fe14 ]

| BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
| in_atomic(): 1, irqs_disabled(): 0, pid: 1401, name: cryptomgr_test
| Preemption disabled at:
| [<ffff00000849941c>] scomp_acomp_comp_decomp+0x34/0x1a0
| CPU: 21 PID: 1401 Comm: cryptomgr_test Tainted: G        W        4.16.18-rt9-rt #1
| Hardware name: www.cavium.com crb-1s/crb-1s, BIOS 0.3 Apr 25 2017
| Call trace:
|  dump_backtrace+0x0/0x1c8
|  show_stack+0x24/0x30
|  dump_stack+0xac/0xe8
|  ___might_sleep+0x124/0x188
|  rt_spin_lock+0x40/0x88
|  zip_load_instr+0x44/0x170 [thunderx_zip]
|  zip_deflate+0x184/0x378 [thunderx_zip]
|  zip_compress+0xb0/0x130 [thunderx_zip]
|  zip_scomp_compress+0x48/0x60 [thunderx_zip]
|  scomp_acomp_comp_decomp+0xd8/0x1a0
|  scomp_acomp_compress+0x24/0x30
|  test_acomp+0x15c/0x558
|  alg_test_comp+0xc0/0x128
|  alg_test.part.6+0x120/0x2c0
|  alg_test+0x6c/0xa0
|  cryptomgr_test+0x50/0x58
|  kthread+0x134/0x138
|  ret_from_fork+0x10/0x18

Mainline disables preemption to serialize percpu scratch buffer access,
causing the splat above.  Serialize with a local lock for RT instead.

Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 crypto/scompress.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 2075e2c4e7df..c6b4e265c6bf 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -24,6 +24,7 @@
 #include <linux/cryptouser.h>
 #include <net/netlink.h>
 #include <linux/scatterlist.h>
+#include <linux/locallock.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/internal/acompress.h>
 #include <crypto/internal/scompress.h>
@@ -34,6 +35,7 @@ static void * __percpu *scomp_src_scratches;
 static void * __percpu *scomp_dst_scratches;
 static int scomp_scratch_users;
 static DEFINE_MUTEX(scomp_lock);
+static DEFINE_LOCAL_IRQ_LOCK(scomp_scratches_lock);
 
 #ifdef CONFIG_NET
 static int crypto_scomp_report(struct sk_buff *skb, struct crypto_alg *alg)
@@ -193,7 +195,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	void **tfm_ctx = acomp_tfm_ctx(tfm);
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
-	const int cpu = get_cpu();
+	const int cpu = local_lock_cpu(scomp_scratches_lock);
 	u8 *scratch_src = *per_cpu_ptr(scomp_src_scratches, cpu);
 	u8 *scratch_dst = *per_cpu_ptr(scomp_dst_scratches, cpu);
 	int ret;
@@ -228,7 +230,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 					 1);
 	}
 out:
-	put_cpu();
+	local_unlock_cpu(scomp_scratches_lock);
 	return ret;
 }
 
-- 
2.18.0


