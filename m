Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423845AbeE1Lx0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423208AbeE1LJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 085/272] platform/x86: dell-smbios: Fix memory leaks in build_tokens_sysfs()
Date: Mon, 28 May 2018 12:01:58 +0200
Message-Id: <20180528100248.273075692@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 0e5b09b165510e2ea5c526e962c4edadd849ef4c ]

We're freeing "value_name" which is NULL, so that's a no-op, but we
intended to free "location_name" instead.  And then we don't free the
names in token_location_attrs[0] and token_value_attrs[0].

Fixes: 33b9ca1e53b4 ("platform/x86: dell-smbios: Add a sysfs interface for SMBIOS tokens")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell-smbios-base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -514,7 +514,7 @@ static int build_tokens_sysfs(struct pla
 		continue;
 
 loop_fail_create_value:
-		kfree(value_name);
+		kfree(location_name);
 		goto out_unwind_strings;
 	}
 	smbios_attribute_group.attrs = token_attrs;
@@ -525,7 +525,7 @@ loop_fail_create_value:
 	return 0;
 
 out_unwind_strings:
-	for (i = i-1; i > 0; i--) {
+	while (i--) {
 		kfree(token_location_attrs[i].attr.name);
 		kfree(token_value_attrs[i].attr.name);
 	}
