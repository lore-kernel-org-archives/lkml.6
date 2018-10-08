Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD4C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE32121479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiS8HtJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE32121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbeJIB7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2BDC21479;
        Mon,  8 Oct 2018 18:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024361;
        bh=jA3sLgoXXBUU44gVuWVWTDRDRlTSpxZwVjIxadzjbRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiS8HtJgL/2jCC9mmq63V99jF83GcYjMfzjObjehSYG3PSRtDwPJVKdDaKceAwDJn
         +tDHnYJqiz7tyzwbzpQTA/6phMyV6TssYhJL7Cq1ygdoMNnQKLAZjgHhgYd2oYxp3A
         Y5/wOAkNlEvQvDYZ+lQ7A0WVKcuXdJwyOmIr4txc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 008/168] scsi: csiostor: add a check for NULL pointer after kmalloc()
Date:   Mon,  8 Oct 2018 20:29:48 +0200
Message-Id: <20181008175620.355042947@linuxfoundation.org>
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

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 89809b028b6f54187b7d81a0c69b35d394c52e62 ]

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/csiostor/csio_hw.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -2275,8 +2275,8 @@ bye:
 }
 
 /*
- * Returns -EINVAL if attempts to flash the firmware failed
- * else returns 0,
+ * Returns -EINVAL if attempts to flash the firmware failed,
+ * -ENOMEM if memory allocation failed else returns 0,
  * if flashing was not attempted because the card had the
  * latest firmware ECANCELED is returned
  */
@@ -2304,6 +2304,13 @@ csio_hw_flash_fw(struct csio_hw *hw, int
 		return -EINVAL;
 	}
 
+	/* allocate memory to read the header of the firmware on the
+	 * card
+	 */
+	card_fw = kmalloc(sizeof(*card_fw), GFP_KERNEL);
+	if (!card_fw)
+		return -ENOMEM;
+
 	if (csio_is_t5(pci_dev->device & CSIO_HW_CHIP_MASK))
 		fw_bin_file = FW_FNAME_T5;
 	else
@@ -2317,11 +2324,6 @@ csio_hw_flash_fw(struct csio_hw *hw, int
 		fw_size = fw->size;
 	}
 
-	/* allocate memory to read the header of the firmware on the
-	 * card
-	 */
-	card_fw = kmalloc(sizeof(*card_fw), GFP_KERNEL);
-
 	/* upgrade FW logic */
 	ret = csio_hw_prep_fw(hw, fw_info, fw_data, fw_size, card_fw,
 			 hw->fw_state, reset);


