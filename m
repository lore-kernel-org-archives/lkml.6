Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88D1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A741E21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899945;
	bh=wKJeks3UkVwa0d5FmxZnMZCWQk09mkDdXZQ5Xp1UVD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DLcnom6tOz4qsygHwJAt5MXM8pwsQO/TCdHvlZH0npvNlaicmqxxHFMm3AK70eYFj
	 hMiKTtOHfOj5Eq4IAoqBSkIjUAMSoxhUiV2bS79CLyncXxZzexki830b5bHk6KBTRJ
	 VASy51TWiku3QuSpHomN81W+FZy2Sthvyn0YOQnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfBKPpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732590AbfBKOnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:43:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2F820700;
        Mon, 11 Feb 2019 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896196;
        bh=wKJeks3UkVwa0d5FmxZnMZCWQk09mkDdXZQ5Xp1UVD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Or5sSW0AggXMPn0VFtMsW0FUpoB3sb3VLKv4KD7dLux0JnPQyi7XWGdWo28edgxB6
         Yw89p/sAmAKksmFC/kWJP1n4iLWkPyixvNa0A2Wangpu3IIJZL8vCNHIwtntZR0flR
         I3hL0F6FOdBJ9Cv/k3Jn2IL2l0orhKA43jmNqBJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rajnoha <prajnoha@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 105/313] kobject: return error code if writing /sys/.../uevent fails
Date:   Mon, 11 Feb 2019 15:16:25 +0100
Message-Id: <20190211141900.869718928@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1067,8 +1067,14 @@ out:
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



