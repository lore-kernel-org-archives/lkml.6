Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165109AbeE1NBH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163591AbeE1Kxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 246/496] workqueue: use put_device() instead of kfree()
Date: Mon, 28 May 2018 12:00:31 +0200
Message-Id: <20180528100330.261720481@linuxfoundation.org>
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

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

[ Upstream commit 537f4146c53c95aac977852b371bafb9c6755ee1 ]

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized in this function instead.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/workqueue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5350,7 +5350,7 @@ int workqueue_sysfs_register(struct work
 
 	ret = device_register(&wq_dev->dev);
 	if (ret) {
-		kfree(wq_dev);
+		put_device(&wq_dev->dev);
 		wq->wq_dev = NULL;
 		return ret;
 	}
