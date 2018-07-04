Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156B7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC6924462
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC6924462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934628AbeGDMeL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:34:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43013 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933664AbeGDMeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:34:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fagz1-0000iU-8E; Wed, 04 Jul 2018 12:34:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: typec: fix dereference before null check on adev
Date:   Wed,  4 Jul 2018 13:34:06 +0100
Message-Id: <20180704123406.9496-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer adev is being dereferenced before it is being sanity
checked with a null pointer check, hence it is possible for
a null pointer dereference to occur.  Fix this by dereferencing
adev only once it is null checked.

Detected by CoverityScan, CID#1471598 ("Dereference before null check")

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/typec/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 999d7904172a..95a2b10127db 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -51,7 +51,7 @@ static int typec_altmode_set_state(struct typec_altmode *adev, int state)
 int typec_altmode_notify(struct typec_altmode *adev,
 			 unsigned long conf, void *data)
 {
-	bool is_port = is_typec_port(adev->dev.parent);
+	bool is_port;
 	struct altmode *altmode;
 	struct altmode *partner;
 	int ret;
@@ -64,6 +64,7 @@ int typec_altmode_notify(struct typec_altmode *adev,
 	if (!altmode->partner)
 		return -ENODEV;
 
+	is_port = is_typec_port(adev->dev.parent);
 	partner = altmode->partner;
 
 	ret = typec_altmode_set_mux(is_port ? altmode : partner, (u8)conf);
-- 
2.17.1

