Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9DAECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7139420864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7139420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbeGPIDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:03:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPIDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:03:41 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E263C03;
        Mon, 16 Jul 2018 07:37:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.17 17/67] mei: discard messages from not connected client during power down.
Date:   Mon, 16 Jul 2018 09:34:46 +0200
Message-Id: <20180716073445.776868927@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit b7a020bff31318fc8785e6f96b1d38c1625cf1fb upstream.

This fixes regression introduced by
commit 8d52af6795c0 ("mei: speed up the power down flow")

In power down or suspend flow a message can still be received
from the FW because the clients fake disconnection.
In normal case we interpret messages w/o destination as corrupted
and link reset is performed in order to clean the channel,
but during power down link reset is already in progress resulting
in endless loop. To resolve the issue under power down flow we
discard messages silently.

Cc: <stable@vger.kernel.org> 4.16+
Fixes: 8d52af6795c0 ("mei: speed up the power down flow")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199541
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/interrupt.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -310,8 +310,11 @@ int mei_irq_read_handler(struct mei_devi
 	if (&cl->link == &dev->file_list) {
 		/* A message for not connected fixed address clients
 		 * should be silently discarded
+		 * On power down client may be force cleaned,
+		 * silently discard such messages
 		 */
-		if (hdr_is_fixed(mei_hdr)) {
+		if (hdr_is_fixed(mei_hdr) ||
+		    dev->dev_state == MEI_DEV_POWER_DOWN) {
 			mei_irq_discard_msg(dev, mei_hdr);
 			ret = 0;
 			goto reset_slots;


