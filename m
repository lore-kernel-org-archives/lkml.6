Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7040BC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439A620663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359156;
	bh=Qd28OMDjz6NVammSyczS4WmsHiF+toNndT7CwJgGTfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ffnDEIESE3IavkuRbYSdI+bG9PpRp+xlZAqU1+jYD/iYVNK4IZ2KkQupxPxqrc4gD
	 +t1iTrCQhW0c6mkgQMeGBTz56iLJI6qzR53+ZmdVK/TJzqc/K51RKQKTrRcSq8N71X
	 OaPh8kasWdOSEPcdMwytvOFvse+SVW5xjXv/xlIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbfAXTpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:45:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388064AbfAXToT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:44:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D172D20663;
        Thu, 24 Jan 2019 19:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359059;
        bh=Qd28OMDjz6NVammSyczS4WmsHiF+toNndT7CwJgGTfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUAQSIRHnRxe7o/ajMDAsqYyLL2YP67wNTts2DUBe9sKlwE7zBPF7eoWbe2ZZ2UIy
         Pb8asqsp2O8bT3yz16St83qiDWXo9jkuv5N4BWWSLHKo64tsYDxOM2QcUBe5KePGQQ
         rx+/cAOKUtLT/xHl+hyGMV1qzLZ1wrvSXfw9kmKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hedberg <johan.hedberg@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.20 122/127] Bluetooth: Fix unnecessary error message for HCI request completion
Date:   Thu, 24 Jan 2019 20:21:08 +0100
Message-Id: <20190124190217.117167784@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

From: Johan Hedberg <johan.hedberg@intel.com>

commit 1629db9c75342325868243d6bca5853017d91cf8 upstream.

In case a command which completes in Command Status was sent using the
hci_cmd_send-family of APIs there would be a misleading error in the
hci_get_cmd_complete function, since the code would be trying to fetch
the Command Complete parameters when there are none.

Avoid the misleading error and silently bail out from the function in
case the received event is a command status.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Tested-by Adam Ford <aford173@gmail.com> #4.19.16
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/hci_event.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5711,6 +5711,12 @@ static bool hci_get_cmd_complete(struct
 		return true;
 	}
 
+	/* Check if request ended in Command Status - no way to retreive
+	 * any extra parameters in this case.
+	 */
+	if (hdr->evt == HCI_EV_CMD_STATUS)
+		return false;
+
 	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
 		bt_dev_err(hdev, "last event is not cmd complete (0x%2.2x)",
 			   hdr->evt);


