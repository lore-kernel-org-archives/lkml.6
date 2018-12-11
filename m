Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABF6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6066A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544329;
	bh=cx2yN399sfSPq4e/34CN0BofMuHAy22bp7Tlv0abq6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uT8UMr9kn1Eos8u+cOiI5S0fYPY5VCioOBVPQtQTATCPzzFSaLrSbsu3ghrgWo8RE
	 u59FQvzz9bW9LtT3kEnYoPM/NeclMoWViAQIPWqi+w6cakX+u1I2ep8VIWKMaiEFtS
	 iEdnKaHvV9efVWyUPMlrCn9qrPu56Av69+H6vUc0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6066A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbeLKQF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbeLKPzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6109F2146D;
        Tue, 11 Dec 2018 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543716;
        bh=cx2yN399sfSPq4e/34CN0BofMuHAy22bp7Tlv0abq6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deWOk5j3vyHzuy2Elz1DD9vWg9HbV6EzVJvvUGubF3tsmgvfvsiL0icDyNaExE3EM
         YFySEWi441lqDBmJcM4EAfhrJtZlJLV43f8XxZSp2IJV6unIiRwpmB9WrDqBpdQOR1
         T72Vp1F2a62cPI7L3LzzCyX8W+WsQTHvzi8rj1oA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 004/118] media: ipu3-cio2: Unregister device nodes first, then release resources
Date:   Tue, 11 Dec 2018 16:40:23 +0100
Message-Id: <20181211151644.396154031@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

[ Upstream commit 32388d6ef7cffc7d8291b67f8dfa26acd45217fd ]

While there are issues related to object lifetime management, unregister
the media device first, followed immediately by other device nodes when
the driver is being unbound. Only then the resources needed by the driver
may be released. This is slightly safer.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Bingbu Cao <bingbu.cao@intel.com>
Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 29027159eced..ca1a4d8e972e 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1846,12 +1846,12 @@ static void cio2_pci_remove(struct pci_dev *pci_dev)
 	struct cio2_device *cio2 = pci_get_drvdata(pci_dev);
 	unsigned int i;
 
+	media_device_unregister(&cio2->media_dev);
 	cio2_notifier_exit(cio2);
-	cio2_fbpt_exit_dummy(cio2);
 	for (i = 0; i < CIO2_QUEUES; i++)
 		cio2_queue_exit(cio2, &cio2->queue[i]);
+	cio2_fbpt_exit_dummy(cio2);
 	v4l2_device_unregister(&cio2->v4l2_dev);
-	media_device_unregister(&cio2->media_dev);
 	media_device_cleanup(&cio2->media_dev);
 	mutex_destroy(&cio2->lock);
 }
-- 
2.19.1



