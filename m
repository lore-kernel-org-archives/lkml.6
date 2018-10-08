Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5756BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21854214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJkUZZbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21854214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbeJICDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731711AbeJICDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C0C204FD;
        Mon,  8 Oct 2018 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024605;
        bh=fw+0HZinCheJNotCIExv8crgn5Gz1CDW6F9F2Al9YhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJkUZZbowmMCkxqtq+YE+2biKsy0lfhSkt0c4jhpISmNtByq2F3e+O9DoEvQqdPkc
         O1RdBBTX5SfqO0vTAQ83eB2lhxnftiov6FFBQFkXa3oqAkMCBiTOyOl9BmvpJDwrBT
         +ovxvyQcseKxj7zj68GKcliu7ayfIvy6v+FfBvwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Pelletier <plr.vincent@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 086/168] scsi: iscsi: target: Set conn->sess to NULL when iscsi_login_set_conn_values fails
Date:   Mon,  8 Oct 2018 20:31:06 +0200
Message-Id: <20181008175623.328903028@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Pelletier <plr.vincent@gmail.com>

[ Upstream commit 7915919bb94e12460c58e27c708472e6f85f6699 ]

Fixes a use-after-free reported by KASAN when later
iscsi_target_login_sess_out gets called and it tries to access
conn->sess->se_sess:

Disabling lock debugging due to kernel taint
iSCSI Login timeout on Network Portal [::]:3260
iSCSI Login negotiation failed.
==================================================================
BUG: KASAN: use-after-free in
iscsi_target_login_sess_out.cold.12+0x58/0xff [iscsi_target_mod]
Read of size 8 at addr ffff880109d070c8 by task iscsi_np/980

CPU: 1 PID: 980 Comm: iscsi_np Tainted: G           O
4.17.8kasan.sess.connops+ #4
Hardware name: To be filled by O.E.M. To be filled by O.E.M./Aptio CRB,
BIOS 5.6.5 05/19/2014
Call Trace:
 dump_stack+0x71/0xac
 print_address_description+0x65/0x22e
 ? iscsi_target_login_sess_out.cold.12+0x58/0xff [iscsi_target_mod]
 kasan_report.cold.6+0x241/0x2fd
 iscsi_target_login_sess_out.cold.12+0x58/0xff [iscsi_target_mod]
 iscsi_target_login_thread+0x1086/0x1710 [iscsi_target_mod]
 ? __sched_text_start+0x8/0x8
 ? iscsi_target_login_sess_out+0x250/0x250 [iscsi_target_mod]
 ? __kthread_parkme+0xcc/0x100
 ? parse_args.cold.14+0xd3/0xd3
 ? iscsi_target_login_sess_out+0x250/0x250 [iscsi_target_mod]
 kthread+0x1a0/0x1c0
 ? kthread_bind+0x30/0x30
 ret_from_fork+0x35/0x40

Allocated by task 980:
 kasan_kmalloc+0xbf/0xe0
 kmem_cache_alloc_trace+0x112/0x210
 iscsi_target_login_thread+0x816/0x1710 [iscsi_target_mod]
 kthread+0x1a0/0x1c0
 ret_from_fork+0x35/0x40

Freed by task 980:
 __kasan_slab_free+0x125/0x170
 kfree+0x90/0x1d0
 iscsi_target_login_thread+0x1577/0x1710 [iscsi_target_mod]
 kthread+0x1a0/0x1c0
 ret_from_fork+0x35/0x40

The buggy address belongs to the object at ffff880109d06f00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 456 bytes inside of
 512-byte region [ffff880109d06f00, ffff880109d07100)
The buggy address belongs to the page:
page:ffffea0004274180 count:1 mapcount:0 mapping:0000000000000000
index:0x0 compound_mapcount: 0
flags: 0x17fffc000008100(slab|head)
raw: 017fffc000008100 0000000000000000 0000000000000000 00000001000c000c
raw: dead000000000100 dead000000000200 ffff88011b002e00 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff880109d06f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff880109d07000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff880109d07080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff880109d07100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff880109d07180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
[rebased against idr/ida changes and to handle ret review comments from Matthew]
Signed-off-by: Mike Christie <mchristi@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/iscsi/iscsi_target_login.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -310,11 +310,9 @@ static int iscsi_login_zero_tsih_s1(
 		return -ENOMEM;
 	}
 
-	ret = iscsi_login_set_conn_values(sess, conn, pdu->cid);
-	if (unlikely(ret)) {
-		kfree(sess);
-		return ret;
-	}
+	if (iscsi_login_set_conn_values(sess, conn, pdu->cid))
+		goto free_sess;
+
 	sess->init_task_tag	= pdu->itt;
 	memcpy(&sess->isid, pdu->isid, 6);
 	sess->exp_cmd_sn	= be32_to_cpu(pdu->cmdsn);


