Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52507C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2456020989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691491;
	bh=zZimf+VoLvqfH4G0DQU5ZzF5LxZa94Ry+vS+/eljLOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dWJLF0pfb06r4OTvVx3f0BUC5TZsn/X4yqbvhHB574TPKSPHE50UU6/PbPn9D1rAV
	 tALXf4ZZwNdGxAiATWGL3oG1DXn7e04XcihtCMsIJVj63BjY4ZE4FRupxkw/RyJgwM
	 kBQMOL75cgiuX6xU3JgATCkLTI9O2CtDOlap30Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfA1QEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:04:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbfA1QEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:04:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EDB92147A;
        Mon, 28 Jan 2019 16:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691487;
        bh=zZimf+VoLvqfH4G0DQU5ZzF5LxZa94Ry+vS+/eljLOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zW4D/Zvn9ajUqOKN1m3Gn8avaTsHnRhkTb0XebWfeE9C3oVCwu29A77y6Ebjba6s0
         31tqH9UOBrMYEDAzSF435JazE7DhDUtVGDEk5WQdkteWgDeSnaC+Uzg8R+/yXYIQ2M
         WTKgcAPaaIEuyf5iH1WvU0svYbDW4zy7Dym27tg0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 111/258] driver core: Move async_synchronize_full call
Date:   Mon, 28 Jan 2019 10:56:57 -0500
Message-Id: <20190128155924.51521-111-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index 2607f859881a..7caa1adaf62a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -926,9 +926,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 	drv = dev->driver;
 	if (drv) {
-		if (driver_allows_async_probing(drv))
-			async_synchronize_full();
-
 		while (device_links_busy(dev)) {
 			device_unlock(dev);
 			if (parent && dev->bus->need_parent_lock)
@@ -1034,6 +1031,9 @@ void driver_detach(struct device_driver *drv)
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

