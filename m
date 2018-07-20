Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468ABECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE1C20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJuMuMRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE1C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeGTEgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43617 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeGTEgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so5615887pgr.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tk/lDp9C64fMAO9+aR9K/MWZ4PyZsWhqz5YLcCs5KzQ=;
        b=tJuMuMRG8sGHZnLScZ6y/HizV50yhdYoHKFFUhB5If3Mae9Yls9MIKM76jzUrOaWXA
         ne5uZp9xcbPkml0Uiw+2uOcyY2SUrTBX621ohJGH878TBm3nNYnxkViHuF5O3uy5vu8Q
         G0Bu1Mt3uDyft2GY5XLiSsk80SA+MFqMYa7eUX+VAl8OtRP49soh7zzrxy4KlwNjsFgP
         lItHGwbhJko8x+FdqxFLIeFB0SCAdC3jbQtukw+73tK4EPMhUTmO5Wj2oGnZ6iiYYvZj
         u3lzb6w8i/6X4rnFbIy4c7NANS7vwuq3CAnIegMcqMBLaJSAdmD0xivlsaGDO833cCNb
         TPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tk/lDp9C64fMAO9+aR9K/MWZ4PyZsWhqz5YLcCs5KzQ=;
        b=dV486JHvus6hrRRqEwd7G0iCRXrSfueKEAIFT1az3pMavKhidqDHeXJq8keeIRZVS/
         ckKc9ndAieLURVzGyZ68au7pGrooOMjsZvyGd+Rj3hditXPV3KRDC1vr50QBnSUrxkhM
         nH7LX4mm86ZMcPn+3iEtvDtk+bSscdZuXE7kE4y78zqqkyJeBGEmWYF+0UOTcFO1boQF
         VUChL7w23QeU/FTOc5/Ar9BG66SWpLCr/vWJEn65/GHhda44U0iK8z/uVPA3acmtatax
         RKqkrI8nmWcS66ZR+M91WzmxVLsCRGKqrumBIvushvwuEGtkPbmXjKEf5da9zeGypuhd
         +FAw==
X-Gm-Message-State: AOUpUlEP7VuLp77tAM+dwj3zd6u+s+oC150LoK8Zq8zTt2O6l1nv8kpm
        2vrXh0QTJS8FGl0ys3L44/s=
X-Google-Smtp-Source: AAOMgpfyEqbPq2sjEM7qhlqyFzYbcW5sTV83Oveliopd/oyG4B3eaGy03QvHIkOtW0+ZQyktkTmZZg==
X-Received: by 2002:a63:7a43:: with SMTP id j3-v6mr403332pgn.363.1532058607992;
        Thu, 19 Jul 2018 20:50:07 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:50:07 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 20/20] staging: gasket: common ioctls add __user annotations
Date:   Thu, 19 Jul 2018 20:49:20 -0700
Message-Id: <20180720034920.77320-21-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add __user annotation to gasket common ioctl pointer arguments for
sparse checking.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 102 ++++++++++++++------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 998d0e215523c..2e2c9b997093b 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -24,17 +24,24 @@
 #endif
 
 static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd);
