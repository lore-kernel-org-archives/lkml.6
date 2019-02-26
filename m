Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9E6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBE321848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551192090;
	bh=zFUtrXexko0nfeOzAlaTW7zTvpAAtA4MXYAonnlDPNY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=F3BzJ4a2YdDURmkipnqwsdr432+PpRpOofYj6UQdLcST3kUs6cinsml2ZVeW6oNjl
	 Un1mtQGrgyHEVlpB25MqDoE7D/nZf+hmd1/SoZKq1Kg1Pw1VC/R8OKBCykZ/woWvWl
	 IDNGwwmOhwLbncnzLhVIPRI63lpiKmhA8B4/umRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfBZOl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfBZOl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:41:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D132C2173C;
        Tue, 26 Feb 2019 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551192088;
        bh=zFUtrXexko0nfeOzAlaTW7zTvpAAtA4MXYAonnlDPNY=;
        h=From:To:Cc:Subject:Date:From;
        b=kJRJ1W3hNF7SWOEn3MpiCllEA9UvpMC1lD/7Jbm8mHuKrno67/325voEAYOPgtfNe
         IsxiDWz4RTR/STo/u91J2eJ/EyIJQjZJQ8h+WgSYPQfOe9HkHSn85Tfr3kaGsnXZTQ
         zI7uCi4G8Ep3JrJVEtr2OW0ToZLYG9GjEkmJREmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/2] device.h: pack struct dev_links_info
Date:   Tue, 26 Feb 2019 15:41:07 +0100
Message-Id: <20190226144108.25891-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_links_info structure has 4 bytes of padding at the end of it
when embedded in struct device (which is the only place it lives).  To
help reduce the size of struct device pack this structure so we can take
advantage of the hole with later structure reorganizations.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..b63165276a09 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -884,7 +884,7 @@ struct dev_links_info {
 	struct list_head suppliers;
 	struct list_head consumers;
 	enum dl_dev_state status;
-};
+} __packed;
 
 /**
  * struct device - The basic device structure
-- 
2.21.0

