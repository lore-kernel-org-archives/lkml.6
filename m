Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165186AbeE1NJa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163858AbeE1Kvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 233/496] xen: xenbus: use put_device() instead of kfree()
Date: Mon, 28 May 2018 12:00:18 +0200
Message-Id: <20180528100329.728685252@linuxfoundation.org>
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

[ Upstream commit 351b2bccede1cb673ec7957b35ea997ea24c8884 ]

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/xenbus/xenbus_probe.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -466,8 +466,11 @@ int xenbus_probe_node(struct xen_bus_typ
 
 	/* Register with generic device framework. */
 	err = device_register(&xendev->dev);
-	if (err)
+	if (err) {
+		put_device(&xendev->dev);
+		xendev = NULL;
 		goto fail;
+	}
 
 	return 0;
 fail:
