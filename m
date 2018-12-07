Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C3220868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cv6iGX4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C3220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeLGQfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:35:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45043 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLGQfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:35:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so4353702wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSj3fdMMzho6wZgYvLNiLtO6E/C345g53NObmvAcTok=;
        b=cv6iGX4t19Rk0mRaqsNePtGHFTt7bRRHnusH2il0AIpA/wJHey9d7U6tqhzl2cdsc9
         F+ZDTij3C/e6+8JtG/lZgvNEC9ErinkH+F+xlHgKWaDXfWDkCebrXdh6n3SjgprByQba
         KMe8o8fyGCMJABZazK1hDtAQOU+HVISB/qTVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSj3fdMMzho6wZgYvLNiLtO6E/C345g53NObmvAcTok=;
        b=VnmVZnDOT3OJW4kiHCBJTKWswrhcSlY6In0beSwl9PJ0EP69O8EFtujZ0uDaoaQSyA
         xZnu2nFaF06nhTGL1EhH4rJm7cqm1F1MN7DEbstZnsVoYcwjZLBl6c4Ua1jXfcO45SwI
         g67Qak6/D69+xHqkcd/i49Rs3ffak9GiwX1kYItoUaIOn96NhMXb03HsB+mSL29boaGn
         K+tWdq78M8HsjZ/wmKBDRMoLEzp78TvpnaKlV9wPUnGHCaub4Ooq545D5AnFSrF/Ob4L
         5FrN6AkhBXSbc8O7jEbR/9qS0CsPv2xSb8q8TtLQXjZpmidwIG/MEWWIUCl3O85ws6ls
         5NxA==
X-Gm-Message-State: AA+aEWaB8xEYc7uxgkE2Ms8iobYvaiaKCMQ6WtB4P32rWoVWMJxnmFJW
        1WpqFzPMYQLb0hBfBX7YH0dgBw==
X-Google-Smtp-Source: AFSGD/XyFIfbXbd9IZ/X42hQ/1GpD6KO8FA5CIdepsedfx++83Z44aXGhigNJ8mg51y6hGM+9BKJcg==
X-Received: by 2002:adf:aac6:: with SMTP id i6mr2339945wrc.216.1544200522552;
        Fri, 07 Dec 2018 08:35:22 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w6sm4268752wme.46.2018.12.07.08.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 08:35:21 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/6] misc: fastrpc: Add support for create remote init process
Date:   Fri,  7 Dec 2018 16:35:11 +0000
Message-Id: <20181207163513.16412-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to create or attach remote shell process.
The shell process called fastrpc_shell_0 is usually loaded on the DSP
when a user process is spawned.

Most of the work is derived from various downstream Qualcomm kernels.
Credits to various Qualcomm authors who have contributed to this code.
Specially Tharun Kumar Merugu <mtharu@codeaurora.org>

Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 140 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |  12 ++++
 2 files changed, 152 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 46435813785d..fda674e9efe2 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -29,7 +29,10 @@
 #define FASTRPC_MAX_CRCLIST	64
 #define FASTRPC_PHYS(p)	((p) & 0xffffffff)
 #define FASTRPC_CTX_MAX (256)
+#define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_CTXID_MASK (0xFF0)
+#define INIT_FILELEN_MAX (2 * 1024 * 1024)
+#define INIT_MEMLEN_MAX  (8 * 1024 * 1024)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 
 /* Retrives number of input buffers from the scalars parameter */
@@ -60,6 +63,13 @@
 #define FASTRPC_SCALARS(method, in, out) \
 		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
 
+/* Remote Method id table */
+#define FASTRPC_RMID_INIT_ATTACH	0
+#define FASTRPC_RMID_INIT_RELEASE	1
+#define FASTRPC_RMID_INIT_CREATE	6
+#define FASTRPC_RMID_INIT_CREATE_ATTR	7
+#define FASTRPC_RMID_INIT_CREATE_STATIC	8
+
 #define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
@@ -676,6 +686,94 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,
 	return err;
 }
 