-static int gasket_set_event_fd(struct gasket_dev *dev, ulong arg);
+static int gasket_set_event_fd(struct gasket_dev *dev,
+			       struct gasket_interrupt_eventfd __user *argp);
 static int gasket_read_page_table_size(
-	struct gasket_dev *gasket_dev, ulong arg);
+	struct gasket_dev *gasket_dev,
+	struct gasket_page_table_ioctl __user *argp);
 static int gasket_read_simple_page_table_size(
-	struct gasket_dev *gasket_dev, ulong arg);
+	struct gasket_dev *gasket_dev,
+	struct gasket_page_table_ioctl __user *argp);
 static int gasket_partition_page_table(
-	struct gasket_dev *gasket_dev, ulong arg);
-static int gasket_map_buffers(struct gasket_dev *gasket_dev, ulong arg);
-static int gasket_unmap_buffers(struct gasket_dev *gasket_dev, ulong arg);
+	struct gasket_dev *gasket_dev,
+	struct gasket_page_table_ioctl __user *argp);
+static int gasket_map_buffers(struct gasket_dev *gasket_dev,
+			      struct gasket_page_table_ioctl __user *argp);
+static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
+				struct gasket_page_table_ioctl __user *argp);
 static int gasket_config_coherent_allocator(
-	struct gasket_dev *gasket_dev, ulong arg);
+	struct gasket_dev *gasket_dev,
+	struct gasket_coherent_alloc_config_ioctl __user *argp);
 
 /*
  * standard ioctl dispatch function.
@@ -80,7 +87,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 		retval = gasket_reset(gasket_dev, arg);
 		break;
 	case GASKET_IOCTL_SET_EVENTFD:
-		retval = gasket_set_event_fd(gasket_dev, arg);
+		retval = gasket_set_event_fd(gasket_dev, argp);
 		break;
 	case GASKET_IOCTL_CLEAR_EVENTFD:
 		trace_gasket_ioctl_integer_data(arg);
@@ -89,31 +96,30 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 		break;
 	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
 		trace_gasket_ioctl_integer_data(arg);
-		retval = gasket_partition_page_table(gasket_dev, arg);
+		retval = gasket_partition_page_table(gasket_dev, argp);
 		break;
 	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
 		trace_gasket_ioctl_integer_data(gasket_dev->num_page_tables);
-		if (copy_to_user((void __user *)arg,
-				 &gasket_dev->num_page_tables,
+		if (copy_to_user(argp, &gasket_dev->num_page_tables,
 				 sizeof(uint64_t)))
 			retval = -EFAULT;
 		else
 			retval = 0;
 		break;
 	case GASKET_IOCTL_PAGE_TABLE_SIZE:
-		retval = gasket_read_page_table_size(gasket_dev, arg);
+		retval = gasket_read_page_table_size(gasket_dev, argp);
 		break;
 	case GASKET_IOCTL_SIMPLE_PAGE_TABLE_SIZE:
-		retval = gasket_read_simple_page_table_size(gasket_dev, arg);
+		retval = gasket_read_simple_page_table_size(gasket_dev, argp);
 		break;
 	case GASKET_IOCTL_MAP_BUFFER:
-		retval = gasket_map_buffers(gasket_dev, arg);
+		retval = gasket_map_buffers(gasket_dev, argp);
 		break;
 	case GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR:
-		retval = gasket_config_coherent_allocator(gasket_dev, arg);
+		retval = gasket_config_coherent_allocator(gasket_dev, argp);
 		break;
 	case GASKET_IOCTL_UNMAP_BUFFER:
-		retval = gasket_unmap_buffers(gasket_dev, arg);
+		retval = gasket_unmap_buffers(gasket_dev, argp);
 		break;
 	case GASKET_IOCTL_CLEAR_INTERRUPT_COUNTS:
 		/* Clear interrupt counts doesn't take an arg, so use 0. */
@@ -218,16 +224,15 @@ static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 /*
  * Associate an eventfd with an interrupt.
  * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @arg: Pointer to gasket_interrupt_eventfd struct in userspace.
+ * @argp: Pointer to gasket_interrupt_eventfd struct in userspace.
  */
-static int gasket_set_event_fd(struct gasket_dev *gasket_dev, ulong arg)
+static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
+			       struct gasket_interrupt_eventfd __user *argp)
 {
 	struct gasket_interrupt_eventfd die;
 
-	if (copy_from_user(&die, (void __user *)arg,
-			   sizeof(struct gasket_interrupt_eventfd))) {
+	if (copy_from_user(&die, argp, sizeof(struct gasket_interrupt_eventfd)))
 		return -EFAULT;
-	}
 
 	trace_gasket_ioctl_eventfd_data(die.interrupt, die.event_fd);
 
@@ -238,15 +243,16 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev, ulong arg)
 /*
  * Reads the size of the page table.
  * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @arg: Pointer to gasket_page_table_ioctl struct in userspace.
+ * @argp: Pointer to gasket_page_table_ioctl struct in userspace.
  */
-static int gasket_read_page_table_size(struct gasket_dev *gasket_dev, ulong arg)
+static int gasket_read_page_table_size(
+	struct gasket_dev *gasket_dev,
+	struct gasket_page_table_ioctl __user *argp)
 {
 	int ret = 0;
 	struct gasket_page_table_ioctl ibuf;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
-			   sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
@@ -259,7 +265,7 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev, ulong arg)
 		ibuf.page_table_index, ibuf.size, ibuf.host_address,
 		ibuf.device_address);
 
