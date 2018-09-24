Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BBCC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBCB208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBCB208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbeIXSTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:19:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbeIXSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:19:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 15C1C107E;
        Mon, 24 Sep 2018 12:17:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.14 089/173] usb: uas: add support for more quirk flags
Date:   Mon, 24 Sep 2018 13:52:03 +0200
Message-Id: <20180924113122.602674608@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 42d1c6d4a06a77b3ab206a919b9050c3080f3a71 upstream.

The hope that UAS devices would be less broken than old style storage
devices has turned out to be unfounded. Make UAS support more of the
quirk flags of the old driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -842,6 +842,27 @@ static int uas_slave_configure(struct sc
 		sdev->skip_ms_page_8 = 1;
 		sdev->wce_default_on = 1;
 	}
+
+	/*
+	 * Some disks return the total number of blocks in response
+	 * to READ CAPACITY rather than the highest block number.
+	 * If this device makes that mistake, tell the sd driver.
+	 */
+	if (devinfo->flags & US_FL_FIX_CAPACITY)
+		sdev->fix_capacity = 1;
+
+	/*
+	 * Some devices don't like MODE SENSE with page=0x3f,
+	 * which is the command used for checking if a device
+	 * is write-protected.  Now that we tell the sd driver
+	 * to do a 192-byte transfer with this command the
+	 * majority of devices work fine, but a few still can't
+	 * handle it.  The sd driver will simply assume those
+	 * devices are write-enabled.
+	 */
+	if (devinfo->flags & US_FL_NO_WP_DETECT)
+		sdev->skip_ms_page_3f = 1;
+
 	scsi_change_queue_depth(sdev, devinfo->qdepth - 2);
 	return 0;
 }


