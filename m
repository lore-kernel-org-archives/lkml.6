Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3126C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCAD21872
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129738;
	bh=9Po2HbWKJ3OqlbTzy3zk/iyN22HBZrdhZhThWcjwGgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pBam8nGfyRlUsuukzckQV7lru5Lu7bPl5o7F0TrMwT4oqYSYDwLgaFSZvti8xkVaz
	 mTCQNx0KYjBUKfis+svYxcU60DQKZ6q44DkA3ctgDnegqKmoRWGC3hVkLPeWuF3jLe
	 1grJyeguLjqj0Zp2uHFtwGwW0Olj3l5ktggxyO58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfBYVWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfBYVWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328B621848;
        Mon, 25 Feb 2019 21:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129733;
        bh=9Po2HbWKJ3OqlbTzy3zk/iyN22HBZrdhZhThWcjwGgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svIqguicR5l7lBRgA45rspovFV3VOiVpyFPLmc3AXfQXGioPr+155jvCuaSlHKl+1
         zV/iExJY1uDXjVvZv6fUN18l8bPebckVjX6MbJndj+C2UK1BzBRJSef/kRlvhp8OEi
         i18dF05Gg0YNWXAEHI3p14hmFKeICGPd9+ALqewQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeff Moyer <jmoyer@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/152] scsi: isci: initialize shost fully before calling scsi_add_host()
Date:   Mon, 25 Feb 2019 22:10:41 +0100
Message-Id: <20190225195047.043237275@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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
index 08c7b1e25fe48..dde84f7443136 100644
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