-	if (copy_to_user((void __user *)arg, &ibuf, sizeof(ibuf)))
+	if (copy_to_user(argp, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
 
 	return ret;
@@ -268,16 +274,16 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev, ulong arg)
 /*
  * Reads the size of the simple page table.
  * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @arg: Pointer to gasket_page_table_ioctl struct in userspace.
+ * @argp: Pointer to gasket_page_table_ioctl struct in userspace.
  */
 static int gasket_read_simple_page_table_size(
-	struct gasket_dev *gasket_dev, ulong arg)
+	struct gasket_dev *gasket_dev,
+	struct gasket_page_table_ioctl __user *argp)
 {
 	int ret = 0;
 	struct gasket_page_table_ioctl ibuf;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
-			   sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
@@ -290,7 +296,7 @@ static int gasket_read_simple_page_table_size(
 		ibuf.page_table_index, ibuf.size, ibuf.host_address,
 		ibuf.device_address);
 
-	if (copy_to_user((void __user *)arg, &ibuf, sizeof(ibuf)))
+	if (copy_to_user(argp, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
 
 	return ret;
@@ -299,16 +305,17 @@ static int gasket_read_simple_page_table_size(
 /*
  * Sets the boundary between the simple and extended page tables.
  * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @arg: Pointer to gasket_page_table_ioctl struct in userspace.
+ * @argp: Pointer to gasket_page_table_ioctl struct in userspace.
  */
-static int gasket_partition_page_table(struct gasket_dev *gasket_dev, ulong arg)
+static int gasket_partition_page_table(
+	struct gasket_dev *gasket_dev,
+	struct gasket_page_table_ioctl __user *argp)
 {
 	int ret;
 	struct gasket_page_table_ioctl ibuf;
 	uint max_page_table_size;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
-			   sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
 	trace_gasket_ioctl_page_table_data(
@@ -340,14 +347,14 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev, ulong arg)
 /*
  * Maps a userspace buffer to a device virtual address.
  * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @arg: Pointer to a gasket_page_table_ioctl struct in userspace.
+ * @argp: Pointer to a gasket_page_table_ioctl struct in userspace.
  */
-static int gasket_map_buffers(struct gasket_dev *gasket_dev, ulong arg)
+static int gasket_map_buffers(struct gasket_dev *gasket_dev,
+			      struct gasket_page_table_ioctl __user *argp)
 {
 	struct gasket_page_table_ioctl ibuf;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
-			   sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
 	trace_gasket_ioctl_page_table_data(
@@ -370,14 +377,14 @@ static int gasket_map_buffers(struct gasket_dev *gasket_dev, ulong arg)
 /*
  * Unmaps a userspace buffer from a device virtual address.
  * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @arg: Pointer to a gasket_page_table_ioctl struct in userspace.
+ * @argp: Pointer to a gasket_page_table_ioctl struct in userspace.
  */
-static int gasket_unmap_buffers(struct gasket_dev *gasket_dev, ulong arg)
+static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
+				struct gasket_page_table_ioctl __user *argp)
 {
 	struct gasket_page_table_ioctl ibuf;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
-			   sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
 	trace_gasket_ioctl_page_table_data(
@@ -402,15 +409,16 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev, ulong arg)
  * Tell the driver to reserve structures for coherent allocation, and allocate
  * or free the corresponding memory.
  * @dev: Pointer to the current gasket_dev we're using.
- * @arg: Pointer to a gasket_coherent_alloc_config_ioctl struct in userspace.
+ * @argp: Pointer to a gasket_coherent_alloc_config_ioctl struct in userspace.
  */
 static int gasket_config_coherent_allocator(
-	struct gasket_dev *gasket_dev, ulong arg)
+	struct gasket_dev *gasket_dev,
+	struct gasket_coherent_alloc_config_ioctl __user *argp)
 {
 	int ret;
 	struct gasket_coherent_alloc_config_ioctl ibuf;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
+	if (copy_from_user(&ibuf, argp,
 			   sizeof(struct gasket_coherent_alloc_config_ioctl)))
 		return -EFAULT;
 
@@ -432,7 +440,7 @@ static int gasket_config_coherent_allocator(
 			gasket_dev, ibuf.size, &ibuf.dma_address,
 			ibuf.page_table_index);
 	}
-	if (copy_to_user((void __user *)arg, &ibuf, sizeof(ibuf)))
+	if (copy_to_user(argp, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
 
 	return ret;
-- 
2.18.0.233.g985f88cf7e-goog

