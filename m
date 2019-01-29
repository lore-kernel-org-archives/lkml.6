Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70761C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F37F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761938;
	bh=ticgF0n/ZDgTqfEmqPhvgIKPA7uEgY2Qb5RttEPehVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vzzp4612b+JT5BkeuxerRMnPvVE/mu3cB5l5jtJ3WdRIM7q0lRQxgP5MPUNBLwdRB
	 s9g8RtZR6EzSV94bl4R3TS4qEw8rvH47f6RrBV0eEXYNM5obpbzdaT4clVtKELvU2A
	 tmhUy++VkPW+9213fYQ3yr5fXqMGHnUtMuod1DXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfA2Li5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728751AbfA2Liv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CCF20882;
        Tue, 29 Jan 2019 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761931;
        bh=ticgF0n/ZDgTqfEmqPhvgIKPA7uEgY2Qb5RttEPehVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTYuNkmfn7d2Ddg+XdqiiwVTU2eZsEIK8kvs7CbEKf0TdPH4JDu4zHmM9tJHa1GCB
         XO/xfCIYJl8md/mIrJGMrq/WEHFR1UVCphe5y4cGPwhtUMhdNXZAlkXwK8O1XqHGGU
         45KWkzGjvxYDjeFky391dW3YjXLRU1V6QHFoQRHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4.20 050/117] char/mwave: fix potential Spectre v1 vulnerability
Date:   Tue, 29 Jan 2019 12:35:01 +0100
Message-Id: <20190129113210.104942048@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 701956d4018e5d5438570e39e8bda47edd32c489 upstream.

ipcnum is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/char/mwave/mwavedd.c:299 mwave_ioctl() warn: potential spectre issue 'pDrvData->IPCs' [w] (local cap)

Fix this by sanitizing ipcnum before using it to index pDrvData->IPCs.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/mwave/mwavedd.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/char/mwave/mwavedd.c
+++ b/drivers/char/mwave/mwavedd.c
@@ -59,6 +59,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/serial_8250.h>
+#include <linux/nospec.h>
 #include "smapi.h"
 #include "mwavedd.h"
 #include "3780i.h"
@@ -289,6 +290,8 @@ static long mwave_ioctl(struct file *fil
 						ipcnum);
 				return -EINVAL;
 			}
+			ipcnum = array_index_nospec(ipcnum,
+						    ARRAY_SIZE(pDrvData->IPCs));
 			PRINTK_3(TRACE_MWAVE,
 				"mwavedd::mwave_ioctl IOCTL_MW_REGISTER_IPC"
 				" ipcnum %x entry usIntCount %x\n",
@@ -317,6 +320,8 @@ static long mwave_ioctl(struct file *fil
 						" Invalid ipcnum %x\n", ipcnum);
 				return -EINVAL;
 			}
+			ipcnum = array_index_nospec(ipcnum,
+						    ARRAY_SIZE(pDrvData->IPCs));
 			PRINTK_3(TRACE_MWAVE,
 				"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC"
 				" ipcnum %x, usIntCount %x\n",
@@ -383,6 +388,8 @@ static long mwave_ioctl(struct file *fil
 						ipcnum);
 				return -EINVAL;
 			}
+			ipcnum = array_index_nospec(ipcnum,
+						    ARRAY_SIZE(pDrvData->IPCs));
 			mutex_lock(&mwave_mutex);
 			if (pDrvData->IPCs[ipcnum].bIsEnabled == true) {
 				pDrvData->IPCs[ipcnum].bIsEnabled = false;


