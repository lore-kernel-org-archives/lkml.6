Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD10BC677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5606721473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="HXMW+i15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5606721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeJGAYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 20:24:23 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53746 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbeJGAYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 20:24:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1EF7D8EE2BB;
        Sat,  6 Oct 2018 10:20:14 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K6pWYy1Z-xf3; Sat,  6 Oct 2018 10:20:14 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 852A08EE2AF;
        Sat,  6 Oct 2018 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1538846413;
        bh=tvUNzdmAaNE7KHOfk35FVe6lSKXXgmWIiDWeikbxjes=;
        h=Subject:From:To:Cc:Date:From;
        b=HXMW+i152irvAiPDTYUmAQ79ZxLRyFFQOmn/OxKRmV45wzuSkL+rWJ0OAr7DiCEVH
         lmB+KDHbxhqtoobmUCWBOPFLdZzd8CrUh7MRJy49lf41ngcysD+55dW4aqYrzUhhOw
         wHbFkvAGPdwVbk+wKnIUNfJKlQuytuWcHcVB+bWY=
Message-ID: <1538846412.4088.1.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 4.19-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 06 Oct 2018 10:20:12 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small fix for an unititialized mutex in the qedi driver.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Nilesh Javali (1):
      scsi: qedi: Initialize the stats mutex lock

and the diffstat:

 drivers/scsi/qedi/qedi_main.c | 1 +
 1 file changed, 1 insertion(+)

With full diff below.

James

---

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index cc8e64dc65ad..e5bd035ebad0 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2472,6 +2472,7 @@ static int __qedi_probe(struct pci_dev *pdev, int mode)
 		/* start qedi context */
 		spin_lock_init(&qedi->hba_lock);
 		spin_lock_init(&qedi->task_idx_lock);
+		mutex_init(&qedi->stats_lock);
 	}
 	qedi_ops->ll2->register_cb_ops(qedi->cdev, &qedi_ll2_cb_ops, qedi);
 	qedi_ops->ll2->start(qedi->cdev, &params);
