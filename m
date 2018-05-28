Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423657AbeE1LIp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423615AbeE1LIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 103/272] iommu/amd: Take into account that alloc_dev_data() may return NULL
Date: Mon, 28 May 2018 12:02:16 +0200
Message-Id: <20180528100249.761915437@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 39ffe39545cd5cb5b8cee9f0469165cf24dc62c2 ]

find_dev_data() does not check whether the return value alloc_dev_data()
is NULL. This was okay once because the pointer was returned once as-is.
Since commit df3f7a6e8e85 ("iommu/amd: Use is_attach_deferred
call-back") the pointer may be used within find_dev_data() so a NULL
check is required.

Cc: Baoquan He <bhe@redhat.com>
Fixes: df3f7a6e8e85 ("iommu/amd: Use is_attach_deferred call-back")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/amd_iommu.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -310,6 +310,8 @@ static struct iommu_dev_data *find_dev_d
 
 	if (dev_data == NULL) {
 		dev_data = alloc_dev_data(devid);
+		if (!dev_data)
+			return NULL;
 
 		if (translation_pre_enabled(iommu))
 			dev_data->defer_attach = true;
