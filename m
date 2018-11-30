Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC73C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004632146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTomd1IH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004632146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeK3V5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:57:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33487 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeK3V44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:56:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so4839145wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rp460mHVouQdCt0dxaOMsdLua3SS3yYIstuGzJqTGE0=;
        b=aTomd1IHGP69i4CGKsSu31npbyEHjFKPKJU/HrpFw8xwYs8A4PuHHFULcQaJjKzdhY
         7HBQMmRg4g6PmyZdCjO7C84WcehLjAigMGDK3o4pPxfL83ngDaZ5ZYwu0i7Cxbx+wzxX
         DEFq4VpgE2bodMx+ivCZcMUxjX2wdLfN6N9iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rp460mHVouQdCt0dxaOMsdLua3SS3yYIstuGzJqTGE0=;
        b=IYlj53yB5RX/6QEgYJwXSBmXNtDO9JmvPoqXDQDjWnUSgOwf0ZF8bLlcwJnUjr02Sm
         gdSunnG8Np80wFZQ8O1qiXymnFXa4w65/1jmlsXdy8Z6BaVflJHnSbPrE6kizSmOcOmA
         oIv9YWlZSrdOXR4RHcXM9F/EUxSIx4Ndu9ZkQe8y79mvuBq8W4ENYdcIf1X/RYPjTzwe
         gbvYf/ynY3xX8hPSr8OZV9t9kHRx9c3E8qGaIg/idVcNrnv8WqZiyzLZKb0hV82X9hHO
         AzfSHqMdmaV2z8LewE417mij9cJrmaSYgrGcwH3KYgOyjbWJO+VIdjNXN3BoiKomzCWu
         V4fg==
X-Gm-Message-State: AA+aEWZXTg2KnrpiFlF5or2PSQ4CbAv7238ThUttzjuZW2463nIltz6D
        IwWUsgSSXzg5nFt3X7wzPbuv6Q==
X-Google-Smtp-Source: AFSGD/ULRHiRBkAJ0A9tpWt6aApo3KuKKoCTirrpZpb6rHfN1Ctg/JSl0gyuM+k16NN4PlbAsR5fRw==
X-Received: by 2002:adf:83e7:: with SMTP id 94mr4530139wre.278.1543574882300;
        Fri, 30 Nov 2018 02:48:02 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 18sm6964211wmm.32.2018.11.30.02.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 02:48:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 4/6] char: fastrpc: Add support for create remote init process
Date:   Fri, 30 Nov 2018 10:46:55 +0000
Message-Id: <20181130104657.14875-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
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

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/char/fastrpc.c       | 172 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/fastrpc.h |  18 ++++
 2 files changed, 190 insertions(+)

diff --git a/drivers/char/fastrpc.c b/drivers/char/fastrpc.c
index 5bb224adc24f..3630e883d3f4 100644
--- a/drivers/char/fastrpc.c
+++ b/drivers/char/fastrpc.c
@@ -30,6 +30,8 @@
 #define FASTRPC_PHYS(p)	(p & 0xffffffff)
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_CTXID_MASK (0xFF0)
+#define INIT_FILELEN_MAX (2*1024*1024)
+#define INIT_MEMLEN_MAX  (8*1024*1024)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 
 /* Retrives number of input buffers from the scalars parameter */
@@ -59,6 +61,14 @@
 
 #define FASTRPC_SCALARS(method, in, out) \
 		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
+
+/* Remote Method id table */
+#define FASTRPC_RMID_INIT_ATTACH	0
+#define FASTRPC_RMID_INIT_RELEASE	1
+#define FASTRPC_RMID_INIT_CREATE	6
+#define FASTRPC_RMID_INIT_CREATE_ATTR	7
+#define FASTRPC_RMID_INIT_CREATE_STATIC	8
+
 #define cdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, cdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
@@ -735,6 +745,130 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,
 
 	return err;
 }
