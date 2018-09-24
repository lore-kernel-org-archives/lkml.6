Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D5DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9F52083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9F52083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbeIXSjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:39:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbeIXSjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:39:46 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 216F6107F;
        Mon, 24 Sep 2018 12:37:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 086/235] drivers/base: stop new probing during shutdown
Date:   Mon, 24 Sep 2018 13:51:12 +0200
Message-Id: <20180924113113.625835894@linuxfoundation.org>
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

From: Pingfan Liu <kernelfans@gmail.com>

[ Upstream commit 3297c8fc65af5d40501ea7cddff1b195cae57e4e ]

There is a race window in device_shutdown(), which may cause
-1. parent device shut down before child or
-2. no shutdown on a new probing device.

For 1st, taking the following scenario:
         device_shutdown                        new plugin device
  list_del_init(parent_dev);
  spin_unlock(list_lock);
                                                  device_add(child)
                                                  probe child
  shutdown parent_dev
       --> now child is on the tail of devices_kset

For 2nd, taking the following scenario:
         device_shutdown                        new plugin device
                                                  device_add(dev)
  device_lock(dev);
  ...
  device_unlock(dev);
                                                  probe dev
       --> now, the new occurred dev has no opportunity to shutdown

To fix this race issue, just prevent the new probing request. With this
logic, device_shutdown() is more similar to dpm_prepare().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2809,6 +2809,9 @@ void device_shutdown(void)
 {
 	struct device *dev, *parent;
 
+	wait_for_device_probe();
+	device_block_probing();
+
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.


