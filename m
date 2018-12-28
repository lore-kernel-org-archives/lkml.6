Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4BBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5652146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999357;
	bh=CGIz/36tmTXbNGbEiA3lJgRo66wTZZ7ZMIAiIO7GAY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2vXRjBIeOhD+kw4Vreb7csRz76+Wqxx3TRLjIv1ti2eQaJKESQikbqnVUIBHkcrQR
	 lOQi4e/gN6RXUyCMJtYRCX5jA6aLwwffPQ/vvHr58p7TN+Eu7p6PJ0Pakzc2Kmvrb8
	 mv9i3g9iM8JPyC+URGvCm9sqromRJO7oi8j5eR+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbeL1MPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbeL1MPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24BC42146F;
        Fri, 28 Dec 2018 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999352;
        bh=CGIz/36tmTXbNGbEiA3lJgRo66wTZZ7ZMIAiIO7GAY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTeI2HgCIokOZu3jiuZnqfdofrv5LbGtNegBDRrFbzQx4w2DZu0LVPKj2SeBjrqVm
         yWY/VmyHOe6/8oQddQyGaZ+S7KKy5+jt0GSkRVEYjf2bK17mb08G/8Tok2Sn2x6xK5
         oRpiEErXjMS6cEb5kROf1URhEAyGHaQV+sTdZ/Z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 05/36] ib_srpt: Fix a use-after-free in __srpt_close_all_ch()
Date:   Fri, 28 Dec 2018 12:52:21 +0100
Message-Id: <20181228113126.877068121@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 14d15c2b278011056482eb015dff89f9cbf2b841 upstream

BUG: KASAN: use-after-free in srpt_set_enabled+0x1a9/0x1e0 [ib_srpt]
Read of size 4 at addr ffff8801269d23f8 by task check/29726

CPU: 4 PID: 29726 Comm: check Not tainted 4.18.0-rc2-dbg+ #4
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
 dump_stack+0xa4/0xf5
 print_address_description+0x6f/0x270
 kasan_report+0x241/0x360
 __asan_load4+0x78/0x80
 srpt_set_enabled+0x1a9/0x1e0 [ib_srpt]
 srpt_tpg_enable_store+0xb8/0x120 [ib_srpt]
 configfs_write_file+0x14e/0x1d0 [configfs]
 __vfs_write+0xd2/0x3b0
 vfs_write+0x101/0x270
 ksys_write+0xab/0x120
 __x64_sys_write+0x43/0x50
 do_syscall_64+0x77/0x230
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f235cfe6154

Fixes: aaf45bd83eba ("IB/srpt: Detect session shutdown reliably")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 60105ba77889..47f3f562d86f 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1775,8 +1775,8 @@ static void __srpt_close_all_ch(struct srpt_device *sdev)
 
 	list_for_each_entry(ch, &sdev->rch_list, list) {
 		if (srpt_disconnect_ch(ch) >= 0)
-			pr_info("Closing channel %s-%d because target %s has been disabled\n",
-				ch->sess_name, ch->qp->qp_num,
+			pr_info("Closing channel %s because target %s has been disabled\n",
+				ch->sess_name,
 				sdev->device->name);
 		srpt_close_ch(ch);
 	}
-- 
2.19.1