+
+static int fastrpc_init_process(struct fastrpc_user *fl,
+				struct fastrpc_ioctl_init *init)
+{
+	struct fastrpc_ioctl_invoke *ioctl;
+	struct fastrpc_phy_page pages[1];
+	struct fastrpc_map *file = NULL, *mem = NULL;
+	struct fastrpc_buf *imem = NULL;
+	int err = 0;
+
+	ioctl = kzalloc(sizeof(*ioctl), GFP_KERNEL);
+	if (!ioctl)
+		return -ENOMEM;
+
+	if (init->flags == FASTRPC_INIT_ATTACH) {
+		remote_arg_t ra[1];
+		int tgid = fl->tgid;
+
+		ra[0].buf.pv = (void *)&tgid;
+		ra[0].buf.len = sizeof(tgid);
+		ioctl->handle = 1;
+		ioctl->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
+		ioctl->pra = ra;
+		fl->pd = 0;
+
+		err = fastrpc_internal_invoke(fl, 1, ioctl);
+		if (err)
+			goto bail;
+	} else if (init->flags == FASTRPC_INIT_CREATE) {
+		int memlen;
+		remote_arg_t ra[6];
+		int fds[6];
+		struct {
+			int pgid;
+			unsigned int namelen;
+			unsigned int filelen;
+			unsigned int pageslen;
+			int attrs;
+			int siglen;
+		} inbuf;
+
+		inbuf.pgid = fl->tgid;
+		inbuf.namelen = strlen(current->comm) + 1;
+		inbuf.filelen = init->filelen;
+		fl->pd = 1;
+
+		if (init->filelen) {
+			err = fastrpc_map_create(fl, init->filefd,
+						  init->file, init->filelen,
+						  &file);
+			if (err)
+				goto bail;
+		}
+		inbuf.pageslen = 1;
+
+		if (init->mem) {
+			err = -EINVAL;
+			pr_err("adsprpc: %s: %s: ERROR: donated memory allocated in userspace\n",
+				current->comm, __func__);
+			goto bail;
+		}
+		memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init->filelen * 4),
+			       1024 * 1024);
+		err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
+					 &imem);
+		if (err)
+			goto bail;
+
+		fl->init_mem = imem;
+		inbuf.pageslen = 1;
+		ra[0].buf.pv = (void *)&inbuf;
+		ra[0].buf.len = sizeof(inbuf);
+		fds[0] = 0;
+
+		ra[1].buf.pv = (void *)current->comm;
+		ra[1].buf.len = inbuf.namelen;
+		fds[1] = 0;
+
+		ra[2].buf.pv = (void *)init->file;
+		ra[2].buf.len = inbuf.filelen;
+		fds[2] = init->filefd;
+
+		pages[0].addr = imem->phys;
+		pages[0].size = imem->size;
+
+		ra[3].buf.pv = (void *)pages;
+		ra[3].buf.len = 1 * sizeof(*pages);
+		fds[3] = 0;
+
+		inbuf.attrs = init->attrs;
+		ra[4].buf.pv = (void *)&(inbuf.attrs);
+		ra[4].buf.len = sizeof(inbuf.attrs);
+		fds[4] = 0;
+
+		inbuf.siglen = init->siglen;
+		ra[5].buf.pv = (void *)&(inbuf.siglen);
+		ra[5].buf.len = sizeof(inbuf.siglen);
+		fds[5] = 0;
+
+		ioctl->handle = 1;
+		ioctl->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
+		if (init->attrs)
+			ioctl->sc = FASTRPC_SCALARS(
+					FASTRPC_RMID_INIT_CREATE_ATTR, 6, 0);
+		ioctl->pra = ra;
+		ioctl->fds = fds;
+		err = fastrpc_internal_invoke(fl, 1, ioctl);
+		if (err)
+			goto bail;
+	} else {
+		err = -ENOTTY;
+	}
+bail:
+	kfree(ioctl);
+
+	if (mem && err)
+		fastrpc_map_put(mem);
+
+	if (file)
+		fastrpc_map_put(file);
+
+	return err;
+}
+
 static struct fastrpc_session_ctx *fastrpc_session_alloc(
 					struct fastrpc_channel_ctx *cctx,
 					int secure)
@@ -769,6 +903,25 @@ static const struct of_device_id fastrpc_match_table[] = {
 	{}
 };
 
+static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
+{
+	struct fastrpc_ioctl_invoke ioctl;
+	remote_arg_t ra[1];
+	int tgid = 0;
+
+	tgid = fl->tgid;
+	ra[0].buf.pv = (void *)&tgid;
+	ra[0].buf.len = sizeof(tgid);
+	ioctl.handle = 1;
+	ioctl.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
+	ioctl.pra = ra;
+	ioctl.fds = NULL;
+	ioctl.attrs = NULL;
+	ioctl.crc = NULL;
+
+	return fastrpc_internal_invoke(fl, 1, &ioctl);
+}
+
 static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
@@ -776,6 +929,8 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 
+	fastrpc_release_current_dsp_process(fl);
+
 	spin_lock(&cctx->lock);
 	list_del(&fl->user);
 	spin_unlock(&cctx->lock);
@@ -855,6 +1010,23 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 			goto bail;
 		break;
 		}
+	case FASTRPC_IOCTL_INIT: {
+		struct fastrpc_ioctl_init init;
+
+		init.attrs = 0;
+		init.siglen = 0;
+		err = copy_from_user(&init, argp, sizeof(init));
+		if (err)
+			goto bail;
+		if (init.filelen > INIT_FILELEN_MAX)
+			goto bail;
+		if (init.memlen > INIT_MEMLEN_MAX)
+			goto bail;
+		err = fastrpc_init_process(fl, &init);
+		if (err)
+			goto bail;
+		}
+		break;
 default:
 		err = -ENOTTY;
 		pr_info("bad ioctl: %d\n", cmd);
diff --git a/include/uapi/linux/fastrpc.h b/include/uapi/linux/fastrpc.h
index 8fec66601337..6b596fc7ddf3 100644
--- a/include/uapi/linux/fastrpc.h
+++ b/include/uapi/linux/fastrpc.h
@@ -6,6 +6,12 @@
 #include <linux/types.h>
 
 #define FASTRPC_IOCTL_INVOKE	_IOWR('R', 3, struct fastrpc_ioctl_invoke)
+#define FASTRPC_IOCTL_INIT	_IOWR('R', 4, struct fastrpc_ioctl_init)
+
+/* INIT a new process or attach to guestos */
+#define FASTRPC_INIT_ATTACH      0
+#define FASTRPC_INIT_CREATE      1
+#define FASTRPC_INIT_CREATE_STATIC  2
 
 #define remote_arg64_t    union remote_arg64
 
@@ -53,4 +59,16 @@ struct fastrpc_ioctl_invoke {
 	unsigned int *crc;
 };
 
+struct fastrpc_ioctl_init {
+	uint32_t flags;		/* one of FASTRPC_INIT_* macros */
+	uintptr_t file;		/* pointer to elf file */
+	uint32_t filelen;	/* elf file length */
+	int32_t filefd;		/* ION fd for the file */
+	uintptr_t mem;		/* mem for the PD */
+	uint32_t memlen;	/* mem length */
+	int32_t memfd;		/* fd for the mem */
+	int attrs;
+	unsigned int siglen;
+};
+
 #endif /* __QCOM_FASTRPC_H__ */
-- 
2.19.2

