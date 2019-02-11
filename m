Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABA3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F1E21B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898989;
	bh=pYU6QX0ofs/59rjzJqR5NjdiQt0xkzBj48gNMVhgClI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K1aXpG0gTW5pa97uFcN2mOUUixQb8gWHIipGHXt5LRNVf/1hUHN+9F8rRRwSwBwmU
	 771NbgSkMzXKzHfvuB1agqlr4bTNG35ElOpDaXGA3h+RYhAQCVc7DydngV1mR4qeJi
	 fnaInBamx1NdVoHogf0kqMdP5JSwPLjjFMaq8xuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389314AbfBKO5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389286AbfBKO5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:57:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC383222AB;
        Mon, 11 Feb 2019 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897029;
        bh=pYU6QX0ofs/59rjzJqR5NjdiQt0xkzBj48gNMVhgClI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zUigxIojYmyVK3MhAR7slmMpfbGhuJ0fTU/4yp6ZNkMqYDw6QzVWvFp6SRP9OKXKW
         Iy4ixnd/sbXLq19futkOMjYv/RkC0NpGjJhQV4n2XMG5HIfVWjOcTk8Q0X8MVqlqhA
         1LY75UBSHo1ffwUZT5zdKMbJKk1ccgBo3l/UPbN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rajnoha <prajnoha@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 068/205] kobject: return error code if writing /sys/.../uevent fails
Date:   Mon, 11 Feb 2019 15:17:46 +0100
Message-Id: <20190211141833.203271900@linuxfoundation.org>
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
index 1cf1460f8c90..3464c49dad0d 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -616,8 +616,10 @@ static void remove_probe_files(struct bus_type *bus)
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
 
@@ -833,8 +835,10 @@ static void klist_devices_put(struct klist_node *n)
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
index fc5bbb2519fe..1c67bf24bc23 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -991,8 +991,14 @@ out:
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
index 2a44c515f0d7..94528b891027 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1201,8 +1201,10 @@ static ssize_t store_uevent(struct module_attribute *mattr,
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



