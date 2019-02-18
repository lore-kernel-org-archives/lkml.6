Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAB9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5602173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jcvdRXBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbfBRQg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:36:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35815 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389770AbfBRQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:36:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so5363934edp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jb7xRsjvZ9Wi6wUmflywBCpxpmZ2rI3iyrcwl2Wo6/g=;
        b=jcvdRXBiHJlRaVNLOpdg85jL/N1yQs4tdH/tMpbH6tjSLY2A4MaxbLaMDbOse9ah9Q
         26RxKv4eRUm73mMkoYetasSgN6aTbn4hCqyMxlDNj0vRCkFYV2bRWEOG1nXCY/XWugJz
         ZkvxS3WKhOxmtNK7wA4FYFogLmH20e/kzQV7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jb7xRsjvZ9Wi6wUmflywBCpxpmZ2rI3iyrcwl2Wo6/g=;
        b=JtTPk3BzadSMIXUmt9+wrV3rN6GljF6DDGhqBsBl+fPayW448BXGKemwm8QYategn5
         D/vax/OKQh7+b23lbhFrtvXkQSNYS97M2vUtt6kKDiMn5FZskXb72+vEphP8FvB3P/ua
         838oDvVaedvo8dF7bIGPW9CK1Ror3Ql+I6HyHesVfeBVs0IQOxdvXq+KKSbsYuN7lwhg
         9rd6AfiyMfGtvx49/oZ+YR4kdOI019x44T2iY0pAalf6SrC2Kbz8EuG3ezhULFwXZv5b
         HVDTs6zXSoPMkXf3nrtDg6nI5Q5GSOr/ChTuI0wNxWAXvxEbDiY1AXvSOuHGg0hWFbFY
         tGOw==
X-Gm-Message-State: AHQUAuaUNTPwnC7cFVuBa3M+oOyrfEdIBQsDSSY/AMUTBf9OSKxChXPi
        8QqPasawzC7myJdFcT8jl/UcKJO49jg5dw==
X-Google-Smtp-Source: AHgI3IaGQcQnbT4YMp06E23p6vRhNHusbawSMQNi8yr/dfuBRzBMHe0LdZYEpHE2TKUCMBlaf/8trg==
X-Received: by 2002:a17:906:d1c4:: with SMTP id bs4mr17162809ejb.205.1550507815630;
        Mon, 18 Feb 2019 08:36:55 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id o37sm4226476edc.32.2019.02.18.08.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:36:54 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>
Subject: [PATCH] drivers/component: kerneldoc polish
Date:   Mon, 18 Feb 2019 17:36:48 +0100
Message-Id: <20190218163648.28987-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218085242.18845-1-daniel.vetter@ffwll.ch>
References: <20190218085242.18845-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Polish the kerneldoc a bit with suggestions from Randy.

v2: Randy found another typo: s/compent/component/

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Ramalingam C <ramalingam.c@intel.com>
---
 drivers/base/component.c  | 14 +++++++-------
 include/linux/component.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 7dbc41cccd58..532a3a5d8f63 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -27,7 +27,7 @@
  * helper fills the niche of aggregate drivers for specific hardware, where
  * further standardization into a subsystem would not be practical. The common
  * example is when a logical device (e.g. a DRM display driver) is spread around
- * the SoC on various component (scanout engines, blending blocks, transcoders
+ * the SoC on various components (scanout engines, blending blocks, transcoders
  * for various outputs and so on).
  *
  * The component helper also doesn't solve runtime dependencies, e.g. for system
@@ -378,7 +378,7 @@ static void __component_match_add(struct device *master,
 }
 
 /**
- * component_match_add_release - add a component match with release callback
+ * component_match_add_release - add a component match entry with release callback
  * @master: device with the aggregate driver
  * @matchptr: pointer to the list of component matches
  * @release: release function for @compare_data
@@ -408,7 +408,7 @@ void component_match_add_release(struct device *master,
 EXPORT_SYMBOL(component_match_add_release);
 
 /**
- * component_match_add_typed - add a compent match for a typed component
+ * component_match_add_typed - add a component match entry for a typed component
  * @master: device with the aggregate driver
  * @matchptr: pointer to the list of component matches
  * @compare_typed: compare function to match against all typed components
@@ -537,11 +537,11 @@ static void component_unbind(struct component *component,
 }
 
 /**
- * component_unbind_all - unbind all component to an aggregate driver
+ * component_unbind_all - unbind all components of an aggregate driver
  * @master_dev: device with the aggregate driver
  * @data: opaque pointer, passed to all components
  *
- * Unbinds all components to the aggregate @dev by passing @data to their
+ * Unbinds all components of the aggregate @dev by passing @data to their
  * &component_ops.unbind functions. Should be called from
  * &component_master_ops.unbind.
  */
@@ -619,11 +619,11 @@ static int component_bind(struct component *component, struct master *master,
 }
 
 /**
- * component_bind_all - bind all component to an aggregate driver
+ * component_bind_all - bind all components of an aggregate driver
  * @master_dev: device with the aggregate driver
  * @data: opaque pointer, passed to all components
  *
- * Binds all components to the aggregate @dev by passing @data to their
+ * Binds all components of the aggregate @dev by passing @data to their
  * &component_ops.bind functions. Should be called from
  * &component_master_ops.bind.
  */
diff --git a/include/linux/component.h b/include/linux/component.h
index 30bcc7e590eb..16de18f473d7 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -98,7 +98,7 @@ void component_match_add_typed(struct device *master,
 	int (*compare_typed)(struct device *, int, void *), void *compare_data);
 
 /**
- * component_match_add - add a compent match
+ * component_match_add - add a component match entry
  * @master: device with the aggregate driver
  * @matchptr: pointer to the list of component matches
  * @compare: compare function to match against all components
-- 
2.20.1

