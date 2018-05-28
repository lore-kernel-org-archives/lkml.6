Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940436AbeE1Qmx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933542AbeE1KHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:07:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 049/185] scsi: mptfusion: Add bounds check in mptctl_hp_targetinfo()
Date: Mon, 28 May 2018 12:01:30 +0200
Message-Id: <20180528100055.087697854@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit a7043e9529f3c367cc4d82997e00be034cbe57ca ]

My static checker complains about an out of bounds read:

    drivers/message/fusion/mptctl.c:2786 mptctl_hp_targetinfo()
    error: buffer overflow 'hd->sel_timeout' 255 <= u32max.

It's true that we probably should have a bounds check here.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/message/fusion/mptctl.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -2694,6 +2694,8 @@ mptctl_hp_targetinfo(unsigned long arg)
 				__FILE__, __LINE__, iocnum);
 		return -ENODEV;
 	}
+	if (karg.hdr.id >= MPT_MAX_FC_DEVICES)
+		return -EINVAL;
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_hp_targetinfo called.\n",
 	    ioc->name));
 
