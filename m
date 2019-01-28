Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E23C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA89321738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691495;
	bh=QC6pCkMHdSBJyWG+XHJCYH2xeRVFQKj8Ivy+sqeDsq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U8/dRXc9SQOSVPYXGYO/H0HQXO8B2lzf737o0hgSItNdvdalF26hhY7dLq8ZRus2i
	 ayS1AOakL3PdLCKMHZp7OSYY/Wh8Gb6tkgrf6dZAp6myoy9NLYeut0T/4mIWcLCQiK
	 D7bqQbd7svpKmS6VLrkZ8kLCCl7szr1ahsIoWoB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfA1QEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731223AbfA1QEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:04:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91A920989;
        Mon, 28 Jan 2019 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691489;
        bh=QC6pCkMHdSBJyWG+XHJCYH2xeRVFQKj8Ivy+sqeDsq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDu7Tak8kM7XT37F4XveQHxalwrbn15C5xL1k+olZ6yTW/2jwi+BdanI+NVC7a/cr
         +F9aBRWRt+sksbhmN/4OtsM6Q88Dc9yK9ts3KmGqhSyv8PmjTuZC9s+eaRqjkEXE/Z
         RBYMVjbtTOit6DrA1Jba4AN6ldIrZ7D06F+SKkb0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Rajnoha <prajnoha@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 112/258] kobject: return error code if writing /sys/.../uevent fails
Date:   Mon, 28 Jan 2019 10:56:58 -0500
Message-Id: <20190128155924.51521-112-sashal@kernel.org>
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

From: Peter Rajnoha <prajnoha@redhat.com>

[ Upstream commit df44b479654f62b478c18ee4d8bc4e9f897a9844 ]

Propagate error code back to userspace if writing the /sys/.../uevent
file fails. Before, the write operation always returned with success,
even if we failed to recognize the input string or if we failed to
generate the uevent itself.

With the error codes properly propagated back to userspace, we are
able to react in userspace accordingly by not assuming and awaiting
a uevent that is not delivered.

Signed-off-by: Peter Rajnoha <prajnoha@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/bus.c  | 12 ++++++++----
 drivers/base/core.c |  8 +++++++-
 kernel/module.c     |  6 ++++--
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 585e2e1c9c8f..e06a57936cc9 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -614,8 +614,10 @@ static void remove_probe_files(struct bus_type *bus)
 static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 			    size_t count)
 {
-	kobject_synth_uevent(&drv->p->kobj, buf, count);
-	return count;
+	int rc;
+
+	rc = kobject_synth_uevent(&drv->p->kobj, buf, count);
+	return rc ? rc : count;
 }
 static DRIVER_ATTR_WO(uevent);
 
@@ -831,8 +833,10 @@ static void klist_devices_put(struct klist_node *n)
 static ssize_t bus_uevent_store(struct bus_type *bus,
 				const char *buf, size_t count)
 {
-	kobject_synth_uevent(&bus->p->subsys.kobj, buf, count);
-	return count;
+	int rc;
+
+	rc = kobject_synth_uevent(&bus->p->subsys.kobj, buf, count);
+	return rc ? rc : count;
 }
 static BUS_ATTR(uevent, S_IWUSR, NULL, bus_uevent_store);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..92e2c32c2227 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1067,8 +1067,14 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	if (kobject_synth_uevent(&dev->kobj, buf, count))
+	int rc;
+
+	rc = kobject_synth_uevent(&dev->kobj, buf, count);
+
+	if (rc) {
 		dev_err(dev, "uevent: failed to send synthetic uevent\n");
+		return rc;
+	}
 
 	return count;
 }
diff --git a/kernel/module.c b/kernel/module.c
index 6746c85511fe..38bf28b5cc20 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1207,8 +1207,10 @@ static ssize_t store_uevent(struct module_attribute *mattr,
 			    struct module_kobject *mk,
 			    const char *buffer, size_t count)
 {
-	kobject_synth_uevent(&mk->kobj, buffer, count);
-	return count;
+	int rc;
+
+	rc = kobject_synth_uevent(&mk->kobj, buffer, count);
+	return rc ? rc : count;
 }
 
 struct module_attribute module_uevent =
-- 
2.19.1

