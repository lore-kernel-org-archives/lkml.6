Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034259AbeE1KrO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163203AbeE1KrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:47:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 106/496] RDMA/bnxt_re: Fix system crash during load/unload
Date: Mon, 28 May 2018 11:58:11 +0200
Message-Id: <20180528100324.356460166@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit dcdaba08062b4726500b9456f8664bfda896c664 ]

During driver unload, the driver proceeds with cleanup
without waiting for the scheduled events. So the device
pointers get freed up and driver crashes when the events
are scheduled later.

Flush the bnxt_re_task work queue before starting
device removal.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/main.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1398,6 +1398,11 @@ static void __exit bnxt_re_mod_exit(void
 
 	list_for_each_entry(rdev, &to_be_deleted, list) {
 		dev_info(rdev_to_dev(rdev), "Unregistering Device");
+		/*
+		 * Flush out any scheduled tasks before destroying the
+		 * resources
+		 */
+		flush_workqueue(bnxt_re_wq);
 		bnxt_re_dev_stop(rdev);
 		bnxt_re_ib_unreg(rdev, true);
 		bnxt_re_remove_one(rdev);
