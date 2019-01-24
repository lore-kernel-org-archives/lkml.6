Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99096C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650C2218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358517;
	bh=SOdfPhYJrCKR9xkGXpIpjF3UsoA6sBhg4e5Wzwg2pR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ipehEKfT2yP+ajUduSgSwfLk1pbUn6xeN1GWsq3PYwJyZQ/2TZWHJBuzL+Y9FCh0z
	 ctZWRhRAu+2JaA8+NSeguAFSkiJ3fStiZlx/c1vVjKe0Q+wd13Y4KVcIkvex8MDEQL
	 T9CwC04HkY9zlMe/0Vld0CveXwG9jj7S5FvMOAWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfAXTfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731935AbfAXTfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:35:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53EC5218D4;
        Thu, 24 Jan 2019 19:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358512;
        bh=SOdfPhYJrCKR9xkGXpIpjF3UsoA6sBhg4e5Wzwg2pR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gz8aw/0ANMu5QBEd6n0OoscGCgl9wSRrJp6ReuXD4gTFziscokYySfOjTcLnUuJog
         ckCe4UoMwEv9B1LPw2q8Ju+uVBy4403x19icQkX7XS8oYUwmNTKbNxEY5FOpxQ7EvE
         H2LIejIOM7FQKXMbsNLafXhebMcqIhpYswG5QshU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manish Rangankar <manish.rangankar@cavium.com>,
        Lee Duncan <lduncan@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/106] scsi: qedi: Check for session online before getting iSCSI TLV data.
Date:   Thu, 24 Jan 2019 20:19:52 +0100
Message-Id: <20190124190208.620124426@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d5632b11f0a17efa6356311e535ae135d178438d ]

The kernel panic was observed after switch side perturbation,

BUG: unable to handle kernel NULL pointer dereference at (null)
     IP: [<ffffffff8132b5a0>] strcmp+0x20/0x40
     PGD 0 Oops: 0000 [#1] SMP
CPU: 8 PID: 647 Comm: kworker/8:1 Tainted: G        W  OE  ------------   3.10.0-693.el7.x86_64 #1
Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS U30 06/20/2018
Workqueue: slowpath-13:00. qed_slowpath_task [qed]
task: ffff880429eb8fd0 ti: ffff880429190000 task.ti: ffff880429190000
RIP: 0010:[<ffffffff8132b5a0>]  [<ffffffff8132b5a0>] strcmp+0x20/0x40
RSP: 0018:ffff880429193c68  EFLAGS: 00010202
RAX: 000000000000000a RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff88042bda7a41
RBP: ffff880429193c68 R08: 000000000000ffff R09: 000000000000ffff
R10: 0000000000000007 R11: ffff88042b3af338 R12: ffff880420b007a0
R13: ffff88081aa56af8 R14: 0000000000000001 R15: ffff88081aa50410
FS:  0000000000000000(0000) GS:ffff88042fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000019f2000 CR4: 00000000003407e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Stack:
ffff880429193d20 ffffffffc02a0c90 ffffc90004b32000 ffff8803fd3ec600
ffff88042bda7800 ffff88042bda7a00 ffff88042bda7840 ffff88042bda7a40
0000000129193d10 2e3836312e323931 ff000a342e363232 ffffffffc01ad99d
Call Trace:
[<ffffffffc02a0c90>] qedi_get_protocol_tlv_data+0x270/0x470 [qedi]
[<ffffffffc01ad99d>] ? qed_mfw_process_tlv_req+0x24d/0xbf0 [qed]
[<ffffffffc01653ae>] qed_mfw_fill_tlv_data+0x5e/0xd0 [qed]
[<ffffffffc01ad9b9>] qed_mfw_process_tlv_req+0x269/0xbf0 [qed]

Fix kernel NULL pointer deref by checking for session is online before
getting iSCSI TLV data.

Signed-off-by: Manish Rangankar <manish.rangankar@cavium.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index e5bd035ebad0..4de740da547b 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -952,6 +952,9 @@ static int qedi_find_boot_info(struct qedi_ctx *qedi,
 		cls_sess = iscsi_conn_to_session(cls_conn);
 		sess = cls_sess->dd_data;
 
+		if (!iscsi_is_session_online(cls_sess))
+			continue;
+
 		if (pri_ctrl_flags) {
 			if (!strcmp(pri_tgt->iscsi_name, sess->targetname) &&
 			    !strcmp(pri_tgt->ip_addr, ep_ip_addr)) {
-- 
2.19.1



