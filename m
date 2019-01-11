Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D97FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7BF206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217747;
	bh=n7m+zbV/5GvMDNSUgXpWBdaOGeZPgOorBTj00tL0cgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sL189wBrctw9D/GpDG2j7S8BdUw2T6onGKp45OwMnehzUE502pEVy6p4ovHcQIaiE
	 wJG0KKzivEkeFse9Ayf3RozM+QcSTD7OgwX7IPdItYfhisv0FOQfpADirtklXCXavu
	 2x55bfJ/ZGlwQDy3YgW+A8zaqMO/s3h3kd/CXXbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbfAKOm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404139AbfAKOmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 683C92063F;
        Fri, 11 Jan 2019 14:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217742;
        bh=n7m+zbV/5GvMDNSUgXpWBdaOGeZPgOorBTj00tL0cgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Atf9nvSL4FzTqiYTBBdj9S5Ti9T/MZyCBF/x60IABZhwBT8ZoV24F92ECYu/YbqA/
         yPOgtApBl5BbNzW2rlrxOK2HEweWoK8UCu+pNOiqhdPEJ2fycgOMrNFjS8+V4p6iUd
         BTtPCZExj5vABTAO08Z/YaJXK1CQWmqzIZbPFY2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.20 24/65] driver core: Add missing dev->bus->need_parent_lock checks
Date:   Fri, 11 Jan 2019 15:15:10 +0100
Message-Id: <20190111131059.716457548@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit e121a833745b4708b660e3fe6776129c2956b041 upstream.

__device_release_driver() has to check dev->bus->need_parent_lock
before dropping the parent lock and acquiring it again as it may
attempt to drop a lock that hasn't been acquired or lock a device
that shouldn't be locked and create a lock imbalance.

Fixes: 8c97a46af04b (driver core: hold dev's parent lock when needed)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/dd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -933,11 +933,11 @@ static void __device_release_driver(stru
 
 		while (device_links_busy(dev)) {
 			device_unlock(dev);
-			if (parent)
+			if (parent && dev->bus->need_parent_lock)
 				device_unlock(parent);
 
 			device_links_unbind_consumers(dev);
-			if (parent)
+			if (parent && dev->bus->need_parent_lock)
 				device_lock(parent);
 
 			device_lock(dev);


