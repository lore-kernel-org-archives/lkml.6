Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B26C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13E52075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13E52075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeIHB5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:57:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42154 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeIHB5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:57:20 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5388CF07;
        Fri,  7 Sep 2018 21:14:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.18 048/145] ib_srpt: Fix a use-after-free in __srpt_close_all_ch()
Date:   Fri,  7 Sep 2018 23:08:34 +0200
Message-Id: <20180907210908.495175671@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 14d15c2b278011056482eb015dff89f9cbf2b841 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srpt/ib_srpt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1939,8 +1939,8 @@ static void __srpt_close_all_ch(struct s
 	list_for_each_entry(nexus, &sport->nexus_list, entry) {
 		list_for_each_entry(ch, &nexus->ch_list, list) {
 			if (srpt_disconnect_ch(ch) >= 0)
-				pr_info("Closing channel %s-%d because target %s_%d has been disabled\n",
-					ch->sess_name, ch->qp->qp_num,
+				pr_info("Closing channel %s because target %s_%d has been disabled\n",
+					ch->sess_name,
 					sport->sdev->device->name, sport->port);
 			srpt_close_ch(ch);
 		}


