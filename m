Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964CBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A66A23ED7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A66A23ED7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933207AbeGFM6M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:58:12 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeGFM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:58:10 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M57wk-1gK3hj47G2-00zHrR; Fri, 06 Jul 2018 14:58:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rohit kumar <rohitkr@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: qcom q6v5: fix modular build
Date:   Fri,  6 Jul 2018 14:57:53 +0200
Message-Id: <20180706125804.3572356-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:fYjIpTCZeiuDLYyttD5TMJmFddXwIZ3tagL/l5VM0K82PkzJijH
 dBd/nr0KCIRwTzOgDXDvhayOVMBB9hHKp3GinnVVMhGdhnSU75/MRlLuTlH6wYjr0ftquUL
 NnApXOMdnQuhXBJOQKyz54bvDCFnNVAlYIfAf1zbet+/RLaC6KeTZkksqkxwL7NXdCBDPiq
 JWc0D0K4D9CaYcQ7kR/XQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eR00jwDB2zI=:7mb4k/OailC9ldFTnj1rAP
 BwZicdybztTFpLVIQffT+k9umjzBIpzzSFdrs1EuOOznaYXfxZ4r4jwUBaTUJmfYRFIBwcrph
 U3vZp4WAtEC/4q7IAz+DjZmYaVlkE5716sPCoUU18KoOfHIay2UEyGqv4ELkleBfnlYGYHVtZ
 MmQKnBGS5BxUSFOrdSS0t1RX4c6eTFmPcBlcJaErDhd4XWjNz6KmoBB1IfC3nwU17UyZlB/ad
 AtxormRwa4rYzn5MFZRFVc01+MWb4EKswLf5hxUjZDbxZSxe5of+j+iZh2kBu/pvTkwH1H+6K
 iPXig2+NjFow0O4T/Oje9fWtB6LgeIVxpKDk+pXpCDdFmqrs56vtrB/424KNcTAkEz/CsdKdW
 ntYZUIY8j72A//LjuRGgUvnq9iwtxk1NDHpuKvFcyKsZT0pDw8DHVBwOmm+gfMs6q7xnntMFG
 VbkB2ysfH51TJmj7Hc4IVPkSO6Am2SURuOScoEzJ9eZsf7sKSOBpftZEyGJNfK9z47FOpd3Rf
 /W5na+mzuEgHmh2eZBKOHS6HMLYbSNqy5NVahxIfI6Trne04P3lc2+p88rZbxsncRyTAnxK+1
 SgtSJXAqgWL5owiUQfZCjmA2lNhvxIllgoy31/jXN5S4OjQfqZXubjcHGDK3BC6rglx8sc95T
 mNpU1XBQApbfAqbqoM6cUko8iicCfVuzjslZnzeBPnrpXM0fHhqFXYISDL3vbbOSgHRY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new driver only works as built-in code at the moment but fails
with a link error when configured as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/remoteproc/qcom_q6v5.o
see include/linux/module.h for more information
ERROR: "qcom_q6v5_init" [drivers/remoteproc/qcom_q6v5_pil.ko] undefined!
ERROR: "qcom_q6v5_wait_for_start" [drivers/remoteproc/qcom_q6v5_pil.ko] undefined!
ERROR: "qcom_q6v5_prepare" [drivers/remoteproc/qcom_q6v5_pil.ko] undefined!
ERROR: "qcom_q6v5_unprepare" [drivers/remoteproc/qcom_q6v5_pil.ko] undefined!
ERROR: "qcom_q6v5_request_stop" [drivers/remoteproc/qcom_q6v5_pil.ko] undefined!
ERROR: "qcom_q6v5_init" [drivers/remoteproc/qcom_adsp_pil.ko] undefined!
ERROR: "qcom_q6v5_wait_for_start" [drivers/remoteproc/qcom_adsp_pil.ko] undefined!
ERROR: "qcom_q6v5_prepare" [drivers/remoteproc/qcom_adsp_pil.ko] undefined!
ERROR: "qcom_q6v5_unprepare" [drivers/remoteproc/qcom_adsp_pil.ko] undefined!
ERROR: "qcom_q6v5_request_stop" [drivers/remoteproc/qcom_adsp_pil.ko] undefined!

This exports the internal symbols as needed and adds the MODULE_LICENSE()
and MODULE_DESCRIPTION() tags. I could not figure out the author, so I
did not add a MODULE_AUTHOR() tag for now.

Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource handling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/remoteproc/qcom_q6v5.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 400cdf936f6b..61a760ee4aac 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/remoteproc.h>
@@ -32,6 +33,7 @@ int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(qcom_q6v5_prepare);
 
 /**
  * qcom_q6v5_unprepare() - unprepare the qcom_q6v5 context after stop
@@ -45,6 +47,7 @@ int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5)
 
 	return !q6v5->handover_issued;
 }
+EXPORT_SYMBOL_GPL(qcom_q6v5_unprepare);
 
 static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 {
@@ -114,6 +117,7 @@ int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
 
 	return !ret ? -ETIMEDOUT : 0;
 }
+EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_start);
 
 static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
 {
@@ -157,6 +161,7 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5)
 
 	return ret == 0 ? -ETIMEDOUT : 0;
 }
+EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
 
 /**
  * qcom_q6v5_init() - initializer of the q6v5 common struct
@@ -241,3 +246,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(qcom_q6v5_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Qualcomm Peripheral Image Loader for Q6V5");
-- 
2.9.0

