Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA76BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9018F20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9018F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbeHAULm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:11:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404319AbeHATDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9AD21061;
        Wed,  1 Aug 2018 17:01:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 154/336] scsi: zfcp: assert that the ERP lock is held when tracing a recovery trigger
Date:   Wed,  1 Aug 2018 18:48:09 +0200
Message-Id: <20180801165035.019663522@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Remus <jremus@linux.ibm.com>

[ Upstream commit 9e156c54ace310ce7fb1cd960e62416947f3d47c ]

Otherwise iterating with list_for_each() over the adapter->erp_ready_head
and adapter->erp_running_head lists can lead to an infinite loop. See commit
"zfcp: fix infinite iteration on erp_ready_head list".

The run-time check is only performed for debug kernels which have the kernel
lock validator enabled. Following is an example of the warning that is
reported, if the ERP lock is not held when calling zfcp_dbf_rec_trig():

WARNING: CPU: 0 PID: 604 at drivers/s390/scsi/zfcp_dbf.c:288 zfcp_dbf_rec_trig+0x172/0x188
Modules linked in: ...
CPU: 0 PID: 604 Comm: kworker/u128:3 Not tainted 4.16.0-... #1
Hardware name: IBM 2964 N96 702 (z/VM 6.4.0)
Workqueue: zfcp_q_0.0.1906 zfcp_scsi_rport_work
Krnl PSW : 00000000330fdbf9 00000000367e9728 (zfcp_dbf_rec_trig+0x172/0x188)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
Krnl GPRS: 00000000c57a5d99 3288200000000000 0000000000000000 000000006cc82740
           00000000009d09d6 0000000000000000 00000000000000ff 0000000000000000
           0000000000000000 0000000000e1b5fe 000000006de01d38 0000000076130958
           000000006cc82548 000000006de01a98 00000000009d09d6 000000006a6d3c80
Krnl Code: 00000000009d0ad2: eb7ff0b80004        lmg        %r7,%r15,184(%r15)
           00000000009d0ad8: c0f4000d7dd0        brcl       15,b80678
          #00000000009d0ade: a7f40001            brc        15,9d0ae0
          >00000000009d0ae2: a7f4ff7d            brc        15,9d09dc
           00000000009d0ae6: e340f0f00004        lg         %r4,240(%r15)
           00000000009d0aec: eb7ff0b80004        lmg        %r7,%r15,184(%r15)
           00000000009d0af2: 07f4                bcr        15,%r4
           00000000009d0af4: 0707                bcr        0,%r7
Call Trace:
([<00000000009d09d6>] zfcp_dbf_rec_trig+0x66/0x188)
 [<00000000009dd740>] zfcp_scsi_rport_work+0x98/0x190
 [<0000000000169b34>] process_one_work+0x3d4/0x6f8
 [<000000000016a08a>] worker_thread+0x232/0x418
 [<000000000017219e>] kthread+0x166/0x178
 [<0000000000b815ea>] kernel_thread_starter+0x6/0xc
 [<0000000000b815e4>] kernel_thread_starter+0x0/0xc
2 locks held by kworker/u128:3/604:
 #0:  ((wq_completion)name){+.+.}, at: [<0000000082af1024>] process_one_work+0x1dc/0x6f8
 #1:  ((work_completion)(&port->rport_work)){+.+.}, at: [<0000000082af1024>] process_one_work+0x1dc/0x6f8
Last Breaking-Event-Address:
 [<00000000009d0ade>] zfcp_dbf_rec_trig+0x16e/0x188
---[ end trace b2f4020572e2c124 ]---

Suggested-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/scsi/zfcp_dbf.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -285,6 +285,8 @@ void zfcp_dbf_rec_trig(char *tag, struct
 	struct list_head *entry;
 	unsigned long flags;
 
+	lockdep_assert_held(&adapter->erp_lock);
+
 	if (unlikely(!debug_level_enabled(dbf->rec, level)))
 		return;
 


