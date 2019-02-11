Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2932C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7431D2229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897030;
	bh=ypmoBlZBlkwuUwWBqu8EhsRh8S1JjS763Y8Nj2GHi74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QTXZerBi7wUVrjlZi0fvan/Q+gaWrOW1b2KMkZzIMq3BICxU4nX7c9qSlXC7XBKu2
	 103GMGQa9YfRfGJtCWi9T2Umyd2RHgsCocmrDiRPLsMlDrnaLFhNIZRSZ+5HMdtn1G
	 AII+soPu8M0yol3EJpg1d8kjXu8Cf6pjV+iYtCdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbfBKO5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389286AbfBKO5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:57:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BAD52229E;
        Mon, 11 Feb 2019 14:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897026;
        bh=ypmoBlZBlkwuUwWBqu8EhsRh8S1JjS763Y8Nj2GHi74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkztoeRWB1McI6PNtIocJqea5yrjytgz9jDhHA/SvLjXo4PsHR9iEzdiLUHO0p9aI
         43Hf/eaasn16tGB4KjEotxnnYGDnL9TWY/e/syMlhkv4g4rJdFkEIU5wK7vISRdWEJ
         ZSyCP9lDy99AQkyjQYnJW5a/7szVktUpBRwcBvt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 067/205] driver core: Move async_synchronize_full call
Date:   Mon, 11 Feb 2019 15:17:45 +0100
Message-Id: <20190211141833.140397122@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c37d721c68ad88925ba0e72f6e14acb829a8c6bb ]

Move the async_synchronize_full call out of __device_release_driver and
into driver_detach.

The idea behind this is that the async_synchronize_full call will only
guarantee that any existing async operations are flushed. This doesn't do
anything to guarantee that a hotplug event that may occur while we are
doing the release of the driver will not be asynchronously scheduled.

By moving this into the driver_detach path we can avoid potential deadlocks
as we aren't holding the device lock at this point and we should not have
the driver we want to flush loaded so the flush will take care of any
asynchronous events the driver we are detaching might have scheduled.

Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/dd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 55fc31f6fe7f..d928cc6d0638 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -813,9 +813,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 	drv = dev->driver;
 	if (drv) {
-		if (driver_allows_async_probing(drv))
-			async_synchronize_full();
-
 		while (device_links_busy(dev)) {
 			device_unlock(dev);
 			if (parent)
@@ -920,6 +917,9 @@ void driver_detach(struct device_driver *drv)
 	struct device_private *dev_prv;
 	struct device *dev;
 
+	if (driver_allows_async_probing(drv))
+		async_synchronize_full();
+
 	for (;;) {
 		spin_lock(&drv->p->klist_devices.k_lock);
 		if (list_empty(&drv->p->klist_devices.k_list)) {
-- 
2.19.1



