Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84733ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9842148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9842148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbeIXSgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:36:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeIXSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:36:18 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91E301018;
        Mon, 24 Sep 2018 12:34:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4.18 109/235] vmbus: dont return values for uninitalized channels
Date:   Mon, 24 Sep 2018 13:51:35 +0200
Message-Id: <20180924113116.640890602@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Stephen Hemminger <stephen@networkplumber.org>

commit 6712cc9c22117a8af9f3df272b4a44fd2e4201cd upstream.

For unsupported device types, the vmbus channel ringbuffer is never
initialized, and therefore reading the sysfs files will return garbage
or cause a kernel OOPS.

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Cc: <stable@vger.kernel.org> # 4.15
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/vmbus_drv.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1178,6 +1178,9 @@ static ssize_t vmbus_chan_attr_show(stru
 	if (!attribute->show)
 		return -EIO;
 
+	if (chan->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
+
 	return attribute->show(chan, buf);
 }
 


