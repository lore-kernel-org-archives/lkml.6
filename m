Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E55C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9534C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9534C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeIHCPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:15:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeIHCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:15:48 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4B7ED6B;
        Fri,  7 Sep 2018 21:32:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.9 13/63] ib_srpt: Fix a use-after-free in srpt_close_ch()
Date:   Fri,  7 Sep 2018 23:09:44 +0200
Message-Id: <20180907211013.737284910@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 995250959d22fc341b5424e3343b0ce5df672461 upstream.

Avoid that KASAN reports the following:

BUG: KASAN: use-after-free in srpt_close_ch+0x4f/0x1b0 [ib_srpt]
Read of size 4 at addr ffff880151180cb8 by task check/4681

CPU: 15 PID: 4681 Comm: check Not tainted 4.18.0-rc2-dbg+ #4
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
 dump_stack+0xa4/0xf5
 print_address_description+0x6f/0x270
 kasan_report+0x241/0x360
 __asan_load4+0x78/0x80
 srpt_close_ch+0x4f/0x1b0 [ib_srpt]
 srpt_set_enabled+0xf7/0x1e0 [ib_srpt]
 srpt_tpg_enable_store+0xb8/0x120 [ib_srpt]
 configfs_write_file+0x14e/0x1d0 [configfs]
 __vfs_write+0xd2/0x3b0
 vfs_write+0x101/0x270
 ksys_write+0xab/0x120
 __x64_sys_write+0x43/0x50
 do_syscall_64+0x77/0x230
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: aaf45bd83eba ("IB/srpt: Detect session shutdown reliably")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srpt/ib_srpt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1701,8 +1701,7 @@ static bool srpt_close_ch(struct srpt_rd
 	int ret;
 
 	if (!srpt_set_ch_state(ch, CH_DRAINING)) {
-		pr_debug("%s-%d: already closed\n", ch->sess_name,
-			 ch->qp->qp_num);
+		pr_debug("%s: already closed\n", ch->sess_name);
 		return false;
 	}
 


