Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161448AbeE1KcE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161359AbeE1KcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:32:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 130/329] s390/cio: clear timer when terminating driver I/O
Date: Mon, 28 May 2018 12:00:59 +0200
Message-Id: <20180528100253.514344215@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

[ Upstream commit 410d5e13e7638bc146321671e223d56495fbf3c7 ]

When we terminate driver I/O (because we need to stop using a certain
channel path) we also need to ensure that a timer (which may have been
set up using ccw_device_start_timeout) is cleared.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/cio/device_fsm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -923,6 +923,7 @@ void ccw_device_kill_io(struct ccw_devic
 {
 	int ret;
 
+	ccw_device_set_timeout(cdev, 0);
 	cdev->private->iretry = 255;
 	cdev->private->async_kill_io_rc = -EIO;
 	ret = ccw_device_cancel_halt_clear(cdev);
