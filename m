Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EBEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18D920877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18D920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbeIXSE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:04:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeIXSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:04:25 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 72D2D106D;
        Mon, 24 Sep 2018 12:02:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.9 055/111] mei: ignore not found client in the enumeration
Date:   Mon, 24 Sep 2018 13:52:22 +0200
Message-Id: <20180924113110.406252928@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit 8d2d8935d30cc2acc57a3196dc10dfa8d5cbcdab upstream.

Some of the ME clients are available only for BIOS operation and are
removed during hand off to an OS. However the removal is not instant.
A client may be visible on the client list when the mei driver requests
for enumeration, while the subsequent request for properties will be
answered with client not found error value. The default behavior
for an error is to perform client reset while this error is harmless and
the link reset should be prevented. This issue started to be visible due to
suspend/resume timing changes. Currently reported only on the Haswell
based system.

Fixes:
[33.564957] mei_me 0000:00:16.0: hbm: properties response: wrong status = 1 CLIENT_NOT_FOUND
[33.564978] mei_me 0000:00:16.0: mei_irq_read_handler ret = -71.
[33.565270] mei_me 0000:00:16.0: unexpected reset: dev_state = INIT_CLIENTS fw status = 1E000255 60002306 00000200 00004401 00000000 00000010

Cc: <stable@vger.kernel.org>
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/hbm.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1137,15 +1137,18 @@ int mei_hbm_dispatch(struct mei_device *
 
 		props_res = (struct hbm_props_response *)mei_msg;
 
-		if (props_res->status) {
+		if (props_res->status == MEI_HBMS_CLIENT_NOT_FOUND) {
+			dev_dbg(dev->dev, "hbm: properties response: %d CLIENT_NOT_FOUND\n",
+				props_res->me_addr);
+		} else if (props_res->status) {
 			dev_err(dev->dev, "hbm: properties response: wrong status = %d %s\n",
 				props_res->status,
 				mei_hbm_status_str(props_res->status));
 			return -EPROTO;
+		} else {
+			mei_hbm_me_cl_add(dev, props_res);
 		}
 
-		mei_hbm_me_cl_add(dev, props_res);
-
 		/* request property for the next client */
 		if (mei_hbm_prop_req(dev, props_res->me_addr + 1))
 			return -EIO;


