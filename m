Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B869C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7BF20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762697;
	bh=Nrwdy9u0vK483DrziIXVrZfhNGvu1O+DV6fmbULOYuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MpwYteJl9USWwqc734PKwmUihcmIpRic8AEjry/RRADkip6ny2JHdCjIfv8irgx2X
	 1Oip1a1TZaEjbFLc85mFpTkJx7qZB/98vD85K1IRiIA9aSiYAmWp6ww8E6sa1aictp
	 ph820odE80SDrCehwMiD5GwF7b/b/SiazZ3QKFQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbfA2Lvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:51:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731889AbfA2Lvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:51:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E4B2086C;
        Tue, 29 Jan 2019 11:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762690;
        bh=Nrwdy9u0vK483DrziIXVrZfhNGvu1O+DV6fmbULOYuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzK9qEYJnbcvW0NIYD2o+PuomINZOHnd0yM9qMVn9Go33xamAPpOhmYBrxVQ6hX7W
         NwNX9Bzyt+WMiN8p2JPUXDs46neN22Oa+mwpKF6ch2aZE/3LWO7EL/u+SlI2QB80VO
         FB1JQGCAsaOkHbQ6+pTcF8kAj1+ZsrpgVDS/Brf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4.9 17/44] char/mwave: fix potential Spectre v1 vulnerability
Date:   Tue, 29 Jan 2019 12:36:12 +0100
Message-Id: <20190129113141.385394175@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


