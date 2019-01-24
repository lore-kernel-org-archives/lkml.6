Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8670C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B385421872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZIPSiqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfAXRcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:32:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44799 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfAXRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:32:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so5952304lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KWJ7bHoK/sF4rrqF5MiZ+1DYYfCAJZqlGq6hSezEKP8=;
        b=eZIPSiqL34TBnH/ER0RA6ai9bEeY4M1ZpoObjCS9/M6AfopBGmh7yIayEA9iLDS9IJ
         gz0lnDpwKMSMa7WyBcOp0p3LoK/vPqOtk0dJ8gnq+ganaUw1Xzaljvb8cAScLLDi0Yy/
         850NdW40fcIYwxElFfZdR9FozwKjYocgDNFWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KWJ7bHoK/sF4rrqF5MiZ+1DYYfCAJZqlGq6hSezEKP8=;
        b=HOIdVgzK5lci+DPxq8etoT1vsOQrOs2sCOkHsaHB77Vm3AKHZEtHo9DOD5tWTJrYOk
         ZnjQY1o2I3f8pkyfdbHZ2Fztyxn38C3I0Qn1/9Gk+0TsGJJzEqB4p/tJ6UmjBOnjSE9Q
         L65TNjfgo3J1XdbMGLeSMx+IfvJBguYxTThMOvHKBy89PZBP4KsiVMen2w0Lsnz8sB+E
         R7dwg44m4PvKgonlkgTA5gRAgAgcv1MG71VkXUvespJlcVvC8I5rH9fIoMRFOqwtWshi
         mMTATMJsrDYeiBZXTRiZSRI+nrzdpcpqXOVy6yVKnDtj1yShPqhy+ZrIPN7wz49wwV+l
         OOFw==
X-Gm-Message-State: AJcUukekSJD2sJOdBT/XSYaxIxeKp932BvDRi2Suj9v71i+yvknCBijY
        q/PHfTs/SHyC7fPOn7wO7CLDza/jkHE=
X-Google-Smtp-Source: ALg8bN78g8GAJjJPsLdp+v2YHWnYh/cST8kguvz/X6aUB/7KFq3QiTSmsFFYUYHrs8rIgWHd3+WDCw==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr6600436ljf.96.1548351153486;
        Thu, 24 Jan 2019 09:32:33 -0800 (PST)
Received: from localhost ([195.238.92.223])
        by smtp.gmail.com with ESMTPSA id y81-v6sm1113700lje.30.2019.01.24.09.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 09:32:32 -0800 (PST)
From:   Igor Opaniuk <igor.opaniuk@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org
Cc:     jerome.forissier@linaro.org, jens.wiklander@linaro.org,
        prime.zeng@hisilicon.com, sumit.garg@linaro.org
Subject: [PATCH v2 1/1] tee: add cancellation support to client interface
Date:   Thu, 24 Jan 2019 19:32:31 +0200
Message-Id: <1548351151-3722-1-git-send-email-igor.opaniuk@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of cancellation request to the TEE kernel internal
client interface. Can be used by software TPM drivers, that leverage
TEE under the hood (for instance TPM2.0 mobile profile), for requesting
cancellation of time-consuming operations (RSA key-pair generation etc.).

Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
---

v2:
- use tee_ioctl_cancel_arg to provide session and cancel_id
- fix tee_client_cancel_req function description header

 drivers/tee/tee_core.c  | 10 ++++++++++
 include/linux/tee_drv.h | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 7b2bb4c..1148175 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1027,6 +1027,16 @@ int tee_client_invoke_func(struct tee_context *ctx,
 }
 EXPORT_SYMBOL_GPL(tee_client_invoke_func);
 
+int tee_client_cancel_req(struct tee_context *ctx,
+			  struct tee_ioctl_cancel_arg *arg)
+{
+	if (!ctx->teedev->desc->ops->cancel_req)
+		return -EINVAL;
+	return ctx->teedev->desc->ops->cancel_req(ctx, arg->cancel_id,
+						  arg->session);
+}
+EXPORT_SYMBOL_GPL(tee_client_cancel_req);
+
 static int __init tee_init(void)
 {
 	int rc;
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 6cfe058..177016e 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -526,6 +526,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param);
 
+/**
+ * tee_client_cancel_req() - Request cancellation of the previous open-session
+ * or invoke-command operations in a Trusted Application
+ * @ctx:       TEE Context
+ * @arg:       Cancellation arguments, see description of
+ *             struct tee_ioctl_cancel_arg
+ *
+ * Returns < 0 on error else 0 if the cancellation was successfully requested.
+ */
+int tee_client_cancel_req(struct tee_context *ctx,
+			  struct tee_ioctl_cancel_arg *arg);
+
 static inline bool tee_param_is_memref(struct tee_param *param)
 {
 	switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
-- 
2.7.4

