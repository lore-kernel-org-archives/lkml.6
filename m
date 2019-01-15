Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2844120645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570666;
	bh=qGPJZvt3j/ipzuNM2WkWmUsb19evjrHcR3MLpUz1AFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uvOUGb3LAw3A31j1UHiInwLC7z8sDohrBmbQzdCjxKEfmZf/nKm3eljeWeLfbV/Zc
	 CvXi3xhz+HuFhEHKCPnVu3tmcinpQMV4ltSx3bBNoduH65MsoJm1FeETed/xxQR49m
	 MzOMsUgI/bHALjIRbidutxKxJsqYcKXVPyP9SKyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbfAOQoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbfAOQoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28AB2054F;
        Tue, 15 Jan 2019 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570660;
        bh=qGPJZvt3j/ipzuNM2WkWmUsb19evjrHcR3MLpUz1AFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dx9WxXDKSAUQb7hdNqcd+YM/c+p2kXjVMzD/6XxfI/PCdukTTl9gtE9qpYi/4Rlve
         MFjXk+koP5EqWekvplXxNuZuDRnrqWTkaX860MJhWkCMqwlMBBqqHdjU+ipc3pMdDx
         +heluqtMn/WzP8ibTxp0998ki129IcZQS1gbDb1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.20 24/57] USB: storage: dont insert sane sense for SPC3+ when bad sense specified
Date:   Tue, 15 Jan 2019 17:36:05 +0100
Message-Id: <20190115154912.063907661@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Icenowy Zheng <icenowy@aosc.io>

commit c5603d2fdb424849360fe7e3f8c1befc97571b8c upstream.

Currently the code will set US_FL_SANE_SENSE flag unconditionally if
device claims SPC3+, however we should allow US_FL_BAD_SENSE flag to
prevent this behavior, because SMI SM3350 UFS-USB bridge controller,
which claims SPC4, will show strange behavior with 96-byte sense
(put the chip into a wrong state that cannot read/write anything).

Check the presence of US_FL_BAD_SENSE when assuming US_FL_SANE_SENSE on
SPC4+ devices.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Cc: stable <stable@vger.kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/scsiglue.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -235,8 +235,12 @@ static int slave_configure(struct scsi_d
 		if (!(us->fflags & US_FL_NEEDS_CAP16))
 			sdev->try_rc_10_first = 1;
 
-		/* assume SPC3 or latter devices support sense size > 18 */
-		if (sdev->scsi_level > SCSI_SPC_2)
+		/*
+		 * assume SPC3 or latter devices support sense size > 18
+		 * unless US_FL_BAD_SENSE quirk is specified.
+		 */
+		if (sdev->scsi_level > SCSI_SPC_2 &&
+		    !(us->fflags & US_FL_BAD_SENSE))
 			us->fflags |= US_FL_SANE_SENSE;
 
 		/*


