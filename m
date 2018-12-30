Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4559CC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ECD20861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0hJtU1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeL3RtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47054 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeL3RtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so22341750ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=QROh7OCQrXt9g019C2ypOS2+SuZs8Qynl+T7q8Jh3vk=;
        b=k0hJtU1ppOLceGH1yK//pcF9NRBxTvmTKQmWeibNSRhN6Q9g1ogTwExJ3YtCjfKLzG
         0NtviqIUKbI6ILvfHdRyXcAoOPN1hLNPUbvK6WN+IvwzwdHearLQCpUXIvl9KqdzWzEE
         segZwElOw8pVw7ibeJOhQKFnbtgMLpl2StAO5Jsq5o0NCzjVcxVMbyTs7HscBbN07dES
         7CdntI7OJHeOO0ZICaUb/pSpvKgr9Cq8NY5rDB7KcP+IPjMUO2iu4sZKA26jZHi+KFSu
         0sDhLu+4GFYK6Pi+FAegLMa8nDSZJSp+x0bQsv2gNQK/8+UHdwLBe4IjQ4XcOPNbn6rr
         WeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=QROh7OCQrXt9g019C2ypOS2+SuZs8Qynl+T7q8Jh3vk=;
        b=uVtptTkIGA9yujNUjwp7+rCy0HxIRiSC7JPpN2sEexjRIFTvNoKpf/T0sTWzbKnSMW
         ZumMYyQwKrkm0i1e2sZhDKzHgmP3Xx2gYjpTS1h5D3wqXbNT+fnJIp8vNJrOt61k0z+Y
         HwKp0LMSK6PlV27jb4/ouSrP4N1r5uFb4bL4c1+Adf5/q7JWCEaGVsmUAHc0LKQwQVUh
         NQMyrZIJ+l1IL6xGfqDESHYM0fnJfhKHwWK67YI4T9T5vykmxTdcTO5l4PjbvLih5Fby
         XLAqobypoj0PG7hSM62zIsmFmVzEr2Is6XEZMAp6BdIUS4RYzXtd2iDOueqdGdgTiD1t
         uUrA==
X-Gm-Message-State: AJcUukdKtieVkFR6CVMf9eeGh3LiXaygJzlfexenTSpiICAf4Lwkosh2
        Ul2K+LkTv/TepBqhTqgJFzk=
X-Google-Smtp-Source: ALg8bN75Aa9e0PW3JcyoSbXhHo1k8p3tHxWifvj5/DjvRcHNrwxobb9XdvcG1OsPwZ72ewgUxg3fSA==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26-v6mr22263487lju.8.1546192138969;
        Sun, 30 Dec 2018 09:48:58 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:48:58 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 02/14] drm: drm_device.h: update comments to kernel-doc style
Date:   Sun, 30 Dec 2018 18:48:26 +0100
Message-Id: <20181230174838.32330-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated comment style to kernel-doc format in drm_device.h

In struct drm_device there are 12 struct members without doc:
- registered
- filelist_mutex
- filelist
- irq
- vbl_lock
- event_lock
- hose
- sigdata
- sigdata.context
- sigdata.lock
- agp_buffer_map
- agp_buffer_token

They all need proper documentation, a task left for someone
that knows their usage.

drm_device is not plugged into Documentation/gpu/drm-internals.rst
as this would create a new load of warnings.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 include/drm/drm_device.h | 199 +++++++++++++++++++++++++++++++----------------
 1 file changed, 134 insertions(+), 65 deletions(-)

diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 42411b3ea0c8..2b154ead9efc 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -25,24 +25,48 @@ struct pci_dev;
 struct pci_controller;
 
 /**
- * DRM device structure. This structure represent a complete card that
+ * struct drm_device - DRM device structure
+ *
+ * This structure represent a complete card that
  * may contain multiple heads.
  */
 struct drm_device {
-	struct list_head legacy_dev_list;/**< list of devices per driver for stealth attach cleanup */
-	int if_version;			/**< Highest interface version set */
-
-	/** \name Lifetime Management */
-	/*@{ */
-	struct kref ref;		/**< Object ref-count */
-	struct device *dev;		/**< Device structure of bus-device */
-	struct drm_driver *driver;	/**< DRM driver managing the device */
-	void *dev_private;		/**< DRM driver private data */
-	struct drm_minor *primary;		/**< Primary node */
-	struct drm_minor *render;		/**< Render node */
+	/**
+	 * @legacy_dev_list:
+	 *
+	 * List of devices per driver for stealth attach cleanup
+	 */
+	struct list_head legacy_dev_list;
+
+	/** @if_version: Highest interface version set */
+	int if_version;
+
+	/** @ref: Object ref-count */
+	struct kref ref;
+
+	/** @dev: Device structure of bus-device */
+	struct device *dev;
+
+	/** @driver: DRM driver managing the device */
+	struct drm_driver *driver;
+
+	/** @dev_private: DRM driver private data */
+	void *dev_private;
+
+	/** @primary: Primary node */
+	struct drm_minor *primary;
+
+	/** @render: Render node */
+	struct drm_minor *render;
+
 	bool registered;
 
-	/* currently active master for this device. Protected by master_mutex */
+	/**
+	 * @master:
+	 *
+	 * Currently active master for this device.
+	 * Protected by &master_mutex
+	 */
 	struct drm_master *master;
 
 	/**
@@ -63,23 +87,42 @@ struct drm_device {
 	 */
 	bool unplugged;
 
-	struct inode *anon_inode;		/**< inode for private address-space */
-	char *unique;				/**< unique name of the device */
-	/*@} */
+	/** @anon_inode: inode for private address-space */
+	struct inode *anon_inode;
+
+	/** @unique: Unique name of the device */
+	char *unique;
+
+	/**
+	 * @struct_mutex:
+	 *
+	 * Lock for others (not &drm_minor.master and &drm_file.is_master)
+	 */
+	struct mutex struct_mutex;
+
+	/**
+	 * @master_mutex:
+	 *
+	 * Lock for &drm_minor.master and &drm_file.is_master
+	 */
+	struct mutex master_mutex;
+
+	/**
+	 * @open_count:
+	 *
+	 * Usage counter for outstanding files open,
+	 * protected by drm_global_mutex
+	 */
+	int open_count;
+
+	/** @buf_lock: Lock for &buf_use and a few other things. */
+	spinlock_t buf_lock;
 
-	/** \name Locks */
-	/*@{ */
-	struct mutex struct_mutex;	/**< For others */
-	struct mutex master_mutex;      /**< For drm_minor::master and drm_file::is_master */
-	/*@} */
+	/** @buf_use: Usage counter for buffers in use -- cannot alloc */
+	int buf_use;
 
-	/** \name Usage Counters */
-	/*@{ */
-	int open_count;			/**< Outstanding files open, protected by drm_global_mutex. */
-	spinlock_t buf_lock;		/**< For drm_device::buf_use and a few other things. */
-	int buf_use;			/**< Buffers in use -- cannot alloc */
-	atomic_t buf_alloc;		/**< Buffer allocation in progress */
-	/*@} */
+	/** @buf_alloc: Buffer allocation in progress */
+	atomic_t buf_alloc;
 
 	struct mutex filelist_mutex;
 	struct list_head filelist;
@@ -87,51 +130,64 @@ struct drm_device {
 	/**
 	 * @filelist_internal:
 	 *
-	 * List of open DRM files for in-kernel clients. Protected by @filelist_mutex.
+	 * List of open DRM files for in-kernel clients.
+	 * Protected by &filelist_mutex.
 	 */
 	struct list_head filelist_internal;
 
 	/**
 	 * @clientlist_mutex:
 	 *
-	 * Protects @clientlist access.
+	 * Protects &clientlist access.
 	 */
 	struct mutex clientlist_mutex;
 
 	/**
 	 * @clientlist:
 	 *
-	 * List of in-kernel clients. Protected by @clientlist_mutex.
+	 * List of in-kernel clients. Protected by &clientlist_mutex.
 	 */
 	struct list_head clientlist;
 
-	/** \name Memory management */
-	/*@{ */
-	struct list_head maplist;	/**< Linked list of regions */
-	struct drm_open_hash map_hash;	/**< User token hash table for maps */
+	/** @maplist: Memory management - linked list of regions */
+	struct list_head maplist;
 
-	/** \name Context handle management */
-	/*@{ */
-	struct list_head ctxlist;	/**< Linked list of context handles */
-	struct mutex ctxlist_mutex;	/**< For ctxlist */
+	/** @map_hash: Memory management - user token hash table for maps */
+	struct drm_open_hash map_hash;
 
-	struct idr ctx_idr;
+	/**
+	 * @ctxlist:
+	 * Context handle management - linked list of context handles
+	 */
+	struct list_head ctxlist;
 
-	struct list_head vmalist;	/**< List of vmas (for debugging) */
+	/**
+	 * @ctxlist_mutex:
+	 *
+	 * Context handle management - mutex for &ctxlist
+	 */
+	struct mutex ctxlist_mutex;
 
-	/*@} */
+	/**
+	 * @ctx_idr:
+	 * Context handle management
+	 */
+	struct idr ctx_idr;
 
-	/** \name DMA support */
-	/*@{ */
-	struct drm_device_dma *dma;		/**< Optional pointer for DMA support */
-	/*@} */
+	/**
+	 * @vmalist:
+	 * Context handle management - list of vmas (for debugging)
+	 */
+	struct list_head vmalist;
+
+	/** @dma: Optional pointer for DMA support */
+	struct drm_device_dma *dma;
 
-	/** \name Context support */
-	/*@{ */
+	/** @context_flag: Context swapping flag */
+	__volatile__ long context_flag;
 
-	__volatile__ long context_flag;	/**< Context swapping flag */
-	int last_context;		/**< Last current context */
-	/*@} */
+	/** @last_context: Last current context */
+	int last_context;
 
 	/**
 	 * @irq_enabled:
@@ -168,7 +224,12 @@ struct drm_device {
 	 */
 	struct drm_vblank_crtc *vblank;
 
-	spinlock_t vblank_time_lock;    /**< Protects vblank count and time updates during vblank enable/disable */
+	/**
+	 * @vblank_time_lock:
+	 *
+	 *  Protects vblank count and time updates during vblank enable/disable
+	 */
+	spinlock_t vblank_time_lock;
 	spinlock_t vbl_lock;
 
 	/**
@@ -186,25 +247,29 @@ struct drm_device {
 	 *
 	 * If non-zeor, &drm_crtc_funcs.get_vblank_counter must be set.
 	 */
-	u32 max_vblank_count;           /**< size of vblank counter register */
 
-	/**
-	 * List of events
-	 */
+	/** @max_vblank_count: Size of vblank counter register */
+	u32 max_vblank_count;
+
+	/** @vblank_event_list: List of vblank events */
 	struct list_head vblank_event_list;
 	spinlock_t event_lock;
 
-	/*@} */
+	/** @agp: AGP data */
+	struct drm_agp_head *agp;
 
-	struct drm_agp_head *agp;	/**< AGP data */
+	/** @pdev: PCI device structure */
+	struct pci_dev *pdev;
 
-	struct pci_dev *pdev;		/**< PCI device structure */
 #ifdef __alpha__
 	struct pci_controller *hose;
 #endif
 
-	struct drm_sg_mem *sg;	/**< Scatter gather memory */
-	unsigned int num_crtcs;                  /**< Number of CRTCs on this device */
+	/** @sg: Scatter gather memory */
+	struct drm_sg_mem *sg;
+
+	/** @num_crtcs: Number of CRTCs on this device */
+	unsigned int num_crtcs;
 
 	struct {
 		int context;
@@ -214,14 +279,18 @@ struct drm_device {
 	struct drm_local_map *agp_buffer_map;
 	unsigned int agp_buffer_token;
 
-	struct drm_mode_config mode_config;	/**< Current mode config */
+	/** @mode_config: Current mode config */
+	struct drm_mode_config mode_config;
 
-	/** \name GEM information */
-	/*@{ */
+	/** @object_name_lock: GEM information */
 	struct mutex object_name_lock;
+
+	/** @object_name_idr: GEM information */
 	struct idr object_name_idr;
+
+	/** @vma_offset_manager: GEM information */
 	struct drm_vma_offset_manager *vma_offset_manager;
-	/*@} */
+
 	int switch_power_state;
 
 	/**
-- 
2.12.0

