Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E640DC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BF720837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gl2pWT01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BF720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeLGQfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:35:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40966 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeLGQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:35:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so4374100wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQ+PJLKTzPpPTHfRUO6Ar2xCC5SpgIGYufiOB0FS4tU=;
        b=gl2pWT01E6DtIS0VB3E+M3TdRA2UczDDViVaFKLZICkugVcs3tMZgr6DqD6QEuS/f8
         OKBSETt6bnVUol7H2Yby/FbXMJlhYzhH+2OE2/BruiKeZyIrhb6urrG7tDGDB6TUsu05
         F0tKmuPQKlUKkBBeS9IbdgxqmI8N8L5IdgdH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQ+PJLKTzPpPTHfRUO6Ar2xCC5SpgIGYufiOB0FS4tU=;
        b=GpWRWh5jb4qqZdbGU4nwi+uDL42YH7PiJA+r6UN0NYBwBAsmaMSUOp+vo9vN092o9I
         5KO2lmTqyOpabEs67bZJITssY5BAwGdNnDLmhbUOVjuHBLQLcr8eGy5e4czQi++uiMgO
         GdLv1NW3GaIxY/0eX4+WRdtfoubcWzPvAgagnxpJY7+UEykSFROhKUj4NFkVm6uQ7spV
         4BbvzEAQS+dxx0a/ERAQBaCVo9TiMNgsuqu9pvryJ4A0PmnabNch6/QuxM6k0C9TErlO
         FqtHO78TDH+hb657l1hkrth9W0s4UH6FfJ3vfNeqEqsFrU0brvhwfSaCeOJU/bCvDTj9
         Ayiw==
X-Gm-Message-State: AA+aEWY4dRZRoqVvgzgB7eVUUnReipSD/WUS4Udy97fiBmylMuMWbNSY
        wf2hF1tdLWkM7pVRy72tLab0kg==
X-Google-Smtp-Source: AFSGD/VXFsWoExbPv3azgcK+bFLtQvwiTnHuGO5pb9M8qkN9sxRAxrG9Vz7FhqHx/uqNJOfKFUbRaQ==
X-Received: by 2002:adf:b783:: with SMTP id s3mr2518323wre.274.1544200524816;
        Fri, 07 Dec 2018 08:35:24 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w6sm4268752wme.46.2018.12.07.08.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 08:35:24 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 6/6] misc: fastrpc: Add support for compat ioctls
Date:   Fri,  7 Dec 2018 16:35:13 +0000
Message-Id: <20181207163513.16412-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for compat ioctl from 32 bits userland to
Qualcomm fastrpc driver.

Supported ioctls in this change are INIT, INVOKE, and ALLOC/FREE_DMA.

Most of the work is derived from various downstream Qualcomm kernels.
Credits to various Qualcomm authors who have contributed to this code.
Specially Tharun Kumar Merugu <mtharu@codeaurora.org>

Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 71 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5ea2bba1e4bd..f36657263183 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2011-2018, The Linux Foundation. All rights reserved.
 // Copyright (c) 2018, Linaro Limited
 
+#include <linux/compat.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
@@ -194,6 +195,22 @@ struct fastrpc_user {
 	struct mutex mutex;
 };
 
+#ifdef CONFIG_COMPAT
+
+#define FASTRPC_IOCTL_INVOKE32		_IOWR('R', 3, struct fastrpc_invoke32)
+struct fastrpc_invoke_args32 {
+	__s32 fd;
+	compat_size_t length;
+	compat_caddr_t ptr;
+};
+
+struct fastrpc_invoke32 {
+	__u32 handle;
+	__u32 sc;
+	compat_uptr_t args;
+};
+#endif
+
 static void fastrpc_free_map(struct kref *ref)
 {
 	struct fastrpc_map *map;
@@ -1092,6 +1109,52 @@ static long fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+static long fastrpc_invoke32(struct fastrpc_user *fl, compat_uptr_t arg)
+{
+	struct fastrpc_invoke_args32 *args32 = NULL;
+	struct fastrpc_invoke_args *args = NULL;
+	struct fastrpc_invoke32 inv32;
+	struct fastrpc_invoke inv;
+	int i, ret, nscalars;
+
+	if (copy_from_user(&inv32, compat_ptr(arg), sizeof(inv32)))
+		return -EFAULT;
+
+	inv.handle = inv32.handle;
+	inv.sc = inv32.sc;
+	inv.args = NULL;
+	nscalars = REMOTE_SCALARS_LENGTH(inv.sc);
+
+	if (nscalars) {
+		args32 = kcalloc(nscalars, sizeof(*args32), GFP_KERNEL);
+		if (!args32)
+			return -ENOMEM;
+
+		if (copy_from_user(args32, compat_ptr(inv32.args),
+				   nscalars * sizeof(*args32)))
+			return -EFAULT;
+
+		args = kcalloc(nscalars, sizeof(*args), GFP_KERNEL);
+		if (!args)
+			return -ENOMEM;
+
+		for (i = 0; i < nscalars; i++) {
+			args[i].length = args32[i].length;
+			args[i].ptr = (void *)(unsigned long)args32[i].ptr;
+			args[i].fd = args32[i].fd;
+		}
+		inv.args = &args[0];
+	}
+
+	ret = fastrpc_internal_invoke(fl, 0, &inv);
+	kfree(args32);
+	kfree(args);
+
+	return ret;
+}
+#endif
+
 static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg)
 {
@@ -1103,6 +1166,11 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_INVOKE:
 		err = fastrpc_invoke(fl, argp);
 		break;
+#ifdef CONFIG_COMPAT
+	case FASTRPC_IOCTL_INVOKE32:
+		err = fastrpc_invoke32(fl, ptr_to_compat(argp));
+		break;
+#endif
 	case FASTRPC_IOCTL_INIT_ATTACH:
 		err = fastrpc_init_attach(fl);
 		break;
@@ -1131,6 +1199,9 @@ static const struct file_operations fastrpc_fops = {
 	.open = fastrpc_device_open,
 	.release = fastrpc_device_release,
 	.unlocked_ioctl = fastrpc_device_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = fastrpc_device_ioctl,
+#endif
 };
 
 static int fastrpc_cb_probe(struct platform_device *pdev)
-- 
2.19.2

