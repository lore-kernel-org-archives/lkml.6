Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD95C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1810920881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697405;
	bh=k7gz+tZClWa88j9/ebpZ9JvfugdGv+ivXb6VSrzN+CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m7OdnqywpBVU0rquQICTGi8PpJKm7eO5mMwhM2EoqWjkirFP2rMKOAxVQRUv/Soqj
	 Otxmg6ALRTZYEMLP0U6y3KCOD1oJgHmPOKgsd7fKvBddm5OfBMfVwG0mUywv+rcWYH
	 RSCfJ2SzOKGFwX9WgZZI6m3ccRwvpYkv0R7psHQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfA1Pty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbfA1Ptv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C2C20880;
        Mon, 28 Jan 2019 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690590;
        bh=k7gz+tZClWa88j9/ebpZ9JvfugdGv+ivXb6VSrzN+CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZwkPIwRLFBjVciAOtPhUh/vdB8JaWqeKAI3NolZqdMQLVg+tB0wHPsjvEc4SFJq+
         TRt+XhrwrIzHfpV+5378/LgAyM3mHg4gC+NmCrFMee4ux1ABDcMQ7tEwPm4y0EgvKf
         XyZjL3Yy0uCe51Cf3h3cQ3VncjEA4eWdJYp4WH3M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 132/304] driver core: Move async_synchronize_full call
Date:   Mon, 28 Jan 2019 10:40:49 -0500
Message-Id: <20190128154341.47195-132-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

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
index dbba123e058d..9d6604b50d75 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -928,9 +928,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 	drv = dev->driver;
 	if (drv) {
-		if (driver_allows_async_probing(drv))
-			async_synchronize_full();
-
 		while (device_links_busy(dev)) {
 			device_unlock(dev);
 			if (parent && dev->bus->need_parent_lock)
@@ -1036,6 +1033,9 @@ void driver_detach(struct device_driver *drv)
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

