Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BFEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD9820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD9820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405565AbeHATIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405022AbeHATIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:06 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CBE6ACE6;
        Wed,  1 Aug 2018 17:21:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 153/246] media: media-device: fix ioctl function types
Date:   Wed,  1 Aug 2018 18:51:03 +0200
Message-Id: <20180801165019.056165850@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit daa36370b62428cca6d48d1b2530a8419f631c8c ]

This change fixes function types for media device ioctls to avoid
indirect call mismatches with Control-Flow Integrity checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/media-device.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/drivers/media/media-device.c
+++ b/drivers/media/media-device.c
@@ -54,9 +54,10 @@ static int media_device_close(struct fil
 	return 0;
 }
 
-static int media_device_get_info(struct media_device *dev,
-				 struct media_device_info *info)
+static long media_device_get_info(struct media_device *dev, void *arg)
 {
+	struct media_device_info *info = arg;
+
 	memset(info, 0, sizeof(*info));
 
 	if (dev->driver_name[0])
@@ -93,9 +94,9 @@ static struct media_entity *find_entity(
 	return NULL;
 }
 
-static long media_device_enum_entities(struct media_device *mdev,
-				       struct media_entity_desc *entd)
+static long media_device_enum_entities(struct media_device *mdev, void *arg)
 {
+	struct media_entity_desc *entd = arg;
 	struct media_entity *ent;
 
 	ent = find_entity(mdev, entd->id);
@@ -146,9 +147,9 @@ static void media_device_kpad_to_upad(co
 	upad->flags = kpad->flags;
 }
 
-static long media_device_enum_links(struct media_device *mdev,
-				    struct media_links_enum *links)
+static long media_device_enum_links(struct media_device *mdev, void *arg)
 {
+	struct media_links_enum *links = arg;
 	struct media_entity *entity;
 
 	entity = find_entity(mdev, links->entity);
@@ -194,9 +195,9 @@ static long media_device_enum_links(stru
 	return 0;
 }
 
-static long media_device_setup_link(struct media_device *mdev,
-				    struct media_link_desc *linkd)
+static long media_device_setup_link(struct media_device *mdev, void *arg)
 {
+	struct media_link_desc *linkd = arg;
 	struct media_link *link = NULL;
 	struct media_entity *source;
 	struct media_entity *sink;
@@ -222,9 +223,9 @@ static long media_device_setup_link(stru
 	return __media_entity_setup_link(link, linkd->flags);
 }
 
-static long media_device_get_topology(struct media_device *mdev,
-				      struct media_v2_topology *topo)
+static long media_device_get_topology(struct media_device *mdev, void *arg)
 {
+	struct media_v2_topology *topo = arg;
 	struct media_entity *entity;
 	struct media_interface *intf;
 	struct media_pad *pad;


