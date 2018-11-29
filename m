Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91100C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549C921104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYZkOYn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549C921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbeK3BVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:21:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbeK3BV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:21:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DBB1205C9;
        Thu, 29 Nov 2018 14:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500959;
        bh=bPr+O65SRC63T8dOf8StYevoVbBwWscX1PrkKZsZHpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYZkOYn3D0V6rTEog8H3q5jgY9VCuvIMiCLRpsm5jr4mzNahJJKXjeWSkbsjeBwzP
         6eAG84i9k3isbEmFG2ycDr6o1erFbXldc5qLd9XuJiS2jqytWcTBYgKNdjHOefiXyK
         tVNgnC+IlRDWhsXCJFWeXg89iMgeQdGrK1dp18IE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 67/83] Input: xpad - validate USB endpoint type during probe
Date:   Thu, 29 Nov 2018 15:12:25 +0100
Message-Id: <20181129140141.604106963@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 122d6a347329818419b032c5a1776e6b3866d9b9 ]

We should only see devices with interrupt endpoints. Ignore any other
endpoints that we find, so we don't send try to send them interrupt URBs
and trigger a WARN down in the USB stack.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Cc: <stable@vger.kernel.org> # c01b5e7464f0 Input: xpad - don't depend on endpoint order
Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f8e34ef643c7..d86e59515b9c 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1764,10 +1764,12 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		struct usb_endpoint_descriptor *ep =
 				&intf->cur_altsetting->endpoint[i].desc;
 
-		if (usb_endpoint_dir_in(ep))
-			ep_irq_in = ep;
-		else
-			ep_irq_out = ep;
+		if (usb_endpoint_xfer_int(ep)) {
+			if (usb_endpoint_dir_in(ep))
+				ep_irq_in = ep;
+			else
+				ep_irq_out = ep;
+		}
 	}
 
 	if (!ep_irq_in || !ep_irq_out) {
-- 
2.17.1



