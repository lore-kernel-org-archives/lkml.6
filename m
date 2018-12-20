Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5366CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B2C20989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298178;
	bh=v+k6eve9/GMvTqQ/IIK+O8PkDbBKL/rXQM91wRDesW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XpFCsBpkTGJb2KGyQWDZBQRQMdfcAYi+dGs1WNrFqhhCWY3/PiOimpPodV7u7Ggzw
	 LEUB7eSkjcKsNUpY81vJWmHJZP7AwdlfgAvnpPNwSggYG5Ce24D9dKuFk7JpFrVrbH
	 3RlfNHHs/h9UpptYqYRpiesClo+PnKb3NysBrrXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbeLTJ3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732726AbeLTJ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A01720989;
        Thu, 20 Dec 2018 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298173;
        bh=v+k6eve9/GMvTqQ/IIK+O8PkDbBKL/rXQM91wRDesW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAxEsBQv9BUSNbVb97s4OZImuzuSw7PDqNM0ypw8KRQNM3cz0jNd9BgYK2gH88yTD
         2XzOvTj+Uv2ML8vXG+OVstAxboFEfAE5psKmjVdj+NPmhIzxjMSDCRXWGg1/Iq/uaH
         /iXxq/bRjbADRhVEX1dJRIkOM99ZxqU5Bzq++jCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cathy Avery <cavery@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/67] scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload
Date:   Thu, 20 Dec 2018 10:18:20 +0100
Message-Id: <20181220085903.896208539@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

[ Upstream commit 02f425f811cefcc4d325d7a72272651e622dc97e ]

Currently pvscsi_remove calls free_irq more than once as
pvscsi_release_resources and __pvscsi_shutdown both call
pvscsi_shutdown_intr. This results in a 'Trying to free already-free IRQ'
warning and stack trace. To solve the problem pvscsi_shutdown_intr has been
moved out of pvscsi_release_resources.

Signed-off-by: Cathy Avery <cavery@redhat.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/vmw_pvscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 0cd947f78b5b..890b8aaf95e1 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1202,8 +1202,6 @@ static void pvscsi_shutdown_intr(struct pvscsi_adapter *adapter)
 
 static void pvscsi_release_resources(struct pvscsi_adapter *adapter)
 {
-	pvscsi_shutdown_intr(adapter);
-
 	if (adapter->workqueue)
 		destroy_workqueue(adapter->workqueue);
 
@@ -1535,6 +1533,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_reset_adapter:
 	ll_adapter_reset(adapter);
 out_release_resources:
+	pvscsi_shutdown_intr(adapter);
 	pvscsi_release_resources(adapter);
 	scsi_host_put(host);
 out_disable_device:
@@ -1543,6 +1542,7 @@ out_disable_device:
 	return error;
 
 out_release_resources_and_disable:
+	pvscsi_shutdown_intr(adapter);
 	pvscsi_release_resources(adapter);
 	goto out_disable_device;
 }
-- 
2.19.1