+static long fastrpc_init_create_process(struct fastrpc_user *fl,
+					char __user *argp)
+{
+	struct fastrpc_init_create init;
+	struct fastrpc_invoke_args args[6];
+	struct fastrpc_phy_page pages[1];
+	struct fastrpc_invoke inv;
+	struct fastrpc_map *map = NULL;
+	struct fastrpc_buf *imem = NULL;
+	int err, memlen;
+	struct {
+		int pgid;
+		unsigned int namelen;
+		unsigned int filelen;
+		unsigned int pageslen;
+		int attrs;
+		int siglen;
+	} inbuf;
+
+	err = copy_from_user(&init, argp, sizeof(init));
+	if (err)
+		goto bail;
+
+	if (init.filelen > INIT_FILELEN_MAX ||
+	    init.memlen > INIT_MEMLEN_MAX)
+		goto bail;
+
+	inbuf.pgid = fl->tgid;
+	inbuf.namelen = strlen(current->comm) + 1;
+	inbuf.filelen = init.filelen;
+	inbuf.pageslen = 1;
+	inbuf.attrs = init.attrs;
+	inbuf.siglen = init.siglen;
+	fl->pd = 1;
+
+	if (init.filelen && init.filefd) {
+		err = fastrpc_map_create(fl, init.filefd, init.filelen, &map);
+		if (err)
+			goto bail;
+	}
+	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
+		       1024 * 1024);
+	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
+				&imem);
+	if (err)
+		goto bail;
+
+	fl->init_mem = imem;
+	args[0].ptr = &inbuf;
+	args[0].length = sizeof(inbuf);
+	args[0].fd = -1;
+
+	args[1].ptr = current->comm;
+	args[1].length = inbuf.namelen;
+	args[1].fd = -1;
+
+	args[2].ptr = (void *)init.file;
+	args[2].length = inbuf.filelen;
+	args[2].fd = init.filefd;
+
+	pages[0].addr = imem->phys;
+	pages[0].size = imem->size;
+
+	args[3].ptr = pages;
+	args[3].length = 1 * sizeof(*pages);
+	args[3].fd = -1;
+
+	args[4].ptr = &inbuf.attrs;
+	args[4].length = sizeof(inbuf.attrs);
+	args[4].fd = -1;
+
+	args[5].ptr = &inbuf.siglen;
+	args[5].length = sizeof(inbuf.siglen);
+	args[5].fd = -1;
+
+	inv.handle = 1;
+	inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
+	if (init.attrs)
+		inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 6, 0);
+	inv.args = &args[0];
+	err = fastrpc_internal_invoke(fl, 1, &inv);
+bail:
+	if (map)
+		fastrpc_map_put(map);
+
+	return err;
+}
+
 static struct fastrpc_session_ctx *fastrpc_session_alloc(
 					struct fastrpc_channel_ctx *cctx,
 					int secure)
@@ -705,6 +803,23 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
 	spin_unlock(&cctx->lock);
 }
 
+static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
+{
+	struct fastrpc_invoke inv;
+	struct fastrpc_invoke_args args[1];
+	int tgid = 0;
+
+	tgid = fl->tgid;
+	args[0].ptr = &tgid;
+	args[0].length = sizeof(tgid);
+	args[0].fd = -1;
+	inv.handle = 1;
+	inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
+	inv.args = &args[0];
+
+	return fastrpc_internal_invoke(fl, 1, &inv);
+}
+
 static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
@@ -712,6 +827,8 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 
+	fastrpc_release_current_dsp_process(fl);
+
 	spin_lock(&cctx->lock);
 	list_del(&fl->user);
 	spin_unlock(&cctx->lock);
@@ -759,6 +876,23 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static long fastrpc_init_attach(struct fastrpc_user *fl)
+{
+	struct fastrpc_invoke_args args[1];
+	struct fastrpc_invoke inv;
+	int tgid = fl->tgid;
+
+	args[0].ptr = &tgid;
+	args[0].length = sizeof(tgid);
+	args[0].fd = -1;
+	inv.handle = FASTRPC_INIT_HANDLE;
+	inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
+	inv.args = &args[0];
+	fl->pd = 0;
+
+	return fastrpc_internal_invoke(fl, 1, &inv);
+}
+
 static long fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args *args = NULL;
@@ -799,6 +933,12 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_INVOKE:
 		err = fastrpc_invoke(fl, argp);
 		break;
+	case FASTRPC_IOCTL_INIT_ATTACH:
+		err = fastrpc_init_attach(fl);
+		break;
+	case FASTRPC_IOCTL_INIT_CREATE:
+		err = fastrpc_init_create_process(fl, argp);
+		break;
 	default:
 		err = -ENOTTY;
 		dev_err(fl->sctx->dev, "bad ioctl: %d\n", cmd);
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 0b408ba62482..2f0afa5dab1f 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>
 
 #define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
+#define FASTRPC_IOCTL_INIT_ATTACH	_IO('R', 4)
+#define FASTRPC_IOCTL_INIT_CREATE	_IOWR('R', 5, struct fastrpc_init_create)
 
 struct fastrpc_invoke_args {
 	__s32 fd;
@@ -19,4 +21,14 @@ struct fastrpc_invoke {
 	struct fastrpc_invoke_args *args;
 };
 
+struct fastrpc_init_create {
+	__u32 filelen;	/* elf file length */
+	__u32 filefd;	/* fd for the file */
+	__u32 memlen;	/* mem length */
+	__u32 memfd;	/* fd for the mem */
+	__u32 attrs;
+	__u32 siglen;
+	__u64 file;	/* pointer to elf file */
+};
+
 #endif /* __QCOM_FASTRPC_H__ */
-- 
2.19.2

