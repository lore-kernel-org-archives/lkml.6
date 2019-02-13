Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB57AC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99C0222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025483;
	bh=2+ElqeV+nIunlzrCHfSoDCQl8YyInhtsu8IqX/ZPXSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZbB2Kk2zmFRb8Mj4AEN6eK5clg9xTFhmkSYqb8qm8+jloH7trBGzAYmbXbMDgj2E0
	 Jl1SxkFT8fFJuODQqVWz4xw7vYuElHC8A51GZySsEFrbbPO2RURCUMuNatTqIhAzMZ
	 fLs14CMPg3BVO8KWZaWEfu3BHHO37QWZRaNwEibM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbfBMCiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:38:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388422AbfBMCh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88811206B6;
        Wed, 13 Feb 2019 02:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025475;
        bh=2+ElqeV+nIunlzrCHfSoDCQl8YyInhtsu8IqX/ZPXSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaX4ETy//tZXAGH+LOSI96rqxvMnjO0eM3NODK8VEac2wFB2hL0oEmdWHs7bY/8rI
         IIOwEyIH7U5BE4+NDQzSrEBxbYVfCq/21d6AtEncug7BOcqr0HJZTgWy55cB3JwSop
         TLROjGG8Au1dREx3POjL8FTYJjFN9WaB2YruZGJk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeff Moyer <jmoyer@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 34/83] scsi: isci: initialize shost fully before calling scsi_add_host()
Date:   Tue, 12 Feb 2019 21:36:12 -0500
Message-Id: <20190213023701.20286-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit cc29a1b0a3f2597ce887d339222fa85b9307706d ]

scsi_mq_setup_tags(), which is called by scsi_add_host(), calculates the
command size to allocate based on the prot_capabilities. In the isci
driver, scsi_host_set_prot() is called after scsi_add_host() so the command
size gets calculated to be smaller than it needs to be.  Eventually,
scsi_mq_init_request() locates the 'prot_sdb' after the command assuming it
was sized correctly and a buffer overrun may occur.

However, seeing blk_mq_alloc_rqs() rounds up to the nearest cache line
size, the mistake can go unnoticed.

The bug was noticed after the struct request size was reduced by commit
9d037ad707ed ("block: remove req->timeout_list")

Which likely reduced the allocated space for the request by an entire cache
line, enough that the overflow could be hit and it caused a panic, on boot,
at:

  RIP: 0010:t10_pi_complete+0x77/0x1c0
  Call Trace:
    <IRQ>
    sd_done+0xf5/0x340
    scsi_finish_command+0xc3/0x120
    blk_done_softirq+0x83/0xb0
    __do_softirq+0xa1/0x2e6
    irq_exit+0xbc/0xd0
    call_function_single_interrupt+0xf/0x20
    </IRQ>

sd_done() would call scsi_prot_sg_count() which reads the number of
entities in 'prot_sdb', but seeing 'prot_sdb' is located after the end of
the allocated space it reads a garbage number and erroneously calls
t10_pi_complete().

To prevent this, the calls to scsi_host_set_prot() are moved into
isci_host_alloc() before the call to scsi_add_host(). Out of caution, also
move the similar call to scsi_host_set_guard().

Fixes: 3d2d75254915 ("[SCSI] isci: T10 DIF support")
Link: http://lkml.kernel.org/r/da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Intel SCU Linux support <intel-linux-scu@intel.com>
Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/isci/init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 08c7b1e25fe4..dde84f744313 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -588,6 +588,13 @@ static struct isci_host *isci_host_alloc(struct pci_dev *pdev, int id)
 	shost->max_lun = ~0;
 	shost->max_cmd_len = MAX_COMMAND_SIZE;
 
+	/* turn on DIF support */
+	scsi_host_set_prot(shost,
+			   SHOST_DIF_TYPE1_PROTECTION |
+			   SHOST_DIF_TYPE2_PROTECTION |
+			   SHOST_DIF_TYPE3_PROTECTION);
+	scsi_host_set_guard(shost, SHOST_DIX_GUARD_CRC);
+
 	err = scsi_add_host(shost, &pdev->dev);
 	if (err)
 		goto err_shost;
@@ -675,13 +682,6 @@ static int isci_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			goto err_host_alloc;
 		}
 		pci_info->hosts[i] = h;
-
-		/* turn on DIF support */
-		scsi_host_set_prot(to_shost(h),
-				   SHOST_DIF_TYPE1_PROTECTION |
-				   SHOST_DIF_TYPE2_PROTECTION |
-				   SHOST_DIF_TYPE3_PROTECTION);
-		scsi_host_set_guard(to_shost(h), SHOST_DIX_GUARD_CRC);
 	}
 
 	err = isci_setup_interrupts(pdev);
-- 
2.19.1

