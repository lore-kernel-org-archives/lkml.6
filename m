Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5CDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8622098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8622098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbeHWL2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:28:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeHWL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:28:25 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3F38BB6;
        Thu, 23 Aug 2018 08:00:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 39/79] HID: wacom: Correct touch maximum XY of 2nd-gen Intuos
Date:   Thu, 23 Aug 2018 09:53:15 +0200
Message-Id: <20180823074921.620626842@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gerecke <killertofu@gmail.com>

[ Upstream commit 3b8d573586d1b9dee33edf6cb6f2ca05f4bca568 ]

The touch sensors on the 2nd-gen Intuos tablets don't use a 4096x4096
sensor like other similar tablets (3rd-gen Bamboo, Intuos5, etc.).
The incorrect maximum XY values don't normally affect userspace since
touch input from these devices is typically relative rather than
absolute. It does, however, cause problems when absolute distances
need to be measured, e.g. for gesture recognition. Since the resolution
of the touch sensor on these devices is 10 units / mm (versus 100 for
the pen sensor), the proper maximum values can be calculated by simply
dividing by 10.

Fixes: b5fd2a3e92 ("Input: wacom - add support for three new Intuos devices")
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_wac.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2487,8 +2487,14 @@ void wacom_setup_device_quirks(struct wa
 			if (features->type >= INTUOSHT && features->type <= BAMBOO_PT)
 				features->device_type |= WACOM_DEVICETYPE_PAD;
 
-			features->x_max = 4096;
-			features->y_max = 4096;
+			if (features->type == INTUOSHT2) {
+				features->x_max = features->x_max / 10;
+				features->y_max = features->y_max / 10;
+			}
+			else {
+				features->x_max = 4096;
+				features->y_max = 4096;
+			}
 		}
 		else if (features->pktlen == WACOM_PKGLEN_BBTOUCH) {
 			features->device_type |= WACOM_DEVICETYPE_PAD;


