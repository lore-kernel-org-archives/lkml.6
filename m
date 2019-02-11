Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B919C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA393222A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899293;
	bh=3C4kiI5mktAYE/9kNLO+LVXEvDywedN/MfUnpJqWdjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a2ublVLh6Kuuy4dB8Grg2bOHv3wiG/RcE57pMs4K/FsAC0BnrIsf5nPuYEB4mgzSw
	 jV4DvCdMZYU1E9+s76lJg5rFST1WyoBWuHCB4SGBEGuwvKOkytKj/zceZceiuqQJdC
	 EgZzsyu9bZ6dHCGnQqkwIi8yLN33WMuK/m/SGDqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbfBKPev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:34:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388534AbfBKOw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2385D20700;
        Mon, 11 Feb 2019 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896776;
        bh=3C4kiI5mktAYE/9kNLO+LVXEvDywedN/MfUnpJqWdjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNYmWLNXF0fBenyIG4EfSvmgZUwndDVm0M8S8VMSZbHKB2oAnGiRb3O0tbD4X3z7i
         e4RLIWldmtnTFrF9P/RRix8HrbPNm6pjBZ8/ayG7xIDgCBLM+nM3WJxJ1GOY/OMoaf
         9U/0OEwz8nmQNm0MU/iVdTFGngUSdeH/KS9nvBcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 298/313] scsi: cxlflash: Prevent deadlock when adapter probe fails
Date:   Mon, 11 Feb 2019 15:19:38 +0100
Message-Id: <20190211141912.852760827@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

From: Vaibhav Jain <vaibhav@linux.ibm.com>

commit bb61b843ffd46978d7ca5095453e572714934eeb upstream.

Presently when an error is encountered during probe of the cxlflash
adapter, a deadlock is seen with cpu thread stuck inside
cxlflash_remove(). Below is the trace of the deadlock as logged by
khungtaskd:

cxlflash 0006:00:00.0: cxlflash_probe: init_afu failed rc=-16
INFO: task kworker/80:1:890 blocked for more than 120 seconds.
       Not tainted 5.0.0-rc4-capi2-kexec+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/80:1    D    0   890      2 0x00000808
Workqueue: events work_for_cpu_fn

Call Trace:
 0x4d72136320 (unreliable)
 __switch_to+0x2cc/0x460
 __schedule+0x2bc/0xac0
 schedule+0x40/0xb0
 cxlflash_remove+0xec/0x640 [cxlflash]
 cxlflash_probe+0x370/0x8f0 [cxlflash]
 local_pci_probe+0x6c/0x140
 work_for_cpu_fn+0x38/0x60
 process_one_work+0x260/0x530
 worker_thread+0x280/0x5d0
 kthread+0x1a8/0x1b0
 ret_from_kernel_thread+0x5c/0x80
INFO: task systemd-udevd:5160 blocked for more than 120 seconds.

The deadlock occurs as cxlflash_remove() is called from cxlflash_probe()
without setting 'cxlflash_cfg->state' to STATE_PROBED and the probe thread
starts to wait on 'cxlflash_cfg->reset_waitq'. Since the device was never
successfully probed the 'cxlflash_cfg->state' never changes from
STATE_PROBING hence the deadlock occurs.

We fix this deadlock by setting the variable 'cxlflash_cfg->state' to
STATE_PROBED in case an error occurs during cxlflash_probe() and just
before calling cxlflash_remove().

Cc: stable@vger.kernel.org
Fixes: c21e0bbfc485("cxlflash: Base support for IBM CXL Flash Adapter")
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/cxlflash/main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3694,6 +3694,7 @@ static int cxlflash_probe(struct pci_dev
 	host->max_cmd_len = CXLFLASH_MAX_CDB_LEN;
 
 	cfg = shost_priv(host);
+	cfg->state = STATE_PROBING;
 	cfg->host = host;
 	rc = alloc_mem(cfg);
 	if (rc) {
@@ -3782,6 +3783,7 @@ out:
 	return rc;
 
 out_remove:
+	cfg->state = STATE_PROBED;
 	cxlflash_remove(pdev);
 	goto out;
 }


