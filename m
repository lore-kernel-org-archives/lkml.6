Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A22C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904862146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543884;
	bh=LxNGzLvHrLHnHUP7vXGqjyYA4CqtX2QP9zRblCOsAv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rsiaMMFo0hRXC/oZSCfnJiWmdsdJ4oNNUd1KtGjbgRah2jq1rBseaN+GJmDodzM0S
	 qgDUBSFjOee9eWbjHnXJMCYR406orHEmoWQSwxpBtKeFYSVkKjYAwofult7HpJRczS
	 JVG6wz5tm+xAxVOcj5TQQloIVYmJx3+lpjxATHss=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904862146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbeLKP6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730924AbeLKP55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF6920855;
        Tue, 11 Dec 2018 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543876;
        bh=LxNGzLvHrLHnHUP7vXGqjyYA4CqtX2QP9zRblCOsAv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKJEaEeoTqwHR/i/CJLK/xVyCDBbfA1fZj7romD0zc/qpSPBQY1yBFI7yvyUXoyMr
         795/4laaP5grxAjB0GfODgmfPdsD9RWvt42OyTTEDzcWO1DSIcR1eD6PTr2SVSUjLj
         PfmK4O2EkZUa0aLirrts44q/EoAdvUt1PGHf/Nxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Packard <keithp@keithp.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 4.19 098/118] drm/lease: Send a distinct uevent
Date:   Tue, 11 Dec 2018 16:41:57 +0100
Message-Id: <20181211151648.232890582@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

From: Daniel Vetter <daniel.vetter@ffwll.ch>

commit ce85882860f0e756f7066cbda1c43e8b50b73ab6 upstream.

Sending the exact same hotplug event is not great uapi. Luckily the
only already merged implementation of leases (in the -modesetting
driver) doesn't care about what kind of uevent it gets, and
unconditionally processes both hotplug and lease changes. So we can
still adjust the uapi here.

But e.g. weston tries to filter stuff, and I guess others might want
to do that too. Try to make that possible. Cc: stable since it's uapi
adjustement that we want to roll out everywhere.

Michel Dänzer mentioned on irc that -amdgpu also has lease support. It
has the same code flow as -modesetting though, so we can still go
ahead.

v2: Mention -amdgpu (Michel)

Cc: Keith Packard <keithp@keithp.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Keith Packard <keithp@keithp.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181129094226.30591-1-daniel.vetter@ffwll.ch
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_internal.h |    2 ++
 drivers/gpu/drm/drm_lease.c    |    2 +-
 drivers/gpu/drm/drm_sysfs.c    |   10 ++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -99,6 +99,8 @@ struct device *drm_sysfs_minor_alloc(str
 int drm_sysfs_connector_add(struct drm_connector *connector);
 void drm_sysfs_connector_remove(struct drm_connector *connector);
 
+void drm_sysfs_lease_event(struct drm_device *dev);
+
 /* drm_gem.c */
 int drm_gem_init(struct drm_device *dev);
 void drm_gem_destroy(struct drm_device *dev);
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -296,7 +296,7 @@ void drm_lease_destroy(struct drm_master
 
 	if (master->lessor) {
 		/* Tell the master to check the lessee list */
-		drm_sysfs_hotplug_event(dev);
+		drm_sysfs_lease_event(dev);
 		drm_master_put(&master->lessor);
 	}
 
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -301,6 +301,16 @@ void drm_sysfs_connector_remove(struct d
 	connector->kdev = NULL;
 }
 
+void drm_sysfs_lease_event(struct drm_device *dev)
+{
+	char *event_string = "LEASE=1";
+	char *envp[] = { event_string, NULL };
+
+	DRM_DEBUG("generating lease event\n");
+
+	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
+}
+
 /**
  * drm_sysfs_hotplug_event - generate a DRM uevent
  * @dev: DRM device


