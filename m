Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F23C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8412063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218146;
	bh=N1pqzf6zQqE4r/i16yUFXRQtOMPn1guGjMfgb/dpCc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e40GMGlz8AxgpR95pJyDl4sUKxV7BWxisY4ZkDgljYiCFZY73kGEmNPGpv5YfHEn3
	 2l8ribzxwyvnfspB0DYw+oG4A8zYJo+TYTv29qo3ymF+YfOfiNrKteS8w5tPt45FtD
	 XRz0ZtTumUOXw9UJJK23LZWi1Y2qykYwsQgp6TWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391551AbfAKOtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:49:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390588AbfAKOlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ADD921841;
        Fri, 11 Jan 2019 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217674;
        bh=N1pqzf6zQqE4r/i16yUFXRQtOMPn1guGjMfgb/dpCc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdrjH1zvpjQ0d4+T5pbbFBW4+dh5RmAdXnHIAkQ25KkdETpEtjZCxkfV0i4Dkh5LS
         Riyyb61jt1524YF5RoqrbJ6cmEFGajUqsfGfINo/Bjj6pcxuJpAv92tA6b0wMVwhax
         xuS6CjJhpdSczAL23h5cn7c1/pqrYa2izRtKNqmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.19 110/148] driver core: Add missing dev->bus->need_parent_lock checks
Date:   Fri, 11 Jan 2019 15:14:48 +0100
Message-Id: <20190111131118.612965834@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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
@@ -931,11 +931,11 @@ static void __device_release_driver(stru
 
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


